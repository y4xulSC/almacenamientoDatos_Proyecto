package com.proyectoBackend.Api.Repositorio;

import org.springframework.data.jpa.repository.JpaRepository;

import com.proyectoBackend.Api.Modelo.PedidoModel;

public interface IPedidoRepositorio extends JpaRepository<PedidoModel, Integer> {
    
}
