package com.co.backend_architecture_final.backend_architecture_final.repository;

import com.co.backend_architecture_final.backend_architecture_final.model.Person;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

@Repository
public interface PersonRepository extends JpaRepository<Person, Integer> {

    @Query(value = "{call getPersonInformation()}", nativeQuery = true)
    List<Person> getPersonInformation();

    @Query(value = "{call addPerson(:address, :confirmed, :email, :lastname, :name, :phone)}", nativeQuery = true)
    Person addPerson(
            @Param("address")String address,
            @Param("confirmed")Boolean confirmed,
            @Param("email")String email,
            @Param("lastname")String lastname,
            @Param("name")String name,
            @Param("phone")Long phone
    );

    @Query(value = "{call calculateAllTotalCosts()}", nativeQuery = true)
    List<?> getCalculateTotalCost();

    @Query(value = "{call costsPerDate(:date)}", nativeQuery = true)
    List<?> costPerDate(
            @Param("date") LocalDate date
            );

    @Query(value = "{call serviceDetails()}", nativeQuery = true)
    List<?> serviceDetails();
}
