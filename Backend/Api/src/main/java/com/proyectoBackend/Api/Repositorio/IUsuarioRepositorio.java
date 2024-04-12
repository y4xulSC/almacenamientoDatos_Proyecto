package com.proyectoBackend.Api.Repositorio;

import org.springframework.data.jpa.repository.JpaRepository;
import com.proyectoBackend.Api.Modelo.UsuarioModel;

public interface IUsuarioRepositorio extends JpaRepository<UsuarioModel, Integer> {
    // consultas de la tabla usuario
}
