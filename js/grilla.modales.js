
import { handlersFormulario } from './grilla.formularios.js';

function abrirModal({ html, envolver = true, idEsperado = null, focoSelector = null, contexto = null }) {
  const contenedor = document.getElementById('modal-formulario');
  if (!contenedor) return;

  // 🧼 Limpieza previa
  contenedor.innerHTML = '';
  contenedor.insertAdjacentHTML('afterbegin',
    envolver ? `<div class="modal-contenido">${html}</div>` : html
  );
  contenedor.style.display = 'flex';

  requestAnimationFrame(() => {
    const form = contenedor.querySelector('form');
    if (!form || (idEsperado && form.id !== idEsperado)) return;

    if (focoSelector) {
      form.querySelector(focoSelector)?.focus();
    }

    const formId = form.id.trim();
    const handler = handlersFormulario?.[formId];
    
  });
}

// 🧼 Cierre de modal
function cerrarModal() {
  const contenedor = document.getElementById('modal-formulario');
  if (contenedor) {
    contenedor.innerHTML = '';
    contenedor.style.display = 'none';
  }
}

// ➕ HTML para crear nueva entidad
function htmlNuevaEntidad() {
  return `
    <div class="modal-entidad">
      <h2 class="modal-titulo">➕ Nueva Entidad</h2>
      <form id="form-agregar-entidad" class="modal-formulario">
        <div class="campo-formulario">
          <label for="nombre">Nombre de la entidad</label>
          <input type="text" name="nombre" id="nombre" autocomplete="off" required />
        </div>
        <div class="campo-formulario">
          <label for="color">Color</label>
          <input type="color" name="color" id="color" value="#2196f3" />
        </div>
        <div id="aviso-duplicado" class="aviso-error fila-completa" style="display:none;"></div>
        <div class="form-buttons fila-completa">
          <button type="button" id="btn-cancelar-agregar">Cancelar</button>
          <button type="submit">✅ Guardar</button>
        </div>
      </form>
    </div>
  `;
}

// ❌ HTML para eliminar entidad
function htmlEliminarEntidad(entidades) {
  let html = `<div class="modal-contenido">
    <h3>❌ Eliminar entidad</h3>
    <form id="form-eliminar-entidad" class="modal-eliminar-form">`;

  entidades.forEach(ent => {
    html += `
      <div class="campo-formulario fila-completa">
        <label class="opcion-eliminar">
          <input type="radio" name="entidad_id" value="${ent.id}">
          <span style="background:${ent.color}; color:#fff; padding:4px 8px; border-radius:4px;">${ent.nombre}</span>
        </label>
      </div>`;
  });

  html += `
    <div class="form-buttons fila-completa">
      <button type="button" id="btn-cancelar-eliminar">Cancelar</button>
      <button type="submit">❌ Eliminar</button>
    </div>
  </form></div>`;

  return html;
}

// ❌ HTML para eliminar asignación
function htmlEliminarAsignacion(asignaciones, aula, fecha, turno) {
  let html = `
    <div class="modal-entidad">
      <h3 class="modal-titulo">❌ Eliminar asignación</h3>
      <form id="form-eliminar-asignacion" class="modal-eliminar-form">`;

  asignaciones.forEach(asig => {
    const detalle = `${asig.materia} – ${asig.hora_inicio.slice(0,5)}-${asig.hora_fin.slice(0,5)} – ${asig.profesor}`;
    html += `
      <label class="opcion-eliminar">
        <input type="radio" name="asignacion_id" value="${asig.Id}">
        <span>${detalle}</span>
      </label>`;
  });

  html += `
      <div class="campo-formulario fila-completa">
        <label>Eliminar asignación:</label>
        <div class="opciones-repeticion">
          <input type="radio" id="repetir_dia" name="repeticion" value="dia" checked>
          <label for="repetir_dia">Solo este día</label>

          <input type="radio" id="repetir_mes" name="repeticion" value="mes">
          <label for="repetir_mes">Todo el mes</label>

          <input type="radio" id="repetir_anio" name="repeticion" value="anio">
          <label for="repetir_anio">Todo el año</label>
        </div>
      </div>

      <input type="hidden" name="aula_id" value="${aula}">
      <input type="hidden" name="fecha" value="${fecha}">
      <input type="hidden" name="turno" value="${turno}">
      <div class="form-buttons fila-completa">
        <button type="button" id="btn-cancelar-eliminar">Cancelar</button>
        <button type="submit">❌ Eliminar</button>
      </div>
    </form>
  </div>`;

  return html;
}

export {
  abrirModal,
  cerrarModal,
  htmlNuevaEntidad,
  htmlEliminarEntidad,
  htmlEliminarAsignacion 
};
