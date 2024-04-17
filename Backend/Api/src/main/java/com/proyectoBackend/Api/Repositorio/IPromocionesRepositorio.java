package com.proyectoBackend.Api.Repositorio;

import java.time.LocalDate;

import org.springframework.data.jpa.repository.JpaRepository;

import com.proyectoBackend.Api.Modelo.ProductoModel;
import com.proyectoBackend.Api.Modelo.PromocionesModel;

public interface IPromocionesRepositorio extends JpaRepository<PromocionesModel, Integer> {
        
 boolean existsByProductoAndFechaInicioBeforeAndFechaFinAfter(ProductoModel idProducto, LocalDate fechaInicio, LocalDate fechaFin);

}