INSERT INTO usuario (edad, nombre, sexo, telefono, correo_electronico, contrasena, rol) VALUES
(25, 'Juan Perez', 'Hombre', 123456789, 'juan.perez@example.com', 'password123', 'cliente'),
(30, 'Ana López', 'Mujer', 987654321, 'ana.lopez@example.com', 'contrasena321', 'administrador');


INSERT INTO producto (nombre, precio, categoria, talla, genero) VALUES
('Camiseta XYZ', 19.99, 'Camiseta', 'M', 'Hombre'),
('Buzo ABC', 29.99, 'Buzo', 'L', 'Mujer');

INSERT INTO diseño_personalizado (id_producto, descripcion, imagen, personalizable) VALUES
(1, 'Diseño con tema de espacio', 'imagen_espacio.jpg', 'Sí'),
(2, 'Diseño floral', 'imagen_floral.jpg', 'No');

INSERT INTO pedido (id_pedido, id_cliente, fechaHoraSolicita, fechaHoraEntrega, total, estado) VALUES
(1, 1, '2024-03-01 10:00:00', NULL, 39.98, 'pendiente'),
(2, 2, '2024-03-02 15:30:00', CURRENT_TIMESTAMP, 29.99, 'enviado');

INSERT INTO productopedido () VALUES 
	(1,1,1),
    (2,2,2);

INSERT INTO pedido (id_pedido, id_cliente, fechaHoraSolicita, fechaHoraEntrega, total, estado) VALUES
(3, 2, '2024-03-02 15:30:00', CURRENT_TIMESTAMP, 

(SELECT prd.id_producto, p.nombre, (p.precio * prd.cantidad_producto)
FROM productoPedido AS prd
INNER JOIN producto AS p USING (id_producto)
WHERE prd.id_producto = 2
GROUP BY
	prd.id_producto,
    prd.cantidad_producto), 

'enviado'
);

INSERT INTO productopedido () VALUES (3,2,3),(3,2,1);