<?php
include '../config/conexion.php';
header('Content-Type: application/json');

// 🧑 Validación de sesión (opcional, pero recomendado si es data sensible)
session_start();
if (!isset($_SESSION['usuario_id'])) {
  echo json_encode(['ok' => false, 'error' => 'Acceso no autenticado']);
  exit;
}

$aulasQuery = mysqli_query($conexion, "SELECT aula_id, nombre FROM aulas ORDER BY nombre ASC");

if (!$aulasQuery) {
  http_response_code(500);
  echo json_encode(['ok' => false, 'error' => 'Error en la consulta de aulas']);
  exit;
}

$aulas = mysqli_fetch_all($aulasQuery, MYSQLI_ASSOC);

echo json_encode(['ok' => true, 'aulas' => $aulas]);
