package com.proyectoBackend.Api.Repositorio;

import org.springframework.data.jpa.repository.JpaRepository;

import com.proyectoBackend.Api.Modelo.RolModel;

public interface IRolRepositorio extends JpaRepository<RolModel, Integer> {
    // Consultas de la tabla Rol
}
