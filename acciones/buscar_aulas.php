<?php
include '../config/conexion.php';
header('Content-Type: application/json');

session_start();
if (!isset($_SESSION['user_id'])) {
    echo json_encode(['ok' => false, 'error' => 'Debe iniciar sesión']);
    exit;
}

$input = json_decode(file_get_contents('php://input'), true);
$texto = strtolower(trim($input['texto'] ?? ''));

if (!$texto) {
    echo json_encode(['ok' => false, 'error' => 'Texto vacío']);
    exit;
}

$stmt = $pdo->prepare("
    SELECT aula_id AS id, nombre, recurso, capacidad
    FROM aulas
    WHERE LOWER(nombre) LIKE :texto
       OR LOWER(recurso) LIKE :texto
       OR LOWER(CAST(capacidad AS CHAR)) LIKE :texto
");
$texto = "%$texto%";
$stmt->execute(['texto' => $texto]);
$aulas = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode(['ok' => true, 'aulas' => $aulas]);
exit;
?>