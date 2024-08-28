package com.personal.employee.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.personal.employee.mapper.CodeManagerMapper;
import com.personal.employee.vo.CodeVO;

@Service
public class CodeManagerService {

    @Autowired
    CodeManagerMapper codeManagerMapper;

    public List<CodeVO> lodeCode(){
        return codeManagerMapper.loadCode();
    }
}
