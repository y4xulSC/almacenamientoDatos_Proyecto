package com.proyectoBackend.Api.Modelo;

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
@Table(name = "paquete")
@Data
@AllArgsConstructor
@NoArgsConstructor  
public class PaqueteModel {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idPaquete;

    @ManyToOne
    @JsonIgnoreProperties("promociones") // Evita la serialización recursiva
    @JoinColumn(name = "idProducto", referencedColumnName = "idProducto")
    private ProductoModel idProducto;

    private Integer cantidadProducto;
    private String tipoProducto;
}
