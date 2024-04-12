package com.ProjectOnlineShop.Controller;


import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import com.Enum.Sexo;
import com.Exception.ExistNombreUsuario;
import com.Exception.NoEncontradoException;
import com.Exception.SexoInvalidoException;
import com.ProjectOnlineShop.Model.UsuarioModel;
import com.ProjectOnlineShop.Service.IUsuarioService;



@RestController
@RequestMapping("/api/usuarios")
public class UsuarioController {

    @Autowired
    IUsuarioService usuarioService;

    @PostMapping("/")
    public ResponseEntity<?> crearUsuario(@RequestBody UsuarioModel usuario) {
        try {
            // Verificar si ya existe un usuario con el mismo nombre de usuario o correo electrónico
            if (usuarioService.existsByNombreUsuarioOrEmail(usuario.getNombreUsuario(), usuario.getEmail())) {
                throw new ExistNombreUsuario("El nombre de usuario '" + usuario.getNombreUsuario() + "' o el correo electrónico '" + usuario.getEmail() + "' ya están en uso");
            }
            if(!(usuario.getSexo().equals(Sexo.HOMBRE) || usuario.getSexo().equals(Sexo.MUJER))) {
                throw new SexoInvalidoException("El sexo ingresado es inválido");
            }

            usuarioService.guardarUsuario(usuario);
            return ResponseEntity.ok("Usuario con ID " + usuario.getIdUsuario() + " fue creado correctamente");
        } catch (ExistNombreUsuario e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        } catch(SexoInvalidoException s){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(s.getMessage());
        }
    }

    @GetMapping("/{idUsuario}")
    public ResponseEntity<?> buscarUsuarioPorId(@PathVariable int idUsuario) {
        try {
            UsuarioModel usuario = usuarioService.buscarUsuarioPorId(idUsuario);
            return ResponseEntity.ok(usuario);
        } catch (NoEncontradoException e) {
            String mensajeError = e.getMessage();
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(mensajeError);
        }
    }

    @GetMapping("/")
    public ResponseEntity<List<UsuarioModel>> listarUsuarios() {
        List<UsuarioModel> usuarios = usuarioService.listarUsuarios();
        return ResponseEntity.ok(usuarios);
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> actualizarUsuario(@PathVariable Integer id, @RequestBody UsuarioModel usuario) {
        try {
            UsuarioModel usuarioActualizado = usuarioService.actualizarUsuario(id, usuario);
            return ResponseEntity.ok(usuarioActualizado);
        } catch (NoEncontradoException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        } catch (ExistNombreUsuario e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }
}
