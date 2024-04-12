package com.proyectoBackend.Api.Servicio;

//import java.util.Optional;
//import java.util.List;

//import org.hibernate.mapping.List;

import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;

import com.proyectoBackend.Api.Modelo.UsuarioModel;
import com.proyectoBackend.Api.Repositorio.IUsuarioRepositorio;

@Service
public class UsuarioServicioImp implements IUsuarioServicio {
    @Autowired
    IUsuarioRepositorio usuarioRepositorio;
    @Override
    public String guardarUsuario(UsuarioModel usuario) {
        usuarioRepositorio.save(usuario);
        return "El usuario con el ID " + usuario.getId() + " fue creado con éxito";
    }
}
