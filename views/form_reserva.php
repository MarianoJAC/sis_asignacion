<?php
session_start();
// Proteger la página para que solo el rol 'invitado' pueda acceder.
if (!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] !== true || $_SESSION["role"] !== 'invitado') {
    header("location: ../index.php");
    exit;
}

require_once '../config/conexion.php';

// Obtener entidades para el dropdown
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
    <title>Solicitud de Reserva de Aula</title>
    <link rel="stylesheet" href="../css/global.css">
    <link rel="stylesheet" href="../css/variables.css">
    <link rel="stylesheet" href="../css/formulario.css">
    <link rel="stylesheet" href="../css/header.css">
</head>
<body>
    <header class="header">
        <div class="header-container">
            <h1>Solicitud de Reserva de Aula</h1>
            <a href="../acciones/logout.php" class="btn-logout">Cerrar Sesión</a>
        </div>
    </header>

    <main class="form-container">
        <?php
        if (isset($_GET['status'])) {
            if ($_GET['status'] === 'success') {
                echo '<p class="alert alert-success">¡Solicitud de reserva enviada con éxito!</p>';
            } else if ($_GET['status'] === 'error') {
                echo '<p class="alert alert-danger">Error al enviar la solicitud. Por favor, intente de nuevo.</p>';
            }
        }
        ?>

        <form action="../acciones/guardar_reserva.php" method="POST" class="form-grid">
            
            <div class="form-group">
                <label for="fecha">Fecha de Reserva:</label>
                <input type="date" id="fecha" name="fecha" required>
            </div>

            <div class="form-group">
                <label for="entidad_id">Entidad:</label>
                <select id="entidad_id" name="entidad_id" required>
                    <option value="">Seleccione una entidad</option>
                    <?php foreach ($entidades as $entidad): ?>
                        <option value="<?php echo htmlspecialchars($entidad['entidad_id']); ?>">
                            <?php echo htmlspecialchars($entidad['nombre']); ?>
                        </option>
                    <?php endforeach; ?>
                </select>
            </div>

            <div class="form-group">
                <label for="carrera">Carrera:</label>
                <input type="text" id="carrera" name="carrera" required>
            </div>

            <div class="form-group">
                <label for="anio">Año de Carrera:</label>
                <input type="text" id="anio" name="anio" required>
            </div>

            <div class="form-group">
                <label for="materia">Materia:</label>
                <input type="text" id="materia" name="materia" required>
            </div>

            <div class="form-group">
                <label for="profesor">Profesor:</label>
                <input type="text" id="profesor" name="profesor" required>
            </div>

            <div class="form-group">
                <label for="hora_inicio">Hora Inicio:</label>
                <input type="time" id="hora_inicio" name="hora_inicio" required>
            </div>

            <div class="form-group">
                <label for="hora_fin">Hora Fin:</label>
                <input type="time" id="hora_fin" name="hora_fin" required>
            </div>

            <div class="form-group">
                <label for="telefono_contacto">Teléfono de Contacto:</label>
                <input type="text" id="telefono_contacto" name="telefono_contacto" required>
            </div>

            <div class="form-group full-width">
                <label for="comentarios">Comentarios:</label>
                <textarea id="comentarios" name="comentarios" rows="3"></textarea>
            </div>

            <div class="form-group full-width">
                <button type="submit" class="btn-submit">Enviar Solicitud</button>
            </div>
        </form>
    </main>
</body>
</html>
