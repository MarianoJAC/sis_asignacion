
<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

require_once '../config/conexion.php';

session_start();

header('Content-Type: application/json');

// Function to log messages
function log_message($message) {
    $log_file = '../logs/reservas_ia.log';
    $timestamp = date('Y-m-d H:i:s');
    file_put_contents($log_file, "[{$timestamp}] {$message}\n", FILE_APPEND);
}

log_message('Request received.');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    log_message('Invalid request method.');
    echo json_encode(['ok' => false, 'error' => 'Método no permitido']);
    exit;
}

if (!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] !== true || $_SESSION["role"] !== 'invitado') {
    log_message('Unauthorized access attempt.');
    echo json_encode(['ok' => false, 'error' => 'Acceso no autorizado']);
    exit;
}

$data = json_decode(file_get_contents('php://input'), true);

if (json_last_error() !== JSON_ERROR_NONE) {
    log_message('Invalid JSON received.');
    echo json_encode(['ok' => false, 'error' => 'JSON inválido']);
    exit;
}

log_message('Request data: ' . print_r($data, true));

// Validar datos
$required_fields = ['fecha', 'entidad_id', 'aula_id', 'carrera', 'anio', 'materia', 'profesor', 'hora_inicio', 'hora_fin', 'telefono_contacto'];
foreach ($required_fields as $field) {
    if (empty($data[$field])) {
        log_message("Missing required field: {$field}");
        echo json_encode(['ok' => false, 'error' => "El campo '{$field}' es obligatorio."]);
        exit;
    }
}

// Convertir el tipo de reserva de string a int
$tipo_reserva_str = $data['tipo_reserva'] ?? 'Aula';
$tipo_reserva_int = 1; // Por defecto Aula
if ($tipo_reserva_str === 'Laboratorio Ambulante') {
        $tipo_reserva_int = 2;
    } elseif ($tipo_reserva_str === 'Kit TV') {    $tipo_reserva_int = 3;
}


$fecha = $data['fecha'];
$entidad_id = $data['entidad_id'];
$aula_id = $data['aula_id'];
$carrera = $data['carrera'];
$anio = $data['anio'];
$materia = $data['materia'];
$profesor = $data['profesor'];
$hora_inicio = $data['hora_inicio'];
$hora_fin = $data['hora_fin'];
$telefono_contacto = $data['telefono_contacto'];
$comentarios = $data['comentarios'] ?? '';
$cantidad_pc = $data['cantidad_pc'] ?? 0;

$sql = "INSERT INTO reservas (tipo_reserva, fecha, entidad_id, aula_id, carrera, anio, materia, profesor, hora_inicio, hora_fin, telefono_contacto, comentarios, cantidad_pc) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

if ($stmt = $conexion->prepare($sql)) {
    $stmt->bind_param("isiissssssssi", 
        $tipo_reserva_int, 
        $fecha, 
        $entidad_id, 
        $aula_id,
        $carrera, 
        $anio, 
        $materia, 
        $profesor, 
        $hora_inicio, 
        $hora_fin, 
        $telefono_contacto, 
        $comentarios,
        $cantidad_pc
    );

    if ($stmt->execute()) {
        log_message('Reservation saved successfully.');
        echo json_encode(['ok' => true]);
    } else {
        log_message('Error saving reservation: ' . $stmt->error);
        echo json_encode(['ok' => false, 'error' => 'Error al guardar la reserva.']);
    }
    $stmt->close();
} else {
    log_message('Error preparing statement: ' . $conexion->error);
    echo json_encode(['ok' => false, 'error' => 'Error en la preparación de la consulta.']);
}

$conexion->close();
