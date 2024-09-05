package com.personal.employee.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.personal.employee.mapper.EmployeeMapper;
import com.personal.employee.vo.EmpDetailVO;
import com.personal.employee.vo.EmpSearchVO;
import com.personal.employee.vo.EmployeeVO;
import com.personal.employee.vo.ProEmpCusVO;
import com.personal.employee.vo.ProSearchVO;
import com.personal.employee.vo.ProjectVO;
import com.personal.employee.vo.SkillVO;

import java.util.List;
import java.util.Map;

@Service
public class EmployeeService {
    @Autowired
    EmployeeMapper employeeMapper;

    public int employee_search_count(EmpSearchVO empSearchVO) {
        return employeeMapper.employee_search_count(empSearchVO);
    }
    public List<EmployeeVO> employee_search(EmpSearchVO empSearchVO) {
        return employeeMapper.employee_search(empSearchVO);
    }
    public EmployeeVO employee_detail_info(String emp_idx) {
        return employeeMapper.employee_detail_info(emp_idx);
    }
    public List<SkillVO> employee_detail_skill(String emp_idx) {
        return employeeMapper.employee_detail_skill(emp_idx);
    }
    public List<ProEmpCusVO> empProCus_list(EmpDetailVO empDetailVO) {
        return employeeMapper.empProCus_list(empDetailVO);
    }
    public int emp_insert(EmployeeVO employeeVO) {
        return employeeMapper.emp_insert(employeeVO);
    }
    public int emp_insert_skill(Map<String, Object> map) {
        return employeeMapper.emp_insert_skill(map);
    }
    public int emp_update(EmployeeVO employeeVO) {
        return employeeMapper.emp_update(employeeVO);
    }

    public int skill_real_delete(String emp_idx) {
        employeeMapper.skill_real_delete(emp_idx);
        return 1;
    }

    @Transactional
    public int emp_update_skill(Map<String, Object> map) {
        employeeMapper.skill_real_delete(map.get("emp_idx").toString());
        employeeMapper.emp_insert_skill(map);
        return 1;
    }

    @Transactional
    public int emp_delete(List<String> delete_emp_list) {
        employeeMapper.emp_delete(delete_emp_list);
        employeeMapper.skill_delete(delete_emp_list);
        employeeMapper.empPro_delete(delete_emp_list);
        return delete_emp_list.size();
    }
    
    public int management_project_delete(List<String> delete_pe_list) {
        return employeeMapper.management_project_delete(delete_pe_list);
    }
    public int management_project_update(ProEmpCusVO update_vo) {
        return employeeMapper.management_project_update(update_vo);
    }
    public int management_project_insert(ProEmpCusVO insert_vo) {
        return employeeMapper.management_project_insert(insert_vo);
    }

    public int project_pop_search_count(ProSearchVO proSearchVO, List<String> in_project_list) {
        return employeeMapper.project_pop_search_count(proSearchVO, in_project_list);
    }
    public List<ProjectVO> project_pop_search(ProSearchVO proSearchVO, List<String> in_project_list) {
        return employeeMapper.project_pop_search(proSearchVO, in_project_list);
    }
    public List<String> in_project_list(String emp_idx) {
        return employeeMapper.in_project_list(emp_idx);
    }
}
