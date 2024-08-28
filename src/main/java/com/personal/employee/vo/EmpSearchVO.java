package com.personal.employee.vo;

import lombok.Data;

@Data
public class EmpSearchVO {
    private String emp_name, fieldCD, classCD, lebelCD, employment_statusCD, 
    s_start_date, e_start_date, s_last_date, e_last_date,cpage, option;
    private int offset, limit;
}