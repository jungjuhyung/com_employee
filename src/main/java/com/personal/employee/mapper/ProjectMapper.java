package com.personal.employee.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.personal.employee.vo.CusSearchVO;
import com.personal.employee.vo.CustomerVO;
import com.personal.employee.vo.EmployeeVO;
import com.personal.employee.vo.ProDetailVO;
import com.personal.employee.vo.ProEmpCusVO;
import com.personal.employee.vo.ProSearchVO;
import com.personal.employee.vo.ProjectVO;
import com.personal.employee.vo.SkillVO;

import java.util.List;
import java.util.Map;

@Mapper
public interface ProjectMapper {

    int project_search_count(ProSearchVO proSearchVO);
    List<ProjectVO> project_search(ProSearchVO proSearchVO);
    ProjectVO project_detail_info(String project_idx);
    List<SkillVO> project_detail_skill(String project_idx);
    List<ProEmpCusVO> proEmpCus_list(ProDetailVO proDetailVO);
    int customer_pop_search_count(CusSearchVO cusSearchVO);
    List<CustomerVO> customer_pop_search(CusSearchVO cusSearchVO);
    int customer_insert_pop(CustomerVO customerVO);
    int project_insert(ProjectVO projectVO);
    int project_customer_insert(ProjectVO projectVO);
    int project_insert_skill(Map<String, Object> map);

    int project_delete(List<String> delete_project_list);
    int project_skill_delete(List<String> delete_project_list);
    int proEmp_delete(List<String> delete_project_list);
    int proCus_delete(List<String> delete_project_list);
}