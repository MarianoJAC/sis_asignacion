<?php
session_start();
include '../config/conexion.php';

// 1. Verificación de seguridad: solo los administradores pueden ejecutar este script.
if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'admin') {
    die('Acceso denegado. Esta acción requiere privilegios de administrador.');
}

$response = ['success' => false, 'message' => ''];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = trim($_POST['username'] ?? '');
    $new_password = $_POST['new_password'] ?? '';

    // 2. Validación de entradas
    if (empty($username) || empty($new_password)) {
        $response['message'] = 'El nombre de usuario y la nueva contraseña no pueden estar vacíos.';
    } else {
        // 3. Hashear la nueva contraseña como en el login
        $nuevo_hash = password_hash($new_password, PASSWORD_DEFAULT);

        // 4. Preparar y ejecutar la actualización en la base de datos
        $stmt = $conexion->prepare("UPDATE usuarios SET password = ? WHERE username = ?");
        $stmt->bind_param("ss", $nuevo_hash, $username);

        if ($stmt->execute()) {
            if ($stmt->affected_rows > 0) {
                $response['success'] = true;
                $response['message'] = 'La contraseña para el usuario ' . htmlspecialchars($username) . ' ha sido actualizada correctamente.';
            } else {
                $response['message'] = 'No se encontró un usuario con el nombre ' . htmlspecialchars($username) . '. No se realizaron cambios.';
            }
        } else {
            $response['message'] = 'Error al ejecutar la actualización: ' . $stmt->error;
        }
        $stmt->close();
    }
} else {
    $response['message'] = 'Método de solicitud no válido.';
}

$conexion->close();

// Redirigir de vuelta al formulario con un mensaje
$_SESSION['flash_message'] = $response['message'];
header('Location: ../views/form_cambiar_pass.php');
exit;
