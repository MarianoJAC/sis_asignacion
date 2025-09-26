<?php
include '../config/conexion.php';
header('Content-Type: application/json');

// 🧩 Función para registrar auditoría
function registrarAuditoria($tipo, $objetoId, $usuarioId, $accion, $campo = null, $valorAnterior = null, $valorNuevo = null) {
  global $conexion;
  $stmt = $conexion->prepare("INSERT INTO auditoria_acciones 
    (tipo_objeto, objeto_id, usuario_id, accion, campo_modificado, valor_anterior, valor_nuevo) 
    VALUES (?, ?, ?, ?, ?, ?, ?)");
  $stmt->bind_param("sisssss", $tipo, $objetoId, $usuarioId, $accion, $campo, $valorAnterior, $valorNuevo);
  $stmt->execute();
}

// 🧠 Leer JSON desde el body
$input = json_decode(file_get_contents('php://input'), true);
$id = $input['id'] ?? null;
$repeticion = $input['repeticion'] ?? 'dia';

// 🧑 Obtener usuario actual
session_start();
$usuarioId = $_SESSION['usuario_id'] ?? null;

if (!$usuarioId) {
  echo json_encode(['ok' => false, 'error' => 'Usuario no autenticado']);
  exit;
}

if (!$id || !is_numeric($id)) {
  echo json_encode(['ok' => false, 'error' => 'ID no recibido o inválido']);
  exit;
}

// Iniciar transacción
$conexion->begin_transaction();

try {
    // 🔍 Obtener la asignación original para usarla como plantilla
    $queryOriginal = $conexion->prepare("SELECT * FROM asignaciones WHERE Id = ?");
    $queryOriginal->bind_param("i", $id);
    $queryOriginal->execute();
    $resultOriginal = $queryOriginal->get_result();

    if ($resultOriginal->num_rows === 0) {
        throw new Exception('Asignación no encontrada');
    }
    $original = $resultOriginal->fetch_assoc();
    $queryOriginal->close();

    $deleteCount = 0;

    if ($repeticion === 'dia') {
        // --- Eliminación simple ---
        $valorAnterior = json_encode($original, JSON_UNESCAPED_UNICODE);
        
        $delete = $conexion->prepare("DELETE FROM asignaciones WHERE Id = ?");
        $delete->bind_param("i", $id);
        $delete->execute();
        $deleteCount = $delete->affected_rows;
        $delete->close();

        if ($deleteCount > 0) {
            registrarAuditoria('asignacion', $id, $usuarioId, 'baja', null, $valorAnterior, null);
        }

    } else {
        // --- Eliminación masiva (mensual, cuatrimestral o anual) ---
        $fecha_dt = new DateTime($original['fecha']);
        $dia_semana_original = $fecha_dt->format('N'); // 1 (Lunes) a 7 (Domingo)

        $fecha_inicio_loop = clone $fecha_dt;
        $fecha_fin_loop = clone $fecha_dt;

        if ($repeticion === 'mensual') {
            $fecha_inicio_loop->modify('first day of this month');
            $fecha_fin_loop->modify('last day of this month');
        } elseif ($repeticion === 'cuatrimestral') {
            // To delete the entire block, find the start date by searching backwards week by week
            $findStmt = $conexion->prepare("SELECT 1 FROM asignaciones WHERE
                aula_id = ? AND turno = ? AND materia = ? AND profesor = ? AND
                hora_inicio = ? AND hora_fin = ? AND entidad_id = ? AND fecha = ?");

            $start_date_loop = new DateTime($original['fecha']);

            while (true) {
                $previous_week_date = clone $start_date_loop;
                $previous_week_date->modify('-7 days');
                $previous_week_date_str = $previous_week_date->format('Y-m-d');

                $findStmt->bind_param('isssssis',
                    $original['aula_id'], $original['turno'], $original['materia'],
                    $original['profesor'], $original['hora_inicio'], $original['hora_fin'],
                    $original['entidad_id'], $previous_week_date_str);
                $findStmt->execute();
                $findStmt->store_result();

                if ($findStmt->num_rows > 0) {
                    // Found a preceding assignment, continue searching backwards
                    $start_date_loop = $previous_week_date;
                } else {
                    // No more preceding assignments, we found the start of the block
                    break;
                }
            }
            $findStmt->close();

            // Now define the full 4-month period from the actual start date
            $fecha_inicio_loop = $start_date_loop;
            $fecha_fin_loop = clone $fecha_inicio_loop;
            $fecha_fin_loop->modify('+4 months');
        } elseif ($repeticion === 'anual') {
            $fecha_inicio_loop->modify('first day of january this year');
            $fecha_fin_loop->modify('last day of december this year');
        }

        $fecha_inicio_str = $fecha_inicio_loop->format('Y-m-d');
        $fecha_fin_str = $fecha_fin_loop->format('Y-m-d');

        // Construir la consulta de eliminación masiva
        $deleteQuery = "DELETE FROM asignaciones WHERE 
            aula_id = ? AND 
            turno = ? AND 
            materia = ? AND 
            profesor = ? AND 
            hora_inicio = ? AND 
            hora_fin = ? AND 
            DAYOFWEEK(fecha) = ? AND 
            fecha BETWEEN ? AND ?";
        
        // DAYOFWEEK en MySQL: 1=Domingo, 2=Lunes... 7=Sábado
        // PHP 'N': 1=Lunes... 7=Domingo
        $dia_semana_mysql = ($dia_semana_original % 7) + 1;

        $stmt = $conexion->prepare($deleteQuery);
        $stmt->bind_param('isssssiss', 
            $original['aula_id'], 
            $original['turno'], 
            $original['materia'], 
            $original['profesor'], 
            $original['hora_inicio'], 
            $original['hora_fin'], 
            $dia_semana_mysql, 
            $fecha_inicio_str, 
            $fecha_fin_str
        );

        $stmt->execute();
        $deleteCount = $stmt->affected_rows;
        $stmt->close();

        if ($deleteCount > 0) {
            $detalleAuditoria = json_encode([
                'repeticion' => $repeticion,
                'plantilla' => $original,
                'eliminadas' => $deleteCount
            ], JSON_UNESCAPED_UNICODE);
            registrarAuditoria('asignacion', $id, $usuarioId, 'baja_masiva', null, $detalleAuditoria, null);
        }
    }

    if ($deleteCount > 0) {
        $conexion->commit();
        echo json_encode(['ok' => true, 'mensaje' => "✅ $deleteCount asignacion(es) eliminada(s)."]);
    } else {
        throw new Exception('No se encontró ninguna asignación para eliminar con los criterios seleccionados.');
    }

} catch (Exception $e) {
    $conexion->rollback();
    echo json_encode(['ok' => false, 'error' => $e->getMessage()]);
}

exit;
