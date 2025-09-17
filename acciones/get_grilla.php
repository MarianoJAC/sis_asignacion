<?php
include '../config/conexion.php';
header('Content-Type: application/json');


if (!isset($conexion) || !$conexion) {
  http_response_code(500);
  echo json_encode(['error' => 'Conexión no establecida']);
  exit;
}

$aula_id = isset($_GET['aula_id']) ? intval($_GET['aula_id']) : 0;

// 🔁 Primero cargamos recursos
$recursosPorAula = [];
$recursosQuery = mysqli_query($conexion, "SELECT aula_id, recurso FROM recursos_por_aula");
if ($recursosQuery) {
  while ($r = mysqli_fetch_assoc($recursosQuery)) {
    $id = intval($r['aula_id']);
    if (!isset($recursosPorAula[$id])) {
      $recursosPorAula[$id] = [];
    }
    $recursosPorAula[$id][] = $r['recurso'];
  }
}

// ✅ Ahora sí, cargamos aulas y les inyectamos recursos
$aulasQuery = mysqli_query($conexion, "SELECT aula_id, nombre, capacidad FROM aulas ORDER BY aula_id ASC");
if (!$aulasQuery) {
  http_response_code(500);
  echo json_encode(['error' => 'Error en la consulta de aulas']);
  exit;
}

$aulas = [];
while ($fila = mysqli_fetch_assoc($aulasQuery)) {
  if (in_array(trim($fila['nombre']), ['Laboratorio', 'Aula Gabinete'])) {
    $fila['capacidad'] = null;
  }
  if ($aula_id === 0 || $fila['aula_id'] == $aula_id) {
    $fila['recursos'] = $recursosPorAula[$fila['aula_id']] ?? [];
    $aulas[] = $fila;
  }
}


$query = "
  SELECT 
    a.Id,
    a.fecha,
    a.turno,
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
  $query .= " WHERE a.aula_id = ?";
}

$query .= " ORDER BY a.fecha ASC, a.hora_inicio ASC";

$stmt = mysqli_prepare($conexion, $query);

if (!$stmt) {
    http_response_code(500);
    echo json_encode(['error' => 'Error al preparar la consulta: ' . mysqli_error($conexion)]);
    exit;
}

if ($aula_id > 0) {
    mysqli_stmt_bind_param($stmt, "i", $aula_id);
}

mysqli_stmt_execute($stmt);
$asignacionesQuery = mysqli_stmt_get_result($stmt);

if (!$asignacionesQuery) {
  http_response_code(500);
  echo json_encode(['error' => 'Error en la consulta de asignaciones']);
  exit;
}

$asignaciones = mysqli_fetch_all($asignacionesQuery, MYSQLI_ASSOC);

echo json_encode([
  'aulas' => $aulas,
  'asignaciones' => $asignaciones
]);