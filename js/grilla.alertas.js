
export function mostrarMensaje(tipo = 'info', texto = '', opciones = {}) {
  Swal.fire({
    icon: tipo, // 'success', 'error', 'warning', 'info'
    text: texto,
    toast: true,
    timer: 3000,
    showConfirmButton: false,
    position: 'center',
    ...opciones
  });
}
