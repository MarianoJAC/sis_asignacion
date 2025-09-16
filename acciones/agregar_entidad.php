<?php
header('Content-Type: application/json; charset=utf-8');
include '../config/conexion.php';

$data = json_decode(file_get_contents("php://input"), true);

// Sanitización
$nombre = trim(preg_replace('/\s+/', ' ', $data['nombre'] ?? ''));
$color = trim($data['color'] ?? '');

if (!$nombre || !$color) {
  echo json_encode(['ok' => false, 'error' => 'Datos incompletos']);
  exit;
}

if (!preg_match('/^#[0-9A-F]{6}$/i', $color)) {
  echo json_encode(['ok' => false, 'error' => 'Color inválido']);
  exit;
}

// Chequeo de duplicado (opcional si tenés UNIQUE en la DB)
$check = $conexion->prepare("SELECT 1 FROM entidades WHERE UPPER(nombre) = ?");
$check->bind_param("s", $nombre);
$check->execute();
$check->store_result();

if ($check->num_rows > 0) {
  echo json_encode(['ok' => false, 'error' => 'La entidad ya existe']);
  exit;
}

try {
  $stmt = $conexion->prepare("INSERT INTO entidades (nombre, color) VALUES (?, ?)");
  $stmt->bind_param("ss", $nombre, $color);
  $stmt->execute();

  echo json_encode(['ok' => true]);
} catch (mysqli_sql_exception $e) {
  echo json_encode(['ok' => false, 'error' => 'La entidad ya existe']);
}
exit;