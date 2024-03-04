-- ------------------------------------------------------ Consulta de la factura ------------------------------------------------------ --
SELECT 
	p.idPedido AS 'Factura No',
    p.fechaHoraSolicita AS 'Fecha de compra',
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
    pp.totalCantProd AS 'Total del producto',
    p.total AS 'Total de compra',
    p.estado AS 'Estado envío',
    p.fechaHoraEntrega AS 'Fecha de entrega'
    -- p.idCliente AS 'Cliente No',
    -- u.id AS 'Usuario No',
    -- u.edad AS 'Edad usuario',
    -- u.sexo,
    -- u.rol AS 'Tipo cliente'
FROM
	pedido AS p,
    usuario AS u,
    productoPedido AS pp,
    -- producto AS pr,
    promociones AS prom-- , producto AS pr
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
    AND prom.descuento IS NOT NULL -- Consultar segun su descuento
    -- AND (DATE(p.fechaHoraSolicita) >= '2024-03-01' AND DATE(p.fechaHoraSolicita) <= '2024-03-02') -- Consulta por rango de fechas
;
-- ------------------------------------------------------ -------- -- -- ------- ------------------------------------------------------ --
-- ---- Consulta de vista a producto de inteacción ---- --
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
    AND v.idProducto = pr.idProducto;
-- ---- -------- -- ----- - -------- -- ---------- ---- --




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