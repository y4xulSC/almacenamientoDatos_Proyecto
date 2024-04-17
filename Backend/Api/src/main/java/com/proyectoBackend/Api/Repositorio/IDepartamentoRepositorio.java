package com.proyectoBackend.Api.Repositorio;

import org.springframework.data.jpa.repository.JpaRepository;

import com.proyectoBackend.Api.Modelo.DepartamentoModel;

public interface IDepartamentoRepositorio extends JpaRepository<DepartamentoModel, Integer> {
    
    boolean existsByNombre(String nombre);
}
