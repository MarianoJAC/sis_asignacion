<?php
session_start();

// Solo usuarios con rol 'invitado' pueden guardar.
if (!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] !== true || $_SESSION["role"] !== 'invitado') {
    header("location: ../index.php");
    exit;
}

require_once '../config/conexion.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Validar que los campos requeridos no estén vacíos
    $required_fields = ['fecha', 'entidad_id', 'carrera', 'anio', 'materia', 'profesor', 'hora_inicio', 'hora_fin', 'telefono_contacto'];
    $error = false;
    foreach ($required_fields as $field) {
        if (empty($_POST[$field])) {
            $error = true;
            break;
        }
    }

    if ($error) {
        header("location: ../views/form_reserva.php?status=error");
        exit;
    }

    // Asignar variables desde POST
    $fecha = $_POST['fecha'];
    $entidad_id = $_POST['entidad_id'];
    $carrera = $_POST['carrera'];
    $anio = $_POST['anio'];
    $materia = $_POST['materia'];
    $profesor = $_POST['profesor'];
    $hora_inicio = $_POST['hora_inicio'];
    $hora_fin = $_POST['hora_fin'];
    $telefono_contacto = $_POST['telefono_contacto'];
    $comentarios = $_POST['comentarios'] ?? ''; // Comentarios es opcional

    // Preparar la sentencia SQL para evitar inyección SQL
    $sql = "INSERT INTO reservas (fecha, entidad_id, carrera, anio, materia, profesor, hora_inicio, hora_fin, telefono_contacto, comentarios) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    if ($stmt = $conexion->prepare($sql)) {
        // Vincular parámetros
        $stmt->bind_param("sissssssss", $fecha, $entidad_id, $carrera, $anio, $materia, $profesor, $hora_inicio, $hora_fin, $telefono_contacto, $comentarios);

        // Ejecutar la sentencia
        if ($stmt->execute()) {
            // Redirigir con éxito
            header("location: ../views/form_reserva.php?status=success");
        } else {
            // Redirigir con error
            header("location: ../views/form_reserva.php?status=error");
        }
        $stmt->close();
    } else {
        header("location: ../views/form_reserva.php?status=error");
    }

    $conexion->close();
} else {
    // Si no es un método POST, redirigir
    header("location: ../views/form_reserva.php");
    exit;
}
?>