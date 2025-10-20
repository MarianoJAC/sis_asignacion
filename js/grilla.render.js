import { renderLeyenda } from './grilla.eventos.js';
import { mostrarMensaje } from './grilla.alertas.js';
import { rangoTurno, convertirAHora, minutosAHora, getFechasSemanaCompleta, calcularDisponibilidad, formatearFecha  } from './grilla.validaciones.js';
import { normalizarFecha } from './grilla.filtros.js';
import { getState, setState } from './grilla.state.js';

const iconoRecurso = {
  'Proyector': '<i class="fas fa-video"></i>',
  'TV': '<i class="fas fa-tv"></i>',
  'Pantalla interactiva': '<i class="fas fa-chalkboard-teacher"></i>',
  'Ninguno': '<i class="fas fa-ban"></i>'
};

export function renderGrilla(turnoSeleccionado, datos, aulaIdFiltrada = null, targetId = null, fechaFiltrada = null) {
  const state = getState();
  if (state.modoExtendido && !targetId) return;

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

  const fechaNormalizada = fechaFiltrada ? normalizarFecha(fechaFiltrada) : null;
  const aulaIdsPermitidos = aulas.map(a => Number(a.aula_id || a.id));



  const filtradas = asignaciones.filter(a => {
    const aulaOk = aulaIdsPermitidos.includes(Number(a.aula_id));
    const turnoOk = a.turno === turnoSeleccionado;
    const fechaOk = fechaNormalizada ? normalizarFecha(a.fecha) === fechaNormalizada : true;
    return aulaOk && turnoOk && fechaOk;
  });



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

  aulasFiltradas.forEach(aula => {
    const id = Number(aula.aula_id || aula.id);
    const count = filtradas.filter(a => Number(a.aula_id) === id).length;

  });



  const destino = targetId
    ? document.getElementById(targetId)
    : document.getElementById('grilla-container');

  if (destino) {
    renderGrillaSafe(destino, turnoSeleccionado, datos, aulaIdFiltrada, targetId, fechaFiltrada, ocultarColumnaAula, fechasUnicas, grid, aulasFiltradas);
  }



}



function renderGrillaSafe(destino, turnoSeleccionado, datos, aulaIdFiltrada, targetId, fechaFiltrada, ocultarColumnaAula, fechasUnicas, grid, aulasFiltradas) {
  const container = document.getElementById('grilla-container');

  // Toggle centered class based on view
  if (fechasUnicas.length === 1) {
    container.classList.add('grilla-container-centered');
  } else {
    container.classList.remove('grilla-container-centered');
  }

  destino.textContent = '';

  const table = document.createElement('table');
  table.className = 'grid-table';
  if (fechasUnicas.length === 1) {
    table.classList.add('grid-table-single-date');
  }

  const thead = document.createElement('thead');
  const trHead = document.createElement('tr');
  

  if (!ocultarColumnaAula) {
    const th = document.createElement('th');
    th.textContent = 'Aula';
    th.style.width = '200px'; // Set fixed width on the header cell
    trHead.appendChild(th);
  }

  fechasUnicas.forEach(fecha => {
    const th = document.createElement('th');
    th.textContent = formatearFecha(fecha);
    if (fechasUnicas.length === 1) {
      th.style.minWidth = '500px'; // Set a min-width for the single date column
    }
    trHead.appendChild(th);
  });

  thead.appendChild(trHead);
  table.appendChild(thead);

  const tbody = document.createElement('tbody');

  const mostrarNombreAula = targetId === null || targetId === 'principal';

  aulasFiltradas.forEach(aula => {
     const asignacionesAula = datos.asignaciones.filter(a => Number(a.aula_id) === Number(aula.aula_id || aula.id));


    const tr = document.createElement('tr');

    if (!ocultarColumnaAula) {
      const tdAula = document.createElement('td');
      if (mostrarNombreAula) {
        const strong = document.createElement('strong');
        strong.textContent = aula.nombre;
        tdAula.appendChild(strong);
        tdAula.appendChild(document.createElement('br'));
        const small = document.createElement('small');
        let infoParts = [];

        const recursos = Array.isArray(aula.recursos) && aula.recursos.length > 0 ? aula.recursos : [];
        if (recursos.length > 0) {
            const recursosHTML = recursos.map(r => `${iconoRecurso[r] || '❓'} ${r}`).join(' / ');
            infoParts.push(recursosHTML);
        }

        if (aula.capacidad) {
            infoParts.push(`Capacidad: ${aula.capacidad}`);
        }

        if (infoParts.length > 0) {
            const wrappedParts = infoParts.map(part => `<span style="white-space: nowrap;">${part}</span>`);
            small.innerHTML = wrappedParts.join(' – ');
            tdAula.appendChild(small);
        }
      }
      tr.appendChild(tdAula);
    }

    fechasUnicas.forEach(fecha => {
       const td = document.createElement('td');
  const aulaId = Number(aula.aula_id || aula.id);
  const asignacionesFecha = grid[aulaId]?.[fecha] || [];

      td.className = 'celda-asignacion';
      td.dataset.fecha = fecha;
      td.dataset.aula = aula.aula_id;


      if (asignacionesFecha.length > 0) {
        const huecos = calcularDisponibilidad(turnoSeleccionado, asignacionesFecha);
        if (huecos.length > 0) {
          const disponibleWrapper = document.createElement('div');
          disponibleWrapper.className = 'disponible-wrapper';
          const disponibleLabel = document.createElement('div');
          disponibleLabel.className = 'disponible-label';
          disponibleLabel.textContent = '🟢 Disponibilidad';
          disponibleWrapper.appendChild(disponibleLabel);
          const disponibleDetalle = document.createElement('div');
          disponibleDetalle.className = 'disponible-detalle';
          disponibleDetalle.innerHTML = huecos.join('<br>');
          disponibleWrapper.appendChild(disponibleDetalle);
          td.appendChild(disponibleWrapper);
        }
      }

      asignacionesFecha.forEach(asig => {
        const asignacionDiv = document.createElement('div');
        asignacionDiv.className = 'asignacion';
        asignacionDiv.dataset.id = asig.Id;
        asignacionDiv.dataset.fecha = asig.fecha;
        asignacionDiv.dataset.aula = asig.aula_id;
        asignacionDiv.style.marginBottom = '6px';
        asignacionDiv.style.backgroundColor = asig.color_entidad || '#ccc';
        asignacionDiv.style.color = '#fff';
        asignacionDiv.style.padding = '6px';
        asignacionDiv.style.borderRadius = '6px';

        const asignacionTexto = document.createElement('div');
        asignacionTexto.className = 'asignacion-texto';
        asignacionTexto.innerHTML = `
          <strong>MATERIA: ${asig.materia}</strong><br>
          <span>CARRERA: ${asig.carrera}</span><br>
          <span>AÑO: ${asig.anio}</span><br>
          HORARIO: ${asig.hora_inicio.slice(0,5)} - ${asig.hora_fin.slice(0,5)}<br>
          <small><em>PROFESOR: ${asig.profesor}</em></small>
        `;
        asignacionDiv.appendChild(asignacionTexto);

        if (asig.comentarios?.trim()) {
          const comentarioWrapper = document.createElement('div');
          comentarioWrapper.className = 'comentario-wrapper';
          const comentarioToggle = document.createElement('span');
          comentarioToggle.className = 'comentario-toggle';
          comentarioToggle.innerHTML = '<i class="fas fa-comment-dots"></i> Comentario';
          comentarioWrapper.appendChild(comentarioToggle);
          const comentarioFlotante = document.createElement('div');
          comentarioFlotante.className = 'comentario-flotante';
          comentarioFlotante.textContent = asig.comentarios.replace(/\r?\n/g, ' ');
          comentarioWrapper.appendChild(comentarioFlotante);
          asignacionDiv.appendChild(comentarioWrapper);
        }

        td.appendChild(asignacionDiv);
      });

     const accionesCelda = document.createElement('div');
accionesCelda.className = 'acciones-celda';

if (window.esAdmin) {
  const btnAgregar = document.createElement('button');
  btnAgregar.className = 'btn-agregar';
  btnAgregar.title = 'Agregar asignación';
  btnAgregar.dataset.fecha = fecha;
  btnAgregar.dataset.aula = aula.aula_id;
  btnAgregar.dataset.turno = turnoSeleccionado;
  btnAgregar.textContent = '➕';
  accionesCelda.appendChild(btnAgregar);

  if (asignacionesFecha.length > 0) {
    const btnEditar = document.createElement('button');
    btnEditar.className = 'btn-editar-asignacion';
    btnEditar.dataset.id = asignacionesFecha[0].Id;
    btnEditar.dataset.fecha = fecha;
    btnEditar.dataset.aula = aula.aula_id;
    btnEditar.dataset.turno = turnoSeleccionado; // 🐞 FIX
    btnEditar.title = 'Editar esta asignación';
    btnEditar.textContent = '✏️';
    accionesCelda.appendChild(btnEditar);

    const btnEliminar = document.createElement('button');
    btnEliminar.className = 'btn-eliminar-asignacion';
    btnEliminar.dataset.id = asignacionesFecha[0].Id;
    btnEliminar.dataset.fecha = fecha;
    btnEliminar.dataset.aula = aula.aula_id;
    btnEliminar.dataset.turno = turnoSeleccionado; // 🐞 FIX
    btnEliminar.title = 'Eliminar esta asignación';
    btnEliminar.textContent = '❌';
    accionesCelda.appendChild(btnEliminar);
  }
}

      td.appendChild(accionesCelda);
      tr.appendChild(td);
    });

    tbody.appendChild(tr);
  });

  table.appendChild(tbody);
  destino.appendChild(table);
}

export function cargarAsignacionesPorAula(aulaId) {
  setState({ aulaSeleccionada: aulaId });

  fetch('../acciones/get_grilla.php')
    .then(res => res.json())
    .then(data => {


      try {
        if (!data.aulas || data.aulas.length === 0) {
          return mostrarMensaje('error', 'No se han cargado aulas globalmente');
        }

        setState({ datosGlobales: data });

        const state = getState();
        if (state.modoExtendido) return;

        const turnoActivo = document.querySelector('.tab-btn.active')?.dataset.turno || 'Matutino';
        renderGrilla(turnoActivo, data, aulaId);
        renderLeyenda();
      } catch (err) {
        mostrarMensaje('error', 'Error al procesar la grilla inicial: ' + err.message);
      }
    })
    .catch((err) => {
      mostrarMensaje('error', 'No se pudo cargar la grilla del aula: ' + err.message);
    });
}

let turnoActual = null;

export function actualizarGrilla(turno) {
  const turnoSeguro = turno || 'Matutino';
  const state = getState();
  const aulaId = state.aulaSeleccionada;

  if (state.modoExtendido) return;

  if (!state.datosGlobales || !state.datosGlobales.asignaciones) {
    mostrarMensaje('error', 'Los datos aún no están disponibles');
    return;
  }

  if (turnoActual === turnoSeguro && aulaId === null && !state.forceRender) {
    return;
  }

  turnoActual = turnoSeguro;
  setState({ forceRender: false });

  renderGrilla(turnoSeguro, state.datosGlobales, aulaId);
}

export function renderGrillaTodosLosTurnos(datos, aulaIdFiltrada = null) {
  if (aulaIdFiltrada === undefined) {
    aulaIdFiltrada = null;
  }

  const container = document.getElementById('grilla-container');
  if (!container) {
    mostrarMensaje('error', 'No se encontró el contenedor de grilla');
    return;
  }

  const aula = aulaIdFiltrada !== null
    ? datos.aulas?.find(a => a.aula_id == aulaIdFiltrada)
    : null;

  const breadcrumbContainer = document.getElementById('breadcrumb-container');
  if (breadcrumbContainer) {
      if (aula) {
          breadcrumbContainer.innerHTML = `
              <span class="text-muted"><i class="fas fa-chevron-right"></i></span> 
              <strong>${aula.nombre}</strong> 
              <button id="btn-salir-extendido" class="btn btn-outline-secondary btn-sm ms-3">Ver todas las aulas</button>
          `;
      } else {
          breadcrumbContainer.innerHTML = ''; // Limpiar si no hay aula
      }
  }

  container.textContent = '';

  const turnos = ['Matutino', 'Vespertino', 'Nocturno'];



  document.body.classList.add('modo-extendido');
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
  setState({ yaRenderizado: true });

  fetch('../acciones/get_grilla.php')
    .then(res => res.json())
    .then(data => {
      if (!data.aulas || data.aulas.length === 0) {
        mostrarMensaje('error', 'No se recibieron aulas desde el backend');
        return;
      }

      setState({ datosGlobales: data, aulaSeleccionada: aulaId });

      renderGrillaTodosLosTurnos(data, aulaId);
    })
    .catch((err) => {
      mostrarMensaje('error', 'No se pudieron cargar las asignaciones del aula: ' + err.message);
    });
}

export function renderVistaGeneral() {


  setState({
    modoExtendido: false,
    aulaSeleccionada: null,
    filtroActivo: null
  });

  // 🧼 Limpieza visual
  const selectorFecha = document.getElementById('selector-fecha');
  if (selectorFecha) selectorFecha.value = '';

  const inputBuscador = document.getElementById('input-buscador');
  if (inputBuscador) inputBuscador.value = '';

  const leyenda = document.getElementById('leyenda-dinamica');
  if (leyenda) leyenda.textContent = '';

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


  setState({
    modoExtendido: true,
    aulaSeleccionada: aulaId,
  });
  document.querySelector('.bloque-turnos')?.style.setProperty('display', 'none', 'important');

  // 🧼 Limpieza visual previa
  const selectorFecha = document.getElementById('selector-fecha');
  if (selectorFecha) selectorFecha.value = '';

  const inputBuscador = document.getElementById('input-buscador');
  if (inputBuscador) inputBuscador.value = '';

  const leyenda = document.getElementById('leyenda-dinamica');
  if (leyenda) leyenda.textContent = '';

  const modal = document.querySelector('.modal');
  if (modal) modal.remove();

  // 🔄 Mantener turno activo
  const turno = document.querySelector('.tab-btn.active')?.dataset.turno || 'Matutino';

  // 🔄 Render extendido
  actualizarGrilla(turno, aulaId);
  actualizarVisibilidadFiltros();
}

export function actualizarVisibilidadFiltros() {
  const state = getState();
  const mostrar = !state.modoExtendido;

  const bloqueFecha = document.getElementById('bloque-filtro-fecha');
  const bloqueBuscador = document.getElementById('bloque-buscador');

  if (bloqueFecha) bloqueFecha.style.display = mostrar ? 'block' : 'none';
  if (bloqueBuscador) bloqueBuscador.style.display = mostrar ? 'block' : 'none';


}

export function actualizarLayoutPorModo() {
  const state = getState();
  const mostrar = !state.modoExtendido;

  const filtroFecha = document.getElementById('contenedor-fecha');
  const buscador = document.getElementById('input-buscador');
  const btnResetFecha = document.getElementById('btn-reset-fecha');

  if (filtroFecha) filtroFecha.style.display = mostrar ? 'block' : 'none';
  if (buscador) buscador.style.display = mostrar ? 'inline-block' : 'none';
  if (btnResetFecha) btnResetFecha.style.display = mostrar ? 'inline-block' : 'none';


}
