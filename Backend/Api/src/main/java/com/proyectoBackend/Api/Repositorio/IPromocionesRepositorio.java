package com.proyectoBackend.Api.Repositorio;

import org.springframework.data.jpa.repository.JpaRepository;

import com.proyectoBackend.Api.Modelo.PromocionesModel;

public interface IPromocionesRepositorio extends JpaRepository<PromocionesModel, Integer> {
    
}