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

import {
  inputBuscador, selectorFecha, btnResetFecha, toggleFiltrosBtn, contenedorFiltros, tabButtons, btnMenu, menuDesplegable
} from './grilla.dom.js';

import './grilla.eventos.js';
import './grilla.formularios.js';
import './grilla.modales.js';
import './grilla.alertas.js';
import { preprocesarAsignaciones } from './grilla.validaciones.js';
import { mostrarMensaje } from './grilla.alertas.js';
import { renderLeyenda } from './grilla.eventos.js';
import { getState, setState } from './grilla.state.js';

document.addEventListener('DOMContentLoaded', () => {
  const params = new URLSearchParams(window.location.search);
  const aulaId = parseInt(params.get('aula_id') || '0');
  const origen = params.get('origen') || '';

  if (aulaId > 0 && origen === 'mapa') {
    setState({ aulaSeleccionada: aulaId, modoExtendido: true, yaRenderizado: true });
    actualizarVisibilidadFiltros();
    cargarAsignacionesPorAulaTodosLosTurnos(aulaId);
    tabButtons.forEach(btn => btn.classList.remove('active'));
    history.replaceState(null, '', 'grilla.php');
    return;
  }

  if (aulaId > 0) {
    setState({ aulaSeleccionada: aulaId });
    cargarAsignacionesPorAula(aulaId);
    return;
  }

  cargarVistaInstitucional();

  tabButtons.forEach(btn => {
    if(btn.dataset.turno) { // Only apply to turn buttons
      btn.addEventListener('click', () => {
        tabButtons.forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
        const turno = btn.dataset.turno;
        setState({ forceRender: true });
        actualizarGrilla(turno);
      });
    }
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

function cargarVistaInstitucional() {
  setState({ modoExtendido: false, aulaSeleccionada: null, yaRenderizado: false });
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

let buscadorTimeout;
inputBuscador?.addEventListener('input', e => {
  clearTimeout(buscadorTimeout);
  buscadorTimeout = setTimeout(() => {
    const textoOriginal = e.target.value.trim();
    const texto = textoOriginal.toLowerCase().normalize('NFD').replace(/[\u0300-\u036f]/g, '');
    const turno = document.querySelector('.tab-btn.active')?.dataset.turno || 'Matutino';
    ejecutarBusqueda(texto, turno);
  }, 300);
});

toggleFiltrosBtn?.addEventListener('click', () => {
  if (contenedorFiltros) {
    contenedorFiltros.classList.toggle('contenedor-oculto');
    contenedorFiltros.classList.toggle('contenedor-visible');
    const rectBoton = toggleFiltrosBtn.getBoundingClientRect();
    const espacioIzquierda = rectBoton.left;
    if (espacioIzquierda < 320) {
      contenedorFiltros.style.right = 'auto';
      contenedorFiltros.style.left = '0';
    } else {
      contenedorFiltros.style.right = 'calc(100% + 20px)';
      contenedorFiltros.style.left = 'auto';
    }
  }
});

btnResetFecha?.addEventListener('click', () => {
  if (selectorFecha) selectorFecha.value = '';
  if (inputBuscador) inputBuscador.value = '';
  const turno = document.querySelector('.tab-btn.active')?.dataset.turno || 'Matutino';
  limpiarFiltrosYRestaurar(turno);
});

if (btnMenu && menuDesplegable) {
  btnMenu.addEventListener('click', () => {
    const visible = menuDesplegable.style.display === 'block';
    menuDesplegable.style.display = visible ? 'none' : 'block';
  });

  document.addEventListener('click', (e) => {
    if (!menuDesplegable.contains(e.target) && !btnMenu.contains(e.target)) {
      menuDesplegable.style.display = 'none';
    }
  });
}