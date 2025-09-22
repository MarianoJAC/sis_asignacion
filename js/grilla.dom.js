/**
 * Módulo para centralizar la selección de elementos del DOM de la página de la grilla.
 * Esto evita consultas repetidas al DOM y facilita el mantenimiento.
 */

export const grillaContainer = document.getElementById('grilla-container');

// --- Filtros ---
export const inputBuscador = document.getElementById('input-buscador');
export const selectorFecha = document.getElementById('selector-fecha');
export const btnResetFecha = document.getElementById('btn-reset-fecha');
export const toggleFiltrosBtn = document.getElementById('toggle-filtros');
export const contenedorFiltros = document.getElementById('contenedor-filtros');

// --- Pestañas ---
export const tabButtons = document.querySelectorAll('.tab-btn');

// --- Modal Principal ---
export const mainModal = document.getElementById('main-modal');
export const mainModalLabel = document.getElementById('main-modal-label');
export const mainModalBody = document.getElementById('main-modal-body');

// --- Otros ---
export const comentarioGlobal = document.getElementById('comentario-global');
export const leyendaDinamica = document.getElementById('leyenda-dinamica');
export const btnMenu = document.getElementById('btn-menu');
export const menuDesplegable = document.getElementById('menu-desplegable');
