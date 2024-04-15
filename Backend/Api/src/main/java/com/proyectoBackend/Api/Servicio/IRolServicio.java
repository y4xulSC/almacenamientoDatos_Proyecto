package com.proyectoBackend.Api.Servicio;

import java.util.List;

import com.proyectoBackend.Api.Modelo.RolModel;
//import com.proyectoBackend.Api.Modelo.UsuarioModel;;

public interface IRolServicio {
    String guardarRol(RolModel rol);

    List<RolModel> listarRolesXusuario();
    
    RolModel buscarRolXid(int idRol);

    void eliminarRol(int idRol);

    RolModel actualizarRol(Integer idRol, RolModel rol);
}