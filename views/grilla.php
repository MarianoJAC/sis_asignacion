<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Grilla de Asignaciones</title>

  <!-- 🧼 Estilos institucionales -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="../css/variables.css?v=1.3">
  <link rel="stylesheet" href="../css/global.css?v=1.3">
  <link rel="stylesheet" href="../css/main.css?v=1.0">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

  <!-- 🧠 Ícono institucional (opcional) -->
  <link rel="icon" href="../iconos/calendario.ico" type="image/x-icon">
</head>
<body>
<?php
session_start();
$esAdmin = isset($_SESSION['role']) && $_SESSION['role'] === 'admin';
$usuario = $_SESSION['username'] ?? 'Usuario';
?>

<div id="zona-controles" class="zona-controles">
  <div class="zona-superior">
    <h2>Asignaciones CRUI</h2>
    <div class="menu-hamburguesa">
      <button id="btn-menu"><i class="fas fa-bars"></i></button>
      <div id="menu-desplegable" class="menu-oculto">
        <div class="menu-usuario">👤 <?= htmlspecialchars($usuario) ?></div>
        <?php if ($esAdmin): ?>
          <a href="auditoria_panel.php">🛡️ Auditoría</a>
          <a href="reservas.php">📋 Ver Reservas</a>
          <a href="configuracion.php">⚙️ Configuración</a>
        <?php endif; ?>
        <a href="asignacionesTurnoActual.php">🕒 Turno Actual</a>
        <a href="../acciones/logout.php">🔓 Cerrar sesión</a>
      </div>
    </div>
  </div>

  <div class="zona-leyenda">
  <div class="leyenda-row" id="leyenda-dinamica"></div>
  <?php if ($esAdmin): ?>
  <div class="acciones-entidad">
    <button class="btn-agregar btn-entidad" id="btn-agregar-entidad">➕</button>
    <button class="btn-eliminar btn-entidad" id="btn-eliminar-entidad">❌</button>
  </div>
<?php endif; ?>
</div>


<div class="zona-filtros-turno">
  <!-- 🕒 Botones de turno -->
  <div class="bloque-turnos">
    <button class="tab-btn" data-turno="Matutino">Matutino</button>
    <button class="tab-btn" data-turno="Vespertino">Vespertino</button>
    <button class="tab-btn" data-turno="Nocturno">Nocturno</button>
    <a href="pisos.php"><button class="tab-btn" id="almapa">Al Mapa</button></a>
    <button class="tab-btn" id="btn-ver-todas">Todas las Aulas</button>
  </div>

  <div id="bloque-filtro-fecha" class="bloque-desplegable">
  <button id="toggle-filtros" class="btn-desplegable">📅 Filtrar</button>

  <div id="contenedor-filtros" class="contenedor-oculto">
    <!-- 🔍 Buscador de aula -->
    <div class="filtro-buscador">
      <label for="input-buscador"><strong>Buscar:</strong></label>
      <input type="text" id="input-buscador" class="input-buscador" placeholder="Ej: Proyector, TV.." />
    </div>
    <!-- 🗓️ Selector de fecha -->
    <div class="filtro-fecha">
      <label for="selector-fecha"><strong>Fecha:</strong></label>
      <input type="date" id="selector-fecha" class="selector-fecha" />
      <button id="btn-reset-fecha" class="btn-reset-fecha">🧹 Limpiar</button>
    </div>
  </div>
</div>
</div>

  <!-- 🟡 Comentario flotante -->
  <div id="comentario-global" class="comentario-flotante"></div>

  <!-- 🟢 Contenedor principal -->
  <div id="grilla-container">Cargando grilla...</div>

  <!-- Bootstrap Modal -->
  <div class="modal fade" id="main-modal" tabindex="-1" aria-labelledby="main-modal-label" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="main-modal-label"></h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body" id="main-modal-body">
          <!-- Contenido del formulario se inyectará aquí -->
        </div>
      </div>
    </div>
  </div>

 <!-- 🧠 Scripts modulares (orden blindado) -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
  window.esAdmin = <?= json_encode($esAdmin) ?>;
</script>


<!-- Núcleo primero: define datosGlobales -->
<script type="module" src="../js/grilla.core.js"></script>
<script type="module">

import {
  cargarAsignacionesPorAula,
  cargarAsignacionesPorAulaTodosLosTurnos,
  actualizarGrilla
} from '../js/grilla.render.js';



const params = new URLSearchParams(window.location.search);
const aulaId = params.get('aula_id');
const origen = params.get('origen');
window.aulaSeleccionada = aulaId || null;

if (aulaId) {
  console.log('🧭 Aula seleccionada:', aulaId, '| Origen:', origen);
  if (origen === 'mapa') {
    cargarAsignacionesPorAulaTodosLosTurnos(aulaId); // 🧩 render extendido
  } else {
    cargarAsignacionesPorAula(aulaId); // ✅ comportamiento normal
  }
}

  // 🧠 Interceptar clicks de pestañas
  document.querySelectorAll('.tab-btn').forEach(btn => {
    btn.addEventListener('click', () => {
      const turno = btn.dataset.turno;
      if (turno) {
        actualizarGrilla(turno); // ✅ mantiene el aula seleccionada
      }
    });
  });
</script>
</body>
</html>