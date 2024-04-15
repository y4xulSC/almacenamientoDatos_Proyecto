package com.proyectoBackend.Api.Controlador;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.proyectoBackend.Api.Modelo.ProductoModel;
import com.proyectoBackend.Api.Servicio.IProductoServicio;

@RestController
@RequestMapping ("/proyecto/producto")

public class ProductoControlador {
    @Autowired IProductoServicio productoServicio;

    @PostMapping("/crear")
    public ResponseEntity<String> crearProducto(@RequestBody ProductoModel producto) {
        productoServicio.guardarProducto(producto);
        return new ResponseEntity<String>(productoServicio.guardarProducto(producto), HttpStatus.OK);
    }
}
