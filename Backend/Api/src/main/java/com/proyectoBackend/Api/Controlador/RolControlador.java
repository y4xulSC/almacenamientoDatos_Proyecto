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
import com.proyectoBackend.Api.Repositorio.IUsuarioRepositorio;
import com.proyectoBackend.Api.Servicio.IRolServicio;
import com.proyectoBackend.Api.Servicio.IUsuarioServicio;

@RestController
@RequestMapping ("/proyecto/rol")

public class RolControlador {
    @Autowired IRolServicio rolServicio;
    
    @Autowired IUsuarioServicio usuarioServicio;

    @Autowired IUsuarioRepositorio usuarioRepositorio;
   
    //Crear

    @PostMapping("/crearRol")
    public ResponseEntity<?> crearRol(@RequestBody RolModel rol) {
        try {
            Integer idUsuario = rol.getIdUsuario().getIdUsuario();
            UsuarioModel usuario = usuarioServicio.buscarUsuarioXid(idUsuario);
            if (usuario != null) {
                rolServicio.guardarRol(rol);
                return new ResponseEntity<String>(rolServicio.guardarRol(rol), HttpStatus.OK);
            } else {
                throw new RecursoNoEncontradoExcepcion("No se encontró el usuario");
            }
        } catch (RecursoNoEncontradoExcepcion e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        } catch (RecursoYaExistente e) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body(e.getMessage());
        }
    }

    // Buscar
    @GetMapping("/{idRol}")
    public ResponseEntity<?> buscarRolXid(@PathVariable int idRol) {
        try {
            RolModel rol = rolServicio.buscarRolXid(idRol);
            return ResponseEntity.ok(rol);
        } catch (Exception e) {
            String mensajeError = e.getMessage();
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(mensajeError);
        }
    }

    // Listar
    @GetMapping("/")
    public ResponseEntity<List<RolModel>> listarRolesXusuario() {
        List<RolModel> rol = rolServicio.listarRolesXusuario();
        return new ResponseEntity<List<RolModel>>(rol, HttpStatus.OK);
    }

    // Eliminar
    @DeleteMapping("/{idRol}")
    public ResponseEntity<?> eliminarRolXid(@PathVariable int idRol) {
        try {
            rolServicio.eliminarRol(idRol);
            return ResponseEntity.ok("Rol con ID " + idRol + " eliminado");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }
    
    //Actualizar
    @PutMapping("/{idRol}") // Corregir el formato de la ruta
    public ResponseEntity<?> actualizarRol(@PathVariable Integer idRol, @RequestBody RolModel rol) {
        try {
            // Verificar si el usuario asociado al rol existe
            if (!usuarioRepositorio.existsById(rol.getIdUsuario().getIdUsuario())) {
                // Si el usuario no existe, lanzar una excepción
                throw new RecursoNoEncontradoExcepcion("Usuario con ID " + rol.getIdUsuario().getIdUsuario() + " no encontrado");
            }

            // Si el usuario existe, actualizar el rol
            RolModel rolActualizado = rolServicio.actualizarRol(idRol, rol);
            return ResponseEntity.ok(rolActualizado);
        } catch (RecursoNoEncontradoExcepcion e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }

    
}
