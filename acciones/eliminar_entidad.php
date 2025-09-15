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

    if (!$data || !isset($data['entidad_id'])) {
        http_response_code(400);
        echo json_encode(['error' => 'ID de entidad no proporcionado']);
        exit;
    }

    $stmt = $pdo->prepare("DELETE FROM entidades WHERE entidad_id = :entidad_id");
    $stmt->bindParam(':entidad_id', $data['entidad_id'], PDO::PARAM_INT);
    $stmt->execute();

    echo json_encode(['ok' => true, 'mensaje' => 'Entidad eliminada correctamente']);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Error al eliminar entidad: ' . $e->getMessage()]);
    exit;
}
?>