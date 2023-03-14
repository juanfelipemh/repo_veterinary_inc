package com.co.backend_architecture.controller;

import com.co.backend_architecture.model.Person;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.*;

@RestController
@RequestMapping(path = "/person")

public class PersonController {

    static List<Person> listPerson = new ArrayList<Person>();

    @ResponseBody
    @GetMapping("/")
    public ResponseEntity<String> getAllPersons() {
        List<Person> person = listPerson;
        if(person.isEmpty()){
            return ResponseEntity.ok("There are not people information");
        } else {
            return ResponseEntity.ok("Showing people information");
        }
    }

    @ResponseBody
    @GetMapping(value = "/{personId}", produces = {MediaType.APPLICATION_JSON_VALUE})
    public ResponseEntity<String> getPersonById(@NotNull @Valid @PathVariable Integer personId) {
        boolean existe = false;
        for (Person dataPerson : listPerson) {
            if (dataPerson.getId() == personId) {
                existe = true;
                break;
            }
        }
        if(!existe){
            return ResponseEntity.ok("person not found");
        } else {
            return ResponseEntity.ok("person found");
        }
    }

    @ResponseBody
    @PostMapping(value = "/")
    public ResponseEntity<String> createPerson(@NotNull @Valid @RequestBody Person person){
        for(Person dataPerson : listPerson){
            if (person.getId() == dataPerson.getId() ) {
                return ResponseEntity.ok("Person has not been created");
            }
        }
        listPerson.add(person);
        return ResponseEntity.ok("Person has been successfully created");
    }

    @ResponseBody
    @PutMapping(value = "/{personId}", consumes = {MediaType.APPLICATION_JSON_VALUE})
    public ResponseEntity<String> updatePerson(@NotNull @Valid @PathVariable Integer personId, @RequestBody Person person) {
        boolean existe = false;
        Person updatePerson = new Person();
        for (Person dataPerson : listPerson) {
            if (dataPerson.getId() == personId) {
                existe = true;
                updatePerson.setId(personId);
                updatePerson.setName(person.getName());
                updatePerson.setLastName(person.getLastName());
                updatePerson.setEmail(person.getEmail());
                updatePerson.setAddress(person.getAddress());
                updatePerson.setPhone(person.getPhone());
                updatePerson.setConfirmed(person.getConfirmed());
                listPerson.set(listPerson.lastIndexOf(dataPerson), updatePerson);
                break;
            }
        }
        if(!existe){
            return ResponseEntity.ok("person not found");
        } else {
            return ResponseEntity.ok("person has been updated");
        }
    }

    @ResponseBody
    @PatchMapping(path = "/{personId}/{confirmed}", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<String> updateStateConfirmed(@PathVariable Integer personId, @PathVariable Boolean confirmed) {
        boolean existe = false;
        for (Person dataPerson : listPerson) {
            if (dataPerson.getId() == personId) {
                existe = true;
                dataPerson.setConfirmed(confirmed);
                listPerson.set(listPerson.indexOf(dataPerson), dataPerson);
                break;
            }
        }
        if(!existe){
            return ResponseEntity.ok("person not found");
        } else {
            return ResponseEntity.ok("person is confirmed");
        }
    }

    @ResponseBody
    @DeleteMapping(value = "/{personId}", produces = {MediaType.APPLICATION_JSON_VALUE})
    public ResponseEntity<String> deletePerson(@NotNull @Valid @PathVariable Integer personId) {
        boolean existe = false;
        Iterator<Person> iterPerson = listPerson.iterator();
        while (iterPerson.hasNext()){
            Person person = iterPerson.next();
                if (person.getId() == personId) {
                    existe = true;
                    iterPerson.remove();
                    break;
            }
        }
        if(!existe){
            return ResponseEntity.ok("person not found");
        } else {
            return ResponseEntity.ok("person has been deleted");
        }
    }
}
