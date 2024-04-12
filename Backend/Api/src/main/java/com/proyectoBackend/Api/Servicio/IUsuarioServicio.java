package com.proyectoBackend.Api.Servicio;

// import java.util.List;
import com.proyectoBackend.Api.Modelo.UsuarioModel;

public interface IUsuarioServicio {
    String guardarUsuario(UsuarioModel usuario);
    UsuarioModel buscarUsuarioXid(int id);
    // List<UsuarioModel> listarUsuarios();
    // UsuarioModel eliminarUsuarioPorId(int usuario);

}
