import { renderGrilla, actualizarVisibilidadFiltros } from './grilla.render.js';
import { mostrarMensaje } from './grilla.alertas.js';
import { renderLeyenda } from './grilla.eventos.js';
import { getState, setState } from './grilla.state.js';

export async function ejecutarBusqueda(texto, turno) {
  const fechaSeleccionada = document.getElementById('selector-fecha')?.value || null;
  const state = getState();

  if (fechaSeleccionada && !/^\d{4}-\d{2}-\d{2}$/.test(fechaSeleccionada)) {
    mostrarMensaje('info', 'La fecha seleccionada no tiene formato válido');
    return;
  }

  if (!texto) {
    if (!fechaSeleccionada) {
      setState({ modoExtendido: false, aulaSeleccionada: null, filtroActivo: null });

      if (state.datosGlobales?.aulas) {
        renderGrilla(turno, state.datosGlobales);
      } else {
        const res = await fetch('../acciones/get_grilla.php');
        const data = await res.json();
        setState({ datosGlobales: data });
        renderGrilla(turno, data);
      }

      return;
    }

    filtrarGrillaPorFecha(turno, fechaSeleccionada);
    return;
  }

  try {
    const res = await fetch('../acciones/buscar_aulas.php', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ texto })
    });

    const data = await res.json();
    if (!data.ok) throw new Error(data.error || 'Error en búsqueda');

    const aulasFiltradas = data.aulas;
    const idsFiltrados = aulasFiltradas.map(a => Number(a.id));



    const todasAsignaciones = await asegurarAsignaciones();
    const fechaFiltro = fechaSeleccionada ? normalizarFecha(fechaSeleccionada) : null;
    const turnoNormalizado = turno.trim().toLowerCase();

    const asignacionesFiltradas = todasAsignaciones.filter(a => {
      const aulaOk = idsFiltrados.includes(Number(a.aula_id));
      const turnoOk = a.turno?.trim().toLowerCase() === turnoNormalizado;
      const fechaOk = fechaFiltro ? normalizarFecha(a.fecha) === fechaFiltro : true;
      return aulaOk && turnoOk && fechaOk;
    });







    const grillaFiltrada = {
      ...getState().datosGlobales,
      aulas: aulasFiltradas,
      asignaciones: asignacionesFiltradas
    };

    setState({
      filtroActivo: {
        texto,
        fecha: fechaSeleccionada,
        turno
      }
    });

    renderGrilla(turno, grillaFiltrada, null, null, fechaSeleccionada);

  } catch (err) {
    mostrarMensaje('error', 'No se pudo realizar la búsqueda: ' + err.message);
  }
}


function filtrarAsignacionesPorAulasTurnoFecha(asignaciones, aulaIds, turno, fecha) {
  const turnoNormalizado = turno.trim().toLowerCase();

  return asignaciones.filter(a => {
    const aulaOk = aulaIds.includes(Number(a.aula_id));
    const turnoOk = a.turno?.trim().toLowerCase() === turnoNormalizado;
    const fechaOk = fecha ? normalizarFecha(a.fecha) === fecha : true;
    return aulaOk && turnoOk && fechaOk;
  });
}

async function asegurarAsignaciones() {
  const state = getState();
  if (!state.datosGlobales?.asignaciones) {
    const res = await fetch('../acciones/get_grilla.php');
    const data = await res.json();
    setState({ datosGlobales: data });
    return data.asignaciones || [];
  }
  return state.datosGlobales.asignaciones;
}

export function activarFiltroPorFecha() {
  const selector = document.getElementById('selector-fecha');
  if (!selector) return;

  selector.addEventListener('change', () => {
    const textoOriginal = document.getElementById('input-buscador')?.value.trim() || '';
    const texto = textoOriginal.toLowerCase().normalize('NFD').replace(/[\u0300-\u036f]/g, '');
    const turno = document.querySelector('.tab-btn.active')?.dataset.turno || 'Matutino';

    ejecutarBusqueda(texto, turno);
  });
}

export function filtrarGrillaPorFecha(turno, fecha) {
  const state = getState();
  const datos = state.datosGlobales;
  const fechaFiltro = normalizarFecha(fecha);

  const asignacionesFiltradas = datos.asignaciones.filter(a => {
    const fechaAsignacion = normalizarFecha(a.fecha);
    const turnoOk = a.turno?.trim().toLowerCase() === turno.trim().toLowerCase();
    return fechaAsignacion === fechaFiltro && turnoOk;
  });



  const grillaFiltrada = {
    ...datos,
    asignaciones: asignacionesFiltradas
  };

  setState({
    filtroActivo: {
      texto: '',
      fecha,
      turno
    }
  });

  renderGrilla(turno, grillaFiltrada, null, null, fecha);
}

export function normalizarFecha(fecha) {
  if (!fecha) return '';
  const fechaSinHora = fecha.split(' ')[0];
  const partes = fechaSinHora.split(/[\/\-]/);
  if (partes.length !== 3) return '';

  const [a, b, c] = partes;

  if (a.length === 4) return `${a}-${b.padStart(2, '0')}-${c.padStart(2, '0')}`;
  if (c.length === 4) return `${c}-${b.padStart(2, '0')}-${a.padStart(2, '0')}`;

  return '';
}

export function limpiarFiltrosYRestaurar(turno = 'Matutino') {
  const selector = document.getElementById('selector-fecha');
  const buscador = document.getElementById('input-buscador');
  const state = getState();

  const fechaSeleccionada = selector?.value || '';
  const textoOriginal = buscador?.value.trim() || '';
  const texto = textoOriginal
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '');

  const sinTexto = texto.length === 0;
  const sinFecha = fechaSeleccionada.length === 0;

  setState({
    modoExtendido: false,
    aulaSeleccionada: null,
    filtroActivo: null
  });

  actualizarVisibilidadFiltros();

  if (sinTexto && sinFecha) {
    renderGrilla(turno, state.datosGlobales);
    renderLeyenda();
    return;
  }

  if (sinTexto && !sinFecha) {
    filtrarGrillaPorFecha(turno, fechaSeleccionada);
    return;
  }

  ejecutarBusqueda(texto, turno);
}