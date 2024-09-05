package com.personal.employee.controller;

import java.util.List;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.servlet.ModelAndView;

import com.personal.employee.service.CodeManagerService;
import com.personal.employee.service.ProjectService;
import com.personal.employee.vo.CodeVO;
import com.personal.employee.vo.CustomerVO;
import com.personal.employee.vo.EmployeeVO;
import com.personal.employee.vo.ProjectVO;
import com.personal.employee.vo.SkillVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
public class ProjectController {

    @Autowired
    private ProjectService projectService;

    @Autowired
    private CodeManagerService codeManagerService;

    @RequestMapping("project")
    public ModelAndView employee(HttpServletRequest request) {
        ModelAndView model = new ModelAndView();
        HttpSession session = request.getSession();
        session.removeAttribute("emp_search");
        session.removeAttribute("emp_opt");

        List<CodeVO> code_list = codeManagerService.lodeCode();
        List<CodeVO> project_status_list = code_list.stream().filter(k -> k.getGroup_code().equals("PR01")).toList();
        List<CodeVO> skill_condision_list = code_list.stream().filter(k -> k.getGroup_code().equals("EM06")).toList();
        
        model.setViewName("project/index");
        model.addObject("project_status_list", project_status_list);
        model.addObject("skill_condision_list", skill_condision_list);
        
        model.setViewName("project/index");

        return model;
    }

    @RequestMapping("project_detail")
    public ModelAndView project_detail(@RequestParam("project_idx") String project_idx) {
        ModelAndView model = new ModelAndView();
        List<CodeVO> code_list = codeManagerService.lodeCode();
        ProjectVO prvo = projectService.project_detail_info(project_idx);
        prvo.setCodeName(code_list);
        
        List<SkillVO> skill_list = projectService.project_detail_skill(project_idx);
        for (SkillVO k : skill_list) {
            k.setCodeName(code_list);
        }
        model.addObject("prvo", prvo);
        model.addObject("skill_list", skill_list);
        model.setViewName("project/components/project_detail");
        return model;
    }

    @RequestMapping("project_insert_in")
    public ModelAndView pro_insert_in() {
        ModelAndView model = new ModelAndView();
        List<CodeVO> code_list = codeManagerService.lodeCode();

        List<CodeVO> project_status_list = code_list.stream().filter(k -> k.getGroup_code().equals("PR01")).toList();
        List<CodeVO> project_class_list = code_list.stream().filter(k -> k.getGroup_code().equals("PR02")).toList();
        List<CodeVO> skill_condision_list = code_list.stream().filter(k -> k.getGroup_code().equals("EM06")).toList();
        List<CodeVO> skill_list = code_list.stream().filter(k -> k.getGroup_code().equals("EX01")).toList();

        model.addObject("skill_list", skill_list);
        model.addObject("project_status_list", project_status_list);
        model.addObject("project_class_list", project_class_list);
        model.addObject("skill_condision_list", skill_condision_list);

        model.setViewName("project/components/project_insert");
        return model;
    }
    @RequestMapping("customer_search_pop_in")
    public ModelAndView customer_search_pop_in() {
        ModelAndView model = new ModelAndView();
        List<CodeVO> code_list = codeManagerService.lodeCode();

        List<CodeVO> division_list = code_list.stream().filter(k -> k.getGroup_code().equals("CU01")).toList();
        List<CodeVO> size_list = code_list.stream().filter(k -> k.getGroup_code().equals("CU02")).toList();
        List<CodeVO> business_list = code_list.stream().filter(k -> k.getGroup_code().equals("CU03")).toList();

        model.setViewName("project/components/customer_search_pop");
        model.addObject("division_list", division_list);
        model.addObject("size_list", size_list);
        model.addObject("business_list", business_list);
        return model;
    }

    @RequestMapping("customer_insert_pop_in")
    public ModelAndView customer_insert_pop_in() {
        ModelAndView model = new ModelAndView();
        List<CodeVO> code_list = codeManagerService.lodeCode();

        List<CodeVO> division_list = code_list.stream().filter(k -> k.getGroup_code().equals("CU01")).toList();
        List<CodeVO> size_list = code_list.stream().filter(k -> k.getGroup_code().equals("CU02")).toList();
        List<CodeVO> business_list = code_list.stream().filter(k -> k.getGroup_code().equals("CU03")).toList();

        model.setViewName("project/components/customer_insert_pop");
        model.addObject("division_list", division_list);
        model.addObject("size_list", size_list);
        model.addObject("business_list", business_list);
        return model;
    }

    @PostMapping("customer_insert_pop")
    public ModelAndView customer_insert_pop(@ModelAttribute CustomerVO customerVO) {
        ModelAndView model = new ModelAndView();
        customerVO.setMain_num(customerVO.getF_phone()+"-"+customerVO.getM_phone()+"-"+customerVO.getE_phone());
        projectService.customer_insert_pop(customerVO);
        model.setViewName("redirect:customer_search_pop_in");
        return model;
    }

    @RequestMapping("project_update_in")
    public ModelAndView project_update_in(@ModelAttribute("project_idx") String project_idx) {
        ModelAndView model = new ModelAndView();
        List<CodeVO> code_list = codeManagerService.lodeCode();

        ProjectVO prvo = projectService.project_detail_info(project_idx);
        prvo.setCodeName(code_list);
        
        List<SkillVO> project_skill_list = projectService.project_detail_skill(project_idx);
        List<String> project_skill_values = new ArrayList<>();
        for (SkillVO k : project_skill_list) {
            project_skill_values.add(k.getSkillCD());
        }
        List<CodeVO> project_status_list = code_list.stream().filter(k -> k.getGroup_code().equals("PR01")).toList();
        List<CodeVO> project_class_list = code_list.stream().filter(k -> k.getGroup_code().equals("PR02")).toList();
        List<CodeVO> skill_condision_list = code_list.stream().filter(k -> k.getGroup_code().equals("EM06")).toList();
        List<CodeVO> skill_list = code_list.stream().filter(k -> k.getGroup_code().equals("EX01")).toList();

        String[] cp_num =prvo.getCp_num().split("-");
        model.addObject("f_cp_phone", cp_num[0]);
        model.addObject("m_cp_phone", cp_num[1]);
        model.addObject("e_cp_phone", cp_num[2]);
        
        String[] pm_num =prvo.getRep_pm_phone().split("-");
        model.addObject("f_phone", pm_num[0]);
        model.addObject("m_phone", pm_num[1]);
        model.addObject("e_phone", pm_num[2]);
        
        model.addObject("project_status_list", project_status_list);
        model.addObject("project_class_list", project_class_list);
        model.addObject("skill_condision_list", skill_condision_list);
        model.addObject("skill_list", skill_list);

        model.addObject("prvo", prvo);
        model.addObject("project_skill_values", project_skill_values);
        model.setViewName("project/components/project_update");
        return model;
    }
}
