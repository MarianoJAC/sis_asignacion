import { mostrarMensaje } from './grilla.alertas.js';
import { cerrarModal, abrirModal } from './grilla.modales.js';
import { actualizarGrilla, renderGrilla } from './grilla.render.js';
import { renderLeyenda } from './grilla.eventos.js';
import { esHorarioValido, haySolapamiento } from './grilla.validaciones.js';

export const handlersFormulario = {
  'form-agregar-asignacion': procesarAgregarAsignacion,
  'form-seleccionar-edicion': procesarSeleccionEdicion,
  'form-editar-asignacion': procesarEdicionAsignacion,
  'form-agregar-entidad': procesarAgregarEntidad,
  'form-eliminar-entidad': procesarEliminarEntidad,
  'form-eliminar-asignacion': procesarEliminarAsignacion
};

document.addEventListener('submit', e => {
  let form = e.target;
  if (!form || form.tagName.toUpperCase() !== 'FORM') {
    form = e.target.closest('form');
  }

  if (!form || typeof form.id !== 'string') return;

  const id = form.id.trim();
  const handler = handlersFormulario[id];
  if (!handler) return;

  e.preventDefault();
  const submitBtn = form.querySelector('button[type="submit"]');
  if (submitBtn) submitBtn.disabled = true;

  handler(form, submitBtn);
});

function procesarAgregarAsignacion(form, submitBtn) {
  if (!form || !submitBtn) return;
  if (submitBtn.dataset.enviando === 'true') return;

  submitBtn.dataset.enviando = 'true';
  submitBtn.disabled = true;

  const datos = {
    entidad_id: form.elements['entidad_id']?.value,
    carrera: form.elements['carrera']?.value.trim(),
    anio: form.elements['anio']?.value,
    materia: form.elements['materia']?.value.trim(),
    profesor: form.elements['profesor']?.value.trim(),
    hora_inicio: form.elements['hora_inicio']?.value,
    hora_fin: form.elements['hora_fin']?.value,
    comentarios: form.elements['comentarios']?.value.trim(),
    aula_id: form.elements['aula_id']?.value,
    fecha: form.elements['fecha']?.value,
    turno: form.elements['turno']?.value
  };

  if (!window.isAdmin) {
    mostrarMensaje('warning', 'Solo los administradores pueden agregar asignaciones');
    submitBtn.disabled = false;
    delete submitBtn.dataset.enviando;
    return;
  }

  if (!esHorarioValido(datos.hora_inicio, datos.hora_fin, datos.turno)) {
    mostrarMensaje('error', 'El horario no es válido para el turno seleccionado');
    submitBtn.disabled = false;
    delete submitBtn.dataset.enviando;
    return;
  }

  if (haySolapamiento(datos.turno, datos.hora_inicio, datos.hora_fin, datos.aula_id, datos.fecha)) {
    mostrarMensaje('error', 'El horario se solapa con otra asignación');
    submitBtn.disabled = false;
    delete submitBtn.dataset.enviando;
    return;
  }

  fetch('acciones/guardar_asignacion.php', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(datos)
  })
    .then(res => {
      if (!res.ok) throw new Error(`Error en guardar_asignacion: ${res.status} ${res.statusText}`);
      return res.json();
    })
    .then(data => {
      if (data.ok) {
        mostrarMensaje('success', 'Asignación guardada');
        cerrarModal();
        actualizarGrilla(datos.turno);
        renderLeyenda();
      } else {
        mostrarMensaje('error', data.error || 'Error al guardar');
      }
      submitBtn.disabled = false;
      delete submitBtn.dataset.enviando;
    })
    .catch(err => {
      console.error('[FORMULARIOS] Error en agregar:', err);
      mostrarMensaje('error', 'Error de red o servidor');
      submitBtn.disabled = false;
      delete submitBtn.dataset.enviando;
    });
}

function procesarSeleccionEdicion(form, submitBtn) {
  if (!form || !submitBtn) return;
  const id = form.querySelector('input[name="asignacion_id"]:checked')?.value;
  if (!id) {
    mostrarMensaje('warning', 'Seleccione una asignación');
    submitBtn.disabled = false;
    return;
  }

  const aula_id = form.elements['aula_id'].value;
  const fecha = form.elements['fecha'].value;
  const turno = form.elements['turno'].value;

  fetch(`acciones/get_asignacion.php?id=${id}`)
    .then(res => {
      if (!res.ok) throw new Error(`Error en get_asignacion: ${res.status} ${res.statusText}`);
      return res.json();
    })
    .then(data => {
      if (!data.ok || !data.asignacion) {
        mostrarMensaje('error', 'No se encontró la asignación');
        submitBtn.disabled = false;
        return;
      }
      fetch('acciones/get_entidades.php')
        .then(res => {
          if (!res.ok) throw new Error(`Error en get_entidades: ${res.status} ${res.statusText}`);
          return res.json();
        })
        .then(entidadesData => {
          abrirModal({
            html: htmlEditarAsignacion(data.asignacion, aula_id, fecha, turno, entidadesData.entidades),
            idEsperado: 'form-editar-asignacion',
            focoSelector: 'input#materia'
          });
          submitBtn.disabled = false;
        })
        .catch(err => {
          console.error('[FORMULARIOS] Error en get_entidades:', err);
          mostrarMensaje('error', 'Error al cargar entidades');
          submitBtn.disabled = false;
        });
    })
    .catch(err => {
      console.error('[FORMULARIOS] Error en edicion:', err);
      mostrarMensaje('error', 'Error al cargar el formulario');
      submitBtn.disabled = false;
    });
}

function procesarEdicionAsignacion(form, submitBtn) {
  if (!form || !submitBtn) return;
  if (submitBtn.dataset.enviando === 'true') return;

  submitBtn.dataset.enviando = 'true';
  submitBtn.disabled = true;

  const datos = {
    id: form.elements['id'].value,
    aula_id: form.elements['aula_id'].value,
    fecha: form.elements['fecha'].value,
    turno: form.elements['turno'].value,
    carrera: form.elements['carrera'].value.trim(),
    anio: form.elements['anio'].value,
    materia: form.elements['materia'].value.trim(),
    profesor: form.elements['profesor'].value.trim(),
    entidad_id: form.elements['entidad_id'].value,
    hora_inicio: form.elements['hora_inicio'].value,
    hora_fin: form.elements['hora_fin'].value,
    comentarios: form.elements['comentarios'].value.trim()
  };

  if (!window.isAdmin) {
    mostrarMensaje('warning', 'Solo los administradores pueden editar asignaciones');
    submitBtn.disabled = false;
    delete submitBtn.dataset.enviando;
    return;
  }

  if (!esHorarioValido(datos.hora_inicio, datos.hora_fin, datos.turno)) {
    mostrarMensaje('error', 'El horario no es válido para el turno seleccionado');
    submitBtn.disabled = false;
    delete submitBtn.dataset.enviando;
    return;
  }

  if (haySolapamiento(datos.turno, datos.hora_inicio, datos.hora_fin, datos.aula_id, datos.fecha, datos.id)) {
    mostrarMensaje('error', 'El horario se solapa con otra asignación');
    submitBtn.disabled = false;
    delete submitBtn.dataset.enviando;
    return;
  }

  fetch('acciones/editar_asignacion.php', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(datos)
  })
    .then(res => {
      if (!res.ok) throw new Error(`Error en editar_asignacion: ${res.status} ${res.statusText}`);
      return res.json();
    })
    .then(data => {
      if (data.ok) {
        mostrarMensaje('success', 'Asignación actualizada');
        cerrarModal();
        actualizarGrilla(datos.turno);
        renderLeyenda();
      } else {
        mostrarMensaje('error', data.error || 'Error al actualizar');
      }
      submitBtn.disabled = false;
      delete submitBtn.dataset.enviando;
    })
    .catch(err => {
      console.error('[FORMULARIOS] Error en editar:', err);
      mostrarMensaje('error', 'Error de red o servidor');
      submitBtn.disabled = false;
      delete submitBtn.dataset.enviando;
    });
}

function procesarAgregarEntidad(form, submitBtn) {
  if (!form || !submitBtn) return;
  if (submitBtn.dataset.enviando === 'true') return;

  submitBtn.dataset.enviando = 'true';
  submitBtn.disabled = true;

  const datos = {
    nombre: form.elements['nombre'].value.trim(),
    color: form.elements['color'].value
  };

  if (!window.isAdmin) {
    mostrarMensaje('warning', 'Solo los administradores pueden agregar entidades');
    submitBtn.disabled = false;
    delete submitBtn.dataset.enviando;
    return;
  }

  fetch('acciones/guardar_entidad.php', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(datos)
  })
    .then(res => {
      if (!res.ok) throw new Error(`Error en guardar_entidad: ${res.status} ${res.statusText}`);
      return res.json();
    })
    .then(data => {
      if (data.ok) {
        mostrarMensaje('success', 'Entidad guardada');
        cerrarModal();
        renderLeyenda();
      } else {
        mostrarMensaje('error', data.error || 'Error al guardar entidad');
      }
      submitBtn.disabled = false;
      delete submitBtn.dataset.enviando;
    })
    .catch(err => {
      console.error('[FORMULARIOS] Error en entidad:', err);
      mostrarMensaje('error', 'Error de red o servidor');
      submitBtn.disabled = false;
      delete submitBtn.dataset.enviando;
    });
}

function procesarEliminarEntidad(form, submitBtn) {
  if (!form || !submitBtn) return;
  const id = form.querySelector('input[name="entidad_id"]:checked')?.value;

  if (!id) {
    mostrarMensaje('warning', 'Seleccione una entidad');
    submitBtn.disabled = false;
    return;
  }

  if (!window.isAdmin) {
    mostrarMensaje('warning', 'Solo los administradores pueden eliminar entidades');
    submitBtn.disabled = false;
    return;
  }

  fetch('acciones/eliminar_entidad.php', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ entidad_id: id })
  })
    .then(res => {
      if (!res.ok) throw new Error(`Error en eliminar_entidad: ${res.status} ${res.statusText}`);
      return res.json();
    })
    .then(data => {
      if (data.ok) {
        mostrarMensaje('success', 'Entidad eliminada');
        cerrarModal();
        renderLeyenda();
      } else {
        mostrarMensaje('error', data.error || 'Error al eliminar');
      }
      submitBtn.disabled = false;
    })
    .catch(err => {
      console.error('[FORMULARIOS] Error en eliminar entidad:', err);
      mostrarMensaje('error', 'Error de red o servidor');
      submitBtn.disabled = false;
    });
}

function procesarEliminarAsignacion(form, submitBtn) {
  if (!form || !submitBtn) return;
  const id = form.querySelector('input[name="asignacion_id"]:checked')?.value || form.elements['asignacion_id']?.value;

  if (!id) {
    mostrarMensaje('warning', 'Seleccione una asignación');
    submitBtn.disabled = false;
    return;
  }

  const turnoActual = form.elements['turno'].value;

  if (!window.isAdmin) {
    mostrarMensaje('warning', 'Solo los administradores pueden eliminar asignaciones');
    submitBtn.disabled = false;
    return;
  }

  fetch('acciones/eliminar_asignacion.php', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ id })
  })
    .then(res => {
      if (!res.ok) throw new Error(`Error en eliminar_asignacion: ${res.status} ${res.statusText}`);
      return res.json();
    })
    .then(data => {
      if (data.ok) {
        mostrarMensaje('success', 'Asignación eliminada');
        cerrarModal();
        fetch('acciones/get_grilla.php')
          .then(res => {
            if (!res.ok) throw new Error(`Error en get_grilla: ${res.status} ${res.statusText}`);
            return res.json();
          })
          .then(grilla => {
            if (!grilla || !Array.isArray(grilla.asignaciones)) {
              mostrarMensaje('error', 'La grilla recibida es inválida');
              return;
            }

            window.datosGlobales = grilla;

            const targetId = `grilla-${turnoActual.toLowerCase()}`;
            const destino = document.getElementById(targetId);

            if (window.modoExtendido && destino) {
              renderGrilla(turnoActual, grilla, window.aulaSeleccionada, targetId);
            } else if (!window.modoExtendido) {
              window.forceRender = true;
              actualizarGrilla(turnoActual);
            } else {
              mostrarMensaje('error', 'No se encontró el contenedor de grilla');
            }

            renderLeyenda();
          })
          .catch(err => {
            console.error('[FORMULARIOS] Error en actualizar grilla:', err);
            mostrarMensaje('error', 'No se pudo actualizar la grilla');
          });
      } else {
        mostrarMensaje('error', data.error || 'Error al eliminar asignación');
      }
      submitBtn.disabled = false;
    })
    .catch(err => {
      console.error('[FORMULARIOS] Error en eliminar asignacion:', err);
      mostrarMensaje('error', 'Error de red o servidor');
      submitBtn.disabled = false;
    });
}

function htmlAgregarAsignacion(aula, fecha, turno, entidades = []) {
  let entidadesOptions = '<option value="">Seleccione una entidad</option>';
  entidades.forEach(ent => {
    entidadesOptions += `<option value="${ent.id}">${ent.nombre}</option>`;
  });

  return `
    <div class="modal-contenido">
      <h3>Agregar Asignación</h3>
      <form id="form-agregar-asignacion" class="modal-formulario">
        <input type="hidden" name="aula_id" value="${aula}">
        <input type="hidden" name="fecha" value="${fecha}">
        <input type="hidden" name="turno" value="${turno}">
        <label>
          Entidad:
          <select name="entidad_id" id="entidad_id" required>
            ${entidadesOptions}
          </select>
        </label>
        <label>
          Carrera:
          <input type="text" name="carrera" required>
        </label>
        <label>
          Año:
          <input type="number" name="anio" min="1" max="5" required>
        </label>
        <label>
          Materia:
          <input type="text" name="materia" required>
        </label>
        <label>
          Profesor:
          <input type="text" name="profesor" required>
        </label>
        <label>
          Hora Inicio:
          <input type="time" name="hora_inicio" required>
        </label>
        <label>
          Hora Fin:
          <input type="time" name="hora_fin" required>
        </label>
        <label>
          Comentarios:
          <textarea name="comentarios"></textarea>
        </label>
        <div class="form-buttons">
          <button type="button" id="btn-cancelar">Cancelar</button>
          <button type="submit">Guardar</button>
        </div>
      </form>
    </div>
  `;
}

function htmlEditarAsignacion(asignacion, aula, fecha, turno, entidades = []) {
  let entidadesOptions = entidades.map(ent => 
    `<option value="${ent.id}" ${ent.id === asignacion.entidad_id ? 'selected' : ''}>${ent.nombre}</option>`
  ).join('');

  return `
    <div class="modal-contenido">
      <h3>Editar Asignación</h3>
      <form id="form-editar-asignacion" class="modal-formulario">
        <input type="hidden" name="id" value="${asignacion.Id}">
        <input type="hidden" name="aula_id" value="${aula}">
        <input type="hidden" name="fecha" value="${fecha}">
        <input type="hidden" name="turno" value="${turno}">
        <label>
          Entidad:
          <select name="entidad_id" required>
            ${entidadesOptions}
          </select>
        </label>
        <label>
          Carrera:
          <input type="text" name="carrera" value="${asignacion.carrera}" required>
        </label>
        <label>
          Año:
          <input type="number" name="anio" value="${asignacion.anio}" min="1" max="5" required>
        </label>
        <label>
          Materia:
          <input type="text" name="materia" id="materia" value="${asignacion.materia}" required>
        </label>
        <label>
          Profesor:
          <input type="text" name="profesor" value="${asignacion.profesor}" required>
        </label>
        <label>
          Hora Inicio:
          <input type="time" name="hora_inicio" value="${asignacion.hora_inicio}" required>
        </label>
        <label>
          Hora Fin:
          <input type="time" name="hora_fin" value="${asignacion.hora_fin}" required>
        </label>
        <label>
          Comentarios:
          <textarea name="comentarios">${asignacion.comentarios || ''}</textarea>
        </label>
        <div class="form-buttons">
          <button type="button" id="btn-cancelar">Cancelar</button>
          <button type="submit">Actualizar</button>
        </div>
      </form>
    </div>
  `;
}

function htmlNuevaEntidad() {
  return `
    <div class="modal-contenido">
      <h3>Agregar Entidad</h3>
      <form id="form-agregar-entidad" class="modal-formulario">
        <label>
          Nombre:
          <input type="text" name="nombre" id="nombre" required>
        </label>
        <label>
          Color:
          <input type="color" name="color" required>
        </label>
        <div class="form-buttons">
          <button type="button" id="btn-cancelar">Cancelar</button>
          <button type="submit">Guardar</button>
        </div>
      </form>
    </div>
  `;
}

function htmlEliminarEntidad(entidades) {
  let html = `
    <div class="modal-contenido">
      <h3>Eliminar Entidad</h3>
      <form id="form-eliminar-entidad" class="modal-formulario">
  `;
  entidades.forEach(ent => {
    html += `
      <label class="opcion-eliminar">
        <input type="radio" name="entidad_id" value="${ent.id}"> ${ent.nombre}
      </label>
    `;
  });
  html += `
        <div class="form-buttons">
          <button type="button" id="btn-cancelar">Cancelar</button>
          <button type="submit">Eliminar</button>
        </div>
      </form>
    </div>
  `;
  return html;
}

function htmlEliminarAsignacion(id, aula, fecha, turno, asignacion) {
  return `
    <div class="modal-contenido">
      <h3>Eliminar Asignación</h3>
      <form id="form-eliminar-asignacion" class="modal-formulario">
        <input type="hidden" name="asignacion_id" value="${id}">
        <input type="hidden" name="aula_id" value="${aula}">
        <input type="hidden" name="fecha" value="${fecha}">
        <input type="hidden" name="turno" value="${turno}">
        <p>¿Estás seguro de eliminar la asignación de "${asignacion.materia}" (${asignacion.hora_inicio.slice(0,5)}-${asignacion.hora_fin.slice(0,5)}) en el aula ${aula}?</p>
        <div class="form-buttons">
          <button type="button" id="btn-cancelar">Cancelar</button>
          <button type="submit">Eliminar</button>
        </div>
      </form>
    </div>
  `;
}

export {
  procesarAgregarAsignacion,
  procesarSeleccionEdicion,
  procesarEdicionAsignacion,
  procesarAgregarEntidad,
  procesarEliminarEntidad,
  procesarEliminarAsignacion,
  htmlAgregarAsignacion,
  htmlEditarAsignacion,
  htmlNuevaEntidad,
  htmlEliminarEntidad,
  htmlEliminarAsignacion
};