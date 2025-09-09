const iconoRecurso = {
  'Proyector': '<i class="fas fa-video"></i>',
  'TV': '<i class="fas fa-tv"></i>',
  'Ninguno': '<i class="fas fa-ban"></i>'
};

let datosGlobales = null;

fetch('acciones/get_grilla.php')
  .then(res => res.json())
  .then(data => {
    datosGlobales = data;
    renderGrilla('Matutino');
    renderLeyenda(); // definida en grilla.eventos.js
  })
  .catch(() => {
    mostrarMensaje('error', 'No se pudo cargar la grilla inicial');
  });

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

document.body.addEventListener('mouseout', () => {
  const tooltip = document.getElementById('comentario-global');
  tooltip.style.opacity = '0';
  tooltip.style.visibility = 'hidden';
});

function actualizarGrilla(turnoSeleccionado) {
  fetch('acciones/get_grilla.php')
    .then(res => res.json())
    .then(data => {
      datosGlobales = data;
      renderGrilla(turnoSeleccionado);
      renderLeyenda();
    })
    .catch(() => {
      mostrarMensaje('error', 'No se pudo actualizar la grilla');
    });
}