package com.proyectoBackend.Api.Servicio;

import com.proyectoBackend.Api.Modelo.DetalleEnvioModel;
import java.util.List;

public interface IDetalleEnvioServicio {

    String guardarDetalleEnvio(DetalleEnvioModel detalleEnvio);

    DetalleEnvioModel buscarDetalleEnvioPorId(int idDetalleEnvio);

    List<DetalleEnvioModel> listarDetallesEnvio();

    void eliminarDetalleEnvio(int idDetalleEnvio);

    DetalleEnvioModel actualizarDetalleEnvio(Integer idDetalleEnvio, DetalleEnvioModel detalleEnvio);
}
