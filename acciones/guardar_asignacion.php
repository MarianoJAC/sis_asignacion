<?php
include '../config/conexion.php';

header('Content-Type: application/json');

try {
    if (!isset($pdo) || !$pdo) {
        http_response_code(500);
        echo json_encode(['error' => 'Conexión no establecida']);
        exit;
    }

    $data = json_decode(file_get_contents('php://input'), true);

    if (!$data || !isset($data['entidad_id'], $data['materia'], $data['profesor'], $data['hora_inicio'], $data['hora_fin'], $data['aula_id'], $data['fecha'], $data['turno'])) {
        http_response_code(400);
        echo json_encode(['error' => 'Datos incompletos']);
        exit;
    }

    $stmt = $pdo->prepare("INSERT INTO asignaciones (entidad_id, carrera, anio, materia, profesor, hora_inicio, hora_fin, aula_id, fecha, turno, comentarios) VALUES (:entidad_id, :carrera, :anio, :materia, :profesor, :hora_inicio, :hora_fin, :aula_id, :fecha, :turno, :comentarios)");
    $stmt->execute([
        ':entidad_id' => $data['entidad_id'],
        ':carrera' => $data['carrera'] ?? null,
        ':anio' => $data['anio'] ?? null,
        ':materia' => $data['materia'],
        ':profesor' => $data['profesor'],
        ':hora_inicio' => $data['hora_inicio'],
        ':hora_fin' => $data['hora_fin'],
        ':aula_id' => $data['aula_id'],
        ':fecha' => $data['fecha'],
        ':turno' => $data['turno'],
        ':comentarios' => $data['comentarios'] ?? null
    ]);

    echo json_encode(['ok' => true, 'mensaje' => 'Asignación guardada con éxito']);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Error al guardar asignación: ' . $e->getMessage()]);
    exit;
}
?>