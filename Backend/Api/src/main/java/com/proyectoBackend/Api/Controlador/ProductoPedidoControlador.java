
package com.proyectoBackend.Api.Controlador;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import com.proyectoBackend.Api.Modelo.ProductoPedidoModel;
import com.proyectoBackend.Api.Repositorio.IPedidoRepositorio;
import com.proyectoBackend.Api.Repositorio.IProductoPedidoRepositorio;
import com.proyectoBackend.Api.Repositorio.IProductoRepositorio;
import com.proyectoBackend.Api.Servicio.IProductoPedidoServicio;
import com.proyectoBackend.Api.Servicio.IProductoServicio;
import com.proyectoBackend.Api.Excepcion.RecursoNoEncontradoExcepcion;
import com.proyectoBackend.Api.Excepcion.RecursoYaExistente;

import java.util.List;

@RestController
@RequestMapping("/proyecto/productoPedido")
public class ProductoPedidoControlador {

    @Autowired IProductoPedidoServicio productoPedidoServicio;
    @Autowired IProductoServicio productoServicio;
    @Autowired IProductoRepositorio productoRepositorio;
    @Autowired IPedidoRepositorio pedidoRepositorio;
    @Autowired IProductoPedidoRepositorio productoPedidoRepositorio;

    //Crear
    @PostMapping("/crear")
public ResponseEntity<String> crearProductoPedido(@RequestBody ProductoPedidoModel productoPedido) {
    try {
        // Verificar si el pedido existe
        if (!pedidoRepositorio.existsById(productoPedido.getIdPedido().getIdPedido())) {
            throw new RecursoNoEncontradoExcepcion("Pedido con ID " + productoPedido.getIdPedido().getIdPedido() + " no encontrado");
        }
        
        // Verificar si el producto existe
        if (!productoRepositorio.existsById(productoPedido.getIdProducto().getIdProducto())) {
            throw new RecursoNoEncontradoExcepcion("Producto con ID " + productoPedido.getIdProducto().getIdProducto() + " no encontrado");
        }

        // Guardar el ProductoPedido
        productoPedidoServicio.guardarProductoPedido(productoPedido);
        
        return new ResponseEntity<String>("Producto pedido creado correctamente", HttpStatus.OK);
    } catch (RecursoNoEncontradoExcepcion e) {
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
    } catch (RecursoYaExistente e) {
        return ResponseEntity.status(HttpStatus.CONFLICT).body(e.getMessage());
    }
}

    // Buscar
    @GetMapping("/{idPedido}/{idProducto}")
    public ResponseEntity<?> buscarProductoPedidoPorId(@PathVariable int idPedido, @PathVariable int idProducto) {
        try {
            ProductoPedidoModel productoPedido = productoPedidoServicio.buscarProductoPedidoPorId(idPedido);
            return ResponseEntity.ok(productoPedido);
        } catch (Exception e) {
            String mensajeError = e.getMessage();
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(mensajeError);
        }
    }

    // Listar
    @GetMapping("/")
    public ResponseEntity<List<ProductoPedidoModel>> listarProductosPedidos() {
        List<ProductoPedidoModel> productosPedidos = productoPedidoServicio.listarProductosPedido();
        return new ResponseEntity<List<ProductoPedidoModel>>(productosPedidos, HttpStatus.OK);
    }

    // Eliminar
    @DeleteMapping("/{idProductoPedido}")
    public ResponseEntity<?> eliminarProductoPedido(@PathVariable int idProductoPedido) {
    try {
        productoPedidoServicio.eliminarProductoPedido(idProductoPedido);
        return ResponseEntity.ok("Producto pedido con ID " + idProductoPedido + " eliminado");
    } catch (Exception e) {
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }

    @PutMapping("/{idProductoPedido}")
    public ResponseEntity<?> actualizarProductoPedido(@PathVariable Integer idProductoPedido, @RequestBody ProductoPedidoModel productoPedido) {
        try {
            // Verificar si el producto pedido existe
            if (!productoPedidoRepositorio.existsById(idProductoPedido)) {
                // Si el producto pedido no existe, lanzar una excepción
                throw new RecursoNoEncontradoExcepcion("Producto pedido con ID " + idProductoPedido + " no encontrado");
            } else {
                // Verificar si el pedido asociado al producto pedido existe
                if (!pedidoRepositorio.existsById(productoPedido.getIdPedido().getIdPedido())) {
                    // Si el pedido no existe, lanzar una excepción
                    throw new RecursoNoEncontradoExcepcion("Pedido con ID " + productoPedido.getIdPedido().getIdPedido() + " no encontrado");
                } else {
                    if (!pedidoRepositorio.existsById(productoPedido.getIdProducto().getIdProducto())) {
                        // Si el pedido no existe, lanzar una excepción
                        throw new RecursoNoEncontradoExcepcion("Producto con ID " + productoPedido.getIdPedido().getIdPedido() + " no encontrado");
                    } else {
                        // Actualizar el ProductoPedidoModel
                        ProductoPedidoModel productoPedidoActualizado = productoPedidoServicio.actualizarProductoPedido(idProductoPedido, productoPedido);
                        // Devolver una respuesta con el ProductoPedidoModel actualizado
                        return ResponseEntity.ok(productoPedidoActualizado);
                    }
                }
            }
        } catch (RecursoNoEncontradoExcepcion e) {
            // Manejar la excepción y devolver una respuesta con el mensaje de error
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }
}    