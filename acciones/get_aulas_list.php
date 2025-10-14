<?php
session_start();
header('Content-Type: application/json; charset=utf-8');
require_once '../config/conexion.php';

function responder_error_local($mensaje, $codigo = 400) {
    http_response_code($codigo);
    echo json_encode(['ok' => false, 'error' => $mensaje]);
    exit;
}

if (!isset($_SESSION['usuario_id'])) {
    responder_error_local('Acceso no autenticado.', 401);
}

if (!$conexion) {
    responder_error_local("Error de conexión a la base de datos.", 500);
}

// NOTA: Se omite "WHERE activa = 1" porque causa un error irrecuperable en el servidor de BD.
// Esto mostrará todas las aulas, incluyendo las inactivas.
$stmt = $conexion->prepare("SELECT aula_id as id, nombre FROM aulas ORDER BY nombre ASC");

if (!$stmt) {
    responder_error_local("Error al preparar la consulta de aulas: " . $conexion->error, 500);
}

if (!$stmt->execute()) {
    responder_error_local("Error al ejecutar la consulta de aulas: " . $stmt->error, 500);
}

$resultado = $stmt->get_result();
$aulas = $resultado->fetch_all(MYSQLI_ASSOC);

$stmt->close();
$conexion->close();

echo json_encode(['ok' => true, 'aulas' => $aulas]);
?>