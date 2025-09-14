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

document.addEventListener('DOMContentLoaded', () => {
  const params = new URLSearchParams(window.location.search);
  const aulaId = parseInt(params.get('aula_id') || '0');
  const origen = params.get('origen') || '';

  console.log('🌐 Parámetros detectados:', { aulaId, origen });

  if (aulaId > 0 && origen === 'mapa') {
    console.log('🧭 Render extendido desde mapa | Aula:', aulaId);
    window.aulaSeleccionada = aulaId;

    cargarAsignacionesPorAulaTodosLosTurnos(aulaId); // 🧩 render extendido
    document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active')); // 🧼 desactivar pestañas
    history.replaceState(null, '', 'index.html'); // 🧹 limpiar URL
    return; // 🛡️ evitar render por defecto
  }

  if (aulaId > 0) {
    console.log('🧭 Aula seleccionada:', aulaId);
    window.aulaSeleccionada = aulaId;
    cargarAsignacionesPorAula(aulaId); // ✅ comportamiento normal
    return;
  }

  // 🧩 Render por defecto si no hay aula ni mapa
  fetch('acciones/get_grilla.php')
    .then(async res => {
      const texto = await res.text();
      try {
        const json = JSON.parse(texto);
        return json;
      } catch (err) {
        console.error('❌ Respuesta no válida del servidor:', texto);
        throw new Error('Respuesta no válida del servidor');
      }
    })
    .then(data => {
      if (yaRenderizado) {
        console.log('🛑 Render ignorado: ya ejecutado');
        return;
      }
      yaRenderizado = true;

      try {
        console.log('🧪 Datos recibidos:', data);
        window.datosGlobales = data;

        if (!data.aulas || data.aulas.length === 0) {
          throw new Error('No se recibieron aulas desde el backend');
        }

        renderGrilla('Matutino', data);
        renderLeyenda();
      } catch (err) {
        console.error('❌ Error interno al renderizar:', err);
        mostrarMensaje('error', 'Error al procesar la grilla');
      }
    })
    .catch(err => {
      console.error('❌ Error en fetch:', err);
      mostrarMensaje('error', 'No se pudo cargar la grilla inicial');
    });

    // 🗓️ Interceptar cambio de fecha
document.getElementById('selector-fecha')?.addEventListener('change', e => {
  const fecha = e.target.value;
  const turno = document.querySelector('.tab-btn.active')?.dataset.turno || 'Matutino';

  console.log('📅 Fecha seleccionada:', fecha);
  console.log('🎯 Turno activo:', turno);

  filtrarGrillaPorFecha(turno, fecha);
});

// 🧩 Toggle visual del filtro de fecha
document.getElementById('toggle-fecha')?.addEventListener('click', () => {
  const contenedor = document.getElementById('contenedor-fecha');
  contenedor.classList.toggle('contenedor-visible');
  contenedor.classList.toggle('contenedor-oculto');
  console.log('📂 Toggle filtro de fecha');
});


// 🧹 Botón para limpiar filtro de fecha
document.getElementById('btn-reset-fecha')?.addEventListener('click', () => {
  document.getElementById('selector-fecha').value = '';
  const turno = document.querySelector('.tab-btn.active')?.dataset.turno || 'Matutino';
  actualizarGrilla(turno);
  console.log('🧹 Filtro de fecha limpiado, grilla restaurada');
});

// 🧩 Buscador
let buscadorTimeout;

document.getElementById('input-buscador')?.addEventListener('input', e => {
  clearTimeout(buscadorTimeout);

  buscadorTimeout = setTimeout(() => {
    const textoOriginal = e.target.value.trim();
    const texto = textoOriginal.toLowerCase().normalize('NFD').replace(/[\u0300-\u036f]/g, '');
    const turno = document.querySelector('.tab-btn.active')?.dataset.turno || 'Matutino';

    if (!texto) {
      actualizarGrilla(turno);
      console.log('🔄 Buscador vacío, grilla restaurada');
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

    // 🧩 Mostrar todas las aulas encontradas, aunque no tengan asignaciones
    const asignacionesFiltradas = window.datosGlobales.asignaciones.filter(a =>
      idsFiltrados.includes(a.aula_id)
    );

    const grillaFiltrada = {
  ...window.datosGlobales,
  asignaciones: asignacionesFiltradas,
  aulas: data.aulas // 🧩 solo las aulas encontradas
};

    console.log('🔍 Texto buscado:', texto);
    console.log('📦 Aulas encontradas desde backend:', data.aulas);
    console.log('📦 Asignaciones filtradas (todos los turnos):', asignacionesFiltradas);

    renderGrilla(turno, grillaFiltrada, null);

    if (asignacionesFiltradas.length === 0) {
      mostrarMensaje('info', 'Se encontraron aulas, pero no tienen asignaciones en este turno');
    }
  } catch (err) {
    console.error('❌ Error en búsqueda:', err.message);
    mostrarMensaje('error', 'No se pudo realizar la búsqueda');
  }
}

  // 🧹 Botón para salir del filtro de aula
  document.getElementById('btn-ver-todas')?.addEventListener('click', () => {
    if (window.aulaSeleccionada === null && yaRenderizado) {
      console.log('🛑 Vista completa ya activa');
      return;
    }

    fetch('acciones/get_grilla.php')
      .then(async res => {
        const texto = await res.text();
        try {
          return JSON.parse(texto);
        } catch (err) {
          console.error('❌ Respuesta no válida del servidor:', texto);
          throw new Error('Respuesta no válida del servidor');
        }
      })
      .then(data => {
        window.datosGlobales = data;
        window.aulaSeleccionada = null;
        yaRenderizado = true;

        document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));
        document.querySelector('h2').textContent = 'Grilla Semanal de Asignaciones Marechal';

        renderGrilla('Matutino', data, null);
        renderLeyenda();
        history.replaceState(null, '', 'index.html');
        mostrarMensaje('info', 'Vista completa activada');
        console.log('🧹 Filtro de aula desactivado y grilla recargada');
      })
      .catch(err => {
        console.error('❌ Error al recargar grilla:', err);
        mostrarMensaje('error', 'No se pudo recargar la grilla completa');
      });
  });
});