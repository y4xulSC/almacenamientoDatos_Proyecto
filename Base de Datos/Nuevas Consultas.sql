-- Usuario x productos comprados

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
    
    
-- Creación de factura 

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
    INNER JOIN departamento depto ON c.idDepartamento = depto.idDepartamento;


-- Producto más caro
SELECT 
    nombre AS 'Nombre del Producto Más Caro',
    precio AS 'Precio'
FROM 
    producto
WHERE 
    precio = (SELECT MAX(precio) FROM producto);


-- Productos más vendido
SELECT 
    p.nombre AS 'Nombre del Producto Más Vendido',
    SUM(pp.cantidadProducto) AS 'Cantidad Total Vendida'
FROM 
    producto p
    INNER JOIN productoPedido pp ON p.idProducto = pp.idProducto
GROUP BY 
    p.nombre
ORDER BY 
    SUM(pp.cantidadProducto) DESC
-- LIMIT 1
;


-- Productos menos vendido y más vendido por ciudad

SELECT 
    c.nombre AS 'Ciudad',
    p.nombre AS 'Nombre del Producto Menos Vendido',
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
    c.nombre, SUM(pp.cantidadProducto) ASC -- Menos vendido
    -- c.nombre, SUM(pp.cantidadProducto) DESC -- Más vendido
;

-- Total de ventas por Género
SELECT 
    u.sexo AS 'Género',
    SUM(p.total) AS 'Total de Ventas'
FROM 
    pedido p
    INNER JOIN usuario u ON p.idUsuario = u.idUsuario
GROUP BY 
    u.sexo;
    

-- Total de ventas por categoría de producto
SELECT 
    d.categoria AS 'Categoría',
    SUM(p.precio) AS 'Total Ventas'
FROM 
    producto p
    INNER JOIN diseno d ON p.idDiseno = d.idDiseno
GROUP BY 
    d.categoria;
    
    
    
-- Clientes con más pedidos
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


-- Total de ventas por ciudad
SELECT 
    c.nombre AS 'Ciudad',
    SUM(p.total) AS 'Total de Ventas'
FROM 
    pedido p
    INNER JOIN detalleEnvio de ON p.idPedido = de.idPedido
    INNER JOIN ciudad c ON de.idCiudad = c.idCiudad
GROUP BY 
    c.nombre;


-- Total de ventas por mes
SELECT 
    MONTHNAME(p.fechaHoraPedido) AS 'Mes',
    SUM(p.total) AS 'Total de Ventas'
FROM 
    pedido p
GROUP BY 
    MONTHNAME(p.fechaHoraPedido);


-- Productos más vendidos en general
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



-- ciudades con más pedidos 
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

-- Porcentaje de pedidos procesados por estado
SELECT 
    estado,
    COUNT(*) AS 'Cantidad',
    CONCAT(ROUND(COUNT(*) * 100 / (SELECT COUNT(*) FROM pedido), 2), '%') AS 'Porcentaje'
FROM 
    pedido
GROUP BY 
    estado;
    

-- Total de ingresos por mes y año
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

-- Cantidad de productos por género
SELECT 
    genero AS 'Género',
    COUNT(*) AS 'Total de Productos'
FROM 
    producto
GROUP BY 
    genero;

-- Edad promedio de los clientes por género
SELECT 
    sexo AS 'Género',
    ROUND(AVG(edad),0) AS 'Edad Promedio'
FROM 
    usuario
GROUP BY 
    sexo;


-- Total de ventas por día de la semana
SELECT 
    DAYNAME(fechaHoraPedido) AS 'Día de la Semana',
    SUM(total) AS 'Total de Ventas'
FROM 
    pedido
GROUP BY 
    DAYNAME(fechaHoraPedido);


-- Promedio de duración del envío por ciudad
-- SELECT 
--     c.nombre AS 'Ciudad',
--     AVG(TIMESTAMPDIFF(DAY, p.fechaHoraPedido, de.fechaHoraEntrega)) AS 'Promedio de Duración del Envío (Días)'
-- FROM 
--     ciudad c
--     INNER JOIN detalleEnvio de ON c.idCiudad = de.idCiudad
--     INNER JOIN pedido p ON de.idPedido = p.idPedido
-- WHERE 
--     p.fechaHoraEntrega IS NOT NULL
-- GROUP BY 
--     c.nombre;