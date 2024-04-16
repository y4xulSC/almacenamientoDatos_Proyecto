package com.proyectoBackend.Api.Controlador;

import java.util.List;

import com.proyectoBackend.Api.Excepcion.RecursoNoEncontradoExcepcion;
import com.proyectoBackend.Api.Modelo.PedidoModel;
import com.proyectoBackend.Api.Servicio.IPedidoServicio;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/proyecto/pedido")
public class PedidoControlador {

    @Autowired
    IPedidoServicio pedidoServicio;

    @PostMapping("/crear")
    public ResponseEntity<String> crearPedido(@RequestBody PedidoModel pedido) {
        pedidoServicio.guardarPedido(pedido);
        return new ResponseEntity<String>("El pedido con el ID " + pedido.getIdPedido() + " fue creado con éxito.",
                HttpStatus.OK);
    }

    @GetMapping("/{idPedido}")
    public ResponseEntity<?> buscarPedidoPorId(@PathVariable int idPedido) {
        try {
            PedidoModel pedido = pedidoServicio.buscarPedidoPorId(idPedido);
            return ResponseEntity.ok(pedido);
        } catch (RecursoNoEncontradoExcepcion e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }

    @GetMapping("/")
    public ResponseEntity<List<PedidoModel>> listarPedidos() {
        List<PedidoModel> pedidos = pedidoServicio.listarPedidos();
        return new ResponseEntity<List<PedidoModel>>(pedidos, HttpStatus.OK);
    }

    @DeleteMapping("/{idPedido}")
    public ResponseEntity<?> eliminarPedido(@PathVariable int idPedido) {
        try {
            pedidoServicio.eliminarPedido(idPedido);
            return ResponseEntity.ok("Pedido con el ID " + idPedido + " fue eliminado con éxito.");
        } catch (RecursoNoEncontradoExcepcion e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }

    @PutMapping("/{idPedido}")
    public ResponseEntity<?> actualizarPedido(@PathVariable Integer idPedido, @RequestBody PedidoModel pedido) {
        try {
            PedidoModel pedidoActualizado = pedidoServicio.actualizarPedido(idPedido, pedido);
            return ResponseEntity.ok(pedidoActualizado);
        } catch (RecursoNoEncontradoExcepcion e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }
}

