<?php
require_once '../config/conexion.php';

header('Content-Type: application/json');

// Establecer la zona horaria para la sesión actual de MySQL
$conexion->query("SET time_zone = '-03:00'");

// Consulta para obtener todas las reservas junto con el nombre de la entidad
$reservas = [];
$sql = "SELECT r.*, e.nombre as entidad_nombre, a.nombre as aula_nombre, DATE_FORMAT(r.timestamp, '%d/%m/%Y') AS fecha_solicitud
        FROM reservas r 
        JOIN entidades e ON r.entidad_id = e.entidad_id
        LEFT JOIN aulas a ON r.aula_id = a.aula_id
        WHERE r.eliminado = FALSE
        ORDER BY r.timestamp DESC";

$response = [];

try {
    if ($result = $conexion->query($sql)) {
        while ($row = $result->fetch_assoc()) {
            $reservas[] = $row;
        }
        $response['ok'] = true;
        $response['data'] = $reservas;
    } else {
        throw new Exception('Error al ejecutar la consulta: ' . $conexion->error);
    }
} catch (Exception $e) {
    http_response_code(500);
    $response['ok'] = false;
    $response['error'] = $e->getMessage();
}

$conexion->close();
echo json_encode($response);
