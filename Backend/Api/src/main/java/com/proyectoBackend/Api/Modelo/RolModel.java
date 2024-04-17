package com.proyectoBackend.Api.Modelo;

import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

import com.proyectoBackend.Api.Modelo.Enum.Rol;

//import com.fasterxml.jackson.annotation.JsonBackReference;

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
import jakarta.persistence.UniqueConstraint;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table (name = "rol", uniqueConstraints = {@UniqueConstraint(columnNames = {"idUsuario"})})
@Data
@AllArgsConstructor
@NoArgsConstructor
@EnableJpaRepositories

public class RolModel {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idRol;
    
    @Column(name = "nombreRol")
    @Enumerated(EnumType.STRING)    
    private Rol nombreRol;

    private String contrasena;

    @ManyToOne
    @JoinColumn(name = "idUsuario", referencedColumnName = "idUsuario", unique = true)
    private UsuarioModel usuario;
}
