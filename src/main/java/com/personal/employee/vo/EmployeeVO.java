package com.personal.employee.vo;

import lombok.Data;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

@Data
public class EmployeeVO {

    private String emp_idx,emp_name,f_resident_num,b_resident_num,phone,f_email,
    image,zip_code,main_adress,detail_adress,extra_adress,start_date,last_date,
    fieldCD,agreementCD,classCD,lebelCD,employment_statusCD,genderCD,e_emailCD,statusCD,note,
    field,agreement,class_d,lebel,employment_status,gender,e_email,status,
    f_phone,m_phone,e_phone;

    private List<String> skill_list;
    private MultipartFile img_file;

    public void setCodeName(List<CodeVO> code_list){
        this.field = code_list.stream()
        .filter(k -> k.getGroup_code().equals("EM05") && k.getClassification_code().equals(fieldCD))
        .map(k -> k.getCode_name())
        .findFirst().orElse("코드 없음");

        this.agreement = code_list.stream()
        .filter(k -> k.getGroup_code().equals("EM02") && k.getClassification_code().equals(agreementCD))
        .map(k -> k.getCode_name())
        .findFirst().orElse("코드 없음");

        this.class_d = code_list.stream()
        .filter(k -> k.getGroup_code().equals("EM03") && k.getClassification_code().equals(classCD))
        .map(k -> k.getCode_name())
        .findFirst().orElse("코드 없음");

        this.lebel = code_list.stream()
        .filter(k -> k.getGroup_code().equals("EM06") && k.getClassification_code().equals(lebelCD))
        .map(k -> k.getCode_name())
        .findFirst().orElse("코드 없음");

        this.employment_status = code_list.stream()
        .filter(k -> k.getGroup_code().equals("EM04") && k.getClassification_code().equals(employment_statusCD))
        .map(k -> k.getCode_name())
        .findFirst().orElse("코드 없음");

        this.gender = code_list.stream()
        .filter(k -> k.getGroup_code().equals("EM08") && k.getClassification_code().equals(genderCD))
        .map(k -> k.getCode_name())
        .findFirst().orElse("코드 없음");

        this.e_email = code_list.stream()
        .filter(k -> k.getGroup_code().equals("EX04") && k.getClassification_code().equals(e_emailCD))
        .map(k -> k.getCode_name())
        .findFirst().orElse("코드 없음");

        this.status = code_list.stream()
        .filter(k -> k.getGroup_code().equals("EX03") && k.getClassification_code().equals(statusCD))
        .map(k -> k.getCode_name())
        .findFirst().orElse("코드 없음");
    }
}
