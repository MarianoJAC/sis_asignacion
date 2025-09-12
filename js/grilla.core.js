import { renderGrilla, cargarAsignacionesPorAula } from './grilla.render.js';
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

  if (aulaId > 0) {
    console.log('🧪 Aula seleccionada desde mapa:', aulaId);
    window.aulaSeleccionada = aulaId;
    cargarAsignacionesPorAula(aulaId);
  } else {
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
  }

  // 🧹 Botón para salir del filtro de aula
  const btnVerTodas = document.getElementById('btn-ver-todas');
  if (btnVerTodas) {
    btnVerTodas.addEventListener('click', () => {
      window.aulaSeleccionada = null;
      const turno = document.querySelector('.tab-btn.active')?.dataset.turno || 'Matutino';
      renderGrilla(turno, window.datosGlobales, null);
      mostrarMensaje('info', 'Vista completa activada');
      console.log('🧹 Filtro de aula desactivado');
    });
  }
});