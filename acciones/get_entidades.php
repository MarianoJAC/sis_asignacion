<?php
include '../config/conexion.php';

$res = mysqli_query($conexion, "SELECT entidad_id, nombre, color FROM entidades ORDER BY nombre ASC");
$entidades = [];

while ($row = mysqli_fetch_assoc($res)) {
  $entidades[] = $row;
}

echo json_encode($entidades);