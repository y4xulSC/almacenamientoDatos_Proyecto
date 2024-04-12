package com.ProjectOnlineShop.Service;



import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Enum.Sexo;
import com.Exception.ExistNombreUsuario;
import com.Exception.NoEncontradoException;
import com.Exception.SexoInvalidoException;
import com.ProjectOnlineShop.Model.UsuarioModel;
import com.ProjectOnlineShop.Repository.IUsuarioRepository;

@Service
public class UsuarioServiceImp implements IUsuarioService {

    @Autowired
    IUsuarioRepository usuarioRepository;
    
    @Override
public String guardarUsuario(UsuarioModel usuario) {
    // Verificar si ya existe un usuario con el mismo nombre de usuario o correo electrónico
    if (usuarioRepository.existsByNombreUsuarioOrEmail(usuario.getNombreUsuario(), usuario.getEmail())) {
        throw new ExistNombreUsuario("El nombre de usuario '" + usuario.getNombreUsuario() + "' o el correo electrónico '" + usuario.getEmail() + "' ya están en uso");
    }
    // Verificar si el valor de sexo es HOMBRE o MUJER
    if(!(usuario.getSexo().equals(Sexo.HOMBRE) || usuario.getSexo().equals(Sexo.MUJER))) {
        throw new SexoInvalidoException("El sexo ingresado es inválido");
    }

    usuarioRepository.save(usuario);
    return null;
}
  

    @Override
    public boolean existsByNombreUsuarioOrEmail(String nombreUsuario, String email) {
        return usuarioRepository.existsByNombreUsuarioOrEmail(nombreUsuario, email);
    }

    @Override
    public UsuarioModel buscarUsuarioPorId(int idUsuario) {
        Optional<UsuarioModel> usuarioOptional = usuarioRepository.findById(idUsuario);
        return usuarioOptional.orElseThrow(() -> new NoEncontradoException("Id " + idUsuario + " No encontrada"));
    }

    @Override
    public List<UsuarioModel> listarUsuarios() {
        return usuarioRepository.findAll();
    }   

    @Override
    public UsuarioModel actualizarUsuario(Integer idUsuario, UsuarioModel usuario) {
        
        // Verificar si el nombre de usuario o el correo electrónico ya están en uso por otro usuario
        
        if (usuarioRepository.existsByNombreUsuarioOrEmail(usuario.getNombreUsuario(), usuario.getEmail())) {
            throw new ExistNombreUsuario("El nombre de usuario '" + usuario.getNombreUsuario() 
            + " o el correo electrónico '" + usuario.getEmail() + "' ya están en uso");
        }
        
        // Verificar si el usuario existe
        
        Optional<UsuarioModel> usuarioOptional = usuarioRepository.findById(idUsuario);
        if (usuarioOptional.isPresent()) {
            UsuarioModel usuarioExistente = usuarioOptional.get();
            usuarioExistente.setNombreUsuario(usuario.getNombreUsuario());
            usuarioExistente.setNombre(usuario.getNombre());
            usuarioExistente.setEmail(usuario.getEmail());
            usuarioExistente.setTelefono(usuario.getTelefono());
            usuarioExistente.setEdad(usuario.getEdad());
            usuarioExistente.setSexo(usuario.getSexo());
            
            return usuarioRepository.save(usuarioExistente);
        } else {
            throw new NoEncontradoException("Usuario con ID " + idUsuario + " no encontrado");
        }
    }
}



  

