-- PLANTA

-- insertar planta
INSERT INTO planta (nombre, tipo_planta, descripcion, fecha_ingreso, email_contacto, fono_contacto, comuna_entrega, intercambio_por) VALUES (?,?,?,?,?,?,?,?)
-- obtener primeros 5 plantaes ordenadas desde la más nueva a la más antigua
SELECT id, nombre, tipo_planta, descripcion, fecha_ingreso, email_contacto, fono_contacto, comuna_entrega, intercambio_por FROM planta ORDER BY fecha_ingreso DESC LIMIT 0, 5
-- obtener informacion de 1 planta en particular
SELECT id, nombre, tipo_planta, descripcion, fecha_ingreso, email_contacto, fono_contacto, comuna_entrega, intercambio_por FROM planta WHERE id=?
-- obtener informacion de 1 planta en particular con nombre de tipo_planta y nombre de comuna
SELECT PL.id, PL.nombre, TP.descripcion, PL.descripcion, PL.fecha_ingreso, PL.email_contacto, PL.fono_contacto, CO.nombre, PL.intercambio_por FROM planta PL, tipo_planta TP, comuna CO WHERE PL.id=? AND TP.id=PL.tipo_planta AND PL.comuna_entrega=CO.id 


-- FOTOGRAFIA
-- insertar fotografia
INSERT INTO fotografia (ruta_archivo, nombre_archivo, planta) VALUES (?,?,?)
-- obtener fotografias de una planta
SELECT id, ruta_archivo, nombre_archivo, planta FROM fotografia WHERE planta=?

-- TIPO_PLANTA
-- insertar un nuevo tipo
INSERT INTO tipo_planta (descripcion) VALUES (?)
-- obtener los tipo de planta ordenados por ID ascendente
SELECT id, descripcion FROM tipo_planta ORDER BY id ASC

-- COMENTARIO
-- insertar comentario
INSERT INTO comentario (comentario, nombre_comentarista, fecha, planta) VALUES (?,?,?,?)
-- obtener comentarios de una planta ordenados por fecha desc
SELECT id, comentario, nombre_comentarista, fecha, planta FROM comentario WHERE planta=? ORDER BY fecha DESC
