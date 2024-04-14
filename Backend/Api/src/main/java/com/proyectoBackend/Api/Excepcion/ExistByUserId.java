package com.proyectoBackend.Api.Excepcion;

public class ExistByUserId  extends RuntimeException {
    public ExistByUserId(String message) {
        super(message);
    }
}