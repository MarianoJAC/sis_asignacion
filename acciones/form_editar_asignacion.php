<?php
include '../config/conexion.php';

$id = $_GET['id'] ?? '';
$aula_id = $_GET['aula_id'] ?? '';
$turno = $_GET['turno'] ?? '';

if (!is_numeric($id) || intval($id) <= 0) {
  echo '<div class="alert alert-danger">ID inválido</div>';
  exit;
}

$stmt = $conexion->prepare("SELECT * FROM asignaciones WHERE Id = ?");
$stmt->bind_param("i", $id);
$stmt->execute();
$result = $stmt->get_result();
$asignacion = $result->fetch_assoc();

if (!$asignacion) {
  echo '<div class="alert alert-danger">Asignación no encontrada</div>';
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

<p><strong>Turno actual:</strong> <?= htmlspecialchars($asignacion['turno']) ?></p>

<form id="form-editar-asignacion" autocomplete="off">
    <input type="hidden" name="id" value="<?= $id ?>">
    <input type="hidden" name="aula_id" value="<?= htmlspecialchars($aula_id ?: $asignacion['aula_id']) ?>">
    <input type="hidden" name="turno" value="<?= htmlspecialchars($asignacion['turno']) ?>">

    <div class="row g-3">
        <div class="col-md-6">
            <label for="fecha" class="form-label">Fecha exacta:</label>
            <input type="date" name="fecha" id="fecha" class="form-control" value="<?= $asignacion['fecha'] ?>" required>
        </div>

        <div class="col-md-6">
            <label for="entidad_id" class="form-label">Entidad:</label>
            <select name="entidad_id" id="entidad_id" class="form-select" required>
                <option value="">Seleccionar</option>
                <?= options('entidades', 'entidad_id', 'nombre', $asignacion['entidad_id']) ?>
            </select>
        </div>

        <div class="col-md-6">
            <label for="carrera" class="form-label">Carrera:</label>
            <input type="text" name="carrera" id="carrera" class="form-control" value="<?= htmlspecialchars($asignacion['carrera']) ?>" required>
        </div>

        <div class="col-md-6">
            <label for="anio" class="form-label">Año de la carrera:</label>
            <select name="anio" id="anio" class="form-select" required>
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

        <div class="col-12">
            <label for="materia" class="form-label">Materia:</label>
            <input type="text" name="materia" id="materia" class="form-control" value="<?= htmlspecialchars($asignacion['materia']) ?>" required>
        </div>

        <div class="col-12">
            <label for="profesor" class="form-label">Profesor:</label>
            <input type="text" name="profesor" id="profesor" class="form-control" value="<?= htmlspecialchars($asignacion['profesor']) ?>" required>
        </div>

        <div class="col-md-6">
            <label for="hora_inicio" class="form-label">Hora inicio:</label>
            <input type="time" name="hora_inicio" id="hora_inicio" class="form-control" value="<?= $asignacion['hora_inicio'] ?>" required>
        </div>

        <div class="col-md-6">
            <label for="hora_fin" class="form-label">Hora fin:</label>
            <input type="time" name="hora_fin" id="hora_fin" class="form-control" value="<?= $asignacion['hora_fin'] ?>" required>
        </div>

        <div class="col-12">
            <label for="comentarios" class="form-label">Comentarios:</label>
            <textarea name="comentarios" id="comentarios" class="form-control" rows="3"><?= htmlspecialchars($asignacion['comentarios']) ?></textarea>
        </div>
    </div>

    <div class="modal-footer mt-4 d-flex justify-content-center">
        <button type="button" class="btn btn-secondary" id="btn-cancelar-edicion" data-bs-dismiss="modal">❌ Cancelar</button>
        <button type="submit" class="btn btn-primary">✅ Guardar cambios</button>
    </div>
</form>
