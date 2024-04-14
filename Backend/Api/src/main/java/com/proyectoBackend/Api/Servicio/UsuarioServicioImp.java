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
        return "El usuario con el ID " + usuario.getId() + " fue creado con éxito";
    }

    public UsuarioModel buscarUsuarioXid (int id) {
        //Optional<UsuarioModel> usuarioEncontrado = usuarioRepositorio.findOne(id);
        Optional<UsuarioModel> usuarioEncontrado = usuarioRepositorio.findById(id);
        return usuarioEncontrado.orElseThrow(() -> new RecursoNoEncontradoExcepcion("Usuario no encontrado por el id " + id));
    }

    public List<UsuarioModel> listarUsuarios() {
        return usuarioRepositorio.findAll();
    }
    
    //public UsuarioModel buscarUsuarioXvalor (valor) {
    //    
    //}

    public void eliminarUsuario(int id){
        if (!usuarioRepositorio.existsById(id)) {
            throw new RecursoNoEncontradoExcepcion(" usuario con ID " + id + " no encontrado");
        }
        usuarioRepositorio.deleteById(id);
    }

    public boolean existsByNombreUsuarioOrEmail(String nombreUsuario, String email) {
        return usuarioRepositorio.existsByNombreUsuarioOrEmail(nombreUsuario, email);
    }

    public UsuarioModel actualizarUsuario(Integer id, UsuarioModel usuario) {
        
        // Verificar si el usuario existe
        
        Optional<UsuarioModel> usuarioOptional = usuarioRepositorio.findById(id);
        if (usuarioOptional.isPresent()) {
            
            UsuarioModel usuarioExistente = usuarioOptional.get();
            
            // Verificar si el nombre de usuario o el correo electrónico ya están en uso por otro usuario
            
            if (usuarioExistente.getId() != usuario.getId()) { //} && usuarioExistente.getNombreUsuario() == usuario.getNombreUsuario()) {
                throw new ExistByUserId("Ya hay usuarios usando el mismo email o nombre de usuario");
            } else {
                if (usuarioRepositorio.existsByNombreUsuarioOrEmail(usuario.getNombreUsuario(), usuario.getEmail())) {
                    
                    // Validar si los datos del usuario coinciden con los datos del usuario existente
                    // if (!usuarioExistente.equals(usuario)) {
                        //     throw new ExistByUserId(usuarioExistente + "\nLos datos del usuario a actualizar no coinciden con los datos del usuario existente.");
                    // }
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
            //else {
            //    usuarioExistente.setNombreUsuario(usuario.getNombreUsuario());
            //    usuarioExistente.setNombre(usuario.getNombre());
            //    usuarioExistente.setEmail(usuario.getEmail());
            //    usuarioExistente.setTelefono(usuario.getTelefono());
            //    usuarioExistente.setEdad(usuario.getEdad());
            //    usuarioExistente.setSexo(usuario.getSexo());
            //    return usuarioRepositorio.save(usuarioExistente);
            //}
        } else {
            throw new RecursoNoEncontradoExcepcion("Usuario con ID " + id + " no encontrado");
        }
    }
}

        
