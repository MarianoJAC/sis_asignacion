<?php
include '../config/conexion.php';
header('Content-Type: application/json');
session_start();

if (!isset($_SESSION['usuario_id']) || $_SESSION['role'] !== 'admin') {
  http_response_code(403);
  echo json_encode(['ok' => false, 'error' => 'Acceso denegado']);
  exit;
}

try {
  $result = mysqli_query($conexion, "SELECT id, username, role FROM usuarios ORDER BY username ASC");
  
  if (!$result) {
    throw new Exception('Error en la consulta a la base de datos.');
  }

  $usuarios = mysqli_fetch_all($result, MYSQLI_ASSOC);
  
  echo json_encode(['ok' => true, 'data' => $usuarios]);

} catch (Exception $e) {
  http_response_code(500);
  echo json_encode(['ok' => false, 'error' => $e->getMessage()]);
}

exit;