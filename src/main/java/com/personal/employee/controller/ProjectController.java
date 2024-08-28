package com.personal.employee.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.servlet.ModelAndView;

import com.personal.employee.service.CodeManagerService;
import com.personal.employee.service.EmployeeService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class ProjectController {

    @Autowired
    EmployeeService employeeService;

    @Autowired
    CodeManagerService codeManagerService;

    @RequestMapping("project")
    public ModelAndView employee(HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.removeAttribute("emp_search");
        session.removeAttribute("emp_opt");
        ModelAndView model = new ModelAndView();
        model.setViewName("project/index");

        return model;
    }
}
