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
  <link rel="stylesheet" href="../css/global.css?v=1.0">
<link rel="stylesheet" href="../css/auditoria.css?v=1.0">
</head>
<body>
<div class="zona-superior">
  <h2 class="titulo-modulo">Auditoría</h2>
  <a href="grilla.php" class="btn-volver">Volver a la grilla</a>
</div>
  <form id="filtros-auditoria" class="bloque-filtros">
    <label>Usuario:
      <input type="text" name="usuario" placeholder="Ej: admin">
    </label>
    <label>Tipo:
      <select name="tipo">
        <option value="">Todos</option>
        <option value="asignacion">Asignación</option>
        <option value="entidad">Entidad</option>
      </select>
    </label>
    <label>Acción:
      <select name="accion">
        <option value="">Todas</option>
        <option value="alta">Alta</option>
        <option value="baja">Baja</option>
        <option value="modificacion">Modificación</option>
      </select>
    </label>
    <label>Desde:
      <input type="date" name="desde">
    </label>
    <label>Hasta:
      <input type="date" name="hasta">
    </label>
    <button type="submit">Filtrar</button>
  </form>

  <table id="tabla-auditoria">
    <thead>
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
    <tbody></tbody>
  </table>

  <script src="../js/auditoria.panel.js"></script>
</body>
</html>