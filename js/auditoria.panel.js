document.addEventListener('DOMContentLoaded', () => {
  const tabla = document.querySelector('#tabla-auditoria tbody');
  const form = document.getElementById('filtros-auditoria');

  // 🔍 Carga inicial
  form.dispatchEvent(new Event('submit'));

  // 🧩 Filtro dinámico
  form.addEventListener('submit', e => {
    e.preventDefault();
    const params = new URLSearchParams(new FormData(form)).toString();
    fetch(`../acciones/get_auditoria.php?${params}`)
      .then(res => res.json())
      .then(data => {
        if (!data.ok) throw new Error(data.error);
        renderAuditoria(data.auditorias);
      })
      .catch(err => {
        tabla.innerHTML = `<tr><td colspan="8">❌ Error: ${err.message}</td></tr>`;
      });
  });

  // 🧠 Render visual
function renderAuditoria(data) {
  tabla.innerHTML = '';
  data.forEach(a => {
    const fila = document.createElement('tr');

    // 🧠 Clasificación visual por tipo de acción
    if (a.accion.includes('ALTA')) fila.classList.add('fila-alta');
    if (a.accion.includes('BAJA')) fila.classList.add('fila-baja');
    if (a.accion.includes('MODIFICACION')) fila.classList.add('fila-modificacion');

    // 🎨 Ícono institucional por tipo de acción
    const icono = a.accion.includes('ALTA') ? '🟢' :
                  a.accion.includes('BAJA') ? '🔴' :
                  a.accion.includes('MODIFICACION') ? '🟡' : '⚪';

    // 🧩 Render visual
    fila.innerHTML = `
      <td>${a.fecha}</td>
      <td>${a.username}</td>
      <td>${icono} <strong>${a.accion.toUpperCase()}</strong></td>
      <td>${a.tipo_objeto}</td>
      <td>${a.objeto_id}</td>
      <td>${a.campo_modificado || '—'}</td>
      <td><pre>${a.valor_anterior || '—'}</pre></td>
      <td><pre>${a.valor_nuevo || '—'}</pre></td>
    `;
    tabla.appendChild(fila);
  });
}
});