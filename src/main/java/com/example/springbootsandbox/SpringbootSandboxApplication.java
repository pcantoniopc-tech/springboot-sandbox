package com.example.springbootsandbox;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.mongodb.repository.config.EnableMongoRepositories;

@SpringBootApplication
@EnableMongoRepositories
public class SpringbootSandboxApplication {
	public static void main(String[] args) {
		SpringApplication.run(SpringbootSandboxApplication.class, args);
	}
}
