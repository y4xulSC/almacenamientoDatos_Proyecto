package com.proyectoBackend.Api.Servicio;

import java.util.List;
import java.util.Optional;

//import org.hibernate.mapping.List;

import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;

import com.proyectoBackend.Api.Excepcion.ExistByUserId;
import com.proyectoBackend.Api.Excepcion.ExistNombreUsuario;
import com.proyectoBackend.Api.Excepcion.RecursoNoEncontradoExcepcion;
import com.proyectoBackend.Api.Modelo.UsuarioModel;
import com.proyectoBackend.Api.Repositorio.IUsuarioRepositorio;

@Service
public class UsuarioServicioImp implements IUsuarioServicio {
    @Autowired IUsuarioRepositorio usuarioRepositorio;
    
    @Override
    public String guardarUsuario(UsuarioModel usuario) {
        usuarioRepositorio.save(usuario);
        return "El usuario con el ID " + usuario.getIdUsuario() + " fue creado con éxito";
    }

    public UsuarioModel buscarUsuarioXid (int idUsuario) {
        //Optional<UsuarioModel> usuarioEncontrado = usuarioRepositorio.findOne(id);
        Optional<UsuarioModel> usuarioEncontrado = usuarioRepositorio.findById(idUsuario);
        return usuarioEncontrado.orElseThrow(() -> new RecursoNoEncontradoExcepcion("Usuario no encontrado por el id " + idUsuario));
    }

    public List<UsuarioModel> listarUsuarios() {
        return usuarioRepositorio.findAll();
    }
    
    public UsuarioModel buscarXnombre(String nombreUsuario) {
        throw new UnsupportedOperationException("Unimplemented method 'buscarXnombre'");
    }

    public void eliminarUsuario(int idUsuario){
        if (!usuarioRepositorio.existsById(idUsuario)) {
            throw new RecursoNoEncontradoExcepcion(" usuario con ID " + idUsuario + " no encontrado");
        }
        usuarioRepositorio.deleteById(idUsuario);
    }

    public boolean existsByNombreUsuarioOrEmail(String nombreUsuario, String email) {
        return usuarioRepositorio.existsByNombreUsuarioOrEmail(nombreUsuario, email);
    }

    public UsuarioModel actualizarUsuario(Integer idUsuario, UsuarioModel usuario) {
        // Verificar si el usuario existe
        Optional<UsuarioModel> usuarioOptional = usuarioRepositorio.findById(idUsuario);
        if (usuarioOptional.isPresent()) {
            UsuarioModel usuarioExistente = usuarioOptional.get();
            // Verificar si el nombre de usuario o el correo electrónico ya están en uso por otro usuario
            if (usuarioExistente.getIdUsuario() != usuario.getIdUsuario()) { //} && usuarioExistente.getNombreUsuario() == usuario.getNombreUsuario()) {
                throw new ExistByUserId("Ya hay usuarios usando el mismo email o nombre de usuario");
            } else {
                if (usuarioRepositorio.existsByNombreUsuarioOrEmail(usuario.getNombreUsuario(), usuario.getEmail())) {
                    usuarioExistente.setNombreUsuario(usuario.getNombreUsuario());
                    usuarioExistente.setNombre(usuario.getNombre());
                    usuarioExistente.setEmail(usuario.getEmail());
                    usuarioExistente.setTelefono(usuario.getTelefono());
                    usuarioExistente.setEdad(usuario.getEdad());
                    usuarioExistente.setSexo(usuario.getSexo());
                    return usuarioRepositorio.save(usuarioExistente);
                } else {
                    throw new ExistNombreUsuario("El nombre de usuario '" + usuario.getNombreUsuario() + " o el correo electrónico '" + usuario.getEmail() + "' ya están en uso");
                }
            }
        } else {
            throw new RecursoNoEncontradoExcepcion("Usuario con ID " + idUsuario + " no encontrado");
        }
    }
}

        
