package com.co.backend_architecture.model;

import lombok.*;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Person {
    private Integer id;
    private String name;
    private String lastName;
    private String email;
    private Long phone;
    private String address;
    private Boolean confirmed;

}
