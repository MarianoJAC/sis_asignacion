<?php
header('Content-Type: application/json');
include '../config/conexion.php';

// 🧩 Función para registrar auditoría
function registrarAuditoria($tipo, $objetoId, $usuarioId, $accion, $campo = null, $valorAnterior = null, $valorNuevo = null) {
  global $conexion;
  $stmt = $conexion->prepare("INSERT INTO auditoria_acciones 
    (tipo_objeto, objeto_id, usuario_id, accion, campo_modificado, valor_anterior, valor_nuevo) 
    VALUES (?, ?, ?, ?, ?, ?, ?)");
  $stmt->bind_param("sisssss", $tipo, $objetoId, $usuarioId, $accion, $campo, $valorAnterior, $valorNuevo);
  $stmt->execute();
}

// 🧪 Trazabilidad de entrada
$dataRaw = file_get_contents("php://input");
error_log("🧪 JSON recibido: " . $dataRaw);

$data = json_decode($dataRaw, true);
$entidad_id = isset($data['entidad_id']) ? intval($data['entidad_id']) : 0;
error_log("🧪 entidad_id extraído: " . $entidad_id);

// 🧑 Obtener usuario actual (ajustar según tu sistema)
session_start();
$usuarioId = $_SESSION['usuario_id'] ?? null;

if (!$usuarioId) {
  echo json_encode(['ok' => false, 'error' => 'Usuario no autenticado']);
  exit;
}

// 🔒 Validación básica
if (!is_int($entidad_id) || $entidad_id <= 0) {
  error_log("❌ entidad_id inválido recibido");
  echo json_encode(['ok' => false, 'error' => 'ID inválido']);
  exit;
}

// 🔍 Verificar existencia y obtener datos
$check = $conexion->prepare("SELECT nombre, color FROM entidades WHERE entidad_id = ?");
$check->bind_param("i", $entidad_id);
$check->execute();
$resultado = $check->get_result();

if ($resultado->num_rows === 0) {
  error_log("❌ Entidad con entidad_id $entidad_id no existe");
  echo json_encode(['ok' => false, 'error' => 'La entidad no existe']);
  exit;
}

$entidad = $resultado->fetch_assoc();
$valorAnterior = json_encode($entidad, JSON_UNESCAPED_UNICODE);

// 🧹 Eliminar
$delete = $conexion->prepare("DELETE FROM entidades WHERE entidad_id = ?");
$delete->bind_param("i", $entidad_id);
$delete->execute();

if ($delete->affected_rows > 0) {
  error_log("✅ Entidad con entidad_id $entidad_id eliminada");

  // 🧾 Registrar auditoría
  registrarAuditoria('entidad', $entidad_id, $usuarioId, 'baja', null, $valorAnterior, null);

  echo json_encode(['ok' => true]);
} else {
  error_log("❌ Falló la eliminación de entidad_id $entidad_id");
  echo json_encode(['ok' => false, 'error' => 'No se pudo eliminar la entidad']);
}