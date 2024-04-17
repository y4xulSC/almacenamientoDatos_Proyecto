package com.proyectoBackend.Api.Servicio;

import com.proyectoBackend.Api.Excepcion.RecursoNoEncontradoExcepcion;
import com.proyectoBackend.Api.Modelo.ProductoPedidoModel;
import com.proyectoBackend.Api.Repositorio.IProductoPedidoRepositorio;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;


@Service
public class ProductoPedidoServicioImp implements IProductoPedidoServicio {

    @Autowired
    
    IProductoPedidoRepositorio productoPedidoRepositorio;

    @Override
    public String guardarProductoPedido(ProductoPedidoModel productoPedido) {
        productoPedidoRepositorio.save(productoPedido);
        return "El producto pedido con ID " + productoPedido.getIdPedido() + productoPedido.getIdProducto() + " fue creado con éxito";
    }

    @Override
public ProductoPedidoModel buscarProductoPedidoPorId(int idProductoPedido) {
    Optional<ProductoPedidoModel> productoPedidoOptional = productoPedidoRepositorio.findById(idProductoPedido);
    return productoPedidoOptional.orElseThrow(() -> new RecursoNoEncontradoExcepcion("Producto pedido con ID " + idProductoPedido + " no encontrado"));
}


    @Override
    public List<ProductoPedidoModel> listarProductosPedido() {
        return productoPedidoRepositorio.findAll();
    }

    @Override
    public void eliminarProductoPedido(int idProductoPedido) {
        if (!productoPedidoRepositorio.existsById(idProductoPedido)) {
            throw new RecursoNoEncontradoExcepcion("Producto pedido no encontrado");
        } else {
            productoPedidoRepositorio.deleteById(idProductoPedido);
        }
    }

    @Override
public ProductoPedidoModel actualizarProductoPedido(Integer idProductoPedido, ProductoPedidoModel productoPedido) {
    // Verificar si el producto pedido existe
    Optional<ProductoPedidoModel> productoPedidoOptional = productoPedidoRepositorio.findById(idProductoPedido);
    if (productoPedidoOptional.isPresent()) {
        ProductoPedidoModel productoPedidoExistente = productoPedidoOptional.get();
        // Actualizar los atributos del producto pedido
        productoPedidoExistente.setIdPedido(null);
        productoPedidoExistente.setIdProducto(productoPedido.getIdProducto());
        productoPedidoExistente.setCantidadProducto(productoPedido.getCantidadProducto());
        // Guardar el producto pedido actualizado
        return productoPedidoRepositorio.save(productoPedidoExistente);
    } else {
        throw new RecursoNoEncontradoExcepcion("El producto pedido no existe");
    }
}

}
