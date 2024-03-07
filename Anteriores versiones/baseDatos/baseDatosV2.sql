CREATE DATABASE proyectoAD_test;

CREATE TABLE rol (
	idRol INT AUTO_INCREMENT NOT NULL,
    nombreRol VARCHAR(15) NOT NULL,
    descripcionRol VARCHAR(20) NOT NULL,
    -- Los usuarios pueden tener un solo rol o varios roles
    -- Los clientes pueden tienen roles?
    -- Únicamente los administradores tienen roles?
    -- tipoUsuario ENUM('administrador','cliente'), -- OPCIONAL hasta no identificar su función
    PRIMARY KEY (idRol)
);

CREATE TABLE usuario (
    idUsuario INT AUTO_INCREMENT NOT NULL,
    correoElectronico VARCHAR(255) UNIQUE NOT NULL,
    idRol VARCHAR(15) NOT NULL, -- OPCIONAL hasta NO tener claro su función
    nombreCompleto VARCHAR(255) NOT NULL,
    numContacto INT(25) NOT NULL,
    fechaNacimiento DATE NOT NULL,
    fechaActivacionUsuario DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (idUsuario),
    FOREIGN KEY (idRol) REFERENCES rol(idRol)
);

CREATE TABLE administrador (
    idAdmin VARCHAR(100) NOT NULL,
    idUsuario INT NOT NULL,
    -- idRol INT NOT NULL, -- OPCIONAL hasta NO tener claro su funcionamiento
    contrasena VARCHAR(255) NOT NULL,
    estadoAdmin ENUM('Activo', 'Inactivo') NOT NULL DEFAULT 'Activo',
    PRIMARY KEY (idAdmin),
    FOREIGN KEY (idUsuario) REFERENCES usuario(idUsuario)
);

CREATE TABLE cliente (
    idCliente VARCHAR(100) NOT NULL,
    idUsuario INT NOT NULL,
    contrasena VARCHAR(255) NOT NULL,
    estadoCliente ENUM('Activo', 'Inactivo') NOT NULL DEFAULT 'Activo',
    numdocumento INT UNIQUE NULL,
    sexo VARCHAR(10) NULL,
    PRIMARY KEY (idCliente),
    FOREIGN KEY (idUsuario) REFERENCES usuario(idUsuario)
);

CREATE TABLE producto (
    idProducto INT AUTO_INCREMENT NOT NULL,
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
    PRIMARY KEY (idProducto),
    FOREIGN KEY (idAdmin) REFERENCES administrador(idAdmin),
    CONSTRAINT CheckGeneroProduc CHECK (genero IN ('Femenino', 'Masculino', 'Neutro')),
    CONSTRAINT checkCalificacionProducto CHECK (calificacionProducto IN (1, 2, 3, 4, 5, NULL))
);

CREATE TABLE diseno (
    idDiseno INT NOT NULL,
    idAdmin VARCHAR(255) NULL,
    idCliente VARCHAR(255) NULL, -- Si se le da la oportinidad de ampliar la personalización
    nombreDiseno VARCHAR(100) NOT NULL,
    tipoDiseno ENUM('Imagen', 'Texto') NOT NULL,
    archivoDiseno BLOB NOT NULL,
    costoAdicional FLOAT NOT NULL,
    descripcionDiseno VARCHAR(200) NULL,
    restricciones VARCHAR(255) NULL,
    calificacionDiseno INT NULL,
    PRIMARY KEY (idDiseno),
    FOREIGN KEY (idAdmin) REFERENCES administrador(idAdmin),
    FOREIGN KEY (idCliente) REFERENCES cliente(idCliente), -- Si se le da la oportinidad de ampliar la personalización
    CONSTRAINT checkCalificacionDiseno CHECK (calificacionDiseno IN (1, 2, 3, 4, 5, NULL))
);

CREATE TABLE personalizacion (
    idPersonalizacion INT NOT NULL,
    idDiseno INT NOT NULL,
    idProducto INT NOT NULL,
    idCliente VARCHAR(100) NOT NULL,
    descripcionExtra VARCHAR(255) NULL,
    PRIMARY KEY (idPersonalizacion),
    FOREIGN KEY (idDiseno) REFERENCES diseno(idDiseno),
    FOREIGN KEY (idProducto) REFERENCES producto(idProducto),
    FOREIGN KEY (idCliente) REFERENCES cliente(idCliente)
);

-- ------------------- EN PRUEBA ------------------- --
-- ALTER TABLE tipoDiseno ADD CONSTRAINT checkImagenTextoDiseno CHECK (
--     (imagen = True AND texto = False) OR
--     (imagen = False AND texto = True) OR
--     (imagen IS NULL AND texto IS NULL));
-- ALTER TABLE tipoDiseno ADD CONSTRAINT checkImagenDiseno CHECK (
--     imagen = True AND archivoImagen IS NOT NULL
-- );
-- ALTER TABLE tipoDiseno ADD CONSTRAINT checkTextoDiseno CHECK (
--     (texto = True AND (fraseTexto IS NOT NULL AND
--                        fuenteTexto IS NOT NULL AND
--                        colorTexto IS NOT NULL AND
--                        tamanoTexto IS NOT NULL))
-- );

-- ALTER TABLE tipoDiseno ADD CONSTRAINT checkImagenDiseno CHECK (imagen = True OR archivoImagen IS NULL);
-- ALTER TABLE tipoDiseno ADD CONSTRAINT checkFraseTextoDiseno CHECK (texto = True OR fraseTexto IS NULL);
-- ALTER TABLE tipoDiseno ADD CONSTRAINT checkFuenteTextoDiseno CHECK (texto = True OR fuenteTexto IS NULL);
-- ALTER TABLE tipoDiseno ADD CONSTRAINT checkColorTextoDiseno CHECK (texto = True OR colorTexto IS NULL);
-- ALTER TABLE tipoDiseno ADD CONSTRAINT checkTamanoTextoDiseno CHECK (texto = True OR tamanoTexto IS NULL);
-- ------------------- -- ------ ------------------- --

CREATE TABLE descuentos (
    idDescuento INT NOT NULL,
    idProducto INT NOT NULL,
    idAdmin VARCHAR(255) NOT NULL,
    porcentajeDescuento DECIMAL NOT NULL,
    fechaInicioDescuento DATE NOT NULL,
    fechaFinDescuento DATE NULL,
    descripcionDescuento VARCHAR(255) NULL,
    PRIMARY KEY (idDescuento),
    FOREIGN KEY (idProducto) REFERENCES producto(idProducto),
    FOREIGN KEY (idAdmin) REFERENCES administrador(idAdmin)
);

CREATE TABLE promociones (
    idPromocion INT NOT NULL,
    idProducto INT NOT NULL,
    idAdmin VARCHAR(255) NOT NULL,
    cantidadMinProd INT NOT NULL,
    cantidadMaxProd INT NOT NULL,
    fechaInicioPromo DATE NOT NULL,
    fechaFinPromo DATE NULL,
    PRIMARY KEY (idPromocion),
    FOREIGN KEY (idProducto) REFERENCES producto(idProducto),
    FOREIGN KEY (idAdmin) REFERENCES administrador(idAdmin)
);

CREATE TABLE carritoCompra (
    idCarritoCompra INT AUTO_INCREMENT NOT NULL,
    idCliente VARCHAR(255) NOT NULL,
    estadoCarrito ENUM('Activo', 'Inactivo') NOT NULL DEFAULT 'Activo',
    totalCarrito DECIMAL NOT NULL DEFAULT 0,
    PRIMARY KEY (idCarritoCompra),
    FOREIGN KEY (idCliente) REFERENCES cliente(idCliente)
);

CREATE TABLE carritoProducto (
    idCantProdCarrito INT AUTO_INCREMENT NOT NULL,
    idCarritoCompra INT NOT NULL,
    idProducto INT NOT NULL,
    cantProducto INT NOT NULL,
    comprado BOOLEAN NOT NULL DEFAULT False,
	productoActivo BOOLEAN NOT NULL DEFAULT True,
    PRIMARY KEY (idCantProdCarrito),
    FOREIGN KEY (idCarritoCompra) REFERENCES carritoCompra(idCarritoCompra),
    FOREIGN KEY (idProducto) REFERENCES producto(idProducto)
);

CREATE TABLE compra (
    idCompra INT AUTO_INCREMENT NOT NULL,
    idCarritoCompra INT NOT NULL,
    fechaCompra DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    calificacionCompra INT NULL,
    PRIMARY KEY (idCompra),
    FOREIGN KEY (idCarritoCompra) REFERENCES carritoCompra(idCarritoCompra),
    CONSTRAINT checkCalificacionCompra CHECK (calificacionCompra IN (1, 2, 3, 4, 5, NULL))
);

-- CREATE TABLE productosComprados (
--     idProductosComprados INT AUTO_INCREMENT NOT NULL,
--     idCompra INT NOT NULL,
--     idProducto INT NOT NULL,
--     idPersonalizacion INT NOT NULL, 
--     cantidadComprada INT NOT NULL,
--     PRIMARY KEY (idProductosComprados),
--     FOREIGN KEY (idCompra) REFERENCES compra(idCompra),
--     FOREIGN KEY (idProducto) REFERENCES producto(idProducto),
--     FOREIGN KEY (idPersonalizacion) REFERENCES personalizacion(idPersonalizacion)
-- );

CREATE TABLE impresiones (
    idImpresion INT NOT NULL,
    idProducto INT NOT NULL,
    idCliente VARCHAR(255) NOT NULL,
    fechaHoraImpresion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    -- compraProducto BOOLEAN DEFAULT FALSE, -- VALIDAR
    PRIMARY KEY (idImpresion),
    FOREIGN KEY (idProducto) REFERENCES producto(idProducto),
    FOREIGN KEY (idCliente) REFERENCES cliente(idCliente)
);

-- ------------------- EN PRUEBA ------------------- --
ALTER TABLE impresiones ADD CONSTRAINT chekCompraProdImpr CHECK (compraProducto = IF(EXISTS (SELECT 1 FROM compra WHERE compra.idProducto = idProducto), TRUE, FALSE));
-- ------------------- -- ------ ------------------- --

CREATE TABLE direccionCliente (
    idDireccion INT NOT NULL,
    idCliente VARCHAR(255) NOT NULL,
    pais VARCHAR(100) NOT NULL, -- Validar la capacidad envíos a otros países y ciudadades (¿Se tiene que clasificar?)
    ciudad VARCHAR(100) NOT NULL,
    barrio VARCHAR(200) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    infoExtra VARCHAR(255) NULL,
    PRIMARY KEY (idDireccion),
    FOREIGN KEY (idCliente) REFERENCES cliente(idCliente)
);

CREATE TABLE domiciliario (
    idDomiciliario INT NOT NULL,
    nombrecompleto VARCHAR(255) NOT NULL,
    numdocumentoDomiciliario INT NOT NULL UNIQUE,
    edad INT NOT NULL,
    PRIMARY KEY (idDomiciliario)
);
 
CREATE TABLE metodoTransporte (
    idMetodoTransp INT AUTO_INCREMENT NOT NULL,
    idDomiciliario INT NOT NULL,
    nombreTranspo VARCHAR(150) NOT NULL,
    vehiculo VARCHAR(100) NOT NULL,
    PRIMARY KEY (idMetodoTransp)
);

CREATE TABLE envio (
    idEnvio INT AUTO_INCREMENT NOT NULL,
    idCliente VARCHAR(255) NOT NULL,
    idDireccion INT NOT NULL,
    idCompra INT NOT NULL,
    idMetodoTranspo INT NOT NULL,
    idAdmin VARCHAR(255) NOT NULL,
    estadoEnvio VARCHAR(100) NOT NULL,
    fechaHoraEntrega DATETIME NULL,
    calificacionEnvio VARCHAR(20) NOT NULL,
    PRIMARY KEY (idEnvio),
    FOREIGN KEY (idCliente) REFERENCES cliente(idCliente),
    FOREIGN KEY (idDireccion) REFERENCES direccionCliente(idDireccion),
    FOREIGN KEY (idCompra) REFERENCES compra(idCompra),
    FOREIGN KEY (idMetodoTranspo) REFERENCES metodoTransporte(idMetodoTransp),
    FOREIGN KEY (idAdmin) REFERENCES administrador(idAdmin),
    CONSTRAINT checkEstadoEnvio CHECK (estadoEnvio IN('Preparacion', 'Despachado', 'En camino', 'Entregado'))
);


