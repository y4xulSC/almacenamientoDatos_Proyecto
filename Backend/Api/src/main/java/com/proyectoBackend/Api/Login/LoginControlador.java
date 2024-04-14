package com.proyectoBackend.Api.Login;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.proyectoBackend.Api.Excepcion.ExistNombreUsuario;
import com.proyectoBackend.Api.Modelo.UsuarioModel;
import com.proyectoBackend.Api.Servicio.IUsuarioServicio;

@RestController
@RequestMapping ("/login")

public class LoginControlador {
    @Autowired IUsuarioServicio usuarioServicio;

    @GetMapping("/{username}-{email}-{passwd}")
    public ResponseEntity<String> login(@PathVariable String username, @PathVariable String email, @PathVariable String passwd) {
        try {
            boolean encontrado = usuarioServicio.existsByNombreUsuarioOrEmail(username, email);
            return ResponseEntity.ok(encontrado);
        } catch (ExistNombreUsuario e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }
}
