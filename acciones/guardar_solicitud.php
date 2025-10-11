
<?php
require_once '../config/conexion.php';

session_start();

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Validacion de sesion de invitado
    if (!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] !== true || $_SESSION["role"] !== 'invitado') {
        header("location: ../index.php?status=error");
        exit;
    }

    // Recoleccion de datos comunes
    $tipo_reserva = filter_input(INPUT_POST, 'tipo_reserva', FILTER_VALIDATE_INT);
    $fecha = $_POST['fecha'] ?? '';
    $entidad_id = filter_input(INPUT_POST, 'entidad_id', FILTER_VALIDATE_INT);
    $carrera = trim($_POST['carrera'] ?? '');
    $anio = trim($_POST['anio'] ?? '');
    $materia = trim($_POST['materia'] ?? '');
    $profesor = trim($_POST['profesor'] ?? '');
    $hora_inicio = $_POST['hora_inicio'] ?? '';
    $hora_fin = $_POST['hora_fin'] ?? '';
    $telefono_contacto = trim($_POST['telefono_contacto'] ?? '');
    $comentarios = trim($_POST['comentarios'] ?? '');
    
    // Recoleccion de datos especificos
    $cantidad_pc = null;
    if ($tipo_reserva == 2) { // Laboratorio Ambulante
        $cantidad_pc = filter_input(INPUT_POST, 'cantidad_pc', FILTER_VALIDATE_INT);
    }
    $aula_id = null;
    if ($tipo_reserva == 1) { // Reserva de Aula
        $aula_id = filter_input(INPUT_POST, 'aula_id', FILTER_VALIDATE_INT);
    }

    // Validacion basica
    if (!$tipo_reserva || !$fecha || !$entidad_id || !$carrera || !$anio || !$materia || !$profesor || !$hora_inicio || !$hora_fin || !$telefono_contacto) {
        die("Error: Todos los campos obligatorios deben ser completados.");
    }

    $sql = "INSERT INTO reservas (tipo_reserva, fecha, entidad_id, aula_id, carrera, anio, materia, profesor, hora_inicio, hora_fin, telefono_contacto, cantidad_pc, comentarios) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    if ($stmt = $conexion->prepare($sql)) {
        $stmt->bind_param("isiisssssssis", 
            $tipo_reserva, 
            $fecha, 
            $entidad_id, 
            $aula_id,
            $carrera, 
            $anio, 
            $materia, 
            $profesor, 
            $hora_inicio, 
            $hora_fin, 
            $telefono_contacto, 
            $cantidad_pc, 
            $comentarios
        );

        if ($stmt->execute()) {
            // Redireccionar a la pagina del formulario correspondiente con un mensaje de exito
            $redirect_url = '../views/form_reserva.php'; // URL por defecto
            if ($tipo_reserva == 2) {
                $redirect_url = '../views/form_laboratorio.php';
            } elseif ($tipo_reserva == 3) {
                $redirect_url = '../views/form_kit_tv.php';
            }
            header("location: " . $redirect_url . "?status=success");
        } else {
            // Redireccionar con mensaje de error
            header("location: " . $redirect_url . "?status=error");
        }
        $stmt->close();
    } else {
        die("Error en la preparacion de la consulta: " . $conexion->error);
    }
    $conexion->close();
} else {
    header("location: ../index.php");
    exit;
}
?>
