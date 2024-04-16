package com.proyectoBackend.Api.Servicio;

import java.util.List;

import com.proyectoBackend.Api.Modelo.PromocionesModel;

public interface IPromocionesServicio {

    String guardarPromocion(PromocionesModel promocion);

    PromocionesModel buscarPromocionPorId(int idPromocion);

    List<PromocionesModel> listarPromociones();

    void eliminarPromocion(int idPromocion);

    PromocionesModel actualizarPromocion(Integer idPromocion, PromocionesModel promocion);
}