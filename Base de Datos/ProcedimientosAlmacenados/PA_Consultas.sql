-- ---------------------------------- Consultas ---------------------------------- --

-- usuario x productos comprados
DELIMITER //
CREATE PROCEDURE compraProductosXusuario ()
BEGIN
    SELECT 
        u.nombreUsuario AS 'Nombre de usuario',
        COUNT(DISTINCT pp.idProducto) AS 'Cantidad productos comprados',
        SUM(p.total) AS 'Total compras'
    FROM 
        usuario u
        INNER JOIN pedido p ON u.idUsuario = p.idUsuario
        INNER JOIN productoPedido pp ON p.idPedido = pp.idPedido
    GROUP BY 
        u.nombreUsuario;
END//
DELIMITER ;
CALL compraProductosXusuario();

-- creacion de factura 
DELIMITER // 
CREATE PROCEDURE creacionFactura ()
BEGIN
    SELECT 
        p.idPedido AS 'Número de Pedido',
        u.nombre AS 'Nombre del Cliente',
        u.email AS 'Email del Cliente',
        p.fechaHoraPedido AS 'Fecha y Hora del Pedido',
        pd.nombre AS 'Nombre del Producto',
        pp.cantidadProducto AS 'Cantidad',
        pd.precio AS 'Precio Unitario',
        (pp.cantidadProducto * pd.precio) AS 'Subtotal',
        d.barrio AS 'Barrio',
        d.direccion AS 'Dirección de Envío',
        d.numero AS 'Número',
        d.infoExtra AS 'Información Extra',
        c.nombre AS 'Ciudad',
        depto.nombre AS 'Departamento',
        c.codigoPostal AS 'Código Postal'
    FROM 
        pedido p
        INNER JOIN usuario u ON p.idUsuario = u.idUsuario
        INNER JOIN productoPedido pp ON p.idPedido = pp.idPedido
        INNER JOIN producto pd ON pp.idProducto = pd.idProducto
        INNER JOIN detalleEnvio d ON p.idPedido = d.idPedido
        INNER JOIN ciudad c ON d.idCiudad = c.idCiudad
        INNER JOIN departamento depto ON c.idDepartamento = depto.idDepartamento
    -- WHERE p.idPedido = Numero_pedido
    ;
END//
DELIMITER ;
CALL creacionFactura();

-- Productos mas caro 
DELIMITER //
CREATE PROCEDURE producto_mas_caro ()
BEGIN 
    SELECT 
        nombre AS 'Nombre del Producto Más Caro',
        precio AS 'Precio'
    FROM 
        producto
    WHERE 
        precio = (SELECT MAX(precio) FROM producto);
END //
DELIMITER ;
CALL producto_mas_caro();

-- Productos mas vendidos
DELIMITER //
CREATE PROCEDURE productos_mas_vendido ()
BEGIN 
    SELECT 
        p.nombre AS 'Nombre del Producto Más Vendido',
        SUM(pp.cantidadProducto) AS 'Cantidad Total Vendida'
    FROM 
        producto p
        INNER JOIN productoPedido pp ON p.idProducto = pp.idProducto
    GROUP BY 
        p.nombre
    ORDER BY 
        SUM(pp.cantidadProducto) DESC;
END //
DELIMITER ;
CALL productos_mas_vendido();

--Productos más vendido por Ciudad
DELIMITER //
CREATE PROCEDURE productos_mas_vendido_ciudad()
BEGIN 
    SELECT 
        c.nombre AS 'Ciudad',
        p.nombre AS 'Nombre del Producto Más Vendido',
        SUM(pp.cantidadProducto) AS 'Cantidad Total Vendida'
    FROM 
        producto p
        INNER JOIN productoPedido pp ON p.idProducto = pp.idProducto
        INNER JOIN pedido ped ON pp.idPedido = ped.idPedido
        INNER JOIN detalleEnvio de ON ped.idPedido = de.idPedido
        INNER JOIN ciudad c ON de.idCiudad = c.idCiudad
    GROUP BY 
        c.nombre, p.nombre
    ORDER BY 
        c.nombre, SUM(pp.cantidadProducto) DESC;
END //
DELIMITER ;
CALL Productos_mas_vendido_ciudad();

-- Total de ventas por Genero
DELIMITER //
CREATE PROCEDURE ventasXgenero ()
BEGIN
    SELECT 
        u.sexo AS 'Género',
        SUM(p.total) AS 'Total de Ventas'
    FROM 
        pedido p
        INNER JOIN usuario u ON p.idUsuario = u.idUsuario
    GROUP BY 
        u.sexo;
END //
DELIMITER ;
CALL ventasXgenero();

-- Total de ventas por categoría de producto
DELIMITER //
CREATE PROCEDURE total_ventas_categoria()
BEGIN
    SELECT 
        d.categoria AS 'Categoría',
        SUM(p.precio) AS 'Total Ventas'
    FROM 
        producto p
        INNER JOIN diseno d ON p.idDiseno = d.idDiseno
    GROUP BY 
        d.categoria;
END //
DELIMITER ;
CALL total_ventas_categoria();

-- Clientes con más pedidos
DELIMITER // 
CREATE PROCEDURE clientes_con_mas_pedidos()
BEGIN
    SELECT 
        u.nombre AS 'Nombre del Cliente',
        COUNT(p.idPedido) AS 'Total de Pedidos'
    FROM 
        usuario u
        INNER JOIN pedido p ON u.idUsuario = p.idUsuario
    GROUP BY 
        u.nombre
    ORDER BY 
        COUNT(p.idPedido) DESC
    LIMIT 20
;
END //
DELIMITER ;
CALL Clientes_con_mas_pedidos();

-- Total de ventas por ciudad
DELIMITER //
CREATE PROCEDURE ventas_por_ciudad()
BEGIN
    SELECT 
        c.nombre AS 'Ciudad',
        SUM(p.total) AS 'Total de Ventas'
    FROM 
        pedido p
        INNER JOIN detalleEnvio de ON p.idPedido = de.idPedido
        INNER JOIN ciudad c ON de.idCiudad = c.idCiudad
    GROUP BY 
        c.nombre;
END //
DELIMITER ;
CALL Ventas_por_ciudad();

-- Total de ventas por mes
DELIMITER // 
CREATE PROCEDURE ventas_por_Mes()
BEGIN
    SELECT 
        MONTHNAME(p.fechaHoraPedido) AS 'Mes',
        SUM(p.total) AS 'Total de Ventas'
    FROM 
        pedido p
    GROUP BY 
        MONTHNAME(p.fechaHoraPedido);
END //
DELIMITER ;
CALL Ventas_por_Mes();

-- Productos más vendidos en general
DELIMITER //
CREATE PROCEDURE productos_mas_vendidos()
BEGIN 
    SELECT 
        p.nombre AS 'Nombre del Producto',
        SUM(pp.cantidadProducto) AS 'Total Vendido'
    FROM 
        producto p
        INNER JOIN productoPedido pp ON p.idProducto = pp.idProducto
    GROUP BY 
        p.nombre
    ORDER BY 
        SUM(pp.cantidadProducto) DESC
    LIMIT 20;
END // 
DELIMITER ;
CALL Productos_mas_vendidos();

-- ciudades con más pedidos 
DELIMITER //
CREATE PROCEDURE ciudades_con_mas_pedidos()
BEGIN 
    SELECT 
        c.nombre AS 'Ciudad',
        COUNT(p.idPedido) AS 'Total de Pedidos'
    FROM 
        ciudad c
        INNER JOIN detalleEnvio de ON c.idCiudad = de.idCiudad
        INNER JOIN pedido p ON de.idPedido = p.idPedido
    GROUP BY 
        c.nombre
    ORDER BY 
        COUNT(p.idPedido) DESC
    LIMIT 10;
END //
DELIMITER ;
CALL ciudades_con_mas_pedidos();


-- Porcentaje de pedidos procesados por estado
DELIMITER //
CREATE PROCEDURE porcentaje_pedidos_Procesados_estado()
BEGIN 
    SELECT 
        estado,
        COUNT(*) AS 'Cantidad',
        CONCAT(ROUND(COUNT(*) * 100 / (SELECT COUNT(*) FROM pedido), 2), '%') AS 'Porcentaje'
    FROM 
        pedido
    GROUP BY 
        estado;
END //
DELIMITER ;
CALL Porcentaje_pedidos_Procesados_estado();

-- Total de ingresos por mes y año

DELIMITER //
CREATE PROCEDURE total_Ingresos_mes_año()
BEGIN
    SELECT 
        YEAR(fechaHoraPedido) AS 'Año',
        MONTHNAME(fechaHoraPedido) AS 'Mes',
        SUM(total) AS 'Total de Ingresos'
    FROM 
        pedido
    GROUP BY 
        YEAR(fechaHoraPedido), MONTHNAME(fechaHoraPedido)
    ORDER BY 
        YEAR(fechaHoraPedido), MONTHNAME(fechaHoraPedido);
END//
DELIMITER ;
CALL Total_Ingresos_mes_año();

-- Cantidad de productos por género
DELIMITER //
CREATE PROCEDURE cantidad_productos_genero()
BEGIN
    SELECT 
        genero AS 'Género',
        COUNT(*) AS 'Total de Productos'
    FROM 
        producto
    GROUP BY 
        genero;
END //
DELIMITER ;

-- Edad promedio de los clientes por género
DELIMITER //
CREATE PROCEDURE edad_Promedio_Genero()
BEGIN
    SELECT 
        sexo AS 'Género',
        ROUND(AVG(edad),0) AS 'Edad Promedio'
    FROM 
        usuario
    GROUP BY 
        sexo;
END // 
DELIMITER ;

-- Total de ventas por día de la semana
DELIMITER //
CREATE PROCEDURE ventasPorDiaSemana (IN nombreDia VARCHAR(20))
BEGIN
    SELECT 
        DAYNAME(fechaHoraPedido) AS 'Día de la Semana',
        SUM(total) AS 'Total de Ventas'
    FROM 
        pedido
    WHERE
        DAYNAME(fechaHoraPedido) = nombreDia
    GROUP BY 
        DAYNAME(fechaHoraPedido);
END//
DELIMITER ;

-- ---------------------------------- --------- ---------------------------------- --

-- ------------------------------- ??????????????? ------------------------------- --
-- ------------------------------- ??????????????? ------------------------------- --