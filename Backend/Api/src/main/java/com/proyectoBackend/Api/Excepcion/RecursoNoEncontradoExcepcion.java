package com.proyectoBackend.Api.Excepcion;

public class RecursoNoEncontradoExcepcion extends RuntimeException {
    public RecursoNoEncontradoExcepcion(String mensaje){
        super("\n ---------------------------- \nasdasdasd \n" + mensaje);
    }
}
