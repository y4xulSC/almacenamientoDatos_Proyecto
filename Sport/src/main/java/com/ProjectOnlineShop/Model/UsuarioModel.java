package com.ProjectOnlineShop.Model;


import com.Enum.Sexo;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;

import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "usuario")
@Data
@AllArgsConstructor
@NoArgsConstructor

public class UsuarioModel {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idUsuario;
    
    private String nombreUsuario;
    private String nombre;
    private String email;
    private Long telefono;
    private Integer edad;

    @Enumerated(EnumType.STRING)
     @JsonDeserialize(using = SexoDeserializer.class)
    private Sexo sexo;
    
}
