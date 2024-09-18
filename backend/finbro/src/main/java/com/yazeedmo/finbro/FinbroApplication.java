package com.yazeedmo.finbro;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.info.Info;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@OpenAPIDefinition(info = @Info(title = "FinBro API", version = "v1"))
@EnableScheduling
public class FinbroApplication {

	public static void main(String[] args) {
		SpringApplication.run(FinbroApplication.class, args);
	}

}
