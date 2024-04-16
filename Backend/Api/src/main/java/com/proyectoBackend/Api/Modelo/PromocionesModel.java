package com.proyectoBackend.Api.Modelo;

import java.time.LocalDate;
import java.time.LocalTime;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table (name = "promociones")
@Data
@AllArgsConstructor
@NoArgsConstructor  

public class PromocionesModel {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY )
    private Integer idPromocion;

    @ManyToOne
    @JsonIgnoreProperties("promociones") // Evita la serialización recursiva
    @JoinColumn(name = "idProducto", referencedColumnName = "idProducto")
    private ProductoModel idProducto;

    private LocalDate fechaInicio;
    private LocalTime horaInicio;
    private LocalDate fechaFin;
    private LocalTime horaFin;
    private Float descuento;
}
