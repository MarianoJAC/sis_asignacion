function esHorarioValido(horaInicio, horaFin, turno) {
  const [hI, mI] = horaInicio.split(':').map(Number);
  const [hF, mF] = horaFin.split(':').map(Number);
  const minutosInicio = hI * 60 + mI;
  const minutosFin = hF * 60 + mF;

  if (minutosFin <= minutosInicio) return false;

  const rangoTurno = {
    'Matutino':   [360, 840],     // 6:00 - 14:00
    'Vespertino': [780, 1260],    // 13:00 - 21:00
    'Nocturno':   [1080, 1380]    // 18:00 - 23:00
  };

  const [desde, hasta] = rangoTurno[turno] || [0, 1440];
  return minutosInicio >= desde && minutosFin <= hasta;
}

function convertirAHora(horaStr) {
  const [h, m] = horaStr.split(':').map(Number);
  return h * 60 + m;
}

function haySolapamiento(turno, horaInicio, horaFin, aula_id, dia, idActual = null) {
  const inicioNuevo = convertirAHora(horaInicio);
  const finNuevo = convertirAHora(horaFin);

  return datosGlobales.asignaciones.some(asig => {
    if (asig.turno !== turno || asig.aula_id !== aula_id || asig.dia !== dia) return false;
    if (idActual && asig.Id === idActual) return false;

    const inicioExistente = convertirAHora(asig.hora_inicio);
    const finExistente = convertirAHora(asig.hora_fin);

    return !(finNuevo <= inicioExistente || inicioNuevo >= finExistente);
  });
}