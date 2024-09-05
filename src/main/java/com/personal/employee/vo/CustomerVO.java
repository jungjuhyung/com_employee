package com.personal.employee.vo;

import lombok.Data;
import java.util.List;

@Data
public class CustomerVO {
    private String customer_idx, customer_name, main_num,note,
    f_phone,m_phone,e_phone,
    divisionCD,sizeCD,businessCD,statusCD,
    division,size,business,status;

    public void setCodeName(List<CodeVO> code_list){
        this.division = code_list.stream()
        .filter(k -> k.getGroup_code().equals("CU01") && k.getClassification_code().equals(divisionCD))
        .map(k -> k.getCode_name())
        .findFirst().orElse("코드 없음");

        this.size = code_list.stream()
        .filter(k -> k.getGroup_code().equals("CU02") && k.getClassification_code().equals(sizeCD))
        .map(k -> k.getCode_name())
        .findFirst().orElse("코드 없음");

        this.business = code_list.stream()
        .filter(k -> k.getGroup_code().equals("CU03") && k.getClassification_code().equals(businessCD))
        .map(k -> k.getCode_name())
        .findFirst().orElse("코드 없음");

        this.status = code_list.stream()
        .filter(k -> k.getGroup_code().equals("EX03") && k.getClassification_code().equals(statusCD))
        .map(k -> k.getCode_name())
        .findFirst().orElse("코드 없음");
    }
}