<?php
include '../config/conexion.php';
header('Content-Type: application/json');

session_start();
if (!isset($_SESSION['user_id'])) {
    echo json_encode(['ok' => false, 'error' => 'Debe iniciar sesión']);
    exit;
}

$aula_id = isset($_GET['aula_id']) ? intval($_GET['aula_id']) : 0;
$fecha = $_GET['fecha'] ?? '';
$turno = $_GET['turno'] ?? '';

if (!$aula_id || !$fecha || !$turno) {
    echo json_encode(['ok' => false, 'error' => 'Parámetros inválidos']);
    exit;
}

$stmt = $pdo->prepare("
    SELECT 
        a.Id,
        a.fecha,
        a.turno,
        a.carrera,
        a.anio,
        a.profesor,
        a.materia,
        a.hora_inicio,
        a.hora_fin,
        a.aula_id,
        a.entidad_id,
        a.comentarios
    FROM asignaciones a
    WHERE a.aula_id = :aula_id AND a.fecha = :fecha AND a.turno = :turno
    ORDER BY a.hora_inicio ASC
");
$stmt->execute([
    'aula_id' => $aula_id,
    'fecha' => $fecha,
    'turno' => $turno
]);
$asignaciones = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode(['ok' => true, 'asignaciones' => $asignaciones]);
?>