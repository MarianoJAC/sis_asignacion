<?php
require_once __DIR__ . '/api_utils.php';

// Asumimos que cualquier usuario autenticado puede ver la lista de entidades
validar_autenticado();

$stmt = $conexion->prepare("SELECT entidad_id as id, nombre, color FROM entidades ORDER BY nombre ASC");
if (!$stmt) {
    responder_error("Error al preparar la consulta de entidades.", 500);
}

if (!$stmt->execute()) {
    responder_error("Error al ejecutar la consulta de entidades.", 500);
}

$resultado = $stmt->get_result();
$entidades = $resultado->fetch_all(MYSQLI_ASSOC);

$stmt->close();
$conexion->close();

echo json_encode(['ok' => true, 'entidades' => $entidades]);
?>