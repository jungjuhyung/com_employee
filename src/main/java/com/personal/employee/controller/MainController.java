package com.personal.employee.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class MainController {

    @RequestMapping("/")
    public ModelAndView employee(HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.removeAttribute("emp_search");
        session.removeAttribute("emp_opt");
        ModelAndView model = new ModelAndView();
        model.setViewName("main/index");
        return model;
    }
}
