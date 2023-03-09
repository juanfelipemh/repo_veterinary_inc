package com.co.backend_architecture_final.backend_architecture_final.usecase;

import com.co.backend_architecture_final.backend_architecture_final.model.Person;

public class PersonUseCase {
    public Boolean validateNewPerson(Person person){
        if(person.getName() == null ||
                person.getLastname() == null ||
                person.getEmail() == null ||
                person.getAddress() == null ||
                person.getPhone() == null ||
                person.getConfirmed() == true){
            return false;
        }
        return true;
    }
}
