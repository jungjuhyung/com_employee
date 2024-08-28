package com.personal.employee.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.personal.employee.vo.EmpSearchVO;
import com.personal.employee.vo.EmployeeVO;
import com.personal.employee.vo.ProEmpCusVO;
import com.personal.employee.vo.SkillVO;

import java.util.List;

@Mapper
public interface EmployeeMapper {
    int employee_search_count(EmpSearchVO empSearchVO);
    List<EmployeeVO> employee_search(EmpSearchVO empSearchVO);
    EmployeeVO employee_detail_info(String emp_idx);
    List<SkillVO> employee_detail_skill(String emp_idx);
    List<ProEmpCusVO> empProCus_list(String emp_idx);
}