// grilla.validaciones.js

// 🧩 Rango institucional por turno (en minutos desde medianoche)
const rangoTurno = {
  Matutino:   [360, 840],     // 06:00 - 14:00
  Vespertino: [780, 1080],    // 13:00 - 18:00
  Nocturno:   [1080, 1380]    // 18:00 - 23:00
};

// 🧠 Convierte "HH:mm" a minutos
function convertirAHora(horaStr) {
  const [h, m] = horaStr.split(':').map(Number);
  return h * 60 + m;
}

// ✅ Valida que el horario esté dentro del turno y sea coherente
function esHorarioValido(horaInicio, horaFin, turno) {
  const minutosInicio = convertirAHora(horaInicio);
  const minutosFin = convertirAHora(horaFin);

  if (minutosFin <= minutosInicio) return false;

  const [desde, hasta] = rangoTurno[turno] || [0, 1440];
  return minutosInicio >= desde && minutosFin <= hasta;
}

// 🔍 Detecta solapamientos en el mismo aula/día/turno
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

function minutosAHora(minutos) {
  const h = Math.floor(minutos / 60);
  const m = minutos % 60;
  return `${h.toString().padStart(2, '0')}:${m.toString().padStart(2, '0')}`;
}

// 📦 Export institucional
export {
  rangoTurno,
  convertirAHora,
  esHorarioValido,
  haySolapamiento,
  minutosAHora
};