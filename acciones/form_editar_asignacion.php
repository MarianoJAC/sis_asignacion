<?php
include '../config/conexion.php';

$id = $_GET['id'] ?? '';
$aula_id = $_GET['aula_id'] ?? '';
$turno = $_GET['turno'] ?? '';

// 🧪 Trazas para auditoría
error_log("🧪 ID recibido: " . $id);
error_log("🧪 Aula ID: " . $aula_id);
error_log("🧪 Turno: " . $turno);

// 🚫 Validación de ID
if (!is_numeric($id) || intval($id) <= 0) {
  error_log("❌ ID inválido: " . $id);
  echo '<div class="modal-contenido"><p class="mensaje-error">ID inválido</p></div>';
  exit;
}

// 🔍 Buscar asignación
$query = "SELECT * FROM asignaciones WHERE Id = '$id'";
$result = mysqli_query($conexion, $query);
$asignacion = mysqli_fetch_assoc($result);

if (!$asignacion) {
  error_log("❌ Asignación no encontrada para ID: " . $id);
  echo '<div class="modal-contenido"><p class="mensaje-error">Asignación no encontrada</p></div>';
  exit;
}

function options($tabla, $id_col, $name_col, $selected = '') {
  global $conexion;
  $result = mysqli_query($conexion, "SELECT $id_col, $name_col FROM $tabla ORDER BY $name_col");
  $opts = '';
  while ($row = mysqli_fetch_assoc($result)) {
    $selectedAttr = ($selected == $row[$id_col]) ? 'selected' : '';
    $opts .= "<option value='{$row[$id_col]}' $selectedAttr>{$row[$name_col]}</option>";
  }
  return $opts;
}
?>

<p style="margin-bottom:10px;"><strong>Turno actual:</strong> <?= htmlspecialchars($asignacion['turno']) ?></p>

<form id="form-editar-asignacion" class="modal-formulario" autocomplete="off">
  <input type="hidden" name="id" value="<?= $id ?>">
  <input type="hidden" name="aula_id" value="<?= htmlspecialchars($aula_id ?: $asignacion['aula_id']) ?>">
  <input type="hidden" name="turno" value="<?= htmlspecialchars($asignacion['turno']) ?>">

  <div class="campo-formulario">
    <label for="fecha">Fecha exacta:</label>
    <input type="date" name="fecha" id="fecha" value="<?= $asignacion['fecha'] ?>" required>
  </div>

  <div class="campo-formulario">
    <label for="entidad_id">Entidad:</label>
    <select name="entidad_id" id="entidad_id" required>
      <option value="">Seleccionar</option>
      <?= options('entidades', 'entidad_id', 'nombre', $asignacion['entidad_id']) ?>
    </select>
  </div>

  <div class="campo-formulario">
    <label for="carrera">Carrera:</label>
    <input type="text" name="carrera" id="carrera" value="<?= htmlspecialchars($asignacion['carrera']) ?>" required>
  </div>

  <div class="campo-formulario">
    <label for="anio">Año de la carrera:</label>
    <select name="anio" id="anio" required>
      <option value="">Seleccione una opción</option>
      <?php
      $opciones = ['1', '1A', '1B', '2', '3', '4', '5', '6'];
      foreach ($opciones as $op) {
        $selected = $asignacion['anio'] == $op ? 'selected' : '';
        echo "<option value=\"$op\" $selected>$op</option>";
      }
      ?>
    </select>
  </div>

  <div class="campo-formulario">
    <label for="materia">Materia:</label>
    <input type="text" name="materia" id="materia" value="<?= htmlspecialchars($asignacion['materia']) ?>" required>
  </div>

  <div class="campo-formulario">
    <label for="profesor">Profesor:</label>
    <input type="text" name="profesor" id="profesor" value="<?= htmlspecialchars($asignacion['profesor']) ?>" required>
  </div>

  <div class="campo-formulario">
    <label for="hora_inicio">Hora inicio:</label>
    <input type="time" name="hora_inicio" id="hora_inicio" value="<?= $asignacion['hora_inicio'] ?>" required>
  </div>

  <div class="campo-formulario">
    <label for="hora_fin">Hora fin:</label>
    <input type="time" name="hora_fin" id="hora_fin" value="<?= $asignacion['hora_fin'] ?>" required>
  </div>

  <div class="campo-formulario fila-completa">
    <label for="comentarios">Comentarios:</label>
    <textarea name="comentarios" id="comentarios" rows="3"><?= htmlspecialchars($asignacion['comentarios']) ?></textarea>
  </div>

  <div class="form-buttons fila-completa">
    <button type="button" id="btn-cancelar-creacion">❌ Cancelar</button>
    <button type="submit">✅ Guardar cambios</button>
  </div>
</form>