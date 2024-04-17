package com.proyectoBackend.Api.Servicio;

import com.proyectoBackend.Api.Modelo.DetalleEnvioModel;
import com.proyectoBackend.Api.Excepcion.RecursoNoEncontradoExcepcion;
import com.proyectoBackend.Api.Repositorio.IDetalleEnvioRepositorio;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class DetalleEnvioServicioImp implements IDetalleEnvioServicio {

    @Autowired
    IDetalleEnvioRepositorio detalleEnvioRepositorio;

    @Override
    public String guardarDetalleEnvio(DetalleEnvioModel detalleEnvio) {
        detalleEnvioRepositorio.save(detalleEnvio);
        return "Se ha creado el detalle de envío correctamente.";
    }

    @Override
    public DetalleEnvioModel buscarDetalleEnvioPorId(int idDetalleEnvio) {
        Optional<DetalleEnvioModel> detalleEnvioOptional = detalleEnvioRepositorio.findById(idDetalleEnvio);
        return detalleEnvioOptional.orElseThrow(() -> new RecursoNoEncontradoExcepcion("Detalle de envío no encontrado"));
    }

    @Override
    public List<DetalleEnvioModel> listarDetallesEnvio() {
        return detalleEnvioRepositorio.findAll();
    }

    @Override
    public void eliminarDetalleEnvio(int idDetalleEnvio) {
        if (!detalleEnvioRepositorio.existsById(idDetalleEnvio)) {
            throw new RecursoNoEncontradoExcepcion("Detalle de envío no encontrado");
        } else {
            detalleEnvioRepositorio.deleteById(idDetalleEnvio);
        }
    }

    @Override
    public DetalleEnvioModel actualizarDetalleEnvio(Integer idDetalleEnvio, DetalleEnvioModel detalleEnvio) {
        Optional<DetalleEnvioModel> detalleEnvioExistenteOptional = detalleEnvioRepositorio.findById(idDetalleEnvio);
        if (detalleEnvioExistenteOptional.isPresent()) {
            DetalleEnvioModel detalleEnvioExistente = detalleEnvioExistenteOptional.get();
            // Actualizar los atributos del detalle de envío
            detalleEnvioExistente.setBarrio(detalleEnvio.getBarrio());
            detalleEnvioExistente.setDireccion(detalleEnvio.getDireccion());
            detalleEnvioExistente.setNumero(detalleEnvio.getNumero());
            detalleEnvioExistente.setInfoExtra(detalleEnvio.getInfoExtra());
            detalleEnvioExistente.setPais(detalleEnvio.getPais());
            // Guardar el detalle de envío actualizado
            return detalleEnvioRepositorio.save(detalleEnvioExistente);
        } else {
            throw new RecursoNoEncontradoExcepcion("Detalle de envío no encontrado");
        }
    }
}


