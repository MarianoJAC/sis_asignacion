<?php
$classrooms_first_floor = [
    ['id' => 1, 'class' => 'auditorio', 'name' => 'Auditorio'],
    ['id' => 2, 'class' => 'magna1', 'name' => 'Magna 1'],
    ['id' => 3, 'class' => 'magna2', 'name' => 'Magna 2'],
    ['id' => 4, 'class' => 'magna', 'name' => 'Magna'],
    ['id' => 5, 'class' => 'gabinete', 'name' => 'Gabinete'],
    ['id' => 6, 'class' => 'laboratorio', 'name' => 'Laboratorio'],
];

$classrooms_second_floor = [
    ['id' => 7, 'class' => 'aula1', 'name' => 'Aula 1'],
    ['id' => 8, 'class' => 'aula2', 'name' => 'Aula 2'],
    ['id' => 9, 'class' => 'aula12', 'name' => 'Aula 1 y 2'],
    ['id' => 10, 'class' => 'aula3', 'name' => 'Aula 3'],
    ['id' => 11, 'class' => 'aula4', 'name' => 'Aula 4'],
    ['id' => 12, 'class' => 'aula5', 'name' => 'Aula 5'],
    ['id' => 13, 'class' => 'aula6', 'name' => 'Aula 6'],
    ['id' => 14, 'class' => 'aula45', 'name' => 'Aula 5 y 6'],

];
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mapa de Aulas</title>
    <link rel="stylesheet" href="../css_aulas/mapa_pisos.css">
    <link rel="stylesheet" href="../../css/turnos.css">
</head>
<body>
    <!-- Primer Piso -->
    <section class="mapa piso primer-piso">
        <img src="../imagenes/primer_piso.jpg" alt="Mapa del primer piso">
        <a href="#segPiso" id="priPiso" class="marca-agua">Planta Baja</a>
        <a href="http://localhost/sis_asignacion/index.html" class="volver"><button class="tab-btn">VOLVER</button></a>
        <?php foreach ($classrooms_first_floor as $classroom): ?>
            <a href="aula_asignaciones.php?aula_id=<?php echo $classroom['id']; ?>" class="aula <?php echo $classroom['class']; ?>"><?php echo $classroom['name']; ?></a>
        <?php endforeach; ?>
        <div class="flechabajo">
            <a href="#segPiso"><img class="flecha" src="../imagenes/flechabajo.png" alt="arriba"></a>
        </div>
    </section>

    <!-- Segundo Piso -->
    <section class="mapa piso segundo-piso">
        <img src="../imagenes/segundo_piso.jpg" alt="Mapa del segundo piso">
        <a href="#priPiso" id="segPiso" class="marca-agua">Primer Piso</a>
        <a href="http://localhost/sis_asignacion/index.html" class="volver"><button class="tab-btn">VOLVER</button></a>
        <?php foreach ($classrooms_second_floor as $classroom): ?>
            <a href="aula_asignaciones.php?aula_id=<?php echo $classroom['id']; ?>" class="aula <?php echo $classroom['class']; ?>"><?php echo $classroom['name']; ?></a>
        <?php endforeach; ?>
        <div class="flecharriba">
            <a href="#priPiso"><img class="flecha" src="../imagenes/flecharriba.png" alt="arriba"></a>
        </div>
    </section>
</body> 
</html>