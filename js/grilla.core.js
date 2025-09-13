import { renderGrilla, cargarAsignacionesPorAula, renderGrillaTodosLosTurnos, actualizarGrilla } from './grilla.render.js';
import './grilla.eventos.js';
import './grilla.formularios.js';
import './grilla.modales.js';
import './grilla.alertas.js';
import './grilla.validaciones.js';
import { mostrarMensaje } from './grilla.alertas.js';
import { renderLeyenda } from './grilla.eventos.js';

export { cargarAsignacionesPorAula, actualizarGrilla } from './grilla.render.js';

document.addEventListener('DOMContentLoaded', () => {
 
  const params = new URLSearchParams(window.location.search);
  const aulaId = parseInt(params.get('aula_id') || '0');
  const origen = params.get('origen') || '';
 console.log('🌐 Parámetros detectados:', { aulaId, origen });
  if (aulaId > 0 && origen === 'mapa') {
    console.log('🧭 Render extendido desde mapa | Aula:', aulaId);
    window.aulaSeleccionada = aulaId;

    cargarAsignacionesPorAulaTodosLosTurnos(aulaId); // 🧩 render extendido
    document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active')); // 🧼 desactivar pestañas

    history.replaceState(null, '', 'index.html'); // 🧹 limpiar URL
    return; // 🛡️ evitar render por defecto
  }

  if (aulaId > 0) {
    console.log('🧭 Aula seleccionada:', aulaId);
    window.aulaSeleccionada = aulaId;
    cargarAsignacionesPorAula(aulaId); // ✅ comportamiento normal
    return;
  }

  // 🧩 Render por defecto si no hay aula ni mapa
  fetch('acciones/get_grilla.php')
    .then(res => res.json())
    .then(data => {
      try {
        console.log('🧪 Datos recibidos:', data);
        window.datosGlobales = data;

        if (!data.aulas || data.aulas.length === 0) {
          throw new Error('No se recibieron aulas desde el backend');
        }

        renderGrilla('Matutino', data);
        renderLeyenda();
      } catch (err) {
        console.error('❌ Error interno al renderizar:', err);
        mostrarMensaje('error', 'Error al procesar la grilla');
      }
    })
    .catch(err => {
      console.error('❌ Error en fetch:', err);
      mostrarMensaje('error', 'No se pudo cargar la grilla inicial');
    });

  // 🧹 Botón para salir del filtro de aula
  const btnVerTodas = document.getElementById('btn-ver-todas');
  if (btnVerTodas) {
    btnVerTodas.addEventListener('click', () => {
  window.aulaSeleccionada = null;

  fetch('acciones/get_grilla.php')
    .then(res => res.json())
    .then(data => {
      window.datosGlobales = data;

      // 🧼 limpiar pestañas
      document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));

      // 🧠 restaurar título principal
      document.querySelector('h2').textContent = 'Grilla Semanal de Asignaciones Marechal';

      // 🧩 render por defecto
      renderGrilla('Matutino', data, null);
      renderLeyenda();

      // 🧹 limpiar URL
      history.replaceState(null, '', 'index.html');

      mostrarMensaje('info', 'Vista completa activada');
      console.log('🧹 Filtro de aula desactivado y grilla recargada');
    })
    .catch(err => {
      console.error('❌ Error al recargar grilla:', err);
      mostrarMensaje('error', 'No se pudo recargar la grilla completa');
    });
});
  }
});

export function cargarAsignacionesPorAulaTodosLosTurnos(aulaId) {
  fetch('acciones/get_grilla.php')
    .then(res => res.json())
    .then(data => {
      window.datosGlobales = data;
      window.aulaSeleccionada = aulaId;

      renderGrillaTodosLosTurnos(data, aulaId); // ✅ render extendido

      window.aulaSeleccionada = null; // 🧼 evitar render filtrado posterior
    })
    .catch(err => {
      console.error('❌ Error al cargar asignaciones:', err);
      mostrarMensaje('error', 'No se pudieron cargar las asignaciones del aula');
    });
}