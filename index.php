<?php
session_start();
include 'config/conexion.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  $username = trim($_POST['username'] ?? '');
  $password = $_POST['password'] ?? '';

  if (!$username || !$password) {
    $error = 'Credenciales incompletas';
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

        header("Location: views/grilla.php");
        exit;
      } else {
        $error = 'Contraseña incorrecta';
      }
    } else {
      $error = 'Usuario no encontrado';
    }
  }
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Login institucional</title>
  <link rel="stylesheet" href="css/login.css">
</head>
<body>
  <div class="login-container">
    <h2>🔐 Acceso al sistema</h2>
    <?php if (isset($error)): ?>
      <div class="error"><?= htmlspecialchars($error) ?></div>
    <?php endif; ?>
    <form method="POST">
      <label>Usuario:
        <input type="text" name="username" required>
      </label>
      <label>Contraseña:
        <input type="password" name="password" required>
      </label>
      <button type="submit">Ingresar</button>
    </form>
  </div>
</body>
</html>