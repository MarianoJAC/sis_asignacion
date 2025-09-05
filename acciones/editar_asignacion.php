<?php
include '../config/conexion.php';

// Función para capitalizar con soporte de acentos
function capitalizar($texto) {
  $texto = mb_strtolower(trim($texto), 'UTF-8');
  $palabras = explode(' ', $texto);

  $excepciones = ['de', 'del', 'la', 'las', 'los', 'y', 'a', 'en', 'el', 'al', 'con', 'por'];

  foreach ($palabras as &$palabra) {
    if (!in_array($palabra, $excepciones)) {
      $palabra = mb_strtoupper(mb_substr($palabra, 0, 1), 'UTF-8') . mb_substr($palabra, 1);
    }
  }

  return implode(' ', $palabras);
}

$id        = $_POST['id'];
$aula_id   = $_POST['aula_id'];
$dia       = $_POST['dia'];
$turno     = $_POST['turno'];
$carrera   = capitalizar($_POST['carrera']);
$anio      = $_POST['anio'];
$materia   = capitalizar($_POST['materia']);
$profesor  = capitalizar($_POST['profesor']);
$entidad   = $_POST['entidad_id'];
$inicio    = $_POST['hora_inicio'];
$fin       = $_POST['hora_fin'];
$comentarios = trim($_POST['comentarios']);

$query = "UPDATE asignaciones SET 
  aula_id = '$aula_id', 
  dia = '$dia', 
  turno = '$turno', 
  carrera = '$carrera', 
  anio = '$anio', 
  profesor = '$profesor', 
  materia = '$materia', 
  entidad_id = '$entidad', 
  hora_inicio = '$inicio', 
  hora_fin = '$fin', 
  comentarios = '$comentarios'
  WHERE Id = '$id'";

if (mysqli_query($conexion, $query)) {
  echo "✅ Asignación actualizada";
} else {
  echo "❌ Error: " . mysqli_error($conexion);
}
?>