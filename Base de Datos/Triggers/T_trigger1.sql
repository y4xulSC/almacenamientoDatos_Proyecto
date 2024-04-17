-- Triggers customer table 

DELIMITER $$ 
CREATE TRIGGER before_delete_usuario BEFORE DELETE ON usuario
FOR EACH ROW 
BEGIN
    DECLARE pending_orders INT;
    SELECT COUNT(*) INTO pending_orders FROM pedido WHERE idUsuario = OLD.idUsuario AND estado = 'PENDIENTE';

    IF pending_orders > 0 THEN 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede eliminar el usuario debido a que tiene pedidos pendientes';
    END IF;
END $$
DELIMITER ;




-- Trigger para la tabla rol 
DELIMITER $$
CREATE TRIGGER after_insert_rol AFTER INSERT ON rol
FOR EACH ROW 
BEGIN
    -- Asignar permisos predeterminados al nuevo rol
    INSERT INTO permisos_rol (idRol, permiso)
    VALUES (NEW.idRol, 'crear_contenido'), (NEW.idRol, 'editar_contenido'), (NEW.idRol, 'eliminar_contenido');
END $$
DELIMITER ;


-- Trigger para la tabla producto 
DELIMITER $$

CREATE TRIGGER after_insert_producto AFTER INSERT ON producto 
FOR EACH ROW 
BEGIN 
    -- Actualizar la cantidad de stock en el inventario del producto 
    UPDATE inventario 
    SET cantidad = CANTIDAD + NEW.cantidadStock
    WHERE idProducto = NEW.idProducto;

    -- Registrar la insercion 
    INSERT INTO registro_actividad (accion, descripcion, fecha)
    VALUES ('Nuevo producto agregado', CONCAT('Se agrego un nuevo producto con ID', NEW.idProducto), NOW());

END$$ 
DELIMITER $$


-- Trigger para la tabla promociones 
DELIMITER $$ 
CREATE TRIGGER after_insert_promociones AFTER INSERT ON promociones 
FOR EACH ROW
BEGIN 
    -- Actualizar precios productos con prom
    UPDATE producto
    SET precio = precio - (precio * NEW.descuento / 100)
    WHERE idProducto = NEW.idProducto;

    -- registrar la nueva promocion 
    INSERT INTO registro_actividad (accion, descripcion, fecha)
    VALUES ('Nueva promocion creada', CONCAT('Se creo una nueva promocion para el producto con ID', NEW.idProducto), NOW());
END$$
DELIMITER;


-- Trigger para la tabla paquete 
DELIMITER $$
CREATE TRIGGER after_insert_paquete AFTER INSERT ON paquete 
FOR EACH ROW 
BEGIN 
    -- Actualizar la cantidad de stock del producto relacionado con el paquete 
    UPDATE producto
    SET cantidadStock = cantidadStock + NEW.cantidadProducto
    WHERE idProducto = NEW.idProducto;

    -- Registrar la insercion del nuevo paquete 
    INSERT INTO registro_actividad (accion, descripcion, fecha)
    VALUES ('Nuevo paquete agregado', CONCAT('Se agrego un nuevo paquete con ID', NEW.idPaquete), NOW());
END$$
DELIMITER;


-- Trigger para la tabla pedido 
DELIMITER $$
CREATE TRIGGER after_insert_pedido AFTER INSERT ON pedido
FOR EACH ROW
BEGIN

    -- Actualizar el estado del producto asociado al pedido
    UPDATE producto
    SET estado = 'ENVIADO'
    WHERE idProducto IN (SELECT idProducto FROM productoPedido WHERE idPedido = NEW.idPedido);

    -- registrar la insercion
    INSERT INTO registro_actividad (accion, descripcion, fecha)
    VALUES ('Nuevo pedido realizado', CONCAT('Se realizo un nuevo pedido con ID', NEW.idPedido), NOW());
END $$
DELIMITER;

-- Trigger para la tabla productoPedido
DELIMITER $$
CREATE TRIGGER after_insert_productoPedido AFTER INSERT ON productoPedido
FOR EACH ROW
BEGIN
    -- Actualizar la cantidad de Stock
    UPDATE producto 
    SET cantidadStock = cantidadStock - NEW.cantidadProducto
    WHERE idProducto = NEW.idProducto;

    -- Registrar la insercion del nuevo producto en el pedido que se registro 
    INSERT INTO registro_actividad (accion, descripcion, fecha)
    VALUES ('Nuevo producto agregado al pedido', CONCAT('Se agrego un nuevo producto al pedido con ID', NEW.idPedido), NOW());
END $$
DELIMITER;


-- Trigger para la tabla detalleEnvio

DELIMITER $$
CREATE TRIGGER after_insert_detalleEnvio AFTER INSERT ON detalleEnvio
FOR EACH ROW
BEGIN
    -- Actualizar el estado del pedido asociado al detalle del envio 
    UPDATE pedido
    SET estado = 'ENVIADO'
    WHERE idPedido = NEW.idPedido;

    -- Registrar la insercion del nuevo detalle de envio en el registro
    INSERT INTO registro_actividad (accion, descripcion, fecha)
    VALUES ('Nuevo detalle de envio agregado', CONCAT('Se agrego un nuevo detalle de envio con ID', NEW.idDetalleEnvio), NOW());
END$$
DELIMITER ;


--Trigger para la tabla comentario
DELIMITER $$
CREATE TRIGGER before_insert_comentario BEFORE INSERT ON comentario
FOR EACH ROW
BEGIN
    DECLARE usuario_tiene_acceso BOOLEAN;

    -- Verificar si el usuario ha comprado el producto antes de comentarlo
    SELECT COUNT(*) INTO usuario_tiene_acceso
    FROM pedido p
    JOIN productoPedido pp ON p.idPedido = pp.idPedido
    WHERE p.idUsuario = NEW.idUsuario AND pp.idProducto = NEW.idProducto;

    IF usuario_tiene_acceso = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No puedes comentar un producto que no has comprado previamente. ';
    END IF;
END$$

CREATE TRIGGER after_insert_comentario AFTER INSERT ON comentario 
FOR EACH ROW
BEGIN 
    -- Actualizar la calificacion promedio del producto asociada al comentario 
    UPDATE producto
    SET calificacionPromedio = (
        SELECT AVG(calificacion) FROM comentario WHERE idProducto = NEW.idProducto
    )
    WHERE idProducto = NEW.idProducto;

    -- Registrar la inserción del nuevo comentario en el registro de actividad
    INSERT INTO registro_actividad (accion, descripcion, fecha) 
    VALUES ('Nuevo comentario agregado', CONCAT('Se agregó un nuevo comentario con ID ', NEW.idComentario), NOW());
END$$
DELIMITER ;
