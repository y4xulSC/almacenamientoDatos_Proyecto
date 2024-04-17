-- Ejemplo
-- CREATE FUNCTION validarTelefono(telefono VARCHAR) RETURN BOOLEAN
-- BEGIN
--     DECLARE valido BOOLEAN;
--     SET valido = (telefono REGEXP '^[0-9]{10}$');
--     RETURN valido;
-- END;
-- Lista de todas las funciones 
-- VAlidación del login
-- Validar que un usuario ya haya comprado un producto para realizar un comentario
-- Historico de compras de un usuario
-- Validar que en la compra el producto que se compra aplica o no alguna promocion
-- Validar la existencia del usuario
-- Verificar si un producto esta en un paquete de productos
-- Buscar un producto en pedidos
-- Buscar todos los comentarios relacionados a un producto 
-- devuelve los comentarios realizador por un usuario

-- VAlidación del login
DELIMITER //
CREATE FUNCTION validarLogin (
    var_nombreUsuario VARCHAR(255),
    var_contrasena VARCHAR(255),
    var_rol ENUM('Administrador', 'Cliente')
) RETURNS BOOLEAN
READS SQL DATA
BEGIN
    DECLARE resultado BOOLEAN;
    SELECT COUNT(*) INTO resultado
    FROM usuario AS u
    INNER JOIN rol AS r ON u.idUsuario = r.idUsuario
    WHERE
        (u.nombreUsuario = var_nombreUsuario OR u.email = var_nombreUsuario)
        AND r.contrasena = var_contrasena
        AND r.nombreRol = var_rol;
    RETURN resultado;
END //
DELIMITER ;
SELECT validarLogin(
	'nombre_de_usuario', 
	-- 'email@uao.edu.co', 
    '123',
    'Cliente');

-- Validar que un usuario ya haya comprado un producto para realizar un comentario
DELIMITER //
CREATE FUNCTION validarPedidoParaComentario(
    var_idUsuario INT,
    var_idProducto INT
) RETURNS BOOLEAN
READS SQL DATA
BEGIN
    DECLARE tienePedido BOOLEAN;
    -- Verificar si el usuario tiene el rol de cliente
    IF (SELECT COUNT(*) FROM rol WHERE idUsuario = var_idUsuario AND nombreRol = 'Cliente') > 0 THEN
        -- Verificar si el usuario ha realizado algún pedido
        IF (SELECT COUNT(*) FROM pedido WHERE idUsuario = var_idUsuario) > 0 THEN
            -- Verificar si el usuario ha realizado un pedido que incluya el producto específico
            IF (SELECT COUNT(*) FROM productoPedido WHERE idPedido IN (SELECT idPedido FROM pedido WHERE idUsuario = var_idUsuario) AND idProducto = var_idProducto) > 0 THEN
                SET tienePedido = TRUE;
            ELSE
                SET tienePedido = FALSE;
            END IF;
        ELSE
            SET tienePedido = FALSE;
        END IF;
    ELSE
        SET tienePedido = FALSE;
    END IF;
    RETURN tienePedido;
END //
DELIMITER ;
SELECT validarPedidoParaComentario(1,1);

-- Historico de compras de un usuario
DELIMITER //
CREATE FUNCTION obtenerHistorialCompras (
    var_idUsuario INT
) RETURNS TEXT
READS SQL DATA
BEGIN
    DECLARE historial TEXT;
    SELECT GROUP_CONCAT(CONCAT(p.nombre, ', ', pp.cantidadProducto, ', ', pe.fechaHoraPedido) SEPARATOR '; ')
    INTO historial
    FROM productoPedido AS pp
    INNER JOIN pedido AS pe ON pp.idPedido = pe.idPedido
    INNER JOIN producto AS p ON pp.idProducto = p.idProducto
    WHERE pe.idUsuario = var_idUsuario;
    RETURN historial;
END //
DELIMITER ;
SELECT obtenerHistorialCompras(1);

-- Validar que en la compra el producto que se compra aplica o no alguna promocion
DELIMITER //
CREATE FUNCTION validarPrecioConPromocion (
    var_idProducto INT,
    var_fechaPedido DATE,
    var_cantidad INT
) RETURNS BOOLEAN
READS SQL DATA
BEGIN
    DECLARE precioProducto DECIMAL(10,2);
    DECLARE precioConDescuento DECIMAL(10,2);
    -- Obtener el precio del producto
    SELECT precio INTO precioProducto FROM producto WHERE idProducto = var_idProducto;
    -- Obtener el descuento de la promoción para el producto y la fecha del pedido
    SELECT IFNULL(MAX(descuento), 0) INTO precioConDescuento
    FROM promociones
    WHERE idProducto = var_idProducto
    AND var_fechaPedido BETWEEN fechaInicio AND fechaFin;
    -- Calcular el precio con descuento
    SET precioConDescuento = precioProducto * (1 - precioConDescuento/100);
    -- Comparar el precio con descuento con el precio original multiplicado por la cantidad
    IF precioConDescuento * var_cantidad < precioProducto * var_cantidad THEN
        RETURN TRUE; -- El precio total con descuento es menor que el precio total original
    ELSE
        RETURN FALSE; -- El precio total con descuento es igual o mayor que el precio total original
    END IF;
END //
DELIMITER ;
SELECT validarPrecioConPromocion(1,'2024-04-16 21:30:15',3);
SELECT validarPrecioConPromocion(1,'2024-05-03 21:30:15',5);

-- Validar la existencia del usuario
DELIMITER //
CREATE FUNCTION verificarExistenciaUsuario (
    var_nombreUsuarioCorreo VARCHAR(255)
) RETURNS BOOLEAN
READS SQL DATA
BEGIN
    DECLARE existe BOOLEAN;
    -- Verificar si existe un usuario con el nombre de usuario o correo electrónico proporcionado
    SELECT EXISTS (
        SELECT 1 FROM usuario WHERE nombreUsuario = var_nombreUsuarioCorreo OR email = var_nombreUsuarioCorreo
    ) INTO existe;

    RETURN existe;
END //
DELIMITER ;
SELECT verificarExistenciaUsuario('email@uao.edu.co');
SELECT verificarExistenciaUsuario('nombre_de_usuario');

-- Verificar si un producto esta en un paquete de productos
DELIMITER //
CREATE FUNCTION verificarExistenciaProductoEnPaquete (
    var_idProducto INT
) RETURNS BOOLEAN
READS SQL DATA
BEGIN
    DECLARE existe BOOLEAN;

    -- Verificar si el producto está incluido en algún paquete
    SELECT EXISTS (
        SELECT 1 FROM paquete WHERE idProducto = var_idProducto
    ) INTO existe;

    RETURN existe;
END //
DELIMITER ;
SELECT verificarExistenciaProductoEnPaquete(1);

-- Buscar un producto en pedidos
DELIMITER //
CREATE FUNCTION buscarPedidosPorProducto (
    var_idProducto INT
) RETURNS 
    VARCHAR(255)
READS SQL DATA
BEGIN
    DECLARE result VARCHAR(255);

    SELECT GROUP_CONCAT(
        CONCAT('ID Pedido: ', p.idPedido, ', ID Usuario: ', p.idUsuario, ', Fecha Hora Pedido: ', p.fechaHoraPedido, ', Estado: ', p.estado, ', Total: ', p.total)
        SEPARATOR '; '
    ) INTO result
    FROM productoPedido AS pp
    INNER JOIN pedido AS p ON pp.idPedido = p.idPedido
    WHERE pp.idProducto = var_idProducto;

    RETURN result;
END //
DELIMITER ;
SELECT buscarPedidosPorProducto(1);

-- Buscar todos los comentarios relacionados a un producto 
DELIMITER //
CREATE FUNCTION buscarComentariosPorProducto (
    var_idProducto INT
) RETURNS 
    VARCHAR(4000)
READS SQL DATA
BEGIN
    DECLARE result VARCHAR(4000);
    SELECT GROUP_CONCAT(
        CONCAT('Comentario: ', c.comentario, ', Calificación: ', c.calificacion)
        SEPARATOR '; '
    ) INTO result
    FROM comentario AS c
    WHERE c.idProducto = var_idProducto;
    RETURN result;
END //
DELIMITER ;
SELECT buscarComentariosPorProducto(1);


-- devuelve los comentarios realizador por un usuario
DELIMITER //
CREATE FUNCTION obtenerComentariosPorUsuario (
    var_idUsuario INT
) RETURNS TEXT
READS SQL DATA
BEGIN
    DECLARE comentarios TEXT;

    SELECT GROUP_CONCAT(CONCAT(comentario, '(Comentario', idComentario, ')') SEPARATOR '; ') INTO comentarios
    FROM comentario
    WHERE idUsuario = var_idUsuario;

    RETURN comentarios;
END //
DELIMITER ;
SELECT obtenerComentariosPorUsuario(1);

-- relaciona usuarios con la ciudad
DELIMITER //
CREATE FUNCTION relacionarUsuariosConCiudad (
    var_idUsuario INT
) RETURNS VARCHAR(255)
READS SQL DATA
BEGIN
    DECLARE ciudadUsuario VARCHAR(255);
    SELECT c.nombre
    INTO ciudadUsuario
    FROM usuario AS u
    INNER JOIN ciudad AS c ON u.idCiudad = c.idCiudad
    WHERE u.idUsuario = var_idUsuario;
    RETURN ciudadUsuario;
END //
DELIMITER ;