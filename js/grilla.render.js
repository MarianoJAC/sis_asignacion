import { renderLeyenda } from './grilla.eventos.js';
import { mostrarMensaje } from './grilla.alertas.js';
import { rangoTurno, convertirAHora, minutosAHora, getFechasSemanaCompleta, calcularDisponibilidad, formatearFecha } from './grilla.validaciones.js';
import { normalizarFecha } from './grilla.filtros.js';

const iconoRecurso = {
  'Proyector': '<i class="fas fa-video"></i>',
  'TV': '<i class="fas fa-tv"></i>',
  'Ninguno': '<i class="fas fa-ban"></i>'
};

export function renderGrilla(turnoSeleccionado, datos = window.datosGlobales, aulaIdFiltrada = null, targetId = null, fechaFiltrada = null) {
  if (window.modoExtendido && !targetId) return;

  if (!datos || !datos.aulas || !datos.asignaciones) {
    mostrarMensaje('error', 'Los datos aún no están cargados');
    return;
  }

  const ocultarColumnaAula = aulaIdFiltrada && targetId !== 'principal';
  const { aulas, asignaciones } = datos;

  const fechasUnicas = fechaFiltrada
    ? [normalizarFecha(fechaFiltrada)]
    : getFechasSemanaCompleta();

  if (fechasUnicas.length === 0) {
    mostrarMensaje('info', 'No hay asignaciones de lunes a sábado para este turno');
    return;
  }

  const filtradas = asignaciones.filter(a =>
    a.turno === turnoSeleccionado &&
    (!aulaIdFiltrada || a.aula_id == aulaIdFiltrada)
  );

  const grid = {};
  filtradas.forEach(a => {
    const fechaNorm = normalizarFecha(a.fecha);
    if (!grid[a.aula_id]) grid[a.aula_id] = {};
    if (!grid[a.aula_id][fechaNorm]) grid[a.aula_id][fechaNorm] = [];
    grid[a.aula_id][fechaNorm].push(a);
  });

  const aulasFiltradas = aulaIdFiltrada
    ? aulas.filter(a => a.aula_id == aulaIdFiltrada)
    : aulas;

  // ✅ Fallback seguro para targetId
  if (!targetId) {
    if (aulaIdFiltrada) {
      targetId = 'grilla-extendida';
    } else {
      targetId = 'grilla-container'; // fallback principal
    }
  }

  const contenedor = document.getElementById(targetId);
  if (!contenedor) {
    console.error(`[RENDER] Contenedor con id "${targetId}" no encontrado`);
    return;
  }
  contenedor.innerHTML = '';

  const table = document.createElement('table');
  table.className = 'grid-table';

  let thead = '<thead><tr>';
  if (!ocultarColumnaAula) thead += '<th>Aula</th>';
  fechasUnicas.forEach(fecha => {
    thead += `<th>${formatearFecha(fecha)}</th>`;
  });
  thead += '</tr></thead>';
  table.innerHTML = thead;

  const tbody = document.createElement('tbody');

  aulasFiltradas.forEach(aula => {
    const tr = document.createElement('tr');

    if (!ocultarColumnaAula) {
      const tdAula = document.createElement('td');
      tdAula.textContent = aula.nombre;
      if (aula.recurso) tdAula.innerHTML += ` ${iconoRecurso[aula.recurso] || ''}`;
      if (aula.capacidad) tdAula.innerHTML += ` (${aula.capacidad})`;
      tr.appendChild(tdAula);
    }

    fechasUnicas.forEach(fecha => {
      const td = document.createElement('td');
      td.className = 'celda-asignacion';
      const asignacionesDia = grid[aula.aula_id]?.[fecha] || [];
      if (asignacionesDia.length > 0) {
        asignacionesDia.forEach(asig => {
          const div = document.createElement('div');
          div.className = 'asignacion';
          div.style.backgroundColor = asig.color_entidad;
          div.innerHTML = `
            <strong>${asig.materia}</strong>
            <span>${asig.profesor}</span>
            <span>${asig.hora_inicio.slice(0,5)} - ${asig.hora_fin.slice(0,5)}</span>
          `;
          if (asig.comentarios) {
            div.innerHTML += `<div class="comentario-wrapper"><a class="comentario-toggle">Comentario</a><div class="comentario-flotante">${asig.comentarios}</div></div>`;
          }
          if (window.isAdmin) {
            div.innerHTML += `
              <div class="acciones-celda">
                <button class="btn-editar-asignacion" data-aula="${aula.aula_id}" data-fecha="${fecha}" data-turno="${turnoSeleccionado}" data-id="${asig.Id}">✏️</button>
                <button class="btn-eliminar-asignacion" data-aula="${aula.aula_id}" data-fecha="${fecha}" data-turno="${turnoSeleccionado}" data-id="${asig.Id}">❌</button>
              </div>
            `;
          }
          td.appendChild(div);
        });
      } else {
        const disponibilidad = calcularDisponibilidad(turnoSeleccionado, []);
        td.innerHTML = `
          <div class="disponible-wrapper">
            <span class="disponible-label">Disponible</span>
            <div class="disponible-detalle">${disponibilidad}</div>
          </div>
        `;
        if (window.isAdmin) {
          td.innerHTML += `
            <div class="acciones-celda">
              <button class="btn-agregar" data-aula="${aula.aula_id}" data-fecha="${fecha}" data-turno="${turnoSeleccionado}">➕</button>
            </div>
          `;
        }
      }
      tr.appendChild(td);
    });
    tbody.appendChild(tr);
  });

  table.appendChild(tbody);
  contenedor.appendChild(table);
}

export function actualizarGrilla(turno, aulaId = null, fecha = null) {
  console.log('[FLOW] Actualizando grilla para:', { turno, aulaId, fecha });
  if (!window.forceRender && window.yaRenderizado) {
    console.log('[FLOW] Grilla ya renderizada, saltando actualización');
    return;
  }
  window.yaRenderizado = true;
  fetch(`acciones/get_grilla.php?turno=${turno}`)
    .then(res => {
      if (!res.ok) {
        throw new Error(`Error en get_grilla: ${res.status} ${res.statusText}`);
      }
      return res.json();
    })
    .then(data => {
      console.log('[FLOW] Datos de grilla recibidos:', data);
      if (!data.aulas || !Array.isArray(data.aulas)) {
        throw new Error('No se recibieron aulas válidas');
      }
      window.datosGlobales = data;
      if (aulaId !== null) {
        renderGrilla(turno, data, aulaId, null, fecha);
      } else {
        renderGrilla(turno, data, null, null, fecha);
      }
      renderLeyenda();
    })
    .catch(err => {
      console.error('[FLOW] Error al actualizar grilla:', err);
      mostrarMensaje('error', 'No se pudo actualizar la grilla');
    });
}

export function actualizarVisibilidadFiltros() {
  const mostrar = !window.modoExtendido;

  const filtroFecha = document.getElementById('contenedor-fecha');
  const buscador = document.getElementById('input-buscador');
  const btnResetFecha = document.getElementById('btn-reset-fecha');

  if (filtroFecha) filtroFecha.style.display = mostrar ? 'block' : 'none';
  if (buscador) buscador.style.display = mostrar ? 'inline-block' : 'none';
  if (btnResetFecha) btnResetFecha.style.display = mostrar ? 'inline-block' : 'none';

  console.log(`[UI] Layout actualizado: filtros ${mostrar ? 'visibles' : 'ocultos'} según modo ${window.modoExtendido ? 'extendido' : 'institucional'}`);
}

export function cargarAsignacionesPorAulaTodosLosTurnos(aulaId) {
  ['Matutino', 'Vespertino', 'Nocturno'].forEach(turno => {
    renderGrilla(turno, window.datosGlobales, aulaId, `grilla-${turno.toLowerCase()}`);
  });
}

export function renderVistaGeneral() {
  console.log('[RENDER] Renderizando vista general');
  if (typeof cargarVistaInstitucional === 'function') {
    cargarVistaInstitucional();
  } else {
    console.warn('[RENDER] cargarVistaInstitucional no definida, cargando datos manualmente');
    fetch('acciones/get_grilla.php')
      .then(res => {
        if (!res.ok) throw new Error(`Error en get_grilla: ${res.status} ${res.statusText}`);
        return res.json();
      })
      .then(data => {
        window.datosGlobales = data;
        ['Matutino', 'Vespertino', 'Nocturno'].forEach(turno => {
          renderGrilla(turno, data);
        });
        renderLeyenda();
      })
      .catch(err => {
        console.error('[RENDER] Error al cargar vista general:', err);
        mostrarMensaje('error', 'No se pudo cargar la vista general');
      });
  }
}

export function renderVistaExtendida(aulaId) {
  console.log(`[FLOW] Renderizando vista extendida para aula ${aulaId}`);

  // 🔁 Activar modo extendido
  window.modoExtendido = true;
  window.aulaSeleccionada = aulaId;

  // 🧼 Limpieza visual previa
  const selectorFecha = document.getElementById('selector-fecha');
  if (selectorFecha) selectorFecha.value = '';

  const inputBuscador = document.getElementById('input-buscador');
  if (inputBuscador) inputBuscador.value = '';

  const leyenda = document.getElementById('leyenda-dinamica');
  if (leyenda) leyenda.innerHTML = '';

  const modal = document.querySelector('.modal');
  if (modal) modal.remove();

  // 🔄 Mantener turno activo
  const turno = document.querySelector('.tab-btn.active')?.dataset.turno || 'Matutino';

  // 🔄 Render extendido
  actualizarGrilla(turno, aulaId);
  actualizarVisibilidadFiltros();
}

export function cargarAsignacionesPorAula(aulaId, turno = 'Matutino') {
  console.log('[RENDER] Cargando asignaciones para aula:', aulaId, 'turno:', turno);
  actualizarGrilla(turno, aulaId);
}
