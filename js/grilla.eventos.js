import { abrirModal, cerrarModal } from './grilla.modales.js';
import { mostrarMensaje } from './grilla.alertas.js';
import {
  htmlNuevaEntidad,
  htmlEliminarEntidad
} from './grilla.formularios.js';
import { htmlEliminarAsignacion } from './grilla.modales.js';
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


  document.body.classList.remove('modo-extendido'); // ✅ Clave para mostrar los botones

  setState({
    modoExtendido: false,
    aulaSeleccionada: null,
    yaRenderizado: false,
  });

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

  // 🔄 Actualizar grilla
  actualizarGrilla(turno);

  // ✅ Actualizar botón activo
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
      html: htmlNuevaEntidad(),
      idEsperado: 'form-agregar-entidad',
      focoSelector: 'input#nombre',
      contexto: 'Agregar nueva entidad'
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
          html: htmlEliminarEntidad(entidades),
          idEsperado: 'form-eliminar-entidad',
          focoSelector: 'button[type="submit"]',
          contexto: { entidades }
        });
      })
      .catch((err) => {
        mostrarMensaje('error', 'No se pudo cargar las entidades: ' + err.message);
      });
    return;
  }

  // Botón cancelar (delegado)
  if (
    id === 'btn-cancelar-agregar' ||
    id === 'btn-cancelar-eliminar' ||
    id === 'btn-cancelar-creacion' ||
    id === 'btn-cancelar-edicion' ||
    id === 'btn-cancelar-eliminacion'
  ) {
    cerrarModal();
    return;
  }

  // Botón de agregar asignación
  if (e.target.classList.contains('btn-agregar') && id !== 'btn-agregar-entidad') {
    const aula_id = e.target.dataset.aula;
    const fecha = e.target.dataset.fecha;
    const turno = e.target.dataset.turno || 'Matutino';


    fetch(`../acciones/form_crear_asignacion.php?aula_id=${aula_id}&fecha=${fecha}&turno=${turno}`)
      .then(res => res.text())
      .then(html => {
        abrirModal({
          html,
          idEsperado: 'form-agregar-asignacion',
          focoSelector: 'button[type="submit"]',
          contexto: { aula_id, fecha, turno }
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
    const aula = e.target.dataset.aula;
    const turno = e.target.dataset.turno; // 🐞 FIX
    const state = getState();

    if (!state.datosGlobales || !Array.isArray(state.datosGlobales.asignaciones)) {
      mostrarMensaje('error', 'Los datos aún no están cargados');
      return;
    }

    const fechaFiltro = normalizarFecha(fecha);
    const asignaciones = state.datosGlobales.asignaciones.filter(a =>
      normalizarFecha(a.fecha) === fechaFiltro &&
      a.aula_id == aula &&
      a.turno === turno
    );

    if (asignaciones.length === 0) {
      mostrarMensaje('info', 'No hay asignaciones para editar');
      return;
    }

    abrirModal({
      html: htmlSeleccionarAsignacion(asignaciones, aula, fecha, turno),
      idEsperado: 'form-seleccionar-edicion',
      focoSelector: 'button[type="submit"]',
      contexto: { aula, fecha, turno }
    });
    return;
  }

  // Botón de eliminar asignación
  if (e.target.classList.contains('btn-eliminar-asignacion') && id !== 'btn-eliminar-entidad') {
    const fecha = e.target.dataset.fecha;
    const aula = e.target.dataset.aula;
    const turno = e.target.dataset.turno; // 🐞 FIX
    const state = getState();

    if (!state.datosGlobales || !Array.isArray(state.datosGlobales.asignaciones)) {
      mostrarMensaje('error', 'Los datos aún no están cargados');
      return;
    }

    const fechaFiltro = normalizarFecha(fecha);
    const asignaciones = state.datosGlobales.asignaciones.filter(a =>
      normalizarFecha(a.fecha) === fechaFiltro &&
      a.aula_id == aula &&
      a.turno === turno
    );

    if (asignaciones.length === 0) {
      mostrarMensaje('info', 'No hay asignaciones para eliminar');
      return;
    }

    abrirModal({
      html: htmlEliminarAsignacion(asignaciones, aula, fecha, turno),
      idEsperado: 'form-eliminar-asignacion',
      focoSelector: 'button[type="submit"]',
      contexto: { aula, fecha, turno }
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

function htmlSeleccionarAsignacion(asignaciones, aula, fecha, turno) {
  let html = `<div class="modal-contenido">
    <h3>Seleccioná una asignación para editar</h3>
    <form id="form-seleccionar-edicion" class="modal-formulario">`;

  asignaciones.forEach(asig => {
    const detalle = `${asig.materia} – ${asig.hora_inicio.slice(0,5)}-${asig.hora_fin.slice(0,5)} – ${asig.profesor}`;
    html += `<label class="opcion-eliminar">
      <input type="radio" name="asignacion_id" value="${asig.Id}"> ${detalle}
    </label>`;
  });

  html += `
    <input type="hidden" name="aula_id" value="${aula}">
    <input type="hidden" name="fecha" value="${fecha}">
    <input type="hidden" name="turno" value="${turno}">

    <div class="form-buttons">
      <button type="button" id="btn-cancelar-edicion">Cancelar</button>
      <button type="submit">✏️ Editar</button>
    </div>
  </form></div>`;

  return html;
}

export function resetearVistaGeneral() {


  setState({
    modoExtendido: false,
    aulaSeleccionada: null,
  });

  // 🧼 Limpia parámetros de la URL
  const baseURL = window.location.origin + window.location.pathname;

  // 🔄 Fuerza redirección sin parámetros
  window.location.href = baseURL;
}