function abrirModal({ html, envolver = true, idEsperado = null, focoSelector = null, contexto = null }) {
  const contenedor = document.getElementById('modal-formulario');
  if (!contenedor) return;

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

    // 🛡️ Interceptor manual directo sobre el form detectado
    const handler = handlersFormulario?.[form.id];
    if (typeof handler === 'function') {
      form.addEventListener('submit', e => {
        e.preventDefault();
        const submitBtn = form.querySelector('button[type="submit"]');
        if (submitBtn) submitBtn.disabled = true;
        handler(form, submitBtn);
      }, { once: true }); // ✅ Solo una vez
    }
  });
}

// 🧼 Cierre de modal
function cerrarModal() {
  const contenedor = document.getElementById('modal-formulario');
  if (contenedor) {
    contenedor.innerHTML = '';
    contenedor.style.display = 'none';
    console.log('🧼 Modal cerrado');
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
          <input type="radio" name="entidad_id" value="${ent.entidad_id}">
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
function htmlEliminarAsignacion(asignaciones, aula, dia, turno) {
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
      <input type="hidden" name="aula_id" value="${aula}">
      <input type="hidden" name="dia" value="${dia}">
      <input type="hidden" name="turno" value="${turno}">
      <div class="form-buttons fila-completa">
        <button type="button" id="btn-cancelar-eliminar">Cancelar</button>
        <button type="submit">❌ Eliminar</button>
      </div>
    </form>
  </div>`;

  return html;
}