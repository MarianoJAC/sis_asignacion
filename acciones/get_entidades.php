<?php
include '../config/conexion.php';

// 🛡️ Encabezado para respuesta JSON
header('Content-Type: application/json; charset=utf-8');

// 🧪 Validación de conexión y consulta
$res = mysqli_query($conexion, "SELECT entidad_id, nombre, color FROM entidades ORDER BY nombre ASC");

if (!$res) {
  http_response_code(500);
  echo json_encode([
    'ok' => false,
    'error' => 'Error al consultar entidades'
  ]);
  exit;
}

// 📦 Armado del array
$entidades = [];
while ($row = mysqli_fetch_assoc($res)) {
  $entidades[] = [
    'id' => $row['entidad_id'],
    'nombre' => $row['nombre'],
    'color' => $row['color']
  ];
}

// ✅ Respuesta estructurada
echo json_encode([
  'ok' => true,
  'entidades' => $entidades
]);