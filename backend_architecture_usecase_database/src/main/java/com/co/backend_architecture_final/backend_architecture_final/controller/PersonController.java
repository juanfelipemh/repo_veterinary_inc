package com.co.backend_architecture_final.backend_architecture_final.controller;

import com.co.backend_architecture_final.backend_architecture_final.service.PersonService;
import com.co.backend_architecture_final.backend_architecture_final.model.Person;
import com.co.backend_architecture_final.backend_architecture_final.usecase.PersonUseCase;
import org.jetbrains.annotations.NotNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

@RestController
@RequestMapping(path = "/person")
public class PersonController {

    @Autowired
    private PersonService personService;

    public PersonController(PersonService personService){
        this.personService = personService;
    }

    @GetMapping("/list")
    public ResponseEntity<List<Person>> list(){
        List<Person> list = personService.list();
        return new ResponseEntity<>(list, HttpStatus.OK);
    }

    @PostMapping(value = "/", produces = MediaType.APPLICATION_JSON_VALUE, consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Person> addPerson(@NotNull @RequestBody Person person){
        PersonUseCase validate = new PersonUseCase();
        if(!validate.validateNewPerson(person)){
            return new ResponseEntity<>(HttpStatus.CONFLICT);
        } else {
            person = personService.addPerson(person);
        }
        return new ResponseEntity<>(person, HttpStatus.OK);
    }

    @GetMapping("/cost")
    public ResponseEntity<?> getCalculateCost(){
        List<?> cost = personService.getCalculateCost();
        return new ResponseEntity<>(cost, HttpStatus.OK);
    }

    @GetMapping("/fecha/{date}")
    public ResponseEntity<?> costPerDate(@PathVariable LocalDate date){
        List<?> cost = personService.costPerDate(date);
        return new ResponseEntity<>(cost, HttpStatus.OK);
    }

    @GetMapping("/service")
    public ResponseEntity<?> serviceDetails(){
        List<?> services = personService.serviceDetails();
        return new ResponseEntity<>(services, HttpStatus.OK);
    }
}
