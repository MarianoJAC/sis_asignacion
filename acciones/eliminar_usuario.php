<?php
session_start();
include '../config/conexion.php';
header('Content-Type: application/json');

if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'admin') {
    http_response_code(403);
    echo json_encode(['ok' => false, 'error' => 'Acceso denegado']);
    exit;
}

$input = json_decode(file_get_contents('php://input'), true);
$id_to_delete = $input['id'] ?? null;
$current_user_id = $_SESSION['usuario_id'] ?? '';

if (empty($id_to_delete)) {
    echo json_encode(['ok' => false, 'error' => 'No se ha proporcionado un ID de usuario.']);
    exit;
}

if ($id_to_delete == $current_user_id) {
    echo json_encode(['ok' => false, 'error' => 'No puede eliminarse a sí mismo.']);
    exit;
}

try {
    $stmt = $conexion->prepare("DELETE FROM usuarios WHERE id = ?");
    $stmt->bind_param("i", $id_to_delete);

    if ($stmt->execute()) {
        if ($stmt->affected_rows > 0) {
            echo json_encode(['ok' => true, 'mensaje' => 'Usuario eliminado con éxito.']);
        } else {
            echo json_encode(['ok' => false, 'error' => 'No se encontró el usuario.']);
        }
    } else {
        throw new Exception('Error al eliminar el usuario.');
    }
    $stmt->close();

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['ok' => false, 'error' => $e->getMessage()]);
}

$conexion->close();
exit;
?>