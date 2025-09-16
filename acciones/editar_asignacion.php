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

// 🧼 Lectura segura
$input = json_decode(file_get_contents('php://input'), true);

// 🧑 Obtener usuario actual (ajustar según tu sistema)
session_start();
$usuarioId = $_SESSION['usuario_id'] ?? null;

if (!$usuarioId) {
  echo json_encode(['ok' => false, 'error' => 'Usuario no autenticado']);
  exit;
}

// 🧠 Extracción defensiva
$id         = $input['id']         ?? '';
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
$comentarios = trim($input['comentarios'] ?? '');

// 🛡️ Validación básica
if (!$id || !$aula_id || !$fecha || !$turno || !$carrera || !$anio || !$materia || !$profesor || !$entidad || !$inicio || !$fin) {
  echo json_encode(['ok' => false, 'error' => 'Faltan campos obligatorios']);
  exit;
}

// 🔍 Obtener estado anterior
$prevQuery = $conexion->prepare("SELECT aula_id, fecha, turno, carrera, anio, profesor, materia, entidad_id, hora_inicio, hora_fin, comentarios FROM asignaciones WHERE Id = ?");
$prevQuery->bind_param("i", $id);
$prevQuery->execute();
$prevResult = $prevQuery->get_result();

if ($prevResult->num_rows === 0) {
  echo json_encode(['ok' => false, 'error' => 'Asignación no encontrada']);
  exit;
}

$prev = $prevResult->fetch_assoc();

// ✅ Actualización blindada
$stmt = $conexion->prepare("UPDATE asignaciones SET 
  aula_id = ?, fecha = ?, turno = ?, carrera = ?, anio = ?, profesor = ?, materia = ?, entidad_id = ?, hora_inicio = ?, hora_fin = ?, comentarios = ?
  WHERE Id = ?");
$stmt->bind_param("sssssssssssi", $aula_id, $fecha, $turno, $carrera, $anio, $profesor, $materia, $entidad, $inicio, $fin, $comentarios, $id);

if ($stmt->execute()) {
  // 🧾 Auditoría por campo modificado
  $campos = [
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
  ];

  foreach ($campos as $campo => $nuevoValor) {
    $valorAnterior = $prev[$campo] ?? '';
    if ($valorAnterior != $nuevoValor) {
      registrarAuditoria('asignacion', $id, $usuarioId, 'modificacion', $campo, $valorAnterior, $nuevoValor);
    }
  }

  echo json_encode(['ok' => true, 'mensaje' => '✅ Asignación actualizada']);
} else {
  echo json_encode(['ok' => false, 'error' => $stmt->error]);
}
exit;