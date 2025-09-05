<?php
include '../config/conexion.php';

$diasSemana = [' ', 'Lunes','Martes','Miércoles','Jueves','Viernes','Sábado'];

// ✅ Traemos recurso y capacidad de cada aula
$aulasQuery = mysqli_query($conexion, "SELECT aula_id, nombre, recurso, capacidad FROM aulas ORDER BY aula_id ASC");
$aulas = [];
while ($fila = mysqli_fetch_assoc($aulasQuery)) {
  // Si el nombre es Laboratorio o Gabinete, omitimos recurso y capacidad
  if (in_array(trim($fila['nombre']), ['Laboratorio', 'Aula Gabinete'])) {
    $fila['recurso'] = null;
    $fila['capacidad'] = null;
  }
  $aulas[] = $fila;
}

// ✅ Traemos las asignaciones con color de entidad incluido
$query = "SELECT 
            a.Id,
            a.turno,
            a.dia,
            a.carrera,
            a.anio,
            a.profesor,
            a.materia,
            a.hora_inicio,
            a.hora_fin,
            a.aula_id,
            a.entidad_id,
            a.comentarios,
            au.nombre AS aula,
            e.nombre AS entidad,
            e.color AS color_entidad
          FROM asignaciones a
          JOIN aulas au    ON a.aula_id = au.aula_id
          JOIN entidades e ON a.entidad_id = e.entidad_id
          ORDER BY a.hora_inicio ASC";

$asignaciones = mysqli_fetch_all(mysqli_query($conexion, $query), MYSQLI_ASSOC);

// ✅ Enviamos recurso y capacidad junto con el resto
echo json_encode([
  'dias' => $diasSemana,
  'aulas' => $aulas,
  'asignaciones' => $asignaciones
]);