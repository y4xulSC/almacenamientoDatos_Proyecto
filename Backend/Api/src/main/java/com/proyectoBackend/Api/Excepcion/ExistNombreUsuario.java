package com.proyectoBackend.Api.Excepcion;

public class ExistNombreUsuario  extends RuntimeException {
    public ExistNombreUsuario(String message) {
        super(message);
    }
}