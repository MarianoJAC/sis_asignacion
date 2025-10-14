CREATE TABLE `admin_notificaciones` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `admin_id` INT NOT NULL,
    `reserva_id` INT NOT NULL,
    `vista` BOOLEAN NOT NULL DEFAULT FALSE,
    `timestamp_creacion` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (`admin_id`, `reserva_id`),
    FOREIGN KEY (`admin_id`) REFERENCES `usuarios`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`reserva_id`) REFERENCES `reservas`(`id`) ON DELETE CASCADE
);