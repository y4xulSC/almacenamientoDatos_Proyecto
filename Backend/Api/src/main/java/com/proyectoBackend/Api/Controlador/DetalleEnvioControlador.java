package com.proyectoBackend.Api.Controlador;

import com.proyectoBackend.Api.Excepcion.RecursoNoEncontradoExcepcion;
import com.proyectoBackend.Api.Modelo.DetalleEnvioModel;
import com.proyectoBackend.Api.Servicio.IDetalleEnvioServicio;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/proyecto/detalleEnvio")
public class DetalleEnvioControlador {

    @Autowired
    IDetalleEnvioServicio detalleEnvioServicio;

    @PostMapping("/crear")
    public ResponseEntity<String> crearDetalleEnvio(@RequestBody DetalleEnvioModel detalleEnvio) {
        String mensaje = detalleEnvioServicio.guardarDetalleEnvio(detalleEnvio);
        return new ResponseEntity<>(mensaje, HttpStatus.CREATED);
    }

    @GetMapping("/{idDetalleEnvio}")
    public ResponseEntity<?> buscarDetalleEnvioPorId(@PathVariable int idDetalleEnvio) {
        try {
            DetalleEnvioModel detalleEnvio = detalleEnvioServicio.buscarDetalleEnvioPorId(idDetalleEnvio);
            return ResponseEntity.ok(detalleEnvio);
        } catch (RecursoNoEncontradoExcepcion e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }

    @GetMapping("/")
    public ResponseEntity<List<DetalleEnvioModel>> listarDetallesEnvio() {
        List<DetalleEnvioModel> detallesEnvio = detalleEnvioServicio.listarDetallesEnvio();
        return new ResponseEntity<>(detallesEnvio, HttpStatus.OK);
    }

    @DeleteMapping("/{idDetalleEnvio}")
    public ResponseEntity<?> eliminarDetalleEnvio(@PathVariable int idDetalleEnvio) {
        try {
            detalleEnvioServicio.eliminarDetalleEnvio(idDetalleEnvio);
            return ResponseEntity.ok("Detalle de envío eliminado correctamente");
        } catch (RecursoNoEncontradoExcepcion e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }

    @PutMapping("/{idDetalleEnvio}")
    public ResponseEntity<?> actualizarDetalleEnvio(@PathVariable int idDetalleEnvio, @RequestBody DetalleEnvioModel detalleEnvio) {
        try {
            DetalleEnvioModel detalleEnvioActualizado = detalleEnvioServicio.actualizarDetalleEnvio(idDetalleEnvio, detalleEnvio);
            return ResponseEntity.ok(detalleEnvioActualizado);
        } catch (RecursoNoEncontradoExcepcion e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }

}