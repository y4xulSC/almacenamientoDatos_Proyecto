package com.proyectoBackend.Api.Servicio;

<<<<<<< Updated upstream
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.proyectoBackend.Api.Excepcion.RecursoNoEncontradoExcepcion;
import com.proyectoBackend.Api.Modelo.ProductoModel;
import com.proyectoBackend.Api.Repositorio.IDisenoRepositorio;
=======
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.proyectoBackend.Api.Modelo.ProductoModel;
>>>>>>> Stashed changes
import com.proyectoBackend.Api.Repositorio.IProductoRepositorio;

@Service
public class ProductoServicioImp implements IProductoServicio {
    @Autowired IProductoRepositorio productoRepositorio;
<<<<<<< Updated upstream
	@Autowired IDisenoRepositorio disenoRepositorio;

    @Override
    public String guardarProducto(ProductoModel producto) {
        productoRepositorio.save(producto);
        return "El producto con el ID " + producto.getIdProducto() + " fue creado con exito.";
    }

	public ProductoModel buscarProductoXid(int idProducto) {
		Optional<ProductoModel> productoEncontrado = productoRepositorio.findById(idProducto);
        return productoEncontrado.orElseThrow(() -> new RecursoNoEncontradoExcepcion("Producto no encontrado por el ID: " + idProducto + "."));
	}

	public List<ProductoModel> listarProductos() {
        return productoRepositorio.findAll();
    }

	public void eliminarProducto(int idProducto) {
        if (!productoRepositorio.existsById(idProducto)) {
            throw new RecursoNoEncontradoExcepcion("Producto no encontrado");
        } else {
            productoRepositorio.deleteById(idProducto);
        }
    }

    public ProductoModel actualizarProducto(Integer idProducto, ProductoModel producto) {
        // Verificar si el producto existe
        Optional<ProductoModel> productoOptional = productoRepositorio.findById(idProducto);
        if (productoOptional.isPresent()) {
            ProductoModel productoExistente = productoOptional.get();
            // Verificar si el diseño asociado al producto existe
            if (disenoRepositorio.existsById(producto.getIdDiseno().getIdDiseno())) {
                // Actualizar los atributos del producto
                productoExistente.setNombre(producto.getNombre());
                productoExistente.setPrecio(producto.getPrecio());
                productoExistente.setGenero(producto.getGenero());
                productoExistente.setTalla(producto.getTalla());
                productoExistente.setImagen(producto.getImagen());
                productoExistente.setDescripcion(producto.getDescripcion());
                productoExistente.setColor(producto.getColor());
                productoExistente.setCantidadStock(producto.getCantidadStock());
                productoExistente.setIdDiseno(producto.getIdDiseno());
                // Guardar el producto actualizado
                return productoRepositorio.save(productoExistente);
            } else {
                throw new RecursoNoEncontradoExcepcion("El diseño asociado al producto no existe");
            }
        } else {
            throw new RecursoNoEncontradoExcepcion("El producto no existe");
        }
    }
}
=======

    @Override
    public String guardarProducto(ProductoModel producto) {
        return null;
    }
}

>>>>>>> Stashed changes
