import { renderLeyenda } from './grilla.eventos.js';
import { mostrarMensaje } from './grilla.alertas.js';
import { rangoTurno, convertirAHora, minutosAHora, getFechasSemanaCompleta } from './grilla.validaciones.js';

function formatearFecha(fecha) {
  const fechaISO = normalizarFecha(fecha).trim();
  const fechaObj = new Date(fechaISO + 'T00:00:00');
  if (isNaN(fechaObj)) {
    return 'Fecha inválida';
  }
  const opciones = { weekday: 'long', day: 'numeric', month: 'short' };
  return fechaObj.toLocaleDateString('es-AR', opciones);
}

function normalizarFecha(fecha) {
  const partes = fecha.split(/[\/\-]/);
  if (partes.length === 3) {
    const [a, b, c] = partes;
    if (a.length === 4) return `${a}-${b.padStart(2, '0')}-${c.padStart(2, '0')}`;
    return `${c}-${b.padStart(2, '0')}-${a.padStart(2, '0')}`;
  }
  return fecha;
}

function esDiaHabil(fechaStr) {
  const limpia = normalizarFecha(fechaStr).trim();
  const fecha = new Date(limpia + 'T00:00:00');
  const dia = fecha.getDay();
  return !isNaN(dia) && dia >= 1 && dia <= 6;
}

export const iconoRecurso = {
  'Proyector': '<i class="fas fa-video"></i>',
  'TV': '<i class="fas fa-tv"></i>',
  'Ninguno': '<i class="fas fa-ban"></i>'
};

export function renderGrilla(turnoSeleccionado, datos = window.datosGlobales, aulaIdFiltrada = null, targetId = null) {
  if (!datos || !datos.aulas || !datos.asignaciones) {
    mostrarMensaje('error', 'Los datos aún no están cargados');
    return;
  }

  const ocultarColumnaAula = aulaIdFiltrada && targetId !== 'principal';
  const { aulas, asignaciones } = datos;

  const fechasUnicas = getFechasSemanaCompleta();
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
  }
}

}
export function cargarAsignacionesPorAula(aulaId) {
  window.aulaSeleccionada = aulaId;

  fetch('acciones/get_grilla.php')
    .then(res => res.json())
    .then(data => {
      try {
        window.datosGlobales = data;

        if (!data.aulas || data.aulas.length === 0) {
          return mostrarMensaje('error', 'No se han cargado aulas globalmente');
        }

        renderGrilla('Matutino', data, aulaId);
        renderLeyenda();
      } catch {
        mostrarMensaje('error', 'Error al procesar la grilla inicial');
      }
    });
}

let turnoActual = null;

export function actualizarGrilla(turno) {
  if (window.modoExtendido) {
    console.log('⛔ Cancelado: modo extendido activo');
    return;
  }

  const turnoSeguro = turno || 'Matutino';
  const aulaId = window.aulaSeleccionada;

  if (turnoActual === turnoSeguro && aulaId === null && !window.forceRender) {
    return;
  }

  turnoActual = turnoSeguro;
  renderGrilla(turnoSeguro, window.datosGlobales, aulaId);
  window.forceRender = false;
}

export function calcularDisponibilidad(turno, asignaciones) {
  const [inicioTurno, finTurno] = rangoTurno[turno];
  const huecos = [];

  let anteriorFin = inicioTurno;

  asignaciones
    .filter(a => a.turno === turno)
    .sort((a, b) => convertirAHora(a.hora_inicio) - convertirAHora(b.hora_inicio))
    .forEach(asig => {
      const inicioAsignacion = convertirAHora(asig.hora_inicio);
      const finAsignacion = convertirAHora(asig.hora_fin);

      if (anteriorFin < inicioAsignacion) {
        huecos.push(`${minutosAHora(anteriorFin)} a ${minutosAHora(inicioAsignacion)}`);
      }

      anteriorFin = Math.max(anteriorFin, finAsignacion);
    });

  if (anteriorFin < finTurno) {
    huecos.push(`${minutosAHora(anteriorFin)} a ${minutosAHora(finTurno)}`);
  }

  return huecos;
}

export function renderGrillaTodosLosTurnos(datos = window.datosGlobales, aulaIdFiltrada = null) {
  console.log('🧩 renderGrillaTodosLosTurnos ejecutado');
  console.log('🔍 aulaIdFiltrada:', aulaIdFiltrada);
  console.log('📊 cantidad de aulas:', datos?.aulas?.length);

  const turnos = ['Matutino', 'Vespertino', 'Nocturno'];
  const container = document.getElementById('grilla-container');
  container.innerHTML = '';

  const aula = datos.aulas?.find(a => a.aula_id == aulaIdFiltrada);
  if (aula) {
    document.querySelector('h2').textContent = `Grilla extendida de ${aula.nombre} (todos los turnos)`;
  } else {
    document.querySelector('h2').textContent = `Grilla Semanal de Asignaciones Marechal (todos los turnos)`;
  }

  document.querySelectorAll('.tab-btn').forEach(btn => {
    btn.classList.remove('active');
  });

  turnos.forEach(turno => {
    console.log(`📐 Renderizando turno: ${turno}`);

    const wrapper = document.createElement('div');
    wrapper.className = 'grilla-turno-wrapper';

    const titulo = document.createElement('h3');
    titulo.textContent = `Turno ${turno}`;
    wrapper.appendChild(titulo);

    const tempDiv = document.createElement('div');
    tempDiv.id = `grilla-${turno.toLowerCase()}`;
    wrapper.appendChild(tempDiv);

    container.appendChild(wrapper);

    renderGrilla(turno, datos, aulaIdFiltrada, tempDiv.id); // ✅ corregido
  });

  renderLeyenda();
}

export function cargarAsignacionesPorAulaTodosLosTurnos(aulaId) {
  fetch('acciones/get_grilla.php')
    .then(res => res.json())
    .then(data => {
      window.datosGlobales = data;
      window.aulaSeleccionada = aulaId;
      renderGrillaTodosLosTurnos(data, aulaId);
    })
    .catch(() => {
      mostrarMensaje('error', 'No se pudieron cargar las asignaciones del aula');
    });
}

export function filtrarGrillaPorFecha(turno, fecha) {
  const datos = window.datosGlobales;
  const aulaId = window.aulaSeleccionada;

  const asignacionesFiltradas = datos.asignaciones.filter(a =>
    a.fecha === fecha && a.turno === turno
  );

  const grillaFiltrada = {
    ...datos,
    asignaciones: asignacionesFiltradas
  };

  renderGrilla(turno, grillaFiltrada, aulaId);
}