
<?php
session_start();
// Proteger la página para que solo el rol 'invitado' pueda acceder.
if (!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] !== true || $_SESSION["role"] !== 'invitado') {
    header("location: ../index.php");
    exit;
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Asistente de Reservas IA</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/vanilla-calendar-pro/build/vanilla-calendar.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <link rel="stylesheet" href="../css/variables.css?v=1.1">
    <link rel="stylesheet" href="../css/global.css?v=1.1">
    <style>
        .chat-container {
            max-width: 800px;
            margin: 2rem auto;
            border: 1px solid #ddd;
            border-radius: 0.5rem;
            overflow: hidden;
        }
        .chat-box {
            height: 400px;
            overflow-y: auto;
            padding: 1rem;
            background-color: #f9f9f9;
        }
        .chat-message {
            margin-bottom: 1rem;
        }
        .chat-message.user {
            text-align: right;
        }
        .chat-message .message-bubble {
            display: inline-block;
            padding: 0.5rem 1rem;
            border-radius: 1rem;
            max-width: 80%;
        }
        .chat-message.user .message-bubble {
            background-color: #0d6efd;
            color: white;
        }
        .chat-message.bot .message-bubble {
            background-color: #e9ecef;
        }
        .chat-input {
            display: flex;
            padding: 1rem;
            border-top: 1px solid #ddd;
        }
        #calendar-container, #time-picker-container {
            display: none;
        }
        #calendar-container {
            margin: 1rem auto;
        }
        .hidden {
            display: none !important;
        }

        /* Overrides para el time-picker (flatpickr) */
        .flatpickr-time {
            background: #fff;
            border-radius: 0.5rem;
            box-shadow: 0 0.125rem 0.25rem rgba(0,0,0,.075);
            border: 1px solid #dee2e6;
        }
        .flatpickr-time .numInputWrapper:hover {
            background: #e9ecef;
        }
        .flatpickr-time .numInput {
            color: #333;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="chat-container card shadow-lg">
            <div class="card-header text-center">
                <h3>Asistente de Reservas CRUI</h3>
            </div>
            <div class="chat-box card-body" id="chat-box">
                <!-- Los mensajes del chat se agregarán aquí -->
            </div>
            <div id="calendar-container"></div>
            <div id="calendar-controls" style="display: none; text-align: center; margin-top: 1rem;">
                <button class="btn btn-primary" id="confirm-date-btn">Confirmar Fecha</button>
            </div>
            <div id="time-picker-container" style="margin: 1rem auto;">
                <div class="row">
                    <div class="col-md-6">
                        <h5>Hora de Inicio</h5>
                        <div id="time-picker-start"></div>
                    </div>
                    <div class="col-md-6">
                        <h5>Hora de Fin</h5>
                        <div id="time-picker-end"></div>
                    </div>
                </div>
                <div style="text-align: center; margin-top: 1rem;">
                    <button class="btn btn-primary" id="confirm-times-btn">Confirmar Horarios</button>
                </div>
            </div>
            <div id="reservation-type-buttons" class="d-flex justify-content-center gap-2" style="display: none; margin: 1rem auto;"></div>
            <div id="entity-selector-container" class="justify-content-center align-items-center gap-2 hidden" style="margin: 1rem auto;">
                <select id="entity-select" class="form-select" style="width: auto; min-width: 200px;"></select>
                <button id="confirm-entity-btn" class="btn btn-primary">Confirmar</button>
            </div>
            <div id="aula-selector-container" class="justify-content-center align-items-center gap-2 hidden" style="margin: 1rem auto;">
                <select id="aula-select" class="form-select" style="width: auto; min-width: 200px;"></select>
                <button id="confirm-aula-btn" class="btn btn-primary">Confirmar</button>
            </div>
            <div id="confirm-buttons" class="d-flex justify-content-center gap-2" style="display: none; margin: 1rem auto;"></div>
            <div id="comment-buttons" class="d-flex justify-content-center gap-2" style="display: none; margin: 1rem auto;"></div>
            <div class="chat-input card-footer">
                <input type="text" class="form-control" id="user-input" placeholder="Escribe tu respuesta...">
                <button class="btn btn-primary ms-2" id="send-btn">Enviar</button>
            </div>
        </div>
        <div class="text-center mt-3">
            <a href="menu_invitado.php" class="btn btn-sm btn-outline-secondary">Volver al Menú</a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/vanilla-calendar-pro/build/vanilla-calendar.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script src="../js/reserva_ia.js"></script>
</body>
</html>
