package com.ProjectOnlineShop.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.Enum.Sexo;
import com.ProjectOnlineShop.Model.UsuarioModel;

@Repository
public interface IUsuarioRepository extends JpaRepository<UsuarioModel, Integer> {

    boolean existsByNombreUsuarioOrEmail(String nombreUsuario, String email);

    boolean existsBySexo(Sexo sexo); 
}