import {
  renderGrilla,
  cargarAsignacionesPorAula,
  cargarAsignacionesPorAulaTodosLosTurnos,
  actualizarVisibilidadFiltros,
  actualizarGrilla
} from './grilla.render.js';

import {
  ejecutarBusqueda,
  activarFiltroPorFecha,
  limpiarFiltrosYRestaurar
} from './grilla.filtros.js';

import './grilla.eventos.js';
import './grilla.formularios.js';
import './grilla.modales.js';
import './grilla.alertas.js';
import './grilla.validaciones.js';

import { mostrarMensaje } from './grilla.alertas.js';
import { renderLeyenda } from './grilla.eventos.js';

window.yaRenderizado = false;
window.modoExtendido = false;

document.addEventListener('DOMContentLoaded', () => {
  console.log('[INIT] DOMContentLoaded');

  const params = new URLSearchParams(window.location.search);
  const aulaId = parseInt(params.get('aula_id') || '0');
  const origen = params.get('origen') || '';

  console.log('[PARAMS] aulaId:', aulaId, 'origen:', origen);

  if (aulaId > 0 && origen === 'mapa') {
    console.log('[FLOW] Carga extendida desde mapa');
    window.aulaSeleccionada = aulaId;
    window.modoExtendido = true;
    window.yaRenderizado = true;

    actualizarVisibilidadFiltros();
    cargarAsignacionesPorAulaTodosLosTurnos(aulaId);
    document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));
    history.replaceState(null, '', 'index.html');
    return;
  }

  if (aulaId > 0) {
    console.log('[FLOW] Carga directa por aulaId:', aulaId);
    window.aulaSeleccionada = aulaId;
    cargarAsignacionesPorAula(aulaId);
    return;
  }

  cargarVistaInstitucional();
  // ✅ Activación dinámica de pestañas de turno
document.querySelectorAll('.tab-btn[data-turno]').forEach(btn => {
  btn.addEventListener('click', () => {
    // 🔄 Reset de clase activa
    document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
    btn.classList.add('active');

    const turno = btn.dataset.turno;
    window.forceRender = true; // 🔁 fuerza render aunque sea el mismo turno
    actualizarGrilla(turno);
  });
});
});

// ✅ Función blindada para vista institucional
function cargarVistaInstitucional() {
  console.log('[FLOW] Cargando vista institucional');

  window.modoExtendido = false;
  window.aulaSeleccionada = null;
  window.yaRenderizado = false;

  actualizarVisibilidadFiltros();

  const turno = 'Matutino';

  fetch('acciones/get_grilla.php')
    .then(async res => {
      const texto = await res.text();
      try {
        const data = JSON.parse(texto);
        if (!data.aulas || data.aulas.length === 0) throw new Error();
        window.datosGlobales = data;
        renderGrilla(turno, data);
        renderLeyenda();
        activarFiltroPorFecha();
      } catch (err) {
        console.error('[ERROR] Falló el render institucional:', err);
        mostrarMensaje('error', 'Error al procesar la grilla');
      }
    })
    .catch(err => {
      console.error('[ERROR] Falló el fetch de grilla:', err);
      mostrarMensaje('error', 'No se pudo cargar la grilla inicial');
    });
}

// ✅ Buscador de aulas
let buscadorTimeout;
document.getElementById('input-buscador')?.addEventListener('input', e => {
  clearTimeout(buscadorTimeout);
  buscadorTimeout = setTimeout(() => {
    const textoOriginal = e.target.value.trim();
    const texto = textoOriginal.toLowerCase().normalize('NFD').replace(/[\u0300-\u036f]/g, '');
    const turno = document.querySelector('.tab-btn.active')?.dataset.turno || 'Matutino';
    ejecutarBusqueda(texto, turno);
  }, 300);
});

// ✅ Toggle de fecha
document.getElementById('toggle-fecha')?.addEventListener('click', () => {
  const contenedor = document.getElementById('contenedor-fecha');
  if (contenedor) {
    contenedor.classList.toggle('contenedor-oculto');
    contenedor.classList.toggle('contenedor-visible');
  }
});

// ✅ Reset de filtro de fecha
document.getElementById('btn-reset-fecha')?.addEventListener('click', () => {
  const selector = document.getElementById('selector-fecha');
  const buscador = document.getElementById('input-buscador');

  // 🧹 Limpiar fecha
  if (selector) selector.value = '';

  // 🧹 Limpiar buscador
  if (buscador) buscador.value = '';

  // 🔄 Disparar restauración completa
  const turno = document.querySelector('.tab-btn.active')?.dataset.turno || 'Matutino';
  limpiarFiltrosYRestaurar(turno);
});

