<?php
header('Content-Type: application/json; charset=utf-8');
include '../config/conexion.php';

// 🧩 Función para registrar auditoría
function registrarAuditoria($tipo, $objetoId, $usuarioId, $accion, $campo = null, $valorAnterior = null, $valorNuevo = null) {
  global $conexion;
  $stmt = $conexion->prepare("INSERT INTO auditoria_acciones 
    (tipo_objeto, objeto_id, usuario_id, accion, campo_modificado, valor_anterior, valor_nuevo) 
    VALUES (?, ?, ?, ?, ?, ?, ?)");
  $stmt->bind_param("sisssss", $tipo, $objetoId, $usuarioId, $accion, $campo, $valorAnterior, $valorNuevo);
  $stmt->execute();
}

$data = json_decode(file_get_contents("php://input"), true);

// Sanitización
$nombre = trim(preg_replace('/\s+/', ' ', $data['nombre'] ?? ''));
$color = trim($data['color'] ?? '');

// 🧑 Obtener usuario actual (ajustar según tu sistema)
session_start();
$usuarioId = $_SESSION['usuario_id'] ?? null;

if (!$usuarioId) {
  echo json_encode(['ok' => false, 'error' => 'Usuario no autenticado']);
  exit;
}

if (!$nombre || !$color) {
  echo json_encode(['ok' => false, 'error' => 'Datos incompletos']);
  exit;
}

if (!preg_match('/^#[0-9A-F]{6}$/i', $color)) {
  echo json_encode(['ok' => false, 'error' => 'Color inválido']);
  exit;
}

// Chequeo de duplicado
$check = $conexion->prepare("SELECT 1 FROM entidades WHERE UPPER(nombre) = ?");
$check->bind_param("s", $nombre);
$check->execute();
$check->store_result();

if ($check->num_rows > 0) {
  echo json_encode(['ok' => false, 'error' => 'La entidad ya existe']);
  exit;
}

try {
  $stmt = $conexion->prepare("INSERT INTO entidades (nombre, color) VALUES (?, ?)");
  $stmt->bind_param("ss", $nombre, $color);
  $stmt->execute();

  $entidadId = $stmt->insert_id;

  // 🧾 Registrar auditoría
  $valorNuevo = json_encode(['nombre' => $nombre, 'color' => $color], JSON_UNESCAPED_UNICODE);
  registrarAuditoria('entidad', $entidadId, $usuarioId, 'alta', null, null, $valorNuevo);

  echo json_encode(['ok' => true]);
} catch (mysqli_sql_exception $e) {
  echo json_encode(['ok' => false, 'error' => 'La entidad ya existe']);
}
exit;