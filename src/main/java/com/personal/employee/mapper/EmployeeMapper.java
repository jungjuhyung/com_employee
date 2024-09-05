package com.personal.employee.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.personal.employee.vo.EmpDetailVO;
import com.personal.employee.vo.EmpSearchVO;
import com.personal.employee.vo.EmployeeVO;
import com.personal.employee.vo.ProEmpCusVO;
import com.personal.employee.vo.ProSearchVO;
import com.personal.employee.vo.ProjectVO;
import com.personal.employee.vo.SkillVO;

import java.util.List;
import java.util.Map;

@Mapper
public interface EmployeeMapper {
    int employee_search_count(EmpSearchVO empSearchVO);
    List<EmployeeVO> employee_search(EmpSearchVO empSearchVO);
    EmployeeVO employee_detail_info(String emp_idx);
    List<SkillVO> employee_detail_skill(String emp_idx);
    List<ProEmpCusVO> empProCus_list(EmpDetailVO empDetailVO);
    int emp_insert(EmployeeVO employeeVO);
    int emp_insert_skill(Map<String, Object> map);
    int emp_delete(List<String> delete_emp_list);
    int management_project_delete(List<String> delete_pe_list);
    int management_project_update(ProEmpCusVO update_vo);
    int management_project_insert(ProEmpCusVO insert_vo);
    int skill_delete(List<String> delete_emp_list);
    int empPro_delete(List<String> delete_emp_list);
    int emp_update(EmployeeVO employeeVO);
    int skill_real_delete(String emp_idx);
    int project_pop_search_count(@Param("proSearchVO") ProSearchVO proSearchVO, @Param("in_project_list") List<String> in_project_list);
    List<ProjectVO> project_pop_search(@Param("proSearchVO") ProSearchVO proSearchVO, @Param("in_project_list") List<String> in_project_list);
    List<String> in_project_list(String emp_idx);
}