import { mostrarMensaje } from './grilla.alertas.js';
import { cerrarModal, abrirModal } from './grilla.modales.js';
import { actualizarGrilla, renderGrilla } from './grilla.render.js';
import { renderLeyenda } from './grilla.eventos.js';
import { esHorarioValido, haySolapamiento } from './grilla.validaciones.js';
import { fetchGrillaData } from './grilla.core.js';
import { getState, setState } from './grilla.state.js';

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
    turno: form.elements['turno']?.value,
    repeticion: form.elements['repeticion']?.value
  };

  if (!datos.entidad_id || !datos.materia || !datos.profesor || !datos.hora_inicio || !datos.hora_fin || !datos.aula_id || !datos.fecha || !datos.turno) {
    mostrarMensaje('warning', 'Completá todos los campos obligatorios');
    submitBtn.disabled = false;
    submitBtn.dataset.enviando = 'false';
    return;
  }

  if (!esHorarioValido(datos.hora_inicio, datos.hora_fin, datos.turno)) {
    mostrarMensaje('warning', `El horario no coincide con el turno ${datos.turno}. Usá un rango permitido.`);
    submitBtn.disabled = false;
    submitBtn.dataset.enviando = 'false';
    return;
  }

  if (haySolapamiento(datos.turno, datos.hora_inicio, datos.hora_fin, datos.aula_id, datos.fecha)) {
    mostrarMensaje('error', 'Ya existe una asignación en ese horario para esa aula y día.');
    submitBtn.disabled = false;
    submitBtn.dataset.enviando = 'false';
    return;
  }

  fetch('../acciones/guardar_asignacion.php', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(datos)
  })
    .then(res => {
      if (!res.ok) throw new Error(`Error ${res.status}`);
      return res.json();
    })
    .then(data => {
      if (data.ok) {
        mostrarMensaje('success', data.mensaje || 'Asignación registrada con éxito');
        cerrarModal();

        const turnoActual = datos.turno || 'Matutino';

        fetchGrillaData()
          .then(grilla => {
            const targetId = `grilla-${turnoActual.toLowerCase()}`;
            const destino = document.getElementById(targetId);
            const state = getState();

            if (state.modoExtendido && destino) {
              renderGrilla(turnoActual, grilla, state.aulaSeleccionada, targetId);
            } else if (!state.modoExtendido) {
              setState({ forceRender: true });
              actualizarGrilla(turnoActual);
            } else {
              mostrarMensaje('error', 'No se encontró el contenedor de grilla');
            }

            renderLeyenda();
          })
          .catch((err) => {
            mostrarMensaje('error', 'No se pudo actualizar la grilla: ' + err.message);
          });

      } else {
        mostrarMensaje('error', data.error || 'Error al guardar asignación');
        submitBtn.disabled = false;
        submitBtn.dataset.enviando = 'false';
      }
    })
    .catch(err => {
      mostrarMensaje('error', `Error del servidor: ${err.message}`);
      submitBtn.disabled = false;
      submitBtn.dataset.enviando = 'false';
    });
}

function procesarSeleccionEdicion(form, submitBtn) {
  const id = form.elements['asignacion_id']?.value;
  const aula_id = form.elements['aula_id']?.value;
  const fecha = form.elements['fecha']?.value;
  const turno = form.elements['turno']?.value;

  if (!id || !aula_id || !fecha || !turno) {
    mostrarMensaje('warning', 'Faltan datos para editar');
    if (submitBtn) submitBtn.disabled = false;
    return;
  }

  fetch(`../acciones/form_editar_asignacion.php?id=${id}&aula_id=${aula_id}&fecha=${fecha}&turno=${turno}`)
    .then(res => res.text())
    .then(html => {
      abrirModal({
        html,
        idEsperado: 'form-editar-asignacion',
        focoSelector: 'button[type="submit"]',
        contexto: { id, aula_id, fecha, turno }
      });

      const formEdit = document.getElementById('form-editar-asignacion');
      if (!formEdit) return;

      const formClonado = formEdit.cloneNode(true);
      formEdit.replaceWith(formClonado);

      formClonado.addEventListener('submit', e => {
        e.preventDefault();
        const submitBtn = formClonado.querySelector('button[type="submit"]');
        if (submitBtn) submitBtn.disabled = true;
        procesarEdicionAsignacion(formClonado, submitBtn);
      }, { once: true });
    })
    .catch((err) => {
      mostrarMensaje('error', 'Error inesperado: ' + err.message);
      if (submitBtn) submitBtn.disabled = false;
    });
}


function procesarEdicionAsignacion(form, submitBtn) {
  const datos = {
    id: form.elements['id']?.value,
    aula_id: form.elements['aula_id']?.value,
    fecha: form.elements['fecha']?.value,
    turno: form.elements['turno']?.value,
    entidad_id: form.elements['entidad_id']?.value,
    carrera: form.elements['carrera']?.value?.trim() || '',
    anio: form.elements['anio']?.value,
    materia: form.elements['materia']?.value?.trim() || '',
    profesor: form.elements['profesor']?.value?.trim() || '',
    hora_inicio: form.elements['hora_inicio']?.value,
    hora_fin: form.elements['hora_fin']?.value,
    comentarios: form.elements['comentarios']?.value?.trim() || ''
  };

  if (!datos.id || !datos.aula_id || !datos.fecha || !datos.turno || !datos.entidad_id || !datos.materia || !datos.profesor || !datos.hora_inicio || !datos.hora_fin) {
    mostrarMensaje('warning', 'Completá todos los campos obligatorios');
    if (submitBtn) submitBtn.disabled = false;
    return;
  }

  if (!esHorarioValido(datos.hora_inicio, datos.hora_fin, datos.turno)) {
    mostrarMensaje('warning', `El horario no coincide con el turno ${datos.turno}. Usá un rango permitido.`);
    if (submitBtn) submitBtn.disabled = false;
    return;
  }

  if (haySolapamiento(datos.turno, datos.hora_inicio, datos.hora_fin, datos.aula_id, datos.fecha, datos.id)) {
    mostrarMensaje('error', 'Ya existe una asignación en ese horario para esa aula y día.');
    if (submitBtn) submitBtn.disabled = false;
    return;
  }

  fetch('../acciones/editar_asignacion.php', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(datos)
  })
    .then(res => res.text())
    .then(texto => {
      try {
        const data = JSON.parse(texto.trim());

        if (data.ok) {
          mostrarMensaje('success', data.mensaje || 'Asignación actualizada');
          cerrarModal();

          const turnoActual = datos.turno || 'Matutino';

          fetchGrillaData()
            .then(grilla => {
              const targetId = `grilla-${turnoActual.toLowerCase()}`;
              const destino = document.getElementById(targetId);
              const state = getState();

              if (state.modoExtendido && destino) {
                renderGrilla(turnoActual, grilla, state.aulaSeleccionada, targetId);
              } else if (!state.modoExtendido) {
                setState({ forceRender: true });
                actualizarGrilla(turnoActual);
              } else {
                mostrarMensaje('error', 'No se encontró el contenedor de grilla');
              }

              renderLeyenda();
            })
            .catch((err) => {
              mostrarMensaje('error', 'No se pudo actualizar la grilla: ' + err.message);
            });

        } else {
          mostrarMensaje('error', data.error || 'Error al actualizar asignación');
          if (submitBtn) submitBtn.disabled = false;
        }
      } catch (err) {
        mostrarMensaje('error', 'Respuesta inválida del servidor: ' + err.message);
        if (submitBtn) submitBtn.disabled = false;
      }
    })
    .catch((err) => {
      mostrarMensaje('error', 'Error inesperado: ' + err.message);
      if (submitBtn) submitBtn.disabled = false;
    });
}


function procesarAgregarEntidad(form, submitBtn) {
  if (form.dataset.agregando === 'true') return;
  form.dataset.agregando = 'true';

  const nombre = form.elements['nombre']?.value?.trim();
  const color = form.elements['color']?.value?.trim();

  if (!nombre || !color) {
    mostrarMensaje('info', 'Completá todos los campos');
    form.dataset.agregando = 'false';
    if (submitBtn) submitBtn.disabled = false;
    return;
  }

  const payload = { nombre, color };

  fetch('../acciones/agregar_entidad.php', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(payload)
  })
    .then(res => res.json())
    .then(data => {
      if (data.ok) {
        mostrarMensaje('success', 'Entidad agregada correctamente');
        cerrarModal();

        const turnoActual = document.querySelector('.tab-btn.active')?.dataset.turno || 'Matutino';
        fetchGrillaData()
          .then(grilla => {
            setState({ datosGlobales: grilla, forceRender: true });
            actualizarGrilla(turnoActual);
            renderLeyenda();
          })
          .catch((err) => {
            mostrarMensaje('error', 'No se pudo actualizar la grilla: ' + err.message);
          });

      } else {
        mostrarMensaje('error', data.error || 'Error al agregar entidad');
        form.dataset.agregando = 'false';
        if (submitBtn) submitBtn.disabled = false;
      }
    })
    .catch((err) => {
      mostrarMensaje('error', 'Error inesperado: ' + err.message);
      form.dataset.agregando = 'false';
      if (submitBtn) submitBtn.disabled = false;
    });
}

function procesarEliminarEntidad(form, submitBtn) {
  if (form.dataset.eliminando === 'true') return;
  form.dataset.eliminando = 'true';

  const id = form.elements['entidad_id']?.value;

  if (!id) {
    mostrarMensaje('info', 'Seleccioná una entidad para eliminar');
    form.dataset.eliminando = 'false';
    if (submitBtn) submitBtn.disabled = false;
    return;
  }

  fetch('../acciones/eliminar_entidad.php', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ entidad_id: parseInt(id) })
  })
    .then(res => res.json())
    .then(data => {
      if (data.ok) {
        mostrarMensaje('success', 'Entidad eliminada correctamente');
        cerrarModal();

        const turnoActual = document.querySelector('.tab-btn.active')?.dataset.turno || 'Matutino';
        fetchGrillaData()
          .then(grilla => {
            setState({ datosGlobales: grilla, forceRender: true });
            actualizarGrilla(turnoActual);
            renderLeyenda();
          })
          .catch((err) => {
            mostrarMensaje('error', 'No se pudo actualizar la grilla: ' + err.message);
          });

      } else {
        mostrarMensaje('error', data.error || 'Error al eliminar entidad');
        form.dataset.eliminando = 'false';
        if (submitBtn) submitBtn.disabled = false;
      }
    })
    .catch((err) => {
      mostrarMensaje('error', 'Error inesperado: ' + err.message);
      form.dataset.eliminando = 'false';
      if (submitBtn) submitBtn.disabled = false;
    });
}

function procesarEliminarAsignacion(form, submitBtn) {
  const id = form.elements['asignacion_id']?.value;

  if (!id) {
    mostrarMensaje('info', 'Seleccioná una asignación para eliminar');
    if (submitBtn) submitBtn.disabled = false;
    return;
  }

  const repeticion = form.elements['repeticion']?.value || 'dia';

  const datos = { id, repeticion };

  fetch('../acciones/eliminar_asignacion.php', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(datos)
  })
    .then(res => res.text())
    .then(texto => {
      try {
        const data = JSON.parse(texto.trim());

        if (data.ok) {
          mostrarMensaje('success', data.mensaje || 'Asignación eliminada correctamente');
          cerrarModal();

          const turnoActual = form.elements['turno']?.value || 'Matutino';

          fetchGrillaData()
            .then(grilla => {
              const targetId = `grilla-${turnoActual.toLowerCase()}`;
              const destino = document.getElementById(targetId);
              const state = getState();

              if (state.modoExtendido && destino) {
                renderGrilla(turnoActual, grilla, state.aulaSeleccionada, targetId);
              } else if (!state.modoExtendido) {
                setState({ forceRender: true });
                actualizarGrilla(turnoActual);
              } else {
                mostrarMensaje('error', 'No se encontró el contenedor de grilla');
              }

              renderLeyenda();
            })
            .catch((err) => {
              mostrarMensaje('error', 'No se pudo actualizar la grilla: ' + err.message);
            });

        } else {
          mostrarMensaje('error', data.error || 'Error al eliminar asignación');
          if (submitBtn) submitBtn.disabled = false;
        }
      } catch (err) {
        mostrarMensaje('error', 'Respuesta inválida del servidor: ' + err.message);
        if (submitBtn) submitBtn.disabled = false;
      }
    })
    .catch((err) => {
      mostrarMensaje('error', 'Error inesperado: ' + err.message);
      if (submitBtn) submitBtn.disabled = false;
    });
}
function interceptarFormulario(id, handler) {
  const form = document.getElementById(id);
  if (!form) return;

  form.addEventListener('submit', e => {
    e.preventDefault();
    const submitBtn = form.querySelector('button[type="submit"]');
    if (submitBtn) submitBtn.disabled = true;
    handler(form, submitBtn);
  });
}


export {
  procesarAgregarAsignacion,
  procesarSeleccionEdicion,
  procesarEdicionAsignacion,
  procesarAgregarEntidad,
  procesarEliminarEntidad,
  procesarEliminarAsignacion,
  interceptarFormulario
};
