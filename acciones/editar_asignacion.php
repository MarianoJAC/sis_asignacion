<?php
include '../config/conexion.php';

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

// 🧠 Preparar respuesta JSON
header('Content-Type: application/json');

// 🛡️ Validación básica
if (!$id || !$aula_id || !$fecha || !$turno || !$carrera || !$anio || !$materia || !$profesor || !$entidad || !$inicio || !$fin) {
  echo json_encode(['ok' => false, 'error' => 'Faltan campos obligatorios']);
  exit;
}

// ✅ Actualización blindada
$stmt = $conexion->prepare("UPDATE asignaciones SET 
  aula_id = ?, fecha = ?, turno = ?, carrera = ?, anio = ?, profesor = ?, materia = ?, entidad_id = ?, hora_inicio = ?, hora_fin = ?, comentarios = ?
  WHERE Id = ?");

$stmt->bind_param("sssssssssssi", $aula_id, $fecha, $turno, $carrera, $anio, $profesor, $materia, $entidad, $inicio, $fin, $comentarios, $id);

if ($stmt->execute()) {
  echo json_encode(['ok' => true, 'mensaje' => '✅ Asignación actualizada']);
} else {
  echo json_encode(['ok' => false, 'error' => $stmt->error]);
}

exit;