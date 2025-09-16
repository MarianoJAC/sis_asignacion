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
  SELECT 
    a.aula_id AS id,
    a.nombre,
    a.capacidad,
    GROUP_CONCAT(DISTINCT r.recurso) AS recursos
  FROM aulas a
  LEFT JOIN recursos_por_aula r ON a.aula_id = r.aula_id
  WHERE LOWER(r.recurso) LIKE CONCAT('%', ?, '%')
     OR LOWER(a.nombre) LIKE CONCAT('%', ?, '%')
     OR LOWER(CAST(a.capacidad AS CHAR)) LIKE CONCAT('%', ?, '%')
  GROUP BY a.aula_id
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
  $fila['recursos'] = isset($fila['recursos']) ? explode(',', $fila['recursos']) : [];
  $aulas[] = $fila;
}

file_put_contents('log_aulas.txt', json_encode($aulas, JSON_PRETTY_PRINT));
echo json_encode(['ok' => true, 'aulas' => $aulas]);
exit;