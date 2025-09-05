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

$comentarios = trim($_POST['comentarios']); // opcionalmente podés capitalizar

$query = "INSERT INTO asignaciones (
  aula_id, dia, turno, carrera, anio, profesor, materia, entidad_id, hora_inicio, hora_fin, comentarios
) VALUES (
  '$aula_id', '$dia', '$turno', '$carrera', '$anio', '$profesor', '$materia', '$entidad', '$inicio', '$fin', '$comentarios'
)";

if (mysqli_query($conexion, $query)) {
  echo "✅ Asignación guardada";
} else {
  echo "❌ Error: " . mysqli_error($conexion);
}