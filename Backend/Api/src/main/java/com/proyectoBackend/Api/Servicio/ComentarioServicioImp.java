package com.proyectoBackend.Api.Servicio;

import com.proyectoBackend.Api.Excepcion.RecursoNoEncontradoExcepcion;
import com.proyectoBackend.Api.Modelo.ComentarioModel;
import com.proyectoBackend.Api.Repositorio.IComentarioRepositorio;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ComentarioServicioImp implements IComentarioServicio {

    @Autowired
    IComentarioRepositorio comentarioRepositorio;

    @Override
    public String guardarComentario(ComentarioModel comentario) {
        comentarioRepositorio.save(comentario);
        return "Se creó el comentario con ID " + comentario.getIdComentario() + ".";
    }

    @Override
    public ComentarioModel buscarComentarioPorId(int idComentario) {
        Optional<ComentarioModel> comentarioOptional = comentarioRepositorio.findById(idComentario);
        return comentarioOptional.orElseThrow(() -> new RecursoNoEncontradoExcepcion("Comentario con ID " + idComentario + " no encontrado"));
    }

    @Override
    public List<ComentarioModel> listarComentarios() {
        return comentarioRepositorio.findAll();
    }

    @Override
    public void eliminarComentario(int idComentario) {
        if (!comentarioRepositorio.existsById(idComentario)) {
            throw new RecursoNoEncontradoExcepcion("Comentario no encontrado");
        } else {
            comentarioRepositorio.deleteById(idComentario);
        }
    }

    @Override
    public ComentarioModel actualizarComentario(Integer idComentario, ComentarioModel comentario) {
        Optional<ComentarioModel> comentarioExistenteOptional = comentarioRepositorio.findById(idComentario);
        if (comentarioExistenteOptional.isPresent()) {
            ComentarioModel comentarioExistente = comentarioExistenteOptional.get();
            comentarioExistente.setComentario(comentario.getComentario());
            comentarioExistente.setCalificacion(comentario.getCalificacion());
            return comentarioRepositorio.save(comentarioExistente);
        } else {
            throw new RecursoNoEncontradoExcepcion("Comentario con ID " + idComentario + " no encontrado.");
        }
    }
}
