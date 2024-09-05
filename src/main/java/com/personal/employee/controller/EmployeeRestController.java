package com.personal.employee.controller;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.personal.employee.common.Paging;
import com.personal.employee.common.PopUpPaging;
import com.personal.employee.service.CodeManagerService;
import com.personal.employee.service.EmployeeService;
import com.personal.employee.vo.CodeVO;
import com.personal.employee.vo.EmpDetailVO;
import com.personal.employee.vo.EmpSearchVO;
import com.personal.employee.vo.EmployeeVO;
import com.personal.employee.vo.ProEmpCusVO;
import com.personal.employee.vo.ProSearchVO;
import com.personal.employee.vo.ProjectVO;

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
import java.io.IOException;

@RestController
public class EmployeeRestController {
    
    @Autowired
    EmployeeService employeeService;

    @Autowired
    CodeManagerService codeManagerService;

    @Autowired
    PopUpPaging popUpPaging;

    @PostMapping("emp_search")
    public ResponseEntity<?> emp_search(@RequestBody EmpSearchVO empSearchVO, HttpServletRequest request) {
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
    public ResponseEntity<?> empProCus_list(@RequestBody EmpDetailVO empDetailVO) {
        List<CodeVO> code_list = codeManagerService.lodeCode();
        List<ProEmpCusVO> empProCus_list = employeeService.empProCus_list(empDetailVO);
        for (ProEmpCusVO k : empProCus_list) {
            k.setCodeName(code_list);
        }
        return ResponseEntity.ok(empProCus_list);
    }

    @PostMapping("emp_project_in_ajax")
    public ResponseEntity<?> emp_project_in_ajax(@RequestBody EmpDetailVO empDetailVO) {
        List<CodeVO> code_list = codeManagerService.lodeCode();
        List<CodeVO> role_list = code_list.stream().filter(k -> k.getGroup_code().equals("EM07")).toList();
        List<CodeVO> score_list = code_list.stream().filter(k -> k.getGroup_code().equals("EX02")).toList();
        List<ProEmpCusVO> empProCus_list = employeeService.empProCus_list(empDetailVO);
        for (ProEmpCusVO k : empProCus_list) {
            k.setCodeName(code_list);
        }
        Map<String, Object> res = new HashMap<>();
        res.put("empProCus_list", empProCus_list);
        res.put("role_list", role_list);
        res.put("score_list", score_list);
        return ResponseEntity.ok(res);
    }

    @PostMapping("emp_insert")
    public ResponseEntity<?> emp_insert(@ModelAttribute EmployeeVO employeeVO, HttpSession session) {

        String path = session.getServletContext().getRealPath("/resources/employee_image");
        if (employeeVO.getImg_file() != null) {
            MultipartFile img_file = employeeVO.getImg_file();
            UUID uuid = UUID.randomUUID();
            String img_name = uuid.toString() + "_" + img_file.getOriginalFilename();
            employeeVO.setImage(img_name);
            try {
                File out = new File(path, img_name);
                byte[] in = img_file.getBytes();
                FileCopyUtils.copy(in, out);
            } catch (IOException e) {
                e.printStackTrace();
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
            employeeService.emp_insert_skill(map);
        }
        
        if (insert_res > 0) {
            return ResponseEntity.ok(employeeVO.getEmp_idx());
        }else{
            return ResponseEntity.ok(null);
        }
    }

    @PostMapping("emp_update")
    public ResponseEntity<?> emp_update(@ModelAttribute EmployeeVO employeeVO, HttpSession session) {
        String path = session.getServletContext().getRealPath("/resources/employee_image");
        EmployeeVO old_emp = employeeService.employee_detail_info(employeeVO.getEmp_idx());
        if (employeeVO.getImg_file() != null) {

            // 기존 파일 삭제
            if (!old_emp.getImage().equals("default.png")) {
                File del_file = new File(path, old_emp.getImage());
                del_file.delete();
            }

            // 새로운 파일 등록
            MultipartFile img_file = employeeVO.getImg_file();
            UUID uuid = UUID.randomUUID();
            String img_name = uuid.toString() + "_" + img_file.getOriginalFilename();
            employeeVO.setImage(img_name);
            try {
                File out = new File(path, img_name);
                byte[] in = img_file.getBytes();
                FileCopyUtils.copy(in, out);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            employeeVO.setImage(old_emp.getImage());
        }

        employeeVO.setPhone(employeeVO.getF_phone()+"-"+employeeVO.getM_phone()+"-"+employeeVO.getE_phone());
        int update_res = employeeService.emp_update(employeeVO);
        
        if (employeeVO.getSkill_list().size() == 0) {
            employeeService.skill_real_delete(employeeVO.getEmp_idx());
        }else{
            Map<String, Object> map = new HashMap<>();
            map.put("emp_idx", employeeVO.getEmp_idx());
            map.put("skill_list", employeeVO.getSkill_list());
            employeeService.emp_update_skill(map);
        }
        
        if (update_res > 0) {
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

    @PostMapping("management_project_delete")
    public ResponseEntity<?> management_project_delete(@RequestBody List<String> delete_pe_list) {
 
        int delete_res = employeeService.management_project_delete(delete_pe_list);
        if (delete_res > 0) {
            return ResponseEntity.ok(delete_res);
        }else{
            return ResponseEntity.ok(0);
        }
    }

    @PostMapping("management_project_update")
    public ResponseEntity<?> management_project_update(@RequestBody List<ProEmpCusVO> update_pe_list) {
        for (ProEmpCusVO update_vo : update_pe_list) {
            employeeService.management_project_update(update_vo);
        }
        return ResponseEntity.ok(1);
    }
    @PostMapping("management_project_insert")
    public ResponseEntity<?> management_project_insert(@RequestBody List<ProEmpCusVO> insert_in_project_list) {
        for (ProEmpCusVO insert_vo : insert_in_project_list) {
            employeeService.management_project_insert(insert_vo);
        }
        return ResponseEntity.ok(1);
    }

    @PostMapping("project_search_pop_ajax")
    public ResponseEntity<?> project_search_pop_ajax(@RequestBody ProSearchVO proSearchVO) {

        List<String> in_project_list = proSearchVO.getIn_project_list();
        int count = employeeService.project_pop_search_count(proSearchVO, in_project_list);
		popUpPaging.setTotalRecord(count);
		
		// 전체 페이지의 수
		if (popUpPaging.getTotalRecord() <= popUpPaging.getNumPerPage()) {
			popUpPaging.setTotalPage(1);
		} else {
			popUpPaging.setTotalPage(popUpPaging.getTotalRecord() / popUpPaging.getNumPerPage());
			if (((popUpPaging.getTotalRecord()*1.0) / popUpPaging.getNumPerPage()) % 2 != 0) {
				popUpPaging.setTotalPage(popUpPaging.getTotalPage() + 1);
			}
		}

		// 현재 페이지 구하기
        String cPage = proSearchVO.getCpage();
        if (cPage == null) {
            popUpPaging.setNowPage(1);
        } else {
            popUpPaging.setNowPage(Integer.parseInt(cPage));
        }

		// offset구하기 limit * 현재페이지-1
		popUpPaging.setOffset(popUpPaging.getNumPerPage() * (popUpPaging.getNowPage() -1 ));
		
		popUpPaging.setBeginBlock(
			(int)(((popUpPaging.getNowPage()-1)/popUpPaging.getPagePerBlock()) * popUpPaging.getPagePerBlock() + 1)
		);
		
		popUpPaging.setEndBlock(popUpPaging.getBeginBlock() + popUpPaging.getPagePerBlock()-1);
		
		if(popUpPaging.getEndBlock() > popUpPaging.getTotalPage()) {
			popUpPaging.setEndBlock(popUpPaging.getTotalPage());
		}
		
        proSearchVO.setOffset(popUpPaging.getOffset());
        proSearchVO.setLimit(popUpPaging.getNumPerPage());
        List<ProjectVO> pro_list = employeeService.project_pop_search(proSearchVO, in_project_list);
        List<CodeVO> code_list = codeManagerService.lodeCode();
        for (ProjectVO k : pro_list) {
            k.setCodeName(code_list);
        }
        List<CodeVO> role_list = code_list.stream().filter(k -> k.getGroup_code().equals("EM07")).toList();
        List<CodeVO> score_list = code_list.stream().filter(k -> k.getGroup_code().equals("EX02")).toList();
        Map<String, Object> res = new HashMap<>();
        res.put("role_list", role_list);
        res.put("score_list", score_list);
        res.put("pro_opt", proSearchVO);
        res.put("pro_list", pro_list);
        res.put("paging", popUpPaging);
        return ResponseEntity.ok(res);
    }
}
