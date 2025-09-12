import { renderLeyenda } from './grilla.eventos.js';
import { mostrarMensaje } from './grilla.alertas.js';
import { rangoTurno, convertirAHora, minutosAHora  } from './grilla.validaciones.js';


export const iconoRecurso = {
  'Proyector': '<i class="fas fa-video"></i>',
  'TV': '<i class="fas fa-tv"></i>',
  'Ninguno': '<i class="fas fa-ban"></i>'
};

export function renderGrilla(turnoSeleccionado, datos = window.datosGlobales, aulaIdFiltrada = null) {
   console.log('🧪 Aulas filtradas:', aulaIdFiltrada);
  if (!datos || !datos.dias || !datos.aulas || !datos.asignaciones) {
    console.warn('⚠️ Datos no disponibles para renderizar grilla');
    mostrarMensaje('error', 'Los datos aún no están cargados');
    return;
  }

  const { dias, aulas, asignaciones } = datos;

  const diasFiltrados = dias.filter(dia => dia.trim() && dia.trim() !== ' ');

  const filtradas = asignaciones.filter(a =>
    a.turno === turnoSeleccionado &&
    (!aulaIdFiltrada || a.aula_id == aulaIdFiltrada)
  );

  const grid = {};
  filtradas.forEach(a => {
    if (!grid[a.aula_id]) grid[a.aula_id] = {};
    if (!grid[a.aula_id][a.dia]) grid[a.aula_id][a.dia] = [];
    grid[a.aula_id][a.dia].push(a);
  });

 

  const aulasFiltradas = aulaIdFiltrada
  ? aulas.filter(a => a.aula_id == aulaIdFiltrada)
  : aulas;

// 🧠 Actualizar título dinámico
if (aulaIdFiltrada) {
  const aula = aulas.find(a => a.aula_id == aulaIdFiltrada);
  if (aula) {
    document.querySelector('h2').textContent = `Grilla de ${aula.nombre} - Turno ${turnoSeleccionado}`;
  }
} else {
  document.querySelector('h2').textContent = `Grilla Semanal de Asignaciones Marechal - Turno ${turnoSeleccionado}`;
}

  const numDias = diasFiltrados.length;
  const anchoAula = 16;
  const anchoTotalDias = 100 - anchoAula;
  const anchoDia = anchoTotalDias / numDias;

  let html = '<table class="grid-table"><colgroup>';
  html += `<col style="width: ${anchoAula}%;">`;
  for (let i = 0; i < numDias; i++) {
    html += `<col style="width: ${anchoDia}%;">`;
  }
  html += '</colgroup><thead><tr><th>Aula</th>';
  diasFiltrados.forEach(dia => {
    html += `<th>${dia}</th>`;
  });
  html += '</tr></thead><tbody>';
 console.log('🧪 Aulas filtradas:', aulasFiltradas.map(a => a.nombre));
  aulasFiltradas.forEach(aula => {
    const recursoIcono = iconoRecurso[aula.recurso] || '❓';
    let infoAula = '';
    if (aula.recurso && aula.capacidad) {
      infoAula = `<small>${recursoIcono} ${aula.recurso} - Capacidad: ${aula.capacidad}</small>`;
    }

    html += `<tr><td><strong>${aula.nombre}</strong><br>${infoAula}</td>`;

    diasFiltrados.forEach(dia => {
  const asignacionesDia = grid[aula.aula_id]?.[dia] || [];
  let celdaHTML = '';
  let botonesEliminar = '';
  let botonesEditar = '';


  // 🟢 Mostrar disponibilidad solo si hay asignaciones
if (asignacionesDia.length > 0) {
  const huecos = calcularDisponibilidad(turnoSeleccionado, asignacionesDia);
  if (huecos.length > 0) {
    celdaHTML += `
      <div class="disponible-wrapper">
        <div class="disponible-label">🟢 Disponibilidad</div>
        <div class="disponible-detalle">${huecos.join('<br>')}</div>
      </div>
    `;
  }
}

  // 🧱 Renderizar asignaciones
  asignacionesDia.forEach(asig => {
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

    celdaHTML += `<div class="asignacion" data-id="${asig.Id}" data-dia="${asig.dia}" data-aula="${asig.aula_id}"
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

  // 🎯 Botones de acción
  if (asignacionesDia.length > 0) {
    botonesEliminar = `<button class="btn-eliminar-asignacion" data-id="${asignacionesDia[0].Id}" data-dia="${dia}" data-aula="${aula.aula_id}" title="Eliminar esta asignación">❌</button>`;
    botonesEditar = `<button class="btn-editar-asignacion" data-id="${asignacionesDia[0].Id}" data-dia="${dia}" data-aula="${aula.aula_id}" title="Editar esta asignación">✏️</button>`;
  }

  celdaHTML += `
    <div class="acciones-celda">
      <button class="btn-agregar" title="Agregar asignación" data-dia="${dia}" data-aula="${aula.aula_id}">➕</button>
      ${botonesEditar}
      ${botonesEliminar}
    </div>
  `;

  html += `<td class="celda-asignacion" data-dia="${dia}" data-aula="${aula.aula_id}">${celdaHTML}</td>`;
});

    html += '</tr>';
  });

  html += '</tbody></table>';
  document.getElementById('grilla-container').innerHTML = html;

  document.querySelectorAll('.tab-btn').forEach(btn => {
    btn.classList.toggle('active', btn.dataset.turno === turnoSeleccionado);
  });
}

export function cargarAsignacionesPorAula(aulaId) {
  window.aulaSeleccionada = aulaId;

  fetch('acciones/get_grilla.php')
    .then(res => res.json())
    .then(data => {
      try {
        window.datosGlobales = data;
        renderGrilla('Matutino', data, aulaId);

        if (!data.aulas || data.aulas.length === 0) {
          return mostrarMensaje('Error en fetch', 'No se han cargado aulas globalmente');
        }

        renderGrilla('Matutino', data, aulaId); // ✅ usamos el aulaId como filtro
        renderLeyenda();
      } catch (error) {
        console.error('❌ Error interno al renderizar:', error);
        mostrarMensaje('Error', 'Error al procesar la grilla inicial');
      }
    });
}

export function actualizarGrilla(turno) {
  const aulaId = window.aulaSeleccionada || null;
  console.log('🔄 Cambio de turno:', turno, '| Aula activa:', aulaId);
  renderGrilla(turno, window.datosGlobales, aulaId); // ✅ tercer parámetro obligatorio
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