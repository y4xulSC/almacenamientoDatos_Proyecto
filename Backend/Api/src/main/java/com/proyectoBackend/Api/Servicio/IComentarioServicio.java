package com.proyectoBackend.Api.Servicio;

import com.proyectoBackend.Api.Modelo.ComentarioModel;
import java.util.List;

public interface IComentarioServicio {

    String guardarComentario(ComentarioModel comentario);

    ComentarioModel buscarComentarioPorId(int idComentario);

    List<ComentarioModel> listarComentarios();

    void eliminarComentario(int idComentario);

    ComentarioModel actualizarComentario(Integer idComentario, ComentarioModel comentario);
}
