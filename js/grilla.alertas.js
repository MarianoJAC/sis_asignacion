export function mostrarMensaje(tipo = 'info', texto = '', opciones = {}) {
  if (typeof Swal === 'undefined') {
    console.warn('[ALERTAS] SweetAlert2 no está cargado');
    alert(texto); // Fallback a alert nativo
    return;
  }
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