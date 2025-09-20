import { handlersFormulario } from './grilla.formularios.js';

// Instancia del modal de Bootstrap
const modalElement = document.getElementById('main-modal');
const bootstrapModal = new bootstrap.Modal(modalElement);

/**
 * Abre el modal de Bootstrap con el contenido y título especificados.
 * @param {{titulo: string, html: string, focoSelector?: string}} options
 */
function abrirModal({ titulo, html, focoSelector = null }) {
  const modalTitle = modalElement.querySelector('.modal-title');
  const modalBody = modalElement.querySelector('.modal-body');

  modalTitle.textContent = titulo;
  modalBody.innerHTML = html;

  bootstrapModal.show();

  // Enfocar el primer campo del formulario después de que el modal sea visible
  modalElement.addEventListener('shown.bs.modal', () => {
    if (focoSelector) {
      modalBody.querySelector(focoSelector)?.focus();
    }
  }, { once: true });
}

/**
 * Cierra el modal de Bootstrap.
 */
function cerrarModal() {
  bootstrapModal.hide();
}

// ➕ HTML para crear nueva entidad
function htmlNuevaEntidad() {
  const formHtml = `
    <form id="form-agregar-entidad">
      <div class="mb-3">
        <label for="nombre" class="form-label">Nombre de la entidad</label>
        <input type="text" name="nombre" id="nombre" class="form-control" autocomplete="off" required />
      </div>
      <div class="mb-3">
        <label for="color" class="form-label">Color</label>
        <input type="color" name="color" id="color" class="form-control form-control-color" value="#2196f3" />
      </div>
      <div id="aviso-duplicado" class="alert alert-danger" style="display:none;"></div>
      <div class="modal-footer d-flex justify-content-center">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
        <button type="submit" class="btn btn-primary">✅ Guardar</button>
      </div>
    </form>
  `;
  return formHtml;
}

// ❌ HTML para eliminar entidad
function htmlEliminarEntidad(entidades) {
  let optionsHtml = '<ul class="list-group">';
  entidades.forEach(ent => {
    optionsHtml += `
      <li class="list-group-item">
        <input class="form-check-input me-1" type="radio" name="entidad_id" id="entidad-${ent.id}" value="${ent.id}">
        <label class="form-check-label" for="entidad-${ent.id}">
          <span class="badge" style="background-color:${ent.color};">${ent.nombre}</span>
        </label>
      </li>
    `;
  });
  optionsHtml += '</ul>';

  const formHtml = `
    <form id="form-eliminar-entidad">
      <p>Seleccione la entidad que desea eliminar:</p>
      <div class="mb-3">${optionsHtml}</div>
      <div class="modal-footer d-flex justify-content-center">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
        <button type="submit" class="btn btn-danger">❌ Eliminar</button>
      </div>
    </form>
  `;
  return formHtml;
}

// ❌ HTML para eliminar asignación
function htmlEliminarAsignacion(asignaciones, aula, fecha, turno) {
  let optionsHtml = '<ul class="list-group mb-3">';
  asignaciones.forEach(asig => {
    const detalle = `${asig.materia} – ${asig.hora_inicio.slice(0,5)}-${asig.hora_fin.slice(0,5)} – ${asig.profesor}`;
    optionsHtml += `
      <li class="list-group-item">
        <input class="form-check-input me-1" type="radio" name="asignacion_id" id="asig-${asig.Id}" value="${asig.Id}">
        <label class="form-check-label" for="asig-${asig.Id}">${detalle}</label>
      </li>
    `;
  });
  optionsHtml += '</ul>';

  const formHtml = `
    <form id="form-eliminar-asignacion">
      <div class="mb-3">
        <p class="fw-bold">Seleccione la asignación a eliminar:</p>
        ${optionsHtml}
      </div>
      <div class="mb-3">
        <p class="fw-bold">Opciones de eliminación:</p>
        <div class="form-check">
          <input class="form-check-input" type="radio" id="repetir_dia" name="repeticion" value="dia" checked>
          <label class="form-check-label" for="repetir_dia">Solo este día</label>
        </div>
        <div class="form-check">
          <input class="form-check-input" type="radio" id="repetir_mes" name="repeticion" value="mes">
          <label class="form-check-label" for="repetir_mes">Todo el mes</label>
        </div>
        <div class="form-check">
          <input class="form-check-input" type="radio" id="repetir_anio" name="repeticion" value="anio">
          <label class="form-check-label" for="repetir_anio">Todo el año</label>
        </div>
      </div>
      <input type="hidden" name="aula_id" value="${aula}">
      <input type="hidden" name="fecha" value="${fecha}">
      <input type="hidden" name="turno" value="${turno}">
      <div class="modal-footer d-flex justify-content-center">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
        <button type="submit" class="btn btn-danger">❌ Eliminar</button>
      </div>
    </form>
  `;
  return formHtml;
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

export {
  abrirModal,
  cerrarModal,
  htmlNuevaEntidad,
  htmlEliminarEntidad,
  htmlEliminarAsignacion,
  htmlSeleccionarAsignacion
};