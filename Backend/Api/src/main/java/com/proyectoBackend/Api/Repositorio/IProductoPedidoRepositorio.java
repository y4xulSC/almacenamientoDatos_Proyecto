package com.proyectoBackend.Api.Repositorio;

import com.proyectoBackend.Api.Modelo.ProductoPedidoModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface IProductoPedidoRepositorio extends JpaRepository<ProductoPedidoModel, Integer> {
    
}

