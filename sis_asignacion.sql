-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 10.123.0.78:3306
-- Tiempo de generación: 21-08-2025 a las 17:07:32
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
  `dia` enum('Lunes','Martes','Miércoles','Jueves','Viernes','Sábado') COLLATE utf8mb4_general_ci NOT NULL,
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

INSERT INTO `asignaciones` (`Id`, `turno`, `dia`, `carrera`, `anio`, `profesor`, `materia`, `aula_id`, `hora_inicio`, `hora_fin`, `entidad_id`, `comentarios`) VALUES
(24, 'Matutino', 'Martes', 'Terapéutica Kinefisiátrica en Geriatría', '1', 'No', 'Terapéutica Kinefisiátrica en Geriatría -ateneo I-', 1, '09:00:00', '12:00:00', 1, 'COM 8'),
(27, 'Matutino', 'Miércoles', 'Enfermeria', '2', 'No', 'Enfermeria', 1, '07:30:00', '13:50:00', 4, ''),
(28, 'Matutino', 'Viernes', 'Desarrollo de las Capacidades Funcionales', '1', 'No', 'Desarrollo de las Capacidades Funcionales', 1, '09:00:00', '12:00:00', 1, 'COM 20'),
(30, 'Vespertino', 'Viernes', 'Desarrollo de las Capacidades Funcionales', '1', 'No', 'Desarrollo de las Capacidades Funcionales', 1, '13:00:00', '16:00:00', 1, 'COM 21'),
(32, 'Vespertino', 'Jueves', 'Lsa', '1', 'No', 'Lsa', 1, '15:00:00', '17:30:00', 5, ''),
(33, 'Nocturno', 'Martes', 'Software', '1B', 'No', 'No', 1, '18:00:00', '20:00:00', 3, ''),
(34, 'Nocturno', 'Martes', 'No', '1A', 'No', 'No', 1, '20:00:00', '22:00:00', 3, ''),
(35, 'Nocturno', 'Miércoles', 'Software', '1', 'No', 'No', 1, '18:00:00', '22:00:00', 3, ''),
(36, 'Nocturno', 'Jueves', 'Software', '1', 'No', 'No', 1, '18:00:00', '22:00:00', 3, ''),
(37, 'Nocturno', 'Viernes', 'Software', '1', 'Evelyn', 'No', 1, '18:00:00', '22:00:00', 3, ''),
(38, 'Matutino', 'Martes', 'No', '3', 'No', 'Salud Comunitaria III', 4, '08:00:00', '11:00:00', 1, 'COM 2'),
(39, 'Matutino', 'Jueves', 'Desarrollo de las Capacidades Funcionales', '1', 'No', 'Desarrollo de las Capacidades Funcionales', 4, '09:00:00', '12:00:00', 1, 'COM 18'),
(40, 'Vespertino', 'Miércoles', 'No', '3', 'No', 'Salud Comunitaria Iii', 4, '14:00:00', '17:00:00', 1, 'COM 1'),
(41, 'Vespertino', 'Jueves', 'No', '1', 'No', 'Salud Comunitaria Iii', 4, '14:00:00', '17:00:00', 1, 'COM 4'),
(42, 'Nocturno', 'Lunes', 'Software', '2', 'No', 'Programacion Orientada a Objetos', 4, '18:00:00', '22:00:00', 3, ''),
(43, 'Nocturno', 'Martes', 'Software', '3', 'No', 'No', 4, '18:00:00', '22:00:00', 3, ''),
(44, 'Nocturno', 'Miércoles', 'No', '1', 'No', 'Desarrollo de las Capacidades Funcionales', 2, '18:00:00', '21:00:00', 1, 'COM 19'),
(45, 'Nocturno', 'Miércoles', 'No', '1', 'No', 'Programacion Inicial', 3, '19:00:00', '22:00:00', 2, ''),
(46, 'Nocturno', 'Jueves', 'Software', '1B', 'Evelyn', 'No', 4, '18:00:00', '22:00:00', 3, ''),
(47, 'Nocturno', 'Viernes', 'Software', '3', 'Evelyn', 'No', 4, '18:00:00', '22:00:00', 3, ''),
(48, 'Matutino', 'Lunes', 'No', '1', 'No', 'Valoración Funcional I', 9, '09:00:00', '12:00:00', 1, 'COM 9'),
(49, 'Matutino', 'Martes', 'No', '3', 'No', 'No', 9, '07:30:00', '12:00:00', 4, ''),
(50, 'Vespertino', 'Lunes', 'No', '1', 'No', 'Valoración Funcional I', 9, '13:00:00', '16:00:00', 1, 'COM 10'),
(51, 'Nocturno', 'Jueves', 'Software', '3', 'No', 'No', 9, '18:00:00', '19:00:00', 3, ''),
(52, 'Nocturno', 'Miércoles', 'Software', '1A', 'No', 'No', 9, '18:00:00', '22:00:00', 3, ''),
(53, 'Nocturno', 'Martes', 'No', '1', 'No', 'Analisis Matematico I', 9, '19:00:00', '22:00:00', 2, ''),
(54, 'Nocturno', 'Lunes', 'Software', '1', 'No', 'No', 9, '18:00:00', '22:00:00', 3, ''),
(55, 'Nocturno', 'Jueves', 'No', '1', 'No', 'Algebra y Geometria Analitica I', 7, '19:00:00', '22:00:00', 2, ''),
(56, 'Nocturno', 'Jueves', 'No', '1', 'No', 'Matematica Discreta', 8, '19:00:00', '22:00:00', 2, ''),
(57, 'Nocturno', 'Viernes', 'No', '2', 'No', 'Kinefisiatría Ii', 9, '18:00:00', '21:00:00', 1, 'COM 12'),
(58, 'Vespertino', 'Lunes', 'No', '1', 'No', 'Lsa', 10, '15:00:00', '17:30:00', 5, ''),
(59, 'Vespertino', 'Miércoles', 'No', '1', 'No', 'Lsa', 10, '15:00:00', '17:30:00', 5, ''),
(60, 'Vespertino', 'Martes', 'No', '1', 'No', 'Lsa', 10, '15:00:00', '17:30:00', 5, ''),
(61, 'Vespertino', 'Jueves', 'No', '1', 'No', 'Fundamentos de la Kinesiología y Fisiatría', 10, '15:00:00', '18:00:00', 1, 'COM 18'),
(62, 'Nocturno', 'Lunes', 'Software', '2', 'No', 'No', 10, '18:00:00', '22:00:00', 3, ''),
(63, 'Nocturno', 'Martes', 'Software', '2', 'Mauro Ayala', 'Diseño Web', 10, '18:00:00', '20:00:00', 3, ''),
(64, 'Nocturno', 'Miércoles', 'Software', '2', 'Vana Mejuto', 'Taller de Matematicas', 10, '18:00:00', '19:00:00', 3, ''),
(66, 'Nocturno', 'Jueves', 'No', '1', 'Gonzalo', 'Fundamentos de la Kinesiología y Fisiatría', 10, '18:00:00', '21:00:00', 1, 'COM 19'),
(67, 'Nocturno', 'Viernes', 'Software', '2', 'No', 'No', 10, '18:00:00', '22:00:00', 3, ''),
(68, 'Matutino', 'Lunes', 'Enfermeria', '3', 'No', 'No', 11, '07:30:00', '14:30:00', 4, ''),
(69, 'Matutino', 'Jueves', 'Enfermeria', '2', 'No', 'No', 11, '08:00:00', '13:00:00', 4, ''),
(70, 'Matutino', 'Viernes', 'Enfermeria', '2', 'No', 'No', 11, '08:00:00', '13:00:00', 4, ''),
(71, 'Vespertino', 'Lunes', 'Enfermeria', '3', 'No', 'No', 11, '16:10:00', '20:10:00', 4, ''),
(72, 'Vespertino', 'Martes', 'Enfermeria', '3', 'No', 'No', 11, '16:00:00', '20:10:00', 4, ''),
(73, 'Vespertino', 'Miércoles', 'Enfermeria', '2', 'No', 'No', 11, '16:00:00', '20:20:00', 4, ''),
(74, 'Vespertino', 'Jueves', 'Enfermeria', '2', 'No', 'No', 11, '16:00:00', '18:40:00', 4, ''),
(75, 'Vespertino', 'Viernes', 'Enfermeria', '2', 'No', 'No', 11, '16:00:00', '18:00:00', 4, ''),
(76, 'Nocturno', 'Lunes', 'Enfermeria', '3', 'No', 'No', 11, '20:20:00', '22:20:00', 4, ''),
(77, 'Nocturno', 'Martes', 'Enfermeria', '3', 'No', 'No', 11, '20:20:00', '22:20:00', 4, ''),
(78, 'Nocturno', 'Miércoles', 'Enfermeria', '2', 'No', 'No', 11, '20:30:00', '22:30:00', 4, ''),
(79, 'Nocturno', 'Jueves', 'Enfermeria', '2', 'No', 'No', 11, '19:00:00', '21:00:00', 4, ''),
(80, 'Nocturno', 'Viernes', 'Enfermeria', '2', 'No', 'No', 11, '18:20:00', '21:00:00', 4, ''),
(81, 'Nocturno', 'Jueves', 'No', '1', 'No', 'Algebra y Geometria Analitica I', 9, '19:00:00', '23:00:00', 2, ''),
(93, 'Matutino', 'Lunes', 'Enfermeria', '1', 'No', 'No', 14, '08:00:00', '12:20:00', 4, ''),
(94, 'Matutino', 'Martes', 'Enfermeria', '1', 'No', 'No', 14, '07:30:00', '14:00:00', 4, ''),
(95, 'Matutino', 'Miércoles', 'Enfermeria', '1', 'No', 'No', 14, '08:00:00', '13:00:00', 4, ''),
(96, 'Matutino', 'Jueves', 'Enfermeria', '1', 'No', 'No', 14, '08:00:00', '12:00:00', 4, ''),
(97, 'Matutino', 'Viernes', 'Enfermeria', '1', 'No', 'No', 14, '08:00:00', '12:00:00', 4, ''),
(98, 'Vespertino', 'Lunes', 'Enfermeria', '1', 'No', 'No', 14, '16:00:00', '18:00:00', 4, ''),
(99, 'Vespertino', 'Martes', 'Enfermeria', '1', 'No', 'No', 14, '16:00:00', '18:00:00', 4, ''),
(100, 'Vespertino', 'Miércoles', 'Enfermeria', '1', 'No', 'No', 14, '16:00:00', '18:40:00', 4, ''),
(101, 'Vespertino', 'Jueves', 'Enfermeria', '1', 'No', 'No', 14, '16:00:00', '20:00:00', 4, ''),
(102, 'Vespertino', 'Viernes', 'Enfermeria', '1', 'No', 'No', 14, '16:00:00', '20:00:00', 4, ''),
(103, 'Nocturno', 'Lunes', 'Enfermeria', '1', 'No', 'No', 14, '18:20:00', '22:20:00', 4, ''),
(104, 'Nocturno', 'Martes', 'Enfermeria', '1', 'No', 'No', 14, '18:20:00', '22:20:00', 4, ''),
(105, 'Nocturno', 'Miércoles', 'Enfermeria', '1', 'No', 'No', 14, '19:00:00', '21:00:00', 4, ''),
(106, 'Nocturno', 'Lunes', 'No', '1', 'No', 'Programación Estructurada Básica', 6, '19:00:00', '23:00:00', 2, ''),
(107, 'Nocturno', 'Martes', 'Software', '1A', 'No', 'No', 6, '18:00:00', '20:00:00', 3, ''),
(108, 'Nocturno', 'Martes', 'Software', '1B', 'No', 'No', 6, '20:00:00', '22:00:00', 3, ''),
(110, 'Nocturno', 'Miércoles', 'Software', '3', 'Evelyn', 'No', 6, '18:00:00', '19:00:00', 3, ''),
(111, 'Nocturno', 'Miércoles', 'Software', '2', 'No', 'No', 6, '19:00:00', '22:00:00', 3, ''),
(112, 'Nocturno', 'Jueves', 'Software', '2', 'No', 'No', 6, '18:00:00', '22:00:00', 3, ''),
(113, 'Nocturno', 'Viernes', 'Software', '1B', 'No', 'No', 6, '18:00:00', '22:00:00', 3, ''),
(114, 'Matutino', 'Lunes', 'Enfermeria', '2', 'No', 'No', 5, '08:00:00', '12:00:00', 4, ''),
(115, 'Matutino', 'Martes', 'Enfermeria', '2', 'No', 'No', 5, '08:00:00', '12:00:00', 4, ''),
(116, 'Matutino', 'Miércoles', 'Enfermeria', '3', 'No', 'No', 5, '08:00:00', '12:00:00', 4, ''),
(117, 'Matutino', 'Jueves', 'Enfermeria', '3', 'No', 'No', 5, '08:00:00', '12:00:00', 4, ''),
(118, 'Matutino', 'Viernes', 'Enfermeria', '3', 'No', 'No', 5, '08:00:00', '12:00:00', 4, ''),
(119, 'Vespertino', 'Lunes', 'Enfermeria', '2', 'No', 'No', 5, '16:00:00', '20:00:00', 4, ''),
(120, 'Vespertino', 'Martes', 'Enfermeria', '2', 'No', 'No', 5, '16:00:00', '20:00:00', 4, ''),
(121, 'Vespertino', 'Miércoles', 'Enfermeria', '3', 'No', 'No', 5, '15:00:00', '19:00:00', 4, ''),
(122, 'Vespertino', 'Jueves', 'Enfermeria', '3', 'No', 'No', 5, '15:00:00', '19:00:00', 4, ''),
(123, 'Vespertino', 'Viernes', 'Enfermeria', '3', 'No', 'No', 5, '15:00:00', '19:00:00', 4, ''),
(124, 'Nocturno', 'Miércoles', 'Software', '3', 'No', 'No', 5, '19:00:00', '22:00:00', 3, ''),
(125, 'Nocturno', 'Jueves', 'Software', '3', 'Evelyn', 'No', 5, '19:00:00', '22:00:00', 3, ''),
(126, 'Nocturno', 'Martes', 'Software', '2', 'Matias Cerdeira', 'Algebra y Logica', 10, '20:00:00', '22:00:00', 3, ''),
(127, 'Nocturno', 'Miércoles', 'Software', '2', 'Inés del Castillo', 'Programación', 10, '19:00:00', '22:00:00', 3, ''),
(128, 'Matutino', 'Sábado', 'Software', '2', 'Matías Cerdeira', 'Estadística y Probabilidades', 6, '08:00:00', '10:00:00', 3, '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aulas`
--

CREATE TABLE `aulas` (
  `aula_id` int(11) NOT NULL,
  `nombre` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `recurso` enum('Proyector','TV','Ninguno') COLLATE utf8mb4_general_ci DEFAULT 'Ninguno',
  `capacidad` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci TABLESPACE `cruvei_asignaciones`;

--
-- Volcado de datos para la tabla `aulas`
--

INSERT INTO `aulas` (`aula_id`, `nombre`, `recurso`, `capacidad`) VALUES
(1, 'Auditorio', 'TV', 70),
(2, 'Aula Magna 1', 'Proyector', 35),
(3, 'Aula Magna 2', 'Proyector', 35),
(4, 'Aula Magna 1 y 2', 'Proyector', 70),
(5, 'Aula Gabinete', 'Ninguno', 0),
(6, 'Laboratorio', 'Ninguno', 0),
(7, 'Aula 1', 'Proyector', 35),
(8, 'Aula 2', 'Proyector', 35),
(9, 'Aula 1 y 2', 'Proyector', 70),
(10, 'Aula 3', 'Ninguno', 38),
(11, 'Aula 4', 'Ninguno', 38),
(12, 'Aula 5', 'TV', 35),
(13, 'Aula 6', 'TV', 35),
(14, 'Aula 5 y 6', 'TV', 70);

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
-- Indices de la tabla `aulas`
--
ALTER TABLE `aulas`
  ADD PRIMARY KEY (`aula_id`);

--
-- Indices de la tabla `entidades`
--
ALTER TABLE `entidades`
  ADD PRIMARY KEY (`entidad_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `asignaciones`
--
ALTER TABLE `asignaciones`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=160;

--
-- AUTO_INCREMENT de la tabla `aulas`
--
ALTER TABLE `aulas`
  MODIFY `aula_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `entidades`
--
ALTER TABLE `entidades`
  MODIFY `entidad_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `asignaciones`
--
ALTER TABLE `asignaciones`
  ADD CONSTRAINT `asignaciones_ibfk_aula` FOREIGN KEY (`aula_id`) REFERENCES `aulas` (`aula_id`),
  ADD CONSTRAINT `asignaciones_ibfk_entidad` FOREIGN KEY (`entidad_id`) REFERENCES `entidades` (`entidad_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
