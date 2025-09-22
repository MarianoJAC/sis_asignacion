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
  <title>Panel de Reservas</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome para iconos -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <!-- Estilos personalizados -->
  <link rel="stylesheet" href="../css/variables.css?v=1.1">
  <link rel="stylesheet" href="../css/global.css?v=1.3">
  <link rel="stylesheet" href="../css/reservas.css?v=1.0">
</head>
<body>

<div class="container-fluid mt-4">
  <div class="d-flex justify-content-between align-items-center mb-4">
    <h2 class="titulo-modulo">Panel de Solicitudes de Reserva</h2>
    <a href="grilla.php" class="btn btn-primary">Volver a la grilla</a>
  </div>

  <div class="card mb-4">
    <div class="card-header d-flex justify-content-between align-items-center">
      <span>Reservas</span>
      <div>
        <button id="btn-imprimir" class="btn btn-secondary">Imprimir</button>
        <button id="btn-pdf" class="btn btn-danger">Generar PDF</button>
      </div>
    </div>
    <div class="card-body">
      <div class="table-responsive" id="zona-imprimible">
        <table id="tabla-reservas" class="table table-hover align-middle">
          <thead class="table-light">
            <tr>
              <th data-sort="fecha">Fecha Reserva <span class="sort-icons"><i class="fas fa-sort-up sort-icon" data-direction="asc"></i><i class="fas fa-sort-down sort-icon" data-direction="desc"></i></span></th>
              <th data-sort="hora_inicio">Hora Inicio </th>
              <th data-sort="hora_fin">Hora Fin </th>
              <th data-sort="entidad_nombre">Entidad </th>
              <th data-sort="carrera">Carrera </th>
              <th data-sort="profesor">Profesor </th>
              <th data-sort="telefono_contacto">Teléfono </th>
              <th data-sort="timestamp">Fecha Solicitud <span class="sort-icons"><i class="fas fa-sort-up sort-icon" data-direction="asc"></i><i class="fas fa-sort-down sort-icon" data-direction="desc"></i></span></th>
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

<!-- Librería html2pdf.js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
<!-- SweetAlert2 para alertas -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Lógica del panel -->
<script src="../js/reservas.panel.js"></script>
</body>
</html>