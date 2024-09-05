package com.personal.employee.vo;

import lombok.Data;
import java.util.List;

@Data
public class ProSearchVO {
    private String project_name, customer_name, emp_idx,
    skill_condisionCD, project_statusCD, 
    s_p_start_date, e_p_start_date, s_p_last_date, e_p_last_date, cpage, option;
    private List<String> in_project_list;
    private int offset, limit;
}