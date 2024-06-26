-- --------------------------------- Insersiones --------------------------------- --

-- departamento
DELIMITER //
CREATE PROCEDURE insertar_departamento(
    IN var_nombre VARCHAR(60)
)
BEGIN
    INSERT INTO departamento(nombre)
    VALUES (var_nombre);
END//
DELIMITER ;
CALL insertar_departamento("Antioquia");
CALL insertar_departamento("Barranquilla");
CALL insertar_departamento("Cundinamarca");
CALL insertar_departamento("Valle del Cauca");

-- ciudad
DELIMITER //
CREATE PROCEDURE insertar_ciudad(
    IN var_idDepartamento INT,
    IN var_nombre VARCHAR(60),
    IN var_codigoPostal INT
)
BEGIN
    INSERT INTO ciudad(idDepartamento, nombre, codigoPostal)
    VALUES (var_idDepartamento, var_nombre, var_codigoPostal);
END//
DELIMITER ;
CALL insertar_ciudad(1, "Medellín", 11);
CALL insertar_ciudad(2, "Barranquilla", 22);
CALL insertar_ciudad(3, "Bogotá", 33);
CALL insertar_ciudad(4, "Cali", 44);

-- usuario
DELIMITER //
CREATE PROCEDURE insertar_usuario(
    IN var_nombreUsuario VARCHAR(100),
    IN var_nombre VARCHAR(255),
    IN var_email VARCHAR(255),
    IN var_telefono BIGINT,
    IN var_edad INT,
    IN var_sexo ENUM('Hombre', 'Mujer'),
    IN var_idCiudad INT
)
BEGIN
    INSERT INTO usuario (nombreUsuario, nombre, email, telefono, edad, sexo, idCiudad)
    VALUES (var_nombreUsuario, var_nombre, var_email, var_telefono, var_edad, var_sexo, var_idCiudad);
END//
DELIMITER ;
CALL insertar_usuario('nombre_de_usuario', 'nombre del usuario', 'email@uao.edu.co', 1234567890, 25, 'Hombre', 1);

-- rol
DELIMITER //
CREATE PROCEDURE insertar_rol(
    IN var_nombreRol ENUM('Administrador', 'Cliente'),
    IN var_contrasena VARCHAR(255),
    IN var_idUsuario INT
)
BEGIN
    INSERT INTO rol(nombreRol, contrasena, idUsuario)
    VALUES (var_nombreRol, var_contrasena, var_idUsuario);
END//
DELIMITER ;
CALL insertar_rol("Cliente", "123", 1);

-- diseno
DELIMITER //
CREATE PROCEDURE insertar_diseno(
    IN var_nombreDiseno VARCHAR(50),
    IN var_categoria VARCHAR(100)
)
BEGIN
    INSERT INTO diseno(nombreDiseno, categoria)
    VALUES (var_nombreDiseno, var_categoria);
END//
DELIMITER ;
CALL insertar_diseno("Diseño predeterminado", "Cualquiera");

-- producto
DELIMITER //
CREATE PROCEDURE insertar_producto(
    IN var_nombre VARCHAR(255),
    IN var_precio DECIMAL(10,2),
    IN var_genero ENUM('Hombre','Mujer','Niño'),
    IN var_talla VARCHAR(5),
    IN var_imagen BLOB,
    IN var_descripcion VARCHAR(200),
    IN var_color VARCHAR(10),
    IN var_cantidadStock INT,
    IN var_idDiseno INT
)
BEGIN
    INSERT INTO producto(nombre, precio, genero, talla, imagen, descripcion, color, cantidadStock, idDiseno)
    VALUES (var_nombre, var_precio, var_genero, var_talla, var_imagen, var_descripcion, var_color, var_cantidadStock, var_idDiseno);
END//
DELIMITER ;
CALL insertar_producto("Tenis deportivos", 209000, "Niño", "26", null, "Tenis deportivos para niños", "Negro", 80, 1);

-- promociones
DELIMITER //
CREATE PROCEDURE insertar_promociones(
    IN var_idProducto INT,
    IN var_fechaInicio DATE,
    IN var_horaInicio TIME,
    IN var_fechaFin DATE,
    IN var_horaFin TIME,
    IN var_descuento DECIMAL(10,2)
)
BEGIN
    INSERT INTO promociones(idProducto, fechaInicio, horaInicio, fechaFin, horaFin, descuento)
    VALUES (var_idProducto, var_fechaInicio, var_horaInicio, var_fechaFin, var_horaFin, var_descuento);
END//
DELIMITER ;
CALL insertar_promociones(1, "2024-05-01", "08:00:00", "2024-05-10", "23:59:59", 5.00);

-- paquete
DELIMITER //
CREATE PROCEDURE insertar_paquete(
    IN var_idProducto INT,
    IN var_cantidadProducto INT,
    IN var_tipoProducto VARCHAR(20)
)
BEGIN
    INSERT INTO paquete(idProducto, cantidadProducto, tipoProducto)
    VALUES (var_idProducto,var_cantidadProducto,var_tipoProducto);
END//
DELIMITER ;
CALL insertar_paquete(1, 3, "Tenis");

-- pedido
DELIMITER //
CREATE PROCEDURE insertar_pedido(
    IN var_idUsuario INT,
    IN var_fechaHoraPedido DATETIME,
    IN var_estado ENUM('PENDIENTE', 'PROCESADO', 'ENVIADO', 'ENTREGADO'),
    IN var_total DECIMAL(15,2)
)
BEGIN
    INSERT INTO pedido(idUsuario, fechaHoraPedido, estado, total)
    VALUES (var_idUsuario, var_fechaHoraPedido, var_estado, var_total);
END//
DELIMITER ;
CALL insertar_pedido(1, CURRENT_TIMESTAMP, "PENDIENTE", 198550.00);

-- productoPedido
DELIMITER //
CREATE PROCEDURE insertar_productoPedido(
    IN var_idPedido INT,
    IN var_idProducto INT,
    IN var_cantidadProducto INT
)
BEGIN
    INSERT INTO productoPedido(idPedido, idProducto, cantidadProducto)
    VALUES (var_idPedido, var_idProducto, var_cantidadProducto);
END//
DELIMITER ;
CALL insertar_productoPedido(1, 1, 1);

-- detalleEnvio
DELIMITER //
CREATE PROCEDURE insertar_detalleEnvio(
    IN var_idPedido INT,
    IN var_idCiudad INT,
    IN var_barrio VARCHAR(150),
    IN var_direccion VARCHAR(255),
    IN var_numero INT,
    IN var_infoExtra VARCHAR(255),
    IN var_pais VARCHAR(255)
)
BEGIN
    INSERT INTO detalleEnvio(idPedido, idCiudad, barrio, direccion, numero, infoExtra, pais)
    VALUES (var_idPedido, var_idCiudad, var_barrio, var_direccion, var_numero, var_infoExtra, var_pais);
END//
DELIMITER ;
CALL insertar_detalleEnvio(1, 1, "Barrio Imaginario", "Calle 123", 34, "Conjunto residencial 1 - apto 78", "Colombia");

-- comentario
DELIMITER //
CREATE PROCEDURE insertar_comentario(
    IN var_idUsuario INT,
    IN var_idProducto INT,
    IN var_comentario VARCHAR(200),
    IN var_calificacion INT
)
BEGIN
    INSERT INTO comentario(idUsuario, idProducto, comentario, calificacion)
    VALUES (var_idUsuario, var_idProducto, var_comentario, var_calificacion);
END//
DELIMITER ;
CALL insertar_comentario(1, 1, "Excelente producto", 5);

-- --------------------------------- ----------- --------------------------------- --