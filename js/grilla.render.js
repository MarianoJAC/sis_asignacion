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
        const color = asig.color_entidad || '#ccc';
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