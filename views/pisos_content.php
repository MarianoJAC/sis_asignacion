<?php
session_start();
if (!isset($_SESSION['usuario_id'])) {
  // This is loaded in an iframe, so we can't redirect.
  // The parent page should handle authentication.
  exit;
}

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
<link rel="stylesheet" href="../css/mapa_pisos.css">
<div class="map-container">
    <!-- Primer Piso -->
    <section class="mapa piso primer-piso active">
        <img src="../imagenes/piso1.jpg" alt="Mapa del primer piso">
        <a href="#segPiso" id="priPiso" class="marca-agua">Planta Baja</a>

        <?php foreach ($classrooms_first_floor as $classroom): ?>
            <a href="grilla.php?aula_id=<?php echo $classroom['id']; ?>&origen=mapa"
               class="aula <?php echo $classroom['class']; ?>" target="_parent">
               <?php echo $classroom['name']; ?>
            </a>
        <?php endforeach; ?>

        <div class="flechabajo">
            <a href="#" class="change-map" data-target="segundo-piso"><img class="flecha" src="../imagenes/flechabajo.png" alt="abajo"></a>
        </div>
    </section>


    <!-- Segundo Piso -->
    <section class="mapa piso segundo-piso">
        <img src="../imagenes/piso2.jpg" alt="Mapa del segundo piso">
        <a href="#priPiso" id="segPiso" class="marca-agua">Primer Piso</a>
        <?php foreach ($classrooms_second_floor as $classroom): ?>
          <a href="grilla.php?aula_id=<?php echo $classroom['id']; ?>&origen=mapa"
             class="aula <?php echo $classroom['class']; ?>" target="_parent">
             <?php echo $classroom['name']; ?>
          </a>
        <?php endforeach; ?>
        <div class="flecharriba">
            <a href="#" class="change-map" data-target="primer-piso"><img class="flecha" src="../imagenes/flecharriba.png" alt="arriba"></a>
        </div>
    </section>
</div>
<script>
document.addEventListener('DOMContentLoaded', function() {
    const changeMapLinks = document.querySelectorAll('.change-map');
    const maps = document.querySelectorAll('.mapa');

    changeMapLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            const target = this.dataset.target;

            maps.forEach(map => {
                if (map.classList.contains(target)) {
                    map.classList.add('active');
                } else {
                    map.classList.remove('active');
                }
            });
        });
    });
});
</script>
