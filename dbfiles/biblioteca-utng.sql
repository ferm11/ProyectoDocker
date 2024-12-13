
ALTER USER 'admin'@'%' IDENTIFIED WITH mysql_native_password BY 'admin';
FLUSH PRIVILEGES;

Use bibliotecautng

CREATE TABLE `Ejemplar` (
  `ISBN` varchar(50) DEFAULT NULL,
  `idEjemplar` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `Ejemplar`
--

INSERT INTO `Ejemplar` (`ISBN`, `idEjemplar`) VALUES
(1234567890, 1),
(1234567899, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Libro`
--

CREATE TABLE `Libro` (
  `ISBN` varchar(50) NOT NULL,
  `titulo` varchar(50) NOT NULL,
  `autores` varchar(100) NOT NULL,
  `fPublicacion` varchar(15) NOT NULL,
  `editorial` varchar(100) NOT NULL,
  `cantEjemplares` int DEFAULT NULL,
  `categoria` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `Libro`
--

INSERT INTO `Libro` (`ISBN`, `titulo`, `autores`, `fPublicacion`, `editorial`, `cantEjemplares`, `categoria`) VALUES
(1234567890, 'Caperucita Roja', 'J. Grimm , Wilhelm Grimm', '1982-05-05', 'Los hermanos Grimm', 1, 'Infantil'),
(1234567899, 'Cien años de soledad', 'Gabriel García Márquez', '1967-09-13', 'Sudamericana', 1, 'Aventura'),
(1414131200, 'El Principito', 'Antoine de Saint-Exupéry', '1988-01-22', 'Reynal & Hitchcock.', 0, 'Infantil');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Prestamo`
--

CREATE TABLE `Prestamo` (
  `idPrestamo` int NOT NULL,
  `ISBN` varchar(50) DEFAULT NULL,
  `idEjemplar` int DEFAULT NULL,
  `numControl` int NOT NULL,
  `correo` varchar(75) NOT NULL,
  `fechaPrestamo` date NOT NULL,
  `fechaDevolucion` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Sancion`
--

CREATE TABLE `Sancion` (
  `idSancion` int NOT NULL,
  `montoSancion` decimal(10,0) NOT NULL,
  `idPrestamo` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `numControl` int NOT NULL PRIMARY KEY,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `telefono` varchar(10) DEFAULT NULL,
  `contrasena` varchar(100) NOT NULL,
  `rol` varchar(50) NOT NULL DEFAULT 'estudiante'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`numControl`, `nombre`, `apellido`, `correo`, `telefono`, `contrasena`, `rol`) VALUES
(1221100297, 'Fernando', 'Mendoza Garcia', 'fermgarcia1912@gmail.com', '4681150215', '$2a$10$tahPau/.74XaiueDQrszXeulCZBpKGubOGtOmhHxRUheu/zuSiKHO', 'administrador'),
(1221100290, 'Ana', 'Lopez', 'jisellopez1022@gmail.com', '4681392374', '$2a$08$7XEjg4nxMLUK4HVmZlF.p.yuSnejK6SgdVnourZOYgFsTreigs4HK', 'estudiante'),
(1221100110, 'Ana', 'Lopez', 'poki089@gmail.com', '2382948894', '$2a$08$EgBcAhbzjXorrwvuEoJfP./NJujmL.LU.ygAwjZADrb11ACAxjhDS', 'estudiante'),
(1221100123, 'Rodrigo', 'Mendoza', 'poki132@gmail.com', '4681150215', '$2a$08$7J57NlOpAo.JkrAruMmF8u/fiSoFZogOj8a5GNXfQRV77QsVElNyG', 'estudiante');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `Ejemplar`
--
ALTER TABLE `Ejemplar`
  ADD PRIMARY KEY (`idEjemplar`),
  ADD KEY `ISBN` (`ISBN`);

--
-- Indices de la tabla `Libro`
--
ALTER TABLE `Libro`
  ADD PRIMARY KEY (`ISBN`);

--
-- Indices de la tabla `Prestamo`
--
ALTER TABLE `Prestamo`
  ADD PRIMARY KEY (`idPrestamo`),
  ADD KEY `idEjemplar` (`idEjemplar`);

--
-- Indices de la tabla `Sancion`
--
ALTER TABLE `Sancion`
  ADD PRIMARY KEY (`idSancion`),
  ADD KEY `idPrestamo` (`idPrestamo`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idUsuario`),
  ADD UNIQUE KEY `numControl` (`numControl`,`correo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `Ejemplar`
--
ALTER TABLE `Ejemplar`
  MODIFY `idEjemplar` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `Prestamo`
--
ALTER TABLE `Prestamo`
  MODIFY `idPrestamo` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `Sancion`
--
ALTER TABLE `Sancion`
  MODIFY `idSancion` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idUsuario` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `Ejemplar`
--
ALTER TABLE `Ejemplar`
  ADD CONSTRAINT `Ejemplar_ibfk_1` FOREIGN KEY (`ISBN`) REFERENCES `Libro` (`ISBN`) ON DELETE CASCADE;

--
-- Filtros para la tabla `Prestamo`
--
ALTER TABLE `Prestamo`
  ADD CONSTRAINT `Prestamo_ibfk_1` FOREIGN KEY (`idEjemplar`) REFERENCES `Ejemplar` (`idEjemplar`) ON DELETE CASCADE;

--
-- Filtros para la tabla `Sancion`
--
ALTER TABLE `Sancion`
  ADD CONSTRAINT `Sancion_ibfk_1` FOREIGN KEY (`idPrestamo`) REFERENCES `Prestamo` (`idPrestamo`) ON DELETE CASCADE;
