package com.proyectoBackend.Api.Controlador;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.proyectoBackend.Api.Excepcion.RecursoNoEncontradoExcepcion;
import com.proyectoBackend.Api.Modelo.CiudadModel;
import com.proyectoBackend.Api.Servicio.ICiudadServicio;

@RestController
@RequestMapping("/proyecto/ciudades")
public class CiudadControlador {

    @Autowired
    ICiudadServicio ciudadServicio;

    // Crear
    @PostMapping("/crear")
    public ResponseEntity<String> crearCiudad(@RequestBody CiudadModel ciudad) {
        ciudadServicio.guardarCiudad(ciudad);
        return new ResponseEntity<>("Ciudad creada correctamente", HttpStatus.OK);
    }

    // Buscar
    @GetMapping("/{idCiudad}")
    public ResponseEntity<?> buscarCiudadPorId(@PathVariable int idCiudad) {
        try {
            CiudadModel ciudad = ciudadServicio.buscarCiudadPorId(idCiudad);
            return ResponseEntity.ok(ciudad);
        } catch (RecursoNoEncontradoExcepcion e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }

    // Listar
    @GetMapping("/")
    public ResponseEntity<List<CiudadModel>> listarCiudades() {
        List<CiudadModel> ciudades = ciudadServicio.listarCiudades();
        return new ResponseEntity<>(ciudades, HttpStatus.OK);
    }

    // Eliminar
    @DeleteMapping("/{idCiudad}")
    public ResponseEntity<?> eliminarCiudad(@PathVariable int idCiudad) {
        try {
            ciudadServicio.eliminarCiudad(idCiudad);
            return ResponseEntity.ok("Ciudad con ID " + idCiudad + " eliminada");
        } catch (RecursoNoEncontradoExcepcion e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }

    // Actualizar
    @PutMapping("/{idCiudad}")
    public ResponseEntity<?> actualizarCiudad(@PathVariable Integer idCiudad, @RequestBody CiudadModel ciudad) {
        try {
            CiudadModel ciudadActualizada = ciudadServicio.actualizarCiudad(idCiudad, ciudad);
            return ResponseEntity.ok(ciudadActualizada);
        } catch (RecursoNoEncontradoExcepcion e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }
}
