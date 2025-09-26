-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 10.123.0.78:3306
-- Tiempo de generación: 26-09-2025 a las 18:26:22
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
(37, 'Vespertino', '2025-09-26', 'Sdgfsdgf', '1A', 'Sdfgsdgf', 'Sdfgsd', 1, '14:30:00', '16:00:00', 6, 'sdfsd'),
(38, 'Vespertino', '2025-09-26', 'Asdfas', '1A', 'Asfdas', 'Asfdasfd', 2, '13:00:00', '14:00:00', 4, ''),
(39, 'Vespertino', '2025-09-26', 'Asdf', '1', 'Sdfg', 'Asdfa', 3, '15:08:00', '17:00:00', 2, ''),
(40, 'Vespertino', '2025-09-26', 'Sdfgsd', '1A', 'Sdgfs', 'Sdfgsd', 4, '15:11:00', '17:00:00', 5, '');

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
(241, 'asignacion', 40, 5, 'alta', NULL, NULL, '{\"aula_id\":4,\"fecha\":\"2025-09-26\",\"turno\":\"Vespertino\",\"carrera\":\"Sdfgsd\",\"anio\":\"1A\",\"profesor\":\"Sdgfs\",\"materia\":\"Sdfgsd\",\"entidad_id\":5,\"hora_inicio\":\"15:11\",\"hora_fin\":\"17:00\",\"comentarios\":\"\"}', '2025-09-26 18:10:10');

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
  `timestamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `eliminado` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci TABLESPACE `cruvei_asignaciones`;

--
-- Volcado de datos para la tabla `reservas`
--

INSERT INTO `reservas` (`id`, `fecha`, `entidad_id`, `carrera`, `anio`, `materia`, `profesor`, `hora_inicio`, `hora_fin`, `telefono_contacto`, `comentarios`, `timestamp`, `eliminado`) VALUES
(1, '2025-11-10', 3, 'lplpasd', '3', 'asdasdasdas', 'asdasd', '18:00:00', '22:00:00', '1162648300', 'prueba', '2025-09-19 22:07:52', 1),
(2, '2025-10-20', 4, 'aaaaaaa', '3', '333333', 'dddddddd', '19:00:00', '22:00:00', '113335647', 'va bien', '2025-09-19 22:24:48', 1),
(3, '2025-08-09', 4, 'asdas', 'asdfas', 'dsafsadf', 'sdfsdf', '10:00:00', '12:00:00', '231231243', 'wdfsfsfs', '2025-09-19 22:26:46', 1),
(4, '2025-10-05', 3, 'sosguar', '3', 'aaaaaa', 'eeeee', '21:00:00', '22:00:00', '1162648300', 'SDFSDFSDF', '2025-09-20 00:14:08', 1);

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
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT de la tabla `auditoria_acciones`
--
ALTER TABLE `auditoria_acciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=242;

--
-- AUTO_INCREMENT de la tabla `aulas`
--
ALTER TABLE `aulas`
  MODIFY `aula_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `entidades`
--
ALTER TABLE `entidades`
  MODIFY `entidad_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;

--
-- AUTO_INCREMENT de la tabla `recursos_por_aula`
--
ALTER TABLE `recursos_por_aula`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `reservas`
--
ALTER TABLE `reservas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
  ADD CONSTRAINT `reservas_ibfk_entidad` FOREIGN KEY (`entidad_id`) REFERENCES `entidades` (`entidad_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
