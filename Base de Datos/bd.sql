CREATE DATABASE Proyecto;
USE Proyecto;

CREATE TABLE IF NOT EXISTS departamento (
	idDepartamento INT NOT NULL AUTO_INCREMENT,
	nombre VARCHAR(60) NOT NULL,
	PRIMARY KEY (idDepartamento)
);

CREATE TABLE IF NOT EXISTS ciudad (
	idCiudad INT NOT NULL AUTO_INCREMENT,
	idDepartamento INT NOT NULL,
	nombre VARCHAR(60),
	codigoPostal INT NOT NULL,
	PRIMARY KEY (idCiudad),
	FOREIGN KEY (idDepartamento) REFERENCES departamento(idDepartamento)
);

CREATE TABLE IF NOT EXISTS usuario (
    idUsuario INT NOT NULL AUTO_INCREMENT,
    nombreUsuario VARCHAR(100) UNIQUE,
    nombre VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    telefono BIGINT NOT NULL,
    edad INT NOT NULL,
    sexo ENUM('Hombre', 'Mujer') NOT NULL,
	idCiudad INT NOT NULL,
    PRIMARY KEY (idUsuario),
	FOREIGN KEY (idCiudad) REFERENCES ciudad(idCiudad)
);

CREATE TABLE IF NOT EXISTS rol (
	idRol INT NOT NULL AUTO_INCREMENT,
    nombreRol ENUM('Administrador', 'Cliente') NOT NULL, -- Administrador, Cliente y los que se desee agregar
    contrasena VARCHAR(255) NOT NULL,
    idUsuario INT NOT NULL UNIQUE,
    PRIMARY KEY (idRol),
    FOREIGN KEY (idUsuario) REFERENCES usuario(idUsuario)
);

CREATE TABLE IF NOT EXISTS diseno (
    idDiseno INT NOT NULL AUTO_INCREMENT,
    nombreDiseno VARCHAR(50) NOT NULL,
    categoria VARCHAR(100) NOT NULL,
    PRIMARY KEY (idDiseno)
);
INSERT INTO diseno VALUES(1, "Sin diseno", "No aplica");

CREATE TABLE IF NOT EXISTS producto (
	idProducto INT NOT NULL AUTO_INCREMENT,
	nombre VARCHAR(255) NOT NULL,
	precio DECIMAL(10,2) NOT NULL,
    genero ENUM('Hombre','Mujer','Niño'),
    talla VARCHAR(5) NOT NULL,
	imagen BLOB NULL,
    descripcion VARCHAR(200) NULL,
    color VARCHAR(10) NULL,
    cantidadStock INT NULL,
    idDiseno INT NOT NULL,
	PRIMARY KEY (idProducto),
    FOREIGN KEY (idDiseno) REFERENCES diseno(idDiseno)
);

CREATE TABLE IF NOT EXISTS promociones (
	idPromocion INT NOT NULL AUTO_INCREMENT,
	idProducto INT NOT NULL,
	fechaInicio DATE NOT NULL,
	horaInicio TIME NOT NULL,
	fechaFin DATE NULL,
	horaFin TIME NULL,
	descuento DECIMAL(10,2) NOT NULL,
	PRIMARY KEY(idPromocion),
	FOREIGN KEY (idProducto) REFERENCES producto(idProducto)
);

CREATE TABLE IF NOT EXISTS paquete (
    idPaquete INT NOT NULL AUTO_INCREMENT,
    idProducto INT NOT NULL,
    cantidadProducto INT NOT NULL,
    tipoProducto VARCHAR(50) NOT NULL,
    PRIMARY KEY (idPaquete),
    FOREIGN KEY (idProducto) REFERENCES producto(idProducto)
);

CREATE TABLE IF NOT EXISTS pedido (
	idPedido INT NOT NULL AUTO_INCREMENT,
	idUsuario INT NOT NULL,
	fechaHoraPedido DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	estado ENUM('PENDIENTE', 'PROCESADO', 'ENVIADO', 'ENTREGADO') DEFAULT 'PENDIENTE' NOT NULL,
	total DECIMAL(15,2) NOT NULL,
		-- Pendiente: El envío del pedido esta por ser aceptado
		-- Procesado: El envío del pedido es aceptado por la entidad que realizará el proceso para enviarlo de un lugar A a un lugar B
		-- Enviado: la entidad envía el pedido a la dirección proporcionada por un user
		-- PrimerEntregado: El pedido llega a la dirección del usuario
	PRIMARY KEY (idPedido),
	FOREIGN KEY (idUsuario) REFERENCES usuario(idUsuario)
);

CREATE TABLE IF NOT EXISTS productoPedido (
	idProductoPedio INT NOT NULL AUTO_INCREMENT,
	idPedido INT NOT NULL,
    idProducto INT NOT NULL,
    cantidadProducto INT NOT NULL,
    PRIMARY KEY (idProductoPedio),
    FOREIGN KEY (idPedido) REFERENCES pedido(idPedido),
    FOREIGN KEY (idProducto) REFERENCES producto(idProducto)
);

CREATE TABLE IF NOT EXISTS detalleEnvio (
	idDetalleEnvio INT NOT NULL AUTO_INCREMENT,
	idPedido INT NOT NULL,
	idCiudad INT NOT NULL,
    barrio VARCHAR(150) NOT NULL,
	direccion VARCHAR(255) NOT NULL,
	numero INT NOT NULL,
	infoExtra VARCHAR(255) NOT NULL,
	pais VARCHAR(255) NOT NULL,
	PRIMARY KEY (idDetalleEnvio),
	FOREIGN KEY (idPedido) REFERENCES pedido(idPedido),
	FOREIGN KEY (idCiudad) REFERENCES ciudad(idCiudad)
);

CREATE TABLE IF NOT EXISTS comentario (
	idComentario INT NOT NULL AUTO_INCREMENT,
    idUsuario INT NOT NULL,
    idProducto INT NOT NULL,
    comentario VARCHAR(200) NULL,
    calificacion INT NULL,
    PRIMARY KEY (idComentario),
    FOREIGN KEY (idUsuario) REFERENCES usuario(idUsuario),
    FOREIGN KEY (idProducto) REFERENCES producto(idProducto),
    CONSTRAINT check_calificacionProducto CHECK (calificacion >= 0 AND calificacion <= 5)
);

-- Mostrar todas las tablas
DESCRIBE usuario
-- producto
-- visita
-- promocion
-- pedido
-- productoPedido
-- departamento
-- ciudad
-- detalleEnvio
-- comentario
;
