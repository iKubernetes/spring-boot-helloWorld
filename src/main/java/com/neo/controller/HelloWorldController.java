package com.neo.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloWorldController {

    @RequestMapping("/")
    public String index() {
        return "Hello Spring Boot 2.0!";
    }
	
    @RequestMapping("/hello")
    public String hello(Locale locale, Model model) {
        return "Hello World";
    }
}
