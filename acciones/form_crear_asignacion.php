<?php
include '../config/conexion.php';

$aula_id = $_GET['aula_id'] ?? '';
$fecha = $_GET['fecha'] ?? '';
$turno = $_GET['turno'] ?? '';

// 🧪 Trazas para auditoría
error_log("🧪 Crear asignación | Aula: $aula_id | Fecha: $fecha | Turno: $turno");

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
  <form id="form-agregar-asignacion" class="modal-formulario" autocomplete="off">
    <input type="hidden" name="aula_id" value="<?= htmlspecialchars($aula_id) ?>">
    <input type="hidden" name="turno" value="<?= htmlspecialchars($turno) ?>">

    <div class="campo-formulario">
      <label for="fecha">Fecha exacta:</label>
      <input type="date" name="fecha" id="fecha" value="<?= htmlspecialchars($fecha) ?>" required>
    </div>

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
        <?php
        $opciones = ['1', '1A', '1B', '2', '3', '4', '5', '6'];
        foreach ($opciones as $op) {
          echo "<option value=\"$op\">$op</option>";
        }
        ?>
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