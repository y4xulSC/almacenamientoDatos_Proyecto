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
import com.proyectoBackend.Api.Modelo.DisenoModel;
<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
import com.proyectoBackend.Api.Servicio.IDisenoServicio;

@RestController
@RequestMapping ("/proyecto/diseno")

public class DisenoControlador {
    @Autowired IDisenoServicio disenoServicio;

<<<<<<< Updated upstream
   

=======
>>>>>>> Stashed changes
    @PostMapping("/crearDiseno")
    public ResponseEntity<String> crearDiseno(@RequestBody DisenoModel diseno) {
        disenoServicio.guardarDiseno(diseno);
        return new ResponseEntity<String>(disenoServicio.guardarDiseno(diseno), HttpStatus.OK);
    }

    @GetMapping("/{idDiseno}")
<<<<<<< Updated upstream
    public ResponseEntity<?> buscarDisenoXid(@PathVariable int idDiseno) {
=======
    public ResponseEntity<?> buscarUsuarioXid(@PathVariable int idDiseno) {
>>>>>>> Stashed changes
        try {
            DisenoModel diseno = disenoServicio.buscarDisenoXid(idDiseno);
            return ResponseEntity.ok(diseno);
        } catch (RecursoNoEncontradoExcepcion e) {
<<<<<<< Updated upstream
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
=======
            String mensajeError = e.getMessage();
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(mensajeError);
>>>>>>> Stashed changes
        }
    }

    @GetMapping("/")
    public ResponseEntity<List<DisenoModel>> obtenerTodosLosDisenos() {
        List<DisenoModel> disenos = disenoServicio.obtenerTodosLosDisenos();
        return new ResponseEntity<>(disenos, HttpStatus.OK);
    }

    @DeleteMapping("/{idDiseno}")
    public ResponseEntity<?> eliminarDiseno(@PathVariable int idDiseno) {
        try {
            disenoServicio.eliminarDiseno(idDiseno);
            return ResponseEntity.ok("Usuario con ID " + idDiseno + " eliminado correctamente");
        } catch (RecursoNoEncontradoExcepcion e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }

<<<<<<< Updated upstream
    @PutMapping("/{idDiseno}") // Corregir el formato de la ruta
    public ResponseEntity<?> actualizarDiseno(@PathVariable Integer idDiseno, @RequestBody DisenoModel diseno) {
        try {
            DisenoModel disenoActualizado = disenoServicio.actualizarDiseno(idDiseno, diseno);
            return ResponseEntity.ok(disenoActualizado);
        } catch (RecursoNoEncontradoExcepcion e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }
}

=======
    @PutMapping("/diseno/{idDiseno}") 
    
    // Corregir el formato de la ruta
    public ResponseEntity<?> actualizarDiseno(@PathVariable Integer idDiseno, @RequestBody DisenoModel diseno) {
    try {
        DisenoModel disenoActualizado = disenoServicio.actualizarDiseno(idDiseno, diseno);
        return ResponseEntity.ok(disenoActualizado);
    } catch (RecursoNoEncontradoExcepcion e) {
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
    }
}

}

>>>>>>> Stashed changes
