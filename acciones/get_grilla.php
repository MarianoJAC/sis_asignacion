<?php
include '../config/conexion.php';

$diasSemana = [' ', 'Lunes','Martes','Miércoles','Jueves','Viernes','Sábado'];

// 🧠 Capturar parámetro opcional
$aula_id = isset($_GET['aula_id']) ? intval($_GET['aula_id']) : 0;

// ✅ Traemos recurso y capacidad de cada aula
$aulasQuery = mysqli_query($conexion, "SELECT aula_id, nombre, recurso, capacidad FROM aulas ORDER BY aula_id ASC");
$aulas = [];
while ($fila = mysqli_fetch_assoc($aulasQuery)) {
  if (in_array(trim($fila['nombre']), ['Laboratorio', 'Aula Gabinete'])) {
    $fila['recurso'] = null;
    $fila['capacidad'] = null;
  }

  // 🧠 Filtramos si se pasó aula_id
  if ($aula_id === 0 || $fila['aula_id'] == $aula_id) {
    $aulas[] = $fila;
  }
}


// ✅ Armamos query de asignaciones con filtro opcional
$query = "
  SELECT 
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
";

if ($aula_id > 0) {
  $query .= " WHERE a.aula_id = $aula_id";
}

$query .= " ORDER BY a.hora_inicio ASC";

// ✅ Ejecutamos y enviamos
$asignaciones = mysqli_fetch_all(mysqli_query($conexion, $query), MYSQLI_ASSOC);

if (!is_array($asignaciones)) {
  $asignaciones = [];
}

if (!$aulasQuery || !$asignaciones) {
  http_response_code(500);
  echo json_encode(['error' => 'Error en la consulta']);
  exit;
}

echo json_encode([
  'dias' => $diasSemana,
  'aulas' => $aulas,
  'asignaciones' => $asignaciones
]);