package com.proyectoBackend.Api.Repositorio;

import java.time.LocalDate;

import org.springframework.data.jpa.repository.JpaRepository;

import com.proyectoBackend.Api.Modelo.PromocionesModel;

public interface IPromocionesRepositorio extends JpaRepository<PromocionesModel, Integer> {

    boolean existePromocion(Integer idProducto, LocalDate fechaInicio, LocalDate fechaFin);
}