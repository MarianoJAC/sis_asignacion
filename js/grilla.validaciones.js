// grilla.validaciones.js

// 🧩 Rango institucional por turno (en minutos desde medianoche)
const rangoTurno = {
  Matutino:   [360, 840],     // 06:00 - 14:00
  Vespertino: [840, 1080],    // 14:00 - 18:00
  Nocturno:   [1080, 1380]    // 18:00 - 23:00
};

let asignacionesPorAulaYFecha = new Map();

export function preprocesarAsignaciones(asignaciones) {
  asignacionesPorAulaYFecha.clear();
  for (const asig of asignaciones) {
    const key = `${asig.aula_id}-${asig.fecha}`;
    if (!asignacionesPorAulaYFecha.has(key)) {
      asignacionesPorAulaYFecha.set(key, []);
    }
    asignacionesPorAulaYFecha.get(key).push(asig);
  }
}

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
function haySolapamiento(turno, horaInicio, horaFin, aula_id, fecha, idActual = null) {
  const inicioNuevo = convertirAHora(horaInicio);
  const finNuevo = convertirAHora(horaFin);

  const key = `${aula_id}-${fecha}`;
  const asignaciones = asignacionesPorAulaYFecha.get(key);

  if (!asignaciones) {
    return false;
  }

  return asignaciones.some(asig => {
    if (asig.turno !== turno) return false;
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

function getFechasSemanaCompleta() {
  const hoy = new Date();
  const diaActual = hoy.getDay(); // 0 = domingo, 1 = lunes, ..., 6 = sábado

  const lunes = new Date(hoy);
  lunes.setDate(hoy.getDate() - diaActual + 1);
  lunes.setHours(0, 0, 0, 0);

  const fechas = [];
  for (let i = 0; i < 6; i++) {
    const f = new Date(lunes);
    f.setDate(lunes.getDate() + i);
    const iso = f.toISOString().slice(0, 10); // YYYY-MM-DD
    fechas.push(iso);
  }

  return fechas;
}

function calcularDisponibilidad(turno, asignaciones) {
  const [inicioTurno, finTurno] = rangoTurno[turno];
  const huecos = [];

  let anteriorFin = inicioTurno;

  asignaciones
    .filter(a => a.turno === turno)
    .sort((a, b) => convertirAHora(a.hora_inicio) - convertirAHora(b.hora_inicio))
    .forEach(asig => {
      const inicioAsignacion = convertirAHora(asig.hora_inicio);
      const finAsignacion = convertirAHora(asig.hora_fin);

      if (anteriorFin < inicioAsignacion) {
        huecos.push(`${minutosAHora(anteriorFin)} a ${minutosAHora(inicioAsignacion)}`);
      }

      anteriorFin = Math.max(anteriorFin, finAsignacion);
    });

  if (anteriorFin < finTurno) {
    huecos.push(`${minutosAHora(anteriorFin)} a ${minutosAHora(finTurno)}`);
  }

  return huecos;
}

function formatearFecha(fecha) {
  const fechaISO = fecha.trim();
  const fechaObj = new Date(fechaISO + 'T00:00:00');
  if (isNaN(fechaObj)) {
    return 'Fecha inválida';
  }
  const opciones = { weekday: 'long', day: 'numeric', month: 'short' };
  return fechaObj.toLocaleDateString('es-AR', opciones);
}


export {
  rangoTurno,
  convertirAHora,
  esHorarioValido,
  haySolapamiento,
  minutosAHora,
  getFechasSemanaCompleta,
  calcularDisponibilidad,
  formatearFecha
};