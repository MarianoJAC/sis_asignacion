document.addEventListener('DOMContentLoaded', () => {
    const chatBox = document.getElementById('chat-box');
    const userInput = document.getElementById('user-input');
    const sendBtn = document.getElementById('send-btn');
    const calendarContainer = document.getElementById('calendar-container');
    const calendarControls = document.getElementById('calendar-controls');
    const confirmDateBtn = document.getElementById('confirm-date-btn');
    const chatInputContainer = document.getElementById('chat-input-container');

    function setChatInputVisible(visible) {
        if (visible) {
            chatInputContainer.style.display = 'flex';
            userInput.disabled = false;
            sendBtn.disabled = false;
        } else {
            chatInputContainer.style.display = 'none';
            userInput.disabled = true;
            sendBtn.disabled = true;
        }
    }

    const timePickerStartInput = document.getElementById('time-picker-start');
    const timePickerEndInput = document.getElementById('time-picker-end');

    let conversationState = {
        currentQuestion: 'welcome',
        reservationData: {},
        entities: [],
        aulas: [],
    };

    const questions = {
        'welcome': {
            question: '¡Hola! ¿Qué reserva te gustaría hacer?',
            next: 'ask_fecha',
        },
        'ask_fecha': {
            question: 'Perfecto, para que fecha?.',
            key: 'fecha',
            next: 'ask_entidad',
        },
        'ask_entidad': {
            question: '¿A qué entidad perteneces?',
            key: 'entidad_id',
            next: 'ask_aula',
        },
        'ask_aula': {
            question: '¿Qué aula necesitas?',
            key: 'aula_id',
            next: 'ask_carrera',
        },
        'ask_notebooks': {
            question: '¿Cuántas notebooks necesitas?',
            key: 'cantidad_pc',
            next: 'ask_carrera',
        },
        'ask_carrera': {
            question: '¿Para qué carrera es la reserva?',
            key: 'carrera',
            next: 'ask_anio',
        },
        'ask_anio': {
            question: '¿Año de la carrera?',
            key: 'anio',
            next: 'ask_materia',
        },
        'ask_materia': {
            question: '¿Cuál es la materia?',
            key: 'materia',
            next: 'ask_profesor',
        },
        'ask_profesor': {
            question: 'Nombre del profesor a cargo:',
            key: 'profesor',
            next: 'ask_hora_inicio',
        },
        'ask_hora_inicio': {
            question: '¿A qué hora comienza la reserva?',
            key: 'hora_inicio',
            next: 'ask_hora_fin',
        },
        'ask_hora_fin': {
            question: '¿A qué hora finaliza?',
            key: 'hora_fin',
            next: 'ask_telefono',
        },
        'ask_telefono': {
            question: 'Por favor, un número de teléfono de contacto:',
            key: 'telefono_contacto',
            next: 'ask_if_comment',
        },
        'ask_if_comment': {
            question: '¿Te gustaría añadir un comentario?',
            next: null, 
        },
        'ask_comentarios': {
            question: 'Escribí tu comentario.',
            key: 'comentarios',
            next: 'confirm',
        },
        'confirm': {
            question: '¡Excelente! ¿Confirmo la reserva?',
            next: 'sending',
        },
        'sending': {
            question: 'Un momento, estoy procesando tu solicitud...',
            next: null,
        },
    };

    const timePickerContainer = document.getElementById('time-picker-container');
    const timePickerStartContainer = document.getElementById('time-picker-start');
    const timePickerEndContainer = document.getElementById('time-picker-end');
    const confirmTimesBtn = document.getElementById('confirm-times-btn');

    const reservationTypeButtons = document.getElementById('reservation-type-buttons');
    const entitySelectorContainer = document.getElementById('entity-selector-container');
    const entitySelect = document.getElementById('entity-select');
    const confirmEntityBtn = document.getElementById('confirm-entity-btn');
    const aulaSelectorContainer = document.getElementById('aula-selector-container');
    const aulaSelect = document.getElementById('aula-select');
    const confirmAulaBtn = document.getElementById('confirm-aula-btn');
    const confirmButtons = document.getElementById('confirm-buttons');
    const commentButtons = document.getElementById('comment-buttons');

    let timePickerStart, timePickerEnd;

    function initTimePickers() {
        const startTime = new Date();
        // Set default start time to the next hour, rounded to 00 minutes
        startTime.setHours(startTime.getHours() + 1);
        startTime.setMinutes(0);
        startTime.setSeconds(0);

        const endTime = new Date(startTime);
        // Set default end time to one hour after the start time
        endTime.setHours(startTime.getHours() + 1);

        timePickerStart = flatpickr(timePickerStartContainer, {
            enableTime: true,
            noCalendar: true,
            dateFormat: "H:i",
            inline: true,
            time_24hr: true,
            defaultDate: startTime
        });

        timePickerEnd = flatpickr(timePickerEndContainer, {
            enableTime: true,
            noCalendar: true,
            dateFormat: "H:i",
            inline: true,
            time_24hr: true,
            defaultDate: endTime
        });
    }

    let calendar;

    function initCalendar() {
        const setDate = (dateStr) => {
            conversationState.reservationData['fecha'] = dateStr;
            confirmDateBtn.textContent = 'Confirmar Fecha';
        };

        const today = new Date();
        const todayStr = `${today.getFullYear()}-${String(today.getMonth() + 1).padStart(2, '0')}-${String(today.getDate()).padStart(2, '0')}`;

        calendar = new VanillaCalendar(calendarContainer, {
            settings: {
                lang: 'es-ES',
                selected: {
                    dates: [todayStr],
                },
                range: {
                    min: todayStr,
                },
            },
            actions: {
                clickDay(event, self) {
                    if (self.selectedDates[0]) {
                        setDate(self.selectedDates[0]);
                    }
                },
            },
        });
        calendar.init();

        // Set the initial state
        setDate(todayStr);
    }

    async function fetchEntities() {
        try {
            const response = await fetch('../acciones/get_entidades.php');
            const result = await response.json();
            if (result.ok) {
                conversationState.entities = result.entidades;
            } else {
                addMessage('Error al cargar la lista de entidades. Por favor, recarga la página.', 'bot');
            }
        } catch (error) {
            addMessage('Error de conexión al cargar las entidades. Por favor, recarga la página.', 'bot');
        }
    }

    async function fetchAulas() {
        try {
            const response = await fetch('../acciones/get_aulas_list.php');
            if (!response.ok) {
                const errorText = await response.text();
                const errorMessage = `Error HTTP ${response.status}: ${response.statusText}. No se pudo cargar la lista de aulas.`;
                addMessage(errorMessage, 'bot');
                console.error('Fetch Aulas Error:', errorText);
                return;
            }
            const result = await response.json();
            if (result.ok) {
                if (result.aulas && result.aulas.length > 0) {
                    conversationState.aulas = result.aulas;
                } else {
                    addMessage('No hay aulas disponibles para reservar en este momento.', 'bot');
                }
            } else {
                const errorMessage = `Error al cargar la lista de aulas: ${result.error || 'Error desconocido.'}`;
                addMessage(errorMessage, 'bot');
                console.error('API Error:', result.error);
            }
        } catch (error) {
            addMessage('Error de conexión al cargar las aulas. Intenta recargar la página.', 'bot');
            console.error('Fetch Aulas Connection Error:', error);
        }
    }

    function addMessage(message, sender) {
        const messageElement = document.createElement('div');
        messageElement.classList.add('chat-message', sender);
        const bubble = document.createElement('div');
        bubble.classList.add('message-bubble');
        bubble.textContent = message;
        messageElement.appendChild(bubble);
        chatBox.appendChild(messageElement);
        chatBox.scrollTop = chatBox.scrollHeight;
    }

    function askQuestion() {
        const currentState = questions[conversationState.currentQuestion];
        if (currentState && currentState.question) {
            addMessage(currentState.question, 'bot');

            const nonInputStates = ['welcome', 'ask_fecha', 'ask_hora_inicio', 'ask_entidad', 'ask_aula', 'confirm', 'ask_if_comment'];
            if (nonInputStates.includes(conversationState.currentQuestion)) {
                setChatInputVisible(false);

                if (conversationState.currentQuestion === 'welcome') {
                    reservationTypeButtons.style.display = 'flex';
                    const reservationTypes = [
                        { name: 'Aula', style: 'background-color: #cfe2ff; color: #0056b3; border-color: #b6d4fe; font-weight: bold;' },
                        { name: 'Laboratorio Ambulante', style: 'background-color: #d1e7dd; color: #218838; border-color: #c3e6cb; font-weight: bold;' },
                        { name: 'Kit TV', style: 'background-color: #fff3cd; color: #b95000; border-color: #ffeeba; font-weight: bold;' }
                    ];
                    reservationTypeButtons.innerHTML = reservationTypes.map(type =>
                        `<button class="btn" style="${type.style}">${type.name}</button>`
                    ).join('');
                } else if (conversationState.currentQuestion === 'ask_fecha') {
                    chatBox.style.height = '200px';
                    calendarContainer.style.display = 'block';
                    calendarControls.style.display = 'block';
                } else if (conversationState.currentQuestion === 'ask_hora_inicio') {
                    timePickerContainer.style.display = 'block';
                } else if (conversationState.currentQuestion === 'ask_entidad') {
                    entitySelectorContainer.classList.remove('hidden');
                    entitySelectorContainer.classList.add('d-flex');
                    entitySelect.innerHTML = '<option selected disabled>Entidad...</option>';
                    entitySelect.innerHTML += conversationState.entities.map(e => `<option value="${e.id}" data-nombre="${e.nombre}">${e.nombre}</option>`).join('');
                } else if (conversationState.currentQuestion === 'ask_aula') {
                    aulaSelectorContainer.classList.remove('hidden');
                    aulaSelectorContainer.classList.add('d-flex');
                    aulaSelect.innerHTML = '<option selected disabled>Aula...</option>';
                    aulaSelect.innerHTML += conversationState.aulas.map(a => `<option value="${a.id}" data-nombre="${a.nombre}">${a.nombre}</option>`).join('');
                } else if (conversationState.currentQuestion === 'confirm') {
                    confirmButtons.style.display = 'flex';
                    confirmButtons.innerHTML = '<button class="btn btn-danger">Reiniciar</button><button class="btn btn-success">Confirmar</button>';
                } else if (conversationState.currentQuestion === 'ask_if_comment') {
                    commentButtons.style.display = 'flex';
                    commentButtons.innerHTML = '<button class="btn btn-secondary">No</button><button class="btn btn-primary">Sí</button>';
                }
            } else {
                setChatInputVisible(true);
            }
        }
    }

    async function handleUserInput() {
        const userMessage = userInput.value.trim();
        if (!userMessage) return;

        const currentState = questions[conversationState.currentQuestion];

        if (currentState.key === 'telefono_contacto' || currentState.key === 'cantidad_pc') {
            const onlyNumbersRegex = /^[0-9]+$/;
            if (!onlyNumbersRegex.test(userMessage)) {
                let errorMessage = 'La cantidad debe ser solo números.';
                if (currentState.key === 'telefono_contacto') {
                    errorMessage = 'Por favor, introduce un número de teléfono válido (solo números).';
                }
                addMessage(errorMessage, 'bot');
                return;
            }
        }

        addMessage(userMessage, 'user');
        userInput.value = '';

        if (currentState.key) {
            if (currentState.key === 'entidad_id') {
                const selectedEntity = conversationState.entities.find(e => e.id == userMessage || e.nombre.toLowerCase() === userMessage.toLowerCase());
                if (selectedEntity) {
                    conversationState.reservationData[currentState.key] = selectedEntity.id;
                } else {
                    addMessage('Por favor, elige una entidad válida de la lista.', 'bot');
                    return;
                }
            } else {
                conversationState.reservationData[currentState.key] = userMessage;
            }
        }

        conversationState.currentQuestion = currentState.next;

        if (conversationState.currentQuestion === 'sending') {
            askQuestion();
            await sendReservationData();
        } else {
            askQuestion();
        }
    }

    async function sendReservationData() {
        try {
            const response = await fetch('../acciones/guardar_reserva_ia.php', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(conversationState.reservationData),
            });

            const result = await response.json();

            if (result.ok) {
                addMessage('¡Tu reserva ha sido registrada con éxito!', 'bot');
                setTimeout(() => {
                    window.location.href = 'menu_invitado.php';
                }, 2000); // Redirigir después de 2 segundos
            } else {
                addMessage(`Hubo un error al guardar tu reserva: ${result.error}`, 'bot');
            }
        } catch (error) {
            addMessage('Error de conexión. No se pudo completar la solicitud.', 'bot');
        }
    }

    confirmDateBtn.addEventListener('click', () => {
        if (conversationState.reservationData['fecha']) {
            const dateParts = conversationState.reservationData['fecha'].split('-'); // YYYY-MM-DD
            const displayDate = `${dateParts[2]}-${dateParts[1]}-${dateParts[0]}`; // DD-MM-YYYY
            addMessage(`Fecha seleccionada: ${displayDate}`, 'user');
            
            chatBox.style.height = '300px';
            calendarContainer.style.display = 'none';
            calendarControls.style.display = 'none';

            conversationState.currentQuestion = questions['ask_fecha'].next;
            askQuestion();
        } else {
            addMessage('Por favor, selecciona una fecha del calendario.', 'bot');
        }
    });

    reservationTypeButtons.addEventListener('click', (e) => {
        if (e.target.tagName === 'BUTTON') {
            const selectedType = e.target.textContent;
            conversationState.reservationData['tipo_reserva'] = selectedType;
            addMessage(`Tipo de reserva seleccionado: ${selectedType}`, 'user');
            reservationTypeButtons.style.display = 'none';
            reservationTypeButtons.innerHTML = '';
            conversationState.currentQuestion = questions['welcome'].next;
            askQuestion();
        }
    });

    confirmEntityBtn.addEventListener('click', () => {
        const selectedOption = entitySelect.options[entitySelect.selectedIndex];
        if (!selectedOption || selectedOption.disabled) {
            addMessage('Por favor, selecciona una entidad de la lista.', 'bot');
            return;
        }

        const selectedEntityId = selectedOption.value;
        const selectedEntityName = selectedOption.dataset.nombre;

        conversationState.reservationData['entidad_id'] = selectedEntityId;
        addMessage(`Entidad seleccionada: ${selectedEntityName}`, 'user');

        entitySelectorContainer.classList.add('hidden');
        entitySelectorContainer.classList.remove('d-flex');
        entitySelect.innerHTML = '';

        const tipoReserva = conversationState.reservationData['tipo_reserva'];
        if (tipoReserva === 'Laboratorio Ambulante') {
            conversationState.currentQuestion = 'ask_notebooks';
        } else if (tipoReserva === 'Kit TV') {
            conversationState.currentQuestion = 'ask_carrera';
        } else { // Default to 'Aula'
            conversationState.currentQuestion = 'ask_aula';
        }
        askQuestion();
    });

    confirmAulaBtn.addEventListener('click', () => {
        const selectedOption = aulaSelect.options[aulaSelect.selectedIndex];
        if (!selectedOption || selectedOption.disabled) {
            addMessage('Por favor, selecciona un aula de la lista.', 'bot');
            return;
        }

        const selectedAulaId = selectedOption.value;
        const selectedAulaName = selectedOption.dataset.nombre;

        conversationState.reservationData['aula_id'] = selectedAulaId;
        addMessage(`Aula seleccionada: ${selectedAulaName}`, 'user');

        aulaSelectorContainer.classList.add('hidden');
        aulaSelectorContainer.classList.remove('d-flex');
        aulaSelect.innerHTML = '';

        // After selecting an aula, always proceed to the next step in the sequence.
        // The decision to ask for notebooks is now handled after selecting the entity.
        conversationState.currentQuestion = questions['ask_aula'].next; // 'ask_carrera'
        askQuestion();
    });

    confirmButtons.addEventListener('click', async (e) => {
        if (e.target.tagName === 'BUTTON') {
            confirmButtons.style.display = 'none';
            confirmButtons.innerHTML = '';

            if (e.target.textContent === 'Confirmar') {
                addMessage('Confirmar', 'user');
                conversationState.currentQuestion = questions['confirm'].next;
                askQuestion(); // Muestra "Procesando..."
                await sendReservationData();
            } else {
                addMessage('Reiniciar', 'user');
                addMessage('De acuerdo, reiniciando la solicitud...', 'bot');
                setTimeout(() => {
                    window.location.reload();
                }, 1000); // Reload after 1 second
            }
        }
    });

    commentButtons.addEventListener('click', (e) => {
        if (e.target.tagName === 'BUTTON') {
            commentButtons.style.display = 'none';
            commentButtons.innerHTML = '';

            if (e.target.textContent === 'Sí') {
                addMessage('Sí', 'user');
                conversationState.currentQuestion = 'ask_comentarios';
                askQuestion();
                userInput.focus();
            } else {
                addMessage('No', 'user');
                addMessage('Ok, no se agregaran comentarios.', 'bot');
                conversationState.reservationData['comentarios'] = '';
                conversationState.currentQuestion = 'confirm';
                askQuestion();
            }
        }
    });

    confirmTimesBtn.addEventListener('click', () => {
        const startTime = timePickerStart.selectedDates[0];
        const endTime = timePickerEnd.selectedDates[0];

        if (startTime && endTime) {
            if (endTime <= startTime) {
                addMessage('La hora de fin debe ser posterior a la hora de inicio. Por favor, corrige los horarios.', 'bot');
                return;
            }
            const startTimeStr = `${String(startTime.getHours()).padStart(2, '0')}:${String(startTime.getMinutes()).padStart(2, '0')}`;
            const endTimeStr = `${String(endTime.getHours()).padStart(2, '0')}:${String(endTime.getMinutes()).padStart(2, '0')}`;

            conversationState.reservationData['hora_inicio'] = startTimeStr;
            conversationState.reservationData['hora_fin'] = endTimeStr;

            addMessage(`Hora de inicio seleccionada: ${startTimeStr}`, 'user');
            addMessage(`Hora de fin seleccionada: ${endTimeStr}`, 'user');

            timePickerContainer.style.display = 'none';

            conversationState.currentQuestion = questions['ask_hora_fin'].next;
            askQuestion();
        } else {
            addMessage('Por favor, selecciona una hora de inicio y fin.', 'bot');
        }
    });

    sendBtn.addEventListener('click', handleUserInput);
    userInput.addEventListener('keypress', (e) => {
        if (e.key === 'Enter') {
            handleUserInput();
        }
    });

    // Start the conversation
    initCalendar();
    initTimePickers();
    Promise.all([fetchEntities(), fetchAulas()]).then(() => {
        askQuestion();
    });
});