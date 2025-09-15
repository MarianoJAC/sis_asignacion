<?php
$host = 'mysql.freehostia.com';
$usuario = 'cruvei_asignaciones';
$contrasena = 'Crui2025'; 
$base_datos = 'cruvei_asignaciones';

date_default_timezone_set('America/Argentina/Buenos_Aires');

try {
    $pdo = new PDO("mysql:host=$host;dbname=$base_datos;charset=utf8mb4", $usuario, $contrasena);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $pdo->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
} catch (PDOException $e) {
    die("Error de conexión: " . $e->getMessage());
}
?>