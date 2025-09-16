<?php
include '../config/conexion.php';
header('Content-Type: application/json');

// 🧩 Función para registrar auditoría
function registrarAuditoria($tipo, $objetoId, $usuarioId, $accion, $campo = null, $valorAnterior = null, $valorNuevo = null) {
  global $conexion;
  $stmt = $conexion->prepare("INSERT INTO auditoria_acciones 
    (tipo_objeto, objeto_id, usuario_id, accion, campo_modificado, valor_anterior, valor_nuevo) 
    VALUES (?, ?, ?, ?, ?, ?, ?)");
  $stmt->bind_param("sisssss", $tipo, $objetoId, $usuarioId, $accion, $campo, $valorAnterior, $valorNuevo);
  $stmt->execute();
}

// 🧠 Capitalización con soporte de acentos
function capitalizar($texto) {
  $texto = mb_strtolower(trim($texto), 'UTF-8');
  $palabras = explode(' ', $texto);
  $excepciones = ['de', 'del', 'la', 'las', 'los', 'y', 'a', 'en', 'el', 'al', 'con', 'por'];

  foreach ($palabras as &$palabra) {
    if (!in_array($palabra, $excepciones)) {
      $palabra = mb_strtoupper(mb_substr($palabra, 0, 1), 'UTF-8') . mb_substr($palabra, 1);
    }
  }

  return implode(' ', $palabras);
}

// 🧼 Lectura segura del JSON
$input = json_decode(file_get_contents('php://input'), true);

// 🧑 Obtener usuario actual (ajustar según tu sistema)
session_start();
$usuarioId = $_SESSION['usuario_id'] ?? null;

if (!$usuarioId) {
  echo json_encode(['ok' => false, 'error' => 'Usuario no autenticado']);
  exit;
}

// 🧠 Extracción defensiva
$aula_id    = $input['aula_id']    ?? '';
$fecha      = $input['fecha']      ?? '';
$turno      = $input['turno']      ?? '';
$carrera    = capitalizar($input['carrera'] ?? '');
$anio       = $input['anio']       ?? '';
$materia    = capitalizar($input['materia'] ?? '');
$profesor   = capitalizar($input['profesor'] ?? '');
$entidad    = $input['entidad_id'] ?? '';
$inicio     = $input['hora_inicio'] ?? '';
$fin        = $input['hora_fin']    ?? '';
$comentarios = isset($input['comentarios']) ? trim($input['comentarios']) : '';

// 🛡️ Validación básica
if (!$aula_id || !$fecha || !$turno || !$carrera || !$anio || !$materia || !$profesor || !$entidad || !$inicio || !$fin) {
  echo json_encode(['ok' => false, 'error' => 'Faltan campos obligatorios']);
  exit;
}

// 🔍 Validación de existencia de entidad
$check = mysqli_query($conexion, "SELECT 1 FROM entidades WHERE entidad_id = '$entidad'");
if (mysqli_num_rows($check) === 0) {
  echo json_encode(['ok' => false, 'error' => 'La entidad no existe']);
  exit;
}

// 🔍 Verificación de duplicado funcional
$verificar = $conexion->prepare("SELECT COUNT(*) FROM asignaciones WHERE 
  aula_id = ? AND fecha = ? AND turno = ? AND materia = ? AND profesor = ? AND hora_inicio = ? AND hora_fin = ?");
$verificar->bind_param("sssssss", $aula_id, $fecha, $turno, $materia, $profesor, $inicio, $fin);
$verificar->execute();
$verificar->bind_result($total);
$verificar->fetch();
$verificar->close();

if ($total > 0) {
  echo json_encode(['ok' => false, 'error' => 'Ya existe una asignación con esos datos']);
  exit;
}

// 🧪 Trazabilidad
error_log("🧪 Insertando asignación: $materia - $profesor - $fecha - $turno - $inicio/$fin");

// ✅ Inserción blindada
$stmt = $conexion->prepare("INSERT INTO asignaciones (
  aula_id, fecha, turno, carrera, anio, profesor, materia, entidad_id, hora_inicio, hora_fin, comentarios
) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

$stmt->bind_param("sssssssssss", $aula_id, $fecha, $turno, $carrera, $anio, $profesor, $materia, $entidad, $inicio, $fin, $comentarios);

if ($stmt->execute()) {
  $asignacionId = $stmt->insert_id;

  // 🧾 Registrar auditoría
  $valorNuevo = json_encode([
    'aula_id' => $aula_id,
    'fecha' => $fecha,
    'turno' => $turno,
    'carrera' => $carrera,
    'anio' => $anio,
    'profesor' => $profesor,
    'materia' => $materia,
    'entidad_id' => $entidad,
    'hora_inicio' => $inicio,
    'hora_fin' => $fin,
    'comentarios' => $comentarios
  ], JSON_UNESCAPED_UNICODE);

  registrarAuditoria('asignacion', $asignacionId, $usuarioId, 'alta', null, null, $valorNuevo);

  echo json_encode(['ok' => true, 'mensaje' => 'Asignación guardada']);
} else {
  echo json_encode(['ok' => false, 'error' => $stmt->error]);
}
$stmt->close();
exit;