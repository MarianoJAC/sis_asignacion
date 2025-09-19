<?php
session_start();

// Proteger la página para que solo el rol 'admin' pueda acceder.
if (!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] !== true || $_SESSION["role"] !== 'admin') {
    header("location: ../index.php");
    exit;
}

require_once '../config/conexion.php';

// Consulta para obtener todas las reservas junto con el nombre de la entidad
$reservas = [];
$sql = "SELECT r.*, e.nombre as entidad_nombre 
        FROM reservas r 
        JOIN entidades e ON r.entidad_id = e.entidad_id 
        ORDER BY r.fecha DESC, r.hora_inicio DESC";

if ($result = $conexion->query($sql)) {
    while ($row = $result->fetch_assoc()) {
        $reservas[] = $row;
    }
}

$conexion->close();
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel de Reservas</title>
    <link rel="stylesheet" href="../css/global.css">
    <link rel="stylesheet" href="../css/variables.css">
    <link rel="stylesheet" href="../css/header.css">
    <link rel="stylesheet" href="../css/auditoria.css"> <!-- Reutilizamos estilos de auditoría para la tabla -->
</head>
<body>
    <header class="header">
        <div class="header-container">
            <h1>Panel de Solicitudes de Reserva</h1>
            <div>
                <a href="grilla.php" class="btn-logout">Volver a la Grilla</a>
                <a href="../acciones/logout.php" class="btn-logout">Cerrar Sesión</a>
            </div>
        </div>
    </header>

    <main class="auditoria-container">
        <div class="table-container">
            <table class="auditoria-table">
                <thead>
                    <tr>
                        <th>Fecha Reserva</th>
                        <th>Hora Inicio</th>
                        <th>Hora Fin</th>
                        <th>Entidad</th>
                        <th>Carrera</th>
                        <th>Año</th>
                        <th>Materia</th>
                        <th>Profesor</th>
                        <th>Teléfono Contacto</th>
                        <th>Comentarios</th>
                        <th>Fecha Solicitud</th>
                    </tr>
                </thead>
                <tbody>
                    <?php if (!empty($reservas)): ?>
                        <?php foreach ($reservas as $reserva): ?>
                            <tr>
                                <td><?php echo htmlspecialchars(date("d/m/Y", strtotime($reserva['fecha']))); ?></td>
                                <td><?php echo htmlspecialchars(date("H:i", strtotime($reserva['hora_inicio']))); ?></td>
                                <td><?php echo htmlspecialchars(date("H:i", strtotime($reserva['hora_fin']))); ?></td>
                                <td><?php echo htmlspecialchars($reserva['entidad_nombre']); ?></td>
                                <td><?php echo htmlspecialchars($reserva['carrera']); ?></td>
                                <td><?php echo htmlspecialchars($reserva['anio']); ?></td>
                                <td><?php echo htmlspecialchars($reserva['materia']); ?></td>
                                <td><?php echo htmlspecialchars($reserva['profesor']); ?></td>
                                <td><?php echo htmlspecialchars($reserva['telefono_contacto']); ?></td>
                                <td class="comentarios-cell"><?php echo htmlspecialchars($reserva['comentarios']); ?></td>
                                <td><?php echo htmlspecialchars(date("d/m/Y H:i", strtotime($reserva['timestamp']))); ?></td>
                            </tr>
                        <?php endforeach; ?>
                    <?php else: ?>
                        <tr>
                            <td colspan="11">No hay solicitudes de reserva.</td>
                        </tr>
                    <?php endif; ?>
                </tbody>
            </table>
        </div>
    </main>
</body>
</html>
