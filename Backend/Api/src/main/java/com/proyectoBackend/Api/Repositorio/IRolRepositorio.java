package com.proyectoBackend.Api.Repositorio;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.proyectoBackend.Api.Modelo.RolModel;

public interface IRolRepositorio extends JpaRepository<RolModel, Integer> {
    // Consultas de la tabla Rol
}
