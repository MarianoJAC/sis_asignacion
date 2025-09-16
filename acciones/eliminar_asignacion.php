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

// 🧑 Obtener usuario actual (ajustar según tu sistema)
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

// 🔍 Obtener estado anterior
$prevQuery = $conexion->prepare("SELECT aula_id, fecha, turno, carrera, anio, profesor, materia, entidad_id, hora_inicio, hora_fin, comentarios FROM asignaciones WHERE Id = ?");
$prevQuery->bind_param("i", $id);
$prevQuery->execute();
$prevResult = $prevQuery->get_result();

if ($prevResult->num_rows === 0) {
  echo json_encode(['ok' => false, 'error' => 'Asignación no encontrada']);
  exit;
}

$prev = $prevResult->fetch_assoc();
$valorAnterior = json_encode($prev, JSON_UNESCAPED_UNICODE);

// 🧨 Eliminación segura
$delete = $conexion->prepare("DELETE FROM asignaciones WHERE Id = ?");
$delete->bind_param("i", $id);
$delete->execute();

if ($delete->affected_rows > 0) {
  // 🧾 Registrar auditoría
  registrarAuditoria('asignacion', $id, $usuarioId, 'baja', null, $valorAnterior, null);

  echo json_encode(['ok' => true, 'mensaje' => '✅ Asignación eliminada']);
} else {
  echo json_encode(['ok' => false, 'error' => 'No se pudo eliminar la asignación']);
}