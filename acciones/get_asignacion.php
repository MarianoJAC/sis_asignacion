<?php
include '../config/conexion.php';
header('Content-Type: application/json');

session_start();
if (!isset($_SESSION['user_id'])) {
    echo json_encode(['ok' => false, 'error' => 'Debe iniciar sesión']);
    exit;
}

$id = isset($_GET['id']) ? intval($_GET['id']) : 0;

if (!$id) {
    echo json_encode(['ok' => false, 'error' => 'ID inválido']);
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
    WHERE a.Id = :id
");
$stmt->execute(['id' => $id]);
$asignacion = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$asignacion) {
    echo json_encode(['ok' => false, 'error' => 'Asignación no encontrada']);
    exit;
}

echo json_encode(['ok' => true, 'asignacion' => $asignacion]);
?>