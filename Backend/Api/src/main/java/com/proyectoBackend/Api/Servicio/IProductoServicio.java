package com.proyectoBackend.Api.Servicio;

import java.util.List;

import com.proyectoBackend.Api.Modelo.ProductoModel;

public interface IProductoServicio {
    String guardarProducto(ProductoModel producto);
<<<<<<< Updated upstream

    ProductoModel buscarProductoXid(int idProducto);

    List<ProductoModel> listarProductos();

    void eliminarProducto(int idProducto);

    ProductoModel actualizarProducto(Integer idProducto, ProductoModel producto);
}
=======
}
>>>>>>> Stashed changes
