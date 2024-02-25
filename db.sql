CREATE DATABASE almacenamiento_datos_proyecto;

CREATE TABLE IF NOT EXISTS usuario (
    idUsuario VARCHAR(100) PRIMARY KEY NOT NULL,
    correoElectronico VARCHAR(255) UNIQUE NOT NULL,
    contrasena VARCHAR(255) NOT NULL,
    nombreUsuario VARCHAR(255) NOT NULL,
    edad INT NOT NULL,
    rol VARCHAR(15) NOT NULL,
    fechaActivacionUsario TIMESTAMP NOT NULL,
    fechaDesactivacionUsario TIMESTAMP  NULL
);

ALTER TABLE usuario ADD CONSTRAINT checkRolUsuario CHECK (rol IN ('Administrador', 'Cliente'));

