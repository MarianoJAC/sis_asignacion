<?php
header('Content-Type: application/json');
include '../config/conexion.php';

// 🧪 Trazabilidad de entrada
$dataRaw = file_get_contents("php://input");
error_log("🧪 JSON recibido: " . $dataRaw);

$data = json_decode($dataRaw, true);
$entidad_id = isset($data['entidad_id']) ? intval($data['entidad_id']) : 0;
error_log("🧪 entidad_id extraído: " . $entidad_id);

// 🔒 Validación básica
if (!is_int($entidad_id) || $entidad_id <= 0) {
  error_log("❌ entidad_id inválido recibido");
  echo json_encode(['ok' => false, 'error' => 'ID inválido']);
  exit;
}

// 🔍 Verificar existencia
$check = $conexion->prepare("SELECT nombre FROM entidades WHERE entidad_id = ?");
$check->bind_param("i", $entidad_id);
$check->execute();
$check->store_result();

if ($check->num_rows === 0) {
  error_log("❌ Entidad con entidad_id $entidad_id no existe");
  echo json_encode(['ok' => false, 'error' => 'La entidad no existe']);
  exit;
}

// 🧹 Eliminar
$delete = $conexion->prepare("DELETE FROM entidades WHERE entidad_id = ?");
$delete->bind_param("i", $entidad_id);
$delete->execute();

if ($delete->affected_rows > 0) {
  error_log("✅ Entidad con entidad_id $entidad_id eliminada");
  echo json_encode(['ok' => true]);
} else {
  error_log("❌ Falló la eliminación de entidad_id $entidad_id");
  echo json_encode(['ok' => false, 'error' => 'No se pudo eliminar la entidad']);
}