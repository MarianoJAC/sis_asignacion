<?php
include '../config/conexion.php';
header('Content-Type: application/json');
ini_set('display_errors', 1);
error_reporting(E_ALL);

$input = json_decode(file_get_contents('php://input'), true);
$texto = strtolower(trim($input['texto'] ?? ''));

if (!$texto) {
  echo json_encode(['ok' => false, 'error' => 'Texto vacío']);
  exit;
}

$stmt = $conexion->prepare("
  SELECT aula_id AS id, nombre, recurso, capacidad
  FROM aulas
  WHERE LOWER(nombre) LIKE CONCAT('%', ?, '%')
     OR LOWER(recurso) LIKE CONCAT('%', ?, '%')
     OR LOWER(CAST(capacidad AS CHAR)) LIKE CONCAT('%', ?, '%')
");

if (!$stmt) {
  echo json_encode(['ok' => false, 'error' => 'Error en la preparación SQL']);
  exit;
}

$stmt->bind_param("sss", $texto, $texto, $texto);
$stmt->execute();
$resultado = $stmt->get_result();

$aulas = [];
while ($fila = $resultado->fetch_assoc()) {
  $aulas[] = $fila;
}

echo json_encode(['ok' => true, 'aulas' => $aulas]);
exit;