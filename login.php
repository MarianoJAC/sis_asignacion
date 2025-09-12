<?php
session_start();

// Incluir la conexión a la BD (ajusta si el path es diferente)
include 'config/conexion.php';

$error = '';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = $_POST['username'];
    $password = $_POST['password'];

    // Consulta a la BD
    $stmt = $pdo->prepare("SELECT * FROM usuarios WHERE username = :username AND password = :password");
    $stmt->execute(['username' => $username, 'password' => $password]);  
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($user) {
        $_SESSION['user_id'] = $user['id'];
        $_SESSION['role'] = $user['role'];
        header('Location: index.html');  // Redirige a index.html
        exit();
    } else {
        $error = 'Usuario o contraseña incorrectos.';
    }
}

// Si ya está logueado, redirige directamente
if (isset($_SESSION['user_id'])) {
    header('Location: index.html');
    exit();
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Sistema de Asignación de Aulas</title>
    <!-- Incluir CSS si existe, ajusta paths según tu estructura -->
    <link rel="stylesheet" href="css/estilos.css">  <!-- Asumiendo que hay un CSS en css/ -->
</head>
<body>
    <div class="login-container">
        <h2>Iniciar Sesión</h2>
        <?php if ($error): ?>
            <p style="color: red;"><?php echo $error; ?></p>
        <?php endif; ?>
        <form method="POST">
            <label for="username">Usuario:</label>
            <input type="text" id="username" name="username" required>
            
            <label for="password">Contraseña:</label>
            <input type="password" id="password" name="password" required>
            
            <button type="submit">Ingresar</button>
        </form>
    </div>
</body>
</html>