CREATE DATABASE Almacenamiento_Tienda;

CREATE TABLE usuario (
    idUsuario INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    correoelectronico VARCHAR(255) UNIQUE NOT NULL,
    contrasena VARCHAR(255) NOT NULL,
    nombreUsuario VARCHAR(255) NOT NULL,
    edad INT NOT NULL,
    rol VARCHAR(15) NOT NULL,
    estado VARCHAR(10) NOT NULL,
    fechaActivacionUsuario TIMESTAMP NOT NULL,
    fechaDesactivacionUsuario TIMESTAMP NOT NULL
);

ALTER TABLE usuario ADD CONSTRAINT CheckRolUsuario CHECK (rol IN ('administrador', 'cliente'));
ALTER TABLE usuario ADD CONSTRAINT CheckEstadoUsuario CHECK (estado IN ('activo', 'inactivo'));

CREATE TABLE administrador (
    idAdmin VARCHAR(255) PRIMARY KEY NOT NULL,
    idUsuario VARCHAR(100) NOT NULL,
    permisGestionUsuario BOOLEAN NOT NULL,
    permisoOrdenProducto BOOLEAN NOT NULL,
    permisDescuentoProducto BOOLEAN NOT NULL,
    FOREIGN KEY (idUsuario) REFERENCES usuario(idUsuario)
);

CREATE TABLE cliente (
    idCliente VARCHAR(255)CHAR(255) PRIMARY KEY NOT NULL,
    numdocumento INT UNIQUE NULL,
    idUsuario VARCHAR(255) NOT NULL,
    numContacto INT(25) NOT NULL,
    sexo VARCHAR(10) NULL,
    FOREIGN KEY (idUsuario) REFERENCES usuario(idUsuario)
);

CREATE TABLE producto (
    idProducto INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    idAdmin VARCHAR(255) NOT NULL,
    tipoProducto VARCHAR(100) NOT NULL,
    categoriaProducto VARCHAR(255) NOT NULL,
    nombreProducto VARCHAR(150) NOT NULL,
    imagenProd BLOB NULL,
    genero VARCHAR(10) NOT NULL,
    talla VARCHAR(10) NOT NULL,
    cantidadStock INT NOT NULL,
    precioVenta FLOAT NOT NULL,
    descripcionProducto VARCHAR(255) NULL,
    calificacionProducto INT NULL,
    FOREIGN KEY (idAdmin) REFERENCES administrador(idAdmin)
);

ALTER TABLE producto ADD CONSTRAINT CheckGeneroProduc CHECK (genero IN ('femenino', 'masculino', 'neutro'));
ALTER TABLE producto ADD CONSTRAINT checkCalificacionProducto CHECK (calificacionProducto IN (1, 2, 3, 4, 5, NULL));

CREATE TABLE tipoDiseno (
    idTipoDiseno INT PRIMARY KEY NOT NULL,
    imagen BOOLEAN NULL,
    archivoImagen BLOB NULL,
    texto BOOLEAN NULL,
    fraseTexto VARCHAR(255) NULL,
    fuenteTexto VARCHAR(50) NULL,
    colorTexto VARCHAR(100) NULL,
    tamanoTexto FLOAT NULL
);

CREATE TABLE diseno (
    idDiseno INT PRIMARY KEY NOT NULL,
    idTipoDiseno INT NOT NULL,
    idAdmin VARCHAR(255) NOT NULL,
    restricciones VARCHAR(255) NULL,
    calificacionDiseno INT NULL,
    FOREIGN KEY (idTipoDiseno) REFERENCES tipoDiseno(idTipoDiseno),
    FOREIGN KEY (idAdmin) REFERENCES administrador(idAdmin)
);

CREATE TABLE personalizacion (
    idPersonalizacion INT PRIMARY KEY NOT NULL,
    idDiseno INT NOT NULL,
    idProducto INT NOT NULL,
    costoAdicional FLOAT NOT NULL,
    descripcionExtra VARCHAR(255) NULL,
    FOREIGN KEY (idDiseno) REFERENCES diseno(idDiseno),
    FOREIGN KEY (idProducto) REFERENCES producto(idProducto)
);

ALTER TABLE diseno ADD CONSTRAINT checkCalificacionDiseno CHECK (calificacionDiseno IN (1, 2, 3, 4, 5));

-- ------------------- EN PRUEBA ------------------- --
ALTER TABLE tipoDiseno ADD CONSTRAINT checkImagenTextoDiseno CHECK (
    (imagen = True AND texto = False) OR
    (imagen = False AND texto = True) OR
    (imagen IS NULL AND texto IS NULL));
ALTER TABLE tipoDiseno ADD CONSTRAINT checkImagenDiseno CHECK (
    imagen = True AND archivoImagen IS NOT NULL
);
ALTER TABLE tipoDiseno ADD CONSTRAINT checkTextoDiseno CHECK (
    (texto = True AND (fraseTexto IS NOT NULL AND
                       fuenteTexto IS NOT NULL AND
                       colorTexto IS NOT NULL AND
                       tamanoTexto IS NOT NULL))
);

-- ALTER TABLE tipoDiseno ADD CONSTRAINT checkImagenDiseno CHECK (imagen = True OR archivoImagen IS NULL);
-- ALTER TABLE tipoDiseno ADD CONSTRAINT checkFraseTextoDiseno CHECK (texto = True OR fraseTexto IS NULL);
-- ALTER TABLE tipoDiseno ADD CONSTRAINT checkFuenteTextoDiseno CHECK (texto = True OR fuenteTexto IS NULL);
-- ALTER TABLE tipoDiseno ADD CONSTRAINT checkColorTextoDiseno CHECK (texto = True OR colorTexto IS NULL);
-- ALTER TABLE tipoDiseno ADD CONSTRAINT checkTamanoTextoDiseno CHECK (texto = True OR tamanoTexto IS NULL);
-- ------------------- -- ------ ------------------- --

CREATE TABLE descuentos (
    idDescuento INT PRIMARY KEY NOT NULL,
    idProducto INT NOT NULL,
    idAdmin VARCHAR(255) NOT NULL,
    porcentajeDescuento DECIMAL NOT NULL,
    fechaInicioDescuento TIMESTAMP NOT NULL,
    fechaFinDescuento TIMESTAMP NULL,
    descripcionDescuento VARCHAR(255) NULL,
    FOREIGN KEY (idProducto) REFERENCES producto(idProducto),
    FOREIGN KEY (idAdmin) REFERENCES administrador(idAdmin)
);

CREATE TABLE promociones (
    idPromocion INT PRIMARY KEY NOT NULL,
    idProducto INT NOT NULL,
    idAdmin VARCHAR(255) NOT NULL,
    cantidadMinProd INT NOT NULL,
    cantidadMaxProd INT NOT NULL,
    fechaInicioPromo TIMESTAMP NOT NULL,
    fechaFinPromo TIMESTAMP NULL,
    FOREIGN KEY (idProducto) REFERENCES producto(idProducto),
    FOREIGN KEY (idAdmin) REFERENCES administrador(idAdmin)
);

CREATE TABLE carritoCompra (
    idCarritoCompra INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    idCliente VARCHAR(255) NOT NULL,
    totalCarrito DECIMAL NOT NULL,
    FOREIGN KEY (idCliente) REFERENCES cliente(idCliente)
);

CREATE TABLE cantidadProdCarrito (
    idCantProdCarrito INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    idCarritoCompra INT NOT NULL,
    idProducto INT NOT NULL,
    cantProducto INT,
    activoCantCarrito BOOLEAN NOT NULL,
    FOREIGN KEY (idCarritoCompra) REFERENCES carritoCompra(idCarritoCompra),
    FOREIGN KEY (idProducto) REFERENCES producto(idProducto)
);

CREATE TABLE compra (
    idCompra INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    idCliente VARCHAR(255) NOT NULL,
    idCarritoCompra INT NOT NULL,
    calificacionCompra INT NULL,
    FOREIGN KEY (idCliente) REFERENCES cliente(idCliente),
    FOREIGN KEY (idCarritoCompra) REFERENCES carritoCompra(idCarritoCompra)
);

ALTER TABLE compra ADD CONSTRAINT checkCalificacionCompra CHECK (calificacionCompra IN (1, 2, 3, 4, 5) OR calificacionCompra IS NULL);

CREATE TABLE productosComprados (
    idProductosComprados INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    idCompra INT NOT NULL,
    idProducto INT NOT NULL,
    idPersonalizacion INT NOT NULL, 
    cantidadComprada INT NOT NULL,
    FOREIGN KEY (idCompra) REFERENCES compra(idCompra),
    FOREIGN KEY (idProducto) REFERENCES producto(idProducto),
    FOREIGN KEY (idPersonalizacion) REFERENCES personalizacion(idPersonalizacion)
);

CREATE TABLE impresiones (
    idImpresion INT PRIMARY KEY NOT NULL,
    idProducto INT NOT NULL,
    idCliente VARCHAR(255) NOT NULL,
    fechaHoraImpresion TIMESTAMP NOT NULL,
    compraProducto BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (idProducto) REFERENCES producto(idProducto),
    FOREIGN KEY (idCliente) REFERENCES cliente(idCliente)
);

-- ------------------- EN PRUEBA ------------------- --
ALTER TABLE impresiones ADD CONSTRAINT chekCompraProdImpr CHECK (compraProducto = IF(EXISTS (SELECT 1 FROM compra WHERE compra.idProducto = idProducto), TRUE, FALSE));
-- ------------------- -- ------ ------------------- --

CREATE TABLE direccionCliente (
    idDireccion INT PRIMARY KEY NOT NULL,
    idCliente VARCHAR(255) NOT NULL,
    pais VARCHAR(100) NOT NULL,
    ciudad VARCHAR(100) NOT NULL,
    barrio VARCHAR(200) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    infoExtra VARCHAR(255) NULL,
    FOREIGN KEY (idCliente) REFERENCES cliente(idCliente)
);

CREATE TABLE domiciliario (
    idDomiciliario INT PRIMARY KEY NOT NULL,
    nombrecompleto VARCHAR(255) NOT NULL,
    numdocumentoDomiciliario INT NOT NULL UNIQUE,
    edad INT NOT NULL
);
 
CREATE TABLE metodoTransporte (
    idMetodoTransp INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    idDomiciliario INT NOT NULL,
    nombreTranspo VARCHAR(150) NOT NULL,
    vehiculo VARCHAR(100) NOT NULL
);

CREATE TABLE pedido (
    idPedido INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    idCliente VARCHAR(255) NOT NULL,
    idDireccion INT NOT NULL,
    idCompra INT NOT NULL,
    idMetodoTranspo INT NOT NULL,
    idAdmin VARCHAR(255) NOT NULL,
    estadoPedido VARCHAR(100) NOT NULL,
    fechaHoraEntrega TIMESTAMP NULL,
    calificacionPedido VARCHAR(20) NOT NULL,
    FOREIGN KEY (idCliente) REFERENCES cliente(idCliente),
    FOREIGN KEY (idDireccion) REFERENCES direccionCliente(idDireccion),
    FOREIGN KEY (idCompra) REFERENCES compra(idCompra),
    FOREIGN KEY (idMetodoTranspo) REFERENCES metodoTransporte(idMetodoTransp),
    FOREIGN KEY (idAdmin) REFERENCES administrador(idAdmin)
);

ALTER TABLE pedido ADD CONSTRAINT checkEstadoPedido CHECK (calificacionPedido IN('Preparacion', 'Despachado', 'En camino', 'Entregado'));
