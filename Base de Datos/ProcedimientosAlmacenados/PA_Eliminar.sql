-- ----------------------------------- Eliminar ---------------------------------- --

-- usuario
DELIMITER //
CREATE PROCEDURE eliminar_usuario(
    IN var_id_usuario INT
)
BEGIN
    DELETE FROM usuario
    WHERE idUsuario = var_id_usuario;
END//
DELIMITER ;
-- CALL nombre();

-- rol
DELIMITER //
CREATE PROCEDURE eliminar_rol(
    IN var_id_rol INT
)
BEGIN
    DELETE FROM rol
    WHERE idRol = var_id_rol;
END//
DELIMITER ;
-- CALL nombre();

-- diseno
DELIMITER //
CREATE PROCEDURE eliminar_diseno(
    IN var_id_diseno INT
)
BEGIN
    DELETE FROM diseno
    WHERE idDiseno = var_id_diseno;
END//
DELIMITER ;
-- CALL nombre();

-- producto
DELIMITER //
CREATE PROCEDURE eliminar_producto(
    IN var_id_producto INT
)
BEGIN
    DELETE FROM producto
    WHERE idProducto = var_id_producto;
END//
DELIMITER ;
-- CALL nombre();

-- promociones
DELIMITER //
CREATE PROCEDURE eliminar_promociones(
    IN var_id_promociones INT
)
BEGIN
    DELETE FROM promociones
    WHERE idPromocion = var_id_promociones;
END//
DELIMITER ;
-- CALL nombre();

-- paquete
DELIMITER //
CREATE PROCEDURE eliminar_paquete(
    IN var_id_paquete INT
)
BEGIN
    DELETE FROM paquete
    WHERE idPaquete = var_id_paquete;
END//
DELIMITER ;
-- CALL nombre();

-- pedido
DELIMITER //
CREATE PROCEDURE eliminar_pedido(
    IN var_id_pedido INT
)
BEGIN
    DELETE FROM pedido
    WHERE idPedido = var_id_pedido;
END//
DELIMITER ;
-- CALL nombre();

-- productoPedido
DELIMITER //
CREATE PROCEDURE eliminar_productoPedido(
    IN var_id_pedido INT
    IN var_id_producto INT
)
BEGIN
    DELETE FROM productoPedido
    WHERE idPedido = var_id_pedido AND idProducto = var_id_producto;
END//
DELIMITER ;
-- CALL nombre();

-- departamento
DELIMITER //
CREATE PROCEDURE eliminar_departamento(
    IN var_id_departamento INT
)
BEGIN
    DELETE FROM departamento
    WHERE id = var_id_departamento;
END//
DELIMITER ;
-- CALL nombre();

-- ciudad
DELIMITER //
CREATE PROCEDURE eliminar_ciudad(
    IN var_id_ciudad INT
)
BEGIN
    DELETE FROM ciudad
    WHERE id = var_id_ciudad;
END//
DELIMITER ;
-- CALL nombre();

-- detalleEnvio
DELIMITER //
CREATE PROCEDURE eliminar_detalleEnvio(
    IN var_id_detalleEnvio INT
)
BEGIN
    DELETE FROM detalleEnvio
    WHERE id = var_id_detalleEnvio;
END//
DELIMITER ;
-- CALL nombre();

-- comentario
DELIMITER //
CREATE PROCEDURE eliminar_comentario(
    IN var_id_comentario INT
)
BEGIN
    DELETE FROM comentario
    WHERE id = var_id_comentario;
END//
DELIMITER ;
-- CALL nombre();


-- ----------------------------------- -------- ---------------------------------- --