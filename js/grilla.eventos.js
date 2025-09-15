import { abrirModal, cerrarModal } from './grilla.modales.js';
import { mostrarMensaje } from './grilla.alertas.js';
import {
  htmlNuevaEntidad,
  htmlEliminarEntidad,
  htmlEliminarAsignacion
} from './grilla.formularios.js';
import { actualizarGrilla, renderVistaGeneral } from './grilla.render.js';
import { normalizarFecha } from './grilla.filtros.js';

document.addEventListener('click', e => {
  const id = e.target.id;

  // 🟢 Botón "Todas las Aulas"
  const btnTodas = e.target.closest('#btn-ver-todas');
  if (btnTodas) {
    e.preventDefault();
    console.log('[EVENTOS] Click en "Ver todas las aulas"');

    window.modoExtendido = false;
    window.aulaSeleccionada = null;
    window.yaRenderizado = false;

    import('./grilla.render.js').then(mod => {
      mod.actualizarVisibilidadFiltros();
      mod.renderVistaGeneral();
      renderLeyenda();
    });

    return;
  }

  // 🟡 Tabs de turno
  if (e.target.classList.contains('tab-btn')) {
    const turno = e.target.dataset.turno;
    actualizarGrilla(turno);
    return;
  }

  // Botón de agregar entidad
  if (id === 'btn-agregar-entidad') {
    e.stopPropagation();
    if (!window.isAdmin) {
      mostrarMensaje('warning', 'Solo los administradores pueden agregar entidades');
      return;
    }
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
    if (!window.isAdmin) {
      mostrarMensaje('warning', 'Solo los administradores pueden eliminar entidades');
      return;
    }
    fetch('acciones/get_entidades.php')
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
      });
    return;
  }

  // Botón de eliminar asignación
  if (id === 'btn-eliminar-asignacion') {
    e.stopPropagation();
    if (!window.isAdmin) {
      mostrarMensaje('warning', 'Solo los administradores pueden eliminar asignaciones');
      return;
    }
    const aula = e.target.dataset.aulaId;
    const fecha = e.target.dataset.fecha;
    const turno = e.target.dataset.turno;
    fetch(`acciones/get_asignaciones.php?aula_id=${aula}&fecha=${fecha}&turno=${turno}`)
      .then(res => res.json())
      .then(data => {
        if (!data.ok || !data.asignaciones || data.asignaciones.length === 0) {
          mostrarMensaje('info', 'No hay asignaciones para eliminar');
          return;
        }
        abrirModal({
          html: htmlEliminarAsignacion(data.asignaciones, aula, fecha, turno),
          idEsperado: 'form-eliminar-asignacion',
          focoSelector: 'button[type="submit"]',
          contexto: { asignaciones: data.asignaciones }
        });
      });
    return;
  }

  // Botón de editar asignación
  if (id === 'btn-editar-asignacion') {
    e.stopPropagation();
    if (!window.isAdmin) {
      mostrarMensaje('warning', 'Solo los administradores pueden editar asignaciones');
      return;
    }
    const aula = e.target.dataset.aulaId;
    const fecha = e.target.dataset.fecha;
    const turno = e.target.dataset.turno;
    fetch(`acciones/get_asignaciones.php?aula_id=${aula}&fecha=${fecha}&turno=${turno}`)
      .then(res => res.json())
      .then(data => {
        if (!data.ok || !data.asignaciones || data.asignaciones.length === 0) {
          mostrarMensaje('info', 'No hay asignaciones para editar');
          return;
        }
        abrirModal({
          html: htmlSeleccionarAsignacion(data.asignaciones, aula, fecha, turno),
          idEsperado: 'form-seleccionar-edicion',
          focoSelector: 'input[name="asignacion_id"]',
          contexto: { asignaciones: data.asignaciones }
        });
      });
    return;
  }
});

function renderLeyenda() {
  fetch('acciones/get_entidades.php')
    .then(res => res.json())
    .then(data => {
      if (!data.ok || !Array.isArray(data.entidades)) {
        throw new Error();
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
    .catch(() => {
      mostrarMensaje('error', 'No se pudo cargar la leyenda de entidades');
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
  console.log('[EVENTOS] Ejecutando reset de vista general');

  window.modoExtendido = false;
  window.aulaSeleccionada = null;

  const baseURL = window.location.origin + window.location.pathname;
  window.location.href = baseURL;
}

export { renderLeyenda };