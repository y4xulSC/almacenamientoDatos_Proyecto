package com.proyectoBackend.Api.Servicio;

import java.util.List;

import com.proyectoBackend.Api.Modelo.PaqueteModel;

public interface IPaqueteServicio {
    
    String guardarPaquete(PaqueteModel paquete);
    
    PaqueteModel buscarPaquetePorId(int idPaquete);
    
    List<PaqueteModel> listarPaquetes();
    
    void eliminarPaquete(int idPaquete);
    
    PaqueteModel actualizarPaquete(Integer idPaquete, PaqueteModel paquete);
}