<?php
include '../config/conexion.php';
header('Content-Type: application/json');

date_default_timezone_set('America/Argentina/Buenos_Aires');

$fechaActual = date('Y-m-d');
$horaActual = date('H:i:s');

$turnos = [
    'Matutino' => ['inicio' => '06:00:00', 'fin' => '14:00:00'],
    'Vespertino' => ['inicio' => '13:00:00', 'fin' => '18:00:00'],
    'Nocturno' => ['inicio' => '18:00:00', 'fin' => '23:00:00']
];

$turnoActual = null;
foreach ($turnos as $nombre => $rango) {
    if ($horaActual >= $rango['inicio'] && $horaActual <= $rango['fin']) {
        $turnoActual = $nombre;
        break;
    }
}

if (!$turnoActual) {
    echo json_encode([]);
    exit;
}

$query = "
    SELECT 
        e.nombre AS entidad,
        e.color AS color_entidad,
        au.nombre AS aula,
        a.carrera,
        a.anio,
        a.materia,
        a.profesor,
        a.hora_inicio,
        a.hora_fin,
        CONCAT(TIME_FORMAT(a.hora_inicio, '%H:%i'), ' - ', TIME_FORMAT(a.hora_fin, '%H:%i')) AS horario
    FROM asignaciones a
    JOIN aulas au ON a.aula_id = au.aula_id
    JOIN entidades e ON a.entidad_id = e.entidad_id
    WHERE a.fecha = ? AND a.turno = ?
    ORDER BY a.aula_id, a.hora_inicio;
";

$stmt = mysqli_prepare($conexion, $query);

if (!$stmt) {
    http_response_code(500);
    echo json_encode(['error' => 'Error al preparar la consulta: ' . mysqli_error($conexion)]);
    exit;
}

mysqli_stmt_bind_param($stmt, "ss", $fechaActual, $turnoActual);
mysqli_stmt_execute($stmt);
$resultado = mysqli_stmt_get_result($stmt);

if (!$resultado) {
    http_response_code(500);
    echo json_encode(['error' => 'Error al ejecutar la consulta de asignaciones']);
    exit;
}

$asignaciones = mysqli_fetch_all($resultado, MYSQLI_ASSOC);

echo json_encode($asignaciones);
?>
