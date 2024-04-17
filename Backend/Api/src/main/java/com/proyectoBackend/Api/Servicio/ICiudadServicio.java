package com.proyectoBackend.Api.Servicio;

import com.proyectoBackend.Api.Modelo.CiudadModel;

import java.util.List;

public interface ICiudadServicio {

    String guardarCiudad(CiudadModel ciudad);

    CiudadModel buscarCiudadPorId(int idCiudad);

    List<CiudadModel> listarCiudades();

    void eliminarCiudad(int idCiudad);

    CiudadModel actualizarCiudad(Integer idCiudad, CiudadModel ciudad);
}
