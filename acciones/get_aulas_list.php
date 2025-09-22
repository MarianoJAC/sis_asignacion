<?php
require_once __DIR__ . '/api_utils.php';

// Asumimos que cualquier usuario autenticado puede ver la lista de aulas
validar_autenticado();

$stmt = $conexion->prepare("SELECT aula_id, nombre FROM aulas ORDER BY nombre ASC");
if (!$stmt) {
    responder_error("Error al preparar la consulta de aulas.", 500);
}

if (!$stmt->execute()) {
    responder_error("Error al ejecutar la consulta de aulas.", 500);
}

$resultado = $stmt->get_result();
$aulas = $resultado->fetch_all(MYSQLI_ASSOC);

$stmt->close();
$conexion->close();

echo json_encode(['ok' => true, 'aulas' => $aulas]);
?>