-- --- Valores Rol --- --
INSERT INTO rol () VALUES
	(1, 'Administrador'),
    (2, 'Cliente')
;
-- --- Valores Rol --- --

-- --------------------- Valores usuario --------------------- --
INSERT INTO usuario (nombreUsuario, nombre, email, telefono, edad, sexo, contrasena, idRol) VALUES 
	('userAdmin', 'Admin User', 'admin@example.com', 3100000000, 30, 'Hombre', 'pass123', 1),
	('Jacobo90', 'Jacobo', 'cliente1@example.com', 3200000001, 25, 'Hombre', 'pass123', 2),
	('y4xul', 'Yaxul Cardenas', 'yaxul.cardenas@uao.edu.co', 3059460082, 21, 'Hombre', '123', 2),
	('Edwards', 'Gabriel', 'cliente4@example.com', 3200000004, 20, 'Hombre', 'VivaElAmor', 2),
	('GabrielXX', 'Eduardo', 'cliente5@example.com', 3200000005, 27, 'Mujer', 'pass123', 2),
	('Santiago:)', 'Willy', 'cliente6@example.com', 3200000006, 24, 'Hombre', 'pass123', 2),
	('Yalany', 'Antonio', 'cliente7@example.com', 3200000007, 29, 'Mujer', 'pass123', 2),
	('chocoboMelo', 'Chocobo Melo', 'chococo@example.com', 3200000008, 31, 'Hombre', 'pass123', 2),
	('Alejo09', 'Manuel', 'cliente9@example.com', 3200000009, 33, 'Mujer', 'pass123', 2),
    ('Cuaran02', 'Nicolas Cuaran', 'nicolas.cuaran@oau.edu.com', 3116680249, 18, 'Hombre', '123', 1)
;
-- --------------------- Valores usuario --------------------- --

-- --------------------- Valores productos --------------------- --
INSERT INTO producto (nombre, precio, genero, categoria, talla, descripcion, diseno) VALUES 
	('Camiseta Hombre A', 20000.00, 'Hombre', 'Camiseta', 'M', 'Camiseta deportiva para hombre', 'diseno_blob'),
	('Buzo Mujer A', 50000.00, 'Mujer', 'Buzo', 'S', 'Buzo cómodo para mujer', 'diseno_blob'),
	('Chaqueta Niño A', 60000.00, 'Niño', 'Chaqueta', 'L', 'Chaqueta para niño con diseño único', 'diseno_blob'),
	('Sudadera Hombre B', 40000.00, 'Hombre', 'Sudadera', 'XL', 'Sudadera deportiva para hombre', 'diseno_blob'),
	('Zapatos Mujer A', 80000.00, 'Mujer', 'Zapatos', '38', 'Zapatos deportivos para mujer', 'diseno_blob'),
	('Camiseta Mujer B', 25000.00, 'Mujer', 'Camiseta', 'L', 'Camiseta casual para mujer', 'diseno_blob'),
	('Buzo Hombre B', 55000.00, 'Hombre', 'Buzo', 'M', 'Buzo térmico para hombre', 'diseno_blob'),
	('Chaqueta Mujer B', 70000.00, 'Mujer', 'Chaqueta', 'S', 'Chaqueta elegante para mujer', 'diseno_blob'),
	('Sudadera Mujer B', 45000.00, 'Mujer', 'Sudadera', 'XL', 'Sudadera para mujer con diseño moderno', 'diseno_blob'),
	('Zapatos Hombre B', 90000.00, 'Hombre', 'Zapatos', '42', 'Zapatos formales para hombre', 'diseno_blob')
;
-- --------------------- Valores productos --------------------- --

-- --------------------- Valores visita --------------------- --
INSERT INTO visita () VALUES
	(1,	4, 4, "2024-03-02  20:23:04"),
	(2, 5, 4, "2024-03-03  03:35:05"),
	(3, 10, 4, "2024-03-03  10:47:04"),
	(4, 2, 5, "2024-03-03  17:59:04"),
	(5, 6, 5, "2024-03-04  01:11:04"),
	(6, 1, 5, "2024-03-04  08:23:04"),
	(7, 2, 5, "2024-03-04  15:35:05"),
	(8, 6, 7, "2024-03-04  22:47:04"),
	(9, 10, 7, "2024-03-05  05:59:04"),
	(10, 3, 7, "2024-03-05  13:11:04"),
	(11, 6, 7, "2024-03-05  20:23:04"),
	(12, 5, 8, "2024-03-06  03:35:05"),
	(13, 7, 8, "2024-03-06  10:47:04"),
	(14, 6, 9, "2024-03-06  17:59:04"),
	(15, 7, 10, "2024-03-07  01:11:04"),
	(16, 10, 10, "2024-03-07  08:23:04"),
	(17, 1, 10, "2024-03-07  15:35:05"),
	(18, 4, 9, "2024-03-07  22:47:04"),
	(19, 5, 9, "2024-03-08  05:59:04"),
	(20, 9, 8, "2024-03-08  13:11:04")
;
-- --------------------- Valores visita --------------------- --

-- --------------------- Valores promociones --------------------- --
INSERT INTO promociones () VALUES 
	(1, 9, "2024-03-01", "08:00:00", "2024-03-10", "20:00:00", 25.00),
	(2, 3, "2024-03-01", "08:00:00", "2024-03-10", "20:00:00", 5.00),
	(3, 1, "2024-03-01", "08:00:00", "2024-03-10", "20:00:00", 20.00),
	(4, 4, "2024-03-01", "08:00:00", "2024-03-10", "20:00:00", 45.00),
	(5, 2, "2024-03-01", "08:00:00", "2024-03-10", "20:00:00", 10.00)
;
-- --------------------- Valores promociones --------------------- --

-- --------------------- Valores pedido --------------------- --
INSERT INTO pedido () VALUES 
	(1, 9, "2024-03-01 09:30:00", "2024-03-01 20:45:00", 280000.00, 'entregado'), 
	(2, 2, "2024-03-02 13:15:00", "2024-03-03 12:30:00", 300000.00, 'entregado'),
	(3, 4, "2024-03-03 17:45:00", NULL, 250000.00, 'enviado'),  
	(4, 8, "2024-03-04 08:20:00", NULL, 180000.00, 'enviado'), 
	(5, 3, "2024-03-05 10:55:00", NULL, 200000.00, 'procesado'),
	(6, 7, "2024-03-06 14:40:00", NULL, 220000.00, 'procesado'), 
	(7, 2, "2024-03-07 07:20:00", NULL, 150000.00, 'pendiente'), 
	(8, 5, "2024-03-08 12:10:00", NULL, 350000.00, 'pendiente'),
	(9, 6, "2024-03-09 16:30:00", NULL, 120000.00, 'pendiente'), 
	(10, 5, "2024-03-10 18:55:00", NULL, 150000.00, 'pendiente')
;
-- --------------------- Valores pedido --------------------- --

-- --------------------- Valores productoPedido --------------------- --
INSERT INTO productoPedido (idPedido, idProducto, cantidadProducto) VALUES 
	(1, 1, 2), 
	(2, 2, 1), 
	(3, 3, 3), 
	(4, 4, 2), 
	(5, 5, 1), 
	(6, 6, 1), 
	(7, 7, 2), 
	(8, 8, 3), 
	(9, 9, 1), 
	(10, 10, 2)
;
-- --------------------- Valores productoPedido --------------------- --

-- --------------------- Valores departamento --------------------- --
INSERT INTO departamento (nombre) VALUES 
	('Bogotá'), 
    ('Antioquia'), 
    ('Valle del Cauca'), 
    ('Atlántico'), 
    ('Santander')
;
-- --------------------- Valores departamento --------------------- --

-- --------------------- Valores ciudad --------------------- --
INSERT INTO ciudad () VALUES
	(1, 1, "Bogota", 110211),
	(2, 1, "Bogota", 110111),
	(3, 2, "Medellin", 050001),
	(4, 3, "Cali", 760030),
	(5, 3, "Buenaventura", 7645)
;
INSERT INTO ciudad (idDepartamento, nombre, codigoPostal) VALUES 
	(1, 'Bogotá', 110001), 
	(2, 'Medellín', 50001), 
	(3, 'Cali', 760001), 
	(4, 'Barranquilla', 80001), 
	(5, 'Bucaramanga', 680001)
;
-- --------------------- Valores ciudad --------------------- --

-- --------------------- Valores detalleEnvio --------------------- --
INSERT INTO detalleEnvio (idPedido, idCiudad, barrio, calle, numero, infoExtra, pais) VALUES 
	(1, 1, 'Chapinero', 'Calle 45', 123, 'Apartamento 301', 'Colombia'), 
	(2, 1, 'Laureles', 'Carrera 70', 456, 'Casa 20', 'Colombia'), 
	(3, 2, 'Granada', 'Avenida 6N', 789, 'Oficina 302', 'Colombia'), 
	(4, 2, 'Norte', 'Calle 84', 1011, 'Edificio Torre Mar', 'Colombia'), 
	(5, 3, 'Cabecera', 'Carrera 27', 1213, 'Local 5', 'Colombia'),
	(6, 3, 'Terranova', 'Calle 30', 2021, 'Torre 2 Apartamento 405', 'Colombia'), 
	(7, 4, 'Quindio', 'Carrera 14', 3022, 'Casa 5', 'Colombia'), 
	(8, 4, 'Centro', 'Avenida 30', 4033, 'Local 102', 'Colombia'), 
	(9, 5, 'Sancancio', 'Calle 22', 5044, 'Edificio Concorde', 'Colombia'), 
	(10, 5, 'Multicentro', 'Carrera 5', 6055, 'Casa con antejardín', 'Colombia')
;
-- --------------------- Valores detalleEnvio --------------------- --

-- --------------------- Valores comentario --------------------- --
INSERT INTO comentario (idCliente, idProducto, comentario, calificacion) VALUES 
	(2, 1, 'Muy buena calidad', '5'), 
	(3, 2, 'Cómodo y a buen precio', '4'), 
	(4, 3, 'Excelente diseño para niños', '5'), 
	(2, 4, 'Ideal para el deporte', '4'), 
	(5, 5, 'Los zapatos son muy cómodos', '5'),
	(6, 6, 'Buena relación calidad-precio', '4'), 
	(7, 7, 'Me encantó el diseño', '5'), 
	(8, 8, 'Perfecto para el clima frío', '4'), 
	(9, 9, 'Colores muy vivos, excelente compra', '5'), 
	(5, 10, 'Estilo formal que buscaba', '5');
;
-- --------------------- Valores comentario --------------------- --



-- ------------------------------------  Insersión anterior ------------------------------------ --
-- INSERT INTO usuario (edad, nombre, sexo, telefono, correo_electronico, contrasena, rol) VALUES
-- 	(25, 'Juan Perez', 'Hombre', 123456789, 'juan.perez@example.com', 'password123', 'cliente'),
-- 	(30, 'Ana López', 'Mujer', 987654321, 'ana.lopez@example.com', 'contrasena321', 'administrador');


-- INSERT INTO producto (nombre, precio, categoria, talla, genero) VALUES
-- 	('Camiseta XYZ', 19.99, 'Camiseta', 'M', 'Hombre'),
-- 	('Buzo ABC', 29.99, 'Buzo', 'L', 'Mujer');

-- INSERT INTO diseño_personalizado (id_producto, descripcion, imagen, personalizable) VALUES
-- 	(1, 'Diseño con tema de espacio', 'imagen_espacio.jpg', 'Sí'),
-- 	(2, 'Diseño floral', 'imagen_floral.jpg', 'No');

-- INSERT INTO pedido (id_pedido, id_cliente, fechaHoraSolicita, fechaHoraEntrega, total, estado) VALUES
-- 	(1, 1, '2024-03-01 10:00:00', NULL, 39.98, 'pendiente'),
-- 	(2, 2, '2024-03-02 15:30:00', CURRENT_TIMESTAMP, 29.99, 'enviado');

-- INSERT INTO productopedido () VALUES 
-- 	(1,1,1),
-- 	(2,2,2);

-- INSERT INTO pedido (id_pedido, id_cliente, fechaHoraSolicita, fechaHoraEntrega, total, estado) VALUES
-- (3, 2, '2024-03-02 15:30:00', CURRENT_TIMESTAMP, 

-- (SELECT prd.id_producto, p.nombre, (p.precio * prd.cantidad_producto)
-- FROM productoPedido AS prd
-- INNER JOIN producto AS p USING (id_producto)
-- WHERE prd.id_producto = 2
-- GROUP BY
-- 	prd.id_producto,
-- 	prd.cantidad_producto), 

-- 'enviado'
-- );

-- INSERT INTO productopedido () VALUES (3,2,3),(3,2,1);
-- ------------------------------------  --------- -------- ------------------------------------ --




-- INSERT INTO disenoPersonalizado () VALUES
-- 	(1, 6, 3, "Texto", "1.png", "No", "Este producto no admite personalización."),
-- 	(2, 9, 4, "Texto", "2.png", "No", "Este producto no admite personalización."),
-- 	(3, 12, 4, "Imagen", "3.png", "No", "Este producto no admite personalización."),
-- 	(4, 9, 5, "Imagen", "4.tpng", "En aprobacion", "La personalización está siendo evaluada."),
-- 	(5, 11, 5, "Imagen", "5.png", "En aprobacion", "La personalización está siendo evaluada."),
-- 	(6, 5, 7, "Texto", "6.png", "En aprobacion", "La personalización está siendo evaluada."),
-- 	(7, 4, 8, "Imagen", "7.png", "En aprobacion", "La personalización está siendo evaluada."),
-- 	(8, 7, 9, "Imagen", "8.png", "Si", "Este producto admite personalización completa."),
-- 	(9, 9, 9, "Imagen", "9.png", "En aprobacion", "La personalización está siendo evaluada."),
-- 	(10, 11, 10, "Texto", "10.png", "No", "Este producto no admite personalización."),
-- 	(11, 8, 12, "Texto", "11.png", "Si", "Este producto admite personalización completa.")
-- ;

-- INSERT INTO disenoPredeterminado () VALUES
-- 	(1, 5, "Espíritu Animal", "Imagen", "1pre.png", "Elige un animal que represente tu espíritu y personalízalo en tu prenda."),
-- 	(2, 10, "Constelación Zodiacal", "Imagen", "2pre.png", "Añade la constelación de tu signo zodiacal."),
-- 	(3, 9, "Iniciales Artísticas", "Texto", "3pre.png", "Iniciales estilizadas con un toque artístico único."),
-- 	(4, 12, "Huella Digital", "Texto", "4pre.png", "Imprime tu huella digital en un diseño exclusivo."),
-- 	(5, 12, "Mapa Estelar", "Texto", "5pre.png", "Personaliza con el mapa estelar de una fecha y lugar especial."),
-- 	(6, 8, "Mantra Personal", "Texto", "6pre.png", "Añade un mantra personal o una palabra poderosa."),
-- 	(7, 8, "Paisaje Soñado", "Imagen", "7pre.png", "Un paisaje que siempre has querido visitar o que te inspira tranquilidad."),
-- 	(8, 8, "Código QR", "Texto", "8pre.png", "Un código QR personal que enlace a tu canción o sitio web favorito."),
-- 	(9, 10, "Arte Pixelado", "Imagen", "9pre.png", "Un diseño retro pixelado de tu videojuego o personaje favorito."),
-- 	(10, 1, "Símbolo Significativo", "Imagen", "10pre.png", "Un símbolo que tenga un significado especial para ti."),
-- 	(11, 5, "Eco-Mensaje", "Texto", "11pre.png", "Un mensaje de conciencia ambiental o sustentabilidad."),
-- 	(12, 11, "Galaxia Personalizada", "Imagen", "12pre.png", "Un fragmento del cosmos que sientes que te representa.")
-- ;