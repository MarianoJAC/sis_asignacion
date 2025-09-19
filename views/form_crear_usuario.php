<?php
session_start();
// Proteger la página para que solo administradores puedan acceder.
if (!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] !== true || $_SESSION["role"] !== 'admin') {
    header("location: ../index.php");
    exit;
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Crear Nuevo Usuario</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/form_usuario.css?v=1.0">
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-10 col-lg-8">
                <div class="card login-card shadow-lg">
                    <div class="card-body">
                        <h3 class="card-title text-center mb-4">👤 Crear Nuevo Usuario</h3>
                        
                        <?php if (isset($_SESSION['flash_message'])): ?>
                            <div class="alert alert-<?php echo strpos($_SESSION['flash_message'], 'Error') !== false ? 'danger' : 'success'; ?>" role="alert">
                                <?php echo $_SESSION['flash_message']; ?>
                            </div>
                            <?php unset($_SESSION['flash_message']); ?>
                        <?php endif; ?>

                        <form action="../acciones/crear_usuario.php" method="POST" class="row g-3">
                            
                            <div class="col-12">
                                <label for="username" class="form-label">Nombre de Usuario:</label>
                                <input type="text" class="form-control" id="username" name="username" required>
                            </div>

                            <div class="col-12">
                                <label for="password" class="form-label">Contraseña:</label>
                                <input type="password" class="form-control" id="password" name="password" required>
                            </div>

                            <div class="col-12">
                                <label for="role" class="form-label">Rol de Usuario:</label>
                                <select class="form-select" id="role" name="role" required>
                                    <option value="">Seleccione un rol</option>
                                    <option value="admin">Administrador</option>
                                    <option value="viewer">Visualizador</option>
                                    <option value="invitado">Invitado</option>
                                </select>
                            </div>

                            <div class="d-grid gap-2 mt-4">
                                <button type="submit" class="btn btn-primary">Crear Usuario</button>
                                <a href="../index.php" class="btn btn-outline-secondary">Volver al Inicio</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
