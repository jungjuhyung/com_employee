package com.personal.employee.vo;

import lombok.Data;

@Data
public class CusSearchVO {
    private String customer_name,cpage,option,
    divisionCD, sizeCD, lebelCD, businessCD, statusCD;
    private int offset, limit;
}