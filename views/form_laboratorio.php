
<?php
session_start();
if (!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] !== true || $_SESSION["role"] !== 'invitado') {
    header("location: ../index.php");
    exit;
}

require_once '../config/conexion.php';

$entidades = [];
$sql_entidades = "SELECT entidad_id, nombre FROM entidades ORDER BY nombre";
if ($result_entidades = $conexion->query($sql_entidades)) {
    while ($row = $result_entidades->fetch_assoc()) {
        $entidades[] = $row;
    }
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Solicitud de Laboratorio Ambulante</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/variables.css?v=1.1">
    <link rel="stylesheet" href="../css/global.css?v=1.1">
    <link rel="stylesheet" href="../css/login.css?v=1.1">
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="card login-card shadow-lg">
                    <div class="card-body">
                        <h3 class="card-title text-center mb-4">💻 Solicitud de Laboratorio Ambulante</h3>
                        
                        <?php if (isset($_GET['status'])): ?>
                            <div class="alert alert-<?php echo $_GET['status'] === 'success' ? 'success' : 'danger'; ?>" role="alert">
                                <?php echo $_GET['status'] === 'success' ? '¡Solicitud enviada con éxito!' : 'Error al enviar la solicitud. Por favor, intente de nuevo.'; ?>
                            </div>
                        <?php endif; ?>

                        <form action="../acciones/guardar_solicitud.php" method="POST" class="row g-3">
                            <input type="hidden" name="tipo_reserva" value="2">

                            <div class="col-md-6">
                                <label for="fecha" class="form-label">Fecha de Reserva:</label>
                                <input type="date" class="form-control" id="fecha" name="fecha" required>
                            </div>

                            <div class="col-md-6">
                                <label for="entidad_id" class="form-label">Entidad:</label>
                                <select class="form-select" id="entidad_id" name="entidad_id" required>
                                    <option value="">Seleccione una entidad</option>
                                    <?php foreach ($entidades as $entidad): ?>
                                        <option value="<?php echo htmlspecialchars($entidad['entidad_id']); ?>">
                                            <?php echo htmlspecialchars($entidad['nombre']); ?>
                                        </option>
                                    <?php endforeach; ?>
                                </select>
                            </div>

                            <div class="col-md-6">
                                <label for="carrera" class="form-label">Carrera:</label>
                                <input type="text" class="form-control" id="carrera" name="carrera" required>
                            </div>

                            <div class="col-md-6">
                                <label for="anio" class="form-label">Año de Carrera:</label>
                                <input type="text" class="form-control" id="anio" name="anio" required>
                            </div>

                            <div class="col-md-6">
                                <label for="materia" class="form-label">Materia:</label>
                                <input type="text" class="form-control" id="materia" name="materia" required>
                            </div>

                            <div class="col-md-6">
                                <label for="profesor" class="form-label">Profesor:</label>
                                <input type="text" class="form-control" id="profesor" name="profesor" required>
                            </div>

                            <div class="col-md-6">
                                <label for="hora_inicio" class="form-label">Hora Inicio:</label>
                                <input type="time" class="form-control" id="hora_inicio" name="hora_inicio" required>
                            </div>

                            <div class="col-md-6">
                                <label for="hora_fin" class="form-label">Hora Fin:</label>
                                <input type="time" class="form-control" id="hora_fin" name="hora_fin" required>
                            </div>

                            <div class="col-md-6">
                                <label for="telefono_contacto" class="form-label">Teléfono de Contacto:</label>
                                <input type="text" class="form-control" id="telefono_contacto" name="telefono_contacto" required>
                            </div>

                            <div class="col-md-6">
                                <label for="cantidad_pc" class="form-label">Cantidad de PC:</label>
                                <input type="number" class="form-control" id="cantidad_pc" name="cantidad_pc" min="1" required>
                            </div>

                            <div class="col-12">
                                <label for="comentarios" class="form-label">Comentarios:</label>
                                <textarea class="form-control" id="comentarios" name="comentarios" rows="3"></textarea>
                            </div>

                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary">Enviar Solicitud</button>
                                <a href="menu_invitado.php" class="btn btn-secondary">Volver al Menu</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
