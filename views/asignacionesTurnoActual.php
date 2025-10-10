<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Turno Actual</title>
    
    <link rel="stylesheet" href="../css/variables.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="icon" href="../iconos/calendario.ico" type="image/x-icon">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&family=Roboto+Mono:wght@400;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

    <style>
        body {
            background-color: var(--background-color-light, #F8F9FA);
            font-family: 'Roboto', sans-serif;
            color: var(--text-color-dark, #202124);
            margin: 0;
            padding: 1em;
            user-select: none; /* Prevent text selection */
        }
        .board-container {
            border: 1px solid var(--border-color, #DADCDE);
            border-radius: 8px;
            overflow: hidden;
            background-color: var(--background-color-white, #FFFFFF);
            box-shadow: 0 2px 4px var(--shadow-color, rgba(0, 0, 0, 0.1));
        }
        .board-header {
            background-color: var(--primary-color, #4285F4);
            color: var(--background-color-white, #FFFFFF);
            padding: 0.75em 1.5em;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .board-header h2 {
            margin: 0;
            font-size: 2em; /* Increased */
            font-weight: 700;
        }
        .board-header .icon-container {
            font-size: 1.5em;
            cursor: pointer;
        }
        .board-table {
            width: 100%;
            border-collapse: collapse;
        }
        .board-table th, .board-table td {
            padding: 0.75em 1.5em;
            text-align: left;
            font-size: 1.2em; /* Increased */
        }
        .board-table thead {
            color: var(--text-color-light, #5F6368);
            font-size: 1em; /* Adjusted */
            font-weight: 700; /* Bolder */
            text-transform: uppercase;
            border-bottom: 2px solid var(--border-color, #DADCDE);
        }
        .board-table tbody tr {
            border-bottom: 1px solid var(--border-color, #DADCDE);
        }
        .board-table tbody tr:last-child {
            border-bottom: none;
        }
        .board-table .aula-cell {
            color: var(--primary-color, #4285F4);
            font-weight: 700;
        }
        #status-container {
            text-align: center;
            padding: 2em;
            font-size: 1.2em;
            color: var(--text-color-light, #5F6368);
        }
    </style>
</head>
<body>

<a href="grilla.php" id="volver-btn" class="btn btn-primary btn-sm mb-3">Volver a la grilla</a>

<div class="board-container">
    <div class="board-header">
        <h2>ASIGNACIONES EN CURSO</h2>
        <div class="icon-container" id="fullscreen-btn">
            <i class="fas fa-expand"></i>
        </div>
    </div>
    <table class="board-table">
        <thead>
            <tr>
                <th>HORA</th>
                <th>ENTIDAD</th>
                <th>MATERIA</th>
                <th>PROFESOR</th>
                <th>AULA</th>
            </tr>
        </thead>
        <tbody id="asignaciones-body"></tbody>
    </table>
    <div id="status-container"></div>
</div>

<script>
    const tbody = document.getElementById('asignaciones-body');
    const statusContainer = document.getElementById('status-container');
    const fullscreenBtn = document.getElementById('fullscreen-btn');

    fullscreenBtn.addEventListener('click', () => {
        if (!document.fullscreenElement) {
            document.documentElement.requestFullscreen().catch(err => {
                alert(`Error al intentar entrar en pantalla completa: ${err.message} (${err.name})`);
            });
        } else {
            if (document.exitFullscreen) {
                document.exitFullscreen();
            }
        }
    });

    async function cargarAsignaciones() {
        try {
            const response = await fetch('../acciones/get_asignaciones_turno_actual.php');
            if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
            
            const asignaciones = await response.json();
            
            const newContent = JSON.stringify(asignaciones);
            if (tbody.dataset.content === newContent) {
                return;
            }
            tbody.dataset.content = newContent;

            tbody.innerHTML = '';

            if (asignaciones.length === 0) {
                statusContainer.innerHTML = 'No hay asignaciones para el turno actual.';
            } else {
                statusContainer.innerHTML = '';
                asignaciones.forEach(asig => {
                    const tr = document.createElement('tr');
                    tr.dataset.horaInicio = asig.hora_inicio;
                    tr.dataset.horaFin = asig.hora_fin;

                    tr.innerHTML = `
                        <td>${asig.horario}</td>
                        <td style="color: ${asig.color_entidad}; font-weight: 700;">${asig.entidad}</td>
                        <td>${asig.materia}</td>
                        <td>${asig.profesor}</td>
                        <td class="aula-cell">${asig.aula}</td>
                    `;
                    tbody.appendChild(tr);
                });
                actualizarVisibilidad();
            }
        } catch (error) {
            console.error('Error al cargar las asignaciones:', error);
            statusContainer.innerHTML = 'Error al cargar los datos.';
        }
    }

    function actualizarVisibilidad() {
        const ahora = new Date();
        const horaActual = ahora.toTimeString().split(' ')[0];

        const filas = tbody.querySelectorAll('tr');
        let asignacionesVisibles = 0;
        
        filas.forEach(fila => {
            const horaInicio = fila.dataset.horaInicio;
            const horaFin = fila.dataset.horaFin;

            const haComenzado = horaActual >= horaInicio;
            const haFinalizado = horaFin && horaActual > horaFin;

            if (haComenzado && !haFinalizado) {
                fila.style.display = '';
                asignacionesVisibles++;
            } else {
                fila.style.display = 'none';
            }
        });

        const hayAsignacionesCargadas = tbody.dataset.content && JSON.parse(tbody.dataset.content).length > 0;

        if (hayAsignacionesCargadas && asignacionesVisibles === 0) {
            const todasHanFinalizado = Array.from(filas).every(f => horaActual > f.dataset.horaFin);
            if (todasHanFinalizado) {
                statusContainer.innerHTML = 'Todas las asignaciones del turno han finalizado.';
            } else {
                statusContainer.innerHTML = 'Esperando próximas asignaciones del turno...';
            }
        } else if (hayAsignacionesCargadas && asignacionesVisibles > 0) {
            statusContainer.innerHTML = '';
        } else if (!hayAsignacionesCargadas) {
            statusContainer.innerHTML = 'No hay asignaciones para el turno actual.';
        }
    }

    cargarAsignaciones();
    setInterval(cargarAsignaciones, 5000);
    setInterval(actualizarVisibilidad, 1000);

    const volverBtn = document.getElementById('volver-btn');
    document.addEventListener('fullscreenchange', () => {
        if (document.fullscreenElement) {
            volverBtn.style.display = 'none';
        } else {
            volverBtn.style.display = 'inline-block';
        }
    });

</script>

</body>
</html>