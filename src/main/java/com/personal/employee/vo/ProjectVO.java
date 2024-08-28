package com.personal.employee.vo;

import lombok.Data;
import java.util.List;

@Data
public class ProjectVO {
    private String project_idx, project_name, project_classCD,skill_condisionCD,project_statusCD,statusCD,
    start_date,last_date,zip_code,main_adress,detail_adress,rep_pm_name,rep_pm_phone,note,
    
    project_class,skill_condision,project_status,status;

    public void setCodeName(List<CodeVO> code_list){
        this.project_class = code_list.stream()
        .filter(k -> k.getGroup_code().equals("PR02") && k.getClassification_code().equals(project_classCD))
        .map(k -> k.getCode_name())
        .findFirst().orElse("코드 없음");

        this.skill_condision = code_list.stream()
        .filter(k -> k.getGroup_code().equals("EM06") && k.getClassification_code().equals(skill_condisionCD))
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