<?php
include '../config/conexion.php';
header('Content-Type: application/json');

// Función de log
function debug_log($message) {
    $log_file = __DIR__ . '/log_aulas.txt';
    $timestamp = date('Y-m-d H:i:s');
    file_put_contents($log_file, "[$timestamp] DEBUG: " . print_r($message, true) . "\n", FILE_APPEND);
}

debug_log("---" . "INICIO DE GUARDAR ASIGNACION" . "---");

// 🧩 Función para registrar auditoría
function registrarAuditoria($tipo, $objetoId, $usuarioId, $accion, $campo = null, $valorAnterior = null, $valorNuevo = null) {
  global $conexion;
  $stmt = $conexion->prepare("INSERT INTO auditoria_acciones 
    (tipo_objeto, objeto_id, usuario_id, accion, campo_modificado, valor_anterior, valor_nuevo) 
    VALUES (?, ?, ?, ?, ?, ?, ?)");
  $stmt->bind_param("sisssss", $tipo, $objetoId, $usuarioId, $accion, $campo, $valorAnterior, $valorNuevo);
  $stmt->execute();
}

// 🧠 Capitalización con soporte de acentos
function capitalizar($texto) {
  $texto = mb_strtolower(trim($texto), 'UTF-8');
  $palabras = explode(' ', $texto);
  $excepciones = ['de', 'del', 'la', 'las', 'los', 'y', 'a', 'en', 'el', 'al', 'con', 'por'];

  foreach ($palabras as &$palabra) {
    if (!in_array($palabra, $excepciones)) {
      $palabra = mb_strtoupper(mb_substr($palabra, 0, 1), 'UTF-8') . mb_substr($palabra, 1);
    }
  }

  return implode(' ', $palabras);
}

// 🧼 Lectura segura del JSON
$input = json_decode(file_get_contents('php://input'), true);
debug_log(['input' => $input]);

// 🧑 Obtener usuario actual
session_start();
$usuarioId = $_SESSION['usuario_id'] ?? null;

if (!$usuarioId) {
  debug_log("Error: Usuario no autenticado.");
  echo json_encode(['ok' => false, 'error' => 'Usuario no autenticado']);
  exit;
}

// 🧠 Extracción defensiva de datos
$aula_id     = isset($input['aula_id']) ? (int)$input['aula_id'] : 0;
$fecha_inicial = $input['fecha']       ?? '';
$turno       = $input['turno']       ?? '';
$carrera     = capitalizar($input['carrera'] ?? '');
$anio        = $input['anio']        ?? '';
$materia     = capitalizar($input['materia'] ?? '');
$profesor    = capitalizar($input['profesor'] ?? '');
$entidad     = isset($input['entidad_id']) ? (int)$input['entidad_id'] : 0;
$inicio      = $input['hora_inicio'] ?? '';
$fin         = $input['hora_fin']    ?? '';
$comentarios = isset($input['comentarios']) ? trim($input['comentarios']) : '';
$repeticion  = trim($input['repeticion']  ?? 'dia'); // dia, mensual, cuatrimestral, anual

// 🛡️ Validación básica
if (!$aula_id || !$fecha_inicial || !$turno || !$carrera || !$anio || !$materia || !$profesor || !$entidad || !$inicio || !$fin) {
  debug_log("Error: Faltan campos obligatorios.");
  echo json_encode(['ok' => false, 'error' => 'Faltan campos obligatorios']);
  exit;
}

// 📅 Lógica de Repetición
$fechas_a_insertar = [];
$fecha_dt = new DateTime($fecha_inicial);

if ($repeticion !== 'dia') {
    $dia_semana_original = $fecha_dt->format('N'); // 1 (lunes) a 7 (domingo)
    $fecha_fin_loop = clone $fecha_dt;
    $period_defined = false;

    if ($repeticion === 'mensual') {
        $fecha_fin_loop->modify('last day of this month');
        $period_defined = true;
    } elseif ($repeticion === 'cuatrimestral') {
        $fecha_fin_loop->modify('+4 months');
        $period_defined = true;
    } elseif ($repeticion === 'anual') {
        $fecha_fin_loop->modify('last day of december this year');
        $period_defined = true;
    }

    if ($period_defined) {
        $intervalo = new DateInterval('P1D');
        // The end date for DatePeriod is exclusive, so add one day to include it.
        $fecha_fin_loop->modify('+1 day');
        $periodo = new DatePeriod($fecha_dt, $intervalo, $fecha_fin_loop);

        foreach ($periodo as $dia) {
            if ($dia->format('N') === $dia_semana_original) {
                $fechas_a_insertar[] = $dia->format('Y-m-d');
            }
        }
    }
}

// If no dates were generated for repetition, or if it's a single day, add the base date.
if (empty($fechas_a_insertar)) {
    $fechas_a_insertar[] = $fecha_dt->format('Y-m-d');
}
debug_log(['Fechas calculadas' => $fechas_a_insertar]);

// Iniciar transacción
$conexion->begin_transaction();
debug_log("Transacción iniciada.");

try {
    $stmt = $conexion->prepare("INSERT INTO asignaciones (
      aula_id, fecha, turno, carrera, anio, profesor, materia, entidad_id, hora_inicio, hora_fin, comentarios
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
    
    $stmt->bind_param("issssssisss", $aula_id, $fecha, $turno, $carrera, $anio, $profesor, $materia, $entidad, $inicio, $fin, $comentarios);

    $asignaciones_creadas = 0;

    foreach ($fechas_a_insertar as $fecha_actual) {
        $fecha = $fecha_actual; // Actualizar la variable vinculada
        debug_log("Procesando fecha: " . $fecha);

        $verificar = $conexion->prepare("SELECT COUNT(*) FROM asignaciones WHERE 
          aula_id = ? AND fecha = ? AND turno = ? AND materia = ? AND profesor = ? AND hora_inicio = ? AND hora_fin = ?");
        $verificar->bind_param("issssss", $aula_id, $fecha, $turno, $materia, $profesor, $inicio, $fin);
        $verificar->execute();
        $verificar->bind_result($total);
        $verificar->fetch();
        $verificar->close();
        debug_log("Verificación de duplicados para " . $fecha . ": " . $total . " encontrados.");

        if ($total > 0) {
            debug_log("Asignación duplicada para " . $fecha . ". Saltando.");
            continue; 
        }
        
        debug_log("Ejecutando inserción para " . $fecha . "...");
        if (!$stmt->execute()) {
            throw new Exception("Error al ejecutar inserción para $fecha: " . $stmt->error);
        }
        
        $asignacionId = $stmt->insert_id;
        $asignaciones_creadas++;
        debug_log("Inserción exitosa para $fecha. ID: " . $asignacionId . ". Total creadas: " . $asignaciones_creadas);

        $valorNuevo = json_encode(['aula_id' => $aula_id, 'fecha' => $fecha, 'turno' => $turno, 'carrera' => $carrera, 'anio' => $anio, 'profesor' => $profesor, 'materia' => $materia, 'entidad_id' => $entidad, 'hora_inicio' => $inicio, 'hora_fin' => $fin, 'comentarios' => $comentarios], JSON_UNESCAPED_UNICODE);
        registrarAuditoria('asignacion', $asignacionId, $usuarioId, 'alta', null, null, $valorNuevo);
    }

    $stmt->close();
    $conexion->commit();
    debug_log("Transacción completada (commit). Total final: " . $asignaciones_creadas);

    if ($asignaciones_creadas > 0) {
        echo json_encode(['ok' => true, 'mensaje' => "Se guardaron $asignaciones_creadas asignacion(es) correctamente."]);
    } else {
        echo json_encode(['ok' => false, 'error' => 'Las asignaciones ya existían para las fechas seleccionadas.']);
    }

} catch (Exception $e) {
    $conexion->rollback();
    debug_log("Error en transacción: " . $e->getMessage());
    debug_log("Transacción revertida (rollback).");
    echo json_encode(['ok' => false, 'error' => 'Ocurrió un error al guardar las asignaciones. Se revirtieron los cambios.']);
}

debug_log("---" . "FIN DE GUARDAR ASIGNACION" . "---");
exit;
