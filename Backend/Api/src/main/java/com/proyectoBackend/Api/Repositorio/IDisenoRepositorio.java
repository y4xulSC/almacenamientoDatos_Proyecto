package com.proyectoBackend.Api.Repositorio;

import org.springframework.data.jpa.repository.JpaRepository;
import com.proyectoBackend.Api.Modelo.DisenoModel;

public interface IDisenoRepositorio extends JpaRepository<DisenoModel, Integer> {
    // 
}
