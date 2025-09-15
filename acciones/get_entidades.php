<?php
include '../config/conexion.php';

header('Content-Type: application/json');

try {
    if (!isset($pdo) || !$pdo) {
        http_response_code(500);
        echo json_encode(['error' => 'Conexión no establecida']);
        exit;
    }

    $stmt = $pdo->prepare("SELECT entidad_id AS id, nombre, color FROM entidades ORDER BY nombre ASC");
    $stmt->execute();
    $entidades = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode(['ok' => true, 'entidades' => $entidades]);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Error al cargar entidades: ' . $e->getMessage()]);
    exit;
}
?>