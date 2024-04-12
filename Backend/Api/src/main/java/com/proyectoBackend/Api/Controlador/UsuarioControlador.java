package com.proyectoBackend.Api.Controlador;

//import java.util.List;

//import org.hibernate.mapping.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.DeleteMapping;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

//import com.proyectoBackend.Api.Excepcion.RecursoNoEncontradoExcepcion;
import com.proyectoBackend.Api.Modelo.UsuarioModel;
import com.proyectoBackend.Api.Servicio.IUsuarioServicio;

@RestController
@RequestMapping ("/proyecto/usuarios")

public class UsuarioControlador {
    @Autowired
    IUsuarioServicio usuarioServicio;
    @PostMapping("/crear")
    public ResponseEntity<String> crearUsuario(@RequestBody UsuarioModel usuario) {
        usuarioServicio.guardarUsuario(usuario);
        return new ResponseEntity<String>(usuarioServicio.guardarUsuario(usuario), HttpStatus.OK);
        /*try {
            Integer idUsuario = usuario.getIdUsuario();
            UsuarioModel qUsuario = usuarioService.buscarUsuarioPorId(idUsuario);
            if (qUsuario != null) {
                System.out.println("Encontrado123");
                throw new RecursoNoEncontradoException("El ID " + usuario + " ya se encuentra en uso");
            } else {
                System.out.println("Encontrado");
                usuarioService.guardarUsuario(usuario);
                return new ResponseEntity<String>(usuarioService.guardarUsuario(usuario), HttpStatus.OK);
            }
        } catch (RecursoNoEncontradoException e) {
            //return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
            System.out.println("123");
            usuarioService.guardarUsuario(usuario);
            return new ResponseEntity<String>(usuarioService.guardarUsuario(usuario), HttpStatus.OK);
        }*/
    }
}
