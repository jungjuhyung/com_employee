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

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.ArrayList;


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
        session.removeAttribute("pro_search");
        session.removeAttribute("pro_opt");

        List<CodeVO> code_list = codeManagerService.lodeCode();
        List<CodeVO> field_list = code_list.stream().filter(k -> k.getGroup_code().equals("EM05")).toList();
        List<CodeVO> class_list = code_list.stream().filter(k -> k.getGroup_code().equals("EM03")).toList();
        List<CodeVO> lebel_list = code_list.stream().filter(k -> k.getGroup_code().equals("EM06")).toList();
        List<CodeVO> employment_status_list = code_list.stream().filter(k -> k.getGroup_code().equals("EM04")).toList();
        
        model.setViewName("employee/index");
        model.addObject("field_list", field_list);
        model.addObject("class_list", class_list);
        model.addObject("lebel_list", lebel_list);
        model.addObject("employment_status_list", employment_status_list);
        return model;
    }

    @RequestMapping("emp_detail")
    public ModelAndView emp_detail(@RequestParam("emp_idx") String emp_idx) {
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
    @RequestMapping("emp_management_project")
    public ModelAndView emp_management_project(@ModelAttribute("emp_idx") String emp_idx) {
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
        model.setViewName("employee/components/emp_project");
        return model;
    }

    @RequestMapping("emp_insert_in")
    public ModelAndView emp_insert_in() {
        ModelAndView model = new ModelAndView();
        List<CodeVO> code_list = codeManagerService.lodeCode();

        List<CodeVO> field_list = code_list.stream().filter(k -> k.getGroup_code().equals("EM05")).toList();
        List<CodeVO> class_list = code_list.stream().filter(k -> k.getGroup_code().equals("EM03")).toList();
        List<CodeVO> lebel_list = code_list.stream().filter(k -> k.getGroup_code().equals("EM06")).toList();
        List<CodeVO> employment_status_list = code_list.stream().filter(k -> k.getGroup_code().equals("EM04")).toList();
        List<CodeVO> gender_list = code_list.stream().filter(k -> k.getGroup_code().equals("EM08")).toList();
        List<CodeVO> agreement_list = code_list.stream().filter(k -> k.getGroup_code().equals("EM02")).toList();
        List<CodeVO> e_email_list = code_list.stream().filter(k -> k.getGroup_code().equals("EX04")).toList();
        List<CodeVO> skill_list = code_list.stream().filter(k -> k.getGroup_code().equals("EX01")).toList();
        
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

    
    @RequestMapping("emp_update_in")
    public ModelAndView emp_update_in(@ModelAttribute("emp_idx") String emp_idx) {
        ModelAndView model = new ModelAndView();
        List<CodeVO> code_list = codeManagerService.lodeCode();

        EmployeeVO eivo = employeeService.employee_detail_info(emp_idx);
        eivo.setCodeName(code_list);
        
        List<SkillVO> emp_skill_list = employeeService.employee_detail_skill(emp_idx);
        List<String> emp_skill_values = new ArrayList<>();
        for (SkillVO k : emp_skill_list) {
            emp_skill_values.add(k.getSkillCD());
        }
        List<CodeVO> field_list = code_list.stream().filter(k -> k.getGroup_code().equals("EM05")).toList();
        List<CodeVO> class_list = code_list.stream().filter(k -> k.getGroup_code().equals("EM03")).toList();
        List<CodeVO> lebel_list = code_list.stream().filter(k -> k.getGroup_code().equals("EM06")).toList();
        List<CodeVO> employment_status_list = code_list.stream().filter(k -> k.getGroup_code().equals("EM04")).toList();
        List<CodeVO> gender_list = code_list.stream().filter(k -> k.getGroup_code().equals("EM08")).toList();
        List<CodeVO> agreement_list = code_list.stream().filter(k -> k.getGroup_code().equals("EM02")).toList();
        List<CodeVO> e_email_list = code_list.stream().filter(k -> k.getGroup_code().equals("EX04")).toList();
        List<CodeVO> skill_list = code_list.stream().filter(k -> k.getGroup_code().equals("EX01")).toList();

        String[] phone =eivo.getPhone().split("-");
        model.addObject("f_phone", phone[0]);
        model.addObject("m_phone", phone[1]);
        model.addObject("e_phone", phone[2]);
        
        model.addObject("field_list", field_list);
        model.addObject("class_list", class_list);
        model.addObject("lebel_list", lebel_list);
        model.addObject("employment_status_list", employment_status_list);
        model.addObject("gender_list", gender_list);
        model.addObject("agreement_list", agreement_list);
        model.addObject("e_email_list", e_email_list);
        model.addObject("skill_list", skill_list);

        model.addObject("eivo", eivo);
        model.addObject("emp_skill_values", emp_skill_values);
        model.setViewName("employee/components/emp_update");
        return model;
    }

    @RequestMapping("emp_project_search")
    public ModelAndView emp_project_search() {
        ModelAndView model = new ModelAndView();
        List<CodeVO> code_list = codeManagerService.lodeCode();
        List<CodeVO> project_status_list = code_list.stream().filter(k -> k.getGroup_code().equals("PR01")).toList();
        List<CodeVO> skill_condision_list = code_list.stream().filter(k -> k.getGroup_code().equals("EM06")).toList();
        model.setViewName("employee/components/emp_project_search");
        model.addObject("project_status_list", project_status_list);
        model.addObject("skill_condision_list", skill_condision_list);
        return model;
    }
}
