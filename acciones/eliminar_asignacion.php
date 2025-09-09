<?php
include '../config/conexion.php';

error_reporting(E_ERROR | E_PARSE);
ini_set('display_errors', 0);

header('Content-Type: application/json');

// 🧠 Leer JSON desde el body
$input = json_decode(file_get_contents('php://input'), true);
$id = $input['id'] ?? null;

if (!$id) {
  echo json_encode(['ok' => false, 'error' => 'ID no recibido']);
  exit;
}

// 🧨 Eliminación segura
$query = "DELETE FROM asignaciones WHERE Id = '$id'";
if (mysqli_query($conexion, $query)) {
  echo json_encode(['ok' => true, 'mensaje' => '✅ Asignación eliminada']);
  exit;
} else {
  echo json_encode(['ok' => false, 'error' => mysqli_error($conexion)]);
  exit;
}