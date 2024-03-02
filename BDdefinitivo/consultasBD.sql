SELECT * FROM usuario;
SELECT * FROM producto;
SELECT * FROM pedido;
SELECT * FROM diseño_personalizado;
SELECT * FROM pedido;

-- usuarios que tienen el estado del envío en 'enviado'
SELECT * FROM usuario AS u, pedido AS p WHERE 
u.id = p.id_pedido AND estado = 'enviado';

-- usuarios que tienen el estado del envío en 'pendiente'
SELECT u.nombre, estado FROM usuario AS u, pedido AS p WHERE 
u.id = p.id_pedido AND estado = 'pendiente';

-- Consulta de la factura

SELECT * 
FROM pedido AS p
INNER JOIN productopedido USING (id_pedido)
INNER JOIN producto USING (id_producto);
