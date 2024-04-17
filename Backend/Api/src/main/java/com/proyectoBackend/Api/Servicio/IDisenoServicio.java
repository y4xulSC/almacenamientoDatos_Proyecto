package com.proyectoBackend.Api.Servicio;

import java.util.List;

import com.proyectoBackend.Api.Modelo.DisenoModel;

public interface IDisenoServicio {
    String guardarDiseno(DisenoModel diseno);
<<<<<<< Updated upstream

    DisenoModel buscarDisenoXid(int idDiseno);

    List<DisenoModel> obtenerTodosLosDisenos();

    void eliminarDiseno(Integer idDiseno);

=======
    DisenoModel buscarDisenoXid(int idDiseno);
    List<DisenoModel> obtenerTodosLosDisenos();
    void eliminarDiseno(Integer idDiseno);  
>>>>>>> Stashed changes
    DisenoModel actualizarDiseno(Integer idDiseno, DisenoModel diseno);
}
