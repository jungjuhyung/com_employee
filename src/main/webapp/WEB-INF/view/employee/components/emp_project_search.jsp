<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    </head>
    <body>
        <form>
            <label for="project_name">
                프로젝트명
                <input type="text" name="project_name" id="project_name" value="" placeholder="프로젝트명">
            </label>
            <label for="customer_name">
                고객사명
                <input type="text" name="customer_name" id="customer_name" value="" placeholder="고객사명">
            </label>
            <div>
                <label for="fieldCD">
                    유지보수
                    <select id="project_statusCD" name="project_statusCD">
                        <c:forEach items="${project_status_list}" var="k">
                            <c:choose>
                                <c:when test="${k.classification_code == ''}" >
                                    <option value="${k.classification_code}">선택해주세요</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="${k.classification_code}">${k.code_name}</option>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </select>
                </label>
                <label for="skill_condisionCD">
                    기술 조건
                    <select id="skill_condisionCD" name="skill_condisionCD">
                        <c:forEach items="${skill_condision_list}" var="k">
                            <c:choose>
                                <c:when test="${k.classification_code == ''}" >
                                    <option value="${k.classification_code}">선택해주세요</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="${k.classification_code}">${k.code_name}</option>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </select>
                </label>
            </div>
            <div>
                <label for="p_start_date">
                    시작일
                    <input type="date" name="s_p_start_date" id="p_start_date" value="" min="0000-01-01" max="9999-12-31">
                    <span>~</span>
                    <input type="date" name="e_p_start_date" id="p_start_date" value="" min="0000-01-01" max="9999-12-31">
                </label>
                <br>
                <label for="p_last_date">
                    종료일
                    <input type="date" name="s_p_last_date" id="p_last_date" value="" min="0000-01-01" max="9999-12-31">
                    <span>~</span>
                    <input type="date" name="e_p_last_date" id="p_last_date" value="" min="0000-01-01" max="9999-12-31">
                </label>
            </div>
            <input type="button" value="검색" onclick="project_search_pop(this.form)">
            <input type="button" value="검색 초기화" onclick="reset_form(this.form)">
        </form>
        <div id="search_project_area">
            <table>
                <caption>프로젝트 검색</caption>
                <thead>
                    <tr>
                        <th>체크</th>
                        <th>프로젝트명</th>
                        <th>계열</th>
                        <th>고객사</th>
                        <th>시작일</th>
                        <th>종료일</th>
                        <th>진행 상태</th>
                        <th>기술 조건</th>
                    </tr>
                </thead>
                <tbody id="search_project_tbody">
                    <tr>
                        <td colspan="7">검색해주세요</td>
                    </tr>
                </tbody>
            </table>
            <input type="button" value="등록하기" onclick="project_search_pop_in()">
            <div id="project_search_paging_area">
            </div>
        </div>
        <script>
            let project_search_data={
            }
            let select_role;
            let select_score;
            // 검색 ajax
            function project_search_pop_ajax(cpage_v){
                if(typeof cpage_v =="undefined"){
                    project_search_data["cpage"] = null
                }else{
                    project_search_data["cpage"] = cpage_v
                }
                project_search_data["in_project_list"] = window.opener.in_project_list
                $.ajax({
                    type: "post",
                    url: "project_search_pop_ajax",
                    contentType: "application/json",
                    data: JSON.stringify(project_search_data),
                    dataType: "json",
                    success: function (res) {
                        select_role = $("<select name='roleCD' data-value='' onchange='checkboxChk(this)'>");
                        select_score = $("<select name='scoreCD' data-value='' onchange='checkboxChk(this)'>")
                        // 역할 select태그
                        $.each(res.role_list, function (idx, j) { 
                            if(j.classification_code == ''){
                                select_role.append($("<option value=''>").text("선택해주세요"))
                            }else{
                                select_role.append($("<option value='"+j.classification_code+"'>").text(j.code_name))
                            }
                        });

                        // 평가 select태그
                        $.each(res.score_list, function (idx, j) { 
                            if(j.classification_code == ''){
                                select_score.append($("<option value=''>").text("선택해주세요"))
                            }else{
                                select_score.append($("<option value='"+j.classification_code+"'>").text(j.code_name))
                            }
                        });


                        let tbody = $("#search_project_tbody")
                        let paging_area = $("#project_search_paging_area")
                        paging_area.empty()
                        tbody.empty()
                        $.each(res.pro_list, function (idx, k) {
                            let tr = $("<tr>")
                            tr.append($('<td>').append($('<input type="checkbox" name="project_idx" value="'+k.project_idx+'">')))
                            tr.append($("<td>").attr("name","project_name").text(k.project_name));
                            tr.append($("<td>").attr("name","project_class").text(k.project_class));
                            tr.append($("<td>").attr("name","customer_name").text(k.customer_name));
                            if(k.p_start_date != null){
                                tr.append($("<td>").attr("name","p_start_date").text(k.p_start_date));
                            }else{
                                tr.append($("<td>").attr("name","p_start_date").text("-"));
                            }
                            if(k.p_last_date != null){
                                tr.append($("<td>").attr("name","p_last_date").text(k.p_last_date));
                            }else{
                                tr.append($("<td>").attr("name","p_last_date").text("-"));
                            }
                            tr.append($("<td>").attr("name","project_status").text(k.project_status));
                            tr.append($("<td>").attr("name","skill_condision").text(k.skill_condision + " 이상"));
                            tbody.append(tr) 
                        });
                        paging_area.append(paging(res.paging))
                        project_search_data = res.pro_opt
                    },
                    error: function(error) {
                        console.error('Error:', error);
                    }
                });
            }
            

            // paging 블록 생성 함수
            function paging(paging){

                let ol =  $("<ul style='width: 300px; display: flex; justify-content: space-around;'>")
                
                // 이전 블록 버튼
                paging.beginBlock <= paging.pagePerBlock ? ol.append($("<li class='non_move'>").text("이전")) : 
                ol.append($("<li class='move_page' onclick='project_search_pop_ajax("+(paging.beginBlock - paging.pagePerBlock)+")'>").text("이전"))
                
                // 페이지 버튼
                for (let i = paging.beginBlock, len = paging.endBlock; i < len+1; i++) {
                  if(i == paging.nowPage){
                      ol.append($("<li class='now_page'>").text(i))
                  }else{
                      ol.append($("<li class='next_page' onclick='project_search_pop_ajax("+i+")'>").text(i))
                  }
                };
                
                // 이후 블록 버튼
                paging.endBlock >= paging.totalPage ? ol.append($("<li class='non_move'>").text("이후")) : 
                ol.append($("<li class='move_page' onclick='project_search_pop_ajax("+(paging.beginBlock + paging.pagePerBlock)+")'>").text("이후"))
                
                return ol;
            }

            // 검색 옵션 데이터 담는 함수
            function project_search_pop(search_data){
                const inputs = search_data.querySelectorAll('input');
                const selects = search_data.querySelectorAll('select');
                
                inputs.forEach(k => {
                    if (k.name) {
                        project_search_data[k.name] = k.value;
                    }
                });
                selects.forEach(k => {
                    if (k.name) {
                        project_search_data[k.name] = k.value;
                    }
                });
                project_search_data["cpage"] = "1";
                project_search_pop_ajax();
            }

            // 검색 옵션 초기화
            function reset_form(search_data){
                let inputs = search_data.querySelectorAll('input');
                let selects = search_data.querySelectorAll('select');
                
                inputs.forEach(k => {
                    if (k.name) {
                        k.value = "";
                    }
                });
                
                selects.forEach(k => {
                    if (k.name) {
                        k.value  = "";
                    }
                });
            }

            // 부모창에 프로젝트 추가
            function project_search_pop_in(){
                let check_pro =$("#search_project_tbody").find('input[type="checkbox"]').filter(':checked');
                $.each(check_pro, function (idx, k) {
                    let tag_data = $("<tr>");
                    let data_tag = $(k).closest("tr")
                    
                    let clone_select_role = select_role.clone(true);
                    let clone_Select_score = select_score.clone(true);

                    tag_data.append($('<td>').append($('<input type="checkbox" name="project_idx" value="'+$(k).val()+'">')))
                    tag_data.append($("<td>").text($(data_tag).find("[name='project_name']").text()));
                    tag_data.append($("<td>").text($(data_tag).find("[name='project_class']").text()));
                    tag_data.append($("<td>").text($(data_tag).find("[name='customer_name']").text()));
                    tag_data.append($("<td>").text($(data_tag).find("[name='p_start_date']").text()));
                    tag_data.append($("<td>").text($(data_tag).find("[name='p_last_date']").text()));
                    tag_data.append($('<td>').append($('<input type="date" name="in_date" data-value="" value="" onchange="in_dateChk(this)">')))
                    tag_data.append($('<td>').append($('<input type="date" name="out_date" data-value="" value="" onchange="out_dateChk(this)">')))
                    tag_data.append($('<td>').append(clone_select_role))
                    tag_data.append($('<td>').append(clone_Select_score))
                    tag_data.append($("<td>").text($(data_tag).find("[name='project_status']").text()));
                    window.opener.pop_in_data(tag_data);
                });
                window.close()
            }
        </script>
    </body>
</html>