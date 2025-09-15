import { renderGrilla, actualizarVisibilidadFiltros } from './grilla.render.js';
import { mostrarMensaje } from './grilla.alertas.js';
import { renderLeyenda } from './grilla.eventos.js';

export async function ejecutarBusqueda(texto, turno) {
  const fechaSeleccionada = document.getElementById('selector-fecha')?.value || null;

  // 🔍 Si no hay texto, solo filtramos por fecha
  if (!texto) {
  if (!fechaSeleccionada) {
    console.log('[BUSCADOR] Texto vacío y sin fecha, restaurando grilla institucional');

    window.modoExtendido = false;
    window.aulaSeleccionada = null;

    if (window.datosGlobales && window.datosGlobales.aulas) {
      renderGrilla(turno, window.datosGlobales);
    } else {
      fetch('acciones/get_grilla.php')
        .then(res => res.json())
        .then(data => {
          window.datosGlobales = data;
          renderGrilla(turno, data);
        })
        .catch(() => {
          mostrarMensaje('error', 'No se pudo restaurar la grilla');
        });
    }

    return;
  }

  // ✅ Si hay fecha, filtramos por fecha
  filtrarGrillaPorFecha(turno, fechaSeleccionada);
  return;
}

  // 🔍 Si hay texto, hacemos búsqueda en backend
  try {
    const res = await fetch('acciones/buscar_aulas.php', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ texto })
    });

    const data = await res.json();
    if (!data.ok) throw new Error(data.error || 'Error en búsqueda');

    const idsFiltrados = data.aulas.map(a => a.id);

    let asignacionesFiltradas = window.datosGlobales.asignaciones.filter(a =>
      idsFiltrados.includes(a.aula_id) && a.turno === turno
    );

    if (fechaSeleccionada) {
      asignacionesFiltradas = asignacionesFiltradas.filter(a => {
        const fechaAsignacion = normalizarFecha(a.fecha);
        const fechaFiltro = normalizarFecha(fechaSeleccionada);
        return fechaAsignacion === fechaFiltro;
      });
    }

    const grillaFiltrada = {
      ...window.datosGlobales,
      asignaciones: asignacionesFiltradas,
      aulas: data.aulas
    };

    renderGrilla(turno, grillaFiltrada, null, null, fechaSeleccionada);

  } catch {
    mostrarMensaje('error', 'No se pudo realizar la búsqueda');
  }
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
  const datos = window.datosGlobales;
  const aulaId = window.modoExtendido ? null : window.aulaSeleccionada;

  const fechaFiltro = normalizarFecha(fecha);

  const asignacionesFiltradas = datos.asignaciones.filter(a => {
    const fechaAsignacion = normalizarFecha(a.fecha);
    const coincide = fechaAsignacion === fechaFiltro && a.turno === turno;

    // 🧪 Log por asignación
    console.log(`[FILTRO FECHA] Asignación: ${a.id} | Fecha: ${fechaAsignacion} | Turno: ${a.turno} | Coincide: ${coincide}`);
    return coincide;
  });

  console.log('[FILTRO FECHA] Total asignaciones filtradas:', asignacionesFiltradas.length);

  const grillaFiltrada = {
    ...datos,
    asignaciones: asignacionesFiltradas
  };

  renderGrilla(turno, grillaFiltrada, aulaId, null, fecha);
}

export function normalizarFecha(fecha) {
  if (!fecha) return '';
  const partes = fecha.split(/[\/\-]/);
  if (partes.length !== 3) return fecha;

  const [a, b, c] = partes;

  // Si ya está en formato ISO (aaaa-mm-dd), devolvemos directo
  if (a.length === 4) return `${a}-${b.padStart(2, '0')}-${c.padStart(2, '0')}`;

  // Si viene como dd/mm/aaaa o dd-mm-aaaa
  return `${c}-${b.padStart(2, '0')}-${a.padStart(2, '0')}`;
}

export function limpiarFiltrosYRestaurar(turno = 'Matutino') {
  const selector = document.getElementById('selector-fecha');
  const buscador = document.getElementById('input-buscador');

  const fechaSeleccionada = selector?.value || '';
  const textoOriginal = buscador?.value.trim() || '';
  const texto = textoOriginal
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '');

  const sinTexto = texto.length === 0;
  const sinFecha = fechaSeleccionada.length === 0;

  window.modoExtendido = false;
  window.aulaSeleccionada = null;
  actualizarVisibilidadFiltros();

  if (sinTexto && sinFecha) {
    renderGrilla(turno, window.datosGlobales);
    renderLeyenda();
    return;
  }

  if (sinTexto && !sinFecha) {
    filtrarGrillaPorFecha(turno, fechaSeleccionada);
    return;
  }

  ejecutarBusqueda(texto, turno);
}