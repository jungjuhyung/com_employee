package com.personal.employee.controller;

import org.springframework.web.bind.annotation.RestController;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;

@RestController
public class ProjectRestController {
    


    @PostMapping("")
    public ResponseEntity<?> search() {
        
        return ResponseEntity.ok(0);
    }
}
