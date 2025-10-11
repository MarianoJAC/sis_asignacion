
<?php
session_start();
if (!isset($_SESSION['usuario_id']) || $_SESSION['role'] !== 'invitado') {
    header('Location: ../index.php');
    exit;
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menu de Solicitudes</title>
    <link rel="stylesheet" href="../css/variables.css">
    <link rel="stylesheet" href="../css/menu_invitado.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <link rel="icon" href="../iconos/calendario.ico" type="image/x-icon">
</head>
<body>
    <div class="menu-container">
        <h1>MENU DE SOLICITUDES</h1>
        <div class="menu-options">
            <a href="form_reserva.php" class="menu-btn btn-aula">RESERVA DE AULAS</a>
            <a href="form_laboratorio.php" class="menu-btn btn-lab">LABORATORIO AMBULANTE</a>
            <a href="form_kit_tv.php" class="menu-btn btn-kit">RESERVA KIT TV</a>
        </div>
        <a href="../acciones/logout.php" class="logout-link">CERRAR SESION</a>
    </div>
</body>
</html>
