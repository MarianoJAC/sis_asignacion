const iconoRecurso = {
  'Proyector': '<i class="fas fa-video"></i>',
  'TV': '<i class="fas fa-tv"></i>',
  'Ninguno': '<i class="fas fa-ban"></i>'
};

let datosGlobales = null;

fetch('../acciones/get_grilla.php')
  .then(res => res.json())
  .then(data => {
    datosGlobales = data;
    renderGrilla('Matutino');
    renderLeyenda();
  })
  .catch(err => {
    console.error("❌ Error al cargar datos:", err);
  });

function mostrarModal(htmlInterno, envolver = true) {
  const contenedor = document.getElementById('modal-formulario');
  contenedor.innerHTML = ''; // 🧼 limpieza previa
  contenedor.innerHTML = envolver
    ? `<div class="modal-contenido">${htmlInterno}</div>`
    : htmlInterno;
  contenedor.style.display = 'flex';
}

function renderGrilla(turnoSeleccionado) {
  const { dias, aulas, asignaciones } = datosGlobales;
  const diasFiltrados = dias.filter(dia => dia.trim() !== '');
  const filtradas = asignaciones.filter(a => a.turno === turnoSeleccionado);
  const grid = {};

  filtradas.forEach(a => {
    if (!grid[a.aula_id]) grid[a.aula_id] = {};
    if (!grid[a.aula_id][a.dia]) grid[a.aula_id][a.dia] = [];
    grid[a.aula_id][a.dia].push(a);
  });

  const numDias = diasFiltrados.length;
  const anchoAula = 16;
  const anchoTotalDias = 100 - anchoAula;
  const anchoDia = anchoTotalDias / numDias;

  let html = '<table class="grid-table"><colgroup>';
  html += `<col style="width: ${anchoAula}%;">`;
  for (let i = 0; i < numDias; i++) {
    html += `<col style="width: ${anchoDia}%;">`;
  }
  html += '</colgroup><thead><tr><th>Aula</th>';
  diasFiltrados.forEach(dia => {
    html += `<th>${dia}</th>`;
  });
  html += '</tr></thead><tbody>';

  aulas.forEach(aula => {
    const recursoIcono = iconoRecurso[aula.recurso] || '❓';
    let infoAula = '';
    if (aula.recurso && aula.capacidad) {
      infoAula = `<small>${recursoIcono} ${aula.recurso} - Capacidad: ${aula.capacidad}</small>`;
    }

    html += `<tr><td><strong>${aula.nombre}</strong><br>${infoAula}</td>`;

    diasFiltrados.forEach(dia => {
      const asignacionesDia = grid[aula.aula_id]?.[dia] || [];
      let celdaHTML = '';
      let botonesEliminar = '';
      let botonesEditar = '';

      asignacionesDia.forEach(asig => {
        const color = asig.color_entidad || '#ccc'; // color desde la DB
        let comentarioHTML = '';
        if (asig.comentarios?.trim()) {
          const limpio = asig.comentarios.replace(/"/g, "'").replace(/\r?\n/g, ' ');
          comentarioHTML = `<span class="comentario-toggle" data-comentario="${limpio.replace(/"/g, '&quot;')}"><i class="fas fa-comment-dots"></i> Ver comentario</span>`;
          }

        celdaHTML += `<div class="asignacion" data-id="${asig.Id}" data-dia="${asig.dia}" data-aula="${asig.aula_id}" 
        style="margin-bottom:6px; background-color:${color}; color:#fff; padding:6px; border-radius:6px;">
        <div class="asignacion-texto">
        <strong>MATERIA: ${asig.materia}</strong><br>
        <span>CARRERA: ${asig.carrera}</span><br>
        <span>AÑO: ${asig.anio}</span><br>
        HORARIO: ${asig.hora_inicio.slice(0,5)} - ${asig.hora_fin.slice(0,5)}<br>
        <small><em>PROFESOR: ${asig.profesor}</em></small>
      </div>
      ${comentarioHTML}
  </div>`;

        if (asignacionesDia.length > 0) {
          botonesEliminar = `<button class="btn-eliminar-asignacion" data-id="${asignacionesDia[0].Id}" data-dia="${dia}" data-aula="${aula.aula_id}" title="Eliminar esta asignación">❌</button>`;
          botonesEditar = `<button class="btn-editar-asignacion" data-id="${asignacionesDia[0].Id}" data-dia="${dia}" data-aula="${aula.aula_id}" title="Editar esta asignación">✏️</button>`;
        }
      });

      celdaHTML += `<div class="acciones-celda">
        <button class="btn-agregar" title="Agregar asignación" data-dia="${dia}" data-aula="${aula.aula_id}">➕</button>
        ${botonesEditar}
        ${botonesEliminar}
      </div>`;

      html += `<td class="celda-asignacion" data-dia="${dia}" data-aula="${aula.aula_id}">${celdaHTML}</td>`;
    });
    html += '</tr>';
  });

  html += '</tbody></table>';
  document.getElementById('grilla-container').innerHTML = html;

  document.querySelectorAll('.tab-btn').forEach(btn => {
    btn.classList.toggle('active', btn.dataset.turno === turnoSeleccionado);
  });
}

document.body.addEventListener('mouseover', e => {
  const toggle = e.target;
  if (!toggle.classList.contains('comentario-toggle')) return;

  const comentario = toggle.dataset.comentario;
  const rect = toggle.getBoundingClientRect();

  const tooltip = document.getElementById('comentario-global');
  tooltip.innerHTML = comentario;
  tooltip.style.top = `${rect.top + window.scrollY}px`;
  tooltip.style.left = `${rect.right + 10}px`;
  tooltip.style.opacity = '1';
  tooltip.style.visibility = 'visible';
});

document.body.addEventListener('mouseout', e => {
  const tooltip = document.getElementById('comentario-global');
  tooltip.style.opacity = '0';
  tooltip.style.visibility = 'hidden';
});

document.addEventListener('click', e => {
  const id = e.target.id;

  // 🟢 Tabs de turno
  if (e.target.classList.contains('tab-btn')) {
    renderGrilla(e.target.dataset.turno);
    return;
  }

  // 🟢 Botón de agregar entidad (blindado por ID)
 if (id === 'btn-agregar-entidad') {
  e.stopPropagation(); // evita que otros listeners reaccionen

  const html = `
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

  mostrarModal(html, false);
  return;
}

  if (id === 'btn-eliminar-entidad') {
  e.stopPropagation();
  fetch('../acciones/get_entidades.php')
    .then(res => res.json())
    .then(entidades => {
      if (entidades.length === 0) {
        mostrarMensaje('info', 'No hay entidades para eliminar');
        return;
      }

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

      mostrarModal(html, false);
    });
  return;
}

  // 🟢 Botón de cancelar entidad
  if (id === 'btn-cancelar-agregar' || id === 'btn-cancelar-eliminar') {
    cerrarModal();
    return;
  }

if (e.target.classList.contains('btn-eliminar-asignacion') && id !== 'btn-eliminar-entidad') {
  const dia = e.target.dataset.dia;
  const aula = e.target.dataset.aula;
  const turno = document.querySelector('.tab-btn.active')?.dataset.turno || 'Matutino';

  const asignaciones = datosGlobales.asignaciones.filter(a =>
    a.dia === dia && a.aula_id === aula && a.turno === turno
  );

  if (asignaciones.length === 0) {
    mostrarMensaje('info', 'No hay asignaciones para eliminar');
    return;
  }

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

  mostrarModal(html, false);
  return;
}

  // 🟢 Botón de agregar asignación (blindado por clase y exclusión de entidad)
  if (e.target.classList.contains('btn-agregar') && id !== 'btn-agregar-entidad') {
  const aula_id = e.target.dataset.aula;
  const dia = e.target.dataset.dia;
  const turno = document.querySelector('.tab-btn.active')?.dataset.turno || 'Matutino';

  fetch(`../acciones/form_crear_asignacion.php?aula_id=${aula_id}&dia=${dia}&turno=${turno}`)
    .then(res => res.text())
    .then(html => {
  mostrarModal(html, false);
});


  return;
}

  // 🟢 Botón de editar asignación
  if (e.target.classList.contains('btn-editar-asignacion')) {
    const dia = e.target.dataset.dia;
    const aula = e.target.dataset.aula;
    const turno = document.querySelector('.tab-btn.active')?.dataset.turno || 'Matutino';

    const asignaciones = datosGlobales.asignaciones.filter(a =>
      a.dia === dia && a.aula_id === aula && a.turno === turno
    );

    if (asignaciones.length === 0) {
      mostrarMensaje('info', 'No hay asignaciones para editar');
      return;
    }

    let html = `<div class="modal-contenido">
  <h3>Seleccioná una asignación para editar</h3>
  <form id="form-editar-asignacion" class="modal-formulario">`;

asignaciones.forEach(asig => {
  const detalle = `${asig.materia} – ${asig.hora_inicio.slice(0,5)}-${asig.hora_fin.slice(0,5)} – ${asig.profesor}`;
  html += `<label class="opcion-eliminar">
    <input type="radio" name="asignacion_id" value="${asig.Id}"> ${detalle}
  </label>`;
});

html += `
  <input type="hidden" name="aula_id" value="${aula}">
  <input type="hidden" name="dia" value="${dia}">
  <input type="hidden" name="turno" value="${turno}">
  <div class="form-buttons">
    <button type="button" id="btn-cancelar-edicion">Cancelar</button>
    <button type="submit">✏️ Editar</button>
  </div>
</form></div>`;

mostrarModal(html, false);
    return;
  }
});

document.addEventListener('submit', e => {
  const form = e.target;
  const idsPermitidos = [
    'form-editar-asignacion',
    'form-agregar-entidad',
    'form-eliminar-entidad',
    'form-eliminar-asignacion' // 🆕 agregado
  ];
  if (!idsPermitidos.includes(form.id)) return;

  const modal = document.getElementById('modal-formulario');
  const submitBtn = form.querySelector('button[type="submit"]');
  if (submitBtn) submitBtn.disabled = true;

  // 🟢 Formulario de edición de asignación
  if (form.id === 'form-editar-asignacion') {
    e.preventDefault();
    const id = form.elements['asignacion_id']?.value;
    const aulaId = form.elements['aula_id']?.value;
    const dia = form.elements['dia']?.value;
    const turno = form.elements['turno']?.value;

    if (!id || !aulaId || !dia || !turno) {
      console.error("❌ Faltan datos para editar la asignación");
      if (submitBtn) submitBtn.disabled = false;
      return;
    }

    fetch(`../acciones/form_editar_asignacion.php?id=${id}&aula_id=${aulaId}&dia=${dia}&turno=${turno}`)
      .then(res => res.text())
      .then(html => mostrarModal(html))
      .catch(err => {
        console.error('❌ Error al cargar formulario de edición:', err);
        mostrarMensaje('error', 'Error al cargar formulario');
      });

    return;
  }

  // 🟢 Formulario de creación de entidad
  if (form.id === 'form-agregar-entidad') {
    e.preventDefault();
    const nombre = form.elements['nombre']?.value.trim().replace(/\s+/g, ' ');
    const color = form.elements['color']?.value;

    if (!nombre || !color) {
      mostrarMensaje('warning', '⚠️ Completá todos los campos');
      if (submitBtn) submitBtn.disabled = false;
      return;
    }

    fetch('../acciones/agregar_entidad.php', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ nombre, color })
    })
      .then(res => res.text())
      .then(texto => {
        console.log('🔍 Respuesta cruda:', texto);
        try {
          const data = JSON.parse(texto);

          if (data.ok) {
            mostrarMensaje('success', `✅ Entidad "${nombre}" registrada correctamente`);
            cerrarModal();
            actualizarGrilla(document.querySelector('.tab-btn.active')?.dataset.turno || 'Matutino');
            renderLeyenda();
          } else {
            mostrarMensaje('error', data.error || 'Error al crear entidad');
            if (submitBtn) submitBtn.disabled = false;
          }
        } catch (err) {
          console.error('❌ JSON malformado:', err);
          mostrarMensaje('error', 'Respuesta inválida del servidor');
          if (submitBtn) submitBtn.disabled = false;
        }
      })
      .catch(err => {
        console.error('❌ Error de red o parsing:', err);
        mostrarMensaje('error', 'Error inesperado');
        if (submitBtn) submitBtn.disabled = false;
      });

    return;
  }

  // 🟢 Formulario de eliminación de entidad
  if (form.id === 'form-eliminar-entidad') {
    e.preventDefault();
    const id = form.elements['entidad_id']?.value;

    if (!id) {
      mostrarMensaje('info', 'Seleccioná una entidad para eliminar');
      if (submitBtn) submitBtn.disabled = false;
      return;
    }

    fetch('../acciones/eliminar_entidad.php', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ id })
    })
      .then(res => res.json())
      .then(data => {
        if (data.ok) {
          mostrarMensaje('success', 'Entidad eliminada correctamente');
          cerrarModal();
          actualizarGrilla('Matutino');
          renderLeyenda();
        } else {
          mostrarMensaje('error', data.error || 'Error al eliminar entidad');
          if (submitBtn) submitBtn.disabled = false;
        }
      })
      .catch(err => {
        console.error('❌ Error al eliminar entidad:', err);
        mostrarMensaje('error', 'Error inesperado');
        if (submitBtn) submitBtn.disabled = false;
      });

    return;
  }

  // 🟢 Formulario de eliminación de asignación
  if (form.id === 'form-eliminar-asignacion') {
    e.preventDefault();
    const id = form.elements['asignacion_id']?.value;

    if (!id) {
      mostrarMensaje('info', 'Seleccioná una asignación para eliminar');
      if (submitBtn) submitBtn.disabled = false;
      return;
    }

    fetch('../acciones/eliminar_asignacion.php', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ id })
    })
      .then(res => res.json())
      .then(data => {
        if (data.ok) {
          mostrarMensaje('success', 'Asignación eliminada correctamente');
          cerrarModal();
          actualizarGrilla(document.querySelector('.tab-btn.active')?.dataset.turno || 'Matutino');
        } else {
          mostrarMensaje('error', data.error || 'Error al eliminar asignación');
          if (submitBtn) submitBtn.disabled = false;
        }
      })
      .catch(err => {
        console.error('❌ Error al eliminar asignación:', err);
        mostrarMensaje('error', 'Error inesperado');
        if (submitBtn) submitBtn.disabled = false;
      });

    return;
  }
});

function renderLeyenda() {
  fetch('../acciones/get_entidades.php')
    .then(res => res.json())
    .then(entidades => {
      const contenedor = document.getElementById('leyenda-dinamica');
      contenedor.innerHTML = ''; // 🧼 limpieza previa

      entidades.forEach(ent => {
        const span = document.createElement('span');
        span.className = 'leyenda-bloque';
        span.textContent = ent.nombre;
        span.style.backgroundColor = ent.color;
        span.style.color = '#fff';
        contenedor.appendChild(span);
      });
    })
    .catch(err => {
      console.error('❌ Error al cargar leyenda:', err);
    });
}



function toggleComentario(elem) {
  const comentario = elem.nextElementSibling;
  comentario.classList.toggle('oculto');
}


function actualizarGrilla(turnoSeleccionado) {
  fetch('../acciones/get_grilla.php')
  .then(res => res.json())
  .then(data => {
    datosGlobales = data;
    renderGrilla('Matutino');
    renderLeyenda();
  })
  .catch(err => {
    console.error("❌ Error al cargar datos:", err);
  });
}