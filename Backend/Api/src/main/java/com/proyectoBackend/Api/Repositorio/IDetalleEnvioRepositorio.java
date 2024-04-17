package com.proyectoBackend.Api.Repositorio;

import com.proyectoBackend.Api.Modelo.DetalleEnvioModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface IDetalleEnvioRepositorio extends JpaRepository<DetalleEnvioModel, Integer> {
}

