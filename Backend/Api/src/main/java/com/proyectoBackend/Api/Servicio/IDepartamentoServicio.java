package com.proyectoBackend.Api.Servicio;

import java.util.List;

import com.proyectoBackend.Api.Modelo.DepartamentoModel;

public interface IDepartamentoServicio {

    String guardarDepartamento(DepartamentoModel departamento);

    DepartamentoModel buscarDepartamentoPorId(int idDepartamento);

    List<DepartamentoModel> listarDepartamentos();

    void eliminarDepartamento(int idDepartamento);

    DepartamentoModel actualizarDepartamento(Integer idDepartamento, DepartamentoModel departamento);
}
