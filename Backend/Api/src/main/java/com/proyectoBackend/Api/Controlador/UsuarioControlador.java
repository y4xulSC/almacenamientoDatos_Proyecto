package com.proyectoBackend.Api.Controlador;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.proyectoBackend.Api.Excepcion.ExistByUserId;
import com.proyectoBackend.Api.Excepcion.ExistNombreUsuario;
import com.proyectoBackend.Api.Excepcion.RecursoNoEncontradoExcepcion;
import com.proyectoBackend.Api.Modelo.UsuarioModel;
import com.proyectoBackend.Api.Servicio.IUsuarioServicio;

@RestController
@RequestMapping ("/proyecto/usuario")

public class UsuarioControlador {
    
    @Autowired IUsuarioServicio usuarioServicio;

    @PostMapping("/crear")
    public ResponseEntity<String> crearUsuario(@RequestBody UsuarioModel usuario) {
        usuarioServicio.guardarUsuario(usuario);
        return new ResponseEntity<String>(usuarioServicio.guardarUsuario(usuario), HttpStatus.OK);
    }

    @GetMapping("/{idUsuario}")
    public ResponseEntity<?> buscarUsuarioXid(@PathVariable int idUsuario) {
        try {
            UsuarioModel usuario = usuarioServicio.buscarUsuarioXid(idUsuario);
            return ResponseEntity.ok(usuario);
        } catch (RecursoNoEncontradoExcepcion e) {
            String mensajeError = e.getMessage();
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(mensajeError);
        }
    }

    @GetMapping("/")
    public ResponseEntity<List<UsuarioModel>> listarUsuarios() {
        List<UsuarioModel> usuarios = usuarioServicio.listarUsuarios();
        return new ResponseEntity<List<UsuarioModel>> (usuarios, HttpStatus.OK);
    }
    
    @GetMapping("7{nombreUsuario}")
    public ResponseEntity<?> buscarXnombre() {
        return null;
    }

    @DeleteMapping("/{idUsuario}")
    public ResponseEntity<?> eliminarUsuario(@PathVariable int idUsuario) {
        try {
            usuarioServicio.eliminarUsuario(idUsuario);
            return ResponseEntity.ok("Usuario con ID " + idUsuario + " eliminado correctamente");
        } catch (RecursoNoEncontradoExcepcion e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }

    @PutMapping("/{idUsuario}")
    public ResponseEntity<?> actualizarUsuario(@PathVariable Integer idUsuario, @RequestBody UsuarioModel usuario) {
        try {
            UsuarioModel usuarioActualizado = usuarioServicio.actualizarUsuario(idUsuario, usuario);
            return ResponseEntity.ok(usuarioActualizado);
        } catch (RecursoNoEncontradoExcepcion e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        } catch (ExistNombreUsuario e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        } catch (ExistByUserId e) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body(e.getMessage());
        }
    }
    
}