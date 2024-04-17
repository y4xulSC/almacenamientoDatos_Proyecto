package com.proyectoBackend.Api.Modelo;

import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table (name ="diseno")
@Data
@AllArgsConstructor
@NoArgsConstructor
@EnableJpaRepositories

public class DisenoModel {
<<<<<<< Updated upstream
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idDiseno;
    private String nombreDiseno;
    private String categoria;
}
=======
    
    @Id
    @GeneratedValue(strategy  = GenerationType.IDENTITY)
    private Integer idDiseno;
    private String nombreDiseno;
    private String categoria;
}
>>>>>>> Stashed changes
