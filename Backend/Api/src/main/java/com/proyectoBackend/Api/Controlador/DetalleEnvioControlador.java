package com.proyectoBackend.Api.Controlador;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import com.proyectoBackend.Api.Modelo.DetalleEnvioModel;
import com.proyectoBackend.Api.Repositorio.IDetalleEnvioRepositorio;
import com.proyectoBackend.Api.Servicio.IDetalleEnvioServicio;
import com.proyectoBackend.Api.Excepcion.RecursoNoEncontradoExcepcion;

import java.util.List;

@RestController
@RequestMapping("/proyecto/detalleEnvio")
public class DetalleEnvioControlador {

    @Autowired 
    IDetalleEnvioServicio detalleEnvioServicio;
    @Autowired 
    IDetalleEnvioRepositorio detalleEnvioRepositorio;

    //Crear
    @PostMapping("/crear")
    public ResponseEntity<String> crearDetalleEnvio(@RequestBody DetalleEnvioModel detalleEnvio) {
        try {
            detalleEnvioServicio.guardarDetalleEnvio(detalleEnvio);
            return new ResponseEntity<String>("Detalle de envío creado correctamente", HttpStatus.OK);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error al crear el detalle de envío");
        }
    }

    // Buscar
    @GetMapping("/{idDetalleEnvio}")
    public ResponseEntity<?> buscarDetalleEnvioPorId(@PathVariable int idDetalleEnvio) {
        try {
            DetalleEnvioModel detalleEnvio = detalleEnvioServicio.buscarDetalleEnvioPorId(idDetalleEnvio);
            return ResponseEntity.ok(detalleEnvio);
        } catch (RecursoNoEncontradoExcepcion e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }

    // Listar
    @GetMapping("/")
    public ResponseEntity<List<DetalleEnvioModel>> listarDetallesEnvio() {
        List<DetalleEnvioModel> detallesEnvio = detalleEnvioServicio.listarDetallesEnvio();
        return new ResponseEntity<List<DetalleEnvioModel>>(detallesEnvio, HttpStatus.OK);
    }

    // Eliminar
    @DeleteMapping("/{idDetalleEnvio}")
    public ResponseEntity<?> eliminarDetalleEnvio(@PathVariable int idDetalleEnvio) {
        try {
            detalleEnvioServicio.eliminarDetalleEnvio(idDetalleEnvio);
            return ResponseEntity.ok("Detalle de envío con ID " + idDetalleEnvio + " eliminado");
        } catch (RecursoNoEncontradoExcepcion e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }

    // Actualizar
    @PutMapping("/{idDetalleEnvio}")
    public ResponseEntity<?> actualizarDetalleEnvio(@PathVariable Integer idDetalleEnvio, @RequestBody DetalleEnvioModel detalleEnvio) {
        try {
            DetalleEnvioModel detalleEnvioActualizado = detalleEnvioServicio.actualizarDetalleEnvio(idDetalleEnvio, detalleEnvio);
            return ResponseEntity.ok(detalleEnvioActualizado);
        } catch (RecursoNoEncontradoExcepcion e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }
}
