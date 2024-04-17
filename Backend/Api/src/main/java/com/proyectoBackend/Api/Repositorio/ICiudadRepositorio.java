package com.proyectoBackend.Api.Repositorio;

import com.proyectoBackend.Api.Modelo.CiudadModel;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ICiudadRepositorio extends JpaRepository<CiudadModel, Integer> {

    boolean existsByNombre(String nombre);
    
}
