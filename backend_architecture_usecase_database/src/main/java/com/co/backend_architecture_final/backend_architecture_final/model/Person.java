package com.co.backend_architecture_final.backend_architecture_final.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "person")
@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Person {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idPerson", nullable = false)
    private Integer idPerson;

    @Column
    private String name;

    @Column
    private String lastname;

    @Column
    private String email;

    @Column
    private Long phone;

    @Column
    private String address;

    @Column
    private Boolean confirmed;
}
