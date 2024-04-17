package com.proyectoBackend.Api.Servicio;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.proyectoBackend.Api.Excepcion.RecursoNoEncontradoExcepcion;
import com.proyectoBackend.Api.Excepcion.RecursoYaExistente;
import com.proyectoBackend.Api.Modelo.ProductoModel;
import com.proyectoBackend.Api.Modelo.PromocionesModel;
import com.proyectoBackend.Api.Repositorio.IProductoRepositorio;


@Service
public class PromocionesServicioImp  implements IPromocionesServicio {
    @Autowired IPromocionesRepositorio promocionesRepositorio;
    @Autowired IProductoRepositorio productoRepositorio;

    @Override
public String guardarPromocion(PromocionesModel promocion) {
    ProductoModel idProducto = promocion.getIdProducto(); // Obtener el objeto ProductoModel
    LocalDate fechaInicio = promocion.getFechaInicio();
    LocalDate fechaFin = promocion.getFechaFin();

    boolean existePromocion = promocionesRepositorio.existsByProductoAndFechaInicioBeforeAndFechaFinAfter(idProducto, fechaInicio, fechaFin);

    if (existePromocion) {
        throw new RecursoYaExistente("Ya existe una promoción para el producto con ID " + idProducto.getIdProducto() + " en la misma fecha");
    } else {
        promocionesRepositorio.save(promocion);
        return "Fue aplicada la promoción " + promocion.getDescuento() + " al producto con ID " + idProducto.getIdProducto() + ".";
    }
}

    public PromocionesModel buscarPromocionPorId(int idPromocion) {
        Optional<PromocionesModel> promocionEncontrada = promocionesRepositorio.findById(idPromocion);
        return promocionEncontrada.orElseThrow(() -> new RecursoNoEncontradoExcepcion("No se encontro la promocion por el id " + idPromocion));
    }

    public List<PromocionesModel> listarPromociones() {
        return promocionesRepositorio.findAll();
    }

    public void eliminarPromocion(int idPromocion) {
        if (!promocionesRepositorio.existsById(idPromocion)) {
            throw new RecursoNoEncontradoExcepcion("La promocion con ID " + idPromocion + " no encontrado");
        } else {
            promocionesRepositorio.deleteById(idPromocion);
        }
    }

    public PromocionesModel actualizarPromocion(Integer idPromocion, PromocionesModel promocion) {
        // Verificar si la promoción existe
        Optional<PromocionesModel> promocionOptional = promocionesRepositorio.findById(idPromocion);
        if (promocionOptional.isPresent()) {
            PromocionesModel promocionExistente = promocionOptional.get();
            // Verificar si el producto asociado a la promoción existe
            if (productoRepositorio.existsById(promocion.getIdProducto().getIdProducto())) {
                // Actualizar los atributos de la promoción
                promocionExistente.setIdProducto(promocion.getIdProducto());
                promocionExistente.setFechaInicio(promocion.getFechaInicio());
                promocionExistente.setHoraInicio(promocion.getHoraInicio());
                promocionExistente.setFechaFin(promocion.getFechaFin());
                promocionExistente.setHoraFin(promocion.getHoraFin());
                promocionExistente.setDescuento(promocion.getDescuento());
                // Guardar la promoción actualizada
                return promocionesRepositorio.save(promocionExistente);
            } else {
                throw new RecursoNoEncontradoExcepcion("El producto asociado a la promoción no existe");
            }
        } else {
            throw new RecursoNoEncontradoExcepcion("La promoción no existe");
        }
    }
}
