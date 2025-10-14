<?php
session_start();
require_once '../config/conexion.php';
require_once 'api_utils.php';

validar_admin(); // Asegura que solo los administradores puedan acceder

$admin_id = $_SESSION['usuario_id'];

$input = json_decode(file_get_contents('php://input'), true);
$reserva_ids = $input['reserva_ids'] ?? [];

if (empty($reserva_ids)) {
    responder_error('No se proporcionaron IDs de reserva para marcar como vistas.');
}

// Iniciar transacción
$conexion->begin_transaction();

try {
    $ids_string = implode(',', array_fill(0, count($reserva_ids), '?'));
    $query_update = "UPDATE admin_notificaciones SET vista = TRUE WHERE admin_id = ? AND reserva_id IN ($ids_string)";
    $stmt = $conexion->prepare($query_update);

    if (!$stmt) {
        throw new Exception('Error al preparar la consulta de actualización.');
    }

    // Bind de los parámetros
    $types = 'i' . str_repeat('i', count($reserva_ids));
    $bind_params = array_merge([$types, $admin_id], $reserva_ids);
    call_user_func_array([$stmt, 'bind_param'], refValues($bind_params));

    if (!$stmt->execute()) {
        throw new Exception('Error al marcar las reservas como vistas.');
    }

    $conexion->commit();
    echo json_encode(['ok' => true, 'message' => 'Reservas marcadas como vistas.']);

} catch (Exception $e) {
    $conexion->rollback();
    responder_error('Error de base de datos: ' . $e->getMessage());
}

$conexion->close();

// Función auxiliar para bind_param con un número variable de argumentos
function refValues($arr) {
    if (strnatcmp(phpversion(),'5.3') >= 0) //Reference is required for PHP 5.3+
    {
        $refs = array();
        foreach($arr as $key => $value)
            $refs[$key] = & $arr[$key];
        return $refs;
    }
    return $arr;
}