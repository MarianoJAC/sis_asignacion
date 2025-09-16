import { renderLeyenda } from './grilla.eventos.js';
import { mostrarMensaje } from './grilla.alertas.js';
import { rangoTurno, convertirAHora, minutosAHora, getFechasSemanaCompleta, calcularDisponibilidad, formatearFecha  } from './grilla.validaciones.js';
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

  if (!targetId) {
    if (aulaIdFiltrada !== null) {
      const aula = aulas.find(a => a.aula_id == aulaIdFiltrada);
      if (aula) {
        document.querySelector('h2').textContent = `Grilla de ${aula.nombre}`;
      }
    } else {
      document.querySelector('h2').textContent = `Grilla Semanal de Asignaciones Marechal`;
    }
  }

  const numFechas = fechasUnicas.length;
  const anchoAula = 16;
  const anchoTotalDias = 100 - anchoAula;
  const anchoDia = anchoTotalDias / numFechas;

  let html = '<table class="grid-table"><colgroup>';
  if (!ocultarColumnaAula) {
    html += `<col style="width: ${anchoAula}%;">`;
  }
  for (let i = 0; i < numFechas; i++) {
    html += `<col style="width: ${anchoDia}%;">`;
  }
  html += '</colgroup><thead><tr>';
  if (!ocultarColumnaAula) {
    html += '<th>Aula</th>';
  }

  fechasUnicas.forEach(fecha => {
    html += `<th>${formatearFecha(fecha)}</th>`;
  });
  html += '</tr></thead><tbody>';

  const mostrarNombreAula = targetId === null || targetId === 'principal';

  aulasFiltradas.forEach(aula => {
    const recursoIcono = iconoRecurso[aula.recurso] || '❓';
    let infoAula = '';
    if (aula.recurso && aula.capacidad) {
      infoAula = `<small>${recursoIcono} ${aula.recurso} - Capacidad: ${aula.capacidad}</small>`;
    }

    html += '<tr>';
    if (!ocultarColumnaAula) {
      html += '<td>';
      if (mostrarNombreAula) {
        html += `<strong>${aula.nombre}</strong><br>${infoAula}`;
      }
      html += '</td>';
    }

    fechasUnicas.forEach(fecha => {
      const asignacionesFecha = grid[aula.aula_id]?.[fecha] || [];
      let celdaHTML = '';
      let botonesEliminar = '';
      let botonesEditar = '';

      if (asignacionesFecha.length > 0) {
        const huecos = calcularDisponibilidad(turnoSeleccionado, asignacionesFecha);
        if (huecos.length > 0) {
          celdaHTML += `
            <div class="disponible-wrapper">
              <div class="disponible-label">🟢 Disponibilidad</div>
              <div class="disponible-detalle">${huecos.join('<br>')}</div>
            </div>
          `;
        }
      }

      asignacionesFecha.forEach(asig => {
        const color = asig.color_entidad || '#ccc';
        let comentarioHTML = '';
        if (asig.comentarios?.trim()) {
          const limpio = asig.comentarios.replace(/"/g, "'").replace(/\r?\n/g, ' ');
          comentarioHTML = `
            <div class="comentario-wrapper">
              <span class="comentario-toggle"><i class="fas fa-comment-dots"></i> Comentario</span>
              <div class="comentario-flotante">${limpio}</div>
            </div>
          `;
        }

        celdaHTML += `<div class="asignacion" data-id="${asig.Id}" data-fecha="${asig.fecha}" data-aula="${asig.aula_id}"
          style="margin-bottom:6px; background-color:${color}; color:#fff; padding:6px; border-radius:6px;">
          <div class="asignacion-texto">
            <strong>MATERIA: ${asig.materia}</strong><br>
            <span>CARRERA: ${asig.carrera}</span><br>
            <span>AÑO: ${asig.anio}</span><br>
            HORARIO: ${asig.hora_inicio.slice(0,5)} - ${asig.hora_fin.slice(0,5)}<br>
            <small><em>PROFESOR: ${asig.profesor}</em></small>
          </div>
          ${comentarioHTML}
        </div>`;
      });

      if (asignacionesFecha.length > 0) {
        botonesEliminar = `<button class="btn-eliminar-asignacion" data-id="${asignacionesFecha[0].Id}" data-fecha="${fecha}" data-aula="${aula.aula_id}" title="Eliminar esta asignación">❌</button>`;
        botonesEditar = `<button class="btn-editar-asignacion" data-id="${asignacionesFecha[0].Id}" data-fecha="${fecha}" data-aula="${aula.aula_id}" title="Editar esta asignación">✏️</button>`;
      }

      celdaHTML += `
        <div class="acciones-celda">
          <button class="btn-agregar" title="Agregar asignación" data-fecha="${fecha}" data-aula="${aula.aula_id}">➕</button>
          ${botonesEditar}
          ${botonesEliminar}
        </div>
      `;

      html += `<td class="celda-asignacion" data-fecha="${fecha}" data-aula="${aula.aula_id}">${celdaHTML}</td>`;
    });

    html += '</tr>';
  });

  html += '</tbody></table>';

  const destino = targetId
    ? document.getElementById(targetId)
    : document.getElementById('grilla-container');

  if (destino) destino.innerHTML = html;

  if ((!targetId || targetId === 'principal') && aulaIdFiltrada !== null) {
    const aula = datos.aulas?.find(a => a.aula_id == aulaIdFiltrada);
    if (aula) {
      document.querySelector('h2').textContent = `Grilla de ${aula.nombre} - Turno ${turnoSeleccionado}`;
    } else {
      document.querySelector('h2').textContent = `Grilla Semanal de Asignaciones Marechal - Turno ${turnoSeleccionado}`;
    }
  }
}

export function cargarAsignacionesPorAula(aulaId) {
  window.aulaSeleccionada = aulaId;

  fetch('acciones/get_grilla.php')
    .then(res => res.json())
    .then(data => {
  console.log('[DEBUG] Datos recibidos:', data); // 👈 acá

      try {
        if (!data.aulas || data.aulas.length === 0) {
          return mostrarMensaje('error', 'No se han cargado aulas globalmente');
        }

        window.datosGlobales = data;

        if (window.modoExtendido) return;

        const turnoActivo = document.querySelector('.tab-btn.active')?.dataset.turno || 'Matutino';
        renderGrilla(turnoActivo, data, aulaId);
        renderLeyenda();
      } catch {
        mostrarMensaje('error', 'Error al procesar la grilla inicial');
      }
    })
    .catch(() => {
      mostrarMensaje('error', 'No se pudo cargar la grilla del aula');
    });
}

let turnoActual = null;

export function actualizarGrilla(turno) {
  const turnoSeguro = turno || 'Matutino';
  const aulaId = window.aulaSeleccionada;

  if (window.modoExtendido) return;

  if (!window.datosGlobales || !window.datosGlobales.asignaciones) {
    mostrarMensaje('error', 'Los datos aún no están disponibles');
    return;
  }

  if (turnoActual === turnoSeguro && aulaId === null && !window.forceRender) {
    return;
  }

  turnoActual = turnoSeguro;
  window.forceRender = false;

  renderGrilla(turnoSeguro, window.datosGlobales, aulaId);
}

export function renderGrillaTodosLosTurnos(datos = window.datosGlobales, aulaIdFiltrada = null) {
  if (aulaIdFiltrada === undefined) {
    aulaIdFiltrada = null;
  }

  const container = document.getElementById('grilla-container');
  if (!container) {
    mostrarMensaje('error', 'No se encontró el contenedor de grilla');
    return;
  }

  container.innerHTML = '';

  const turnos = ['Matutino', 'Vespertino', 'Nocturno'];

  const aula = aulaIdFiltrada !== null
    ? datos.aulas?.find(a => a.aula_id == aulaIdFiltrada)
    : null;

  if (aula) {
    document.querySelector('h2').textContent = `Grilla extendida de ${aula.nombre} (todos los turnos)`;
  } else {
    document.querySelector('h2').textContent = `Grilla Semanal de Asignaciones Marechal (todos los turnos)`;
  }

  document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));

  turnos.forEach(turno => {
    const wrapper = document.createElement('div');
    wrapper.className = 'grilla-turno-wrapper';

    const titulo = document.createElement('h3');
    titulo.textContent = `Turno ${turno}`;
    titulo.classList.add('grilla-turno-activa');
    wrapper.appendChild(titulo);

    const tempDiv = document.createElement('div');
    tempDiv.id = `grilla-${turno.toLowerCase()}`;
    wrapper.appendChild(tempDiv);

    container.appendChild(wrapper);

    renderGrilla(turno, datos, aulaIdFiltrada, tempDiv.id);
  });

  renderLeyenda();
}

export function cargarAsignacionesPorAulaTodosLosTurnos(aulaId) {
  window.yaRenderizado = true;

  fetch('acciones/get_grilla.php')
    .then(res => res.json())
    .then(data => {
      if (!data.aulas || data.aulas.length === 0) {
        mostrarMensaje('error', 'No se recibieron aulas desde el backend');
        return;
      }

      window.datosGlobales = data;
      window.aulaSeleccionada = aulaId;

      renderGrillaTodosLosTurnos(data, aulaId);
    })
    .catch(() => {
      mostrarMensaje('error', 'No se pudieron cargar las asignaciones del aula');
    });
}

export function renderVistaGeneral() {
  console.log('[FLOW] Renderizando vista general institucional');

  // 🔁 Reset de banderas
  window.modoExtendido = false;
  window.aulaSeleccionada = null;

  // 🧼 Limpieza visual
  const selectorFecha = document.getElementById('selector-fecha');
  if (selectorFecha) selectorFecha.value = '';

  const inputBuscador = document.getElementById('input-buscador');
  if (inputBuscador) inputBuscador.value = '';

  const leyenda = document.getElementById('leyenda-dinamica');
  if (leyenda) leyenda.innerHTML = '';

  const modal = document.querySelector('.modal');
  if (modal) modal.remove();

  // 🔄 Reset de tabs activos
  document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));

  const btnMatutino = document.querySelector('.tab-btn[data-turno="Matutino"]');
  if (btnMatutino) btnMatutino.classList.add('active');

  // 🟢 Turno base
  const turno = 'Matutino';

  // 🔄 Render institucional
  actualizarGrilla(turno);
  actualizarVisibilidadFiltros();

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

export function actualizarVisibilidadFiltros() {
  const mostrar = !window.modoExtendido;

  const bloqueFecha = document.getElementById('bloque-filtro-fecha');
  const bloqueBuscador = document.getElementById('bloque-buscador');

  if (bloqueFecha) bloqueFecha.style.display = mostrar ? 'block' : 'none';
  if (bloqueBuscador) bloqueBuscador.style.display = mostrar ? 'block' : 'none';

  console.log(`[UI] Bloques de filtros ${mostrar ? 'visibles' : 'ocultos'} según modo ${window.modoExtendido ? 'extendido' : 'institucional'}`);
}

export function actualizarLayoutPorModo() {
  const mostrar = !window.modoExtendido;

  const filtroFecha = document.getElementById('contenedor-fecha');
  const buscador = document.getElementById('input-buscador');
  const btnResetFecha = document.getElementById('btn-reset-fecha');

  if (filtroFecha) filtroFecha.style.display = mostrar ? 'block' : 'none';
  if (buscador) buscador.style.display = mostrar ? 'inline-block' : 'none';
  if (btnResetFecha) btnResetFecha.style.display = mostrar ? 'inline-block' : 'none';

  console.log(`[UI] Layout actualizado: filtros ${mostrar ? 'visibles' : 'ocultos'} según modo ${window.modoExtendido ? 'extendido' : 'institucional'}`);
}