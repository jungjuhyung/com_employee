package com.personal.employee.mapper;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import com.personal.employee.vo.CodeVO;

@Mapper
public interface CodeManagerMapper {
    List<CodeVO> loadCode();
}