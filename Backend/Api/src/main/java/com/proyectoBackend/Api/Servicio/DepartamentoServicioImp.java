package com.proyectoBackend.Api.Servicio;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.proyectoBackend.Api.Excepcion.RecursoNoEncontradoExcepcion;
import com.proyectoBackend.Api.Excepcion.RecursoYaExistente;
import com.proyectoBackend.Api.Modelo.DepartamentoModel;
import com.proyectoBackend.Api.Repositorio.IDepartamentoRepositorio;

@Service
public class DepartamentoServicioImp implements IDepartamentoServicio {

    @Autowired
    IDepartamentoRepositorio departamentoRepositorio;

    @Override
    public String guardarDepartamento(DepartamentoModel departamento) {
    // Obtener el nombre del departamento
    String nombre = departamento.getNombre();

    // Verificar si el departamento ya existe en la base de datos
    if (departamentoRepositorio.existsByNombre(nombre)) {
        throw new RecursoYaExistente("Departamento con nombre '" + nombre + "' ya existe");
    } else {
        // Guardar el departamento en la base de datos si no existe
        departamentoRepositorio.save(departamento);
        return "Departamento creado con éxito";
    }
}


    @Override
    public DepartamentoModel buscarDepartamentoPorId(int idDepartamento) {
        Optional<DepartamentoModel> departamentoEncontrado = departamentoRepositorio.findById(idDepartamento);
        return departamentoEncontrado.orElseThrow(() -> new RecursoNoEncontradoExcepcion("El departamento no se encuentra en la base de datos."));
    }

    @Override
    public List<DepartamentoModel> listarDepartamentos() {
        return departamentoRepositorio.findAll();
    }

    @Override
    public void eliminarDepartamento(int idDepartamento) {
        if (!departamentoRepositorio.existsById(idDepartamento)) {
            throw new RecursoNoEncontradoExcepcion("Departamento con ID: " + idDepartamento +  " no encontrado");
        } else {
            departamentoRepositorio.deleteById(idDepartamento);
        }
    }

    public DepartamentoModel actualizarDepartamento(Integer idDepartamento, DepartamentoModel departamento) {
    // Verificar si el departamento existe
    Optional<DepartamentoModel> departamentoOptional = departamentoRepositorio.findById(idDepartamento);
    if (departamentoOptional.isPresent()) {
        DepartamentoModel departamentoExistente = departamentoOptional.get();
        
        // Actualizar los campos del departamento existente con los valores del departamento proporcionado
        departamentoExistente.setNombre(departamento.getNombre());
        // Actualizar cualquier otro campo según sea necesario
        
        // Guardar el departamento actualizado en la base de datos
        return departamentoRepositorio.save(departamentoExistente);
    } else {
        // Si el departamento con el ID especificado no existe, lanzar una excepción
        throw new RecursoNoEncontradoExcepcion("Departamento con ID " + idDepartamento + " no encontrado");
    }
}

}