package com.proyectoBackend.Api.Servicio;

import java.util.List;

import com.proyectoBackend.Api.Modelo.PedidoModel;

public interface IPedidoServicio {
    
    String guardarPedido(PedidoModel pedido);
    
    PedidoModel buscarPedidoPorId(int idPedido);
    
    List<PedidoModel> listarPedidos();
    
    void eliminarPedido(int idPedido);
    
    PedidoModel actualizarPedido(Integer idPedido, PedidoModel pedido);
}

