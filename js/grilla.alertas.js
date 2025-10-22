
export function mostrarMensaje(tipo = 'info', texto = '', opciones = {}) {
  Swal.fire({
    icon: tipo === 'success' ? false : tipo, // Disable icon only for 'success' type
    text: texto,
    toast: true,
    timer: 3000,
    showConfirmButton: false,
    position: 'center',
    ...opciones
  });
}
