-- ------------------------------- Actualizaciones ------------------------------- --

-- usuario
DELIMITER //
CREATE PROCEDURE actualizar_usuario(
    IN var_idUsuario INT,
    IN var_nombreUsuario VARCHAR(100),
    IN var_nombre VARCHAR(255),
    IN var_email VARCHAR(255),
    IN var_telefono BIGINT,
    IN var_edad INT,
    IN var_sexo ENUM('Hombre', 'Mujer')
)
BEGIN
    UPDATE usuario
    SET 
        nombreUsuario = var_nombreUsuario,
        nombre = var_nombre,
        email = var_email,
        telefono = var_telefono,
        edad = var_edad,
        sexo = var_sexo
    WHERE idUsuario = var_idUsuario;
END//
DELIMITER ;
-- CALL nombre();

-- rol
DELIMITER //
CREATE PROCEDURE actualizar_rol(
    IN var_idRol INT,
    IN var_nombreRol ENUM('Administrador', 'Cliente'),
    IN var_contrasena VARCHAR(255),
    IN var_idUsuario INT
)
BEGIN
    UPDATE rol
    SET 
        nombreRol = var_nombreRol,
        contrasena = var_contrasena,
        idUsuario = var_idUsuario
    WHERE idRol = var_idRol;
END//
DELIMITER ;
-- CALL nombre();

-- diseno
DELIMITER //
CREATE PROCEDURE actualizar_diseno(
    IN var_idDiseno INT,
    IN var_nombreDiseno VARCHAR(50),
    IN var_categoria VARCHAR(100)
)
BEGIN
    UPDATE diseno
    SET 
        nombreDiseno = var_nombreDiseno,
        categoria = var_categoria
    WHERE idDiseno = var_idDiseno;
END//
DELIMITER ;
-- CALL nombre();

-- producto
DELIMITER //
CREATE PROCEDURE actualizar_producto(
    IN var_idDiseno INT,
    IN var_nombre VARCHAR(255),
    IN var_precio DECIMAL(10,2),
    IN var_genero ENUM('Hombre','Mujer','Niño'),
    IN var_talla VARCHAR(5),
    IN var_imagen BLOB,
    IN var_descripcion VARCHAR(200),
    IN var_color VARCHAR(10),
    IN var_cantidadStock INT
)
BEGIN
    UPDATE producto
    SET 
        nombre = var_nombre,
        precio = var_precio,
        genero = var_genero,
        talla = var_talla,
        imagen = var_imagen,
        descripcion = var_descripcion,
        color = var_color,
        cantidadStock = var_cantidadStock
    WHERE idDiseno = var_idDiseno;
END//
DELIMITER ;
-- CALL nombre();

-- promociones
DELIMITER //
CREATE PROCEDURE actualizar_promociones(
    IN var_idPromociones INT,
    IN var_idProducto INT,
    IN var_fechaInicio DATE,
    IN var_horaInicio TIME,
    IN var_fechaFin DATE,
    IN var_horaFin TIME,
    IN var_descuento DECIMAL(10,2)
)
BEGIN
    UPDATE promociones
    SET 
        idProducto = var_idProducto,
        fechaInicio = var_fechaInicio,
        horaInicio = var_horaInicio,
        fechaFin = var_fechaFin,
        horaFin = var_horaFin,
        descuento = var_descuento
    WHERE idPromociones = var_idPromociones;
END//
DELIMITER ;
-- CALL nombre();

-- paquete
DELIMITER //
CREATE PROCEDURE actualizar_paquete(
    IN var_idPaquete INT,
    IN var_idProducto INT,
    IN var_cantidadProducto INT,
    IN var_tipoProducto VARCHAR(20)
)
BEGIN
    UPDATE paquete
    SET 
        idProducto = var_idProducto,
        cantidadProducto = var_cantidadProducto,
        tipoProducto = var_tipoProducto
    WHERE idPaquete = var_idPaquete;
END//
DELIMITER ;
-- CALL nombre();

-- pedido
DELIMITER //
CREATE PROCEDURE actualizar_pedido(
    IN var_idPedido INT,
    IN var_idUsuario INT,
    IN var_fechaHoraPedido DATETIME,
    IN var_estado ENUM('PENDIENTE', 'PROCESADO', 'ENVIADO', 'ENTREGADO'),
    IN var_total DECIMAL(15,2)
)
BEGIN
    UPDATE pedido
    SET 
        idUsuario = var_idUsuario,
        fechaHoraPedido = var_fechaHoraPedido,
        estado = var_estado,
        total = var_total
    WHERE idPedido = var_idPedido;
END//
DELIMITER ;
-- CALL nombre();

-- productoPedido
DELIMITER //
CREATE PROCEDURE actualizar_productoPedido (
    IN var_idPedido INT,
    IN var_idProducto INT,
    IN var_cantidadProducto INT
)
BEGIN
    UPDATE productoPedido
    SET cantidadProducto = var_cantidadProducto
    WHERE var_idPedido = idPedido AND var_idProducto = idProducto;
END//
DELIMITER ;
-- CALL nombre();

-- departamento
DELIMITER //
CREATE PROCEDURE actualizar_departamento(
    IN var_idDepartamento INT,
    IN var_nombre VARCHAR(60)
)
BEGIN
    UPDATE departamento
    SET nombre = var_nombre
    WHERE idDepartamento = var_idDepartamento;
END//
DELIMITER ;
-- CALL nombre();

-- ciudad
DELIMITER //
CREATE PROCEDURE actualizar_ciudad(
    IN var_idCiudad INT,
    IN var_idDepartamento INT,
    IN var_nombre VARCHAR(60),
    IN var_codigoPostal INT
)
BEGIN
    UPDATE ciudad
    SET 
        idDepartamento = var_idDepartamento,
        nombre = var_nombre,
        codigoPostal = var_codigoPostal
    WHERE idCiudad = var_idCiudad;
END//
DELIMITER ;
-- CALL nombre();

-- detalleEnvio
DELIMITER //
CREATE PROCEDURE actualizar_detalleEnvio(
    IN var_idDetalleEnvio INT,
    IN var_idPedido INT,
    IN var_idCiudad INT,
    IN var_barrio VARCHAR(150),
    IN var_direccion VARCHAR(255),
    IN var_numero INT,
    IN var_infoExtra VARCHAR(255),
    IN var_pais VARCHAR(255)
)
BEGIN
    UPDATE detalleEnvio
    SET 
        idPedido = var_idPedido,
        idCiudad = var_idCiudad,
        barrio = var_barrio,
        direccion = var_direccion,
        numero = var_numero,
        infoExtra = var_infoExtra,
        pais = var_pais
    WHERE idDetalleEnvio = var_idDetalleEnvio;
END//
DELIMITER ;
-- CALL nombre();

-- comentario
DELIMITER //
CREATE PROCEDURE actualizar_comentario(
    IN var_idComentario INT,
    IN var_idUsuario INT,
    IN var_idProducto INT,
    IN var_comentario VARCHAR(200),
    IN var_calificacion INT
)
BEGIN
    UPDATE comentario
    SET 
        idUsuario = var_idUsuario,
        idProducto = var_idProducto,
        comentario = var_comentario,
        calificacion = var_calificacion
    WHERE idComentario = var_idComentario;
END//
DELIMITER ;
-- CALL nombre();

-- ------------------------------- --------------- ------------------------------- --