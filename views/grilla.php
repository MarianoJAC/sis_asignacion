<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
$esAdmin = isset($_SESSION['role']) && $_SESSION['role'] === 'admin';
$usuario = $_SESSION['username'] ?? 'Usuario';
?>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Grilla de Asignaciones</title>

  <!-- 🧼 Estilos institucionales -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="../css/variables.css?v=1.3">
  <link rel="stylesheet" href="../css/global.css?v=2.9">
    <link rel="stylesheet" href="../css/main.css?v=1.0">
    <link rel="stylesheet" href="../css/leyenda.css?v=1.0">
  <link rel="stylesheet" href="../css/mapa.css?v=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

  <!-- 🧠 Ícono institucional (opcional) -->
  <link rel="icon" href="../iconos/calendario.ico" type="image/x-icon">
</head>
<body>
<div id="leyenda-lateral">
    <div id="leyenda-lateral-toggle">ENTIDADES</div>
    <div id="leyenda-lateral-contenido">
      <!-- El contenido de la leyenda se generará aquí -->
    </div>
</div>

<div id="mapa-lateral">
    <div id="mapa-lateral-toggle">MAPA</div>
    <div id="mapa-lateral-contenido">
        <iframe src="pisos_content.php" frameborder="0"></iframe>
    </div>
</div>
<div class="grilla-main-wrapper">
<div id="zona-controles" class="zona-controles">
  <div class="barra-controles">
    <div class="menu-hamburguesa">
      <button id="btn-menu"><span id="globito-notificacion" class="globito-notificacion"></span><img src="../iconos/menuhamburguesa.png" alt="Menú" class="hamburger-icon"></button>
    </div>
    <div id="breadcrumb-container"></div>

    <!-- 🕒 Botones de turno -->
    <div class="bloque-turnos">
      <button class="tab-btn btn btn-outline-primary" data-turno="Matutino">Matutino</button>
      <button class="tab-btn btn btn-outline-primary" data-turno="Vespertino">Vespertino</button>
      <button class="tab-btn btn btn-outline-primary" data-turno="Nocturno">Nocturno</button>
    </div>

    <div id="contenedor-filtros">
      <!-- 🔍 Buscador de aula -->
      <div class="filtro-buscador">
        <label for="input-buscador"><strong>Buscar:</strong></label>
        <input type="text" id="input-buscador" class="input-buscador" placeholder="Ej: Proyector, TV.." />
      </div>
      <!-- 🗓️ Selector de fecha -->
      <div class="filtro-fecha">
        <label for="selector-fecha"><strong>Fecha:</strong></label>
        <input type="date" id="selector-fecha" class="selector-fecha" />
        <button id="btn-reset-fecha" class="btn-reset-fecha" style="background: none; border: none;"><img src="../iconos/limpiafiltro.png" alt="Limpiar Filtro" style="width: 30px; height: 30px;"></button>
      </div>
    </div>
  </div>

  <div id="menu-desplegable" class="menu-oculto">

      <div class="menu-usuario"><img src="../iconos/usuario.png" alt="Usuario" class="menu-item-icon menu-usuario-icon"> <?= htmlspecialchars($usuario) ?></div>

      <?php if ($esAdmin): ?>

        <a href="auditoria_panel.php"><img src="../iconos/auditoria.png" alt="Auditoría" class="menu-item-icon"> Auditoría</a>

        <a href="reservas.php"><img src="../iconos/reservas.png" alt="Ver Reservas" class="menu-item-icon"> Ver Reservas <span id="notificacion-reservas" class="badge-notificacion"></span></a>

        <a href="configuracion.php"><img src="../iconos/configuracion.png" alt="Configuración" class="menu-item-icon"> Configuración</a>

      <?php endif; ?>

      <a href="asignacionesTurnoActual.php"><img src="../iconos/turnoactual.png" alt="Turno Actual" class="menu-item-icon"> Turno Actual</a>

      <a href="../acciones/logout.php"><img src="../iconos/cerrarsesion.png" alt="Cerrar Sesión" class="menu-item-icon"> Cerrar sesión</a>

    </div>

  <!-- 🟡 Comentario flotante -->
  <div id="comentario-global" class="comentario-flotante"></div>

  <!-- 🟢 Contenedor principal -->
  <div id="grilla-container">Cargando grilla...</div>
</div>

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