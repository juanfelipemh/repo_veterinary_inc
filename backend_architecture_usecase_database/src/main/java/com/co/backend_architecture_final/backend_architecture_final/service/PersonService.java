package com.co.backend_architecture_final.backend_architecture_final.service;

import com.co.backend_architecture_final.backend_architecture_final.model.Person;
import com.co.backend_architecture_final.backend_architecture_final.repository.PersonRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

@Service
public class PersonService {

    @Autowired
    private PersonRepository personRepository;

    public PersonService(PersonRepository personRepository){
        this.personRepository = personRepository;
    }

    public List<Person> list(){
        return personRepository.getPersonInformation();
    }

    public Person addPerson(Person person){
        return personRepository.addPerson(person.getAddress(),person.getConfirmed(),person.getEmail(),person.getLastname(),person.getName(),person.getPhone());
    }

    public List<?> getCalculateCost(){
        return personRepository.getCalculateTotalCost();
    }

    public List<?> costPerDate(LocalDate date){
        return personRepository.costPerDate(date);
    }

    public List<?> serviceDetails(){
        return personRepository.serviceDetails();
    }

}
