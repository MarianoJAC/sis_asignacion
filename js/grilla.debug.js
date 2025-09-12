export function toggleComentario(elem) {
  if (!elem || !(elem instanceof HTMLElement)) {
    console.warn('⚠️ toggleComentario recibió un elemento inválido:', elem);
    return;
  }

  const comentario = elem.nextElementSibling;

  if (!comentario || !comentario.classList.contains('comentario-contenido')) {
    console.warn('⚠️ No se encontró el bloque de comentario esperado');
    return;
  }

  comentario.classList.toggle('oculto');
  console.log('🧪 Comentario toggled:', comentario.classList.contains('oculto') ? 'oculto' : 'visible');
}