<?php
session_start();
require_once '../config/conexion.php';

// Proteger la página para que solo administradores puedan acceder.
if (!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] !== true || $_SESSION["role"] !== 'admin') {
    header("location: ../index.php");
    exit;
}

// Obtener todos los usuarios excepto el administrador actual
$usuarios = [];
$current_user_id = $_SESSION['usuario_id']; // Usar la clave de sesión correcta: 'usuario_id'
$sql_usuarios = "SELECT id, username FROM usuarios WHERE id != ? ORDER BY username";
if ($stmt = $conexion->prepare($sql_usuarios)) {
    $stmt->bind_param('i', $current_user_id);
    $stmt->execute();
    $result = $stmt->get_result();
    while ($row = $result->fetch_assoc()) {
        $usuarios[] = $row;
    }
    $stmt->close();
}
$conexion->close();
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Eliminar Usuario</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/form_usuario.css?v=1.0">
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-10 col-lg-8">
                <div class="card login-card shadow-lg">
                    <div class="card-body">
                        <h3 class="card-title text-center mb-4">🗑️ Eliminar Usuario</h3>
                        
                        <?php if (isset($_SESSION['flash_message'])): ?>
                            <div class="alert alert-<?php echo strpos($_SESSION['flash_message'], 'Error') !== false ? 'danger' : 'success'; ?>" role="alert">
                                <?php echo $_SESSION['flash_message']; ?>
                            </div>
                            <?php unset($_SESSION['flash_message']); ?>
                        <?php endif; ?>

                        <form action="../acciones/eliminar_usuario.php" method="POST" class="row g-3" onsubmit="return confirm('¿Está seguro de que desea eliminar a este usuario? Esta acción no se puede deshacer.');">
                            
                            <div class="col-12">
                                <label for="user_id" class="form-label">Seleccione el usuario a eliminar:</label>
                                <select class="form-select" id="user_id" name="user_id" required>
                                    <option value="">Seleccione un usuario</option>
                                    <?php foreach ($usuarios as $usuario): ?>
                                        <option value="<?php echo htmlspecialchars($usuario['id']); ?>">
                                            <?php echo htmlspecialchars($usuario['username']); ?>
                                        </option>
                                    <?php endforeach; ?>
                                </select>
                            </div>

                            <div class="d-grid gap-2 mt-4">
                                <button type="submit" class="btn btn-danger">Eliminar Usuario</button>
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
