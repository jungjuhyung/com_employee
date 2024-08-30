package com.personal.employee.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.personal.employee.mapper.EmployeeMapper;
import com.personal.employee.vo.EmpSearchVO;
import com.personal.employee.vo.EmployeeVO;
import com.personal.employee.vo.ProEmpCusVO;
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
    public List<ProEmpCusVO> empProCus_list(String emp_idx) {
        return employeeMapper.empProCus_list(emp_idx);
    }
    public int emp_insert(EmployeeVO employeeVO) {
        return employeeMapper.emp_insert(employeeVO);
    }
    public int emp_insert_skill(Map<String, Object> map) {
        return employeeMapper.emp_insert_skill(map);
    }
    public int emp_delete(List<String> delete_emp_list) {
        return employeeMapper.emp_delete(delete_emp_list);
    }
}
