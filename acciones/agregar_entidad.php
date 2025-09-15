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

    if (!$data || !isset($data['nombre']) || !isset($data['color'])) {
        http_response_code(400);
        echo json_encode(['error' => 'Datos incompletos']);
        exit;
    }

    $stmt = $pdo->prepare("INSERT INTO entidades (nombre, color) VALUES (:nombre, :color)");
    $stmt->execute([
        ':nombre' => $data['nombre'],
        ':color' => $data['color']
    ]);

    echo json_encode(['ok' => true, 'mensaje' => 'Entidad agregada correctamente']);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Error al agregar entidad: ' . $e->getMessage()]);
    exit;
}
?>