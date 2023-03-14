package com.co.backend_architecture;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

import static java.sql.DriverManager.println;


@ComponentScan(basePackages = {BackendArchitectureApplication.MAIN_APP})
@SpringBootApplication
public class BackendArchitectureApplication {

	public static final String MAIN_APP = "com.co.backend_architecture";
	public static void main(String[] args) {
		SpringApplication.run(BackendArchitectureApplication.class, args);
		println("Server started");
	}

}
