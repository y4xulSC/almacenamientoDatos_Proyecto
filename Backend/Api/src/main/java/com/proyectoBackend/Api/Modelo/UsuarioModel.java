package com.proyectoBackend.Api.Modelo;

import java.math.BigInteger;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

// Anotaciones
@Entity
@Table (name = "usuario", uniqueConstraints = {@UniqueConstraint(columnNames = {"nombreUsuario"})})
@Data
@AllArgsConstructor
@NoArgsConstructor

public class UsuarioModel {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @Column(name = "nombreUsuario", unique = true)
    private String nombreUsuario;
    private String nombre;
    private String email;
    private BigInteger telefono;
    private Integer edad;

    @Column(name = "sexo")
    @Enumerated(EnumType.STRING)
    private Sexo sexo;
}
