import { renderLeyenda } from './grilla.eventos.js';
import { mostrarMensaje } from './grilla.alertas.js';
import { rangoTurno, convertirAHora, minutosAHora, getFechasSemanaCompleta  } from './grilla.validaciones.js';



function formatearFecha(fecha) {
  const fechaISO = normalizarFecha(fecha).trim();
  const fechaObj = new Date(fechaISO + 'T00:00:00'); // fuerza interpretación local
  if (isNaN(fechaObj)) {
    console.warn('⚠️ Fecha inválida detectada:', fecha);
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
  const fecha = new Date(limpia + 'T00:00:00'); // fuerza interpretación local
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
    console.warn('⚠️ Datos no disponibles para renderizar grilla');
    mostrarMensaje('error', 'Los datos aún no están cargados');
    return;
  }

  const ocultarColumnaAula = aulaIdFiltrada && targetId !== 'principal';
  const { aulas, asignaciones } = datos;

  console.log('🧪 Fechas originales:', asignaciones.map(a => a.fecha));

// 🧠 Calcular lunes y sábado de la semana actual, sin depender del día de hoy
const hoy = new Date();
const diaActual = hoy.getDay(); // 0 = domingo, 1 = lunes, ..., 6 = sábado

const lunes = new Date(hoy);
lunes.setDate(hoy.getDate() - diaActual + 1);
lunes.setHours(0, 0, 0, 0);

const sabado = new Date(lunes);
sabado.setDate(lunes.getDate() + 5);
sabado.setHours(23, 59, 59, 999);

// 🛡️ Filtrar fechas dentro del rango lunes-sábado, incluso si ya pasaron
const fechasUnicas = getFechasSemanaCompleta();

  console.log('🧪 Fechas hábiles detectadas:', fechasUnicas);

  if (fechasUnicas.length === 0) {
    console.warn('⚠️ No hay fechas hábiles para mostrar');
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
    if (aulaIdFiltrada) {
      const aula = aulas.find(a => a.aula_id == aulaIdFiltrada);
      if (aula) {
        document.querySelector('h2').textContent = `Grilla de ${aula.nombre}`;
      }
    } else {
      document.querySelector('h2').textContent = `Grilla Semanal de Asignaciones Marechal`;
    }
    console.log(`🧪 RenderGrilla ejecutado para turno: ${turnoSeleccionado} | targetId: ${targetId || 'principal'} | aulaIdFiltrada: ${aulaIdFiltrada}`);
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

  console.log('🧪 Aulas filtradas:', aulasFiltradas.map(a => a.nombre));
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

  if (!targetId || targetId === 'principal') {
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
          return mostrarMensaje('Error en fetch', 'No se han cargado aulas globalmente');
        }

        renderGrilla('Matutino', data, aulaId); // ✅ solo una vez
        renderLeyenda();
      } catch (error) {
        console.error('❌ Error interno al renderizar:', error);
        mostrarMensaje('Error', 'Error al procesar la grilla inicial');
      }
    });
}

let turnoActual = null;

export function actualizarGrilla(turno) {
  const turnoSeguro = turno || 'Matutino';
  const aulaId = window.aulaSeleccionada;

  // 🛡️ Defensa contra renders innecesarios, salvo que se fuerce
  if (turnoActual === turnoSeguro && aulaId === null && !window.forceRender) {
    console.log('🛑 Render ignorado: mismo turno y sin aula activa');
    return;
  }

  turnoActual = turnoSeguro;
  console.log('🔄 Cambio de turno:', turnoSeguro, '| Aula activa:', aulaId);
  renderGrilla(turnoSeguro, window.datosGlobales, aulaId);

  // 🧼 Reset de bandera de render forzado
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
  const turnos = ['Matutino', 'Vespertino', 'Nocturno']; // ✅ array real

  const container = document.getElementById('grilla-container');
  container.innerHTML = ''; // 🧼 limpieza previa

  // 🧠 Actualizar título principal solo una vez
  const aula = datos.aulas?.find(a => a.aula_id == aulaIdFiltrada);
  if (aula) {
    document.querySelector('h2').textContent = `Grilla extendida de ${aula.nombre} (todos los turnos)`;
  } else {
    document.querySelector('h2').textContent = `Grilla Semanal de Asignaciones Marechal (todos los turnos)`;
  }

  // 🧼 Desactivar pestañas de turno
  document.querySelectorAll('.tab-btn').forEach(btn => {
    btn.classList.remove('active');
  });

  // 🧩 Renderizar cada turno en su bloque
  turnos.forEach(turno => {
    const wrapper = document.createElement('div');
    wrapper.className = 'grilla-turno-wrapper';

    const titulo = document.createElement('h3');
    titulo.textContent = `Turno ${turno}`;
    wrapper.appendChild(titulo);

    const tempDiv = document.createElement('div');
    tempDiv.id = `grilla-${turno.toLowerCase()}`;
    wrapper.appendChild(tempDiv);

    container.appendChild(wrapper);

    renderGrilla(turno, datos, aulaIdFiltrada, tempDiv.id); // ✅ render modular
  });

  renderLeyenda();
}

export function cargarAsignacionesPorAulaTodosLosTurnos(aulaId) {
  fetch('acciones/get_grilla.php')
    .then(res => res.json())
    .then(data => {
      window.datosGlobales = data;
      window.aulaSeleccionada = aulaId;

      renderGrillaTodosLosTurnos(data, aulaId); // ✅ render extendido

    })
    .catch(err => {
      console.error('❌ Error al cargar asignaciones:', err);
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

  console.log('🧪 Asignaciones filtradas por fecha:', fecha, '| Turno:', turno);
  console.log('📦 Total asignaciones filtradas:', asignacionesFiltradas.length);

  renderGrilla(turno, grillaFiltrada, aulaId);
}

