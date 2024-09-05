package com.personal.employee.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.personal.employee.service.CodeManagerService;
import com.personal.employee.service.EmployeeService;
import com.personal.employee.vo.ProEmpCusVO;

@Controller
public class CommonController {

    @Autowired
    EmployeeService employeeService;

    @Autowired
    CodeManagerService codeManagerService;
   
    @RequestMapping("project_emp_info")
    public ModelAndView project_emp_info(@RequestBody ProEmpCusVO proEmpCusVO) {
        ModelAndView model = new ModelAndView();
        // List<CodeVO> code_list = codeManagerService.lodeCode();
        // List<CodeVO> role_list = code_list.stream().filter(k -> k.getGroup_code().equals("EM07")).toList();
        // List<CodeVO> score_list = code_list.stream().filter(k -> k.getGroup_code().equals("EX02")).toList();

        return model;
    }
}
