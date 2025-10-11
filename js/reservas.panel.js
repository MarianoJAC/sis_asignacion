document.addEventListener('DOMContentLoaded', () => {
  const tablaBody = document.querySelector('#tabla-reservas tbody');
  const headers = document.querySelectorAll('#tabla-reservas th[data-sort]');
  const filtroTipo = document.getElementById('filtro-tipo');

  let allReservas = [];
  let sortState = { column: 'timestamp', direction: 'desc' };

  const TIPO_RESERVA_MAP = {
    1: 'Aula',
    2: 'Laboratorio',
    3: 'KitTV'
  };

  // --- LÓGICA DE DATOS ---

  async function fetchReservas() {
    try {
      const response = await fetch('../acciones/get_reservas.php');
      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
      const result = await response.json();

      if (!result.ok) throw new Error(result.error || 'Error desconocido al obtener datos.');
      
      allReservas = result.data;
      sortAndRender();

    } catch (error) {
      tablaBody.innerHTML = `<tr><td colspan="9" class="text-center">❌ Error: ${error.message}</td></tr>`;
    }
  }

  // --- LÓGICA DE ORDENACIÓN Y FILTRADO ---

  function sortAndRender() {
    const { column, direction } = sortState;
    const tipoFiltrado = filtroTipo.value;

    // 1. Filtrar
    const filteredData = allReservas.filter(reserva => {
      if (tipoFiltrado === 'todos') return true;
      return reserva.tipo_reserva == tipoFiltrado;
    });

    // 2. Ordenar
    const sortedData = [...filteredData].sort((a, b) => {
      let valA = a[column];
      let valB = b[column];

      // Manejo de fechas y números
      if (column === 'fecha') {
        valA = new Date(valA).getTime();
        valB = new Date(valB).getTime();
      } else if (column === 'timestamp') {
        valA = new Date(valA.split(' ')[0].split('/').reverse().join('-') + 'T' + valA.split(' ')[1]).getTime();
        valB = new Date(valB.split(' ')[0].split('/').reverse().join('-') + 'T' + valB.split(' ')[1]).getTime();
      } else if (!isNaN(valA) && !isNaN(valB)) {
        valA = Number(valA);
        valB = Number(valB);
      }

      if (valA < valB) return direction === 'asc' ? -1 : 1;
      if (valA > valB) return direction === 'asc' ? 1 : -1;
      return 0;
    });

    renderTable(sortedData);
    updateSortIcons();
  }

  // --- LÓGICA DE RENDERIZADO ---

  function renderTable(data) {
    tablaBody.innerHTML = '';
    if (data.length === 0) {
      tablaBody.innerHTML = '<tr><td colspan="12" class="text-center">No se encontraron reservas con los filtros actuales.</td></tr>';
      return;
    }

    data.forEach(reserva => {
      const fila = document.createElement('tr');
      fila.dataset.id = reserva.id;
      fila.classList.add(`tipo-${TIPO_RESERVA_MAP[reserva.tipo_reserva]?.toLowerCase().replace(' ','') || 'default'}`);

      let detalles = '';
      if (reserva.tipo_reserva == 2 && reserva.cantidad_pc) {
        detalles = `${reserva.cantidad_pc} PC(s)`;
      }

      fila.innerHTML = `
        <td>${TIPO_RESERVA_MAP[reserva.tipo_reserva] || 'Desconocido'}</td>
        <td>${reserva.fecha_solicitud}</td>
        <td>${formatDate(reserva.fecha)}</td>
        <td>${formatTime(reserva.hora_inicio)} - ${formatTime(reserva.hora_fin)}</td>
        <td>${reserva.entidad_nombre}</td>
        <td>${reserva.aula_nombre || '-'}</td>
        <td>${reserva.carrera || '-'}</td>
        <td>${reserva.profesor || '-'}</td>
        <td>${reserva.telefono_contacto || '-'}</td>
        <td>${reserva.comentarios || '-'}</td>
        <td>${detalles || '-'}</td>
        <td>
          <button class="btn btn-danger btn-sm btn-delete" data-id="${reserva.id}">
            Borrar
          </button>
        </td>
      `;
      tablaBody.appendChild(fila);
    });
  }

  function updateSortIcons() {
    headers.forEach(header => {
      const sortColumn = header.dataset.sort;
      const iconUp = header.querySelector('.fa-sort-up');
      const iconDown = header.querySelector('.fa-sort-down');

      if (!iconUp || !iconDown) return;

      if (sortColumn === sortState.column) {
        iconUp.classList.toggle('active', sortState.direction === 'asc');
        iconDown.classList.toggle('active', sortState.direction === 'desc');
      } else {
        iconUp.classList.remove('active');
        iconDown.classList.remove('active');
      }
    });
  }

  // --- HELPERS DE FORMATO ---
  function formatDate(dateString) {
    const date = new Date(dateString);
    return date.toLocaleDateString('es-AR', { timeZone: 'UTC' });
  }

  function formatTime(timeString) {
    return timeString.substring(0, 5);
  }

  // --- LÓGICA DE BORRADO ---
  async function handleDelete(id) {
    const result = await Swal.fire({
      title: '¿Estás seguro?',
      text: "¡Esta acción marcará la reserva como eliminada!",
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#d33',
      cancelButtonColor: '#3085d6',
      confirmButtonText: 'Sí, borrar',
      cancelButtonText: 'Cancelar'
    });

    if (result.isConfirmed) {
      try {
        const response = await fetch('../acciones/eliminar_reserva.php', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ id: id })
        });

        const data = await response.json();

        if (data.ok) {
          Swal.fire('¡Borrada!', 'La reserva ha sido marcada como eliminada.', 'success');
          allReservas = allReservas.filter(reserva => reserva.id != id);
          sortAndRender();
        } else {
          Swal.fire('Error', data.error || 'No se pudo marcar la reserva como eliminada.', 'error');
        }
      } catch (error) {
        Swal.fire('Error de conexión', 'No se pudo conectar con el servidor.', 'error');
      }
    }
  }

  // --- EVENT LISTENERS ---

  headers.forEach(header => {
    header.addEventListener('click', (event) => {
      const column = header.dataset.sort;
      if (!column) return;
      
      let newDirection = 'asc';
      if (sortState.column === column) {
        newDirection = sortState.direction === 'asc' ? 'desc' : 'asc';
      }

      sortState.column = column;
      sortState.direction = newDirection;
      sortAndRender();
    });
  });

  filtroTipo.addEventListener('change', sortAndRender);

  tablaBody.addEventListener('click', (event) => {
    if (event.target.classList.contains('btn-delete')) {
      const reservaId = parseInt(event.target.dataset.id);
      handleDelete(reservaId);
    }
  });

  document.getElementById('btn-imprimir')?.addEventListener('click', () => window.print());
  
  document.getElementById('btn-pdf')?.addEventListener('click', () => {
    const elemento = document.getElementById('zona-imprimible');
    const opt = {
      margin: 0.5,
      filename: 'panel_reservas.pdf',
      image: { type: 'jpeg', quality: 0.98 },
      html2canvas: { scale: 2 },
      jsPDF: { unit: 'in', format: 'letter', orientation: 'landscape' }
    };
    html2pdf().from(elemento).set(opt).save();
  });

  // --- INICIALIZACIÓN ---
  fetchReservas();
});