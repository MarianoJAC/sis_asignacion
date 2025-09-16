
function mostrarMensaje(tipo = 'info', texto = '', opciones = {}) {
  Swal.fire({
    icon: tipo, // 'success', 'error', 'warning', 'info'
    text: texto,
    toast: true,
    timer: 2200,
    showConfirmButton: false,
    position: 'center',
    ...opciones
  });
}
