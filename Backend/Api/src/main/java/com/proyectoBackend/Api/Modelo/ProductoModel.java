package com.proyectoBackend.Api.Modelo;

import java.sql.Blob;

import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

import com.proyectoBackend.Api.Modelo.Enum.Genero;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
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
@Table (name = "producto")
@Data
@AllArgsConstructor
@NoArgsConstructor
@EnableJpaRepositories

public class ProductoModel {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idProducto;
    
    private String nombre;
    private Float precio;
    
    @Column(name = "genero")
    @Enumerated(EnumType.STRING)
    private Genero genero;
    
    private String talla;
    private Blob imagen;
    private String descripcion;
    private String color;
    private Integer cantidadStock;

    @ManyToOne
    @JoinColumn(name = "idDiseno", referencedColumnName = "idDiseno")
    private DisenoModel idDiseno;
}
