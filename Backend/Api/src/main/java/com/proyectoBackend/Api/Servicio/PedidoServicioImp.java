package com.proyectoBackend.Api.Servicio;

import com.proyectoBackend.Api.Excepcion.RecursoNoEncontradoExcepcion;
import com.proyectoBackend.Api.Modelo.PedidoModel;
import com.proyectoBackend.Api.Modelo.UsuarioModel;
import com.proyectoBackend.Api.Repositorio.IPedidoRepositorio;
import com.proyectoBackend.Api.Repositorio.IUsuarioRepositorio;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class PedidoServicioImp implements IPedidoServicio {

    @Autowired
    IPedidoRepositorio pedidoRepositorio;

    @Autowired
    IUsuarioRepositorio usuarioRepositorio;

    @Override
    public String guardarPedido(PedidoModel pedido) {
        pedidoRepositorio.save(pedido);
        return "El pedido con el ID " + pedido.getIdPedido() + " fue creado con éxito.";
    }

    @Override
    public PedidoModel buscarPedidoPorId(int idPedido) {
        Optional<PedidoModel> pedidoOptional = pedidoRepositorio.findById(idPedido);
        return pedidoOptional.orElseThrow(() -> new RecursoNoEncontradoExcepcion("Pedido con ID " + idPedido + " no encontrado"));
    }

    @Override
    public List<PedidoModel> listarPedidos() {
        return pedidoRepositorio.findAll();
    }

    @Override
    public void eliminarPedido(int idPedido) {
        if (pedidoRepositorio.existsById(idPedido)) {
            pedidoRepositorio.deleteById(idPedido);
        } else {
            throw new RecursoNoEncontradoExcepcion("Pedido con ID " + idPedido + " no encontrado");
        }
    }

    @Override
public PedidoModel actualizarPedido(Integer idPedido, PedidoModel pedido) {
    // Verificar si el pedido existe
    Optional<PedidoModel> pedidoOptional = pedidoRepositorio.findById(idPedido);
    if (pedidoOptional.isPresent()) {
        PedidoModel pedidoExistente = pedidoOptional.get();
        
        // Verificar si el usuario asociado al pedido existe
        Optional<UsuarioModel> usuarioOptional = usuarioRepositorio.findById(pedido.getIdUsuario().getIdUsuario());
        if (usuarioOptional.isPresent()) {
            // Actualizar los atributos del pedido
            pedidoExistente.setFechaHoraPedido(pedido.getFechaHoraPedido());
            pedidoExistente.setEstado(pedido.getEstado());
            pedidoExistente.setTotal(pedido.getTotal());
            pedidoExistente.setIdUsuario(usuarioOptional.get()); // Asignar el usuario existente
            // Guardar el pedido actualizado
            return pedidoRepositorio.save(pedidoExistente);
        } else {
            throw new RecursoNoEncontradoExcepcion("El usuario asociado al pedido no existe.");
        }
    } else {
        throw new RecursoNoEncontradoExcepcion("Pedido con ID " + idPedido + " no encontrado.");
    }
}

}