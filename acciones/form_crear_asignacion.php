<?php
include '../config/conexion.php';

$aula_id = $_GET['aula_id'] ?? '';
$dia = $_GET['dia'] ?? '';
$turno = $_GET['turno'] ?? '';

function options($tabla, $id_col, $name_col) {
  global $conexion;
  $result = mysqli_query($conexion, "SELECT $id_col, $name_col FROM $tabla ORDER BY $name_col");
  $opts = '';
  while ($row = mysqli_fetch_assoc($result)) {
    $opts .= "<option value='{$row[$id_col]}'>{$row[$name_col]}</option>";
  }
  return $opts;
}
?>

<div class="modal-contenido">
  <form class="modal-formulario" action="acciones/guardar_asignacion.php" method="post" autocomplete="off">
    <input type="hidden" name="aula_id" value="<?= $aula_id ?>">
    <input type="hidden" name="dia" value="<?= $dia ?>">
    <input type="hidden" name="turno" value="<?= $turno ?>">

    <div class="campo-formulario">
      <label for="entidad_id">Entidad:</label>
      <select name="entidad_id" id="entidad_id" required>
        <option value="">Seleccionar</option>
        <?= options('entidades', 'entidad_id', 'nombre') ?>
      </select>
    </div>

    <div class="campo-formulario">
      <label for="carrera">Carrera:</label>
      <input type="text" name="carrera" id="carrera" placeholder="Ej: Lic. en Informática" required>
    </div>

    <div class="campo-formulario">
      <label for="anio">Año de la carrera:</label>
      <select name="anio" id="anio" required>
        <option value="">Seleccione una opción</option>
        <option value="1">1</option>
        <option value="1A">1A</option>
        <option value="1B">1B</option>
        <option value="2">2</option>
        <option value="3">3</option>
        <option value="4">4</option>
        <option value="5">5</option>
        <option value="6">6</option>
      </select>
    </div>

    <div class="campo-formulario">
      <label for="materia">Materia:</label>
      <input type="text" name="materia" id="materia" placeholder="Ej: Algoritmos y estructuras de datos" required>
    </div>

    <div class="campo-formulario">
      <label for="profesor">Profesor:</label>
      <input type="text" name="profesor" id="profesor" placeholder="Ej: Carla Ramírez" required>
    </div>

    <div class="campo-formulario">
      <label for="hora_inicio">Hora inicio:</label>
      <input type="time" name="hora_inicio" id="hora_inicio" required>
    </div>

    <div class="campo-formulario">
      <label for="hora_fin">Hora fin:</label>
      <input type="time" name="hora_fin" id="hora_fin" required>
    </div>

    <div class="campo-formulario fila-completa">
      <label for="comentarios">Comentarios:</label>
      <textarea name="comentarios" id="comentarios" rows="3" placeholder="Opcional..."></textarea>
    </div>

    <div class="form-buttons fila-completa">
      <button type="button" id="btn-cancelar-creacion">❌ Cancelar</button>
      <button type="submit">✅ Guardar</button>
    </div>
  </form>
</div>