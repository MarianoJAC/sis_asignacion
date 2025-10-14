<?php
// Inicia la sesión para todas las llamadas a la API
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

// Incluye la configuración de la base de datos una sola vez
require_once __DIR__ . '/../config/conexion.php';

// Establece el encabezado de respuesta estándar
header('Content-Type: application/json; charset=utf-8');

/**
 * Envía una respuesta de error estandarizada en JSON y termina el script.
 *
 * @param string $mensaje El mensaje de error a enviar.
 * @param int $codigo HTTP status code (ej. 403 para prohibido, 500 para error de servidor).
 */
function responder_error($mensaje, $codigo = 400) {
    http_response_code($codigo);
    echo json_encode(['ok' => false, 'error' => $mensaje]);
    exit;
}

/**
 * Valida si el usuario actual es un administrador.
 * Si no lo es, envía una respuesta de error y termina el script.
 */
function validar_admin() {
    if (!isset($_SESSION['usuario_id']) || $_SESSION['role'] !== 'admin') {
        responder_error('Acceso denegado. Se requiere rol de administrador.', 403);
    }
}

/**
 * Valida si el usuario actual está autenticado (cualquier rol).
 * Si no lo es, envía una respuesta de error y termina el script.
 */
function validar_autenticado() {
    if (!isset($_SESSION['usuario_id'])) {
        responder_error('Acceso no autenticado.', 401);
    }
}

/**
 * Obtiene los IDs de todos los usuarios con rol 'admin'.
 *
 * @global mysqli $conexion
 * @return array Un array de IDs de administradores.
 */
function get_admin_ids() {
    global $conexion;
    $admin_ids = [];
    $query = "SELECT id FROM usuarios WHERE role = 'admin'";
    $result = $conexion->query($query);
    if ($result) {
        while ($row = $result->fetch_assoc()) {
            $admin_ids[] = $row['id'];
        }
    } else {
        error_log("Error al obtener IDs de administradores: " . $conexion->error);
    }
    return $admin_ids;
}
?>