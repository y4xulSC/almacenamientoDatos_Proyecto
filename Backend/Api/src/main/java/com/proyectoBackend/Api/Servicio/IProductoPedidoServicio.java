package com.proyectoBackend.Api.Servicio;

import com.proyectoBackend.Api.Modelo.ProductoPedidoModel;

import java.util.List;

public interface IProductoPedidoServicio {
    
    String guardarProductoPedido(ProductoPedidoModel productoPedido);
    
    ProductoPedidoModel buscarProductoPedidoPorId(int idProductoPedido);
    
    List<ProductoPedidoModel> listarProductosPedido();
    
    void eliminarProductoPedido(int idProductoPedido);
    
    ProductoPedidoModel actualizarProductoPedido(Integer idProductoPedido, ProductoPedidoModel productoPedido);
}
