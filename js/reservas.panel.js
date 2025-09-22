document.addEventListener('DOMContentLoaded', () => {
  const tablaBody = document.querySelector('#tabla-reservas tbody');
  const headers = document.querySelectorAll('#tabla-reservas th[data-sort]');

  let allReservas = [];
  let sortState = { column: 'fecha_solicitud', direction: 'desc' }; // Usar fecha_solicitud para el orden inicial

  // --- LÓGICA DE DATOS ---

  async function fetchReservas() {
    try {
      const response = await fetch('../acciones/get_reservas.php');
      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
      const result = await response.json();

      if (!result.ok) throw new Error(result.error || 'Error desconocido al obtener datos.');
      
      allReservas = result.data;
      sortAndRender(); // Ordenar y renderizar la tabla inicial

    } catch (error) {
      tablaBody.innerHTML = `<tr><td colspan="9" class="text-center">❌ Error: ${error.message}</td></tr>`; // Colspan ajustado
    }
  }

  // --- LÓGICA DE ORDENACIÓN (CLIENT-SIDE) ---

  function sortAndRender() {
    const { column, direction } = sortState;

    // Ordena el array de reservas en memoria
    const sortedData = [...allReservas].sort((a, b) => {
      let valA = a[column];
      let valB = b[column];

      // Manejo de fechas y números
      if (column === 'fecha' || column === 'fecha_solicitud' || column.includes('hora')) {
        valA = new Date(valA).getTime();
        valB = new Date(valB).getTime();
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
      tablaBody.innerHTML = '<tr><td colspan="9" class="text-center">No se encontraron reservas.</td></tr>'; // Colspan ajustado
      return;
    }

    data.forEach(reserva => {
      const fila = document.createElement('tr');
      fila.dataset.id = reserva.id; // Guardar el ID de la reserva en la fila
      fila.innerHTML = `
        <td>${formatDate(reserva.fecha)}</td>
        <td>${formatTime(reserva.hora_inicio)}</td>
        <td>${formatTime(reserva.hora_fin)}</td>
        <td>${reserva.entidad_nombre}</td>
        <td>${reserva.carrera || '-'}</td>
        <td>${reserva.profesor || '-'}</td>
        <td>${reserva.telefono_contacto || '-'}</td>
        <td>${reserva.fecha_solicitud}</td> <!-- Usar el campo pre-formateado -->
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

      if (sortColumn === sortState.column) {
        if (sortState.direction === 'asc') {
          iconUp?.classList.add('active');
          iconDown?.classList.remove('active');
        } else {
          iconUp?.classList.remove('active');
          iconDown?.classList.add('active');
        }
      } else {
        iconUp?.classList.remove('active');
        iconDown?.classList.remove('active');
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

  // --- LÓGICA DE BORRADO (SOFT DELETE) ---
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
          Swal.fire(
            '¡Borrada!',
            'La reserva ha sido marcada como eliminada.',
            'success'
          );
          // Eliminar la fila de la tabla y del array allReservas
          allReservas = allReservas.filter(reserva => reserva.id !== id);
          sortAndRender(); // Re-renderizar para reflejar el cambio
        } else {
          Swal.fire(
            'Error',
            data.error || 'No se pudo marcar la reserva como eliminada.',
            'error'
          );
        }
      } catch (error) {
        Swal.fire(
          'Error de conexión',
          'No se pudo conectar con el servidor para eliminar la reserva.',
          'error'
        );
      }
    }
  }

  // --- EVENT LISTENERS ---

  headers.forEach(header => {
    header.addEventListener('click', (event) => {
      const column = header.dataset.sort;
      let newDirection = 'asc';

      // Determinar la dirección si se hizo clic en un icono específico
      if (event.target.classList.contains('sort-icon')) {
        newDirection = event.target.dataset.direction;
      } else if (sortState.column === column) {
        // Si se hizo clic en el encabezado de la columna activa, alternar dirección
        newDirection = sortState.direction === 'asc' ? 'desc' : 'asc';
      }

      sortState.column = column;
      sortState.direction = newDirection;
      sortAndRender();
    });
  });

  // Delegación de eventos para los botones de borrar
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