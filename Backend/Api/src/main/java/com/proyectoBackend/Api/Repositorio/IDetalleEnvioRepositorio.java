package com.proyectoBackend.Api.Repositorio;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.proyectoBackend.Api.Modelo.DetalleEnvioModel;

@Repository
public interface IDetalleEnvioRepositorio extends JpaRepository<DetalleEnvioModel, Integer> {
}
