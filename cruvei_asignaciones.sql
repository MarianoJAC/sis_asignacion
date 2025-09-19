-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 10.123.0.78:3306
-- Tiempo de generación: 19-09-2025 a las 20:16:43
-- Versión del servidor: 8.0.16
-- Versión de PHP: 8.2.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `cruvei_asignaciones`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asignaciones`
--

CREATE TABLE `asignaciones` (
  `Id` int(11) NOT NULL,
  `turno` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `fecha` date NOT NULL,
  `carrera` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `anio` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `profesor` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `materia` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `aula_id` int(11) DEFAULT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fin` time NOT NULL,
  `entidad_id` int(11) DEFAULT NULL,
  `comentarios` text COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci TABLESPACE `cruvei_asignaciones`;

--
-- Volcado de datos para la tabla `asignaciones`
--

INSERT INTO `asignaciones` (`Id`, `turno`, `fecha`, `carrera`, `anio`, `profesor`, `materia`, `aula_id`, `hora_inicio`, `hora_fin`, `entidad_id`, `comentarios`) VALUES
(1, 'Nocturno', '2025-09-15', 'Nnn', '1', 'Nnnnn', 'Nnnnnnn', 1, '18:00:00', '20:00:00', 3, ''),
(2, 'Vespertino', '2025-09-15', 'Vvvvvvv', '1', 'Vvvvvvv', 'Vvvvvv', 1, '16:00:00', '18:00:00', 3, ''),
(3, 'Matutino', '2025-09-19', 'Mmmmmmm', '3', 'Mmmmmmmmm', 'Mmmmmm', 1, '09:00:00', '11:00:00', 2, ''),
(4, 'Nocturno', '2025-09-17', 'Software', '2', 'Ines del Castillo', 'Programacion', 10, '19:00:00', '22:00:00', 3, ''),
(5, 'Nocturno', '2025-09-24', 'Software', '2', 'Ines del Castillo', 'Programacion', 10, '19:00:00', '22:00:00', 3, ''),
(6, 'Nocturno', '2025-10-01', 'Software', '2', 'Ines del Castillo', 'Programacion', 10, '19:00:00', '22:00:00', 3, ''),
(7, 'Nocturno', '2025-10-08', 'Software', '2', 'Ines del Castillo', 'Programacion', 10, '19:00:00', '22:00:00', 3, ''),
(8, 'Nocturno', '2025-10-15', 'Software', '2', 'Ines del Castillo', 'Programacion', 10, '19:00:00', '22:00:00', 3, ''),
(9, 'Nocturno', '2025-10-22', 'Software', '2', 'Ines del Castillo', 'Programacion', 10, '19:00:00', '22:00:00', 3, ''),
(10, 'Nocturno', '2025-10-29', 'Software', '2', 'Ines del Castillo', 'Programacion', 10, '19:00:00', '22:00:00', 3, ''),
(11, 'Nocturno', '2025-11-05', 'Software', '2', 'Ines del Castillo', 'Programacion', 10, '19:00:00', '22:00:00', 3, ''),
(12, 'Nocturno', '2025-11-12', 'Software', '2', 'Ines del Castillo', 'Programacion', 10, '19:00:00', '22:00:00', 3, ''),
(13, 'Nocturno', '2025-11-19', 'Software', '2', 'Ines del Castillo', 'Programacion', 10, '19:00:00', '22:00:00', 3, ''),
(14, 'Nocturno', '2025-11-26', 'Software', '2', 'Ines del Castillo', 'Programacion', 10, '19:00:00', '22:00:00', 3, ''),
(15, 'Nocturno', '2025-12-03', 'Software', '2', 'Ines del Castillo', 'Programacion', 10, '19:00:00', '22:00:00', 3, ''),
(16, 'Nocturno', '2025-12-10', 'Software', '2', 'Ines del Castillo', 'Programacion', 10, '19:00:00', '22:00:00', 3, ''),
(17, 'Nocturno', '2025-12-17', 'Software', '2', 'Ines del Castillo', 'Programacion', 10, '19:00:00', '22:00:00', 3, ''),
(18, 'Nocturno', '2025-12-24', 'Software', '2', 'Ines del Castillo', 'Programacion', 10, '19:00:00', '22:00:00', 3, ''),
(19, 'Nocturno', '2025-12-31', 'Software', '2', 'Ines del Castillo', 'Programacion', 10, '19:00:00', '22:00:00', 3, '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auditoria_acciones`
--

CREATE TABLE `auditoria_acciones` (
  `id` int(11) NOT NULL,
  `tipo_objeto` enum('asignacion','entidad') COLLATE utf8mb4_general_ci NOT NULL,
  `objeto_id` int(11) DEFAULT NULL,
  `usuario_id` int(11) NOT NULL,
  `accion` enum('alta','baja','modificacion') COLLATE utf8mb4_general_ci NOT NULL,
  `campo_modificado` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `valor_anterior` text COLLATE utf8mb4_general_ci,
  `valor_nuevo` text COLLATE utf8mb4_general_ci,
  `fecha` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci TABLESPACE `cruvei_asignaciones`;

--
-- Volcado de datos para la tabla `auditoria_acciones`
--

INSERT INTO `auditoria_acciones` (`id`, `tipo_objeto`, `objeto_id`, `usuario_id`, `accion`, `campo_modificado`, `valor_anterior`, `valor_nuevo`, `fecha`) VALUES
(1, 'asignacion', 1, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-15\",\"turno\":\"Nocturno\",\"carrera\":\"Aaaaaaa\",\"anio\":\"1\",\"profesor\":\"Aaaaaaaaa\",\"materia\":\"Aaaaaaaaaa\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-09-19 17:46:49'),
(2, 'asignacion', 2, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-15\",\"turno\":\"Vespertino\",\"carrera\":\"Vvvvvvv\",\"anio\":\"1\",\"profesor\":\"Vvvvvvv\",\"materia\":\"Vvvvvv\",\"entidad_id\":3,\"hora_inicio\":\"16:00\",\"hora_fin\":\"18:00\",\"comentarios\":\"\"}', '2025-09-19 17:49:06'),
(3, 'asignacion', 3, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-19\",\"turno\":\"Matutino\",\"carrera\":\"Mmmmmmm\",\"anio\":\"3\",\"profesor\":\"Mmmmmmmmm\",\"materia\":\"Mmmmmm\",\"entidad_id\":2,\"hora_inicio\":\"09:00\",\"hora_fin\":\"11:00\",\"comentarios\":\"\"}', '2025-09-19 17:49:37'),
(4, 'asignacion', 1, 5, 'modificacion', 'carrera', 'Aaaaaaa', 'Nnn', '2025-09-19 17:50:11'),
(5, 'asignacion', 1, 5, 'modificacion', 'profesor', 'Aaaaaaaaa', 'Nnnnn', '2025-09-19 17:50:11'),
(6, 'asignacion', 1, 5, 'modificacion', 'materia', 'Aaaaaaaaaa', 'Nnnnnnn', '2025-09-19 17:50:11'),
(7, 'asignacion', 4, 5, 'alta', NULL, NULL, '{\"aula_id\":10,\"fecha\":\"2025-09-17\",\"turno\":\"Nocturno\",\"carrera\":\"Software\",\"anio\":\"2\",\"profesor\":\"Ines del Castillo\",\"materia\":\"Programacion\",\"entidad_id\":3,\"hora_inicio\":\"19:00\",\"hora_fin\":\"22:00\",\"comentarios\":\"\"}', '2025-09-19 18:18:52'),
(8, 'asignacion', 5, 5, 'alta', NULL, NULL, '{\"aula_id\":10,\"fecha\":\"2025-09-24\",\"turno\":\"Nocturno\",\"carrera\":\"Software\",\"anio\":\"2\",\"profesor\":\"Ines del Castillo\",\"materia\":\"Programacion\",\"entidad_id\":3,\"hora_inicio\":\"19:00\",\"hora_fin\":\"22:00\",\"comentarios\":\"\"}', '2025-09-19 18:18:53'),
(9, 'asignacion', 6, 5, 'alta', NULL, NULL, '{\"aula_id\":10,\"fecha\":\"2025-10-01\",\"turno\":\"Nocturno\",\"carrera\":\"Software\",\"anio\":\"2\",\"profesor\":\"Ines del Castillo\",\"materia\":\"Programacion\",\"entidad_id\":3,\"hora_inicio\":\"19:00\",\"hora_fin\":\"22:00\",\"comentarios\":\"\"}', '2025-09-19 18:18:54'),
(10, 'asignacion', 7, 5, 'alta', NULL, NULL, '{\"aula_id\":10,\"fecha\":\"2025-10-08\",\"turno\":\"Nocturno\",\"carrera\":\"Software\",\"anio\":\"2\",\"profesor\":\"Ines del Castillo\",\"materia\":\"Programacion\",\"entidad_id\":3,\"hora_inicio\":\"19:00\",\"hora_fin\":\"22:00\",\"comentarios\":\"\"}', '2025-09-19 18:18:55'),
(11, 'asignacion', 8, 5, 'alta', NULL, NULL, '{\"aula_id\":10,\"fecha\":\"2025-10-15\",\"turno\":\"Nocturno\",\"carrera\":\"Software\",\"anio\":\"2\",\"profesor\":\"Ines del Castillo\",\"materia\":\"Programacion\",\"entidad_id\":3,\"hora_inicio\":\"19:00\",\"hora_fin\":\"22:00\",\"comentarios\":\"\"}', '2025-09-19 18:18:55'),
(12, 'asignacion', 9, 5, 'alta', NULL, NULL, '{\"aula_id\":10,\"fecha\":\"2025-10-22\",\"turno\":\"Nocturno\",\"carrera\":\"Software\",\"anio\":\"2\",\"profesor\":\"Ines del Castillo\",\"materia\":\"Programacion\",\"entidad_id\":3,\"hora_inicio\":\"19:00\",\"hora_fin\":\"22:00\",\"comentarios\":\"\"}', '2025-09-19 18:18:56'),
(13, 'asignacion', 10, 5, 'alta', NULL, NULL, '{\"aula_id\":10,\"fecha\":\"2025-10-29\",\"turno\":\"Nocturno\",\"carrera\":\"Software\",\"anio\":\"2\",\"profesor\":\"Ines del Castillo\",\"materia\":\"Programacion\",\"entidad_id\":3,\"hora_inicio\":\"19:00\",\"hora_fin\":\"22:00\",\"comentarios\":\"\"}', '2025-09-19 18:18:57'),
(14, 'asignacion', 11, 5, 'alta', NULL, NULL, '{\"aula_id\":10,\"fecha\":\"2025-11-05\",\"turno\":\"Nocturno\",\"carrera\":\"Software\",\"anio\":\"2\",\"profesor\":\"Ines del Castillo\",\"materia\":\"Programacion\",\"entidad_id\":3,\"hora_inicio\":\"19:00\",\"hora_fin\":\"22:00\",\"comentarios\":\"\"}', '2025-09-19 18:18:58'),
(15, 'asignacion', 12, 5, 'alta', NULL, NULL, '{\"aula_id\":10,\"fecha\":\"2025-11-12\",\"turno\":\"Nocturno\",\"carrera\":\"Software\",\"anio\":\"2\",\"profesor\":\"Ines del Castillo\",\"materia\":\"Programacion\",\"entidad_id\":3,\"hora_inicio\":\"19:00\",\"hora_fin\":\"22:00\",\"comentarios\":\"\"}', '2025-09-19 18:18:59'),
(16, 'asignacion', 13, 5, 'alta', NULL, NULL, '{\"aula_id\":10,\"fecha\":\"2025-11-19\",\"turno\":\"Nocturno\",\"carrera\":\"Software\",\"anio\":\"2\",\"profesor\":\"Ines del Castillo\",\"materia\":\"Programacion\",\"entidad_id\":3,\"hora_inicio\":\"19:00\",\"hora_fin\":\"22:00\",\"comentarios\":\"\"}', '2025-09-19 18:19:00'),
(17, 'asignacion', 14, 5, 'alta', NULL, NULL, '{\"aula_id\":10,\"fecha\":\"2025-11-26\",\"turno\":\"Nocturno\",\"carrera\":\"Software\",\"anio\":\"2\",\"profesor\":\"Ines del Castillo\",\"materia\":\"Programacion\",\"entidad_id\":3,\"hora_inicio\":\"19:00\",\"hora_fin\":\"22:00\",\"comentarios\":\"\"}', '2025-09-19 18:19:00'),
(18, 'asignacion', 15, 5, 'alta', NULL, NULL, '{\"aula_id\":10,\"fecha\":\"2025-12-03\",\"turno\":\"Nocturno\",\"carrera\":\"Software\",\"anio\":\"2\",\"profesor\":\"Ines del Castillo\",\"materia\":\"Programacion\",\"entidad_id\":3,\"hora_inicio\":\"19:00\",\"hora_fin\":\"22:00\",\"comentarios\":\"\"}', '2025-09-19 18:19:01'),
(19, 'asignacion', 16, 5, 'alta', NULL, NULL, '{\"aula_id\":10,\"fecha\":\"2025-12-10\",\"turno\":\"Nocturno\",\"carrera\":\"Software\",\"anio\":\"2\",\"profesor\":\"Ines del Castillo\",\"materia\":\"Programacion\",\"entidad_id\":3,\"hora_inicio\":\"19:00\",\"hora_fin\":\"22:00\",\"comentarios\":\"\"}', '2025-09-19 18:19:02'),
(20, 'asignacion', 17, 5, 'alta', NULL, NULL, '{\"aula_id\":10,\"fecha\":\"2025-12-17\",\"turno\":\"Nocturno\",\"carrera\":\"Software\",\"anio\":\"2\",\"profesor\":\"Ines del Castillo\",\"materia\":\"Programacion\",\"entidad_id\":3,\"hora_inicio\":\"19:00\",\"hora_fin\":\"22:00\",\"comentarios\":\"\"}', '2025-09-19 18:19:03'),
(21, 'asignacion', 18, 5, 'alta', NULL, NULL, '{\"aula_id\":10,\"fecha\":\"2025-12-24\",\"turno\":\"Nocturno\",\"carrera\":\"Software\",\"anio\":\"2\",\"profesor\":\"Ines del Castillo\",\"materia\":\"Programacion\",\"entidad_id\":3,\"hora_inicio\":\"19:00\",\"hora_fin\":\"22:00\",\"comentarios\":\"\"}', '2025-09-19 18:19:04'),
(22, 'asignacion', 19, 5, 'alta', NULL, NULL, '{\"aula_id\":10,\"fecha\":\"2025-12-31\",\"turno\":\"Nocturno\",\"carrera\":\"Software\",\"anio\":\"2\",\"profesor\":\"Ines del Castillo\",\"materia\":\"Programacion\",\"entidad_id\":3,\"hora_inicio\":\"19:00\",\"hora_fin\":\"22:00\",\"comentarios\":\"\"}', '2025-09-19 18:19:04');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aulas`
--

CREATE TABLE `aulas` (
  `aula_id` int(11) NOT NULL,
  `nombre` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `capacidad` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci TABLESPACE `cruvei_asignaciones`;

--
-- Volcado de datos para la tabla `aulas`
--

INSERT INTO `aulas` (`aula_id`, `nombre`, `capacidad`) VALUES
(1, 'Auditorio', 70),
(2, 'Aula Magna 1', 35),
(3, 'Aula Magna 2', 35),
(4, 'Aula Magna 1 y 2', 70),
(5, 'Aula Gabinete', 0),
(6, 'Laboratorio', 0),
(7, 'Aula 1', 35),
(8, 'Aula 2', 35),
(9, 'Aula 1 y 2', 70),
(10, 'Aula 3', 38),
(11, 'Aula 4', 38),
(12, 'Aula 5', 35),
(13, 'Aula 6', 35),
(14, 'Aula 5 y 6', 70);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entidades`
--

CREATE TABLE `entidades` (
  `entidad_id` int(11) NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `color` varchar(7) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci TABLESPACE `cruvei_asignaciones`;

--
-- Volcado de datos para la tabla `entidades`
--

INSERT INTO `entidades` (`entidad_id`, `nombre`, `color`) VALUES
(1, 'UNAHUR', '#ffd54f'),
(2, 'UNLAM', '#81c784'),
(3, 'Marechal', '#64b5f6'),
(4, 'Enfermeria', '#f06292'),
(5, 'Ofertas independientes', '#ba68c8'),
(6, 'Curso ingreso UNLAM', '#a1887f');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recursos_por_aula`
--

CREATE TABLE `recursos_por_aula` (
  `id` int(11) NOT NULL,
  `aula_id` int(11) NOT NULL,
  `recurso` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci TABLESPACE `cruvei_asignaciones`;

--
-- Volcado de datos para la tabla `recursos_por_aula`
--

INSERT INTO `recursos_por_aula` (`id`, `aula_id`, `recurso`) VALUES
(1, 1, 'TV'),
(2, 2, 'Proyector'),
(3, 3, 'Proyector'),
(4, 4, 'Proyector'),
(5, 7, 'Proyector'),
(6, 8, 'Proyector'),
(7, 9, 'Proyector'),
(8, 12, 'TV'),
(9, 13, 'TV'),
(10, 14, 'TV');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservas`
--

CREATE TABLE `reservas` (
  `id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `entidad_id` int(11) NOT NULL,
  `carrera` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `anio` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `materia` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `profesor` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fin` time NOT NULL,
  `telefono_contacto` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `comentarios` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `timestamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `role` enum('admin','viewer','invitado') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `reset_token` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `reset_expires` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci TABLESPACE `cruvei_asignaciones`;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `username`, `password`, `role`, `reset_token`, `reset_expires`) VALUES
(5, 'admin', '$2y$10$lerCMSRSXIXvgcniOyebxuUQH6rBvABtNnOZ8kyTq6e.lWXwOrXwW', 'admin', NULL, NULL),
(6, 'usuario', '$2y$10$MiR5h464mw/n1n0GJN5HquDp577KqZRslCNkAIJKyQLBZv3Doh1HK', 'viewer', NULL, NULL),
(7, 'invitado', '$2y$10$ifz.f6f6Yc5i/R53A33y0uHqGkbp4LbvcHnBw2vjVdJdGg/j2dGf.', 'invitado', NULL, NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `asignaciones`
--
ALTER TABLE `asignaciones`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `aula_id` (`aula_id`),
  ADD KEY `entidad_id` (`entidad_id`);

--
-- Indices de la tabla `auditoria_acciones`
--
ALTER TABLE `auditoria_acciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_usuario` (`usuario_id`);

--
-- Indices de la tabla `aulas`
--
ALTER TABLE `aulas`
  ADD PRIMARY KEY (`aula_id`);

--
-- Indices de la tabla `entidades`
--
ALTER TABLE `entidades`
  ADD PRIMARY KEY (`entidad_id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `recursos_por_aula`
--
ALTER TABLE `recursos_por_aula`
  ADD PRIMARY KEY (`id`),
  ADD KEY `aula_id` (`aula_id`);

--
-- Indices de la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `entidad_id` (`entidad_id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `asignaciones`
--
ALTER TABLE `asignaciones`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `auditoria_acciones`
--
ALTER TABLE `auditoria_acciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `aulas`
--
ALTER TABLE `aulas`
  MODIFY `aula_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `entidades`
--
ALTER TABLE `entidades`
  MODIFY `entidad_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100;

--
-- AUTO_INCREMENT de la tabla `recursos_por_aula`
--
ALTER TABLE `recursos_por_aula`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `reservas`
--
ALTER TABLE `reservas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `asignaciones`
--
ALTER TABLE `asignaciones`
  ADD CONSTRAINT `asignaciones_ibfk_aula` FOREIGN KEY (`aula_id`) REFERENCES `aulas` (`aula_id`),
  ADD CONSTRAINT `asignaciones_ibfk_entidad` FOREIGN KEY (`entidad_id`) REFERENCES `entidades` (`entidad_id`);

--
-- Filtros para la tabla `auditoria_acciones`
--
ALTER TABLE `auditoria_acciones`
  ADD CONSTRAINT `fk_auditoria_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `recursos_por_aula`
--
ALTER TABLE `recursos_por_aula`
  ADD CONSTRAINT `recursos_por_aula_ibfk_1` FOREIGN KEY (`aula_id`) REFERENCES `aulas` (`aula_id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD CONSTRAINT `reservas_ibfk_entidad` FOREIGN KEY (`entidad_id`) REFERENCES `entidades` (`entidad_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
