// 🔄 Botón cancelar (delegado)
document.addEventListener('click', e => {
  const id = e.target?.id;
  if (id === 'btn-cancelar-creacion' || id === 'btn-cancelar-eliminacion') {
    cerrarModal();
  }
});

function cerrarModal() {
  const contenedor = document.getElementById('modal-formulario');
  contenedor.innerHTML = '';
  contenedor.style.display = 'none';
}

function esHorarioValido(horaInicio, horaFin, turno) {
  const [hI, mI] = horaInicio.split(':').map(Number);
  const [hF, mF] = horaFin.split(':').map(Number);
  const minutosInicio = hI * 60 + mI;
  const minutosFin = hF * 60 + mF;

  if (minutosFin <= minutosInicio) return false;

  const rangoTurno = {
    'Matutino':   [360, 840],
    'Vespertino': [840, 1080],    // 14:00 - 18:00
    'Nocturno':   [1080, 1380]
  };

  const [desde, hasta] = rangoTurno[turno] || [0, 1440];
  return minutosInicio >= desde && minutosFin <= hasta;
}

// ✅ Intercepta formularios de creación, edición o eliminación de asignación
document.addEventListener('submit', async e => {
  const form = e.target;

  // 🔹 Formulario de creación o edición de asignación
  if (form.id === 'form-agregar-asignacion' || form.id === 'form-editar-asignacion') {
    e.preventDefault();

    const turno = form.querySelector('input[name="turno"]')?.value || 'Matutino';
    const horaInicio = form.querySelector('[name="hora_inicio"]')?.value;
    const horaFin = form.querySelector('[name="hora_fin"]')?.value;
    const aula_id = form.querySelector('[name="aula_id"]')?.value;
    const dia = form.querySelector('[name="dia"]')?.value;
    const idActual = form.querySelector('[name="id"]')?.value || null;

    if (!esHorarioValido(horaInicio, horaFin, turno)) {
      mostrarMensaje('warning', `⏱️ El horario no coincide con el turno ${turno}. Usá un rango permitido.`);
      return;
    }

    if (haySolapamiento(turno, horaInicio, horaFin, aula_id, dia, idActual)) {
      mostrarMensaje('error', '🚫 Ya existe una asignación en ese horario para esa aula y día.');
      return;
    }

    const formData = new FormData(form);
    const data = Object.fromEntries(formData.entries());

    fetch(form.action, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(data)
    })
      .then(res => res.json())
      .then(resp => {
        if (resp.ok) {
          const mensaje = idActual ? 'Asignación actualizada con éxito' : 'Asignación registrada con éxito';
          mostrarMensaje('success', resp.mensaje || mensaje);
          cerrarModal();
          actualizarGrilla(turno);
        } else {
          mostrarMensaje('error', resp.error || 'Error desconocido');
        }
      })
      .catch(err => {

        mostrarMensaje('error', '❌ Error inesperado');
      });

    return;
  }

  // 🔹 Formulario de eliminación de asignación
  if (form.id === 'form-eliminar-asignacion') {
    e.preventDefault();
    const seleccion = form.querySelector('input[name="asignacion_id"]:checked')?.value;
    if (!seleccion) {
      mostrarMensaje('warning', '⚠️ Seleccioná una asignación para eliminar.');
      return;
    }

    fetch(`../acciones/eliminar_asignacion.php?id=${seleccion}`, { method: 'POST' })
      .then(res => res.text())
      .then(resp => {
        if (resp.includes('✅')) {
          mostrarMensaje('success', 'Asignación eliminada');
          cerrarModal();
          const turnoActivo = document.querySelector('.tab-btn.active')?.dataset.turno || 'Matutino';
          actualizarGrilla(turnoActivo);
        } else {
          mostrarMensaje('error', resp);
        }
      })
      .catch(err => {

        mostrarMensaje('error', '❌ Error inesperado');
      });

    return;
  }
});