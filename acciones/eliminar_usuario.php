<?php
session_start();
include '../config/conexion.php';

// 1. Verificación de seguridad: solo los administradores pueden ejecutar este script.
if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'admin') {
    $_SESSION['flash_message'] = 'Error: Acceso denegado.';
    header('Location: ../views/form_eliminar_usuario.php');
    exit;
}

$message = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $user_id_to_delete = $_POST['user_id'] ?? '';
    $current_user_id = $_SESSION['usuario_id'] ?? '';

    // 2. Validación de entradas
    if (empty($user_id_to_delete)) {
        $message = 'Error: No se ha seleccionado ningún usuario.';
    } elseif ($user_id_to_delete == $current_user_id) {
        // Doble chequeo de seguridad para no auto-eliminarse
        $message = 'Error: No puede eliminarse a sí mismo.';
    } else {
        // 3. Preparar y ejecutar la eliminación en la base de datos
        $stmt = $conexion->prepare("DELETE FROM usuarios WHERE id = ?");
        $stmt->bind_param("i", $user_id_to_delete);

        if ($stmt->execute()) {
            if ($stmt->affected_rows > 0) {
                $message = 'Usuario eliminado con éxito.';
            } else {
                $message = 'Error: No se encontró el usuario especificado.';
            }
        } else {
            $message = 'Error al eliminar el usuario: ' . $stmt->error;
        }
        $stmt->close();
    }
} else {
    $message = 'Error: Método de solicitud no válido.';
}

$conexion->close();

// Redirigir de vuelta al formulario con un mensaje
$_SESSION['flash_message'] = $message;
header('Location: ../views/form_eliminar_usuario.php');
exit;
?>
