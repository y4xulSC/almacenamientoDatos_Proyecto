package com.ProjectOnlineShop.Service;



import java.util.List;

import com.ProjectOnlineShop.Model.UsuarioModel;


public interface IUsuarioService {
    
    String guardarUsuario(UsuarioModel usuario);

    boolean existsByNombreUsuarioOrEmail(String nombreUsuario, String email);
  
    UsuarioModel buscarUsuarioPorId(int idUsuario);
    
    List<UsuarioModel> listarUsuarios();

    UsuarioModel actualizarUsuario(Integer idUsuario, UsuarioModel usuario);

}
