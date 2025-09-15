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

    if (!$data || !isset($data['id'])) {
        http_response_code(400);
        echo json_encode(['error' => 'ID de asignación no proporcionado']);
        exit;
    }

    $stmt = $pdo->prepare("DELETE FROM asignaciones WHERE Id = :id");
    $stmt->bindParam(':id', $data['id'], PDO::PARAM_INT);
    $stmt->execute();

    echo json_encode(['ok' => true, 'mensaje' => 'Asignación eliminada correctamente']);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Error al eliminar asignación: ' . $e->getMessage()]);
    exit;
}
?>