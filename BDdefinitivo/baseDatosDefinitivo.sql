CREATE DATABASE Proyecto;
USE Proyecto;

-- Tabla Usuario

CREATE TABLE IF NOT EXISTS usuario (
	id INT NOT NULL AUTO_INCREMENT, -- Evita que se repitan valores
    -- nombreUsuario VARCHAR(100) UNIQUE,
	edad INT NOT NULL,
	nombre VARCHAR(255) NOT NULL,
	sexo ENUM ('Hombre','Mujer') NOT NULL,
	telefono INT NOT NULL,
	email VARCHAR(255) NOT NULL,
	contrasena VARCHAR(255) NOT NULL,
	rol ENUM('Cliente', 'Administrador') NOT NULL,
	PRIMARY KEY (id)
);

-- Tabla producto

CREATE TABLE IF NOT EXISTS producto (
	idProducto INT NOT NULL AUTO_INCREMENT,
	nombre VARCHAR(255) NOT NULL,
	precio DECIMAL(10,2) NOT NULL,
	categoria ENUM('Camiseta', 'Buzo', 'Chaqueta', 'Sudadera', 'Zapatos') NOT NULL,
	talla VARCHAR(10) NOT NULL,
	genero ENUM('Hombre','Mujer','Niño'),
    retricciones VARCHAR(200) NULL,
	PRIMARY KEY (idProducto) 
);

CREATE TABLE IF NOT EXISTS visita (
	idVisita INT NOT NULL AUTO_INCREMENT,
    idProducto INT NOT NULL,
    idUsuario INT NOT NULL,
    fechaHoraVisita DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (idVisita),
    FOREIGN KEY (idProducto) REFERENCES producto(idProducto),
    FOREIGN KEY (idUsuario) REFERENCES usuario(id)
);

-- HERENCIAS DE PRODUCTO

CREATE TABLE IF NOT EXISTS disenoPersonalizado (
	idDisenoPer INT NOT NULL,
	idProducto INT NOT NULL,
    idUsuario INT NOT NULL,
    tipoPersonalizacion ENUM('Imagen', 'Texto') NOT NULL,
	graficaPerso BLOB NOT NULL,
	personalizable ENUM('Sí', 'No', 'En aprobacion') NOT NULL DEFAULT 'En aprobacion',
    descripcion TEXT NULL,
	PRIMARY KEY (idDisenoPer),
	CONSTRAINT disenoPersonalizadoProducto FOREIGN KEY (idProducto) REFERENCES producto(idProducto),
    CONSTRAINT disenoClientePers FOREIGN KEY (idUsuario) REFERENCES usuario(id)
);

CREATE TABLE IF NOT EXISTS disenoPredeterminado (
	idDisenoPre INT NOT NULL,
    idProducto INT NOT NULL,
    nombrePersonalizacion VARCHAR (50) NOT NULL,
    tipoPersonalizacion ENUM('Imagen', 'Texto') NOT NULL,
    graficaPredeterminado BLOB NOT NULL,
    descripcion TEXT NULL,
	-- diseno TEXT NOT NULL,
	PRIMARY KEY (idDisenoPre),
	CONSTRAINT disenoPredeterminadoProducto FOREIGN KEY (idProducto) REFERENCES producto(idProducto)
);

CREATE TABLE IF NOT EXISTS promociones (
	idPromocion INT NOT NULL,
	idProducto INT NOT NULL,
	fechaInicio DATE NOT NULL,
	horaInicio TIME NOT NULL,
	fechaFin DATE NULL,
	horaFin TIME NULL,
	descuento DECIMAL NOT NULL,
	PRIMARY KEY(idPromocion),
	FOREIGN KEY (idProducto) REFERENCES producto(idProducto)
);

-- TABLA PEDIDO

CREATE TABLE IF NOT EXISTS pedido (
	idPedido INT NOT NULL AUTO_INCREMENT,
	-- idProducto INT NOT NULL,
	idCliente INT NOT NULL,
	-- cantidad INT NOT NULL DEFAULT 0,
	fechaHoraSolicita DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	fechaHoraEntrega DATETIME NULL,
	total DECIMAL(15,2) NOT NULL,
	estado ENUM('pendiente', 'procesado', 'enviado', 'entregado') DEFAULT 'Pendiente' NOT NULL,
	PRIMARY KEY (idPedido),
	FOREIGN KEY (idCliente) REFERENCES usuario(id)
	-- FOREIGN KEY (idProducto) REFERENCES producto(idProducto)
);

-- TABLA DE LA CANTIDAD DE PRODUCTOS EN EL PEDIDO

CREATE TABLE IF NOT EXISTS productoPedido (
	idPedido INT NOT NULL,
    idProducto INT NOT NULL,
    cantidadProducto INT NOT NULL,
    totalCantProd DECIMAL NOT NULL,
    PRIMARY KEY (idPedido, idProducto),
    FOREIGN KEY (idPedido) REFERENCES pedido(idPedido),
    FOREIGN KEY (idProducto) REFERENCES producto(idProducto)
);

-- ALTER TABLE productopedido ADD COLUMN precioCantProd DECIMAL NOT NULL;

-- TABLA DEPARTAMENTO

CREATE TABLE IF NOT EXISTS departamento (
	id INT NOT NULL AUTO_INCREMENT,
	idPedido INT NOT NULL,
	nombre VARCHAR(60) NOT NULL,
	PRIMARY KEY (id)
);

-- TABLA CIUDAD

CREATE TABLE IF NOT EXISTS ciudad ( -- Una FOREIGN KEY es una pertenencia.
	id INT NOT NULL AUTO_INCREMENT,
	idDepartamento INT NOT NULL,
	nombre VARCHAR(60),
	codigoPostal INT NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (idDepartamento) REFERENCES departamento(id)
);

-- TABLA detalleEnvio

CREATE TABLE IF NOT EXISTS detalleEnvio (
	id INT NOT NULL AUTO_INCREMENT,
	idPedido INT NOT NULL,
	idCiudad INT NOT NULL,
	calle VARCHAR(255) NOT NULL,
	numero INT NOT NULL,
	infoExtra VARCHAR(255) NOT NULL,
	pais VARCHAR(255) NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (idPedido) REFERENCES pedido(idPedido),
	FOREIGN KEY (idCiudad) REFERENCES ciudad(id)
);

CREATE TABLE IF NOT EXISTS comentario (
	idComentario INT NOT NULL AUTO_INCREMENT,
    idPedido INT NOT NULL,
    comentario VARCHAR(200) NULL,
    calificacion ENUM('1','2','3','4','5') NULL,
    PRIMARY KEY (idComentario),
    FOREIGN KEY (idPedido) REFERENCES pedido(idPedido)
);

-- Mostrar todas las tablas

DESCRIBE usuario;
DESCRIBE producto;
-- DESCRIBE clienteProducto;
DESCRIBE pedido;
DESCRIBE ciudad;
DESCRIBE departamento;
DESCRIBE detalleEnvio;

-- Borrar tablas para luega modificarlas:

-- DROP TABLE usuario; -- ELIMINAR TABLA USUARIO
-- DROP TABLE pedido;
-- DROP TABLE detalleEnvio;
-- DROP DATABASE Proyecto;

-- Mostrar todas las tablas del proyecto

SHOW tables FROM proyecto;