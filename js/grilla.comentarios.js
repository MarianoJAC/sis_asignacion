export function toggleComentario(elem) {
  if (!elem || !(elem instanceof HTMLElement)) {

    return;
  }

  const comentario = elem.nextElementSibling;

  if (!comentario || !comentario.classList.contains('comentario-contenido')) {

    return;
  }

  comentario.classList.toggle('oculto');

}