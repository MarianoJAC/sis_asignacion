<?php
include '../../config/conexion.php';

if (!isset($_GET['aula_id'])) {
    echo "No se especificó el aula.";
    exit;
}

$aula_id = $_GET['aula_id'];

// Obtener el nombre del aula
$query_aula = "SELECT nombre FROM aulas WHERE aula_id = ?";
$stmt_aula = mysqli_prepare($conexion, $query_aula);
mysqli_stmt_bind_param($stmt_aula, "i", $aula_id);
mysqli_stmt_execute($stmt_aula);
mysqli_stmt_bind_result($stmt_aula, $aula_nombre);
if (!mysqli_stmt_fetch($stmt_aula)) {
    echo "Aula no encontrada.";
    exit;
}
mysqli_stmt_close($stmt_aula);

// Definir turnos y días
$shifts = ['Matutino', 'Vespertino', 'Nocturno'];
$days = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'];

// Obtener asignaciones con el nombre de la entidad
$query_asignaciones = "
    SELECT a.*, e.nombre AS entidad_nombre 
    FROM asignaciones a 
    LEFT JOIN entidades e ON a.entidad_id = e.entidad_id 
    WHERE a.aula_id = ? 
    ORDER BY FIELD(a.turno, 'Matutino', 'Vespertino', 'Nocturno'), 
             FIELD(a.dia, 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'), 
             a.hora_inicio";
$stmt_asignaciones = mysqli_prepare($conexion, $query_asignaciones);
mysqli_stmt_bind_param($stmt_asignaciones, "i", $aula_id);
mysqli_stmt_execute($stmt_asignaciones);
$result = mysqli_stmt_get_result($stmt_asignaciones);
$asignaciones = mysqli_fetch_all($result, MYSQLI_ASSOC);
mysqli_stmt_close($stmt_asignaciones);

// Agrupar asignaciones
$grouped = [];
foreach ($asignaciones as $asignacion) {
    $turno = $asignacion['turno'];
    $dia = $asignacion['dia'];
    if (!isset($grouped[$turno])) {
        $grouped[$turno] = [];
    }
    if (!isset($grouped[$turno][$dia])) {
        $grouped[$turno][$dia] = [];
    }
    $grouped[$turno][$dia][] = $asignacion;
}

// Mapear entidad_id a clases CSS
$entidad_classes = [
    1 => 'entidad-UNAHUR',
    2 => 'entidad-UNLAM',
    3 => 'entidad-Marechal',
    4 => 'entidad-Enfermeria',
    5 => 'entidad-Ofertas',
    6 => 'entidad-CursoIngreso'
];
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Asignaciones de <?php echo htmlspecialchars($aula_nombre); ?></title>
    <link rel="stylesheet" href="../css_aulas/aula_asignaciones.css">
</head>
<body>
    <div id="leyenda-colores">
        <strong>Colores por entidad:</strong>
        <div class="leyenda-row">
            <span class="leyenda-bloque entidad-UNAHUR">UNAHUR</span>
            <span class="leyenda-bloque entidad-UNLAM">UNLAM</span>
            <span class="leyenda-bloque entidad-Marechal">Marechal</span>
            <span class="leyenda-bloque entidad-Enfermeria">Enfermería</span>
            <span class="leyenda-bloque entidad-Ofertas">Ofertas independientes</span>
            <span class="leyenda-bloque entidad-CursoIngreso">Curso ingreso UNLAM</span>
        </div>
    </div>

    <h1>Asignaciones para <?php echo htmlspecialchars($aula_nombre); ?></h1>
    <?php if (empty($asignaciones)): ?>
        <p>No hay asignaciones para esta aula.</p>
    <?php else: ?>
        <table>
            <thead>
                <tr>
                    <th>Turno</th>
                    <?php foreach ($days as $day): ?>
                        <th><?php echo $day; ?></th>
                    <?php endforeach; ?>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($shifts as $shift): ?>
                    <tr>
                        <td><?php echo $shift; ?></td>
                        <?php foreach ($days as $day): ?>
                            <td>
                                <?php if (isset($grouped[$shift][$day]) && !empty($grouped[$shift][$day])): ?>
                                    <?php foreach ($grouped[$shift][$day] as $index => $asignacion): ?>
                                        <div class="assignment-detail <?php echo isset($entidad_classes[$asignacion['entidad_id']]) ? $entidad_classes[$asignacion['entidad_id']] : ''; ?>">
                                            <strong>Hora Inicio:</strong> <?php echo substr($asignacion['hora_inicio'], 0, 5); ?><br>
                                            <strong>Hora Fin:</strong> <?php echo substr($asignacion['hora_fin'], 0, 5); ?><br>
                                            <strong>Materia:</strong> <?php echo htmlspecialchars($asignacion['materia']); ?><br>
                                            <strong>Carrera:</strong> <?php echo htmlspecialchars($asignacion['carrera']); ?><br>
                                            <strong>Año:</strong> <?php echo htmlspecialchars($asignacion['anio']); ?><br>
                                            <strong>Profesor:</strong> <?php echo htmlspecialchars($asignacion['profesor']); ?><br>
                                            <strong>Entidad:</strong> <?php echo htmlspecialchars($asignacion['entidad_nombre']); ?>
                                            <?php if ($index < count($grouped[$shift][$day]) - 1): ?>
                                                <br><br>
                                            <?php endif; ?>
                                        </div>
                                    <?php endforeach; ?>
                                <?php else: ?>
                                    <div class="assignment-detail" style="color: green; text-align: center;">DISPONIBLE</div>
                                <?php endif; ?>
                            </td>
                        <?php endforeach; ?>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    <?php endif; ?>
    <a href="pisos.php" class="back-button">Volver al Mapa</a>
</body>
</html>