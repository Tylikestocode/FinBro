package com.finbro.FinBroJavaSpring;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.info.Info;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@OpenAPIDefinition(info = @Info(title = "FinBro API", version = "v1"))
public class FinBroJavaSpringApplication {

	public static void main(String[] args) {
		SpringApplication.run(FinBroJavaSpringApplication.class, args);
	}

}
