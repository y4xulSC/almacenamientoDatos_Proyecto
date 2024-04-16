package com.proyectoBackend.Api.Servicio;

import com.proyectoBackend.Api.Excepcion.RecursoNoEncontradoExcepcion;
import com.proyectoBackend.Api.Modelo.PaqueteModel;
import com.proyectoBackend.Api.Repositorio.IPaqueteRepositorio;
import com.proyectoBackend.Api.Repositorio.IProductoRepositorio;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class PaqueteServicioImp implements IPaqueteServicio {

    @Autowired 
    IPaqueteRepositorio paqueteRepositorio;

    @Autowired 
    IProductoRepositorio productoRepositorio;

    @Override
    public String guardarPaquete(PaqueteModel paquete) {
        paqueteRepositorio.save(paquete);
        return "El paquete con el ID " + paquete.getIdPaquete() + " fue creado con éxito.";
    }

    @Override
    public PaqueteModel buscarPaquetePorId(int idPaquete) {
        Optional<PaqueteModel> paqueteOptional = paqueteRepositorio.findById(idPaquete);
        return paqueteOptional.orElseThrow(() -> new RecursoNoEncontradoExcepcion("Paquete con ID " + idPaquete + " no encontrado"));
    }

    @Override
    public List<PaqueteModel> listarPaquetes() {
        return paqueteRepositorio.findAll();
    }

    @Override
    public void eliminarPaquete(int idPaquete) {
        if (paqueteRepositorio.existsById(idPaquete)) {
            paqueteRepositorio.deleteById(idPaquete);
        } else {
            throw new RecursoNoEncontradoExcepcion("Paquete con ID " + idPaquete + " no encontrado");
        }
    }

    @Override
    public PaqueteModel actualizarPaquete(Integer idPaquete, PaqueteModel paquete) {
        Optional<PaqueteModel> paqueteExistenteOptional = paqueteRepositorio.findById(idPaquete);
        if (paqueteExistenteOptional.isPresent()) {
            PaqueteModel paqueteExistente = paqueteExistenteOptional.get();
            if (paqueteRepositorio.existsById(paquete.getIdProducto().getIdProducto())) {
                paqueteExistente.setCantidadProducto(paquete.getCantidadProducto());
                paqueteExistente.setTipoProducto(paquete.getTipoProducto());
                paqueteExistente.setIdProducto(paquete.getIdProducto());
                return paqueteRepositorio.save(paqueteExistente);
            } else {
                throw new RecursoNoEncontradoExcepcion("El producto asociado al paquete no existe.");
            }
        } else {
            throw new RecursoNoEncontradoExcepcion("Paquete con ID " + idPaquete + " no encontrado.");
        }
    }
}
