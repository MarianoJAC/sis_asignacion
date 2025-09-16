<?php
$host = 'mysql.freehostia.com';
$usuario = 'cruvei_asignaciones';
$contrasena = 'Crui2025'; 
$base_datos = 'cruvei_asignaciones';

date_default_timezone_set('America/Argentina/Buenos_Aires');

$conexion = mysqli_connect($host, $usuario, $contrasena, $base_datos);

if (!$conexion) {
    die("Error de conexión: " . mysqli_connect_error());
}
?>