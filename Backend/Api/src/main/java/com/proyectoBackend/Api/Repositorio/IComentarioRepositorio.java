package com.proyectoBackend.Api.Repositorio;

import com.proyectoBackend.Api.Modelo.ComentarioModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface IComentarioRepositorio extends JpaRepository<ComentarioModel, Integer> {

}
