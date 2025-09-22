<?php
require_once __DIR__ . '/api_utils.php';

// Solo los administradores pueden eliminar reservas
validar_admin();

// Obtener el ID de la reserva del cuerpo de la solicitud
$input = json_decode(file_get_contents('php://input'), true);
$reserva_id = $input['id'] ?? null;

if (!$reserva_id) {
    responder_error('No se proporcionó el ID de la reserva.');
}

$stmt = $conexion->prepare("UPDATE reservas SET eliminado = TRUE WHERE id = ?");
if (!$stmt) {
    responder_error("Error al preparar la consulta.", 500);
}

$stmt->bind_param("i", $reserva_id);

if ($stmt->execute()) {
    if ($stmt->affected_rows > 0) {
        echo json_encode(['ok' => true, 'message' => 'Reserva marcada como eliminada.']);
    } else {
        responder_error('No se encontró ninguna reserva con el ID proporcionado.', 404);
    }
} else {
    responder_error("Error al ejecutar la consulta.", 500);
}

$stmt->close();
$conexion->close();
?>