package com.proyectoBackend.Api.Modelo;


import java.time.LocalDateTime;

import com.proyectoBackend.Api.Modelo.Enum.EstadoPedido;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "pedido")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class PedidoModel {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idPedido;

    @ManyToOne
    @JoinColumn(name = "idUsuario", referencedColumnName = "idUsuario")
    private UsuarioModel usuario;

    private LocalDateTime fechaHoraPedido;

    // No necesitas fechaHoraEntrega aquí, ya que se ha comentado en la definición de la tabla

    @Enumerated(EnumType.STRING)
    private EstadoPedido estado;

    private Float total;

   
}

