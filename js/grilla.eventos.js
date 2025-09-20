import { abrirModal, cerrarModal, htmlNuevaEntidad, htmlEliminarEntidad, htmlEliminarAsignacion, htmlSeleccionarAsignacion } from './grilla.modales.js';
import { mostrarMensaje } from './grilla.alertas.js';
import { actualizarGrilla, renderVistaGeneral } from './grilla.render.js';
import { normalizarFecha } from './grilla.filtros.js';
import { getState, setState } from './grilla.state.js';

document.addEventListener('click', e => {
  const id = e.target.id;

  // 🔒 Cierre automático del panel de filtros si se hace clic fuera
  const contenedorFiltros = document.getElementById('contenedor-filtros');
  const toggleFiltros = document.getElementById('toggle-filtros');

  if (
    contenedorFiltros?.classList.contains('contenedor-visible') &&
    !contenedorFiltros.contains(e.target) &&
    !toggleFiltros.contains(e.target)
  ) {
    contenedorFiltros.classList.remove('contenedor-visible');
    contenedorFiltros.classList.add('contenedor-oculto');
  }

  // 🟢 Botón "Todas las Aulas"
  const btnTodas = e.target.closest('#btn-ver-todas');
  if (btnTodas) {
    e.preventDefault();
    document.body.classList.remove('modo-extendido');
    setState({ modoExtendido: false, aulaSeleccionada: null, yaRenderizado: false });
    import('./grilla.render.js').then(mod => {
      mod.actualizarVisibilidadFiltros();
      mod.renderVistaGeneral();
      renderLeyenda();
    });
    return;
  }

  // 🟡 Tabs de turno
  if (e.target.classList.contains('tab-btn') && e.target.dataset.turno) {
    const turno = e.target.dataset.turno;
    actualizarGrilla(turno);
    document.querySelectorAll('.tab-btn[data-turno]').forEach(btn => {
      btn.classList.remove('active');
    });
    e.target.classList.add('active');
    return;
  }

  // Botón de agregar entidad
  if (id === 'btn-agregar-entidad') {
    e.stopPropagation();
    abrirModal({
      titulo: '➕ Nueva Entidad',
      html: htmlNuevaEntidad(),
      focoSelector: 'input#nombre'
    });
    return;
  }

  // Botón de eliminar entidad
  if (id === 'btn-eliminar-entidad') {
    e.stopPropagation();
    fetch('../acciones/get_entidades.php')
      .then(res => res.json())
      .then(data => {
        const entidades = data.entidades;
        if (!Array.isArray(entidades) || entidades.length === 0) {
          mostrarMensaje('info', 'No hay entidades para eliminar');
          return;
        }
        abrirModal({
          titulo: '❌ Eliminar Entidad',
          html: htmlEliminarEntidad(entidades),
          focoSelector: '[name=entidad_id]'
        });
      })
      .catch((err) => {
        mostrarMensaje('error', 'No se pudo cargar las entidades: ' + err.message);
      });
    return;
  }

  // Botón cancelar (delegado)
  if (e.target.closest('[data-bs-dismiss="modal"]')) {
    cerrarModal();
    return;
  }

  // Botón de agregar asignación
  if (e.target.classList.contains('btn-agregar') && id !== 'btn-agregar-entidad') {
    const aula_id = e.target.dataset.aula;
    const fecha = e.target.dataset.fecha;
    const turno = e.target.dataset.turno || 'Matutino';

    const state = getState();
    const aula = state.datosGlobales.aulas.find(a => a.aula_id == aula_id);
    const nombreAula = aula ? aula.nombre : `Aula ${aula_id}`;

    fetch(`../acciones/form_crear_asignacion.php?aula_id=${aula_id}&fecha=${fecha}&turno=${turno}`)
      .then(res => res.text())
      .then(html => {
        abrirModal({
          titulo: `➕ Agregar Asignación en ${nombreAula}`,
          html: html,
          focoSelector: '#entidad_id'
        });
      })
      .catch((err) => {
        mostrarMensaje('error', 'No se pudo cargar el formulario: ' + err.message);
      });
    return;
  }

  // Botón de editar asignación
  if (e.target.classList.contains('btn-editar-asignacion')) {
    const fecha = e.target.dataset.fecha;
    const aula_id = e.target.dataset.aula;
    const turno = e.target.dataset.turno;
    const state = getState();

    if (!state.datosGlobales || !Array.isArray(state.datosGlobales.asignaciones)) {
      mostrarMensaje('error', 'Los datos aún no están cargados');
      return;
    }

    const fechaFiltro = normalizarFecha(fecha);
    const asignaciones = state.datosGlobales.asignaciones.filter(a =>
      normalizarFecha(a.fecha) === fechaFiltro && a.aula_id == aula_id && a.turno === turno
    );

    if (asignaciones.length === 0) {
      mostrarMensaje('info', 'No hay asignaciones para editar');
      return;
    }

    const aula = state.datosGlobales.aulas.find(a => a.aula_id == aula_id);
    const nombreAula = aula ? aula.nombre : `Aula ${aula_id}`;

    abrirModal({
      titulo: `✏️ Editar Asignación en ${nombreAula}`,
      html: htmlSeleccionarAsignacion(asignaciones, aula_id, fecha, turno),
      focoSelector: '[name=asignacion_id]'
    });
    return;
  }

  // Botón de eliminar asignación
  if (e.target.classList.contains('btn-eliminar-asignacion') && id !== 'btn-eliminar-entidad') {
    const fecha = e.target.dataset.fecha;
    const aula_id = e.target.dataset.aula;
    const turno = e.target.dataset.turno;
    const state = getState();

    if (!state.datosGlobales || !Array.isArray(state.datosGlobales.asignaciones)) {
      mostrarMensaje('error', 'Los datos aún no están cargados');
      return;
    }

    const fechaFiltro = normalizarFecha(fecha);
    const asignaciones = state.datosGlobales.asignaciones.filter(a =>
      normalizarFecha(a.fecha) === fechaFiltro && a.aula_id == aula_id && a.turno === turno
    );

    if (asignaciones.length === 0) {
      mostrarMensaje('info', 'No hay asignaciones para eliminar');
      return;
    }

    const aula = state.datosGlobales.aulas.find(a => a.aula_id == aula_id);
    const nombreAula = aula ? aula.nombre : `Aula ${aula_id}`;

    abrirModal({
      titulo: `❌ Eliminar Asignación en ${nombreAula}`,
      html: htmlEliminarAsignacion(asignaciones, aula_id, fecha, turno),
      focoSelector: '[name=asignacion_id]'
    });
    return;
  }
});

export function renderLeyenda() {
  fetch('../acciones/get_entidades.php')
    .then(res => res.json())
    .then(data => {
      if (!data.ok || !Array.isArray(data.entidades)) {
        throw new Error('Respuesta inválida del servidor');
      }
      const contenedor = document.getElementById('leyenda-dinamica');
      contenedor.innerHTML = '';
      data.entidades.forEach(ent => {
        const span = document.createElement('span');
        span.className = 'leyenda-bloque';
        span.textContent = ent.nombre;
        span.style.backgroundColor = ent.color;
        span.style.color = '#fff';
        contenedor.appendChild(span);
      });
    })
    .catch((err) => {
      mostrarMensaje('error', 'No se pudo cargar la leyenda de entidades: ' + err.message);
    });
}

export function resetearVistaGeneral() {
  setState({ modoExtendido: false, aulaSeleccionada: null });
  const baseURL = window.location.origin + window.location.pathname;
  window.location.href = baseURL;
}
