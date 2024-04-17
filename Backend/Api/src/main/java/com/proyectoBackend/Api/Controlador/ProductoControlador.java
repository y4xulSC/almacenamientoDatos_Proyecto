package com.proyectoBackend.Api.Controlador;

<<<<<<< Updated upstream
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.proyectoBackend.Api.Excepcion.RecursoNoEncontradoExcepcion;
import com.proyectoBackend.Api.Modelo.ProductoModel;
import com.proyectoBackend.Api.Repositorio.IDisenoRepositorio;
import com.proyectoBackend.Api.Servicio.IProductoServicio;

=======
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

>>>>>>> Stashed changes
@RestController
@RequestMapping ("/proyecto/producto")

public class ProductoControlador {
<<<<<<< Updated upstream
 
    @Autowired IProductoServicio productoServicio;

    @Autowired IDisenoRepositorio disenoRepositorio;

    @PostMapping("/crear")
    public ResponseEntity<String> crearProducto(@RequestBody ProductoModel producto) {
        productoServicio.guardarProducto(producto);
        return new ResponseEntity<String>(productoServicio.guardarProducto(producto), HttpStatus.OK);
    }

    @GetMapping("/{idProducto}")
    public ResponseEntity<?> buscarProductoXid(@PathVariable int idProducto) {
        try {
            ProductoModel producto = productoServicio.buscarProductoXid(idProducto);
            return ResponseEntity.ok(producto);
        } catch (RecursoNoEncontradoExcepcion e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }
    
    @GetMapping("/")
    public ResponseEntity<List<ProductoModel>> listarProducto() {
        List<ProductoModel> productos = productoServicio.listarProductos();
        return new ResponseEntity<List<ProductoModel>>(productos, HttpStatus.OK);
    }

    @DeleteMapping("/{idProducto}")
    public ResponseEntity<?> eliminarProducto(@PathVariable int idProducto) {
        try {
            productoServicio.eliminarProducto(idProducto);
            return ResponseEntity.ok("Producto con el ID " + idProducto + " fue eliminado con exito.");
        } catch (RecursoNoEncontradoExcepcion e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }
    
     @PutMapping("/{idProducto}")
    public ResponseEntity<?> actualizarProducto(@PathVariable Integer idProducto, @RequestBody ProductoModel producto) {
        try {
            // Verificar si el diseño asociado al producto existe
            
            if (!disenoRepositorio.existsById(producto.getIdDiseno().getIdDiseno())) {
                
                // Si el diseño no existe, lanzar una excepción
                throw new RecursoNoEncontradoExcepcion("Diseño con ID " + producto.getIdDiseno().getIdDiseno() + " no encontrado");
            } else {
                // Si el diseño existe, actualizar el producto
                ProductoModel productoActualizado = productoServicio.actualizarProducto(idProducto, producto);
                return ResponseEntity.ok(productoActualizado);
            }
        } catch (RecursoNoEncontradoExcepcion e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }
}
=======
    
}

>>>>>>> Stashed changes
