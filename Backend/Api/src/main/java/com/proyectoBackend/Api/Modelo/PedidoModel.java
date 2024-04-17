package com.proyectoBackend.Api.Modelo;

import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

import java.time.LocalDateTime;
import com.proyectoBackend.Api.Modelo.Enum.EstadoPedido;

import jakarta.persistence.Column;
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
@EnableJpaRepositories

public class PedidoModel {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idPedido;

    private LocalDateTime fechaHoraPedido;

    // No necesitas fechaHoraEntrega aquí, ya que se ha comentado en la definición de la tabla

    @Column(name = "estado") // Especifica la longitud de la columna si es necesario
    @Enumerated(EnumType.STRING)
    private EstadoPedido estado;

    private Float total;

    @ManyToOne
    @JoinColumn(name = "idUsuario", referencedColumnName = "idUsuario")
    private UsuarioModel usuario;

    //@OneToMany(mappedBy = "idPedido")
    //private List<ProductoPedidoModel> pedidos;
}

