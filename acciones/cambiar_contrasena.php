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

$id = $input['id'] ?? null;
$new_password = $input['new_password'] ?? '';

if (empty($id) || empty($new_password)) {
    echo json_encode(['ok' => false, 'error' => 'ID de usuario y nueva contraseña son obligatorios.']);
    exit;
}

try {
    $hashed_password = password_hash($new_password, PASSWORD_DEFAULT);

    $stmt = $conexion->prepare("UPDATE usuarios SET password = ? WHERE id = ?");
    $stmt->bind_param("si", $hashed_password, $id);

    if ($stmt->execute()) {
        if ($stmt->affected_rows > 0) {
            echo json_encode(['ok' => true, 'mensaje' => 'Contraseña actualizada correctamente.']);
        } else {
            echo json_encode(['ok' => false, 'error' => 'No se encontró el usuario para actualizar.']);
        }
    } else {
        throw new Exception('Error al actualizar la contraseña: ' . $stmt->error);
    }
    $stmt->close();

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['ok' => false, 'error' => $e->getMessage()]);
}

$conexion->close();
exit;
?>