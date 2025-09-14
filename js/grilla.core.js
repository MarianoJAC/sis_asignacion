import {
  renderGrilla,
  cargarAsignacionesPorAula,
  cargarAsignacionesPorAulaTodosLosTurnos,
  renderGrillaTodosLosTurnos,
  actualizarGrilla,
  filtrarGrillaPorFecha
} from './grilla.render.js';

import './grilla.eventos.js';
import './grilla.formularios.js';
import './grilla.modales.js';
import './grilla.alertas.js';
import './grilla.validaciones.js';

import { mostrarMensaje } from './grilla.alertas.js';
import { renderLeyenda } from './grilla.eventos.js';

let yaRenderizado = false;
window.modoExtendido = false;

document.addEventListener('DOMContentLoaded', () => {
  const params = new URLSearchParams(window.location.search);
  const aulaId = parseInt(params.get('aula_id') || '0');
  const origen = params.get('origen') || '';

if (aulaId > 0 && origen === 'mapa') {
  window.aulaSeleccionada = aulaId;
  window.modoExtendido = true;
  cargarAsignacionesPorAulaTodosLosTurnos(aulaId);
  document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));
  history.replaceState(null, '', 'index.html');
  return; // ✅ este return es clave
}

  if (aulaId > 0) {
    console.log('📌 Entrando desde parámetro aulaId directo:', aulaId);

    window.aulaSeleccionada = aulaId;
    cargarAsignacionesPorAula(aulaId);
    return;
  }

  fetch('acciones/get_grilla.php')
    .then(async res => {
      const texto = await res.text();
      try {
        const json = JSON.parse(texto);
        return json;
      } catch {
        throw new Error('Respuesta no válida del servidor');
      }
    })
    .then(data => {
      if (yaRenderizado) return;
      yaRenderizado = true;

      try {
        window.datosGlobales = data;
        if (!data.aulas || data.aulas.length === 0) {
          throw new Error('No se recibieron aulas desde el backend');
        }
        renderGrilla('Matutino', data);
        renderLeyenda();
      } catch {
        mostrarMensaje('error', 'Error al procesar la grilla');
      }
    })
    .catch(() => {
      mostrarMensaje('error', 'No se pudo cargar la grilla inicial');
    });

  document.getElementById('selector-fecha')?.addEventListener('change', e => {
    const fecha = e.target.value;
    const turno = document.querySelector('.tab-btn.active')?.dataset.turno || 'Matutino';
    filtrarGrillaPorFecha(turno, fecha);
  });

  document.getElementById('toggle-fecha')?.addEventListener('click', () => {
    const contenedor = document.getElementById('contenedor-fecha');
    contenedor.classList.toggle('contenedor-visible');
    contenedor.classList.toggle('contenedor-oculto');
  });

 document.getElementById('btn-reset-fecha')?.addEventListener('click', () => {
  document.getElementById('selector-fecha').value = '';
  const turno = document.querySelector('.tab-btn.active')?.dataset.turno || 'Matutino';

  if (window.modoExtendido) {
    renderGrillaTodosLosTurnos(window.datosGlobales, window.aulaSeleccionada);
  } else {
    actualizarGrilla(turno);
  }
});

  let buscadorTimeout;

  document.getElementById('input-buscador')?.addEventListener('input', e => {
    clearTimeout(buscadorTimeout);

    buscadorTimeout = setTimeout(() => {
      const textoOriginal = e.target.value.trim();
      const texto = textoOriginal.toLowerCase().normalize('NFD').replace(/[\u0300-\u036f]/g, '');
      const turno = document.querySelector('.tab-btn.active')?.dataset.turno || 'Matutino';

 if (!texto) {
  window.aulaSeleccionada = null;
  fetch('acciones/get_grilla.php')
    .then(res => res.json())
    .then(data => {
      window.datosGlobales = data;

      if (window.modoExtendido) {
        renderGrillaTodosLosTurnos(data, null); // ✅ vista extendida general
      } else {
        actualizarGrilla(turno); // ✅ vista simple por turno
      }

      renderLeyenda();
    });
  return;
}

      ejecutarBusqueda(texto, turno);
    }, 300);
  });

  async function ejecutarBusqueda(texto, turno) {
    try {
      const res = await fetch('acciones/buscar_aulas.php', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ texto })
      });

      const data = await res.json();
      if (!data.ok) throw new Error(data.error || 'Error en búsqueda');

      const idsFiltrados = data.aulas.map(a => a.id);
      const asignacionesFiltradas = window.datosGlobales.asignaciones.filter(a =>
        idsFiltrados.includes(a.aula_id)
      );

      const grillaFiltrada = {
        ...window.datosGlobales,
        asignaciones: asignacionesFiltradas,
        aulas: data.aulas
      };

      renderGrilla(turno, grillaFiltrada, null);

      if (asignacionesFiltradas.length === 0) {
        mostrarMensaje('info', 'Se encontraron aulas, pero no tienen asignaciones en este turno');
      }
    } catch {
      mostrarMensaje('error', 'No se pudo realizar la búsqueda');
    }
  }

// Botón para ver la grilla completa
document.getElementById('btn-ver-todas')?.addEventListener('click', () => {
  console.log('🔁 Botón "Ver todas" clickeado');
  console.log('🧼 Limpiando aulaSeleccionada y activando modoExtendido');

  window.aulaSeleccionada = null;
  window.forceRender = true;
  window.modoExtendido = true;

  fetch('acciones/get_grilla.php')
    .then(res => res.json())
    .then(data => {
      console.log('📦 Datos recibidos:', data);
      window.datosGlobales = data;

      const container = document.getElementById('grilla-container');
      container.innerHTML = '';
      console.log('🧹 Contenedor grilla limpiado');

      document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));
      document.querySelector('h2').textContent = 'Grilla Semanal de Asignaciones Marechal (todos los turnos)';

      console.log('🚀 Ejecutando renderGrillaTodosLosTurnos con aulaIdFiltrada = null');
      renderGrillaTodosLosTurnos(data, null);

      renderLeyenda();
      history.replaceState(null, '', 'index.html');
      mostrarMensaje('info', 'Vista completa activada');
    })
    .catch(() => {
      mostrarMensaje('error', 'No se pudo recargar la grilla completa');
    });
});
});