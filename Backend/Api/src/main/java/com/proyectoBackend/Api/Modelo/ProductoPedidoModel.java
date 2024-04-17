package com.proyectoBackend.Api.Modelo;

import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "productoPedido")
@EnableJpaRepositories

public class ProductoPedidoModel {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idProductoPedido;
    
    @ManyToOne
    @JoinColumn(name = "idPedido", referencedColumnName = "idPedido")
    private PedidoModel idPedido;
    
    @ManyToOne
    @JoinColumn(name = "idProducto", referencedColumnName = "idProducto")
    private ProductoModel idProducto;

    private Integer cantidadProducto;
}
