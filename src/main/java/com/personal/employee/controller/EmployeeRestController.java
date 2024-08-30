package com.personal.employee.controller;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.personal.employee.common.Paging;
import com.personal.employee.service.CodeManagerService;
import com.personal.employee.service.EmployeeService;
import com.personal.employee.vo.CodeVO;
import com.personal.employee.vo.EmpDetailVO;
import com.personal.employee.vo.EmpSearchVO;
import com.personal.employee.vo.EmployeeVO;
import com.personal.employee.vo.ProEmpCusVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.UUID;
import java.io.File;

@RestController
public class EmployeeRestController {
    
    @Autowired
    EmployeeService employeeService;

    @Autowired
    CodeManagerService codeManagerService;

    @PostMapping("search")
    public ResponseEntity<?> search(@RequestBody EmpSearchVO empSearchVO, HttpServletRequest request) {
        Paging paging = new Paging();
        HttpSession session = request.getSession();
        String emp_search = (String)session.getAttribute("emp_search");
        String cpage_sub = empSearchVO.getCpage();
        String option_sub = empSearchVO.getOption();
        if (emp_search == null) {
            session.setAttribute("emp_search", "true");
        }else if(empSearchVO.getEmp_name() == null && cpage_sub == null && option_sub == null) {
            empSearchVO = (EmpSearchVO)session.getAttribute("emp_opt");
            if (empSearchVO.getOption() != null) {
                paging.setNumPerPage(Integer.parseInt(empSearchVO.getOption()));
            }
        }else if(empSearchVO.getEmp_name() == null && cpage_sub == null && option_sub != null) {
            empSearchVO = (EmpSearchVO)session.getAttribute("emp_opt");
            empSearchVO.setOption(option_sub);
            empSearchVO.setCpage("1");
            paging.setNumPerPage(Integer.parseInt(option_sub));
        }else if(empSearchVO.getEmp_name() == null && cpage_sub != null){
            empSearchVO = (EmpSearchVO)session.getAttribute("emp_opt");
            empSearchVO.setCpage(cpage_sub);
            if (empSearchVO.getOption() != null) {
                paging.setNumPerPage(Integer.parseInt(empSearchVO.getOption()));
            }
        }
        int count = employeeService.employee_search_count(empSearchVO);
		paging.setTotalRecord(count);
		
		// 전체 페이지의 수
		if (paging.getTotalRecord() <= paging.getNumPerPage()) {
			paging.setTotalPage(1);
		} else {
			paging.setTotalPage(paging.getTotalRecord() / paging.getNumPerPage());
			if (((paging.getTotalRecord()*1.0) / paging.getNumPerPage()) % 2 != 0) {
				paging.setTotalPage(paging.getTotalPage() + 1);
			}
		}

		// 현재 페이지 구하기
        String cPage = empSearchVO.getCpage();
        if (cPage == null) {
            paging.setNowPage(1);
        } else {
            paging.setNowPage(Integer.parseInt(cPage));
        }

		// offset구하기 limit * 현재페이지-1
		paging.setOffset(paging.getNumPerPage() * (paging.getNowPage() -1 ));
		
		paging.setBeginBlock(
			(int)(((paging.getNowPage()-1)/paging.getPagePerBlock()) * paging.getPagePerBlock() + 1)
		);
		
		paging.setEndBlock(paging.getBeginBlock() + paging.getPagePerBlock()-1);
		
		if(paging.getEndBlock() > paging.getTotalPage()) {
			paging.setEndBlock(paging.getTotalPage());
		}
		
        empSearchVO.setOffset(paging.getOffset());
        empSearchVO.setLimit(paging.getNumPerPage());
        List<EmployeeVO> emp_list = employeeService.employee_search(empSearchVO);
        List<CodeVO> code_list = codeManagerService.lodeCode();
        for (EmployeeVO k : emp_list) {
            k.setCodeName(code_list);
        }
        session.setAttribute("emp_opt", empSearchVO);
        Map<String, Object> res = new HashMap<>();
        res.put("emp_opt", empSearchVO);
        res.put("emp_list", emp_list);
        res.put("paging", paging);
        return ResponseEntity.ok(res);
    }

    @PostMapping("empProCus_list")
    public ResponseEntity<?> search(@RequestBody EmpDetailVO empDetailVO) {
        List<CodeVO> code_list = codeManagerService.lodeCode();
        List<ProEmpCusVO> empProCus_list = employeeService.empProCus_list(empDetailVO.getEmp_idx());
        for (ProEmpCusVO k : empProCus_list) {
            k.setCodeName(code_list);
        }
        return ResponseEntity.ok(empProCus_list);
    }

    @PostMapping("emp_insert")
    public ResponseEntity<?> emp_insert(@ModelAttribute EmployeeVO employeeVO, HttpSession session) {
        String path = session.getServletContext().getRealPath("/resources/employee_image");
        if (employeeVO.getImg_file() != null) {
            MultipartFile img_file = employeeVO.getImg_file();
            if (img_file.isEmpty()) {
                employeeVO.setImage("default.png");
            } else {
                UUID uuid = UUID.randomUUID();
                String img_name = uuid.toString() + "_" + img_file.getOriginalFilename();
                employeeVO.setImage(img_name);
                try {
                    File dir = new File(path);
                    if (!dir.exists()) {
                        dir.mkdirs();
                    }
                    File out = new File(path, img_name);
                    byte[] in = img_file.getBytes();
                    FileCopyUtils.copy(in, out);
                } catch (Exception e) {
                    employeeVO.setImage("default.png");
                }
            }
        } else {
            employeeVO.setImage("default.png");
        }
        employeeVO.setPhone(employeeVO.getF_phone()+"-"+employeeVO.getM_phone()+"-"+employeeVO.getE_phone());
        int insert_res = employeeService.emp_insert(employeeVO);
        
        if (employeeVO.getSkill_list().size() > 0) {
            Map<String, Object> map = new HashMap<>();
            map.put("emp_idx", employeeVO.getEmp_idx());
            map.put("skill_list", employeeVO.getSkill_list());
            int insert_skill_res = employeeService.emp_insert_skill(map);
        }
        
        if (insert_res > 0) {
            System.out.println("selectkey : "+employeeVO.getEmp_idx());
            return ResponseEntity.ok(employeeVO.getEmp_idx());
        }else{
            return ResponseEntity.ok(null);
        }
    }

    @PostMapping("emp_delete")
    public ResponseEntity<?> emp_delete(@RequestBody List<String> delete_emp_list) {
        int delete_res = employeeService.emp_delete(delete_emp_list);
        if (delete_res > 0) {
            return ResponseEntity.ok(delete_res);
        }else{
            return ResponseEntity.ok(0);
        }
    }
}
