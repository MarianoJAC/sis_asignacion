import {
  renderGrilla,
  cargarAsignacionesPorAula,
  cargarAsignacionesPorAulaTodosLosTurnos,
  actualizarVisibilidadFiltros,
  actualizarGrilla,
  renderVistaGeneral
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
    menuDesplegable.classList.toggle('menu-visible');
  });

  document.addEventListener('click', (e) => {
    if (!menuDesplegable.contains(e.target) && !btnMenu.contains(e.target)) {
      menuDesplegable.classList.remove('menu-visible');
    }
  });
}

// Notificaciones de nuevas reservas para administradores
if (window.esAdmin) {
  const notificacionReservasBadge = document.getElementById('notificacion-reservas');
  const globitoNotificacion = document.getElementById('globito-notificacion');
  let newReservationsCount = 0;
  let currentNewReservationIds = []; // Para almacenar los IDs de las reservas nuevas

  const updateNotificationBadge = () => {
    if (newReservationsCount > 0) {
      notificacionReservasBadge.textContent = newReservationsCount;
      notificacionReservasBadge.classList.add('visible');
      globitoNotificacion.classList.add('visible');
    } else {
      notificacionReservasBadge.textContent = '';
      notificacionReservasBadge.classList.remove('visible');
      globitoNotificacion.classList.remove('visible');
    }
  };

  const fetchNewReservations = async () => {
    try {
      const response = await fetch('../acciones/get_nuevas_reservas.php');
      const result = await response.json();
      console.log('Nuevas reservas:', result);

      if (result.ok && result.data.length > 0) {
        newReservationsCount = result.data.length;
        currentNewReservationIds = result.data.map(reserva => reserva.id);
        updateNotificationBadge();
      } else if (result.ok && result.data.length === 0) {
        newReservationsCount = 0;
        currentNewReservationIds = [];
        updateNotificationBadge();
      }
    } catch (error) {
      console.error('Error al obtener nuevas reservas:', error);
    }
  };

  // Ejecutar al cargar y luego cada 30 segundos
  fetchNewReservations();
  setInterval(fetchNewReservations, 1800000); // 30 minutos

  // Resetear contador y ocultar badge al hacer clic en 'Ver Reservas'
  const verReservasLink = document.querySelector('#menu-desplegable a[href="reservas.php"]');
  if (verReservasLink) {
    verReservasLink.addEventListener('click', async (e) => {
      // Marcar las reservas como vistas en la base de datos
      if (currentNewReservationIds.length > 0) {
        try {
          await fetch('../acciones/marcar_reservas_vistas.php', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
            },
            body: JSON.stringify({ reserva_ids: currentNewReservationIds }),
          });
        } catch (error) {
          console.error('Error al marcar reservas como vistas:', error);
        }
      }
      newReservationsCount = 0;
      currentNewReservationIds = [];
      updateNotificationBadge();
      // Permitir la navegación normal
    });
  }
}

document.addEventListener('click', (e) => {
    if (e.target && e.target.id === 'btn-salir-extendido') {
        e.preventDefault();
        document.body.classList.remove('modo-extendido');
        const breadcrumbContainer = document.getElementById('breadcrumb-container');
        if (breadcrumbContainer) {
            breadcrumbContainer.innerHTML = '';
        }
        renderVistaGeneral();
    }
});