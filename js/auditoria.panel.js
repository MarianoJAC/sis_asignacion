document.addEventListener('DOMContentLoaded', () => {
  const tabla = document.querySelector('#tabla-auditoria tbody');
  const form = document.getElementById('filtros-auditoria');
  const paginacionContenedor = document.getElementById('contenedor-paginacion');

  let currentPage = 1;
  let aulasMap = new Map();
  let entidadesMap = new Map();

  // --- FUNCIONES DE RENDERIZADO ---

  function renderAuditoria(data) {
    tabla.innerHTML = '';
    if (data.length === 0) {
      tabla.innerHTML = '<tr><td colspan="8" class="text-center">No se encontraron registros con esos filtros.</td></tr>';
      return;
    }
    data.forEach(a => {
      const fila = document.createElement('tr');
      const accionNormalizada = a.accion.toLowerCase();
      if (accionNormalizada.includes('alta')) fila.classList.add('fila-alta');
      if (accionNormalizada.includes('baja')) fila.classList.add('fila-baja');
      if (accionNormalizada.includes('modificacion')) fila.classList.add('fila-modificacion');

      const icono = accionNormalizada.includes('alta') ? '🟢' : accionNormalizada.includes('baja') ? '🔴' : accionNormalizada.includes('modificacion') ? '🟡' : '⚪';

      fila.innerHTML = `
        <td>${a.fecha}</td>
        <td>${a.username}</td>
        <td>${icono} <strong>${a.accion.toUpperCase()}</strong></td>
        <td>${a.tipo_objeto}</td>
        <td>${a.objeto_id}</td>
        <td>${a.campo_modificado || '—'}</td>
        <td>${formatAuditoriaValor(a.valor_anterior, a.campo_modificado)}</td>
        <td>${formatAuditoriaValor(a.valor_nuevo, a.campo_modificado)}</td>
      `;
      tabla.appendChild(fila);
    });
  }

  function renderPaginacion(pagination) {
    paginacionContenedor.innerHTML = '';
    const { page, totalPages } = pagination;

    if (totalPages <= 1) return; // No mostrar paginación si solo hay una página

    const ul = document.createElement('ul');
    ul.className = 'pagination justify-content-center';

    // Botón "Anterior"
    const prevLi = document.createElement('li');
    prevLi.className = `page-item ${page === 1 ? 'disabled' : ''}`;
    prevLi.innerHTML = `<a class="page-link" href="#" data-page="${page - 1}">Anterior</a>`;
    ul.appendChild(prevLi);

    // Números de página (lógica simplificada)
    for (let i = 1; i <= totalPages; i++) {
      const pageLi = document.createElement('li');
      pageLi.className = `page-item ${i === page ? 'active' : ''}`;
      pageLi.innerHTML = `<a class="page-link" href="#" data-page="${i}">${i}</a>`;
      ul.appendChild(pageLi);
    }

    // Botón "Siguiente"
    const nextLi = document.createElement('li');
    nextLi.className = `page-item ${page === totalPages ? 'disabled' : ''}`;
    nextLi.innerHTML = `<a class="page-link" href="#" data-page="${page + 1}">Siguiente</a>`;
    ul.appendChild(nextLi);

    paginacionContenedor.appendChild(ul);
  }

  function formatAuditoriaValor(valor, campo) {
    if (!valor || valor === '—') return '—';
    if (campo === 'aula_id' && aulasMap.has(parseInt(valor))) return aulasMap.get(parseInt(valor));
    if (campo === 'entidad_id' && entidadesMap.has(parseInt(valor))) return entidadesMap.get(parseInt(valor));

    try {
      const obj = JSON.parse(valor);
      const displayNameMap = {
        anio: 'Año', profesor: 'Profesor', materia: 'Materia', carrera: 'Carrera',
        entidad_id: 'Entidad', aula_id: 'Aula', hora_inicio: 'Inicio', hora_fin: 'Fin', 
        comentarios: 'Comentarios', fecha: 'Fecha', turno: 'Turno'
      };

      let html = '<ul class="valor-lista">';
      for (const key in obj) {
        const displayName = displayNameMap[key] || key;
        let displayValue = obj[key];
        if (key === 'aula_id' && aulasMap.has(parseInt(displayValue))) displayValue = aulasMap.get(parseInt(displayValue));
        if (key === 'entidad_id' && entidadesMap.has(parseInt(displayValue))) displayValue = entidadesMap.get(parseInt(displayValue));
        html += `<li><strong>${displayName}:</strong> ${displayValue}</li>`;
      }
      html += '</ul>';
      return html;
    } catch (e) {
      return valor;
    }
  }

  // --- LÓGICA DE DATOS Y EVENTOS ---

  function recargarAuditoria(page = 1) {
    currentPage = page;
    const params = new URLSearchParams(new FormData(form));
    params.append('page', currentPage);
    params.append('limit', 25);

    fetch(`../acciones/get_auditoria.php?${params.toString()}`)
      .then(res => res.json())
      .then(data => {
        if (!data.ok) throw new Error(data.error);
        renderAuditoria(data.auditorias);
        renderPaginacion(data.pagination);
      })
      .catch(err => {
        tabla.innerHTML = `<tr><td colspan="8" class="text-center">❌ Error: ${err.message}</td></tr>`;
      });
  }

  // --- INICIALIZACIÓN ---

  const promesasLookups = [
    fetch('../acciones/get_aulas_list.php').then(res => res.json()),
    fetch('../acciones/get_entidades.php').then(res => res.json())
  ];

  Promise.all(promesasLookups)
    .then(([aulasData, entidadesData]) => {
      if (aulasData.ok) aulasData.aulas.forEach(a => aulasMap.set(parseInt(a.aula_id), a.nombre));
      if (entidadesData.ok) entidadesData.entidades.forEach(e => entidadesMap.set(parseInt(e.id), e.nombre));

      // Eventos principales
      form.addEventListener('submit', e => {
        e.preventDefault();
        recargarAuditoria(1); // Al filtrar, volver a la página 1
      });

      paginacionContenedor.addEventListener('click', e => {
        if (e.target.tagName === 'A' && e.target.dataset.page) {
          e.preventDefault();
          const pageNum = parseInt(e.target.dataset.page);
          if (pageNum !== currentPage) {
            recargarAuditoria(pageNum);
          }
        }
      });

      document.getElementById('btn-imprimir')?.addEventListener('click', () => window.print());
      document.getElementById('btn-pdf')?.addEventListener('click', () => {
        const elemento = document.getElementById('zona-imprimible');
        const opt = { margin: 0.5, filename: 'auditoria_sistema.pdf', image: { type: 'jpeg', quality: 0.98 }, html2canvas: { scale: 2 }, jsPDF: { unit: 'in', format: 'letter', orientation: 'landscape' } };
        html2pdf().from(elemento).set(opt).save();
      });

      // Carga inicial
      recargarAuditoria(1);
    })
    .catch(err => {
      tabla.innerHTML = `<tr><td colspan="8" class="text-center">❌ Error crítico al cargar datos iniciales: ${err.message}</td></tr>`;
    });
});