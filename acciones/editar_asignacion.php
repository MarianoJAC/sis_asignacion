<?php
include '../config/conexion.php';

session_start();
if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'admin') {
    echo json_encode(['ok' => false, 'error' => 'Acceso denegado']);
    exit;
}

header('Content-Type: application/json');

function capitalizar($texto) {
    $texto = mb_strtolower(trim($texto), 'UTF-8');
    $palabras = explode(' ', $texto);
    $excepciones = ['de', 'del', 'la', 'las', 'los', 'y', 'a', 'en', 'el', 'al', 'con', 'por'];

    foreach ($palabras as &$palabra) {
        if (!in_array($palabra, $excepciones)) {
            $palabra = mb_strtoupper(mb_substr($palabra, 0, 1), 'UTF-8') . mb_substr($palabra, 1);
        }
    }

    return implode(' ', $palabras);
}

$input = json_decode(file_get_contents('php://input'), true);

$id         = $input['id']         ?? '';
$aula_id    = $input['aula_id']    ?? '';
$fecha      = $input['fecha']      ?? '';
$turno      = $input['turno']      ?? '';
$carrera    = capitalizar($input['carrera'] ?? '');
$anio       = $input['anio']       ?? '';
$materia    = capitalizar($input['materia'] ?? '');
$profesor   = capitalizar($input['profesor'] ?? '');
$entidad    = $input['entidad_id'] ?? '';
$inicio     = $input['hora_inicio'] ?? '';
$fin        = $input['hora_fin']    ?? '';
$comentarios = trim($input['comentarios'] ?? '');

if (!$id || !$aula_id || !$fecha || !$turno || !$carrera || !$anio || !$materia || !$profesor || !$entidad || !$inicio || !$fin) {
    echo json_encode(['ok' => false, 'error' => 'Faltan campos obligatorios']);
    exit;
}

$stmt = $pdo->prepare("UPDATE asignaciones SET 
    aula_id = :aula_id, fecha = :fecha, turno = :turno, carrera = :carrera, anio = :anio, profesor = :profesor, 
    materia = :materia, entidad_id = :entidad, hora_inicio = :inicio, hora_fin = :fin, comentarios = :comentarios
    WHERE Id = :id");

$stmt->execute([
    'id' => $id, 'aula_id' => $aula_id, 'fecha' => $fecha, 'turno' => $turno, 'carrera' => $carrera, 'anio' => $anio,
    'profesor' => $profesor, 'materia' => $materia, 'entidad' => $entidad, 'inicio' => $inicio, 'fin' => $fin,
    'comentarios' => $comentarios
]);

if ($stmt->rowCount() > 0) {
    echo json_encode(['ok' => true, 'mensaje' => '✅ Asignación actualizada']);
} else {
    echo json_encode(['ok' => false, 'error' => 'No se realizó ninguna actualización']);
}
?>