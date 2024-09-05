package com.personal.employee.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.personal.employee.mapper.ProjectMapper;
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

@Service
public class ProjectService {

    @Autowired
    private ProjectMapper projectMapper;

    public int project_search_count(ProSearchVO proSearchVO) {
        return projectMapper.project_search_count(proSearchVO);
    }

    public List<ProjectVO> project_search(ProSearchVO proSearchVO) {
        return projectMapper.project_search(proSearchVO);
    }

    public ProjectVO project_detail_info(String project_idx) {
        return projectMapper.project_detail_info(project_idx);
    }
    public List<SkillVO> project_detail_skill(String project_idx) {
        return projectMapper.project_detail_skill(project_idx);
    }

    public List<ProEmpCusVO> proEmpCus_list(ProDetailVO proDetailVO) {
        return projectMapper.proEmpCus_list(proDetailVO);
    }

    public int customer_pop_search_count(CusSearchVO cusSearchVO) {
        return projectMapper.customer_pop_search_count(cusSearchVO);
    }
    public List<CustomerVO> customer_pop_search(CusSearchVO cusSearchVO) {
        return projectMapper.customer_pop_search(cusSearchVO);
    }
    public int customer_insert_pop(CustomerVO customerVO) {
        return projectMapper.customer_insert_pop(customerVO);
    }
    public int project_insert(ProjectVO projectVO) {
        return projectMapper.project_insert(projectVO);
    }
    public int project_customer_insert(ProjectVO projectVO) {
        return projectMapper.project_customer_insert(projectVO);
    }
    public int project_insert_skill(Map<String, Object> map) {
        return projectMapper.project_insert_skill(map);
    }

    @Transactional
    public int project_delete(List<String> delete_project_list) {
        projectMapper.project_delete(delete_project_list);
        projectMapper.project_skill_delete(delete_project_list);
        projectMapper.proEmp_delete(delete_project_list);
        projectMapper.proCus_delete(delete_project_list);
        return delete_project_list.size();
    }
}
