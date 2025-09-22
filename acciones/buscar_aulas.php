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

// Si el texto es numérico, busca por capacidad
if (is_numeric($texto)) {
    $capacidad = intval($texto);
    $stmt = $conexion->prepare("
      SELECT 
        a.aula_id AS id,
        a.nombre,
        a.capacidad,
        GROUP_CONCAT(DISTINCT r.recurso) AS recursos
      FROM aulas a
      LEFT JOIN recursos_por_aula r ON a.aula_id = r.aula_id
      WHERE a.capacidad >= ?
      GROUP BY a.aula_id
    ");

    if (!$stmt) {
      echo json_encode(['ok' => false, 'error' => 'Error en la preparación SQL para capacidad']);
      exit;
    }
    $stmt->bind_param("i", $capacidad);

} else { // Si no, busca por texto en nombre y recursos
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
      GROUP BY a.aula_id
    ");
    
    if (!$stmt) {
      echo json_encode(['ok' => false, 'error' => 'Error en la preparación SQL para texto']);
      exit;
    }
    $stmt->bind_param("ss", $texto, $texto);
}

$stmt->execute();
$resultado = $stmt->get_result();

$aulas = [];
while ($fila = $resultado->fetch_assoc()) {
  $fila['recursos'] = isset($fila['recursos']) ? explode(',', $fila['recursos']) : [];
  $aulas[] = $fila;
}

// file_put_contents('log_aulas.txt', json_encode($aulas, JSON_PRETTY_PRINT));
echo json_encode(['ok' => true, 'aulas' => $aulas]);
exit;
