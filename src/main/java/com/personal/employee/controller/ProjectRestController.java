package com.personal.employee.controller;

import org.springframework.web.bind.annotation.RestController;

import com.personal.employee.common.Paging;
import com.personal.employee.common.PopUpPaging;
import com.personal.employee.service.CodeManagerService;
import com.personal.employee.service.ProjectService;
import com.personal.employee.vo.CodeVO;
import com.personal.employee.vo.CusSearchVO;
import com.personal.employee.vo.CustomerVO;
import com.personal.employee.vo.ProDetailVO;
import com.personal.employee.vo.ProEmpCusVO;
import com.personal.employee.vo.ProSearchVO;
import com.personal.employee.vo.ProjectVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@RestController
public class ProjectRestController {

    @Autowired
    private CodeManagerService codeManagerService;

    @Autowired
    private ProjectService projectService;

    @Autowired
    private PopUpPaging popUpPaging;


    @PostMapping("project_search")
        public ResponseEntity<?> project_search(@RequestBody ProSearchVO proSearchVO, HttpServletRequest request) {
            Paging paging = new Paging();
            HttpSession session = request.getSession();
            String pro_search = (String)session.getAttribute("pro_search");
            String cpage_sub = proSearchVO.getCpage();
            String option_sub = proSearchVO.getOption();
            if (pro_search == null) {
                session.setAttribute("pro_search", "true");
            }else if(proSearchVO.getProject_name() == null && cpage_sub == null && option_sub == null) {
                proSearchVO = (ProSearchVO)session.getAttribute("pro_opt");
                if (proSearchVO.getOption() != null) {
                    paging.setNumPerPage(Integer.parseInt(proSearchVO.getOption()));
                }
            }else if(proSearchVO.getProject_name() == null && cpage_sub == null && option_sub != null) {
                proSearchVO = (ProSearchVO)session.getAttribute("pro_opt");
                proSearchVO.setOption(option_sub);
                proSearchVO.setCpage("1");
                paging.setNumPerPage(Integer.parseInt(option_sub));
            }else if(proSearchVO.getProject_name() == null && cpage_sub != null){
                proSearchVO = (ProSearchVO)session.getAttribute("pro_opt");
                proSearchVO.setCpage(cpage_sub);
                if (proSearchVO.getOption() != null) {
                    paging.setNumPerPage(Integer.parseInt(proSearchVO.getOption()));
                }
            }
            
            int count = projectService.project_search_count(proSearchVO);
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
            String cPage = proSearchVO.getCpage();
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
            
            proSearchVO.setOffset(paging.getOffset());
            proSearchVO.setLimit(paging.getNumPerPage());
            List<ProjectVO> pro_list = projectService.project_search(proSearchVO);
            List<CodeVO> code_list = codeManagerService.lodeCode();
            for (ProjectVO k : pro_list) {
                k.setCodeName(code_list);
            }
            session.setAttribute("pro_opt", proSearchVO);
            Map<String, Object> res = new HashMap<>();
            res.put("pro_opt", proSearchVO);
            res.put("pro_list", pro_list);
            res.put("paging", paging);
            return ResponseEntity.ok(res);
        }

    @PostMapping("proEmpCus_list")
    public ResponseEntity<?> proEmpCus_list(@RequestBody ProDetailVO proDetailVO) {
        List<CodeVO> code_list = codeManagerService.lodeCode();
        List<ProEmpCusVO> proEmpCus_list = projectService.proEmpCus_list(proDetailVO);
        for (ProEmpCusVO k : proEmpCus_list) {
            k.setCodeName(code_list);
        }
        return ResponseEntity.ok(proEmpCus_list);
    }

    @PostMapping("customer_search_pop_ajax")
    public ResponseEntity<?> customer_search_pop_ajax(@RequestBody CusSearchVO cusSearchVO) {
        int count = projectService.customer_pop_search_count(cusSearchVO);
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
        String cPage = cusSearchVO.getCpage();
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
		
        cusSearchVO.setOffset(popUpPaging.getOffset());
        cusSearchVO.setLimit(popUpPaging.getNumPerPage());
        List<CustomerVO> cus_list = projectService.customer_pop_search(cusSearchVO);
        List<CodeVO> code_list = codeManagerService.lodeCode();
        for (CustomerVO k : cus_list) {
            k.setCodeName(code_list);
        }
        Map<String, Object> res = new HashMap<>();
        res.put("cus_opt", cusSearchVO);
        res.put("cus_list", cus_list);
        res.put("paging", popUpPaging);
        return ResponseEntity.ok(res);
    }
    @PostMapping("project_insert_ajax")
    public ResponseEntity<?> project_insert_ajax(@RequestBody ProjectVO projectVO) {

        projectVO.setCp_num(projectVO.getF_cus_phone()+"-"+projectVO.getM_cus_phone()+"-"+projectVO.getE_cus_phone());
        projectVO.setRep_pm_phone(projectVO.getF_phone()+"-"+projectVO.getM_phone()+"-"+projectVO.getE_phone());
        int insert_res = projectService.project_insert(projectVO);
        projectService.project_customer_insert(projectVO);
        if (projectVO.getSkill_list().size() > 0) {
            Map<String, Object> map = new HashMap<>();
            map.put("project_idx", projectVO.getProject_idx());
            map.put("skill_list", projectVO.getSkill_list());
            projectService.project_insert_skill(map);
        }
        
        if (insert_res > 0) {
            return ResponseEntity.ok(projectVO.getProject_idx());
        }else{
            return ResponseEntity.ok(null);
        }
    }

    @PostMapping("project_delete")
    public ResponseEntity<?> project_delete(@RequestBody List<String> delete_project_list) {
        int delete_res = projectService.project_delete(delete_project_list);
        if (delete_res > 0) {
            return ResponseEntity.ok(delete_res);
        }else{
            return ResponseEntity.ok(0);
        }
    }
}
