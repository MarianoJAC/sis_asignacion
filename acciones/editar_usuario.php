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
$username = trim($input['username'] ?? '');
$role = $input['role'] ?? '';

if (empty($id) || empty($username) || empty($role)) {
    echo json_encode(['ok' => false, 'error' => 'Todos los campos son obligatorios.']);
    exit;
}
if (!in_array($role, ['admin', 'viewer', 'invitado'])) {
    echo json_encode(['ok' => false, 'error' => 'El rol seleccionado no es válido.']);
    exit;
}

try {
    // Check if the new username is already taken by another user
    $stmt_check = $conexion->prepare("SELECT id FROM usuarios WHERE username = ? AND id != ?");
    $stmt_check->bind_param("si", $username, $id);
    $stmt_check->execute();
    $stmt_check->store_result();

    if ($stmt_check->num_rows > 0) {
        echo json_encode(['ok' => false, 'error' => 'El nombre de usuario ya está en uso.']);
        exit;
    }
    $stmt_check->close();

    // Update user
    $stmt_update = $conexion->prepare("UPDATE usuarios SET username = ?, role = ? WHERE id = ?");
    $stmt_update->bind_param("ssi", $username, $role, $id);

    if ($stmt_update->execute()) {
        if ($stmt_update->affected_rows > 0) {
            echo json_encode(['ok' => true, 'mensaje' => '¡Usuario actualizado con éxito!']);
        } else {
            echo json_encode(['ok' => false, 'error' => 'No se realizó ningún cambio o no se encontró el usuario.']);
        }
    } else {
        throw new Exception('Error al actualizar el usuario: ' . $stmt_update->error);
    }
    $stmt_update->close();

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['ok' => false, 'error' => $e->getMessage()]);
}

$conexion->close();
exit;
?>