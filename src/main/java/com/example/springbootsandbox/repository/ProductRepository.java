package com.example.springbootsandbox.repository;

import com.example.springbootsandbox.model.Product;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface ProductRepository extends MongoRepository<Product, String> {
}
