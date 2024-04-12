-- usuario x productos comprados
SELECT 
	u.nombreUsuario AS 'Nombre de usuario',
    SUM(pp.idProducto) AS 'Cantidad productos comprados',
    SUM(p.total) AS 'Total compras'
FROM 
	usuario u
	INNER JOIN pedido p ON u.id = p.idCliente
	INNER JOIN productoPedido pp ON p.idPedido = pp.idPedido
GROUP BY 
	u.nombreUsuario
;

-- usuario x compras realizadas
SELECT 
	u.nombreUsuario,
	COUNT(p.idPedido),
    SUM(p.total)
FROM 
	pedido AS p, 
    usuario AS u 
WHERE 
	p.idCliente = u.id
GROUP BY 
	u.nombreUsuario
;

SELECT 
	pr.nombre,
    prom.descuento
FROM producto pr
INNER JOIN promociones prom ON prom.idProducto = pr.idProducto
;

-- Num pedido x ciudad
SELECT 
	d.idCiudad, 
	c.nombre, 
    COUNT(DISTINCT p.idPedido) AS totalPedidos
FROM productoPedido p
	INNER JOIN detalleEnvio d ON d.idPedido = p.idPedido
	INNER JOIN ciudad c ON c.id = d.idCiudad
GROUP BY d.idCiudad, c.nombre
;

-- ------------------------------------------------------ Consulta de la factura ------------------------------------------------------ --
SELECT 
	p.idPedido AS Factura,
    p.fechaHoraSolicita AS 'Fecha de compra',
    u.nombre AS 'Nombre cliente',
    u.telefono AS 'Número contacto',
    u.email AS 'Correo electronico',
    pp.idProducto AS 'Cod. Producto',
    pr.categoria AS 'Tipo producto',
    pr.nombre AS 'Nombre producto',
    pr.talla AS 'Talla',
    pp.cantidadProducto AS 'Cantidad producto',
    pr.precio AS 'Precio x unidad',
    prom.descuento AS 'Descuento aplicado',
    p.total AS 'Total de compra',
    p.estado AS 'Estado envío',
    p.fechaHoraEntrega AS 'Fecha de entrega'
    -- p.idCliente AS 'Cliente No',
    -- u.id AS 'Usuario No',
FROM
	pedido AS p,
    usuario AS u,
    productoPedido AS pp,
    -- producto AS pr,
    promociones AS prom
	RIGHT JOIN producto AS pr USING (idProducto)
WHERE 
	p.idCliente = u.id
    AND pp.idPedido = p.idPedido
    AND pp.idProducto = pr.idProducto
    -- AND p.idPedido = 3 -- Consultaro por id del pedido
    -- AND p.estado = 'Enviado' -- Consultar según estado
    -- AND u.email = 'usuarioClienteHombre@gmail.com' -- Consultar por email
    -- AND u.nombre LIKE '%an%' -- Consultar por nombre de cliente
    -- AND u.telefono LIKE '%30%' -- Consultar por número de contacto
    -- AND pp.idProducto = 1 -- Consultar por Cod. Producto
    -- AND pr.categoria LIKE '%ZAPATO%' -- Consultar por tipo de producto
    -- AND prom.descuento IS NOT NULL -- Consultar segun su descuento
    -- AND (DATE(p.fechaHoraSolicita) >= '2024-03-01' AND DATE(p.fechaHoraSolicita) <= '2024-03-02') -- Consulta por rango de fechas
;
-- ------------------------------------------------------ -------- -- -- ------- ------------------------------------------------------ --

-- --- Total compra --- --
SELECT 
	p.idPedido AS Factura,
    p.fechaHoraSolicita AS 'Fecha de compra',
    u.nombre AS 'Nombre cliente',
    u.telefono AS 'Número contacto',
    u.email AS 'Correo electronico',
    SUM(pr.precio * pp.cantidadProducto) AS total,
    -- p.total AS 'Total de compra',
    p.estado AS 'Estado envío',
    p.fechaHoraEntrega AS 'Fecha de entrega'
    -- p.idCliente AS 'Cliente No',
    -- u.id AS 'Usuario No',
FROM
	usuario AS u,
    pedido AS p
    INNER JOIN productoPedido AS pp USING (idPedido)
    INNER JOIN producto AS pr USING (idProducto)
WHERE 
	p.idCliente = u.id
    AND pp.idPedido = p.idPedido
    AND pp.idProducto = pr.idProducto
    -- AND p.idPedido = 3 -- Consultaro por id del pedido
    -- AND p.estado = 'Enviado' -- Consultar según estado
    -- AND u.email = 'usuarioClienteHombre@gmail.com' -- Consultar por email
    -- AND u.nombre LIKE '%an%' -- Consultar por nombre de cliente
    -- AND u.telefono LIKE '%30%' -- Consultar por número de contacto
    -- AND (DATE(p.fechaHoraSolicita) >= '2024-03-01' AND DATE(p.fechaHoraSolicita) <= '2024-03-02') -- Consulta por rango de fechas
GROUP BY
	p.idPedido
;
-- --- Total compra --- --

-- --- Subtotal compra --- --
SELECT	
    u.nombre AS 'Nombre cliente',
    u.telefono AS 'Número contacto',
    u.email AS 'Correo electronico',
    pp.idProducto AS 'Cod. Producto',
    pr.categoria AS 'Tipo producto',
    pr.nombre AS 'Nombre producto',
    -- pr.genero AS 'Genero',
    pr.talla AS 'Talla',
    pp.cantidadProducto AS 'Cantidad producto',
    pr.precio AS 'Precio x unidad',
    prom.descuento AS 'Descuento aplicado',
    (IF (prom.descuento IS NOT NULL,
         ROUND(pp.cantidadProducto * (pr.precio - (pr.precio * (prom.descuento)/100)),2),
         ROUND(pr.precio * pp.cantidadProducto,2)
        )
    ) AS subtotal,
    p.estado AS 'Estado envío',
    p.fechaHoraEntrega AS 'Fecha de entrega'
FROM
    pedido AS p
    INNER JOIN usuario AS u ON u.id = p.idCliente
    RIGHT JOIN productoPedido AS pp USING (idPedido)
    INNER JOIN producto AS pr USING (idProducto)
    LEFT JOIN promociones AS prom USING (idProducto)
WHERE
	(prom.descuento IS NULL OR prom.descuento IS NOT NULL)
;
-- --- Subtotal compra --- --


-- ---- Consulta de vista a producto de interacción ---- --
SELECT 
	v.fechaHoraVisita AS 'Fecha y hora de la vista',
	u.nombre AS 'Nombre de usuario',
    u.sexo AS 'Sexo',
    u.edad AS 'Edad',
    pr.nombre AS 'Nombre del producto',
    pr.categoria AS 'Tipo de producto',
    pr.genero AS 'Genero producto',
    pr.precio AS 'Precio x unidad'
FROM 
	visita AS v, 
    usuario AS u, 
    producto AS pr
WHERE 
	v.idUsuario = u.id 
    AND v.idProducto = pr.idProducto
;
-- ---- -------- -- ----- - -------- -- ---------- ---- --



-- --- Productos con más vistas --- --
SELECT 
	-- * 
    COUNT(pr.idProducto),
    pr.nombre
FROM 
	visita AS v, 
    producto AS pr
WHERE 
	v.idProducto = pr.idProducto
GROUP BY
	pr.idProducto,
    pr.nombre
	
    -- --- Consultar el producto más visto --- --
	-- HAVING
	-- 	COUNT(pr.idProducto) = (
	-- 		SELECT MAX(MaxVistasProd) FROM (
	-- 			SELECT COUNT(pr.idProducto)  AS MaxVistasProd
	-- 			FROM visita AS v, producto AS pr
	-- 			WHERE v.idProducto = pr.idProducto
	-- 			GROUP BY pr.idProducto
	-- 		) AS subConsultaProdMasVisto
	-- 	)
    -- --- --------- -- -------- --- ----- --- --
    
ORDER BY
	COUNT(pr.idProducto) DESC
;
-- --- --------- --- --- ------ --- --



-- ---- Consulta de los producto más comprados ---- --
SELECT 
	SUM(pp.idPedido),
    pr.nombre
FROM 
    producto AS pr,
    productoPedido AS pp
WHERE
	pr.idProducto = pp.idProducto
GROUP BY
	pp.idProducto,
    pr.nombre
    
	-- --- Consultar el producto más comprado --- --
	-- HAVING
	-- 	COUNT(pr.idProducto) = (
	-- 		SELECT MAX(MaxVistasProd) FROM (
	-- 			SELECT COUNT(pp.idProducto)  AS MaxVistasProd
	-- 			FROM producto AS pr, productoPedido AS pp
	--  			WHERE pp.idProducto = pr.idProducto
	--  			GROUP BY pp.idProducto
	--  		) AS subConsultaProdMasCompra
	--  	)
    -- --- --------- -- -------- --- -------- --- --
    
ORDER BY
	COUNT(pp.idPedido) DESC,
    pr.nombre ASC
;
-- ---- Consulta de los producto más comprados ---- --








-- ---------------------------------------------- Pruebas ---------------------------------------------- --
SELECT * -- DATE(prom.fechaFin), TIME(prom.horaFin), prom.descuento, pr.idProducto, pr.nombre, pr.precio 
FROM promociones AS prom-- , producto AS pr
RIGHT JOIN producto AS pr USING (idProducto)
WHERE 
	-- CURRENT_DATE() <= DATE(prom.fechaFin)
    CURRENT_TIME >= TIME(prom.horaFin)
    -- OR prom.fechaFin IS NULL
-- WHERE prom.idProducto = pr.idProducto
;
-- ---------------------------------------------- ------- ---------------------------------------------- --
SELECT p.idPedido, SUM(ROUND(pp.cantidadProducto * (pr.precio - (pr.precio * (prom.descuento)/100)),2)) 
		FROM pedido AS p, productoPedido AS pp, producto AS pr, promociones AS prom
        WHERE p.idPedido = pp.idPedido AND pp.idProducto = pr.idProducto AND prom.descuento IS NOT NULL
		GROUP BY p.idPedido, pp.cantidadProducto, pr.precio, prom.descuento;