-- --------------------- Nuevos valores corregidos --------------------- --
INSERT INTO usuario () VALUES 
	(1, 21, "Yáxul Cárdenas", "Hombre", 3059460082, "yaxul.cardenas@uao.edu.co", 123, "Administrador"),
	(2, 26, "Usuario Admin", "Hombre", 3151047736, "usuarioAdmin@gmail.com", 10000, "Administrador"),
	(3, 43, "Ana Torres", "Mujer", 3027702543, "ana.torres@gmail.com", 10001, "Administrador"),
	(4, 43, "Usuario Cliente Mujer", "Mujer", 3230382541, "usuarioClienteMujer@gmail.com", 10010, "Cliente"),
	(5, 44, "Usuario Clie01nte Hombre", "Hombre", 3203841407, "usuarioClienteHombre@gmail.com", 10011, "Cliente"),
	(6, 43, "Beatriz Gómez", "Mujer", 3055934238, "beatriz.gomez@gmail.com", 10100, "Cliente"),
	(7, 26, "Rick Sánchez", "Hombre", 3509751448, "rick.sanchez@gmail.com", 10101, "Cliente"),
	(8, 53, "Gabriel Pérez", "Hombre", 3226764694, "gabriel.perez@gmail.com", 10110, "Cliente"),
	(9, 32, "Hugo Jiménez", "Hombre", 3203722512, "hugo.jimenez@gmail.com", 10111, "Cliente"),
	(10, 49, "Carmen Ruiz", "Mujer", 3216482927, "carmen.ruiz@gmail.com", 11000, "Cliente"),
	(11, 43, "Diana López", "Mujer", 3508132345, "diana.lopez@gmail.com", 11001, "Cliente"),
	(12, 51, "Elena Martínez", "Mujer", 3128463630, "elena.martinez@gmail.com", 11010, "Cliente")
;

INSERT INTO producto () VALUES
	(1, "Velocity ProFit", 79900.00, "Camiseta", "S", "Hombre", "Máximo de colores en el diseño: 4. No se permite el uso de transparencias."),
	(2, "FlexiRun Femme", 74900.00, "Camiseta", "M", "Mujer", "Solo diseños frontales y traseros, sin mangas. Tamaño máximo del logo: 10x10 cm."),
	(3, "Junior Sprinter", 59900.00, "Camiseta", "L", "Niño", "Texto limitado a 20 caracteres. No se permite el uso de imágenes con derechos de autor."),
	(4, "ThermalBoost Men", 89900.00, "Buzo", "S", "Hombre", "Solo se personaliza en el pecho y la espalda, no en las mangas. Los colores fluorescentes no están disponibles."),
	(5, "CozyWarm Lady", 79900.00, "Buzo", "M", "Mujer", "La personalización solo se permite en áreas específicas (pecho, espalda y brazo derecho). No se permite la personalización con elementos metálicos o reflectantes."),
	(6, "KidVenture Cozy", 64900.00, "Buzo", "L", "Niño", "La personalización se limita a texto, sin imágenes. Máximo de dos colores en el diseño."),
	(7, "WindShield Elite", 109900.00, "Chaqueta", "S", "Hombre", "No se permite personalización en el material reflectante. La personalización en el área de la capucha está limitada a texto solamente."),
	(8, "AeroFemme Jacket", 119900.00, "Chaqueta", "M", "Mujer", "Los diseños no pueden cubrir las zonas de ventilación. Restricción en el uso de colores oscuros en más del 50% del diseño."),
	(9, "FunRun Hoodie", 98900.00, "Sudadera", "S", "Niño", "Solo se permite personalización en el frente. No se permiten imágenes o logos por encima de un cierto tamaño (15x15 cm)."),
	(10, "FunRun Hoodie", 74900.00, "Sudadera", "M", "Mujer", "La personalización en las mangas está limitada a bandas o logos pequeños. No se permiten cambios en la estructura básica del diseño."),
	(11, "TrailMaster X", 179900.00, "Zapatos", "38", "Hombre", "Limitado a la personalización de colores y patrones, no se pueden modificar estructuras. No se permite la personalización en la suela."),
	(12, "SpeedShift XT", 159900.00, "Zapatos", "39", "Hombre", "Solo se pueden personalizar los paneles laterales y la lengüeta. Restricciones en la personalización del material (solo cuero sintético o tela, nada de metal o plástico).")
;

INSERT INTO visita () VALUES
	(1,	4, 3, "2024-03-02  20:23:04"),
	(2, 5, 4, "2024-03-03  03:35:05"),
	(3, 10, 4, "2024-03-03  10:47:04"),
	(4, 2, 5, "2024-03-03  17:59:04"),
	(5, 6, 5, "2024-03-04  01:11:04"),
	(6, 1, 6, "2024-03-04  08:23:04"),
	(7, 2, 6, "2024-03-04  15:35:05"),
	(8, 6, 6, "2024-03-04  22:47:04"),
	(9, 10, 6, "2024-03-05  05:59:04"),
	(10, 3, 7, "2024-03-05  13:11:04"),
	(11, 6, 7, "2024-03-05  20:23:04"),
	(12, 5, 8, "2024-03-06  03:35:05"),
	(13, 7, 8, "2024-03-06  10:47:04"),
	(14, 6, 9, "2024-03-06  17:59:04"),
	(15, 7, 10, "2024-03-07  01:11:04"),
	(16, 10, 10, "2024-03-07  08:23:04"),
	(17, 1, 11, "2024-03-07  15:35:05"),
	(18, 4, 11, "2024-03-07  22:47:04"),
	(19, 5, 12, "2024-03-08  05:59:04"),
	(20, 9, 12, "2024-03-08  13:11:04")
;

INSERT INTO disenoPersonalizado () VALUES
	(1, 6, 3, "Texto", "1.png", "No", "Este producto no admite personalización."),
	(2, 9, 4, "Texto", "2.png", "No", "Este producto no admite personalización."),
	(3, 12, 4, "Imagen", "3.png", "No", "Este producto no admite personalización."),
	(4, 9, 5, "Imagen", "4.tpng", "En aprobacion", "La personalización está siendo evaluada."),
	(5, 11, 5, "Imagen", "5.png", "En aprobacion", "La personalización está siendo evaluada."),
	(6, 5, 7, "Texto", "6.png", "En aprobacion", "La personalización está siendo evaluada."),
	(7, 4, 8, "Imagen", "7.png", "En aprobacion", "La personalización está siendo evaluada."),
	(8, 7, 9, "Imagen", "8.png", "Si", "Este producto admite personalización completa."),
	(9, 9, 9, "Imagen", "9.png", "En aprobacion", "La personalización está siendo evaluada."),
	(10, 11, 10, "Texto", "10.png", "No", "Este producto no admite personalización."),
	(11, 8, 12, "Texto", "11.png", "Si", "Este producto admite personalización completa.")
;

INSERT INTO disenoPredeterminado () VALUES
	(1, 5, "Espíritu Animal", "Imagen", "1pre.png", "Elige un animal que represente tu espíritu y personalízalo en tu prenda."),
	(2, 10, "Constelación Zodiacal", "Imagen", "2pre.png", "Añade la constelación de tu signo zodiacal."),
	(3, 9, "Iniciales Artísticas", "Texto", "3pre.png", "Iniciales estilizadas con un toque artístico único."),
	(4, 12, "Huella Digital", "Texto", "4pre.png", "Imprime tu huella digital en un diseño exclusivo."),
	(5, 12, "Mapa Estelar", "Texto", "5pre.png", "Personaliza con el mapa estelar de una fecha y lugar especial."),
	(6, 8, "Mantra Personal", "Texto", "6pre.png", "Añade un mantra personal o una palabra poderosa."),
	(7, 8, "Paisaje Soñado", "Imagen", "7pre.png", "Un paisaje que siempre has querido visitar o que te inspira tranquilidad."),
	(8, 8, "Código QR", "Texto", "8pre.png", "Un código QR personal que enlace a tu canción o sitio web favorito."),
	(9, 10, "Arte Pixelado", "Imagen", "9pre.png", "Un diseño retro pixelado de tu videojuego o personaje favorito."),
	(10, 1, "Símbolo Significativo", "Imagen", "10pre.png", "Un símbolo que tenga un significado especial para ti."),
	(11, 5, "Eco-Mensaje", "Texto", "11pre.png", "Un mensaje de conciencia ambiental o sustentabilidad."),
	(12, 11, "Galaxia Personalizada", "Imagen", "12pre.png", "Un fragmento del cosmos que sientes que te representa.")
;

INSERT INTO promociones () VALUES 
	(1, 6, "2024-03-01", "08:00:00", "2024-03-10", "20:00:00", 25.00),
	(2, 7, "2024-03-01", "08:00:00", "2024-03-10", "20:00:00", 5.00),
	(3, 9, "2024-03-01", "08:00:00", "2024-03-10", "20:00:00", 20.00),
	(4, 10, "2024-03-01", "08:00:00", "2024-03-10", "20:00:00", 45.00),
	(5, 12, "2024-03-01", "08:00:00", "2024-03-10", "20:00:00", 10.00)
;

INSERT INTO pedido () VALUES
	(1, 9, "2024-03-01 09:30:00", "2024-03-01 20:45:00", 109370.00, "Entregado"),
	(2, 3, "2024-03-02 13:15:00", "2024-03-03 12:30:00", 319800.00, "Entregado"),
	(3, 7, "2024-03-03 17:45:00", "2024-03-04 19:20:00", 194730.00, "Entregado"),
	(4, 9, "2024-03-04 08:20:00", "2024-03-05 12:05:00", 179900.00, "Entregado"),
	(5, 5, "2024-03-05 10:55:00", NULL, 499700.00, "Enviado"),
	(6, 5, "2024-03-06 14:40:00", NULL, 143820.00, "Enviado"),
	(7, 12, "2024-03-07 07:20:00", NULL, 71155.00, "Procesado"),
	(8, 10, "2024-03-08 12:10:00", NULL, 244675.00, "Procesado"),
	(9, 3, "2024-03-09 16:30:00", NULL, 74900.00, "Pendiente"),
	(10, 5, "2024-03-10 18:55:00", NULL, 64900.00, "Pendiente")
;

INSERT INTO productopedido () VALUES
	(1, 1, 1, 59925.00),
	(1, 4, 1, 49445.00),
	(2, 12, 2, 319800.00),
	(3, 3, 1, 47920.00),
	(3, 5, 1, 71910.00),
	(3, 10, 1, 74900.00),
	(4, 11, 1, 179900.00),
	(5, 11, 1, 179900.00),
	(5, 12, 2, 319800.00),
	(6, 5, 2, 143820.00),
	(7, 2, 1, 71155.00),
	(8, 1, 3, 179775.00),
	(8, 6, 1, 64900.00),
	(9, 10, 1, 74900.00),
	(10, 6, 1, 64900.00)
;

INSERT INTO departamento () VALUES
	(1, "Cundinamarca"),
	(2, "Antioquia"),
	(3, "Valle del cauca")
;

INSERT INTO ciudad () VALUES
	(1, 1, "Bogota", 110211),
	(2, 1, "Bogota", 110111),
	(3, 2, "Medellin", 050001),
	(4, 3, "Cali", 760030),
	(5, 3, "Buenaventura", 7645)
;

INSERT INTO detalleEnvio () VALUES
	(1, 1, 1, "Calle 123", 456, "Edificio", "Colombia"),
	(2, 2, 3, "Carrera 45", 789, "Apartamento 301", "Colombia"),
	(3, 3, 5, "Avenida Principal", 1011, "Casa 2", "Colombia"),
	(4, 4, 1, "Calle 67", 1213, "Local 3", "Colombia"),
	(5, 5, 4, "Carrera 89", 1415, "Piso 2", "Colombia"),
	(6, 6, 2, "Calle 34", 1617, "Apartamento 102", "Colombia"),
	(7, 7, 2, "Avenida Norte", 1819, "Casa 5", "Colombia"),
	(8, 8, 4, "Calle 56", 2021, "Edificio", "Colombia"),
	(9, 9, 4, "Calle 78", 2223, "Apartamento 202", "Colombia"),
	(10, 10, 2, "Carrera 12", 2425, "Local 10", "Colombia")
;

INSERT INTO comentario () VALUES
	(1,	1, "El pedido llegó a tiempo y en buen estado", 4),
	(2,	2, "Excelente servicio, la comida deliciosa", 5),
	(3,	3, NULL, 5),
	(4,	4, "El pedido fue correcto y completo", 5),
	(5,	5, "El tiempo de entrega fue un poco largo", 4),
	(6,	6, NULL, NULL),
	(7,	7, "El pedido llegó en perfectas condiciones", 5),
	(8,	8, "Buena calidad de los productos", 4),
	(9,	9, NULL, NULL),
	(10, 10, NULL, 4)
;
-- --------------------- ------ ------- ---------- --------------------- --



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