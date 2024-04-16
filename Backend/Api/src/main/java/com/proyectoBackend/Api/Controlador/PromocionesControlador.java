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

import com.proyectoBackend.Api.Excepcion.RecursoNoEncontradoExcepcion;
import com.proyectoBackend.Api.Excepcion.RecursoYaExistente;
import com.proyectoBackend.Api.Modelo.ProductoModel;
import com.proyectoBackend.Api.Modelo.PromocionesModel;
import com.proyectoBackend.Api.Repositorio.IProductoRepositorio;
import com.proyectoBackend.Api.Servicio.IProductoServicio;
import com.proyectoBackend.Api.Servicio.IPromocionesServicio;

@RestController
@RequestMapping("/proyecto/promociones")
public class PromocionesControlador {

    @Autowired IPromocionesServicio promocionesServicio;
    @Autowired IProductoServicio productoServicio;
    @Autowired IProductoRepositorio productoRepositorio;

    //Crear
    @PostMapping("/crearPromocion")
    public ResponseEntity<String> crearPromocion(@RequestBody PromocionesModel promocion) {
        try {
            Integer idProducto = promocion.getIdProducto().getIdProducto();
            ProductoModel producto = productoServicio.buscarProductoXid(idProducto);
            if (producto != null) {
                promocionesServicio.guardarPromocion(promocion);
                return new ResponseEntity<String>("Promoción creada correctamente", HttpStatus.OK);
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
    @GetMapping("/{idPromocion}")
    public ResponseEntity<?> buscarPromocionPorId(@PathVariable int idPromocion) {
        try {
            PromocionesModel promocion = promocionesServicio.buscarPromocionPorId(idPromocion);
            return ResponseEntity.ok(promocion);
        } catch (Exception e) {
            String mensajeError = e.getMessage();
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(mensajeError);
        }
    }

    // Listar
    @GetMapping("/")
    public ResponseEntity<List<PromocionesModel>> listarPromociones() {
        List<PromocionesModel> promociones = promocionesServicio.listarPromociones();
        return new ResponseEntity<List<PromocionesModel>>(promociones, HttpStatus.OK);
    }

    // Eliminar
    @DeleteMapping("/{idPromocion}")
    public ResponseEntity<?> eliminarPromocion(@PathVariable int idPromocion) {
        try {
            promocionesServicio.eliminarPromocion(idPromocion);
            return ResponseEntity.ok("Promoción con ID " + idPromocion + " eliminada");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }

    // Actualizar
    @PutMapping("/{idPromocion}")
    public ResponseEntity<?> actualizarPromocion(@PathVariable Integer idPromocion, @RequestBody PromocionesModel promociones) {
        try {
            // Verificar si el producto asociado a la promoción existe
            if (!productoRepositorio.existsById(promociones.getIdProducto().getIdProducto())) {
                // Si el producto no existe, lanzar una excepción
                throw new RecursoNoEncontradoExcepcion("Producto con ID " + promociones.getIdProducto().getIdProducto() + " no encontrado");
            } else { // Si el producto existe, actualizar la promoción
                PromocionesModel promocionActualizada = promocionesServicio.actualizarPromocion(idPromocion, promociones);
                return ResponseEntity.ok(promocionActualizada);
            }
        } catch (RecursoNoEncontradoExcepcion e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }
}
