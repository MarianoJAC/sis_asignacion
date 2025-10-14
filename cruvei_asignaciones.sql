-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 10.123.0.78:3306
-- Tiempo de generación: 14-10-2025 a las 18:46:15
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
(64, 'Nocturno', '2025-09-26', 'Desarrollo de Software', '2', 'Patricio Freres', 'Practicas Prof. Ii', 10, '19:00:00', '22:00:00', 3, ''),
(65, 'Nocturno', '2025-09-26', 'Desarrollo de Software', '1', 'Profe', 'Programación C', 9, '20:00:00', '22:00:00', 3, ''),
(66, 'Nocturno', '2025-09-26', 'Enfermeria', '1', 'Profe', 'Rcp', 5, '18:00:00', '22:00:00', 4, ''),
(67, 'Nocturno', '2025-09-26', 'Sdfsdf', '2', 'Pepito', 'Blabla', 1, '19:00:00', '21:00:00', 5, ''),
(68, 'Nocturno', '2025-09-26', 'Asdas', '1', 'Dfgsg', 'Dsfsdf', 6, '20:00:00', '22:00:00', 2, ''),
(69, 'Nocturno', '2025-09-26', 'Dfsdf', '2', 'Wwe', 'Sfgsg', 4, '18:00:00', '20:00:00', 6, ''),
(70, 'Vespertino', '2025-10-22', 'Tecnicatura Superior en Desarrollo de Software', '1', 'Nkjsfnkj', 'Base de Datos', 1, '13:00:00', '17:00:00', 3, ''),
(71, 'Matutino', '2025-10-03', 'Practicas Iii', '2', 'Sada', 'Asda', 1, '10:00:00', '12:00:00', 3, 'asas'),
(72, 'Nocturno', '2025-10-03', 'Sdfsd', '1B', 'Sdfs', 'Dsfsd', 8, '20:02:00', '22:00:00', 4, ''),
(73, 'Vespertino', '2025-10-06', 'Desarrollo de Software', '2', 'Carla Colna', 'Programacion Orientada a Objetos', 1, '16:00:00', '18:00:00', 3, ''),
(74, 'Vespertino', '2025-10-13', 'Desarrollo de Software', '2', 'Carla Colna', 'Programacion Orientada a Objetos', 1, '16:00:00', '18:00:00', 3, ''),
(75, 'Vespertino', '2025-10-20', 'Desarrollo de Software', '2', 'Carla Colna', 'Programacion Orientada a Objetos', 1, '16:00:00', '18:00:00', 3, ''),
(76, 'Vespertino', '2025-10-27', 'Desarrollo de Software', '2', 'Carla Colna', 'Programacion Orientada a Objetos', 1, '16:00:00', '18:00:00', 3, ''),
(77, 'Vespertino', '2025-10-07', 'Enfermeria', '2', 'a Designar', 'a Designar', 1, '16:00:00', '17:00:00', 4, ''),
(78, 'Vespertino', '2025-10-14', 'Enfermeria', '2', 'a Designar', 'a Designar', 1, '16:00:00', '17:00:00', 4, ''),
(79, 'Vespertino', '2025-10-21', 'Enfermeria', '2', 'a Designar', 'a Designar', 1, '16:00:00', '17:00:00', 4, ''),
(80, 'Vespertino', '2025-10-28', 'Enfermeria', '2', 'a Designar', 'a Designar', 1, '16:00:00', '17:00:00', 4, ''),
(81, 'Vespertino', '2025-10-08', 'Desarrollo de Software', '3', 'a Designar', 'Algoritmos y Estructuras de Datos', 1, '17:00:00', '18:00:00', 3, ''),
(82, 'Vespertino', '2025-10-15', 'Desarrollo de Software', '3', 'a Designar', 'Algoritmos y Estructuras de Datos', 1, '17:00:00', '18:00:00', 3, ''),
(83, 'Vespertino', '2025-10-22', 'Desarrollo de Software', '3', 'a Designar', 'Algoritmos y Estructuras de Datos', 1, '17:00:00', '18:00:00', 3, ''),
(84, 'Vespertino', '2025-10-29', 'Desarrollo de Software', '3', 'a Designar', 'Algoritmos y Estructuras de Datos', 1, '17:00:00', '18:00:00', 3, ''),
(85, 'Vespertino', '2025-10-09', 'Desarrollo de Software', '2', 'Ines del Castillo', 'Python', 2, '15:00:00', '17:00:00', 3, ''),
(86, 'Vespertino', '2025-10-16', 'Desarrollo de Software', '2', 'Ines del Castillo', 'Python', 2, '15:00:00', '17:00:00', 3, ''),
(87, 'Vespertino', '2025-10-23', 'Desarrollo de Software', '2', 'Ines del Castillo', 'Python', 2, '15:00:00', '17:00:00', 3, ''),
(88, 'Vespertino', '2025-10-30', 'Desarrollo de Software', '2', 'Ines del Castillo', 'Python', 2, '15:00:00', '17:00:00', 3, ''),
(89, 'Vespertino', '2025-10-10', 'a Designar', '1', 'a Designar', 'a Designar', 3, '15:00:00', '18:00:00', 5, ''),
(90, 'Vespertino', '2025-10-17', 'a Designar', '1', 'a Designar', 'a Designar', 3, '15:00:00', '18:00:00', 5, ''),
(91, 'Vespertino', '2025-10-24', 'a Designar', '1', 'a Designar', 'a Designar', 3, '15:00:00', '18:00:00', 5, ''),
(92, 'Vespertino', '2025-10-31', 'a Designar', '1', 'a Designar', 'a Designar', 3, '15:00:00', '18:00:00', 5, ''),
(93, 'Nocturno', '2025-10-08', 'Desarrollo de Software', '2', 'Ines del Castillo', 'Python', 10, '19:00:00', '22:00:00', 3, ''),
(94, 'Nocturno', '2025-10-15', 'Desarrollo de Software', '2', 'Ines del Castillo', 'Python', 10, '19:00:00', '22:00:00', 3, ''),
(95, 'Nocturno', '2025-10-22', 'Desarrollo de Software', '2', 'Ines del Castillo', 'Python', 10, '19:00:00', '22:00:00', 3, ''),
(96, 'Nocturno', '2025-10-29', 'Desarrollo de Software', '2', 'Ines del Castillo', 'Python', 10, '19:00:00', '22:00:00', 3, ''),
(97, 'Nocturno', '2025-10-06', 'Desarrollo de Software', '2', 'Carla Colina', 'Programacion Orientada a Objetos', 4, '18:00:00', '22:00:00', 3, ''),
(98, 'Nocturno', '2025-10-13', 'Desarrollo de Software', '2', 'Carla Colina', 'Programacion Orientada a Objetos', 4, '18:00:00', '22:00:00', 3, ''),
(99, 'Nocturno', '2025-10-20', 'Desarrollo de Software', '2', 'Carla Colina', 'Programacion Orientada a Objetos', 4, '18:00:00', '22:00:00', 3, ''),
(100, 'Nocturno', '2025-10-27', 'Desarrollo de Software', '2', 'Carla Colina', 'Programacion Orientada a Objetos', 4, '18:00:00', '22:00:00', 3, ''),
(101, 'Nocturno', '2025-10-07', 'Desarrollo de Software', '2', 'Mauro Ayala', 'Diseño Web', 10, '18:00:00', '20:00:00', 3, ''),
(102, 'Nocturno', '2025-10-14', 'Desarrollo de Software', '2', 'Mauro Ayala', 'Diseño Web', 10, '18:00:00', '20:00:00', 3, ''),
(103, 'Nocturno', '2025-10-21', 'Desarrollo de Software', '2', 'Mauro Ayala', 'Diseño Web', 10, '18:00:00', '20:00:00', 3, ''),
(104, 'Nocturno', '2025-10-28', 'Desarrollo de Software', '2', 'Mauro Ayala', 'Diseño Web', 10, '18:00:00', '20:00:00', 3, ''),
(105, 'Nocturno', '2025-10-07', 'Desarrollo de Software', '2', 'Matias Cerdeira', 'Algebra y Logica', 10, '20:00:00', '22:00:00', 3, ''),
(106, 'Nocturno', '2025-10-14', 'Desarrollo de Software', '2', 'Matias Cerdeira', 'Algebra y Logica', 10, '20:00:00', '22:00:00', 3, ''),
(107, 'Nocturno', '2025-10-21', 'Desarrollo de Software', '2', 'Matias Cerdeira', 'Algebra y Logica', 10, '20:00:00', '22:00:00', 3, ''),
(108, 'Nocturno', '2025-10-28', 'Desarrollo de Software', '2', 'Matias Cerdeira', 'Algebra y Logica', 10, '20:00:00', '22:00:00', 3, ''),
(113, 'Nocturno', '2025-10-09', 'Desarrollo de Software', '2', 'Elena Gonzalez', 'Ingles', 6, '18:00:00', '20:00:00', 3, ''),
(114, 'Nocturno', '2025-10-16', 'Desarrollo de Software', '2', 'Elena Gonzalez', 'Ingles', 6, '18:00:00', '20:00:00', 3, ''),
(115, 'Nocturno', '2025-10-23', 'Desarrollo de Software', '2', 'Elena Gonzalez', 'Ingles', 6, '18:00:00', '20:00:00', 3, ''),
(116, 'Nocturno', '2025-10-30', 'Desarrollo de Software', '2', 'Elena Gonzalez', 'Ingles', 6, '18:00:00', '20:00:00', 3, ''),
(117, 'Nocturno', '2025-10-09', 'Desarrollo de Software', '2', 'Joaquin Delgado', 'Desarrollo de Aplicaciones Moviles', 6, '20:00:00', '22:00:00', 3, ''),
(118, 'Nocturno', '2025-10-16', 'Desarrollo de Software', '2', 'Joaquin Delgado', 'Desarrollo de Aplicaciones Moviles', 6, '20:00:00', '22:00:00', 3, ''),
(119, 'Nocturno', '2025-10-23', 'Desarrollo de Software', '2', 'Joaquin Delgado', 'Desarrollo de Aplicaciones Moviles', 6, '20:00:00', '22:00:00', 3, ''),
(120, 'Nocturno', '2025-10-30', 'Desarrollo de Software', '2', 'Joaquin Delgado', 'Desarrollo de Aplicaciones Moviles', 6, '20:00:00', '22:00:00', 3, ''),
(121, 'Nocturno', '2025-10-10', 'Desarrollo de Software', '2', 'Joaquin Delgado', 'Desarrollo de Aplicativos Moviles', 10, '18:00:00', '19:00:00', 3, ''),
(122, 'Nocturno', '2025-10-17', 'Desarrollo de Software', '2', 'Joaquin Delgado', 'Desarrollo de Aplicativos Moviles', 10, '18:00:00', '19:00:00', 3, ''),
(123, 'Nocturno', '2025-10-24', 'Desarrollo de Software', '2', 'Joaquin Delgado', 'Desarrollo de Aplicativos Moviles', 10, '18:00:00', '19:00:00', 3, ''),
(124, 'Nocturno', '2025-10-31', 'Desarrollo de Software', '2', 'Joaquin Delgado', 'Desarrollo de Aplicativos Moviles', 10, '18:00:00', '19:00:00', 3, ''),
(125, 'Nocturno', '2025-10-10', 'Desarrollo de Software', '2', 'Patricio Feres', 'Practicas Profesionalizantes', 10, '19:00:00', '22:00:00', 3, ''),
(126, 'Matutino', '2025-10-11', 'Desarrollo de Software', '2', 'Matias Cerdeira', 'Probabilidad y Estadisticas', 6, '08:00:00', '10:00:00', 3, ''),
(127, 'Matutino', '2025-10-18', 'Desarrollo de Software', '2', 'Matias Cerdeira', 'Probabilidad y Estadisticas', 6, '08:00:00', '10:00:00', 3, ''),
(128, 'Matutino', '2025-10-25', 'Desarrollo de Software', '2', 'Matias Cerdeira', 'Probabilidad y Estadisticas', 6, '08:00:00', '10:00:00', 3, ''),
(133, 'Nocturno', '2025-10-14', 'Fiesta Marechal', '2', 'Emiliano', 'Fiesta Marechal', 4, '18:00:00', '21:00:00', 3, ''),
(134, 'Nocturno', '2025-10-13', 'Sada', '1B', 'Asfa', 'Asasfd', 1, '19:00:00', '20:08:00', 4, '');

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
(22, 'asignacion', 19, 5, 'alta', NULL, NULL, '{\"aula_id\":10,\"fecha\":\"2025-12-31\",\"turno\":\"Nocturno\",\"carrera\":\"Software\",\"anio\":\"2\",\"profesor\":\"Ines del Castillo\",\"materia\":\"Programacion\",\"entidad_id\":3,\"hora_inicio\":\"19:00\",\"hora_fin\":\"22:00\",\"comentarios\":\"\"}', '2025-09-19 18:19:04'),
(23, 'asignacion', 3, 5, 'modificacion', 'carrera', 'Mmmmmmm', 'Asdasda Asdasd Asdasd Asda', '2025-09-19 21:04:17'),
(24, 'asignacion', 3, 5, 'modificacion', 'materia', 'Mmmmmm', 'Mmmmmm Sdfsdfs Sdf Sdfsdfsd', '2025-09-19 21:04:47'),
(25, 'asignacion', 2, 5, 'baja', NULL, '{\"Id\":2,\"turno\":\"Vespertino\",\"fecha\":\"2025-09-15\",\"carrera\":\"Vvvvvvv\",\"anio\":\"1\",\"profesor\":\"Vvvvvvv\",\"materia\":\"Vvvvvv\",\"aula_id\":1,\"hora_inicio\":\"16:00:00\",\"hora_fin\":\"18:00:00\",\"entidad_id\":3,\"comentarios\":\"\"}', NULL, '2025-09-19 21:05:50'),
(26, 'asignacion', 3, 5, 'modificacion', 'fecha', '2025-09-19', '2025-09-18', '2025-09-19 21:06:09'),
(27, 'asignacion', 3, 5, 'modificacion', 'entidad_id', '2', '4', '2025-09-19 21:06:09'),
(28, 'asignacion', 3, 5, 'baja', NULL, '{\"Id\":3,\"turno\":\"Matutino\",\"fecha\":\"2025-09-18\",\"carrera\":\"Asdasda Asdasd Asdasd Asda\",\"anio\":\"3\",\"profesor\":\"Mmmmmmmmm\",\"materia\":\"Mmmmmm Sdfsdfs Sdf Sdfsdfsd\",\"aula_id\":1,\"hora_inicio\":\"09:00:00\",\"hora_fin\":\"11:00:00\",\"entidad_id\":4,\"comentarios\":\"\"}', NULL, '2025-09-19 21:06:21'),
(29, 'entidad', 100, 5, 'alta', NULL, NULL, '{\"nombre\":\"Prácticas Profesionalizantes\",\"color\":\"#f52500\"}', '2025-09-19 22:46:01'),
(30, 'entidad', 100, 5, 'baja', NULL, '{\"nombre\":\"Prácticas Profesionalizantes\",\"color\":\"#f52500\"}', NULL, '2025-09-19 22:51:39'),
(31, 'asignacion', 20, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-16\",\"turno\":\"Matutino\",\"carrera\":\"Sdgfsdg\",\"anio\":\"1A\",\"profesor\":\"Sdgs\",\"materia\":\"Sdgsd\",\"entidad_id\":6,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"sfsdf\"}', '2025-09-19 22:58:32'),
(32, 'asignacion', 20, 5, 'modificacion', 'fecha', '2025-09-16', '2025-09-19', '2025-09-19 22:58:48'),
(33, 'asignacion', 20, 5, 'baja', NULL, '{\"Id\":20,\"turno\":\"Matutino\",\"fecha\":\"2025-09-19\",\"carrera\":\"Sdgfsdg\",\"anio\":\"1A\",\"profesor\":\"Sdgs\",\"materia\":\"Sdgsd\",\"aula_id\":1,\"hora_inicio\":\"10:00:00\",\"hora_fin\":\"12:00:00\",\"entidad_id\":6,\"comentarios\":\"sfsdf\"}', NULL, '2025-09-19 23:02:08'),
(34, 'asignacion', 21, 5, 'alta', NULL, NULL, '{\"aula_id\":2,\"fecha\":\"2025-09-17\",\"turno\":\"Matutino\",\"carrera\":\"Asdasd\",\"anio\":\"1A\",\"profesor\":\"Asfasf\",\"materia\":\"Safasf\",\"entidad_id\":6,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"safsfasf\"}', '2025-09-19 23:05:41'),
(35, 'asignacion', 22, 5, 'alta', NULL, NULL, '{\"aula_id\":2,\"fecha\":\"2025-09-24\",\"turno\":\"Matutino\",\"carrera\":\"Asdasd\",\"anio\":\"1A\",\"profesor\":\"Asfasf\",\"materia\":\"Safasf\",\"entidad_id\":6,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"safsfasf\"}', '2025-09-19 23:05:42'),
(36, 'asignacion', 21, 5, 'baja', NULL, '{\"Id\":21,\"turno\":\"Matutino\",\"fecha\":\"2025-09-17\",\"carrera\":\"Asdasd\",\"anio\":\"1A\",\"profesor\":\"Asfasf\",\"materia\":\"Safasf\",\"aula_id\":2,\"hora_inicio\":\"10:00:00\",\"hora_fin\":\"12:00:00\",\"entidad_id\":6,\"comentarios\":\"safsfasf\"}', NULL, '2025-09-19 23:05:51'),
(37, 'asignacion', 23, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-15\",\"turno\":\"Matutino\",\"carrera\":\"Fwef\",\"anio\":\"1B\",\"profesor\":\"Wqrwer\",\"materia\":\"Wefwe\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"13:00\",\"comentarios\":\"fwew\"}', '2025-09-19 23:06:55'),
(38, 'asignacion', 24, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-15\",\"turno\":\"Matutino\",\"carrera\":\"Wefewrt\",\"anio\":\"1A\",\"profesor\":\"Wetw\",\"materia\":\"Wewt\",\"entidad_id\":4,\"hora_inicio\":\"08:00\",\"hora_fin\":\"09:00\",\"comentarios\":\"erfe\"}', '2025-09-19 23:07:21'),
(39, 'asignacion', 25, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-22\",\"turno\":\"Matutino\",\"carrera\":\"Wefewrt\",\"anio\":\"1A\",\"profesor\":\"Wetw\",\"materia\":\"Wewt\",\"entidad_id\":4,\"hora_inicio\":\"08:00\",\"hora_fin\":\"09:00\",\"comentarios\":\"erfe\"}', '2025-09-19 23:07:22'),
(40, 'asignacion', 26, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-29\",\"turno\":\"Matutino\",\"carrera\":\"Wefewrt\",\"anio\":\"1A\",\"profesor\":\"Wetw\",\"materia\":\"Wewt\",\"entidad_id\":4,\"hora_inicio\":\"08:00\",\"hora_fin\":\"09:00\",\"comentarios\":\"erfe\"}', '2025-09-19 23:07:22'),
(41, 'asignacion', 23, 5, '', NULL, '{\"repeticion\":\"mes\",\"plantilla\":{\"Id\":23,\"turno\":\"Matutino\",\"fecha\":\"2025-09-15\",\"carrera\":\"Fwef\",\"anio\":\"1B\",\"profesor\":\"Wqrwer\",\"materia\":\"Wefwe\",\"aula_id\":1,\"hora_inicio\":\"12:00:00\",\"hora_fin\":\"13:00:00\",\"entidad_id\":6,\"comentarios\":\"fwew\"},\"eliminadas\":1}', NULL, '2025-09-19 23:07:52'),
(42, 'asignacion', 24, 5, '', NULL, '{\"repeticion\":\"mes\",\"plantilla\":{\"Id\":24,\"turno\":\"Matutino\",\"fecha\":\"2025-09-15\",\"carrera\":\"Wefewrt\",\"anio\":\"1A\",\"profesor\":\"Wetw\",\"materia\":\"Wewt\",\"aula_id\":1,\"hora_inicio\":\"08:00:00\",\"hora_fin\":\"09:00:00\",\"entidad_id\":4,\"comentarios\":\"erfe\"},\"eliminadas\":3}', NULL, '2025-09-19 23:08:00'),
(43, 'asignacion', 27, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-16\",\"turno\":\"Vespertino\",\"carrera\":\"Werwe\",\"anio\":\"1A\",\"profesor\":\"Wewe\",\"materia\":\"Ewwew\",\"entidad_id\":4,\"hora_inicio\":\"13:00\",\"hora_fin\":\"18:00\",\"comentarios\":\"sdfsf\"}', '2025-09-19 23:23:20'),
(44, 'asignacion', 28, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-23\",\"turno\":\"Vespertino\",\"carrera\":\"Werwe\",\"anio\":\"1A\",\"profesor\":\"Wewe\",\"materia\":\"Ewwew\",\"entidad_id\":4,\"hora_inicio\":\"13:00\",\"hora_fin\":\"18:00\",\"comentarios\":\"sdfsf\"}', '2025-09-19 23:23:21'),
(45, 'asignacion', 29, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-30\",\"turno\":\"Vespertino\",\"carrera\":\"Werwe\",\"anio\":\"1A\",\"profesor\":\"Wewe\",\"materia\":\"Ewwew\",\"entidad_id\":4,\"hora_inicio\":\"13:00\",\"hora_fin\":\"18:00\",\"comentarios\":\"sdfsf\"}', '2025-09-19 23:23:22'),
(46, 'asignacion', 27, 5, '', NULL, '{\"repeticion\":\"mes\",\"plantilla\":{\"Id\":27,\"turno\":\"Vespertino\",\"fecha\":\"2025-09-16\",\"carrera\":\"Werwe\",\"anio\":\"1A\",\"profesor\":\"Wewe\",\"materia\":\"Ewwew\",\"aula_id\":1,\"hora_inicio\":\"13:00:00\",\"hora_fin\":\"18:00:00\",\"entidad_id\":4,\"comentarios\":\"sdfsf\"},\"eliminadas\":3}', NULL, '2025-09-19 23:23:33'),
(47, 'asignacion', 30, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-15\",\"turno\":\"Vespertino\",\"carrera\":\"Sdfsd\",\"anio\":\"1A\",\"profesor\":\"Sdfsdg\",\"materia\":\"Sdfsd\",\"entidad_id\":4,\"hora_inicio\":\"13:00\",\"hora_fin\":\"18:00\",\"comentarios\":\"sdfsd\"}', '2025-09-19 23:53:14'),
(48, 'asignacion', 30, 5, 'baja', NULL, '{\"Id\":30,\"turno\":\"Vespertino\",\"fecha\":\"2025-09-15\",\"carrera\":\"Sdfsd\",\"anio\":\"1A\",\"profesor\":\"Sdfsdg\",\"materia\":\"Sdfsd\",\"aula_id\":1,\"hora_inicio\":\"13:00:00\",\"hora_fin\":\"18:00:00\",\"entidad_id\":4,\"comentarios\":\"sdfsd\"}', NULL, '2025-09-19 23:53:20'),
(49, 'entidad', 101, 5, 'alta', NULL, NULL, '{\"nombre\":\"hhhh\",\"color\":\"#252628\"}', '2025-09-19 23:54:17'),
(50, 'entidad', 101, 5, 'baja', NULL, '{\"nombre\":\"hhhh\",\"color\":\"#252628\"}', NULL, '2025-09-19 23:54:38'),
(51, 'asignacion', 31, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-16\",\"turno\":\"Matutino\",\"carrera\":\"Safasf\",\"anio\":\"1A\",\"profesor\":\"Fwef\",\"materia\":\"Wefw\",\"entidad_id\":3,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-19 23:56:00'),
(52, 'asignacion', 31, 5, 'modificacion', 'fecha', '2025-09-16', '2025-09-17', '2025-09-19 23:56:28'),
(53, 'asignacion', 31, 5, 'modificacion', 'carrera', 'Safasf', 'Sf', '2025-09-19 23:56:29'),
(54, 'asignacion', 31, 5, 'modificacion', 'anio', '1A', '1B', '2025-09-19 23:56:29'),
(55, 'asignacion', 31, 5, 'modificacion', 'profesor', 'Fwef', 'Tgherg', '2025-09-19 23:56:29'),
(56, 'asignacion', 31, 5, 'modificacion', 'materia', 'Wefw', 'Sdfsd', '2025-09-19 23:56:29'),
(57, 'asignacion', 31, 5, 'modificacion', 'entidad_id', '3', '1', '2025-09-19 23:56:30'),
(58, 'asignacion', 31, 5, 'modificacion', 'hora_inicio', '10:00:00', '11:00', '2025-09-19 23:56:30'),
(59, 'asignacion', 31, 5, 'modificacion', 'hora_fin', '12:00:00', '13:00', '2025-09-19 23:56:30'),
(60, 'asignacion', 31, 5, 'modificacion', 'comentarios', '', 'dfsf', '2025-09-19 23:56:31'),
(61, 'asignacion', 31, 5, 'baja', NULL, '{\"Id\":31,\"turno\":\"Matutino\",\"fecha\":\"2025-09-17\",\"carrera\":\"Sf\",\"anio\":\"1B\",\"profesor\":\"Tgherg\",\"materia\":\"Sdfsd\",\"aula_id\":1,\"hora_inicio\":\"11:00:00\",\"hora_fin\":\"13:00:00\",\"entidad_id\":1,\"comentarios\":\"dfsf\"}', NULL, '2025-09-19 23:56:38'),
(62, 'asignacion', 32, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-17\",\"turno\":\"Vespertino\",\"carrera\":\"Dfgd\",\"anio\":\"1B\",\"profesor\":\"Dfgdf\",\"materia\":\"Dfgdfg\",\"entidad_id\":6,\"hora_inicio\":\"13:00\",\"hora_fin\":\"17:00\",\"comentarios\":\"sdfw\"}', '2025-09-19 23:57:03'),
(63, 'asignacion', 33, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-24\",\"turno\":\"Vespertino\",\"carrera\":\"Dfgd\",\"anio\":\"1B\",\"profesor\":\"Dfgdf\",\"materia\":\"Dfgdfg\",\"entidad_id\":6,\"hora_inicio\":\"13:00\",\"hora_fin\":\"17:00\",\"comentarios\":\"sdfw\"}', '2025-09-19 23:57:03'),
(64, 'asignacion', 32, 5, 'modificacion', 'fecha', '2025-09-17', '2025-09-18', '2025-09-19 23:57:40'),
(65, 'asignacion', 32, 5, 'baja', NULL, '{\"Id\":32,\"turno\":\"Vespertino\",\"fecha\":\"2025-09-18\",\"carrera\":\"Dfgd\",\"anio\":\"1B\",\"profesor\":\"Dfgdf\",\"materia\":\"Dfgdfg\",\"aula_id\":1,\"hora_inicio\":\"13:00:00\",\"hora_fin\":\"17:00:00\",\"entidad_id\":6,\"comentarios\":\"sdfw\"}', NULL, '2025-09-19 23:57:47'),
(66, 'asignacion', 1, 5, 'baja', NULL, '{\"Id\":1,\"turno\":\"Nocturno\",\"fecha\":\"2025-09-15\",\"carrera\":\"Nnn\",\"anio\":\"1\",\"profesor\":\"Nnnnn\",\"materia\":\"Nnnnnnn\",\"aula_id\":1,\"hora_inicio\":\"18:00:00\",\"hora_fin\":\"20:00:00\",\"entidad_id\":3,\"comentarios\":\"\"}', NULL, '2025-09-19 23:57:57'),
(67, 'asignacion', 34, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-17\",\"turno\":\"Nocturno\",\"carrera\":\"Sdfsdf\",\"anio\":\"1A\",\"profesor\":\"Sdfsdf\",\"materia\":\"Dsfsdf\",\"entidad_id\":6,\"hora_inicio\":\"20:00\",\"hora_fin\":\"22:00\",\"comentarios\":\"\"}', '2025-09-19 23:58:28'),
(68, 'asignacion', 35, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-24\",\"turno\":\"Nocturno\",\"carrera\":\"Sdfsdf\",\"anio\":\"1A\",\"profesor\":\"Sdfsdf\",\"materia\":\"Dsfsdf\",\"entidad_id\":6,\"hora_inicio\":\"20:00\",\"hora_fin\":\"22:00\",\"comentarios\":\"\"}', '2025-09-19 23:58:29'),
(69, 'asignacion', 34, 5, 'modificacion', 'hora_inicio', '20:00:00', '18:00', '2025-09-19 23:58:43'),
(70, 'asignacion', 34, 5, 'modificacion', 'hora_fin', '22:00:00', '21:00', '2025-09-19 23:58:44'),
(71, 'asignacion', 34, 5, 'baja', NULL, '{\"Id\":34,\"turno\":\"Nocturno\",\"fecha\":\"2025-09-17\",\"carrera\":\"Sdfsdf\",\"anio\":\"1A\",\"profesor\":\"Sdfsdf\",\"materia\":\"Dsfsdf\",\"aula_id\":1,\"hora_inicio\":\"18:00:00\",\"hora_fin\":\"21:00:00\",\"entidad_id\":6,\"comentarios\":\"\"}', NULL, '2025-09-19 23:58:51'),
(72, 'entidad', 102, 5, 'alta', NULL, NULL, '{\"nombre\":\"zzzzzzzz\",\"color\":\"#28292a\"}', '2025-09-22 15:22:30'),
(73, 'entidad', 103, 5, 'alta', NULL, NULL, '{\"nombre\":\"ssssssss\",\"color\":\"#f0f2f4\"}', '2025-09-22 15:22:41'),
(74, 'entidad', 102, 5, 'baja', NULL, '{\"nombre\":\"zzzzzzzz\",\"color\":\"#28292a\"}', NULL, '2025-09-22 15:22:57'),
(75, 'entidad', 103, 5, 'baja', NULL, '{\"nombre\":\"ssssssss\",\"color\":\"#f0f2f4\"}', NULL, '2025-09-22 15:23:05'),
(76, 'asignacion', 36, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-22\",\"turno\":\"Nocturno\",\"carrera\":\"Soft\",\"anio\":\"1\",\"profesor\":\"Aaaaaaaa\",\"materia\":\"Aaaaaaaaaa\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-09-22 16:16:33'),
(77, 'asignacion', 37, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-29\",\"turno\":\"Nocturno\",\"carrera\":\"Soft\",\"anio\":\"1\",\"profesor\":\"Aaaaaaaa\",\"materia\":\"Aaaaaaaaaa\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-09-22 16:16:34'),
(78, 'asignacion', 38, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-10-06\",\"turno\":\"Nocturno\",\"carrera\":\"Soft\",\"anio\":\"1\",\"profesor\":\"Aaaaaaaa\",\"materia\":\"Aaaaaaaaaa\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-09-22 16:16:35'),
(79, 'asignacion', 39, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-10-13\",\"turno\":\"Nocturno\",\"carrera\":\"Soft\",\"anio\":\"1\",\"profesor\":\"Aaaaaaaa\",\"materia\":\"Aaaaaaaaaa\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-09-22 16:16:36'),
(80, 'asignacion', 40, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-10-20\",\"turno\":\"Nocturno\",\"carrera\":\"Soft\",\"anio\":\"1\",\"profesor\":\"Aaaaaaaa\",\"materia\":\"Aaaaaaaaaa\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-09-22 16:16:37'),
(81, 'asignacion', 41, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-10-27\",\"turno\":\"Nocturno\",\"carrera\":\"Soft\",\"anio\":\"1\",\"profesor\":\"Aaaaaaaa\",\"materia\":\"Aaaaaaaaaa\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-09-22 16:16:38'),
(82, 'asignacion', 42, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-11-03\",\"turno\":\"Nocturno\",\"carrera\":\"Soft\",\"anio\":\"1\",\"profesor\":\"Aaaaaaaa\",\"materia\":\"Aaaaaaaaaa\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-09-22 16:16:38'),
(83, 'asignacion', 43, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-11-10\",\"turno\":\"Nocturno\",\"carrera\":\"Soft\",\"anio\":\"1\",\"profesor\":\"Aaaaaaaa\",\"materia\":\"Aaaaaaaaaa\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-09-22 16:16:39'),
(84, 'asignacion', 44, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-11-17\",\"turno\":\"Nocturno\",\"carrera\":\"Soft\",\"anio\":\"1\",\"profesor\":\"Aaaaaaaa\",\"materia\":\"Aaaaaaaaaa\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-09-22 16:16:41'),
(85, 'asignacion', 45, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-11-24\",\"turno\":\"Nocturno\",\"carrera\":\"Soft\",\"anio\":\"1\",\"profesor\":\"Aaaaaaaa\",\"materia\":\"Aaaaaaaaaa\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-09-22 16:16:41'),
(86, 'asignacion', 46, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-12-01\",\"turno\":\"Nocturno\",\"carrera\":\"Soft\",\"anio\":\"1\",\"profesor\":\"Aaaaaaaa\",\"materia\":\"Aaaaaaaaaa\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-09-22 16:16:42'),
(87, 'asignacion', 47, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-12-08\",\"turno\":\"Nocturno\",\"carrera\":\"Soft\",\"anio\":\"1\",\"profesor\":\"Aaaaaaaa\",\"materia\":\"Aaaaaaaaaa\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-09-22 16:16:43'),
(88, 'asignacion', 48, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-12-15\",\"turno\":\"Nocturno\",\"carrera\":\"Soft\",\"anio\":\"1\",\"profesor\":\"Aaaaaaaa\",\"materia\":\"Aaaaaaaaaa\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-09-22 16:16:44'),
(89, 'asignacion', 49, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-12-22\",\"turno\":\"Nocturno\",\"carrera\":\"Soft\",\"anio\":\"1\",\"profesor\":\"Aaaaaaaa\",\"materia\":\"Aaaaaaaaaa\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-09-22 16:16:45'),
(90, 'asignacion', 50, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-12-29\",\"turno\":\"Nocturno\",\"carrera\":\"Soft\",\"anio\":\"1\",\"profesor\":\"Aaaaaaaa\",\"materia\":\"Aaaaaaaaaa\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-09-22 16:16:46'),
(91, 'asignacion', 51, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-24\",\"turno\":\"Nocturno\",\"carrera\":\"Aaaaa\",\"anio\":\"1\",\"profesor\":\"Aaaaaaaa\",\"materia\":\"Aaaaaaa\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"18:45\",\"comentarios\":\"\"}', '2025-09-22 18:25:48'),
(92, 'asignacion', 52, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-10-01\",\"turno\":\"Nocturno\",\"carrera\":\"Aaaaa\",\"anio\":\"1\",\"profesor\":\"Aaaaaaaa\",\"materia\":\"Aaaaaaa\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"18:45\",\"comentarios\":\"\"}', '2025-09-22 18:25:49'),
(93, 'asignacion', 53, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-10-08\",\"turno\":\"Nocturno\",\"carrera\":\"Aaaaa\",\"anio\":\"1\",\"profesor\":\"Aaaaaaaa\",\"materia\":\"Aaaaaaa\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"18:45\",\"comentarios\":\"\"}', '2025-09-22 18:25:49'),
(94, 'asignacion', 54, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-10-15\",\"turno\":\"Nocturno\",\"carrera\":\"Aaaaa\",\"anio\":\"1\",\"profesor\":\"Aaaaaaaa\",\"materia\":\"Aaaaaaa\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"18:45\",\"comentarios\":\"\"}', '2025-09-22 18:25:50'),
(95, 'asignacion', 55, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-10-22\",\"turno\":\"Nocturno\",\"carrera\":\"Aaaaa\",\"anio\":\"1\",\"profesor\":\"Aaaaaaaa\",\"materia\":\"Aaaaaaa\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"18:45\",\"comentarios\":\"\"}', '2025-09-22 18:25:51'),
(96, 'asignacion', 56, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-10-29\",\"turno\":\"Nocturno\",\"carrera\":\"Aaaaa\",\"anio\":\"1\",\"profesor\":\"Aaaaaaaa\",\"materia\":\"Aaaaaaa\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"18:45\",\"comentarios\":\"\"}', '2025-09-22 18:25:52'),
(97, 'asignacion', 57, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-11-05\",\"turno\":\"Nocturno\",\"carrera\":\"Aaaaa\",\"anio\":\"1\",\"profesor\":\"Aaaaaaaa\",\"materia\":\"Aaaaaaa\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"18:45\",\"comentarios\":\"\"}', '2025-09-22 18:25:53'),
(98, 'asignacion', 58, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-11-12\",\"turno\":\"Nocturno\",\"carrera\":\"Aaaaa\",\"anio\":\"1\",\"profesor\":\"Aaaaaaaa\",\"materia\":\"Aaaaaaa\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"18:45\",\"comentarios\":\"\"}', '2025-09-22 18:25:53'),
(99, 'asignacion', 59, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-11-19\",\"turno\":\"Nocturno\",\"carrera\":\"Aaaaa\",\"anio\":\"1\",\"profesor\":\"Aaaaaaaa\",\"materia\":\"Aaaaaaa\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"18:45\",\"comentarios\":\"\"}', '2025-09-22 18:25:54'),
(100, 'asignacion', 60, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-11-26\",\"turno\":\"Nocturno\",\"carrera\":\"Aaaaa\",\"anio\":\"1\",\"profesor\":\"Aaaaaaaa\",\"materia\":\"Aaaaaaa\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"18:45\",\"comentarios\":\"\"}', '2025-09-22 18:25:55'),
(101, 'asignacion', 61, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-12-03\",\"turno\":\"Nocturno\",\"carrera\":\"Aaaaa\",\"anio\":\"1\",\"profesor\":\"Aaaaaaaa\",\"materia\":\"Aaaaaaa\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"18:45\",\"comentarios\":\"\"}', '2025-09-22 18:25:56'),
(102, 'asignacion', 62, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-12-10\",\"turno\":\"Nocturno\",\"carrera\":\"Aaaaa\",\"anio\":\"1\",\"profesor\":\"Aaaaaaaa\",\"materia\":\"Aaaaaaa\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"18:45\",\"comentarios\":\"\"}', '2025-09-22 18:25:57'),
(103, 'asignacion', 63, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-12-17\",\"turno\":\"Nocturno\",\"carrera\":\"Aaaaa\",\"anio\":\"1\",\"profesor\":\"Aaaaaaaa\",\"materia\":\"Aaaaaaa\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"18:45\",\"comentarios\":\"\"}', '2025-09-22 18:25:58'),
(104, 'asignacion', 64, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-12-24\",\"turno\":\"Nocturno\",\"carrera\":\"Aaaaa\",\"anio\":\"1\",\"profesor\":\"Aaaaaaaa\",\"materia\":\"Aaaaaaa\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"18:45\",\"comentarios\":\"\"}', '2025-09-22 18:25:58'),
(105, 'asignacion', 65, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-12-31\",\"turno\":\"Nocturno\",\"carrera\":\"Aaaaa\",\"anio\":\"1\",\"profesor\":\"Aaaaaaaa\",\"materia\":\"Aaaaaaa\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"18:45\",\"comentarios\":\"\"}', '2025-09-22 18:25:59'),
(106, 'entidad', 104, 5, 'alta', NULL, NULL, '{\"nombre\":\"sdfsadf\",\"color\":\"#0a2338\"}', '2025-09-22 20:12:52'),
(107, 'entidad', 104, 5, 'baja', NULL, '{\"nombre\":\"sdfsadf\",\"color\":\"#0a2338\"}', NULL, '2025-09-22 20:13:01'),
(108, 'asignacion', 22, 5, 'modificacion', 'hora_inicio', '10:00:00', '11:00', '2025-09-22 20:30:39'),
(109, 'asignacion', 22, 5, 'modificacion', 'entidad_id', '6', '4', '2025-09-22 20:30:52'),
(110, 'asignacion', 66, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-23\",\"turno\":\"Matutino\",\"carrera\":\"Sdfgsd\",\"anio\":\"1\",\"profesor\":\"Sdfgsdgf\",\"materia\":\"Sdfgsdgf\",\"entidad_id\":6,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 11:54:30'),
(111, 'asignacion', 66, 5, 'baja', NULL, '{\"Id\":66,\"turno\":\"Matutino\",\"fecha\":\"2025-09-23\",\"carrera\":\"Sdfgsd\",\"anio\":\"1\",\"profesor\":\"Sdfgsdgf\",\"materia\":\"Sdfgsdgf\",\"aula_id\":1,\"hora_inicio\":\"10:00:00\",\"hora_fin\":\"12:00:00\",\"entidad_id\":6,\"comentarios\":\"\"}', NULL, '2025-09-23 11:54:41'),
(112, 'asignacion', 22, 5, 'baja', NULL, '{\"Id\":22,\"turno\":\"Matutino\",\"fecha\":\"2025-09-24\",\"carrera\":\"Asdasd\",\"anio\":\"1A\",\"profesor\":\"Asfasf\",\"materia\":\"Safasf\",\"aula_id\":2,\"hora_inicio\":\"11:00:00\",\"hora_fin\":\"12:00:00\",\"entidad_id\":4,\"comentarios\":\"safsfasf\"}', NULL, '2025-09-23 11:57:20'),
(113, 'asignacion', 67, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-22\",\"turno\":\"Matutino\",\"carrera\":\"Asfdas\",\"anio\":\"1\",\"profesor\":\"Asfdasfd\",\"materia\":\"Asdfas\",\"entidad_id\":6,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 11:57:44'),
(114, 'asignacion', 68, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-23\",\"turno\":\"Matutino\",\"carrera\":\"Sdgfs\",\"anio\":\"2\",\"profesor\":\"Fgsdgh\",\"materia\":\"Sdgfsdg\",\"entidad_id\":3,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 11:58:04'),
(115, 'asignacion', 67, 5, 'baja', NULL, '{\"Id\":67,\"turno\":\"Matutino\",\"fecha\":\"2025-09-22\",\"carrera\":\"Asfdas\",\"anio\":\"1\",\"profesor\":\"Asfdasfd\",\"materia\":\"Asdfas\",\"aula_id\":1,\"hora_inicio\":\"10:00:00\",\"hora_fin\":\"12:00:00\",\"entidad_id\":6,\"comentarios\":\"\"}', NULL, '2025-09-23 11:59:51'),
(116, 'asignacion', 68, 5, 'baja', NULL, '{\"Id\":68,\"turno\":\"Matutino\",\"fecha\":\"2025-09-23\",\"carrera\":\"Sdgfs\",\"anio\":\"2\",\"profesor\":\"Fgsdgh\",\"materia\":\"Sdgfsdg\",\"aula_id\":1,\"hora_inicio\":\"10:00:00\",\"hora_fin\":\"12:00:00\",\"entidad_id\":3,\"comentarios\":\"\"}', NULL, '2025-09-23 11:59:57'),
(117, 'asignacion', 69, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-22\",\"turno\":\"Matutino\",\"carrera\":\"Asdfa\",\"anio\":\"1A\",\"profesor\":\"Asdfa\",\"materia\":\"Asdfas\",\"entidad_id\":6,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:00:17'),
(118, 'asignacion', 69, 5, 'baja', NULL, '{\"Id\":69,\"turno\":\"Matutino\",\"fecha\":\"2025-09-22\",\"carrera\":\"Asdfa\",\"anio\":\"1A\",\"profesor\":\"Asdfa\",\"materia\":\"Asdfas\",\"aula_id\":1,\"hora_inicio\":\"10:00:00\",\"hora_fin\":\"12:00:00\",\"entidad_id\":6,\"comentarios\":\"\"}', NULL, '2025-09-23 12:00:33'),
(119, 'asignacion', 70, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-22\",\"turno\":\"Matutino\",\"carrera\":\"Sdfasf\",\"anio\":\"3\",\"profesor\":\"Sdfgsdgf\",\"materia\":\"Sadfas\",\"entidad_id\":6,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:00:49'),
(120, 'asignacion', 70, 5, 'baja', NULL, '{\"Id\":70,\"turno\":\"Matutino\",\"fecha\":\"2025-09-22\",\"carrera\":\"Sdfasf\",\"anio\":\"3\",\"profesor\":\"Sdfgsdgf\",\"materia\":\"Sadfas\",\"aula_id\":1,\"hora_inicio\":\"10:00:00\",\"hora_fin\":\"12:00:00\",\"entidad_id\":6,\"comentarios\":\"\"}', NULL, '2025-09-23 12:00:56'),
(121, 'asignacion', 71, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-22\",\"turno\":\"Matutino\",\"carrera\":\"Sfasfd\",\"anio\":\"1A\",\"profesor\":\"Asfdasfd\",\"materia\":\"Asfasfd\",\"entidad_id\":6,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:02:19'),
(122, 'asignacion', 72, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-23\",\"turno\":\"Matutino\",\"carrera\":\"Asdfasfd\",\"anio\":\"1A\",\"profesor\":\"Asfdasfd\",\"materia\":\"Asfdasfd\",\"entidad_id\":6,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:02:34'),
(123, 'asignacion', 1, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-22\",\"turno\":\"Matutino\",\"carrera\":\"Asdfaf\",\"anio\":\"1A\",\"profesor\":\"Asdfas\",\"materia\":\"Asasfd\",\"entidad_id\":4,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:03:57'),
(124, 'asignacion', 2, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-22\",\"turno\":\"Matutino\",\"carrera\":\"Sdgfsdg\",\"anio\":\"1A\",\"profesor\":\"Sdfgs\",\"materia\":\"Sdfgsd\",\"entidad_id\":6,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:05:47'),
(125, 'asignacion', 3, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-22\",\"turno\":\"Matutino\",\"carrera\":\"Sdgfsd\",\"anio\":\"1A\",\"profesor\":\"Sdfgsd\",\"materia\":\"Sdfgsd\",\"entidad_id\":6,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:07:11'),
(126, 'asignacion', 4, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-29\",\"turno\":\"Matutino\",\"carrera\":\"Sdgfsd\",\"anio\":\"1A\",\"profesor\":\"Sdfgsd\",\"materia\":\"Sdfgsd\",\"entidad_id\":6,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:07:12'),
(127, 'asignacion', 3, 5, '', NULL, '{\"repeticion\":\"mes\",\"plantilla\":{\"Id\":3,\"turno\":\"Matutino\",\"fecha\":\"2025-09-22\",\"carrera\":\"Sdgfsd\",\"anio\":\"1A\",\"profesor\":\"Sdfgsd\",\"materia\":\"Sdfgsd\",\"aula_id\":1,\"hora_inicio\":\"10:00:00\",\"hora_fin\":\"12:00:00\",\"entidad_id\":6,\"comentarios\":\"\"},\"eliminadas\":2}', NULL, '2025-09-23 12:07:44'),
(128, 'asignacion', 5, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-22\",\"turno\":\"Matutino\",\"carrera\":\"Asdfasfd\",\"anio\":\"1B\",\"profesor\":\"Sdfgsd\",\"materia\":\"Sdfgsd\",\"entidad_id\":4,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:08:00'),
(129, 'asignacion', 6, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-29\",\"turno\":\"Matutino\",\"carrera\":\"Asdfasfd\",\"anio\":\"1B\",\"profesor\":\"Sdfgsd\",\"materia\":\"Sdfgsd\",\"entidad_id\":4,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:08:01'),
(130, 'asignacion', 7, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-10-06\",\"turno\":\"Matutino\",\"carrera\":\"Asdfasfd\",\"anio\":\"1B\",\"profesor\":\"Sdfgsd\",\"materia\":\"Sdfgsd\",\"entidad_id\":4,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:08:02'),
(131, 'asignacion', 8, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-10-13\",\"turno\":\"Matutino\",\"carrera\":\"Asdfasfd\",\"anio\":\"1B\",\"profesor\":\"Sdfgsd\",\"materia\":\"Sdfgsd\",\"entidad_id\":4,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:08:03'),
(132, 'asignacion', 9, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-10-20\",\"turno\":\"Matutino\",\"carrera\":\"Asdfasfd\",\"anio\":\"1B\",\"profesor\":\"Sdfgsd\",\"materia\":\"Sdfgsd\",\"entidad_id\":4,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:08:04'),
(133, 'asignacion', 10, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-10-27\",\"turno\":\"Matutino\",\"carrera\":\"Asdfasfd\",\"anio\":\"1B\",\"profesor\":\"Sdfgsd\",\"materia\":\"Sdfgsd\",\"entidad_id\":4,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:08:05'),
(134, 'asignacion', 11, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-11-03\",\"turno\":\"Matutino\",\"carrera\":\"Asdfasfd\",\"anio\":\"1B\",\"profesor\":\"Sdfgsd\",\"materia\":\"Sdfgsd\",\"entidad_id\":4,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:08:05'),
(135, 'asignacion', 12, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-11-10\",\"turno\":\"Matutino\",\"carrera\":\"Asdfasfd\",\"anio\":\"1B\",\"profesor\":\"Sdfgsd\",\"materia\":\"Sdfgsd\",\"entidad_id\":4,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:08:06'),
(136, 'asignacion', 13, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-11-17\",\"turno\":\"Matutino\",\"carrera\":\"Asdfasfd\",\"anio\":\"1B\",\"profesor\":\"Sdfgsd\",\"materia\":\"Sdfgsd\",\"entidad_id\":4,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:08:07'),
(137, 'asignacion', 14, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-11-24\",\"turno\":\"Matutino\",\"carrera\":\"Asdfasfd\",\"anio\":\"1B\",\"profesor\":\"Sdfgsd\",\"materia\":\"Sdfgsd\",\"entidad_id\":4,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:08:08'),
(138, 'asignacion', 15, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-12-01\",\"turno\":\"Matutino\",\"carrera\":\"Asdfasfd\",\"anio\":\"1B\",\"profesor\":\"Sdfgsd\",\"materia\":\"Sdfgsd\",\"entidad_id\":4,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:08:09'),
(139, 'asignacion', 16, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-12-08\",\"turno\":\"Matutino\",\"carrera\":\"Asdfasfd\",\"anio\":\"1B\",\"profesor\":\"Sdfgsd\",\"materia\":\"Sdfgsd\",\"entidad_id\":4,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:08:10'),
(140, 'asignacion', 17, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-12-15\",\"turno\":\"Matutino\",\"carrera\":\"Asdfasfd\",\"anio\":\"1B\",\"profesor\":\"Sdfgsd\",\"materia\":\"Sdfgsd\",\"entidad_id\":4,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:08:11'),
(141, 'asignacion', 18, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-12-22\",\"turno\":\"Matutino\",\"carrera\":\"Asdfasfd\",\"anio\":\"1B\",\"profesor\":\"Sdfgsd\",\"materia\":\"Sdfgsd\",\"entidad_id\":4,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:08:12'),
(142, 'asignacion', 19, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-12-29\",\"turno\":\"Matutino\",\"carrera\":\"Asdfasfd\",\"anio\":\"1B\",\"profesor\":\"Sdfgsd\",\"materia\":\"Sdfgsd\",\"entidad_id\":4,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:08:12'),
(143, 'asignacion', 20, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2026-01-05\",\"turno\":\"Matutino\",\"carrera\":\"Asdfasfd\",\"anio\":\"1B\",\"profesor\":\"Sdfgsd\",\"materia\":\"Sdfgsd\",\"entidad_id\":4,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:08:13'),
(144, 'asignacion', 21, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2026-01-12\",\"turno\":\"Matutino\",\"carrera\":\"Asdfasfd\",\"anio\":\"1B\",\"profesor\":\"Sdfgsd\",\"materia\":\"Sdfgsd\",\"entidad_id\":4,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:08:14'),
(145, 'asignacion', 22, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2026-01-19\",\"turno\":\"Matutino\",\"carrera\":\"Asdfasfd\",\"anio\":\"1B\",\"profesor\":\"Sdfgsd\",\"materia\":\"Sdfgsd\",\"entidad_id\":4,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:08:15'),
(146, 'asignacion', 23, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-01-01\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:09:36'),
(147, 'asignacion', 24, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-01-08\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:09:36'),
(148, 'asignacion', 25, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-01-15\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:09:37'),
(149, 'asignacion', 26, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-01-22\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:09:38'),
(150, 'asignacion', 27, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-01-29\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:09:39'),
(151, 'asignacion', 28, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-02-05\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:09:40'),
(152, 'asignacion', 29, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-02-12\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:09:41'),
(153, 'asignacion', 30, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-02-19\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:09:42'),
(154, 'asignacion', 31, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-02-26\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:09:42'),
(155, 'asignacion', 32, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-03-05\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:09:43'),
(156, 'asignacion', 33, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-03-12\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:09:44'),
(157, 'asignacion', 34, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-03-19\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:09:45'),
(158, 'asignacion', 35, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-03-26\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:09:46'),
(159, 'asignacion', 36, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-04-02\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:09:47'),
(160, 'asignacion', 37, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-04-09\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:09:48'),
(161, 'asignacion', 38, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-04-16\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:09:49'),
(162, 'asignacion', 39, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-04-23\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:09:49'),
(163, 'asignacion', 40, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-04-30\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:09:50'),
(164, 'asignacion', 41, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-05-07\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:09:51'),
(165, 'asignacion', 42, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-05-14\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:09:52'),
(166, 'asignacion', 43, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-05-21\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:09:53'),
(167, 'asignacion', 44, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-05-28\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:09:54'),
(168, 'asignacion', 45, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-06-04\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:09:55'),
(169, 'asignacion', 46, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-06-11\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:09:56'),
(170, 'asignacion', 47, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-06-18\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:09:56'),
(171, 'asignacion', 48, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-06-25\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:09:57'),
(172, 'asignacion', 49, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-07-02\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:09:58'),
(173, 'asignacion', 50, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-07-09\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:09:59'),
(174, 'asignacion', 51, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-07-16\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:10:00'),
(175, 'asignacion', 52, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-07-23\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:10:01'),
(176, 'asignacion', 53, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-07-30\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:10:02'),
(177, 'asignacion', 54, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-08-06\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:10:03'),
(178, 'asignacion', 55, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-08-13\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:10:03'),
(179, 'asignacion', 56, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-08-20\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:10:04');
INSERT INTO `auditoria_acciones` (`id`, `tipo_objeto`, `objeto_id`, `usuario_id`, `accion`, `campo_modificado`, `valor_anterior`, `valor_nuevo`, `fecha`) VALUES
(180, 'asignacion', 57, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-08-27\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:10:05'),
(181, 'asignacion', 58, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-03\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:10:06'),
(182, 'asignacion', 59, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-10\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:10:07'),
(183, 'asignacion', 60, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-17\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:10:08'),
(184, 'asignacion', 61, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-24\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:10:09'),
(185, 'asignacion', 62, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-10-01\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:10:09'),
(186, 'asignacion', 63, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-10-08\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:10:10'),
(187, 'asignacion', 64, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-10-15\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:10:11'),
(188, 'asignacion', 65, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-10-22\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:10:12'),
(189, 'asignacion', 66, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-10-29\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:10:13'),
(190, 'asignacion', 67, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-11-05\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:10:14'),
(191, 'asignacion', 68, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-11-12\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:10:15'),
(192, 'asignacion', 69, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-11-19\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:10:15'),
(193, 'asignacion', 70, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-11-26\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:10:16'),
(194, 'asignacion', 71, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-12-03\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:10:17'),
(195, 'asignacion', 72, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-12-10\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:10:18'),
(196, 'asignacion', 73, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-12-17\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:10:19'),
(197, 'asignacion', 74, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-12-24\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:10:20'),
(198, 'asignacion', 75, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-12-31\",\"turno\":\"Matutino\",\"carrera\":\"Fdgdsfg\",\"anio\":\"1A\",\"profesor\":\"Sdfgsfg\",\"materia\":\"Sdfsdf\",\"entidad_id\":6,\"hora_inicio\":\"12:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-23 12:10:21'),
(199, 'asignacion', 1, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-07-01\",\"turno\":\"Matutino\",\"carrera\":\"Zxasfd\",\"anio\":\"1A\",\"profesor\":\"Asdfas\",\"materia\":\"Asdfasdf\",\"entidad_id\":6,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:13:59'),
(200, 'asignacion', 2, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-07-08\",\"turno\":\"Matutino\",\"carrera\":\"Zxasfd\",\"anio\":\"1A\",\"profesor\":\"Asdfas\",\"materia\":\"Asdfasdf\",\"entidad_id\":6,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:14:00'),
(201, 'asignacion', 3, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-07-15\",\"turno\":\"Matutino\",\"carrera\":\"Zxasfd\",\"anio\":\"1A\",\"profesor\":\"Asdfas\",\"materia\":\"Asdfasdf\",\"entidad_id\":6,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:14:01'),
(202, 'asignacion', 4, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-07-22\",\"turno\":\"Matutino\",\"carrera\":\"Zxasfd\",\"anio\":\"1A\",\"profesor\":\"Asdfas\",\"materia\":\"Asdfasdf\",\"entidad_id\":6,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:14:01'),
(203, 'asignacion', 5, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-07-29\",\"turno\":\"Matutino\",\"carrera\":\"Zxasfd\",\"anio\":\"1A\",\"profesor\":\"Asdfas\",\"materia\":\"Asdfasdf\",\"entidad_id\":6,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:14:02'),
(204, 'asignacion', 6, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-08-05\",\"turno\":\"Matutino\",\"carrera\":\"Zxasfd\",\"anio\":\"1A\",\"profesor\":\"Asdfas\",\"materia\":\"Asdfasdf\",\"entidad_id\":6,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:14:03'),
(205, 'asignacion', 7, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-08-12\",\"turno\":\"Matutino\",\"carrera\":\"Zxasfd\",\"anio\":\"1A\",\"profesor\":\"Asdfas\",\"materia\":\"Asdfasdf\",\"entidad_id\":6,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:14:04'),
(206, 'asignacion', 8, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-08-19\",\"turno\":\"Matutino\",\"carrera\":\"Zxasfd\",\"anio\":\"1A\",\"profesor\":\"Asdfas\",\"materia\":\"Asdfasdf\",\"entidad_id\":6,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:14:05'),
(207, 'asignacion', 9, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-08-26\",\"turno\":\"Matutino\",\"carrera\":\"Zxasfd\",\"anio\":\"1A\",\"profesor\":\"Asdfas\",\"materia\":\"Asdfasdf\",\"entidad_id\":6,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:14:06'),
(208, 'asignacion', 10, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-02\",\"turno\":\"Matutino\",\"carrera\":\"Zxasfd\",\"anio\":\"1A\",\"profesor\":\"Asdfas\",\"materia\":\"Asdfasdf\",\"entidad_id\":6,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:14:07'),
(209, 'asignacion', 11, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-09\",\"turno\":\"Matutino\",\"carrera\":\"Zxasfd\",\"anio\":\"1A\",\"profesor\":\"Asdfas\",\"materia\":\"Asdfasdf\",\"entidad_id\":6,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:14:08'),
(210, 'asignacion', 12, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-16\",\"turno\":\"Matutino\",\"carrera\":\"Zxasfd\",\"anio\":\"1A\",\"profesor\":\"Asdfas\",\"materia\":\"Asdfasdf\",\"entidad_id\":6,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:14:08'),
(211, 'asignacion', 13, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-23\",\"turno\":\"Matutino\",\"carrera\":\"Zxasfd\",\"anio\":\"1A\",\"profesor\":\"Asdfas\",\"materia\":\"Asdfasdf\",\"entidad_id\":6,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:14:09'),
(212, 'asignacion', 14, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-30\",\"turno\":\"Matutino\",\"carrera\":\"Zxasfd\",\"anio\":\"1A\",\"profesor\":\"Asdfas\",\"materia\":\"Asdfasdf\",\"entidad_id\":6,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:14:10'),
(213, 'asignacion', 15, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-10-07\",\"turno\":\"Matutino\",\"carrera\":\"Zxasfd\",\"anio\":\"1A\",\"profesor\":\"Asdfas\",\"materia\":\"Asdfasdf\",\"entidad_id\":6,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:14:11'),
(214, 'asignacion', 16, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-10-14\",\"turno\":\"Matutino\",\"carrera\":\"Zxasfd\",\"anio\":\"1A\",\"profesor\":\"Asdfas\",\"materia\":\"Asdfasdf\",\"entidad_id\":6,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:14:12'),
(215, 'asignacion', 17, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-10-21\",\"turno\":\"Matutino\",\"carrera\":\"Zxasfd\",\"anio\":\"1A\",\"profesor\":\"Asdfas\",\"materia\":\"Asdfasdf\",\"entidad_id\":6,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:14:13'),
(216, 'asignacion', 18, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-10-28\",\"turno\":\"Matutino\",\"carrera\":\"Zxasfd\",\"anio\":\"1A\",\"profesor\":\"Asdfas\",\"materia\":\"Asdfasdf\",\"entidad_id\":6,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:14:14'),
(217, 'asignacion', 17, 5, '', NULL, '{\"repeticion\":\"cuatrimestral\",\"plantilla\":{\"Id\":17,\"turno\":\"Matutino\",\"fecha\":\"2025-10-21\",\"carrera\":\"Zxasfd\",\"anio\":\"1A\",\"profesor\":\"Asdfas\",\"materia\":\"Asdfasdf\",\"aula_id\":1,\"hora_inicio\":\"10:00:00\",\"hora_fin\":\"12:00:00\",\"entidad_id\":6,\"comentarios\":\"\"},\"eliminadas\":2}', NULL, '2025-09-23 12:14:59'),
(218, 'asignacion', 1, 5, '', NULL, '{\"repeticion\":\"cuatrimestral\",\"plantilla\":{\"Id\":1,\"turno\":\"Matutino\",\"fecha\":\"2025-07-01\",\"carrera\":\"Zxasfd\",\"anio\":\"1A\",\"profesor\":\"Asdfas\",\"materia\":\"Asdfasdf\",\"aula_id\":1,\"hora_inicio\":\"10:00:00\",\"hora_fin\":\"12:00:00\",\"entidad_id\":6,\"comentarios\":\"\"},\"eliminadas\":16}', NULL, '2025-09-23 12:15:48'),
(219, 'asignacion', 19, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-03-01\",\"turno\":\"Matutino\",\"carrera\":\"Dsfgsd\",\"anio\":\"1A\",\"profesor\":\"Sdgfs\",\"materia\":\"Sdgfsd\",\"entidad_id\":3,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:19:19'),
(220, 'asignacion', 20, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-03-08\",\"turno\":\"Matutino\",\"carrera\":\"Dsfgsd\",\"anio\":\"1A\",\"profesor\":\"Sdgfs\",\"materia\":\"Sdgfsd\",\"entidad_id\":3,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:19:20'),
(221, 'asignacion', 21, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-03-15\",\"turno\":\"Matutino\",\"carrera\":\"Dsfgsd\",\"anio\":\"1A\",\"profesor\":\"Sdgfs\",\"materia\":\"Sdgfsd\",\"entidad_id\":3,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:19:20'),
(222, 'asignacion', 22, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-03-22\",\"turno\":\"Matutino\",\"carrera\":\"Dsfgsd\",\"anio\":\"1A\",\"profesor\":\"Sdgfs\",\"materia\":\"Sdgfsd\",\"entidad_id\":3,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:19:21'),
(223, 'asignacion', 23, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-03-29\",\"turno\":\"Matutino\",\"carrera\":\"Dsfgsd\",\"anio\":\"1A\",\"profesor\":\"Sdgfs\",\"materia\":\"Sdgfsd\",\"entidad_id\":3,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:19:22'),
(224, 'asignacion', 24, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-04-05\",\"turno\":\"Matutino\",\"carrera\":\"Dsfgsd\",\"anio\":\"1A\",\"profesor\":\"Sdgfs\",\"materia\":\"Sdgfsd\",\"entidad_id\":3,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:19:23'),
(225, 'asignacion', 25, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-04-12\",\"turno\":\"Matutino\",\"carrera\":\"Dsfgsd\",\"anio\":\"1A\",\"profesor\":\"Sdgfs\",\"materia\":\"Sdgfsd\",\"entidad_id\":3,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:19:24'),
(226, 'asignacion', 26, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-04-19\",\"turno\":\"Matutino\",\"carrera\":\"Dsfgsd\",\"anio\":\"1A\",\"profesor\":\"Sdgfs\",\"materia\":\"Sdgfsd\",\"entidad_id\":3,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:19:25'),
(227, 'asignacion', 27, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-04-26\",\"turno\":\"Matutino\",\"carrera\":\"Dsfgsd\",\"anio\":\"1A\",\"profesor\":\"Sdgfs\",\"materia\":\"Sdgfsd\",\"entidad_id\":3,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:19:26'),
(228, 'asignacion', 28, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-05-03\",\"turno\":\"Matutino\",\"carrera\":\"Dsfgsd\",\"anio\":\"1A\",\"profesor\":\"Sdgfs\",\"materia\":\"Sdgfsd\",\"entidad_id\":3,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:19:27'),
(229, 'asignacion', 29, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-05-10\",\"turno\":\"Matutino\",\"carrera\":\"Dsfgsd\",\"anio\":\"1A\",\"profesor\":\"Sdgfs\",\"materia\":\"Sdgfsd\",\"entidad_id\":3,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:19:27'),
(230, 'asignacion', 30, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-05-17\",\"turno\":\"Matutino\",\"carrera\":\"Dsfgsd\",\"anio\":\"1A\",\"profesor\":\"Sdgfs\",\"materia\":\"Sdgfsd\",\"entidad_id\":3,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:19:28'),
(231, 'asignacion', 31, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-05-24\",\"turno\":\"Matutino\",\"carrera\":\"Dsfgsd\",\"anio\":\"1A\",\"profesor\":\"Sdgfs\",\"materia\":\"Sdgfsd\",\"entidad_id\":3,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:19:29'),
(232, 'asignacion', 32, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-05-31\",\"turno\":\"Matutino\",\"carrera\":\"Dsfgsd\",\"anio\":\"1A\",\"profesor\":\"Sdgfs\",\"materia\":\"Sdgfsd\",\"entidad_id\":3,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:19:30'),
(233, 'asignacion', 33, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-06-07\",\"turno\":\"Matutino\",\"carrera\":\"Dsfgsd\",\"anio\":\"1A\",\"profesor\":\"Sdgfs\",\"materia\":\"Sdgfsd\",\"entidad_id\":3,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:19:31'),
(234, 'asignacion', 34, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-06-14\",\"turno\":\"Matutino\",\"carrera\":\"Dsfgsd\",\"anio\":\"1A\",\"profesor\":\"Sdgfs\",\"materia\":\"Sdgfsd\",\"entidad_id\":3,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:19:32'),
(235, 'asignacion', 35, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-06-21\",\"turno\":\"Matutino\",\"carrera\":\"Dsfgsd\",\"anio\":\"1A\",\"profesor\":\"Sdgfs\",\"materia\":\"Sdgfsd\",\"entidad_id\":3,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:19:33'),
(236, 'asignacion', 36, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-06-28\",\"turno\":\"Matutino\",\"carrera\":\"Dsfgsd\",\"anio\":\"1A\",\"profesor\":\"Sdgfs\",\"materia\":\"Sdgfsd\",\"entidad_id\":3,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-09-23 12:19:33'),
(237, 'asignacion', 30, 5, '', NULL, '{\"repeticion\":\"cuatrimestral\",\"plantilla\":{\"Id\":30,\"turno\":\"Matutino\",\"fecha\":\"2025-05-17\",\"carrera\":\"Dsfgsd\",\"anio\":\"1A\",\"profesor\":\"Sdgfs\",\"materia\":\"Sdgfsd\",\"aula_id\":1,\"hora_inicio\":\"10:00:00\",\"hora_fin\":\"12:00:00\",\"entidad_id\":3,\"comentarios\":\"\"},\"eliminadas\":18}', NULL, '2025-09-23 12:20:00'),
(238, 'asignacion', 37, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-26\",\"turno\":\"Vespertino\",\"carrera\":\"Sdgfsdgf\",\"anio\":\"1A\",\"profesor\":\"Sdfgsdgf\",\"materia\":\"Sdfgsd\",\"entidad_id\":6,\"hora_inicio\":\"14:30\",\"hora_fin\":\"16:00\",\"comentarios\":\"sdfsd\"}', '2025-09-26 17:44:46'),
(239, 'asignacion', 38, 5, 'alta', NULL, NULL, '{\"aula_id\":2,\"fecha\":\"2025-09-26\",\"turno\":\"Vespertino\",\"carrera\":\"Asdfas\",\"anio\":\"1A\",\"profesor\":\"Asfdas\",\"materia\":\"Asfdasfd\",\"entidad_id\":4,\"hora_inicio\":\"13:00\",\"hora_fin\":\"14:00\",\"comentarios\":\"\"}', '2025-09-26 17:45:18'),
(240, 'asignacion', 39, 5, 'alta', NULL, NULL, '{\"aula_id\":3,\"fecha\":\"2025-09-26\",\"turno\":\"Vespertino\",\"carrera\":\"Asdf\",\"anio\":\"1\",\"profesor\":\"Sdfg\",\"materia\":\"Asdfa\",\"entidad_id\":2,\"hora_inicio\":\"15:08\",\"hora_fin\":\"17:00\",\"comentarios\":\"\"}', '2025-09-26 18:07:18'),
(241, 'asignacion', 40, 5, 'alta', NULL, NULL, '{\"aula_id\":4,\"fecha\":\"2025-09-26\",\"turno\":\"Vespertino\",\"carrera\":\"Sdfgsd\",\"anio\":\"1A\",\"profesor\":\"Sdgfs\",\"materia\":\"Sdfgsd\",\"entidad_id\":5,\"hora_inicio\":\"15:11\",\"hora_fin\":\"17:00\",\"comentarios\":\"\"}', '2025-09-26 18:10:10'),
(242, 'asignacion', 41, 5, 'alta', NULL, NULL, '{\"aula_id\":9,\"fecha\":\"2025-09-26\",\"turno\":\"Vespertino\",\"carrera\":\"Zzzzzzz\",\"anio\":\"1\",\"profesor\":\"Zzzzzzzz\",\"materia\":\"Zzzzzzzz\",\"entidad_id\":3,\"hora_inicio\":\"17:00\",\"hora_fin\":\"18:00\",\"comentarios\":\"\"}', '2025-09-26 19:13:08'),
(243, 'asignacion', 42, 5, 'alta', NULL, NULL, '{\"aula_id\":5,\"fecha\":\"2025-09-26\",\"turno\":\"Vespertino\",\"carrera\":\"Aaaaaaa\",\"anio\":\"1\",\"profesor\":\"Aaaaaa\",\"materia\":\"Aaaaaaa\",\"entidad_id\":3,\"hora_inicio\":\"15:00\",\"hora_fin\":\"17:00\",\"comentarios\":\"\"}', '2025-09-26 19:13:55'),
(244, 'asignacion', 43, 5, 'alta', NULL, NULL, '{\"aula_id\":3,\"fecha\":\"2025-09-26\",\"turno\":\"Vespertino\",\"carrera\":\"Xxxxxx\",\"anio\":\"1\",\"profesor\":\"Xxxxx\",\"materia\":\"Xxxxxxx\",\"entidad_id\":3,\"hora_inicio\":\"14:00\",\"hora_fin\":\"15:00\",\"comentarios\":\"\"}', '2025-09-26 19:15:18'),
(245, 'asignacion', 44, 5, 'alta', NULL, NULL, '{\"aula_id\":3,\"fecha\":\"2025-09-26\",\"turno\":\"Vespertino\",\"carrera\":\"Xxxxxxxx\",\"anio\":\"1\",\"profesor\":\"Xxxxxxx\",\"materia\":\"Xxxxxxx\",\"entidad_id\":3,\"hora_inicio\":\"17:00\",\"hora_fin\":\"17:30\",\"comentarios\":\"\"}', '2025-09-26 19:16:10'),
(246, 'asignacion', 45, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-26\",\"turno\":\"Nocturno\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Patricio Freres\",\"materia\":\"Practicas Prof. Ii\",\"entidad_id\":3,\"hora_inicio\":\"19:00\",\"hora_fin\":\"22:00\",\"comentarios\":\"\"}', '2025-09-26 22:18:06'),
(247, 'asignacion', 45, 5, 'baja', NULL, '{\"Id\":45,\"turno\":\"Nocturno\",\"fecha\":\"2025-09-26\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Patricio Freres\",\"materia\":\"Practicas Prof. Ii\",\"aula_id\":1,\"hora_inicio\":\"19:00:00\",\"hora_fin\":\"22:00:00\",\"entidad_id\":3,\"comentarios\":\"\"}', NULL, '2025-09-26 22:20:18'),
(248, 'asignacion', 46, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-01\",\"turno\":\"Nocturno\",\"carrera\":\"Sdgsdg\",\"anio\":\"2\",\"profesor\":\"Sdgsdg\",\"materia\":\"Sdgsdg\",\"entidad_id\":4,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-09-26 22:21:09'),
(249, 'asignacion', 47, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-08\",\"turno\":\"Nocturno\",\"carrera\":\"Sdgsdg\",\"anio\":\"2\",\"profesor\":\"Sdgsdg\",\"materia\":\"Sdgsdg\",\"entidad_id\":4,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-09-26 22:21:10'),
(250, 'asignacion', 48, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-15\",\"turno\":\"Nocturno\",\"carrera\":\"Sdgsdg\",\"anio\":\"2\",\"profesor\":\"Sdgsdg\",\"materia\":\"Sdgsdg\",\"entidad_id\":4,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-09-26 22:21:11'),
(251, 'asignacion', 49, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-22\",\"turno\":\"Nocturno\",\"carrera\":\"Sdgsdg\",\"anio\":\"2\",\"profesor\":\"Sdgsdg\",\"materia\":\"Sdgsdg\",\"entidad_id\":4,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-09-26 22:21:12'),
(252, 'asignacion', 50, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-29\",\"turno\":\"Nocturno\",\"carrera\":\"Sdgsdg\",\"anio\":\"2\",\"profesor\":\"Sdgsdg\",\"materia\":\"Sdgsdg\",\"entidad_id\":4,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-09-26 22:21:14'),
(253, 'asignacion', 51, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-10-06\",\"turno\":\"Nocturno\",\"carrera\":\"Sdgsdg\",\"anio\":\"2\",\"profesor\":\"Sdgsdg\",\"materia\":\"Sdgsdg\",\"entidad_id\":4,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-09-26 22:21:15'),
(254, 'asignacion', 52, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-10-13\",\"turno\":\"Nocturno\",\"carrera\":\"Sdgsdg\",\"anio\":\"2\",\"profesor\":\"Sdgsdg\",\"materia\":\"Sdgsdg\",\"entidad_id\":4,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-09-26 22:21:17'),
(255, 'asignacion', 53, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-10-20\",\"turno\":\"Nocturno\",\"carrera\":\"Sdgsdg\",\"anio\":\"2\",\"profesor\":\"Sdgsdg\",\"materia\":\"Sdgsdg\",\"entidad_id\":4,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-09-26 22:21:19'),
(256, 'asignacion', 54, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-10-27\",\"turno\":\"Nocturno\",\"carrera\":\"Sdgsdg\",\"anio\":\"2\",\"profesor\":\"Sdgsdg\",\"materia\":\"Sdgsdg\",\"entidad_id\":4,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-09-26 22:21:20'),
(257, 'asignacion', 55, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-11-03\",\"turno\":\"Nocturno\",\"carrera\":\"Sdgsdg\",\"anio\":\"2\",\"profesor\":\"Sdgsdg\",\"materia\":\"Sdgsdg\",\"entidad_id\":4,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-09-26 22:21:22'),
(258, 'asignacion', 56, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-11-10\",\"turno\":\"Nocturno\",\"carrera\":\"Sdgsdg\",\"anio\":\"2\",\"profesor\":\"Sdgsdg\",\"materia\":\"Sdgsdg\",\"entidad_id\":4,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-09-26 22:21:23'),
(259, 'asignacion', 57, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-11-17\",\"turno\":\"Nocturno\",\"carrera\":\"Sdgsdg\",\"anio\":\"2\",\"profesor\":\"Sdgsdg\",\"materia\":\"Sdgsdg\",\"entidad_id\":4,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-09-26 22:21:24'),
(260, 'asignacion', 58, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-11-24\",\"turno\":\"Nocturno\",\"carrera\":\"Sdgsdg\",\"anio\":\"2\",\"profesor\":\"Sdgsdg\",\"materia\":\"Sdgsdg\",\"entidad_id\":4,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-09-26 22:21:26'),
(261, 'asignacion', 59, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-12-01\",\"turno\":\"Nocturno\",\"carrera\":\"Sdgsdg\",\"anio\":\"2\",\"profesor\":\"Sdgsdg\",\"materia\":\"Sdgsdg\",\"entidad_id\":4,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-09-26 22:21:27'),
(262, 'asignacion', 60, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-12-08\",\"turno\":\"Nocturno\",\"carrera\":\"Sdgsdg\",\"anio\":\"2\",\"profesor\":\"Sdgsdg\",\"materia\":\"Sdgsdg\",\"entidad_id\":4,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-09-26 22:21:28'),
(263, 'asignacion', 61, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-12-15\",\"turno\":\"Nocturno\",\"carrera\":\"Sdgsdg\",\"anio\":\"2\",\"profesor\":\"Sdgsdg\",\"materia\":\"Sdgsdg\",\"entidad_id\":4,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-09-26 22:21:29'),
(264, 'asignacion', 62, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-12-22\",\"turno\":\"Nocturno\",\"carrera\":\"Sdgsdg\",\"anio\":\"2\",\"profesor\":\"Sdgsdg\",\"materia\":\"Sdgsdg\",\"entidad_id\":4,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-09-26 22:21:31'),
(265, 'asignacion', 63, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-12-29\",\"turno\":\"Nocturno\",\"carrera\":\"Sdgsdg\",\"anio\":\"2\",\"profesor\":\"Sdgsdg\",\"materia\":\"Sdgsdg\",\"entidad_id\":4,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-09-26 22:21:33'),
(266, 'asignacion', 49, 5, '', NULL, '{\"repeticion\":\"cuatrimestral\",\"plantilla\":{\"Id\":49,\"turno\":\"Nocturno\",\"fecha\":\"2025-09-22\",\"carrera\":\"Sdgsdg\",\"anio\":\"2\",\"profesor\":\"Sdgsdg\",\"materia\":\"Sdgsdg\",\"aula_id\":1,\"hora_inicio\":\"18:00:00\",\"hora_fin\":\"20:00:00\",\"entidad_id\":4,\"comentarios\":\"\"},\"eliminadas\":18}', NULL, '2025-09-26 22:23:59'),
(267, 'asignacion', 37, 5, 'baja', NULL, '{\"Id\":37,\"turno\":\"Vespertino\",\"fecha\":\"2025-09-26\",\"carrera\":\"Sdgfsdgf\",\"anio\":\"1A\",\"profesor\":\"Sdfgsdgf\",\"materia\":\"Sdfgsd\",\"aula_id\":1,\"hora_inicio\":\"14:30:00\",\"hora_fin\":\"16:00:00\",\"entidad_id\":6,\"comentarios\":\"sdfsd\"}', NULL, '2025-09-26 22:34:06'),
(268, 'asignacion', 38, 5, 'baja', NULL, '{\"Id\":38,\"turno\":\"Vespertino\",\"fecha\":\"2025-09-26\",\"carrera\":\"Asdfas\",\"anio\":\"1A\",\"profesor\":\"Asfdas\",\"materia\":\"Asfdasfd\",\"aula_id\":2,\"hora_inicio\":\"13:00:00\",\"hora_fin\":\"14:00:00\",\"entidad_id\":4,\"comentarios\":\"\"}', NULL, '2025-09-26 22:34:19'),
(269, 'asignacion', 43, 5, 'baja', NULL, '{\"Id\":43,\"turno\":\"Vespertino\",\"fecha\":\"2025-09-26\",\"carrera\":\"Xxxxxx\",\"anio\":\"1\",\"profesor\":\"Xxxxx\",\"materia\":\"Xxxxxxx\",\"aula_id\":3,\"hora_inicio\":\"14:00:00\",\"hora_fin\":\"15:00:00\",\"entidad_id\":3,\"comentarios\":\"\"}', NULL, '2025-09-26 22:34:39'),
(270, 'asignacion', 40, 5, 'baja', NULL, '{\"Id\":40,\"turno\":\"Vespertino\",\"fecha\":\"2025-09-26\",\"carrera\":\"Sdfgsd\",\"anio\":\"1A\",\"profesor\":\"Sdgfs\",\"materia\":\"Sdfgsd\",\"aula_id\":4,\"hora_inicio\":\"15:11:00\",\"hora_fin\":\"17:00:00\",\"entidad_id\":5,\"comentarios\":\"\"}', NULL, '2025-09-26 22:34:46'),
(271, 'asignacion', 42, 5, 'baja', NULL, '{\"Id\":42,\"turno\":\"Vespertino\",\"fecha\":\"2025-09-26\",\"carrera\":\"Aaaaaaa\",\"anio\":\"1\",\"profesor\":\"Aaaaaa\",\"materia\":\"Aaaaaaa\",\"aula_id\":5,\"hora_inicio\":\"15:00:00\",\"hora_fin\":\"17:00:00\",\"entidad_id\":3,\"comentarios\":\"\"}', NULL, '2025-09-26 22:34:55'),
(272, 'asignacion', 39, 5, 'baja', NULL, '{\"Id\":39,\"turno\":\"Vespertino\",\"fecha\":\"2025-09-26\",\"carrera\":\"Asdf\",\"anio\":\"1\",\"profesor\":\"Sdfg\",\"materia\":\"Asdfa\",\"aula_id\":3,\"hora_inicio\":\"15:08:00\",\"hora_fin\":\"17:00:00\",\"entidad_id\":2,\"comentarios\":\"\"}', NULL, '2025-09-26 22:35:18'),
(273, 'asignacion', 41, 5, 'baja', NULL, '{\"Id\":41,\"turno\":\"Vespertino\",\"fecha\":\"2025-09-26\",\"carrera\":\"Zzzzzzz\",\"anio\":\"1\",\"profesor\":\"Zzzzzzzz\",\"materia\":\"Zzzzzzzz\",\"aula_id\":9,\"hora_inicio\":\"17:00:00\",\"hora_fin\":\"18:00:00\",\"entidad_id\":3,\"comentarios\":\"\"}', NULL, '2025-09-26 22:35:29'),
(274, 'asignacion', 44, 5, 'baja', NULL, '{\"Id\":44,\"turno\":\"Vespertino\",\"fecha\":\"2025-09-26\",\"carrera\":\"Xxxxxxxx\",\"anio\":\"1\",\"profesor\":\"Xxxxxxx\",\"materia\":\"Xxxxxxx\",\"aula_id\":3,\"hora_inicio\":\"17:00:00\",\"hora_fin\":\"17:30:00\",\"entidad_id\":3,\"comentarios\":\"\"}', NULL, '2025-09-26 22:35:42'),
(275, 'asignacion', 64, 5, 'alta', NULL, NULL, '{\"aula_id\":10,\"fecha\":\"2025-09-26\",\"turno\":\"Nocturno\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Patricio Freres\",\"materia\":\"Practicas Prof. Ii\",\"entidad_id\":3,\"hora_inicio\":\"19:00\",\"hora_fin\":\"22:00\",\"comentarios\":\"\"}', '2025-09-26 22:49:56'),
(276, 'asignacion', 65, 5, 'alta', NULL, NULL, '{\"aula_id\":9,\"fecha\":\"2025-09-26\",\"turno\":\"Nocturno\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"1\",\"profesor\":\"Profe\",\"materia\":\"Programación C\",\"entidad_id\":3,\"hora_inicio\":\"20:00\",\"hora_fin\":\"22:00\",\"comentarios\":\"\"}', '2025-09-26 22:51:14'),
(277, 'asignacion', 66, 5, 'alta', NULL, NULL, '{\"aula_id\":5,\"fecha\":\"2025-09-26\",\"turno\":\"Nocturno\",\"carrera\":\"Enfermeria\",\"anio\":\"1\",\"profesor\":\"Profe\",\"materia\":\"Rcp\",\"entidad_id\":4,\"hora_inicio\":\"18:00\",\"hora_fin\":\"22:00\",\"comentarios\":\"\"}', '2025-09-26 22:52:01'),
(278, 'asignacion', 67, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-09-26\",\"turno\":\"Nocturno\",\"carrera\":\"Sdfsdf\",\"anio\":\"2\",\"profesor\":\"Pepito\",\"materia\":\"Blabla\",\"entidad_id\":5,\"hora_inicio\":\"18:00\",\"hora_fin\":\"21:00\",\"comentarios\":\"\"}', '2025-09-26 22:52:47'),
(279, 'asignacion', 68, 5, 'alta', NULL, NULL, '{\"aula_id\":6,\"fecha\":\"2025-09-26\",\"turno\":\"Nocturno\",\"carrera\":\"Asdas\",\"anio\":\"1\",\"profesor\":\"Dfgsg\",\"materia\":\"Dsfsdf\",\"entidad_id\":2,\"hora_inicio\":\"20:00\",\"hora_fin\":\"22:00\",\"comentarios\":\"\"}', '2025-09-26 22:53:55'),
(280, 'asignacion', 69, 5, 'alta', NULL, NULL, '{\"aula_id\":4,\"fecha\":\"2025-09-26\",\"turno\":\"Nocturno\",\"carrera\":\"Dfsdf\",\"anio\":\"2\",\"profesor\":\"Wwe\",\"materia\":\"Sfgsg\",\"entidad_id\":6,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-09-26 22:56:07'),
(281, 'asignacion', 67, 5, 'modificacion', 'hora_inicio', '18:00:00', '19:00', '2025-09-26 23:09:53'),
(282, 'entidad', 105, 5, 'alta', NULL, NULL, '{\"nombre\":\"qwe\",\"color\":\"#2cc9b6\"}', '2025-09-26 23:11:24'),
(283, 'entidad', 105, 5, 'baja', NULL, '{\"nombre\":\"qwe\",\"color\":\"#2cc9b6\"}', NULL, '2025-09-26 23:11:59'),
(284, 'asignacion', 70, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-10-22\",\"turno\":\"Vespertino\",\"carrera\":\"Tecnicatura Superior en Desarrollo de Software\",\"anio\":\"1\",\"profesor\":\"Nkjsfnkj\",\"materia\":\"Base de Datos\",\"entidad_id\":3,\"hora_inicio\":\"13:00\",\"hora_fin\":\"17:00\",\"comentarios\":\"\"}', '2025-09-26 23:27:45'),
(285, 'asignacion', 71, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-10-03\",\"turno\":\"Matutino\",\"carrera\":\"Practicas Iii\",\"anio\":\"2\",\"profesor\":\"Sada\",\"materia\":\"Asda\",\"entidad_id\":3,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"asas\"}', '2025-10-03 22:26:49'),
(286, 'asignacion', 72, 5, 'alta', NULL, NULL, '{\"aula_id\":8,\"fecha\":\"2025-10-03\",\"turno\":\"Nocturno\",\"carrera\":\"Sdfsd\",\"anio\":\"1B\",\"profesor\":\"Sdfs\",\"materia\":\"Dsfsd\",\"entidad_id\":4,\"hora_inicio\":\"20:02\",\"hora_fin\":\"22:00\",\"comentarios\":\"\"}', '2025-10-03 22:27:42'),
(287, 'entidad', 106, 5, 'alta', NULL, NULL, '{\"nombre\":\"tgedfg\",\"color\":\"#2196f3\"}', '2025-10-10 10:48:08'),
(288, 'entidad', 106, 5, 'baja', NULL, '{\"nombre\":\"tgedfg\",\"color\":\"#2196f3\"}', NULL, '2025-10-10 10:48:18'),
(289, 'entidad', 107, 5, 'alta', NULL, NULL, '{\"nombre\":\"sdfsdgf\",\"color\":\"#2196f3\"}', '2025-10-10 10:51:45'),
(290, 'entidad', 107, 5, 'baja', NULL, '{\"nombre\":\"sdfsdgf\",\"color\":\"#2196f3\"}', NULL, '2025-10-10 10:51:55'),
(291, 'asignacion', 73, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-10-06\",\"turno\":\"Vespertino\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Carla Colna\",\"materia\":\"Programacion Orientada a Objetos\",\"entidad_id\":3,\"hora_inicio\":\"16:00\",\"hora_fin\":\"18:00\",\"comentarios\":\"\"}', '2025-10-10 21:47:39'),
(292, 'asignacion', 74, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-10-13\",\"turno\":\"Vespertino\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Carla Colna\",\"materia\":\"Programacion Orientada a Objetos\",\"entidad_id\":3,\"hora_inicio\":\"16:00\",\"hora_fin\":\"18:00\",\"comentarios\":\"\"}', '2025-10-10 21:47:40'),
(293, 'asignacion', 75, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-10-20\",\"turno\":\"Vespertino\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Carla Colna\",\"materia\":\"Programacion Orientada a Objetos\",\"entidad_id\":3,\"hora_inicio\":\"16:00\",\"hora_fin\":\"18:00\",\"comentarios\":\"\"}', '2025-10-10 21:47:40'),
(294, 'asignacion', 76, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-10-27\",\"turno\":\"Vespertino\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Carla Colna\",\"materia\":\"Programacion Orientada a Objetos\",\"entidad_id\":3,\"hora_inicio\":\"16:00\",\"hora_fin\":\"18:00\",\"comentarios\":\"\"}', '2025-10-10 21:47:41'),
(295, 'asignacion', 77, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-10-07\",\"turno\":\"Vespertino\",\"carrera\":\"Enfermeria\",\"anio\":\"2\",\"profesor\":\"a Designar\",\"materia\":\"a Designar\",\"entidad_id\":4,\"hora_inicio\":\"16:00\",\"hora_fin\":\"17:00\",\"comentarios\":\"\"}', '2025-10-10 21:49:21'),
(296, 'asignacion', 78, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-10-14\",\"turno\":\"Vespertino\",\"carrera\":\"Enfermeria\",\"anio\":\"2\",\"profesor\":\"a Designar\",\"materia\":\"a Designar\",\"entidad_id\":4,\"hora_inicio\":\"16:00\",\"hora_fin\":\"17:00\",\"comentarios\":\"\"}', '2025-10-10 21:49:22'),
(297, 'asignacion', 79, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-10-21\",\"turno\":\"Vespertino\",\"carrera\":\"Enfermeria\",\"anio\":\"2\",\"profesor\":\"a Designar\",\"materia\":\"a Designar\",\"entidad_id\":4,\"hora_inicio\":\"16:00\",\"hora_fin\":\"17:00\",\"comentarios\":\"\"}', '2025-10-10 21:49:22'),
(298, 'asignacion', 80, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-10-28\",\"turno\":\"Vespertino\",\"carrera\":\"Enfermeria\",\"anio\":\"2\",\"profesor\":\"a Designar\",\"materia\":\"a Designar\",\"entidad_id\":4,\"hora_inicio\":\"16:00\",\"hora_fin\":\"17:00\",\"comentarios\":\"\"}', '2025-10-10 21:49:23'),
(299, 'asignacion', 81, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-10-08\",\"turno\":\"Vespertino\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"3\",\"profesor\":\"a Designar\",\"materia\":\"Algoritmos y Estructuras de Datos\",\"entidad_id\":3,\"hora_inicio\":\"17:00\",\"hora_fin\":\"18:00\",\"comentarios\":\"\"}', '2025-10-10 21:51:31'),
(300, 'asignacion', 82, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-10-15\",\"turno\":\"Vespertino\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"3\",\"profesor\":\"a Designar\",\"materia\":\"Algoritmos y Estructuras de Datos\",\"entidad_id\":3,\"hora_inicio\":\"17:00\",\"hora_fin\":\"18:00\",\"comentarios\":\"\"}', '2025-10-10 21:51:32'),
(301, 'asignacion', 83, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-10-22\",\"turno\":\"Vespertino\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"3\",\"profesor\":\"a Designar\",\"materia\":\"Algoritmos y Estructuras de Datos\",\"entidad_id\":3,\"hora_inicio\":\"17:00\",\"hora_fin\":\"18:00\",\"comentarios\":\"\"}', '2025-10-10 21:51:33'),
(302, 'asignacion', 84, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-10-29\",\"turno\":\"Vespertino\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"3\",\"profesor\":\"a Designar\",\"materia\":\"Algoritmos y Estructuras de Datos\",\"entidad_id\":3,\"hora_inicio\":\"17:00\",\"hora_fin\":\"18:00\",\"comentarios\":\"\"}', '2025-10-10 21:51:34'),
(303, 'asignacion', 85, 5, 'alta', NULL, NULL, '{\"aula_id\":2,\"fecha\":\"2025-10-09\",\"turno\":\"Vespertino\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Ines del Castillo\",\"materia\":\"Python\",\"entidad_id\":3,\"hora_inicio\":\"15:00\",\"hora_fin\":\"17:00\",\"comentarios\":\"\"}', '2025-10-10 21:52:58'),
(304, 'asignacion', 86, 5, 'alta', NULL, NULL, '{\"aula_id\":2,\"fecha\":\"2025-10-16\",\"turno\":\"Vespertino\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Ines del Castillo\",\"materia\":\"Python\",\"entidad_id\":3,\"hora_inicio\":\"15:00\",\"hora_fin\":\"17:00\",\"comentarios\":\"\"}', '2025-10-10 21:52:59'),
(305, 'asignacion', 87, 5, 'alta', NULL, NULL, '{\"aula_id\":2,\"fecha\":\"2025-10-23\",\"turno\":\"Vespertino\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Ines del Castillo\",\"materia\":\"Python\",\"entidad_id\":3,\"hora_inicio\":\"15:00\",\"hora_fin\":\"17:00\",\"comentarios\":\"\"}', '2025-10-10 21:52:59'),
(306, 'asignacion', 88, 5, 'alta', NULL, NULL, '{\"aula_id\":2,\"fecha\":\"2025-10-30\",\"turno\":\"Vespertino\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Ines del Castillo\",\"materia\":\"Python\",\"entidad_id\":3,\"hora_inicio\":\"15:00\",\"hora_fin\":\"17:00\",\"comentarios\":\"\"}', '2025-10-10 21:53:00'),
(307, 'asignacion', 89, 5, 'alta', NULL, NULL, '{\"aula_id\":3,\"fecha\":\"2025-10-10\",\"turno\":\"Vespertino\",\"carrera\":\"a Designar\",\"anio\":\"1\",\"profesor\":\"a Designar\",\"materia\":\"a Designar\",\"entidad_id\":5,\"hora_inicio\":\"15:00\",\"hora_fin\":\"18:00\",\"comentarios\":\"\"}', '2025-10-10 21:53:43'),
(308, 'asignacion', 90, 5, 'alta', NULL, NULL, '{\"aula_id\":3,\"fecha\":\"2025-10-17\",\"turno\":\"Vespertino\",\"carrera\":\"a Designar\",\"anio\":\"1\",\"profesor\":\"a Designar\",\"materia\":\"a Designar\",\"entidad_id\":5,\"hora_inicio\":\"15:00\",\"hora_fin\":\"18:00\",\"comentarios\":\"\"}', '2025-10-10 21:53:43'),
(309, 'asignacion', 91, 5, 'alta', NULL, NULL, '{\"aula_id\":3,\"fecha\":\"2025-10-24\",\"turno\":\"Vespertino\",\"carrera\":\"a Designar\",\"anio\":\"1\",\"profesor\":\"a Designar\",\"materia\":\"a Designar\",\"entidad_id\":5,\"hora_inicio\":\"15:00\",\"hora_fin\":\"18:00\",\"comentarios\":\"\"}', '2025-10-10 21:53:44'),
(310, 'asignacion', 92, 5, 'alta', NULL, NULL, '{\"aula_id\":3,\"fecha\":\"2025-10-31\",\"turno\":\"Vespertino\",\"carrera\":\"a Designar\",\"anio\":\"1\",\"profesor\":\"a Designar\",\"materia\":\"a Designar\",\"entidad_id\":5,\"hora_inicio\":\"15:00\",\"hora_fin\":\"18:00\",\"comentarios\":\"\"}', '2025-10-10 21:53:45'),
(311, 'asignacion', 93, 5, 'alta', NULL, NULL, '{\"aula_id\":10,\"fecha\":\"2025-10-08\",\"turno\":\"Nocturno\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Ines del Castillo\",\"materia\":\"Python\",\"entidad_id\":3,\"hora_inicio\":\"19:00\",\"hora_fin\":\"22:00\",\"comentarios\":\"\"}', '2025-10-10 21:59:55'),
(312, 'asignacion', 94, 5, 'alta', NULL, NULL, '{\"aula_id\":10,\"fecha\":\"2025-10-15\",\"turno\":\"Nocturno\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Ines del Castillo\",\"materia\":\"Python\",\"entidad_id\":3,\"hora_inicio\":\"19:00\",\"hora_fin\":\"22:00\",\"comentarios\":\"\"}', '2025-10-10 21:59:56'),
(313, 'asignacion', 95, 5, 'alta', NULL, NULL, '{\"aula_id\":10,\"fecha\":\"2025-10-22\",\"turno\":\"Nocturno\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Ines del Castillo\",\"materia\":\"Python\",\"entidad_id\":3,\"hora_inicio\":\"19:00\",\"hora_fin\":\"22:00\",\"comentarios\":\"\"}', '2025-10-10 21:59:56'),
(314, 'asignacion', 96, 5, 'alta', NULL, NULL, '{\"aula_id\":10,\"fecha\":\"2025-10-29\",\"turno\":\"Nocturno\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Ines del Castillo\",\"materia\":\"Python\",\"entidad_id\":3,\"hora_inicio\":\"19:00\",\"hora_fin\":\"22:00\",\"comentarios\":\"\"}', '2025-10-10 21:59:57'),
(315, 'asignacion', 97, 5, 'alta', NULL, NULL, '{\"aula_id\":4,\"fecha\":\"2025-10-06\",\"turno\":\"Nocturno\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Carla Colina\",\"materia\":\"Programacion Orientada a Objetos\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"22:00\",\"comentarios\":\"\"}', '2025-10-10 22:01:01'),
(316, 'asignacion', 98, 5, 'alta', NULL, NULL, '{\"aula_id\":4,\"fecha\":\"2025-10-13\",\"turno\":\"Nocturno\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Carla Colina\",\"materia\":\"Programacion Orientada a Objetos\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"22:00\",\"comentarios\":\"\"}', '2025-10-10 22:01:01'),
(317, 'asignacion', 99, 5, 'alta', NULL, NULL, '{\"aula_id\":4,\"fecha\":\"2025-10-20\",\"turno\":\"Nocturno\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Carla Colina\",\"materia\":\"Programacion Orientada a Objetos\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"22:00\",\"comentarios\":\"\"}', '2025-10-10 22:01:02'),
(318, 'asignacion', 100, 5, 'alta', NULL, NULL, '{\"aula_id\":4,\"fecha\":\"2025-10-27\",\"turno\":\"Nocturno\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Carla Colina\",\"materia\":\"Programacion Orientada a Objetos\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"22:00\",\"comentarios\":\"\"}', '2025-10-10 22:01:03'),
(319, 'asignacion', 101, 5, 'alta', NULL, NULL, '{\"aula_id\":10,\"fecha\":\"2025-10-07\",\"turno\":\"Nocturno\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Mauro Ayala\",\"materia\":\"Diseño Web\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-10-10 22:02:26'),
(320, 'asignacion', 102, 5, 'alta', NULL, NULL, '{\"aula_id\":10,\"fecha\":\"2025-10-14\",\"turno\":\"Nocturno\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Mauro Ayala\",\"materia\":\"Diseño Web\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-10-10 22:02:27'),
(321, 'asignacion', 103, 5, 'alta', NULL, NULL, '{\"aula_id\":10,\"fecha\":\"2025-10-21\",\"turno\":\"Nocturno\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Mauro Ayala\",\"materia\":\"Diseño Web\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-10-10 22:02:28'),
(322, 'asignacion', 104, 5, 'alta', NULL, NULL, '{\"aula_id\":10,\"fecha\":\"2025-10-28\",\"turno\":\"Nocturno\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Mauro Ayala\",\"materia\":\"Diseño Web\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-10-10 22:02:29'),
(323, 'asignacion', 105, 5, 'alta', NULL, NULL, '{\"aula_id\":10,\"fecha\":\"2025-10-07\",\"turno\":\"Nocturno\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Matias Cerdeira\",\"materia\":\"Algebra y Logica\",\"entidad_id\":3,\"hora_inicio\":\"20:00\",\"hora_fin\":\"22:00\",\"comentarios\":\"\"}', '2025-10-10 22:03:21'),
(324, 'asignacion', 106, 5, 'alta', NULL, NULL, '{\"aula_id\":10,\"fecha\":\"2025-10-14\",\"turno\":\"Nocturno\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Matias Cerdeira\",\"materia\":\"Algebra y Logica\",\"entidad_id\":3,\"hora_inicio\":\"20:00\",\"hora_fin\":\"22:00\",\"comentarios\":\"\"}', '2025-10-10 22:03:22'),
(325, 'asignacion', 107, 5, 'alta', NULL, NULL, '{\"aula_id\":10,\"fecha\":\"2025-10-21\",\"turno\":\"Nocturno\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Matias Cerdeira\",\"materia\":\"Algebra y Logica\",\"entidad_id\":3,\"hora_inicio\":\"20:00\",\"hora_fin\":\"22:00\",\"comentarios\":\"\"}', '2025-10-10 22:03:23'),
(326, 'asignacion', 108, 5, 'alta', NULL, NULL, '{\"aula_id\":10,\"fecha\":\"2025-10-28\",\"turno\":\"Nocturno\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Matias Cerdeira\",\"materia\":\"Algebra y Logica\",\"entidad_id\":3,\"hora_inicio\":\"20:00\",\"hora_fin\":\"22:00\",\"comentarios\":\"\"}', '2025-10-10 22:03:24'),
(327, 'asignacion', 109, 5, 'alta', NULL, NULL, '{\"aula_id\":10,\"fecha\":\"2025-10-09\",\"turno\":\"Nocturno\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Elena Gonzalez\",\"materia\":\"Ingles\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-10-10 22:04:26'),
(328, 'asignacion', 110, 5, 'alta', NULL, NULL, '{\"aula_id\":10,\"fecha\":\"2025-10-16\",\"turno\":\"Nocturno\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Elena Gonzalez\",\"materia\":\"Ingles\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-10-10 22:04:27'),
(329, 'asignacion', 111, 5, 'alta', NULL, NULL, '{\"aula_id\":10,\"fecha\":\"2025-10-23\",\"turno\":\"Nocturno\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Elena Gonzalez\",\"materia\":\"Ingles\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-10-10 22:04:28'),
(330, 'asignacion', 112, 5, 'alta', NULL, NULL, '{\"aula_id\":10,\"fecha\":\"2025-10-30\",\"turno\":\"Nocturno\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Elena Gonzalez\",\"materia\":\"Ingles\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-10-10 22:04:28'),
(331, 'asignacion', 109, 5, '', NULL, '{\"repeticion\":\"mensual\",\"plantilla\":{\"Id\":109,\"turno\":\"Nocturno\",\"fecha\":\"2025-10-09\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Elena Gonzalez\",\"materia\":\"Ingles\",\"aula_id\":10,\"hora_inicio\":\"18:00:00\",\"hora_fin\":\"20:00:00\",\"entidad_id\":3,\"comentarios\":\"\"},\"eliminadas\":4}', NULL, '2025-10-10 22:04:56'),
(332, 'asignacion', 113, 5, 'alta', NULL, NULL, '{\"aula_id\":6,\"fecha\":\"2025-10-09\",\"turno\":\"Nocturno\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Elena Gonzalez\",\"materia\":\"Ingles\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-10-10 22:05:45'),
(333, 'asignacion', 114, 5, 'alta', NULL, NULL, '{\"aula_id\":6,\"fecha\":\"2025-10-16\",\"turno\":\"Nocturno\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Elena Gonzalez\",\"materia\":\"Ingles\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-10-10 22:05:46'),
(334, 'asignacion', 115, 5, 'alta', NULL, NULL, '{\"aula_id\":6,\"fecha\":\"2025-10-23\",\"turno\":\"Nocturno\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Elena Gonzalez\",\"materia\":\"Ingles\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-10-10 22:05:47'),
(335, 'asignacion', 116, 5, 'alta', NULL, NULL, '{\"aula_id\":6,\"fecha\":\"2025-10-30\",\"turno\":\"Nocturno\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Elena Gonzalez\",\"materia\":\"Ingles\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"20:00\",\"comentarios\":\"\"}', '2025-10-10 22:05:47'),
(336, 'asignacion', 117, 5, 'alta', NULL, NULL, '{\"aula_id\":6,\"fecha\":\"2025-10-09\",\"turno\":\"Nocturno\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Joaquin Delgado\",\"materia\":\"Desarrollo de Aplicaciones Moviles\",\"entidad_id\":3,\"hora_inicio\":\"20:00\",\"hora_fin\":\"22:00\",\"comentarios\":\"\"}', '2025-10-10 22:06:32'),
(337, 'asignacion', 118, 5, 'alta', NULL, NULL, '{\"aula_id\":6,\"fecha\":\"2025-10-16\",\"turno\":\"Nocturno\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Joaquin Delgado\",\"materia\":\"Desarrollo de Aplicaciones Moviles\",\"entidad_id\":3,\"hora_inicio\":\"20:00\",\"hora_fin\":\"22:00\",\"comentarios\":\"\"}', '2025-10-10 22:06:33');
INSERT INTO `auditoria_acciones` (`id`, `tipo_objeto`, `objeto_id`, `usuario_id`, `accion`, `campo_modificado`, `valor_anterior`, `valor_nuevo`, `fecha`) VALUES
(338, 'asignacion', 119, 5, 'alta', NULL, NULL, '{\"aula_id\":6,\"fecha\":\"2025-10-23\",\"turno\":\"Nocturno\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Joaquin Delgado\",\"materia\":\"Desarrollo de Aplicaciones Moviles\",\"entidad_id\":3,\"hora_inicio\":\"20:00\",\"hora_fin\":\"22:00\",\"comentarios\":\"\"}', '2025-10-10 22:06:34'),
(339, 'asignacion', 120, 5, 'alta', NULL, NULL, '{\"aula_id\":6,\"fecha\":\"2025-10-30\",\"turno\":\"Nocturno\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Joaquin Delgado\",\"materia\":\"Desarrollo de Aplicaciones Moviles\",\"entidad_id\":3,\"hora_inicio\":\"20:00\",\"hora_fin\":\"22:00\",\"comentarios\":\"\"}', '2025-10-10 22:06:35'),
(340, 'asignacion', 121, 5, 'alta', NULL, NULL, '{\"aula_id\":10,\"fecha\":\"2025-10-10\",\"turno\":\"Nocturno\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Joaquin Delgado\",\"materia\":\"Desarrollo de Aplicativos Moviles\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"19:00\",\"comentarios\":\"\"}', '2025-10-10 22:07:26'),
(341, 'asignacion', 122, 5, 'alta', NULL, NULL, '{\"aula_id\":10,\"fecha\":\"2025-10-17\",\"turno\":\"Nocturno\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Joaquin Delgado\",\"materia\":\"Desarrollo de Aplicativos Moviles\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"19:00\",\"comentarios\":\"\"}', '2025-10-10 22:07:27'),
(342, 'asignacion', 123, 5, 'alta', NULL, NULL, '{\"aula_id\":10,\"fecha\":\"2025-10-24\",\"turno\":\"Nocturno\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Joaquin Delgado\",\"materia\":\"Desarrollo de Aplicativos Moviles\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"19:00\",\"comentarios\":\"\"}', '2025-10-10 22:07:27'),
(343, 'asignacion', 124, 5, 'alta', NULL, NULL, '{\"aula_id\":10,\"fecha\":\"2025-10-31\",\"turno\":\"Nocturno\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Joaquin Delgado\",\"materia\":\"Desarrollo de Aplicativos Moviles\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"19:00\",\"comentarios\":\"\"}', '2025-10-10 22:07:28'),
(344, 'asignacion', 125, 5, 'alta', NULL, NULL, '{\"aula_id\":10,\"fecha\":\"2025-10-10\",\"turno\":\"Nocturno\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Patricio Feres\",\"materia\":\"Practicas Profesionalizantes\",\"entidad_id\":3,\"hora_inicio\":\"19:00\",\"hora_fin\":\"22:00\",\"comentarios\":\"\"}', '2025-10-10 22:08:08'),
(345, 'asignacion', 126, 5, 'alta', NULL, NULL, '{\"aula_id\":6,\"fecha\":\"2025-10-11\",\"turno\":\"Matutino\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Matias Cerdeira\",\"materia\":\"Probabilidad y Estadisticas\",\"entidad_id\":3,\"hora_inicio\":\"08:00\",\"hora_fin\":\"10:00\",\"comentarios\":\"\"}', '2025-10-10 22:09:17'),
(346, 'asignacion', 127, 5, 'alta', NULL, NULL, '{\"aula_id\":6,\"fecha\":\"2025-10-18\",\"turno\":\"Matutino\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Matias Cerdeira\",\"materia\":\"Probabilidad y Estadisticas\",\"entidad_id\":3,\"hora_inicio\":\"08:00\",\"hora_fin\":\"10:00\",\"comentarios\":\"\"}', '2025-10-10 22:09:18'),
(347, 'asignacion', 128, 5, 'alta', NULL, NULL, '{\"aula_id\":6,\"fecha\":\"2025-10-25\",\"turno\":\"Matutino\",\"carrera\":\"Desarrollo de Software\",\"anio\":\"2\",\"profesor\":\"Matias Cerdeira\",\"materia\":\"Probabilidad y Estadisticas\",\"entidad_id\":3,\"hora_inicio\":\"08:00\",\"hora_fin\":\"10:00\",\"comentarios\":\"\"}', '2025-10-10 22:09:19'),
(348, 'asignacion', 129, 5, 'alta', NULL, NULL, '{\"aula_id\":4,\"fecha\":\"2025-10-08\",\"turno\":\"Matutino\",\"carrera\":\"Ghjg\",\"anio\":\"1\",\"profesor\":\"Uhui\",\"materia\":\"Jklk\",\"entidad_id\":6,\"hora_inicio\":\"08:00\",\"hora_fin\":\"10:00\",\"comentarios\":\"\"}', '2025-10-11 02:09:05'),
(349, 'asignacion', 130, 5, 'alta', NULL, NULL, '{\"aula_id\":4,\"fecha\":\"2025-10-15\",\"turno\":\"Matutino\",\"carrera\":\"Ghjg\",\"anio\":\"1\",\"profesor\":\"Uhui\",\"materia\":\"Jklk\",\"entidad_id\":6,\"hora_inicio\":\"08:00\",\"hora_fin\":\"10:00\",\"comentarios\":\"\"}', '2025-10-11 02:09:06'),
(350, 'asignacion', 131, 5, 'alta', NULL, NULL, '{\"aula_id\":4,\"fecha\":\"2025-10-22\",\"turno\":\"Matutino\",\"carrera\":\"Ghjg\",\"anio\":\"1\",\"profesor\":\"Uhui\",\"materia\":\"Jklk\",\"entidad_id\":6,\"hora_inicio\":\"08:00\",\"hora_fin\":\"10:00\",\"comentarios\":\"\"}', '2025-10-11 02:09:07'),
(351, 'asignacion', 132, 5, 'alta', NULL, NULL, '{\"aula_id\":4,\"fecha\":\"2025-10-29\",\"turno\":\"Matutino\",\"carrera\":\"Ghjg\",\"anio\":\"1\",\"profesor\":\"Uhui\",\"materia\":\"Jklk\",\"entidad_id\":6,\"hora_inicio\":\"08:00\",\"hora_fin\":\"10:00\",\"comentarios\":\"\"}', '2025-10-11 02:09:07'),
(352, 'asignacion', 129, 5, '', NULL, '{\"repeticion\":\"mensual\",\"plantilla\":{\"Id\":129,\"turno\":\"Matutino\",\"fecha\":\"2025-10-08\",\"carrera\":\"Ghjg\",\"anio\":\"1\",\"profesor\":\"Uhui\",\"materia\":\"Jklk\",\"aula_id\":4,\"hora_inicio\":\"08:00:00\",\"hora_fin\":\"10:00:00\",\"entidad_id\":6,\"comentarios\":\"\"},\"eliminadas\":4}', NULL, '2025-10-11 02:11:15'),
(353, 'asignacion', 133, 5, 'alta', NULL, NULL, '{\"aula_id\":4,\"fecha\":\"2025-10-14\",\"turno\":\"Nocturno\",\"carrera\":\"Fiesta Marechal\",\"anio\":\"2\",\"profesor\":\"Emiliano\",\"materia\":\"Fiesta Marechal\",\"entidad_id\":3,\"hora_inicio\":\"18:00\",\"hora_fin\":\"21:00\",\"comentarios\":\"\"}', '2025-10-13 19:34:38'),
(354, 'asignacion', 134, 5, 'alta', NULL, NULL, '{\"aula_id\":1,\"fecha\":\"2025-10-13\",\"turno\":\"Nocturno\",\"carrera\":\"Sada\",\"anio\":\"1B\",\"profesor\":\"Asfa\",\"materia\":\"Asasfd\",\"entidad_id\":4,\"hora_inicio\":\"19:00\",\"hora_fin\":\"20:08\",\"comentarios\":\"\"}', '2025-10-13 23:06:19'),
(355, 'asignacion', 135, 5, 'alta', NULL, NULL, '{\"aula_id\":6,\"fecha\":\"2025-10-17\",\"turno\":\"Matutino\",\"carrera\":\"Saas\",\"anio\":\"1\",\"profesor\":\"Asdfas\",\"materia\":\"Asasdf\",\"entidad_id\":4,\"hora_inicio\":\"10:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-10-14 17:31:28'),
(356, 'asignacion', 135, 5, 'modificacion', 'carrera', 'Saas', 'Saasasdfas Asdasasdf', '2025-10-14 17:31:48'),
(357, 'asignacion', 136, 5, 'alta', NULL, NULL, '{\"aula_id\":6,\"fecha\":\"2025-10-16\",\"turno\":\"Matutino\",\"carrera\":\"Dfdfghdfdfd Dfhdfghdfghsd\",\"anio\":\"1A\",\"profesor\":\"Aasas Afasfasdf\",\"materia\":\"Sdfsadfasf\",\"entidad_id\":5,\"hora_inicio\":\"09:00\",\"hora_fin\":\"11:00\",\"comentarios\":\"\"}', '2025-10-14 17:32:07'),
(358, 'asignacion', 137, 5, 'alta', NULL, NULL, '{\"aula_id\":6,\"fecha\":\"2025-10-15\",\"turno\":\"Matutino\",\"carrera\":\"Sdfgsdgdfhgdf Dfhd\",\"anio\":\"1B\",\"profesor\":\"Wefwef\",\"materia\":\"Fdghdsfgwtgwe Wegf Wefwefgwefw\",\"entidad_id\":5,\"hora_inicio\":\"08:00\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-10-14 17:32:36'),
(359, 'asignacion', 138, 5, 'alta', NULL, NULL, '{\"aula_id\":6,\"fecha\":\"2025-10-14\",\"turno\":\"Matutino\",\"carrera\":\"Gsddfgsdgfs Sdgfsdgfsd\",\"anio\":\"2\",\"profesor\":\"Sdgfsdgfsdgf\",\"materia\":\"Sdfgsdfgsdfg Sdgfsdgfghghghsdgsd\",\"entidad_id\":2,\"hora_inicio\":\"07:10\",\"hora_fin\":\"12:00\",\"comentarios\":\"\"}', '2025-10-14 17:33:06'),
(360, 'asignacion', 139, 5, 'alta', NULL, NULL, '{\"aula_id\":6,\"fecha\":\"2025-10-13\",\"turno\":\"Matutino\",\"carrera\":\"Dgfhdfhgd Dfhdfhgdfhgd Fhgd Df Hg\",\"anio\":\"1A\",\"profesor\":\"Sdsdqwq Qfqqwwfqdqw Qwfqwdf\",\"materia\":\"Sdgfsdgfsd\",\"entidad_id\":2,\"hora_inicio\":\"07:00\",\"hora_fin\":\"09:00\",\"comentarios\":\"\"}', '2025-10-14 17:33:33'),
(361, 'asignacion', 139, 5, 'baja', NULL, '{\"Id\":139,\"turno\":\"Matutino\",\"fecha\":\"2025-10-13\",\"carrera\":\"Dgfhdfhgd Dfhdfhgdfhgd Fhgd Df Hg\",\"anio\":\"1A\",\"profesor\":\"Sdsdqwq Qfqqwwfqdqw Qwfqwdf\",\"materia\":\"Sdgfsdgfsd\",\"aula_id\":6,\"hora_inicio\":\"07:00:00\",\"hora_fin\":\"09:00:00\",\"entidad_id\":2,\"comentarios\":\"\"}', NULL, '2025-10-14 17:33:47'),
(362, 'asignacion', 138, 5, 'baja', NULL, '{\"Id\":138,\"turno\":\"Matutino\",\"fecha\":\"2025-10-14\",\"carrera\":\"Gsddfgsdgfs Sdgfsdgfsd\",\"anio\":\"2\",\"profesor\":\"Sdgfsdgfsdgf\",\"materia\":\"Sdfgsdfgsdfg Sdgfsdgfghghghsdgsd\",\"aula_id\":6,\"hora_inicio\":\"07:10:00\",\"hora_fin\":\"12:00:00\",\"entidad_id\":2,\"comentarios\":\"\"}', NULL, '2025-10-14 17:33:51'),
(363, 'asignacion', 137, 5, 'baja', NULL, '{\"Id\":137,\"turno\":\"Matutino\",\"fecha\":\"2025-10-15\",\"carrera\":\"Sdfgsdgdfhgdf Dfhd\",\"anio\":\"1B\",\"profesor\":\"Wefwef\",\"materia\":\"Fdghdsfgwtgwe Wegf Wefwefgwefw\",\"aula_id\":6,\"hora_inicio\":\"08:00:00\",\"hora_fin\":\"12:00:00\",\"entidad_id\":5,\"comentarios\":\"\"}', NULL, '2025-10-14 17:33:57'),
(364, 'asignacion', 136, 5, 'baja', NULL, '{\"Id\":136,\"turno\":\"Matutino\",\"fecha\":\"2025-10-16\",\"carrera\":\"Dfdfghdfdfd Dfhdfghdfghsd\",\"anio\":\"1A\",\"profesor\":\"Aasas Afasfasdf\",\"materia\":\"Sdfsadfasf\",\"aula_id\":6,\"hora_inicio\":\"09:00:00\",\"hora_fin\":\"11:00:00\",\"entidad_id\":5,\"comentarios\":\"\"}', NULL, '2025-10-14 17:34:01'),
(365, 'asignacion', 140, 5, 'alta', NULL, NULL, '{\"aula_id\":6,\"fecha\":\"2025-10-17\",\"turno\":\"Matutino\",\"carrera\":\"Sdsdfg\",\"anio\":\"1\",\"profesor\":\"Dfdfgsdf\",\"materia\":\"Dsfgsdgf\",\"entidad_id\":3,\"hora_inicio\":\"08:00\",\"hora_fin\":\"10:00\",\"comentarios\":\"\"}', '2025-10-14 17:34:24'),
(366, 'asignacion', 140, 5, 'baja', NULL, '{\"Id\":140,\"turno\":\"Matutino\",\"fecha\":\"2025-10-17\",\"carrera\":\"Sdsdfg\",\"anio\":\"1\",\"profesor\":\"Dfdfgsdf\",\"materia\":\"Dsfgsdgf\",\"aula_id\":6,\"hora_inicio\":\"08:00:00\",\"hora_fin\":\"10:00:00\",\"entidad_id\":3,\"comentarios\":\"\"}', NULL, '2025-10-14 17:34:41'),
(367, 'asignacion', 135, 5, 'baja', NULL, '{\"Id\":135,\"turno\":\"Matutino\",\"fecha\":\"2025-10-17\",\"carrera\":\"Saasasdfas Asdasasdf\",\"anio\":\"1\",\"profesor\":\"Asdfas\",\"materia\":\"Asasdf\",\"aula_id\":6,\"hora_inicio\":\"10:00:00\",\"hora_fin\":\"12:00:00\",\"entidad_id\":4,\"comentarios\":\"\"}', NULL, '2025-10-14 17:34:47');

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
(10, 14, 'TV'),
(11, 6, 'Pantalla interactiva');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservas`
--

CREATE TABLE `reservas` (
  `id` int(11) NOT NULL,
  `tipo_reserva` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1: Aula, 2: Laboratorio, 3: Kit TV',
  `fecha` date NOT NULL,
  `entidad_id` int(11) NOT NULL,
  `aula_id` int(11) DEFAULT NULL,
  `carrera` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `anio` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `materia` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `profesor` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fin` time NOT NULL,
  `telefono_contacto` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `cantidad_pc` int(11) DEFAULT NULL COMMENT 'Para Laboratorio Ambulante',
  `comentarios` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `timestamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `eliminado` tinyint(1) NOT NULL DEFAULT '0',
  `notificada` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci TABLESPACE `cruvei_asignaciones`;

--
-- Volcado de datos para la tabla `reservas`
--

INSERT INTO `reservas` (`id`, `tipo_reserva`, `fecha`, `entidad_id`, `aula_id`, `carrera`, `anio`, `materia`, `profesor`, `hora_inicio`, `hora_fin`, `telefono_contacto`, `cantidad_pc`, `comentarios`, `timestamp`, `eliminado`, `notificada`) VALUES
(1, 1, '2025-11-10', 3, NULL, 'lplpasd', '3', 'asdasdasdas', 'asdasd', '18:00:00', '22:00:00', '1162648300', NULL, 'prueba', '2025-09-19 22:07:52', 1, 1),
(2, 1, '2025-10-20', 4, NULL, 'aaaaaaa', '3', '333333', 'dddddddd', '19:00:00', '22:00:00', '113335647', NULL, 'va bien', '2025-09-19 22:24:48', 1, 1),
(3, 1, '2025-08-09', 4, NULL, 'asdas', 'asdfas', 'dsafsadf', 'sdfsdf', '10:00:00', '12:00:00', '231231243', NULL, 'wdfsfsfs', '2025-09-19 22:26:46', 1, 1),
(4, 1, '2025-10-05', 3, NULL, 'sosguar', '3', 'aaaaaa', 'eeeee', '21:00:00', '22:00:00', '1162648300', NULL, 'SDFSDFSDF', '2025-09-20 00:14:08', 1, 1),
(5, 1, '2025-09-27', 4, NULL, 'Ingenieria Informatica', '2', 'uygg', 'jose sanchez', '10:00:00', '12:30:00', '154384997', NULL, 'proyector ', '2025-09-26 22:39:53', 0, 1),
(6, 3, '2025-10-14', 3, NULL, 'Desarrollo de Software', '3', 'truco', 'dieguito', '19:00:00', '22:00:00', '12121212121', NULL, 'asdjiasjdijasdasd', '2025-10-11 00:01:47', 0, 1),
(7, 2, '2025-10-16', 6, NULL, 'qwwqe', '2', 'Practicas Profesionalizantes II', 'Hernan Ledesma', '21:00:00', '22:00:00', '333333333', 5, 'son cinco, no 3', '2025-10-11 00:03:18', 1, 1),
(8, 1, '2025-10-15', 4, NULL, 'sdasd', '5', 'cataclismo', 'Patricio Feres', '16:00:00', '18:00:00', '444444', NULL, 'verrrrrrrrr', '2025-10-11 00:04:32', 1, 1),
(9, 1, '2025-10-29', 4, 6, 'qwwqe', '3', 'truco', 'Hernan Ledesma', '21:00:00', '22:00:00', 'tytytytyt', NULL, 'lo puse mal', '2025-10-11 00:26:12', 0, 1),
(10, 1, '2025-11-03', 3, 13, 'qwwqe', '2', 'truco', 'pepe', '21:00:00', '22:00:00', '34234234', NULL, 'otro para ver si el horario esta ok. son 21.32', '2025-10-11 00:32:18', 0, 1),
(11, 3, '2025-10-20', 1, NULL, 'Desarrollo de Software', '3', 'matematicas', 'otro', '12:00:00', '15:00:00', '666666666', NULL, 'no se tiene que ver la hora', '2025-10-11 00:35:03', 1, 1),
(15, 1, '2025-10-13', 1, 3, 'desarrollo', '2', 'c', 'pepeito', '10:00:00', '12:00:00', '123123123', NULL, 'guarda ya zorra', '2025-10-11 19:50:32', 1, 1),
(17, 1, '2025-10-16', 3, 1, 'asd', '1', 'asd', 'asdfas', '20:00:00', '13:00:00', '1231231243', NULL, 'ninguno', '2025-10-11 20:49:04', 0, 1),
(18, 1, '2025-10-16', 6, 1, 'sdasd', '3', 'asdasdf', 'asdasfd', '09:00:00', '12:00:00', '112431234', NULL, 'ninguno', '2025-10-11 20:52:01', 0, 1),
(19, 1, '2025-10-16', 3, 1, 'asd', '1', 'asfa', 'gfdsds', '10:00:00', '13:00:00', '123123', NULL, '', '2025-10-11 21:05:20', 1, 1),
(20, 1, '2025-10-08', 5, 1, 'asd', '2', 'qwe', 'sdfsfdg', '10:00:00', '11:00:00', '1231231', 4, '', '2025-10-11 21:10:31', 1, 1),
(21, 1, '2025-10-23', 6, 1, 'qwqe', '3', 'qwefd', 'ergfergfer', '10:05:00', '12:15:00', '23423521341', 5, '', '2025-10-11 21:18:59', 1, 1),
(22, 3, '2025-10-24', 6, 5, 'dwfwefwe', '1', 'sadqwedx', 'werfwef', '16:00:00', '18:00:00', '13241414', 0, '', '2025-10-11 21:19:35', 1, 1),
(23, 1, '2025-10-16', 4, 9, 'rtdfg', 'vv', 'fghfgh', 'tttttttt', '13:00:00', '14:00:00', 'gdfgdfgdfgfg', 55, '', '2025-10-13 21:08:27', 1, 1),
(24, 1, '2025-10-24', 3, 5, 'fyrfty', '3', 'ttttttgggg', 'kkkk', '13:00:00', '17:00:00', '111111', 0, '', '2025-10-13 21:10:36', 1, 1),
(25, 2, '2025-10-17', 3, 8, 'asd', '2', 'asdasdf', 'pep', '08:00:00', '10:00:00', '12123111', 10, '', '2025-10-14 12:35:55', 1, 1),
(26, 2, '2025-10-16', 3, 13, 'asasf', '3', 'sadasfd', 'asdas', '16:00:00', '18:00:00', '34111', 12, '', '2025-10-14 12:44:25', 1, 1),
(27, 2, '2025-10-16', 6, 6, 'asasdf', '2', 'sdfgsdgfs', 'asdqq', '08:00:00', '10:00:00', '123412431243', 12, '', '2025-10-14 13:04:52', 1, 1),
(28, 2, '2025-10-16', 6, 2, 'sdfasdf', '3', 'sasfdas', 'asfasfd', '08:00:00', '11:00:00', '1231231234', 123, '', '2025-10-14 13:19:12', 1, 1),
(29, 2, '2025-10-15', 4, 5, 'asdfasdf', '1', 'asdasdf', 'sdfgsdgf', '09:00:00', '10:00:00', '123123123', 12, '', '2025-10-14 13:21:21', 1, 1),
(30, 2, '2025-10-16', 6, 4, 'qwfdqdf', '1', 'asdfasfd', 'sdfsdgs', '10:00:00', '12:00:00', '12431241241', 12, '', '2025-10-14 13:42:52', 1, 1),
(31, 1, '2025-10-15', 6, 2, 'asdasdf', '2', 'asdfasfd', 'sdsdgsd', '14:00:00', '19:00:00', '12341241243', 0, '', '2025-10-14 18:29:15', 0, 1),
(32, 3, '2025-10-17', 5, 3, 'sdfafsa', '2', 'dsfasfd', 'asasdf', '18:00:00', '19:00:00', '12312412', 0, '', '2025-10-14 18:31:23', 0, 1),
(33, 1, '2025-10-22', 5, 3, 'asdfasdf', '2', 'asdasd', 'asadasdas', '15:00:00', '16:00:00', '123123123', 0, '', '2025-10-14 18:33:16', 1, 1),
(34, 1, '2025-10-21', 3, 3, 'asdasdfa', '3', 'asdfasdfa', 'asfasdf', '16:00:00', '17:00:00', '12312312', 0, '', '2025-10-14 18:38:59', 1, 1),
(35, 1, '2025-10-16', 4, 2, 'asasdf', '1', 'asdfasfd', 'sadfasdf', '16:00:00', '17:00:00', '1231234124', 0, '', '2025-10-14 18:40:13', 0, 1),
(36, 2, '2025-10-24', 1, 5, 'qwqfdqwd', '3', 'asfdasfd', 'qweq', '19:00:00', '20:00:00', '121231243124', 12, '', '2025-10-14 18:40:42', 0, 1),
(37, 3, '2025-10-30', 3, 5, 'wefgwefg', '1', 'qwedfqwedf', 'fsdfwef', '13:00:00', '15:00:00', '4124123123', 0, '', '2025-10-14 18:41:14', 0, 1),
(38, 1, '2025-10-14', 3, 13, 'sdfgwegf', '1', 'dsfasf', 'wetrwert', '13:00:00', '14:00:00', '12314124', 0, '', '2025-10-14 18:43:15', 0, 1);

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
(5, 'admin', '$2y$10$fRwUcZEkS6BzCVY2s74MqudlHoNUVycN5b5z/xhzftAcOhMeqtV86', 'admin', NULL, NULL),
(8, 'invitado', '$2y$10$Vib6EDAL201WYaqyqyCdr.0hFsrw6J5oWPmILed5.ZJPiVtc4G1fK', 'invitado', NULL, NULL),
(10, 'solicitante', '$2y$10$Pc4EN20ZD9YQDX3XbbgOiO3intUXxS1vPhokFYOtGF/Rp8bTtr2yO', 'invitado', NULL, NULL),
(16, 'usuario', '$2y$10$pXBfuMDxnc6GuRpwsOn2bO4RzQ/QhWk/3W/MTaDB8fPnsjgiV.Ebm', 'viewer', NULL, NULL);

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
  ADD KEY `entidad_id` (`entidad_id`),
  ADD KEY `fk_reservas_aula` (`aula_id`);

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
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=141;

--
-- AUTO_INCREMENT de la tabla `auditoria_acciones`
--
ALTER TABLE `auditoria_acciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=368;

--
-- AUTO_INCREMENT de la tabla `aulas`
--
ALTER TABLE `aulas`
  MODIFY `aula_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `entidades`
--
ALTER TABLE `entidades`
  MODIFY `entidad_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=108;

--
-- AUTO_INCREMENT de la tabla `recursos_por_aula`
--
ALTER TABLE `recursos_por_aula`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `reservas`
--
ALTER TABLE `reservas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

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
  ADD CONSTRAINT `fk_reservas_aula` FOREIGN KEY (`aula_id`) REFERENCES `aulas` (`aula_id`),
  ADD CONSTRAINT `reservas_ibfk_entidad` FOREIGN KEY (`entidad_id`) REFERENCES `entidades` (`entidad_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
