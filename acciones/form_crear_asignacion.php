<?php
include '../config/conexion.php';

$aula_id = $_GET['aula_id'] ?? '';
$fecha = $_GET['fecha'] ?? '';
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

<form id="form-agregar-asignacion" autocomplete="off">
    <input type="hidden" name="aula_id" value="<?= htmlspecialchars($aula_id) ?>">
    <input type="hidden" name="turno" value="<?= htmlspecialchars($turno) ?>">

    <div class="row g-3">
        <div class="col-12">
            <label class="form-label">Repetir asignación:</label>
            <div class="d-flex justify-content-start">
                <div class="form-check form-check-inline me-3">
                    <input class="form-check-input" type="radio" id="repetir_dia" name="repeticion" value="dia" checked>
                    <label class="form-check-label" for="repetir_dia">Solo este día</label>
                </div>
                <div class="form-check form-check-inline me-3">
                    <input class="form-check-input" type="radio" id="repetir_mes" name="repeticion" value="mes">
                    <label class="form-check-label" for="repetir_mes">Todo el mes</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" id="repetir_anio" name="repeticion" value="anio">
                    <label class="form-check-label" for="repetir_anio">Todo el año</label>
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <label for="fecha" class="form-label">Fecha exacta:</label>
            <input type="date" name="fecha" id="fecha" class="form-control" value="<?= htmlspecialchars($fecha) ?>" required>
        </div>

        <div class="col-md-6">
            <label for="turno-display" class="form-label">Turno:</label>
            <input type="text" id="turno-display" class="form-control" value="<?= htmlspecialchars($turno) ?>" disabled>
        </div>

        <div class="col-md-6">
            <label for="entidad_id" class="form-label">Entidad:</label>
            <select name="entidad_id" id="entidad_id" class="form-select" required>
                <option value="">Seleccionar</option>
                <?= options('entidades', 'entidad_id', 'nombre') ?>
            </select>
        </div>

        <div class="col-md-6">
            <label for="carrera" class="form-label">Carrera:</label>
            <input type="text" name="carrera" id="carrera" class="form-control" placeholder="Ej: Lic. en Informática" required>
        </div>

        <div class="col-md-6">
            <label for="anio" class="form-label">Año de la carrera:</label>
            <select name="anio" id="anio" class="form-select" required>
                <option value="">Seleccione una opción</option>
                <?php
                $opciones = ['1', '1A', '1B', '2', '3', '4', '5', '6'];
                foreach ($opciones as $op) {
                  echo "<option value=\"$op\">$op</option>";
                }
                ?>
            </select>
        </div>

        <div class="col-12">
            <label for="materia" class="form-label">Materia:</label>
            <input type="text" name="materia" id="materia" class="form-control" placeholder="Ej: Algoritmos y estructuras de datos" required>
        </div>

        <div class="col-12">
            <label for="profesor" class="form-label">Profesor:</label>
            <input type="text" name="profesor" id="profesor" class="form-control" placeholder="Ej: Carla Ramírez" required>
        </div>

        <div class="col-md-6">
            <label for="hora_inicio" class="form-label">Hora inicio:</label>
            <input type="time" name="hora_inicio" id="hora_inicio" class="form-control" required>
        </div>

        <div class="col-md-6">
            <label for="hora_fin" class="form-label">Hora fin:</label>
            <input type="time" name="hora_fin" id="hora_fin" class="form-control" required>
        </div>

        <div class="col-12">
            <label for="comentarios" class="form-label">Comentarios:</label>
            <textarea name="comentarios" id="comentarios" class="form-control" rows="3" placeholder="Opcional..."></textarea>
        </div>
    </div>

    <div class="modal-footer mt-4 d-flex justify-content-center">
        <button type="button" class="btn btn-secondary" id="btn-cancelar-creacion" data-bs-dismiss="modal">❌ Cancelar</button>
        <button type="submit" class="btn btn-primary">✅ Guardar</button>
    </div>
</form>