<?php
include '../config/conexion.php';

$id = $_GET['id'] ?? $_POST['id'] ?? null;

if (!$id) {
  echo "❌ ID no recibido";
  exit;
}

$query = "DELETE FROM asignaciones WHERE Id = '$id'";
if (mysqli_query($conexion, $query)) {
  echo "✅ Asignación eliminada";
} else {
  echo "❌ Error: " . mysqli_error($conexion);
}
