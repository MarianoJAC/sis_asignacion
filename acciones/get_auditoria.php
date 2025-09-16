<?php
include '../config/conexion.php';
header('Content-Type: application/json');

// 🧑 Validación de sesión y rol
session_start();
if (!isset($_SESSION['usuario_id']) || $_SESSION['role'] !== 'admin') {
  echo json_encode(['ok' => false, 'error' => 'Acceso denegado']);
  exit;
}

// 🧩 Filtros dinámicos
$usuario = $_GET['usuario'] ?? '';
$tipo    = $_GET['tipo']    ?? '';
$accion  = $_GET['accion']  ?? '';
$desde   = $_GET['desde']   ?? '';
$hasta   = $_GET['hasta']   ?? '';

$filtros = [];
$params  = [];
$tipos   = '';

if ($usuario) {
  $filtros[] = 'u.username = ?';
  $params[] = $usuario;
  $tipos .= 's';
}
if ($tipo) {
  $filtros[] = 'a.tipo_objeto = ?';
  $params[] = $tipo;
  $tipos .= 's';
}
if ($accion) {
  $filtros[] = 'a.accion = ?';
  $params[] = $accion;
  $tipos .= 's';
}
if ($desde && $hasta) {
  $filtros[] = 'a.fecha BETWEEN ? AND ?';
  $params[] = $desde . ' 00:00:00';
  $params[] = $hasta . ' 23:59:59';
  $tipos .= 'ss';
}

$where = $filtros ? 'WHERE ' . implode(' AND ', $filtros) : '';

$sql = "SELECT 
  a.id,
  a.tipo_objeto,
  a.objeto_id,
  u.username,
  a.accion,
  a.campo_modificado,
  a.valor_anterior,
  a.valor_nuevo,
  DATE_FORMAT(a.fecha, '%d/%m/%Y %H:%i') AS fecha
FROM auditoria_acciones a
JOIN usuarios u ON a.usuario_id = u.id
$where
ORDER BY a.fecha DESC
LIMIT 100";

$stmt = $conexion->prepare($sql);
if ($params) $stmt->bind_param($tipos, ...$params);
$stmt->execute();
$resultado = $stmt->get_result();
$auditorias = $resultado->fetch_all(MYSQLI_ASSOC);

echo json_encode(['ok' => true, 'auditorias' => $auditorias]);