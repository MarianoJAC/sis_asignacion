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
  <link rel="icon" href="../img/favicon.png">
  <title>Auditoría</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <link rel="stylesheet" href="../css/variables.css?v=1.1">
  <link rel="stylesheet" href="../css/global.css?v=1.3">
  <link rel="stylesheet" href="../css/auditoria.css?v=1.7">
</head>
<body class="pagina-auditoria">

<div class="container-fluid mt-4">
  <div class="d-flex justify-content-between align-items-center mb-4">
    <h2 class="titulo-modulo">Auditoría</h2>
    <a href="grilla.php" class="btn btn-primary">Volver</a>
  </div>

  <div class="card mb-4">
    <div class="card-header d-flex justify-content-between align-items-center">
      <span></span>
      <div>
        <button id="btn-imprimir" class="btn btn-sm btn-outline-secondary">Imprimir</button>
        <button id="btn-pdf" class="btn btn-sm btn-outline-danger">Generar PDF</button>
      </div>
    </div>
    <div class="card-body">
      <form id="filtros-auditoria">
        <div class="row g-3 align-items-end">
          <div class="col-md">
            <label for="filtro-usuario" class="form-label">Usuario</label>
            <input type="text" id="filtro-usuario" name="usuario" class="form-control" placeholder="Ej: admin">
          </div>
          <div class="col-md">
            <label for="filtro-tipo" class="form-label">Tipo de Objeto</label>
            <select id="filtro-tipo" name="tipo" class="form-select">
              <option value="">Todos</option>
              <option value="asignacion">Asignación</option>
              <option value="entidad">Entidad</option>
            </select>
          </div>
          <div class="col-md">
            <label for="filtro-accion" class="form-label">Acción</label>
            <select id="filtro-accion" name="accion" class="form-select">
              <option value="">Todas</option>
              <option value="alta">Alta</option>
              <option value="baja">Baja</option>
              <option value="modificacion">Modificación</option>
            </select>
          </div>
          <div class="col-md">
            <label for="filtro-desde" class="form-label">Desde</label>
            <input type="date" id="filtro-desde" name="desde" class="form-control">
          </div>
          <div class="col-md">
            <label for="filtro-hasta" class="form-label">Hasta</label>
            <input type="date" id="filtro-hasta" name="hasta" class="form-control">
          </div>
          <div class="col-md-auto">
            <button type="submit" class="btn btn-success">Filtrar</button>
          </div>
        </div>
      </form>
    </div>
  </div>

  <div class="table-responsive" id="zona-imprimible">
    <table id="tabla-auditoria" class="table table-hover align-middle">
      <thead class="table-light">
        <tr>
          <th>Fecha</th>
          <th>Usuario</th>
          <th>Acción</th>
          <th>Objeto</th>
          <th>ID</th>
          <th>Campo</th>
          <th>Antes</th>
          <th>Después</th>
        </tr>
      </thead>
      <tbody>
        <!-- Contenido generado por JS -->
      </tbody>
    </table>
  </div>

  <nav id="contenedor-paginacion" aria-label="Paginación de auditoría">
    <!-- Paginación generada por JS -->
  </nav>
</div>

<!-- Librería html2pdf.js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js" integrity="sha512-GsLlZN/3F2ErC5ifS5QtgpiJtWd43JWSuIgh7mbzZ8zBps+dvLusV+eNQATqgA/HdeKFVgA5v3S/cIrLF7QnIg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="../js/auditoria.panel.js"></script>
</body>
</html>