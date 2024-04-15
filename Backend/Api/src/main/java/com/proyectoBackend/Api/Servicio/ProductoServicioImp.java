package com.proyectoBackend.Api.Servicio;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.proyectoBackend.Api.Modelo.ProductoModel;
import com.proyectoBackend.Api.Repositorio.IProductoRepositorio;

@Service
public class ProductoServicioImp implements IProductoServicio {
    @Autowired IProductoRepositorio productoRepositorio;

    @Override
    public String guardarProducto(ProductoModel producto) {
        productoRepositorio.save(producto);
        return "El producto con el ID "+ producto.getIdProducto() + " fue creado con exito.";
    }
}
