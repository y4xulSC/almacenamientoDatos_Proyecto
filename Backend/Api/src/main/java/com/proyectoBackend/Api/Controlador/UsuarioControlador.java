package com.proyectoBackend.Api.Controlador;

//import java.util.List;

//import org.hibernate.mapping.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
//import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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

    @GetMapping("/{id}")
    public ResponseEntity<?> buscarUsuarioXid(@PathVariable int id) {
        try {
            UsuarioModel usuario = usuarioServicio.buscarUsuarioXid(id);
            return ResponseEntity.ok(usuario);
        } catch (RecursoNoEncontradoExcepcion e) {
            String mensajeError = e.getMessage();
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(mensajeError);
        }
    }
}
