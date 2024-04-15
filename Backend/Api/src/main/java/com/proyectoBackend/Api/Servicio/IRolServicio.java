package com.proyectoBackend.Api.Servicio;

import java.util.List;

import com.proyectoBackend.Api.Modelo.RolModel;
//import com.proyectoBackend.Api.Modelo.UsuarioModel;;

public interface IRolServicio {
    String guardarRol(RolModel rol);
    RolModel buscarRolXid(int id);
    List<RolModel> listarRolesXusuario();
    void eliminarRol(int id);
    RolModel actualizarRol(Integer id, RolModel rol);
}