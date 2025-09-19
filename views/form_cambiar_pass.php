<?php
session_start();

// Verificación de seguridad: solo los administradores pueden ver esta página.
if (!isset($_SESSION['role']) || $_SESSION['role'] !== 'admin') {
    die('Acceso denegado. Esta página requiere privilegios de administrador.');
}

// Recuperar y limpiar el mensaje flash de la sesión
$flash_message = $_SESSION['flash_message'] ?? null;
if ($flash_message) {
    unset($_SESSION['flash_message']);
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cambiar Contraseña de Usuario</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/login.css?v=1.1"> <!-- Reutilizamos el CSS del login para un estilo consistente -->
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <div class="card login-card shadow-lg">
                <div class="card-body">
                    <h3 class="card-title text-center mb-4">🔑 Cambiar Contraseña</h3>

                    <?php if ($flash_message): ?>
                        <div class="alert alert-info" role="alert">
                            <?= htmlspecialchars($flash_message) ?>
                        </div>
                    <?php endif; ?>

                    <form action="../acciones/cambiar_contrasena.php" method="POST">
                        <div class="mb-3">
                            <label for="username" class="form-label">Nombre de Usuario a modificar</label>
                            <input type="text" class="form-control" id="username" name="username" required>
                        </div>
                        <div class="mb-3">
                            <label for="new_password" class="form-label">Nueva Contraseña</label>
                            <input type="password" class="form-control" id="new_password" name="new_password" required>
                        </div>
                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary">Actualizar Contraseña</button>
                            <a href="grilla.php" class="btn btn-secondary">Volver a la Grilla</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
