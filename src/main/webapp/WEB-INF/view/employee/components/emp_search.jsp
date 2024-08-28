<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
    <head>
    </head>
    <body>
        <form>
            <label for="emp_name">
                사원명
                <c:choose>
                    <c:when test="${emp_opt != null}" >
                        <input type="text" name="emp_name" id="emp_name" value="${emp_opt.emp_name}" placeholder="사원명">
                    </c:when>
                    <c:otherwise>
                        <input type="text" name="emp_name" id="emp_name" value="" placeholder="사원명">
                    </c:otherwise>
                </c:choose>
            </label>
            <div>
                <label for="fieldCD">
                    기술분야
                    <select id="fieldCD" name="fieldCD">
                        <c:forEach items="${field_list}" var="k">
                            <c:choose>
                                <c:when test="${k.classification_code == ''}" >
                                    <option value="${k.classification_code}">선택해주세요</option>
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${emp_opt.fieldCD == k.classification_code}">
                                            <option value="${k.classification_code}" selected>${k.code_name}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${k.classification_code}">${k.code_name}</option>
                                        </c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </select>
                </label>
                <label for="classCD">
                    직급
                    <select id="classCD" name="classCD">
                        <c:forEach items="${class_list}" var="k">
                            <c:choose>
                                <c:when test="${k.classification_code == ''}" >
                                    <option value="${k.classification_code}">선택해주세요</option>
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${emp_opt.classCD == k.classification_code}">
                                            <option value="${k.classification_code}" selected>${k.code_name}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${k.classification_code}">${k.code_name}</option>
                                        </c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </select>
                </label>
                <label for="lebelCD">
                    기술 등급
                    <select id="lebelCD" name="lebelCD">
                        <c:forEach items="${lebel_list}" var="k">
                            <c:choose>
                                <c:when test="${k.classification_code == ''}" >
                                    <option value="${k.classification_code}">선택해주세요</option>
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${emp_opt.lebelCD == k.classification_code}">
                                            <option value="${k.classification_code}" selected>${k.code_name}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${k.classification_code}">${k.code_name}</option>
                                        </c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </select>
                </label>
                <label for="employment_statusCD">
                    재직상태
                    <select id="employment_statusCD" name="employment_statusCD">
                        <c:forEach items="${employment_status_list}" var="k">
                            <c:choose>
                                <c:when test="${k.classification_code == ''}" >
                                    <option value="${k.classification_code}">선택해주세요</option>
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${emp_opt.employment_statusCD == k.classification_code}">
                                            <option value="${k.classification_code}" selected>${k.code_name}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${k.classification_code}">${k.code_name}</option>
                                        </c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </select>
                </label>
            </div>
            <div>
                <label for="start_date">
                    입사일
                    <c:choose>
                        <c:when test="${emp_opt != null}}" >
                            <input type="date" name="s_start_date" id="start_date" value="${emp_opt.s_start_date}">
                        </c:when>
                        <c:otherwise>
                            <input type="date" name="s_start_date" id="start_date" value="">
                        </c:otherwise>
                    </c:choose>
                    <span>~</span>
                    <c:choose>
                        <c:when test="${emp_opt != null}}" >
                            <input type="date" name="e_start_date" id="start_date" value="${emp_opt.e_start_date}">
                        </c:when>
                        <c:otherwise>
                            <input type="date" name="e_start_date" id="start_date" value="">
                        </c:otherwise>
                    </c:choose>
                </label>
                <br>
                <label for="last_date">
                    퇴사일
                    <c:choose>
                        <c:when test="${emp_opt != null}}" >
                            <input type="date" name="s_last_date" id="last_date" value="${emp_opt.s_last_date}">
                        </c:when>
                        <c:otherwise>
                            <input type="date" name="s_last_date" id="last_date" value="">
                        </c:otherwise>
                    </c:choose>
                    <span>~</span>
                    <c:choose>
                        <c:when test="${emp_opt != null}}" >
                            <input type="date" name="e_last_date" id="last_date" value="${emp_opt.e_last_date}">
                        </c:when>
                        <c:otherwise>
                            <input type="date" name="e_last_date" id="last_date" value="">
                        </c:otherwise>
                    </c:choose>
                </label>
            </div>
            <input type="button" value="검색" onclick="search(this.form)">
            <input type="button" value="검색 초기화" onclick="reset(this.form)">
        </form>
        <input type="button" value="사원 등록" onclick="insert_emp()">
        <div>
            <div id="select_area"></div>
            <table>
                <thead>
                    <tr>
                        <th>체크</th>
                        <th>이름</th>
                        <th>기술분야</th>
                        <th>직급</th>
                        <th>기술 등급</th>
                        <th>재직 상태</th>
                        <th>입사일</th>
                        <th>퇴사일</th>
                        <th>관리</th>
                    </tr>
                </thead>
                <tbody id="search_area">
                    <tr>
                        <td colspan="5">검색해주세요</td>
                    </tr>
                </tbody>
            </table>
            <div id="paging_area"">
            </div>
        </div>
        <script>
            let data = {
            };

            function search_ajax(cpage_v){
                if(typeof cpage_v =="undefined"){
                    data["cpage"] = null
                }else{
                    data["cpage"] = cpage_v
                }
                $.ajax({
                    type: "post",
                    url: "search",
                    contentType: "application/json",
                    data: JSON.stringify(data),
                    dataType: "json",
                    success: function (res) {
                        let tbody = $("#search_area")
                        let paging_area = $("#paging_area")
                        paging_area.empty()
                        tbody.empty()
                        $.each(res.emp_list, function (idx, k) {
                            let tr = $("<tr>")
                            tr.append($('<td>').append($('<input type="checkbox" name="emp_idx" value="'+k.emp_idx+'">')))
                            tr.append($("<td>").text(k.emp_name));
                            tr.append($("<td>").text(k.field));
                            tr.append($("<td>").text(k.class_d));
                            tr.append($("<td>").text(k.lebel));
                            tr.append($("<td>").text(k.employment_status));
                            tr.append($("<td>").text(k.start_date.substring(0,10)));
                            if(k.last_date != null){
                                tr.append($("<td>").text(k.last_date.substring(0,10)));
                                }else{
                                tr.append($("<td>").text("-"));
                            }
                            tr.append($("<td>").append($('<input type="button" onclick="detail_emp('+k.emp_idx+')" value="관리">')))
                            tbody.append(tr) 
                        });
                        paging_area.append(paging(res.paging))
                        select(res.emp_opt.option)
                        data = {}
                    },
                    error: function(error) {
                        console.error('Error:', error);
                    }
                });
            }
            
            if("${emp_search}"=='true'){
                console.log("확인")
                search_ajax();
            }
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

            function paging(paging){

                let ol =  $("<ol style='width: 300px; display: flex; justify-content: space-around;'>")
                
                // 이전 블록 버튼
                paging.beginBlock <= paging.pagePerBlock ? ol.append($("<li class='non_move'>").text("이전")) : 
                ol.append($("<li class='move_page' onclick='search_ajax("+(paging.beginBlock - paging.pagePerBlock)+")'>").text("이전"))
                
                // 페이지 버튼
                for (let i = paging.beginBlock, len = paging.endBlock; i < len+1; i++) {
                  if(i == paging.nowPage){
                      ol.append($("<li class='now_page'>").text(i))
                  }else{
                      ol.append($("<li class='next_page' onclick='search_ajax("+i+")'>").text(i))
                  }
                };
                
                // 이후 블록 버튼
                paging.endBlock >= paging.totalPage ? ol.append($("<li class='non_move'>").text("이후")) : 
                ol.append($("<li class='move_page' onclick='search_ajax("+(paging.beginBlock + paging.pagePerBlock)+")'>").text("이후"))
                
                return ol;
            }

            function search(search_data){
                const inputs = search_data.querySelectorAll('input');
                const selects = search_data.querySelectorAll('select');
                
                inputs.forEach(k => {
                    if (k.name) {
                        data[k.name] = k.value;
                    }
                });
                selects.forEach(k => {
                    if (k.name) {
                        console.log(k.value)
                        data[k.name] = k.value;
                    }
                });
                data["cpage"] = "1";
                search_ajax();
            }
            // 검색 옵션 초기화
            function reset(search_data){
                let inputs = search_data.querySelectorAll('input');
                let selects = search_data.querySelectorAll('select');
                
                inputs.forEach(k => {
                    if (k.name) {
                        data[k.name] = "";
                    }
                });
                selects.forEach(k => {
                    if (k.name) {
                        data[k.name] = "";
                    }
                });
            }

            // 사원별 상세보기
            function detail_emp(emp_idx){
                let dl_box = $("<div class='dl_box'>");
                let dl_area = $("<div class='dl_area'>");
                dl_box.on('click', function() {
                    dl_area.remove();
                    $(this).remove();
                });
                dl_area.load("/employee/emp_detail",{param: emp_idx})
                $("body").append(dl_box);
                $("body").append(dl_area);
            }

            // 사원 등록
            function insert_emp(){
                let dl_box = $("<div class='dl_box'>");
                let dl_area = $("<div class='dl_area'>");
                dl_box.on('click', function() {
                    dl_area.remove();
                    $(this).remove();
                });
                dl_area.load("/employee/emp_insert")
                $("body").append(dl_box);
                $("body").append(dl_area);
            }

            // 정렬 옵션 선택
            function option(value){
                console.log(value)
                data["option"] = value;
                search_ajax();
            }
        </script>
    </body>
</html>