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

@Service
public class RolServicioImp implements IRolServicio {
    @Autowired IRolRepositorio rolRepositorio;
    //@Autowired IUsuarioRepositorio usuarioRepositorio;
    @Override

    public String guardarRol (RolModel rol) {
        rolRepositorio.save(rol);
        return "Se dio acceso con el rol " + rol.getNombreRol();
    }

    public RolModel buscarRolXid(int id) {
        Optional<RolModel> rolEncontrado = rolRepositorio.findById(id);
        return rolEncontrado.orElseThrow(() -> new RecursoNoEncontradoExcepcion("Rol no encontrado por el id " + id));
    }

    public List<RolModel> listarRolesXusuario() {
        return rolRepositorio.findAll();
    }

    public void eliminarRol(int id) {
        if (!rolRepositorio.existsById(id)) {
            throw new RecursoNoEncontradoExcepcion("Rol no encontrado");
        } else {
            rolRepositorio.deleteById(id);
        }
    }
}
