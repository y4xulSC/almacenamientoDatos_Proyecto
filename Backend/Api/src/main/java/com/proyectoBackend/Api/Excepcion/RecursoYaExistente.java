package com.proyectoBackend.Api.Excepcion;

public class RecursoYaExistente extends RuntimeException {
    public RecursoYaExistente(String message) {
        super(message);
    }
}
