<?php
session_start();
include 'config/conexion.php';

// Redirigir si ya hay una sesión activa
if (isset($_SESSION['loggedin']) && $_SESSION['loggedin'] === true) {
    if ($_SESSION['role'] === 'invitado') {
        header("Location: views/form_reserva.php");
    } else {
        header("Location: views/grilla.php");
    }
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  $username = trim($_POST['username'] ?? '');
  $password = $_POST['password'] ?? '';

  if (!$username || !$password) {
    $error = 'Por favor, complete todos los campos.';
  } else {
    $stmt = $conexion->prepare("SELECT id, password, role FROM usuarios WHERE username = ?");
    $stmt->bind_param("s", $username);
    $stmt->execute();
    $stmt->store_result();

    if ($stmt->num_rows === 1) {
      $stmt->bind_result($id, $hash, $role);
      $stmt->fetch();

      if (password_verify($password, $hash)) {
        $_SESSION['usuario_id'] = $id;
        $_SESSION['username'] = $username;
        $_SESSION['role'] = $role;
        $_SESSION['loggedin'] = true; // Añadir para consistencia

        // Redirigir según el rol
        if ($role === 'invitado') {
            header("Location: views/form_reserva.php");
        } else {
            header("Location: views/grilla.php");
        }
        exit;
      } else {
        $error = 'Usuario o contraseña incorrectos.';
      }
    } else {
      $error = 'Usuario o contraseña incorrectos.';
    }
  }
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login - Sistema de Asignaciones</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="css/login.css?v=1.1">
</head>
<body>
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-md-6 col-lg-4">
        <div class="card login-card shadow-lg">
          <div class="card-body">
            <h3 class="card-title text-center mb-4">🔐 Acceso al Sistema</h3>
            <?php if (isset($error)): ?>
              <div class="alert alert-danger" role="alert">
                <?= htmlspecialchars($error) ?>
              </div>
            <?php endif; ?>
            <form method="POST" novalidate>
              <div class="mb-3">
                <label for="username" class="form-label">Nombre de Usuario</label>
                <input type="text" class="form-control" id="username" name="username" required>
              </div>
              <div class="mb-3">
                <label for="password" class="form-label">Contraseña</label>
                <input type="password" class="form-control" id="password" name="password" required>
              </div>
              <div class="d-grid">
                <button type="submit" class="btn btn-primary">Ingresar</button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>