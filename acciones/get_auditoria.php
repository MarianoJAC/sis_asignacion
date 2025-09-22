<?php
require_once __DIR__ . '/api_utils.php';

// Solo los administradores pueden acceder a la auditoría
validar_admin();

// --- Lógica de Paginación y Filtros ---
$page = isset($_GET['page']) ? intval($_GET['page']) : 1;
$limit = isset($_GET['limit']) ? intval($_GET['limit']) : 25;
$offset = ($page - 1) * $limit;

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

// --- Conteo Total para Paginación ---
$totalQuery = "SELECT COUNT(a.id) as total FROM auditoria_acciones a JOIN usuarios u ON a.usuario_id = u.id $where";
$stmtTotal = $conexion->prepare($totalQuery);
if (!$stmtTotal) {
    responder_error("Error al preparar la consulta de conteo.", 500);
}
if ($params) {
    $stmtTotal->bind_param($tipos, ...$params);
}
if (!$stmtTotal->execute()) {
    responder_error("Error al ejecutar la consulta de conteo.", 500);
}

$totalResult = $stmtTotal->get_result()->fetch_assoc();
$totalRecords = $totalResult['total'];
$totalPages = ceil($totalRecords / $limit);
$stmtTotal->close();

// --- Obtención de Registros Paginados ---
$sql = "SELECT 
  a.id, a.tipo_objeto, a.objeto_id, u.username, a.accion, a.campo_modificado,
  a.valor_anterior, a.valor_nuevo, DATE_FORMAT(a.fecha, '%d/%m/%Y %H:%i') AS fecha
FROM auditoria_acciones a
JOIN usuarios u ON a.usuario_id = u.id
$where
ORDER BY a.fecha DESC
LIMIT ? OFFSET ?";

// Añadir limit y offset a los parámetros para la consulta principal
$params_paginados = $params;
$params_paginados[] = $limit;
$params_paginados[] = $offset;
$tipos_paginados = $tipos . 'ii';

$stmt = $conexion->prepare($sql);
if (!$stmt) {
    responder_error("Error al preparar la consulta principal.", 500);
}
if ($params_paginados) {
    $stmt->bind_param($tipos_paginados, ...$params_paginados);
}
if (!$stmt->execute()) {
    responder_error("Error al ejecutar la consulta principal.", 500);
}

$resultado = $stmt->get_result();
$auditorias = $resultado->fetch_all(MYSQLI_ASSOC);
$stmt->close();
$conexion->close();

// --- Respuesta Final ---
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
?>