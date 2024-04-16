package com.proyectoBackend.Api.Repositorio;

import com.proyectoBackend.Api.Modelo.PaqueteModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface IPaqueteRepositorio extends JpaRepository<PaqueteModel, Integer> {
    // Aquí puedes agregar métodos personalizados de ser necesario
}
