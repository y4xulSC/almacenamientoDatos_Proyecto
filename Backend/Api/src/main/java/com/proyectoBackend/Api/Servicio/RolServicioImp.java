package com.proyectoBackend.Api.Servicio;

import java.util.List;
import java.util.Optional;

//import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.proyectoBackend.Api.Excepcion.RecursoNoEncontradoExcepcion;
import com.proyectoBackend.Api.Excepcion.RecursoYaExistente;
//import com.proyectoBackend.Api.Excepcion.ExistByUserId;
//import com.proyectoBackend.Api.Modelo.UsuarioModel;
import com.proyectoBackend.Api.Modelo.RolModel;
import com.proyectoBackend.Api.Repositorio.IRolRepositorio;
//import com.proyectoBackend.Api.Repositorio.IUsuarioRepositorio;
import com.proyectoBackend.Api.Repositorio.IUsuarioRepositorio;

@Service
public class RolServicioImp implements IRolServicio {
    
    @Autowired IRolRepositorio rolRepositorio;

    @Autowired IUsuarioRepositorio usuarioRepositorio;
   
    //@Autowired IUsuarioRepositorio usuarioRepositorio;
   
    @Override
    public String guardarRol (RolModel rol) {
        Integer idUsuario = rol.getUsuario().getIdUsuario(); // Obtener el idUsuario del rol
        
        // Verificar si el idUsuario existe en la base de datos
        if (!usuarioRepositorio.existsById(idUsuario)) {
            throw new RecursoNoEncontradoExcepcion("Usuario con ID " + idUsuario + " no encontrado");
        } else if (rolRepositorio.existsById(idUsuario)) { // Verificar si el usuario ya tiene un rol asignado
            throw new RecursoYaExistente("El usuario con ID " + idUsuario + " ya tiene un rol asignado");
        } else { // Continuar con el proceso de guardar el rol si el idUsuario existe
            rolRepositorio.save(rol);
            return "Se dio acceso con el rol " + rol.getNombreRol();
        }
    }

    public RolModel buscarRolXid(int idRol) {
        Optional<RolModel> rolEncontrado = rolRepositorio.findById(idRol);
        return rolEncontrado.orElseThrow(() -> new RecursoNoEncontradoExcepcion("Rol no encontrado por el id " + idRol));
    }

    public List<RolModel> listarRolesXusuario() {
        return rolRepositorio.findAll();
    }

    public void eliminarRol(int idRol) {
        if (!rolRepositorio.existsById(idRol)) {
            throw new RecursoNoEncontradoExcepcion("Rol no encontrado");
        } else {
            rolRepositorio.deleteById(idRol);
        }
    }

    @Override

    public RolModel actualizarRol(Integer idRol, RolModel rol) {
        // Verificar si el rol existe
        Optional<RolModel> rolOptional = rolRepositorio.findById(idRol);
        if (rolOptional.isPresent()) {
            RolModel rolExistente = rolOptional.get();
            // Verificar si el usuario asociado al rol existe
            if (usuarioRepositorio.existsById(rol.getUsuario().getIdUsuario())) {
                // Actualizar los campos del rol existente con los valores del rol proporcionado
                rolExistente.setContrasena(rol.getContrasena());
                rolExistente.setNombreRol(rol.getNombreRol());
                // Actualizar cualquier otro campo según sea necesario
                
                // Guardar el rol actualizado en la base de datos
                return rolRepositorio.save(rolExistente);
            } else {
                // Si el usuario asociado al rol no existe, lanzar una excepción
                throw new RecursoNoEncontradoExcepcion("Usuario con ID " + rol.getUsuario().getIdUsuario() + " no encontrado");
            }
        } else {
            // Si el rol con el ID especificado no existe, lanzar una excepción
            throw new RecursoNoEncontradoExcepcion("Rol con ID " + idRol + " no encontrado");
        }
    }

}