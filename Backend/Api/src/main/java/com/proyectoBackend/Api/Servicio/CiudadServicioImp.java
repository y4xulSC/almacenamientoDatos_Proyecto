package com.proyectoBackend.Api.Servicio;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.proyectoBackend.Api.Excepcion.RecursoNoEncontradoExcepcion;
import com.proyectoBackend.Api.Excepcion.RecursoYaExistente;
import com.proyectoBackend.Api.Modelo.CiudadModel;
import com.proyectoBackend.Api.Repositorio.ICiudadRepositorio;

@Service
public class CiudadServicioImp implements ICiudadServicio {

    @Autowired
    ICiudadRepositorio ciudadRepositorio;

    @Override
    public String guardarCiudad(CiudadModel ciudad) {
        // Verificar si la ciudad ya existe en la base de datos
        if (ciudadRepositorio.existsByNombre(ciudad.getNombre())) {
            throw new RecursoYaExistente("Ciudad con nombre '" + ciudad.getNombre() + "' ya existe");
        } else {
            // Guardar la ciudad en la base de datos si no existe
            ciudadRepositorio.save(ciudad);
            return "Ciudad creada con éxito";
        }
    }

    @Override
    public CiudadModel buscarCiudadPorId(int idCiudad) {
        Optional<CiudadModel> ciudadEncontrada = ciudadRepositorio.findById(idCiudad);
        return ciudadEncontrada.orElseThrow(() -> new RecursoNoEncontradoExcepcion("La ciudad no se encuentra en la base de datos."));
    }

    @Override
    public List<CiudadModel> listarCiudades() {
        return ciudadRepositorio.findAll();
    }

    @Override
    public void eliminarCiudad(int idCiudad) {
        if (!ciudadRepositorio.existsById(idCiudad)) {
            throw new RecursoNoEncontradoExcepcion("Ciudad con ID: " + idCiudad +  " no encontrada");
        } else {
            ciudadRepositorio.deleteById(idCiudad);
        }
    }

    @Override
    public CiudadModel actualizarCiudad(Integer idCiudad, CiudadModel ciudad) {
        // Verificar si la ciudad existe
        Optional<CiudadModel> ciudadOptional = ciudadRepositorio.findById(idCiudad);
        if (ciudadOptional.isPresent()) {
            CiudadModel ciudadExistente = ciudadOptional.get();
            
            // Actualizar los campos de la ciudad existente con los valores de la ciudad proporcionada
            ciudadExistente.setNombre(ciudad.getNombre());
            ciudadExistente.setCodigoPostal(ciudad.getCodigoPostal());
            ciudadExistente.setIdDepartamento(ciudad.getIdDepartamento());
            // Actualizar cualquier otro campo según sea necesario
            
            // Guardar la ciudad actualizada en la base de datos
            return ciudadRepositorio.save(ciudadExistente);
        } else {
            // Si la ciudad con el ID especificado no existe, lanzar una excepción
            throw new RecursoNoEncontradoExcepcion("Ciudad con ID " + idCiudad + " no encontrada");
        }
    }
}
