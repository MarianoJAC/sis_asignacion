<?php
session_start();
if (!isset($_SESSION['usuario_id']) || $_SESSION['role'] !== 'admin') {
  header('Location: ../index.php?error=acceso_denegado');
  exit;
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Configuración de Usuarios</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome for icons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <!-- Estilos personalizados -->
  <link rel="stylesheet" href="../css/variables.css?v=1.1">
  <link rel="stylesheet" href="../css/global.css?v=1.3">
  <link rel="stylesheet" href="../css/configuracion.css?v=1.3">
  <link rel="stylesheet" href="../css/configuracion.styles.css?v=1.3">
</head>
<body>

<div class="container mt-4">
  <div class="d-flex justify-content-between align-items-center mb-4">
    <h2 class="titulo-modulo">Gestión de Usuarios</h2>
    <a href="grilla.php" class="btn btn-primary">Volver a la grilla</a>
  </div>

  <div class="card">
    <div class="card-header d-flex justify-content-between align-items-center">
      <span>Usuarios del Sistema</span>
      <button id="btn-agregar-usuario" class="btn btn-success">
        <i class="fas fa-plus"></i> Agregar Usuario
      </button>
    </div>
    <div class="card-body">
      <div class="table-responsive">
        <table id="tabla-usuarios" class="table table-hover align-middle">
          <thead class="table-light">
            <tr>
              <th>ID</th>
              <th>Nombre de Usuario</th>
              <th>Rol</th>
              <th>Acciones</th>
            </tr>
          </thead>
          <tbody>
            <!-- Contenido generado por JS -->
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>

<!-- Modal para formularios -->
<div class="modal fade" id="user-modal" tabindex="-1" aria-labelledby="user-modal-label" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="user-modal-label"></h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" id="user-modal-body">
        <!-- Contenido del formulario se inyectará aquí -->
      </div>
    </div>
  </div>
</div>

<!-- SweetAlert2 para alertas -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Lógica del panel de configuración -->
<script type="module" src="../js/configuracion.panel.js"></script>

</body>
</html>