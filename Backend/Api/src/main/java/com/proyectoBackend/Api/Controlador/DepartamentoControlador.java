package com.proyectoBackend.Api.Controlador;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.proyectoBackend.Api.Excepcion.RecursoNoEncontradoExcepcion;
import com.proyectoBackend.Api.Modelo.DepartamentoModel;
import com.proyectoBackend.Api.Repositorio.IDepartamentoRepositorio;
import com.proyectoBackend.Api.Servicio.IDepartamentoServicio;

@RestController
@RequestMapping("/proyecto/departamento")
public class DepartamentoControlador {

    @Autowired IDepartamentoServicio departamentoServicio;
    @Autowired IDepartamentoRepositorio departamentoRepositorio;

    // Crear
    @PostMapping("/crear")
    public ResponseEntity<String> crearDepartamento(@RequestBody DepartamentoModel departamento) {
        departamentoServicio.guardarDepartamento(departamento);
        return new ResponseEntity<String>("Departamento creado correctamente", HttpStatus.OK);
        //try {
            //Lo de arriba
        //} catch (RecursoYaExistente e) {
        //    return ResponseEntity.status(HttpStatus.CONFLICT).body(e.getMessage());
        //}
    }

    // Buscar
    @GetMapping("/{idDepartamento}")
    public ResponseEntity<?> buscarDepartamentoPorId(@PathVariable int idDepartamento) {
        try {
            DepartamentoModel departamento = departamentoServicio.buscarDepartamentoPorId(idDepartamento);
            return ResponseEntity.ok(departamento);
        } catch (RecursoNoEncontradoExcepcion e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }

    // Listar
    @GetMapping("/")
    public ResponseEntity<List<DepartamentoModel>> listarDepartamentos() {
        List<DepartamentoModel> departamentos = departamentoServicio.listarDepartamentos();
        return new ResponseEntity<List<DepartamentoModel>>(departamentos, HttpStatus.OK);
    }

    // Eliminar
    @DeleteMapping("/{idDepartamento}")
    public ResponseEntity<?> eliminarDepartamento(@PathVariable int idDepartamento) {
        try {
            departamentoServicio.eliminarDepartamento(idDepartamento);
            return ResponseEntity.ok("Departamento con ID " + idDepartamento + " eliminado");
        } catch (RecursoNoEncontradoExcepcion e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }

    // Actualizar
    @PutMapping("/{idDepartamento}")
    public ResponseEntity<?> actualizarDepartamento(@PathVariable Integer idDepartamento, @RequestBody DepartamentoModel departamento) {
        try {
            DepartamentoModel departamentoActualizado = departamentoServicio.actualizarDepartamento(idDepartamento, departamento);
            return ResponseEntity.ok(departamentoActualizado);
        } catch (RecursoNoEncontradoExcepcion e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }
}
