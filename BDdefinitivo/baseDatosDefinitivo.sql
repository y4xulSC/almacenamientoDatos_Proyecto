CREATE DATABASE Proyecto2;
USE Proyecto2;

-- Tabla Usuario

CREATE TABLE IF NOT EXISTS rol ( -- Nueva tabla
	id INT NOT NULL AUTO_INCREMENT,
    nombreRol ENUM('Administrador', 'Cliente'), -- Administrador, Cliente y los que se desee agregar
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS usuario (
	id INT NOT NULL AUTO_INCREMENT, -- Evita que se repitan valores
    nombreUsuario VARCHAR(100) UNIQUE,
	nombre VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    telefono BIGINT NOT NULL,
    edad INT NOT NULL,
	sexo ENUM ('Hombre','Mujer') NOT NULL,
	contrasena VARCHAR(255) NOT NULL,
    idRol INT NOT NULL, -- Nueva
	PRIMARY KEY (id),
    FOREIGN KEY (idRol) REFERENCES rol(id) -- Nueva
);

-- Tabla producto

CREATE TABLE IF NOT EXISTS producto (
	idProducto INT NOT NULL AUTO_INCREMENT,
	nombre VARCHAR(255) NOT NULL,
	precio DECIMAL(10,2) NOT NULL,
    genero ENUM('Hombre','Mujer','Niño'),
    categoria ENUM('Camiseta', 'Buzo', 'Chaqueta', 'Sudadera', 'Zapatos') NOT NULL,
    talla VARCHAR(5) NOT NULL,
	imagen BLOB NULL,
    descripcion VARCHAR(200) NULL,
    diseno BLOB NOT NULL, -- Nuevo
	PRIMARY KEY (idProducto)
    -- CONSTRAINT FKDisenoPersonalizado FOREIGN KEY (idDiseno) REFERENCES disenoPersonalizado(idDisenoPer) ON DELETE CASCADE, -- Nuevo (Se elimina por herencia parcial sin solapamiento)
    -- CONSTRAINT FKDisenoPredeterminado FOREIGN KEY (idDiseno) REFERENCES disenoPredeterminado(idDisenoPre) ON DELETE NO ACTION -- Nuevo (Se elimina por herencia parcial sin solapamiento)
    
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

-- TABLA PEDIDO

CREATE TABLE IF NOT EXISTS pedido (
	idPedido INT NOT NULL AUTO_INCREMENT,
	idCliente INT NOT NULL,
	fechaHoraSolicita DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	fechaHoraEntrega DATETIME NULL,
	total DECIMAL(15,2) NOT NULL,
	estado ENUM('pendiente', 'procesado', 'enviado', 'entregado') DEFAULT 'Pendiente' NOT NULL,
		-- Pendiente: El envío del pedido esta por ser aceptado
		-- Procesado: El envío del pedido es aceptado por la entidad que realizará el proceso para enviarlo de un lugar A a un lugar B
		-- Enviado: la entidad envía el pedido a la dirección proporcionada por un user
		-- PrimerEntregado: El pedido llega a la dirección del usuario
	PRIMARY KEY (idPedido),
	FOREIGN KEY (idCliente) REFERENCES usuario(id)
);

-- TABLA DE LA CANTIDAD DE PRODUCTOS EN EL PEDIDO

CREATE TABLE IF NOT EXISTS productoPedido (
	idPedido INT NOT NULL,
    idProducto INT NOT NULL,
    cantidadProducto INT NOT NULL,
    -- totalCantProd DECIMAL NOT NULL, -- Se elimina, se realiza por consulta
    PRIMARY KEY (idPedido, idProducto),
    FOREIGN KEY (idPedido) REFERENCES pedido(idPedido),
    FOREIGN KEY (idProducto) REFERENCES producto(idProducto)
);

-- TABLA DEPARTAMENTO

CREATE TABLE IF NOT EXISTS departamento (
	id INT NOT NULL AUTO_INCREMENT,
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
    barrio VARCHAR(150) NOT NULL, -- Nuevo
	calle VARCHAR(255) NOT NULL,
	numero INT NOT NULL,
	infoExtra VARCHAR(255) NOT NULL,
	pais VARCHAR(255) NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (idPedido) REFERENCES pedido(idPedido),
	FOREIGN KEY (idCiudad) REFERENCES ciudad(id)
);

CREATE TABLE IF NOT EXISTS comentario ( -- Corregido
	idComentario INT NOT NULL AUTO_INCREMENT,
    idCliente INT NOT NULL, -- Nuevo
    idProducto INT NOT NULL, -- idPedido INT NOT NULL, -- Modificado
    comentario VARCHAR(200) NULL,
    calificacion ENUM('1','2','3','4','5') NULL,
    PRIMARY KEY (idComentario),
    FOREIGN KEY (idCliente) REFERENCES usuario(id), -- Nuevo
    FOREIGN KEY (idProducto) REFERENCES producto(idProducto) -- FOREIGN KEY (idPedido) REFERENCES pedido(idPedido) -- Modificado
);

-- Mostrar todas las tablas

DESCRIBE 
usuario
-- producto
-- pedido
-- productoPedido
-- ciudad
-- departamento
-- detalleEnvio
;


-- DISEÑOS DE PRODUCTO

-- CREATE TABLE IF NOT EXISTS disenoPersonalizado ( -- Se elimina
-- 	idDisenoPer INT NOT NULL AUTO_INCREMENT,
	-- idProducto INT NOT NULL, -- Se vincula en producto
    -- idUsuario INT NOT NULL, -- Se elimina
    -- tipoPersonalizacion ENUM('Imagen', 'Texto') NOT NULL, -- Se elimina
-- 	graficaPerso BLOB NOT NULL,
-- 	personalizable ENUM('Sí', 'No', 'En aprobacion') NOT NULL DEFAULT 'En aprobacion',
    -- descripcion TEXT NULL, -- Se elimina
-- 	PRIMARY KEY (idDisenoPer)
	-- CONSTRAINT disenoPersonalizadoProducto FOREIGN KEY (idProducto) REFERENCES producto(idProducto), -- Se vincula en producto
    -- CONSTRAINT disenoClientePers FOREIGN KEY (idUsuario) REFERENCES usuario(id) -- Se vincula en producto
-- );

-- CREATE TABLE IF NOT EXISTS disenoPredeterminado ( -- Se elimina
-- 	idDisenoPre INT NOT NULL AUTO_INCREMENT,
    -- idProducto INT NOT NULL, -- Se vincula en producto
-- 	nombrePersonalizacion VARCHAR (50) NOT NULL,
-- 	categoria ENUM('Camiseta', 'Buzo', 'Chaqueta', 'Sudadera', 'Zapatos') NOT NULL, -- Nuevo (con dudas)
-- 	talla VARCHAR(5) NOT NULL, -- Nuevo (con dudas)
-- 	graficaPredeterminado BLOB NOT NULL,
    -- tipoPersonalizacion ENUM('Imagen', 'Texto') NOT NULL, -- Se elimina
    -- descripcion TEXT NULL, -- Se elimina
-- 	PRIMARY KEY (idDisenoPre)
	-- CONSTRAINT disenoPredeterminadoProducto FOREIGN KEY (idProducto) REFERENCES producto(idProducto) -- Se vincula en producto
-- );