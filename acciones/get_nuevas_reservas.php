<?php
session_start();
require_once '../config/conexion.php';
require_once 'api_utils.php';

if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'admin') {
    responder_error('Acceso denegado. Se requiere rol de administrador.', 403);
}

$admin_id = $_SESSION['usuario_id']; // Asumiendo que el ID del admin está en la sesión

// Iniciar transacción
$conexion->begin_transaction();

try {
    // Obtener IDs de reservas no vistas por el admin actual
    $query_select_notif = "SELECT reserva_id FROM admin_notificaciones WHERE admin_id = ? AND vista = FALSE";
    $stmt_notif = $conexion->prepare($query_select_notif);
    if (!$stmt_notif) {
        throw new Exception('Error al preparar la consulta de notificaciones.');
    }
    $stmt_notif->bind_param("i", $admin_id);
    $stmt_notif->execute();
    $result_notif = $stmt_notif->get_result();

    $reserva_ids_no_vistas = [];
    while ($row = $result_notif->fetch_assoc()) {
        $reserva_ids_no_vistas[] = $row['reserva_id'];
    }
    $stmt_notif->close();

    $nuevas_reservas = [];
    if (!empty($reserva_ids_no_vistas)) {
        // Obtener detalles de las reservas no vistas
        $ids_string = implode(',', array_fill(0, count($reserva_ids_no_vistas), '?'));
        $query_select_reservas = "SELECT r.*, e.nombre as entidad_nombre, a.nombre as aula_nombre FROM reservas r JOIN entidades e ON r.entidad_id = e.entidad_id LEFT JOIN aulas a ON r.aula_id = a.aula_id WHERE r.id IN ($ids_string)";
        $stmt_reservas = $conexion->prepare($query_select_reservas);
        if (!$stmt_reservas) {
            throw new Exception('Error al preparar la consulta de reservas.');
        }
        $types = str_repeat('i', count($reserva_ids_no_vistas));
        $stmt_reservas->bind_param($types, ...$reserva_ids_no_vistas);
        $stmt_reservas->execute();
        $result_reservas = $stmt_reservas->get_result();

        while ($row = $result_reservas->fetch_assoc()) {
            $nuevas_reservas[] = $row;
        }
        $stmt_reservas->close();
    }

    // Confirmar transacción
    $conexion->commit();

    // Enviar las nuevas reservas en la respuesta
    echo json_encode(['ok' => true, 'data' => $nuevas_reservas]);

} catch (Exception $e) {
    // Revertir transacción en caso de error
    $conexion->rollback();
    responder_error('Error de base de datos: ' . $e->getMessage());
}

$conexion->close();
