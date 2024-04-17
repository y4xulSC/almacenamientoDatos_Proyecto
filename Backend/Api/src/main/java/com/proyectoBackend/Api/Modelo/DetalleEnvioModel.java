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
@Table(name = "detalleEnvio")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class DetalleEnvioModel {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idDetalleEnvio;
    
    @ManyToOne
    @JoinColumn(name = "idPedido", referencedColumnName = "idPedido")
    private PedidoModel idPedido;
    
    @ManyToOne
    @JoinColumn(name = "idCiudad", referencedColumnName = "idCiudad")
    private CiudadModel idCiudad;
    
    private String barrio;
    private String direccion;
    private int numero;
    private String infoExtra;
    private String pais;
}
