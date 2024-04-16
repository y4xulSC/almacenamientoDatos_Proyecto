package com.proyectoBackend.Api.Controlador;

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

import com.proyectoBackend.Api.Modelo.PaqueteModel;
import com.proyectoBackend.Api.Modelo.ProductoModel;
import com.proyectoBackend.Api.Repositorio.IProductoRepositorio;
import com.proyectoBackend.Api.Servicio.IPaqueteServicio;
import com.proyectoBackend.Api.Servicio.IProductoServicio;
import com.proyectoBackend.Api.Excepcion.RecursoNoEncontradoExcepcion;
import com.proyectoBackend.Api.Excepcion.RecursoYaExistente;

@RestController
@RequestMapping("/proyecto/paquete")
public class PaqueteControlador {

    @Autowired IPaqueteServicio paqueteServicio;
    @Autowired IProductoServicio productoServicio;
    @Autowired IProductoRepositorio productoRepositorio;

    //Crear
    @PostMapping("/crearPaquete")
    public ResponseEntity<String> crearPaquete(@RequestBody PaqueteModel paquete) {
        try {
            Integer idProducto = paquete.getIdProducto().getIdProducto();
            ProductoModel producto = productoServicio.buscarProductoXid(idProducto);
            if (producto != null) {
                paqueteServicio.guardarPaquete(paquete);
                return new ResponseEntity<String>("Paquete creado correctamente", HttpStatus.OK);
            } else {
                throw new RecursoNoEncontradoExcepcion("No se encontró el producto");
            }
        } catch (RecursoNoEncontradoExcepcion e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        } catch (RecursoYaExistente e) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body(e.getMessage());
        }
    }

    // Buscar
    @GetMapping("/{idPaquete}")
    public ResponseEntity<?> buscarPaquetePorId(@PathVariable int idPaquete) {
        try {
            PaqueteModel paquete = paqueteServicio.buscarPaquetePorId(idPaquete);
            return ResponseEntity.ok(paquete);
        } catch (Exception e) {
            String mensajeError = e.getMessage();
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(mensajeError);
        }
    }

    // Listar
    @GetMapping("/")
    public ResponseEntity<List<PaqueteModel>> listarPaquetes() {
        List<PaqueteModel> paquetes = paqueteServicio.listarPaquetes();
        return new ResponseEntity<List<PaqueteModel>>(paquetes, HttpStatus.OK);
    }

    // Eliminar
    @DeleteMapping("/{idPaquete}")
    public ResponseEntity<?> eliminarPaquete(@PathVariable int idPaquete) {
        try {
            paqueteServicio.eliminarPaquete(idPaquete);
            return ResponseEntity.ok("Paquete con ID " + idPaquete + " eliminado");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }

    // Actualizar
    @PutMapping("/{idPaquete}")
    public ResponseEntity<?> actualizarPaquete(@PathVariable Integer idPaquete, @RequestBody PaqueteModel paquete) {
        try {
            // Verificar si el producto asociado al paquete existe
            if (!productoRepositorio.existsById(paquete.getIdProducto().getIdProducto())) {
                // Si el producto no existe, lanzar una excepción
                throw new RecursoNoEncontradoExcepcion("Producto con ID " + paquete.getIdProducto() + " no encontrado");
            } else { // Si el producto existe, actualizar el paquete
                PaqueteModel paqueteActualizado = paqueteServicio.actualizarPaquete(idPaquete, paquete);
                return ResponseEntity.ok(paqueteActualizado);
            }
        } catch (RecursoNoEncontradoExcepcion e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }
}
