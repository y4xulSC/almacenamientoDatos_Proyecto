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
	correo_electronico VARCHAR(255) NOT NULL,
	contrasena VARCHAR(255) NOT NULL,
	rol ENUM('Cliente', 'Administrador') NOT NULL,
	PRIMARY KEY (id)
);

-- Tabla producto

CREATE TABLE IF NOT EXISTS producto (
	id_producto INT NOT NULL AUTO_INCREMENT,
	nombre VARCHAR(255) NOT NULL,
	precio DECIMAL(10,2) NOT NULL,
	categoria ENUM('Camiseta', 'Buzo', 'Chaqueta', 'Sudadera', 'Zapatos') NOT NULL,
	talla ENUM ('S','M','L','XL'),
	genero ENUM('Hombre','Mujer','Niño'),
    retricciones VARCHAR(200) NULL,
	PRIMARY KEY (id_producto) 
);

-- HERENCIAS DE PRODUCTO

CREATE TABLE IF NOT EXISTS diseño_personalizado (
	id_producto INT NOT NULL,
    tipoPersonalizacion ENUM('Imagen', 'Texto') NOT NULL,
	graficaPerso BLOB NOT NULL,
	personalizable ENUM('Sí', 'No', 'En aprobacion') NOT NULL DEFAULT 'En aprobacion',
    descripcion TEXT NULL,
	PRIMARY KEY (id_producto),
	CONSTRAINT diseño_personalizado_producto FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

CREATE TABLE IF NOT EXISTS diseño_predeterminado (
	id_producto INT NOT NULL,
    nombrePersonalizacion VARCHAR (50) NOT NULL,
    tipoPersonalizacion ENUM('Imagen', 'Texto') NOT NULL,
    graficaPredeterminado BLOB NOT NULL,
    descripcion TEXT NULL,
	-- diseño TEXT NOT NULL,
	PRIMARY KEY (id_producto),
	CONSTRAINT diseño_predeterminado_producto FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

CREATE TABLE IF NOT EXISTS promociones (
	id_promocion INT NOT NULL,
	id_producto INT NOT NULL,
	fechaInicio DATE NOT NULL,
	horaInicio TIME NOT NULL,
	fechaFin DATE NULL,
	horaFin TIME NULL,
	descuento DECIMAL NOT NULL,
	PRIMARY KEY(id_promocion),
	FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

-- TABLA PEDIDO

CREATE TABLE IF NOT EXISTS pedido (
	id_pedido INT NOT NULL AUTO_INCREMENT,
	-- id_producto INT NOT NULL,
	id_cliente INT NOT NULL,
	-- cantidad INT NOT NULL DEFAULT 0,
	fechaHoraSolicita DATETIME NOT NULL,
	fechaHoraEntrega DATETIME NULL,
	total DECIMAL(15,2) NOT NULL,
	estado ENUM('pendiente', 'procesado', 'enviado', 'entregado') DEFAULT 'Pendiente' NOT NULL,
	PRIMARY KEY (id_pedido),
	FOREIGN KEY (id_cliente) REFERENCES usuario(id)
	-- FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

-- TABLA DE LA CANTIDAD DE PRODUCTOS EN EL PEDIDO

CREATE TABLE IF NOT EXISTS productoPedido (
	id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad_producto INT NOT NULL,
    totalCantProd DECIMAL NOT NULL,
    PRIMARY KEY (id_pedido, id_producto),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

ALTER TABLE productopedido ADD COLUMN precioCantProd DECIMAL NOT NULL;

-- TABLA DEPARTAMENTO

CREATE TABLE IF NOT EXISTS departamento (
	id INT NOT NULL AUTO_INCREMENT,
	id_pedido INT NOT NULL,
	nombre VARCHAR(60) NOT NULL,
	PRIMARY KEY (id)
);

-- TABLA CIUDAD

CREATE TABLE IF NOT EXISTS ciudad ( -- Una FOREIGN KEY es una pertenencia.
	id INT NOT NULL AUTO_INCREMENT,
	id_departamento INT NOT NULL,
	nombre VARCHAR(60),
	codigo_postal INT NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (id_departamento) REFERENCES departamento(id)
);

-- TABLA detalle_envio

CREATE TABLE IF NOT EXISTS detalle_envio (
	id INT NOT NULL AUTO_INCREMENT,
	id_pedido INT NOT NULL,
	id_ciudad INT NOT NULL,
	calle VARCHAR(255) NOT NULL,
	numero INT NOT NULL,
	info_extra VARCHAR(255) NOT NULL,
	pais VARCHAR(255) NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
	FOREIGN KEY (id_ciudad) REFERENCES ciudad(id)
);

-- Mostrar todas las tablas

DESCRIBE usuario;
DESCRIBE producto;
DESCRIBE cliente_producto;
DESCRIBE pedido;
DESCRIBE ciudad;
DESCRIBE departamento;
DESCRIBE detalle_envio;

-- Borrar tablas para luega modificarlas:

DROP TABLE usuario; -- ELIMINAR TABLA USUARIO
DROP TABLE pedido;
DROP TABLE detalle_envio;
DROP DATABASE Proyecto;

-- Mostrar todas las tablas del proyecto

SHOW tables FROM proyecto;