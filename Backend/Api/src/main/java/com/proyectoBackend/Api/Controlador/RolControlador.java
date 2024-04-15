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
import com.proyectoBackend.Api.Modelo.RolModel;
import com.proyectoBackend.Api.Modelo.UsuarioModel;
import com.proyectoBackend.Api.Servicio.IRolServicio;
import com.proyectoBackend.Api.Servicio.IUsuarioServicio;

@RestController
@RequestMapping ("/proyecto/rol")

public class RolControlador {
    @Autowired IRolServicio rolServicio;
    @Autowired IUsuarioServicio usuarioServicio;

    @PostMapping("/crear")
    public ResponseEntity<String> crearRol(@RequestBody RolModel rol) {
        try {
            Integer idUsuario = rol.getIdUsuario().getId();
            UsuarioModel usuario = usuarioServicio.buscarUsuarioXid(idUsuario);
            if (usuario != null) {
                rolServicio.guardarRol(rol);
                return new ResponseEntity<String>(rolServicio.guardarRol(rol), HttpStatus.OK);
            } else {
                throw new RecursoNoEncontradoExcepcion("No se encontró usuario");
            }
        } catch (RecursoNoEncontradoExcepcion e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> buscarRolXid(@PathVariable int id) {
        try {
            RolModel rol = rolServicio.buscarRolXid(id);
            return ResponseEntity.ok(rol);
        } catch (Exception e) {
            String mensajeError = e.getMessage();
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(mensajeError);
        }
    }

    @GetMapping("/")
    public ResponseEntity<List<RolModel>> listarRolesXusuario() {
        List<RolModel> roles = rolServicio.listarRolesXusuario();
        return new ResponseEntity<List<RolModel>>(roles, HttpStatus.OK);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> eliminarRolXid(@PathVariable int id) {
        try {
            rolServicio.eliminarRol(id);
            return ResponseEntity.ok("Rol con ID " + id + " eliminado");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }
    
    //falta implementar.
    @PutMapping("(/{id})")
    public ResponseEntity<?> actualizarRol(@PathVariable Integer id, @RequestBody RolModel rol) {
        try {
            RolModel rolActualizado = rolServicio.actualizarRol(id, rol);
            return ResponseEntity.ok(rolActualizado);
        } catch (RecursoNoEncontradoExcepcion e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }

}
