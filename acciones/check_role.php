<?php
session_start();
include '../config/conexion.php';

header('Content-Type: application/json');

$isLoggedIn = isset($_SESSION['role']); // Verifica si hay una sesión activa
$isAdmin = $isLoggedIn && $_SESSION['role'] === 'admin';

echo json_encode([
    'isLoggedIn' => $isLoggedIn,
    'isAdmin' => $isAdmin
]);
exit;
?>