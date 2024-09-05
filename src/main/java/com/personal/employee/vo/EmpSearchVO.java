package com.personal.employee.vo;

import java.util.List;

import lombok.Data;

@Data
public class EmpSearchVO {
    private String emp_name, project_idx, fieldCD, classCD, lebelCD, employment_statusCD, 
    s_start_date, e_start_date, s_last_date, e_last_date,cpage, option;
    private List<String> in_emp_list;
    private int offset, limit;
}