<?php
include '../config/conexion.php';
header('Content-Type: application/json');

// 🧑 Validación de sesión y rol
session_start();
if (!isset($_SESSION['usuario_id']) || $_SESSION['role'] !== 'admin') {
  echo json_encode(['ok' => false, 'error' => 'Acceso denegado']);
  exit;
}

// 🔢 Paginación
$page = isset($_GET['page']) ? intval($_GET['page']) : 1;
$limit = isset($_GET['limit']) ? intval($_GET['limit']) : 25; // 25 registros por página
$offset = ($page - 1) * $limit;

// 🧩 Filtros dinámicos
$usuario = $_GET['usuario'] ?? '';
$tipo    = $_GET['tipo']    ?? '';
$accion  = $_GET['accion']  ?? '';
$desde   = $_GET['desde']   ?? '';
$hasta   = $_GET['hasta']   ?? '';

$filtros = [];
$params  = [];
$tipos   = '';

if ($usuario) { $filtros[] = 'u.username LIKE ?'; $params[] = "%{$usuario}%"; $tipos .= 's'; }
if ($tipo) { $filtros[] = 'a.tipo_objeto = ?'; $params[] = $tipo; $tipos .= 's'; }
if ($accion) { $filtros[] = 'a.accion = ?'; $params[] = $accion; $tipos .= 's'; }
if ($desde && $hasta) { $filtros[] = 'a.fecha BETWEEN ? AND ?'; $params[] = $desde . ' 00:00:00'; $params[] = $hasta . ' 23:59:59'; $tipos .= 'ss'; }

$where = $filtros ? 'WHERE ' . implode(' AND ', $filtros) : '';

// --- 1. Obtener el total de registros con filtros ---
$totalQuery = "SELECT COUNT(a.id) as total FROM auditoria_acciones a JOIN usuarios u ON a.usuario_id = u.id $where";
$stmtTotal = $conexion->prepare($totalQuery);
if ($params) $stmtTotal->bind_param($tipos, ...$params);
$stmtTotal->execute();
$totalResult = $stmtTotal->get_result()->fetch_assoc();
$totalRecords = $totalResult['total'];
$totalPages = ceil($totalRecords / $limit);

// --- 2. Obtener los registros de la página actual ---
$sql = "SELECT 
  a.id, a.tipo_objeto, a.objeto_id, u.username, a.accion, a.campo_modificado,
  a.valor_anterior, a.valor_nuevo, DATE_FORMAT(a.fecha, '%d/%m/%Y %H:%i') AS fecha
FROM auditoria_acciones a
JOIN usuarios u ON a.usuario_id = u.id
$where
ORDER BY a.fecha DESC
LIMIT ? OFFSET ?";

// Añadir limit y offset a los parámetros
$params[] = $limit;
$params[] = $offset;
$tipos .= 'ii';

$stmt = $conexion->prepare($sql);
if ($params) $stmt->bind_param($tipos, ...$params);
$stmt->execute();
$resultado = $stmt->get_result();
$auditorias = $resultado->fetch_all(MYSQLI_ASSOC);

// --- 3. Enviar respuesta completa ---
echo json_encode([
  'ok' => true, 
  'auditorias' => $auditorias,
  'pagination' => [
    'page' => $page,
    'limit' => $limit,
    'totalRecords' => $totalRecords,
    'totalPages' => $totalPages
  ]
]);
