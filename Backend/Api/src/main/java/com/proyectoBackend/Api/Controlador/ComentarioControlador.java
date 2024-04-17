package com.proyectoBackend.Api.Controlador;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import com.proyectoBackend.Api.Modelo.ComentarioModel;
import com.proyectoBackend.Api.Repositorio.IComentarioRepositorio;
import com.proyectoBackend.Api.Servicio.IComentarioServicio;
import com.proyectoBackend.Api.Excepcion.RecursoNoEncontradoExcepcion;
import com.proyectoBackend.Api.Excepcion.RecursoYaExistente;

import java.util.List;

@RestController
@RequestMapping("/proyecto/comentario")
public class ComentarioControlador {

    @Autowired 
    IComentarioServicio comentarioServicio;

    @Autowired 
    IComentarioRepositorio comentarioRepositorio;

    @PostMapping("/crear")
    public ResponseEntity<String> crearComentario(@RequestBody ComentarioModel comentario) {
        try {
            comentarioServicio.guardarComentario(comentario);
            return new ResponseEntity<String>("Comentario creado correctamente", HttpStatus.OK);
        } catch (RecursoNoEncontradoExcepcion e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        } catch (RecursoYaExistente e) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body(e.getMessage());
        }
    }

    @GetMapping("/{idComentario}")
    public ResponseEntity<?> buscarComentarioPorId(@PathVariable int idComentario) {
        try {
            ComentarioModel comentario = comentarioServicio.buscarComentarioPorId(idComentario);
            return ResponseEntity.ok(comentario);
        } catch (Exception e) {
            String mensajeError = e.getMessage();
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(mensajeError);
        }
    }

    @GetMapping("/")
    public ResponseEntity<List<ComentarioModel>> listarComentarios() {
        List<ComentarioModel> comentarios = comentarioServicio.listarComentarios();
        return new ResponseEntity<List<ComentarioModel>>(comentarios, HttpStatus.OK);
    }

    @DeleteMapping("/{idComentario}")
    public ResponseEntity<?> eliminarComentario(@PathVariable int idComentario) {
        try {
            comentarioServicio.eliminarComentario(idComentario);
            return ResponseEntity.ok("Comentario con ID " + idComentario + " eliminado");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }

    @PutMapping("/{idComentario}")
    public ResponseEntity<?> actualizarComentario(@PathVariable Integer idComentario, @RequestBody ComentarioModel comentario) {
        try {
            ComentarioModel comentarioActualizado = comentarioServicio.actualizarComentario(idComentario, comentario);
            return ResponseEntity.ok(comentarioActualizado);
        } catch (RecursoNoEncontradoExcepcion e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }
}

