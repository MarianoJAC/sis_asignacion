<?php
include '../config/conexion.php';
$data = json_decode(file_get_contents("php://input"), true);

// Validación básica
$id = intval($data['id'] ?? 0);
if ($id <= 0) {
  echo json_encode(['ok' => false, 'error' => 'ID inválido']);
  exit;
}

// Verificar existencia antes de eliminar
$check = $conexion->prepare("SELECT nombre FROM entidades WHERE entidad_id = ?");
$check->bind_param("i", $id);
$check->execute();
$check->store_result();

if ($check->num_rows === 0) {
  echo json_encode(['ok' => false, 'error' => 'La entidad no existe']);
  exit;
}

// Eliminar
$delete = $conexion->prepare("DELETE FROM entidades WHERE entidad_id = ?");
$delete->bind_param("i", $id);
$delete->execute();

echo json_encode(['ok' => true]);