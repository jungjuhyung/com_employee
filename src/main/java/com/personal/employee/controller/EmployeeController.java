package com.personal.employee.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.servlet.ModelAndView;

import com.personal.employee.service.CodeManagerService;
import com.personal.employee.service.EmployeeService;
import com.personal.employee.vo.CodeVO;
import com.personal.employee.vo.EmployeeVO;
import com.personal.employee.vo.SkillVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;


@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    @Autowired
    CodeManagerService codeManagerService;

    @RequestMapping("employee")
    public ModelAndView employee(HttpServletRequest request) {
        ModelAndView model = new ModelAndView();
        HttpSession session = request.getSession();
        List<CodeVO> group_codes = codeManagerService.lodeCode();
        List<CodeVO> field_list = group_codes.stream().filter(k -> k.getGroup_code().equals("EM05")).toList();
        List<CodeVO> class_list = group_codes.stream().filter(k -> k.getGroup_code().equals("EM03")).toList();
        List<CodeVO> lebel_list = group_codes.stream().filter(k -> k.getGroup_code().equals("EM06")).toList();
        List<CodeVO> employment_status_list = group_codes.stream().filter(k -> k.getGroup_code().equals("EM04")).toList();
        model.setViewName("employee/index");
        model.addObject("field_list", field_list);
        model.addObject("class_list", class_list);
        model.addObject("lebel_list", lebel_list);
        model.addObject("employment_status_list", employment_status_list);
        return model;
    }

    @RequestMapping("emp_detail")
    public ModelAndView emp_detail(@RequestParam("param") String emp_idx) {
        ModelAndView model = new ModelAndView();
        List<CodeVO> code_list = codeManagerService.lodeCode();
        EmployeeVO eivo = employeeService.employee_detail_info(emp_idx);
        eivo.setCodeName(code_list);
        
        List<SkillVO> skill_list = employeeService.employee_detail_skill(emp_idx);
        for (SkillVO k : skill_list) {
            k.setCodeName(code_list);
        }

        model.addObject("eivo", eivo);
        model.addObject("skill_list", skill_list);
        model.setViewName("employee/components/emp_detail");
        return model;
    }

    @RequestMapping("emp_insert")
    public ModelAndView emp_insert() {
        ModelAndView model = new ModelAndView();
        List<CodeVO> group_codes = codeManagerService.lodeCode();

        List<CodeVO> field_list = group_codes.stream().filter(k -> k.getGroup_code().equals("EM05")).toList();
        List<CodeVO> class_list = group_codes.stream().filter(k -> k.getGroup_code().equals("EM03")).toList();
        List<CodeVO> lebel_list = group_codes.stream().filter(k -> k.getGroup_code().equals("EM06")).toList();
        List<CodeVO> employment_status_list = group_codes.stream().filter(k -> k.getGroup_code().equals("EM04")).toList();
        List<CodeVO> gender_list = group_codes.stream().filter(k -> k.getGroup_code().equals("EM08")).toList();
        List<CodeVO> agreement_list = group_codes.stream().filter(k -> k.getGroup_code().equals("EM02")).toList();
        List<CodeVO> e_email_list = group_codes.stream().filter(k -> k.getGroup_code().equals("EX04")).toList();
        List<CodeVO> skill_list = group_codes.stream().filter(k -> k.getGroup_code().equals("EX01")).toList();
        
        model.addObject("field_list", field_list);
        model.addObject("class_list", class_list);
        model.addObject("lebel_list", lebel_list);
        model.addObject("employment_status_list", employment_status_list);
        model.addObject("gender_list", gender_list);
        model.addObject("agreement_list", agreement_list);
        model.addObject("e_email_list", e_email_list);
        model.addObject("skill_list", skill_list);
        
        model.setViewName("employee/components/emp_insert");
        return model;
    }
}
