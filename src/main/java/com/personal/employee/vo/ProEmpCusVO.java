package com.personal.employee.vo;

import lombok.Data;
import java.util.List;

@Data
public class ProEmpCusVO {
    private String pe_idx,project_idx,emp_idx,in_date,out_date,
    note,project_name,p_start_date,p_last_date,cp_idx,customer_idx,cp_num,customer_name,emp_name,
    classCD,lebelCD,fieldCD,roleCD,scoreCD,project_classCD,project_statusCD,statusCD,
    class_d,lebel,field,role,score,project_class,project_status,status;


    public void setCodeName(List<CodeVO> code_list){

        this.class_d = code_list.stream()
        .filter(k -> k.getGroup_code().equals("EM03") && k.getClassification_code().equals(classCD))
        .map(k -> k.getCode_name())
        .findFirst().orElse("코드 없음");

        this.lebel = code_list.stream()
        .filter(k -> k.getGroup_code().equals("EM06") && k.getClassification_code().equals(lebelCD))
        .map(k -> k.getCode_name())
        .findFirst().orElse("코드 없음");

        this.field = code_list.stream()
        .filter(k -> k.getGroup_code().equals("EM05") && k.getClassification_code().equals(fieldCD))
        .map(k -> k.getCode_name())
        .findFirst().orElse("코드 없음");

        this.role = code_list.stream()
        .filter(k -> k.getGroup_code().equals("EM07") && k.getClassification_code().equals(roleCD))
        .map(k -> k.getCode_name())
        .findFirst().orElse("코드 없음");

        this.score = code_list.stream()
        .filter(k -> k.getGroup_code().equals("EX02") && k.getClassification_code().equals(scoreCD))
        .map(k -> k.getCode_name())
        .findFirst().orElse("코드 없음");

        this.project_class = code_list.stream()
        .filter(k -> k.getGroup_code().equals("PR02") && k.getClassification_code().equals(project_classCD))
        .map(k -> k.getCode_name())
        .findFirst().orElse("코드 없음");

        this.project_status = code_list.stream()
        .filter(k -> k.getGroup_code().equals("PR01") && k.getClassification_code().equals(project_statusCD))
        .map(k -> k.getCode_name())
        .findFirst().orElse("코드 없음");

        this.status = code_list.stream()
        .filter(k -> k.getGroup_code().equals("EX03") && k.getClassification_code().equals(statusCD))
        .map(k -> k.getCode_name())
        .findFirst().orElse("코드 없음");
    }
}