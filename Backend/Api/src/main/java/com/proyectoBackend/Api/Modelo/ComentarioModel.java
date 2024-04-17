package com.proyectoBackend.Api.Modelo;

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
@Table(name = "comentario")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ComentarioModel {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idComentario;
    
    @ManyToOne
    @JoinColumn(name = "idUsuario", referencedColumnName = "idUsuario")
    private UsuarioModel idUsuario;
    
    @ManyToOne
    @JoinColumn(name = "idProducto", referencedColumnName = "idProducto")
    private ProductoModel idProducto;
    
    private String comentario;
    private Integer calificacion;
}
