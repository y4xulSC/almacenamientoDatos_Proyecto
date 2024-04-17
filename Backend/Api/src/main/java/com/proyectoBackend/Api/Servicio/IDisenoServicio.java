package com.proyectoBackend.Api.Servicio;

import java.util.List;

import com.proyectoBackend.Api.Modelo.DisenoModel;

public interface IDisenoServicio {
    String guardarDiseno(DisenoModel diseno);

    DisenoModel buscarDisenoXid(int idDiseno);

    List<DisenoModel> obtenerTodosLosDisenos();

    void eliminarDiseno(Integer idDiseno);

    DisenoModel actualizarDiseno(Integer idDiseno, DisenoModel diseno);
}
