<?php
session_start();
include '../config/conexion.php';

// 1. Verificación de seguridad: solo los administradores pueden ejecutar este script.
if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'admin') {
    $_SESSION['flash_message'] = 'Error: Acceso denegado.';
    header('Location: ../views/form_crear_usuario.php');
    exit;
}

$message = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = trim($_POST['username'] ?? '');
    $password = $_POST['password'] ?? '';
    $role = $_POST['role'] ?? '';

    // 2. Validación de entradas
    if (empty($username) || empty($password) || empty($role)) {
        $message = 'Error: Todos los campos son obligatorios.';
    } elseif (!in_array($role, ['admin', 'viewer', 'invitado'])) {
        $message = 'Error: El rol seleccionado no es válido.';
    } else {
        // Verificar si el usuario ya existe
        $stmt_check = $conexion->prepare("SELECT id FROM usuarios WHERE username = ?");
        $stmt_check->bind_param("s", $username);
        $stmt_check->execute();
        $stmt_check->store_result();

        if ($stmt_check->num_rows > 0) {
            $message = 'Error: El nombre de usuario ya está en uso. Por favor, elija otro.';
        } else {
            // 3. Hashear la contraseña
            $hashed_password = password_hash($password, PASSWORD_DEFAULT);

            // 4. Preparar y ejecutar la inserción en la base de datos
            $stmt_insert = $conexion->prepare("INSERT INTO usuarios (username, password, role) VALUES (?, ?, ?)");
            $stmt_insert->bind_param("sss", $username, $hashed_password, $role);

            if ($stmt_insert->execute()) {
                $message = '¡Usuario ' . htmlspecialchars($username) . ' creado con éxito!';
            } else {
                $message = 'Error al crear el usuario: ' . $stmt_insert->error;
            }
            $stmt_insert->close();
        }
        $stmt_check->close();
    }
} else {
    $message = 'Error: Método de solicitud no válido.';
}

$conexion->close();

// Redirigir de vuelta al formulario con un mensaje
$_SESSION['flash_message'] = $message;
header('Location: ../views/form_crear_usuario.php');
exit;
?>
