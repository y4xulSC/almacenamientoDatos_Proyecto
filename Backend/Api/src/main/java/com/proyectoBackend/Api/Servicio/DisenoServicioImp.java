package com.proyectoBackend.Api.Servicio;

import java.util.Optional;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.proyectoBackend.Api.Excepcion.RecursoNoEncontradoExcepcion;
import com.proyectoBackend.Api.Modelo.DisenoModel;
import com.proyectoBackend.Api.Repositorio.IDisenoRepositorio;

@Service
public class DisenoServicioImp implements IDisenoServicio {
    @Autowired IDisenoRepositorio disenoRepositorio;
    
    @Override
    public String guardarDiseno(DisenoModel diseno) {
        disenoRepositorio.save(diseno);
        return "Se creo el diseno " + diseno.getNombreDiseno() + ".";
    }

    public DisenoModel buscarDisenoXid(int idDiseno) {
        Optional<DisenoModel> disenoEncontrado = disenoRepositorio.findById(idDiseno);
        return disenoEncontrado.orElseThrow(() -> new RecursoNoEncontradoExcepcion("El diseno no se encuentra en la base de datos."));
    }

    public List<DisenoModel> obtenerTodosLosDisenos() {
        return disenoRepositorio.findAll();
    }

	public void eliminarDiseno(Integer idDiseno) {
        if (!disenoRepositorio.existsById(idDiseno)) {
            throw new RecursoNoEncontradoExcepcion("Diseño con ID: " + idDiseno +  " no encontrado");
        } else {
            disenoRepositorio.deleteById(idDiseno);
        }
    }

    public DisenoModel actualizarDiseno(Integer idDiseno, DisenoModel diseno) {
        // Verificar si el diseño existe
        Optional<DisenoModel> disenoOptional = disenoRepositorio.findById(idDiseno);
        if (disenoOptional.isPresent()) {
            DisenoModel disenoExistente = disenoOptional.get();
            
            // Actualizar los campos del diseño existente con los valores del diseño proporcionado
            disenoExistente.setNombreDiseno(diseno.getNombreDiseno());
            disenoExistente.setCategoria(diseno.getCategoria());
            // Actualizar cualquier otro campo según sea necesario
            
            // Guardar el diseño actualizado en la base de datos

            return disenoRepositorio.save(disenoExistente);
        } else {
            
            // Si el diseño con el ID especificado no existe, lanzar una excepción
            throw new RecursoNoEncontradoExcepcion("Diseño con ID " + idDiseno + " no encontrado");
        }
    }
}

