<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
    <head>
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
                <label for="project_statusCD">
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
            <input type="button" value="검색" onclick="project_search(this.form)">
            <input type="button" value="검색 초기화" onclick="reset_form(this.form)">
        </form>
        <input type="button" value="프로젝트 등록" onclick="insert_project()">
        <div id="search_project_area">
            <div id="select_area"></div>
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
                        <th>프로젝트 관리</th>
                    </tr>
                </thead>
                <tbody id="search_project_tbody">
                    <tr>
                        <td colspan="7">검색해주세요</td>
                    </tr>
                </tbody>
            </table>
            <input type="button" value="삭제하기" onclick="delete_project()">
            <div id="project_search_paging_area">
            </div>
        </div>
        <script>
            let pro_data = {
            };

            // 검색 ajax
            function project_search_ajax(cpage_v){
                if(typeof cpage_v =="undefined"){
                    pro_data["cpage"] = null
                }else{
                    pro_data["cpage"] = cpage_v
                }
                $.ajax({
                    type: "post",
                    url: "project_search",
                    contentType: "application/json",
                    data: JSON.stringify(pro_data),
                    dataType: "json",
                    success: function (res) {
                        let tbody = $("#search_project_tbody")
                        let paging_area = $("#project_search_paging_area")
                        paging_area.empty()
                        tbody.empty()
                        $.each(res.pro_list, function (idx, k) {
                            let tr = $("<tr>")
                            tr.append($('<td>').append($('<input type="checkbox" name="project_idx" value="'+k.project_idx+'">')))
                            tr.append($("<td>").text(k.project_name));
                            tr.append($("<td>").text(k.project_class));
                            tr.append($("<td>").text(k.customer_name));
                            if(k.p_start_date != null){
                                tr.append($("<td>").text(k.p_start_date));
                            }else{
                                tr.append($("<td>").text("-"));
                            }
                            if(k.p_last_date != null){
                                tr.append($("<td>").text(k.p_last_date));
                            }else{
                                tr.append($("<td>").text("-"));
                            }
                            tr.append($("<td>").text(k.project_status));
                            tr.append($("<td>").text(k.skill_condision));
                            tr.append($("<td>").append($('<input type="button" onclick="detail_project('+k.project_idx+')" value="관리">')))
                            tbody.append(tr) 
                        });
                        paging_area.append(paging(res.paging))
                        select(res.pro_opt.option)
                        pro_data = {}
                    },
                    error: function(error) {
                        console.error('Error:', error);
                    }
                });
            }
            
            // 처음 입장 세션값 확인
            if("${pro_search}"=='true'){
                project_search_ajax();
            }

            // 개수 select태그 생성 함수
            function select(sel){
                let select_area = $("#select_area");
                select_area.empty()
                let select_tag = $("<select name='option'>")
                select_tag.on('change', function() {
                    option(this.value);
                });
                let list = ["5","10","20"]
                if(sel == null){
                    $.each(list, function (idx, k) { 
                        select_tag.append($("<option value='"+k+"'>").text(k+"개 보기"))
                    });
                }else{
                    $.each(list, function (idx, k) { 
                        if(sel == k){
                            select_tag.append($("<option value='"+k+"' selected>").text(k+"개 보기"))
                            }else{
                            select_tag.append($("<option value='"+k+"'>").text(k+"개 보기"))
                        }
                    });
                }
                select_area.append(select_tag)
            }

            // paging 블록 생성 함수
            function paging(paging){

                let ol =  $("<ol style='width: 300px; display: flex; justify-content: space-around;'>")
                
                // 이전 블록 버튼
                paging.beginBlock <= paging.pagePerBlock ? ol.append($("<li class='non_move'>").text("이전")) : 
                ol.append($("<li class='move_page' onclick='project_search_ajax("+(paging.beginBlock - paging.pagePerBlock)+")'>").text("이전"))
                
                // 페이지 버튼
                for (let i = paging.beginBlock, len = paging.endBlock; i < len+1; i++) {
                  if(i == paging.nowPage){
                      ol.append($("<li class='now_page'>").text(i))
                  }else{
                      ol.append($("<li class='next_page' onclick='project_search_ajax("+i+")'>").text(i))
                  }
                };
                
                // 이후 블록 버튼
                paging.endBlock >= paging.totalPage ? ol.append($("<li class='non_move'>").text("이후")) : 
                ol.append($("<li class='move_page' onclick='project_search_ajax("+(paging.beginBlock + paging.pagePerBlock)+")'>").text("이후"))
                
                return ol;
            }

            // 검색 옵션 데이터 담는 함수
            function project_search(search_data){
                const inputs = search_data.querySelectorAll('input');
                const selects = search_data.querySelectorAll('select');
                
                inputs.forEach(k => {
                    if (k.name) {
                        pro_data[k.name] = k.value;
                    }
                });
                selects.forEach(k => {
                    if (k.name) {
                        pro_data[k.name] = k.value;
                    }
                });
                pro_data["cpage"] = "1";
                project_search_ajax();
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

            // 프로젝트별 상세보기
            function detail_project(project_idx){
                let dl_box = $("<div class='dl_box'>");
                let dl_area = $("<div class='dl_area'>");
                dl_area.load("/employee/project_detail?project_idx="+project_idx)
                $("body").append(dl_box);
                $("body").append(dl_area);
            }

            // 프로젝트 등록
            function insert_project(){
                let dl_box = $("<div class='dl_box'>");
                let dl_area = $("<div class='dl_area'>");
                dl_area.load("/employee/project_insert_in")
                $("body").append(dl_box);
                $("body").append(dl_area);
            }

            // 정렬 옵션 선택
            function option(value){
                pro_data["option"] = value;
                project_search_ajax();
            }

            // 검색창 프로젝트 삭제 ajax
            function delete_project_ajax(delete_project_list){
                $.ajax({
                    type: "post",
                    url: "project_delete",
                    data: JSON.stringify(delete_project_list),
                    contentType: "application/json",
                    dataType: "json",
                    success: function (res) {
                        project_search_ajax("1")
                    },
                    error: function(error) {
                        console.error('Error:', error);
                    }
                });
            }

            // 검색창 프로젝트 삭제 함수
            function delete_project(){
                let check_project =$("#search_project_tbody").find('input[type="checkbox"]').filter(':checked');
                let delete_project_list = []
                $.each(check_project, function (idx, k) {
                    delete_project_list.push($(k).val())
                });
                if(delete_project_list.length > 0){
                    let deleteChk = confirm("정말 삭제하시겠습니까?");

                    if (deleteChk) {
                        delete_project_ajax(delete_project_list)
                    } else {
                        alert("삭제가 취소되었습니다.")
                        return
                    }
                }else{
                    alert("삭제할 프로젝트를 체크해주세요")
                    return
                }
            }
        </script>
    </body>
</html>