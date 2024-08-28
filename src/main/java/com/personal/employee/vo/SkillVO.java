package com.personal.employee.vo;

import lombok.Data;
import java.util.List;

@Data
public class SkillVO {
    private String skillCD, skill;

    public void setCodeName(List<CodeVO> code_list){
        this.skill = code_list.stream()
        .filter(k -> k.getGroup_code().equals("EX01") && k.getClassification_code().equals(skillCD))
        .map(k -> k.getCode_name())
        .findFirst().orElse("코드 없음");
    }
}