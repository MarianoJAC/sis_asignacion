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
import { preprocesarAsignaciones } from './grilla.validaciones.js';

import { mostrarMensaje } from './grilla.alertas.js';
import { renderLeyenda } from './grilla.eventos.js';
import { getState, setState } from './grilla.state.js';

document.addEventListener('DOMContentLoaded', () => {
  console.log('[INIT] DOMContentLoaded');

  const params = new URLSearchParams(window.location.search);
  const aulaId = parseInt(params.get('aula_id') || '0');
  const origen = params.get('origen') || '';

  console.log('[PARAMS] aulaId:', aulaId, 'origen:', origen);

  if (aulaId > 0 && origen === 'mapa') {
    console.log('[FLOW] Carga extendida desde mapa');
    setState({
      aulaSeleccionada: aulaId,
      modoExtendido: true,
      yaRenderizado: true,
    });

    actualizarVisibilidadFiltros();
    cargarAsignacionesPorAulaTodosLosTurnos(aulaId);
    document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));
    history.replaceState(null, '', 'grilla.php');
    return;
  }

  if (aulaId > 0) {
    console.log('[FLOW] Carga directa por aulaId:', aulaId);
    setState({ aulaSeleccionada: aulaId });
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
    setState({ forceRender: true }); // 🔁 fuerza render aunque sea el mismo turno
    actualizarGrilla(turno);
  });
});
});

export function fetchGrillaData() {
  return fetch('../acciones/get_grilla.php')
    .then(res => res.json())
    .then(data => {
      if (!data.aulas || data.aulas.length === 0) {
        throw new Error('No se han cargado aulas globalmente');
      }
      setState({ datosGlobales: data });
      preprocesarAsignaciones(data.asignaciones);
      return data;
    });
}

// ✅ Función blindada para vista institucional
function cargarVistaInstitucional() {
  console.log('[FLOW] Cargando vista institucional');

  setState({
    modoExtendido: false,
    aulaSeleccionada: null,
    yaRenderizado: false,
  });

  actualizarVisibilidadFiltros();

  const turno = 'Matutino';

  fetchGrillaData()
    .then(data => {
      renderGrilla(turno, data);
      renderLeyenda();
      activarFiltroPorFecha();
    })
    .catch(err => {
      mostrarMensaje('error', 'Error al procesar la grilla: ' + err.message);
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

// ✅ Toggle de filtros unificados
document.getElementById('toggle-filtros')?.addEventListener('click', () => {
  const contenedor = document.getElementById('contenedor-filtros');
  const boton = document.getElementById('toggle-filtros');

  if (contenedor && boton) {
    contenedor.classList.toggle('contenedor-oculto');
    contenedor.classList.toggle('contenedor-visible');

    // 🧠 Reposicionamiento dinámico si se sale del viewport
 const rectBoton = boton.getBoundingClientRect();
const espacioIzquierda = rectBoton.left;

if (espacioIzquierda < 320) {
  contenedor.style.right = 'auto';
  contenedor.style.left = '0'; // ⏪ lo pega al borde izquierdo si no hay espacio
} else {
  contenedor.style.right = 'calc(100% + 20px)';
  contenedor.style.left = 'auto';
}


    console.log('[EVENT] Toggle filtros activado');
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

// ✅ Menú hamburguesa desplegable
const btnMenu = document.getElementById('btn-menu');
const menuDesplegable = document.getElementById('menu-desplegable');

if (btnMenu && menuDesplegable) {
  btnMenu.addEventListener('click', () => {
    const visible = menuDesplegable.style.display === 'block';
    menuDesplegable.style.display = visible ? 'none' : 'block';
  });

  // 🧠 Cierre automático al hacer clic fuera
  document.addEventListener('click', (e) => {
    if (!menuDesplegable.contains(e.target) && !btnMenu.contains(e.target)) {
      menuDesplegable.style.display = 'none';
    }
  });
  
}


