<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <script>
            in_project_list = [];
            function emp_project_in_ajax(){
                let empProIn_data={
                    "emp_idx":"${eivo.emp_idx}",
                    "option" : null
                }
                $.ajax({
                    type: "post",
                    url: "emp_project_in_ajax",
                    contentType: "application/json",
                    data: JSON.stringify(empProIn_data),
                    dataType: "json",
                    success: function (res) {
                        let tbody = $("#empPro_area");
                        tbody.empty()
                        $.each(res.empProCus_list, function (idx, k) {
                            in_project_list.push(k.project_idx)

                            // 역할 select태그
                            let select_role = $("<select name='roleCD' data-value='"+k.roleCD+"' onchange='checkboxChk(this)'>")
                            $.each(res.role_list, function (idx, j) { 
                                if(j.classification_code == ''){
                                    select_role.append($("<option value=''>").text("선택해주세요"))
                                }else if(j.classification_code == k.roleCD){
                                    select_role.append($("<option value='"+j.classification_code+"' selected>").text(j.code_name))
                                }else{
                                    select_role.append($("<option value='"+j.classification_code+"'>").text(j.code_name))
                                }
                            });

                            // 평가 select태그
                            let select_score = $("<select name='scoreCD' data-value='"+k.scoreCD+"' onchange='checkboxChk(this)'>")
                            $.each(res.score_list, function (idx, j) { 
                                    if(j.classification_code == ''){
                                    select_score.append($("<option value=''>").text("선택해주세요"))
                                    }else if(j.classification_code == k.scoreCD){
                                    select_score.append($("<option value='"+j.classification_code+"' selected>").text(j.code_name))
                                }else{
                                    select_score.append($("<option value='"+j.classification_code+"'>").text(j.code_name))
                                    }
                            });
                            
                            let tr = $("<tr>")
                            tr.append($('<td>').append($('<input type="checkbox" name="emp_idx" value="'+k.pe_idx+'">')))
                            tr.append($("<td>").text(k.project_name));
                            tr.append($("<td>").text(k.project_class));
                            tr.append($("<td>").text(k.customer_name));
                            // 프로젝트 시작일
                            if(k.p_start_date != null){
                                tr.append($("<td>").text(k.p_start_date));
                            }else{
                                tr.append($("<td>").text("-"));
                            }
                            // 프로젝트 종료일
                            if(k.p_last_date != null){
                                tr.append($("<td>").text(k.p_last_date));
                            }else{
                                tr.append($("<td>").text("-"));
                            }
                            // 프로젝트 투입일
                            if(k.in_date != null){
                                tr.append($("<td>").append($('<input type="date" name="in_date" data-value="'+k.in_date+'" value="'+k.in_date+'" onchange="in_dateChk(this)">')))
                            }else{
                                tr.append($("<td>").append($('<input type="date" name="in_date" onchange="in_dateChk(this)>')))
                            }
                            // 프로젝트 철수일
                            if(k.out_date != null){
                                tr.append($("<td>").append($('<input type="date" name="out_date" data-value="'+k.out_date+'" value="'+k.out_date+'" onchange="out_dateChk(this)">')))
                            }else{
                                tr.append($("<td>").append($('<input type="date" name="out_date" onchange="out_dateChk(this)">')))
                            }
                            tr.append($("<td>").append(select_role));
                            tr.append($("<td>").append(select_score));
                            tr.append($("<td>").text(k.project_status));
                            tr.append($("<td>").text(k.note));
                            tbody.append(tr) 
                        });
                    },
                    error: function(error) {
                        console.error('Error:', error);
                    }
                });
            }
            emp_project_in_ajax("${eivo.emp_idx}");
        </script>
    </head>
    <body>
        <section id="detail_sec">
            <article id="emp_res">
                <div id="emp_img">
                    <img src="resources/employee_image/${eivo.image}" alt="">
                </div>
                <div id="emp_info">
                    <span>이름 : ${eivo.emp_name}</span>
                    <span>기술분야 : ${eivo.field}</span>
                    <span>성별 : ${eivo.gender}</span>
                    <span>직급 : ${eivo.class_d}</span>
                    <span>주민번호 : ${eivo.f_resident_num}-${eivo.b_resident_num}</span>
                    <span>기술등급 : ${eivo.lebel}</span>
                    <span>전화번호 : ${eivo.phone}</span>
                    <span>계약 종류 : ${eivo.agreement}</span>
                    <span>이메일 : ${eivo.f_email}@${eivo.e_email}</span>
                    <span>입사일 : ${eivo.start_date}</span>
                    <span>주소 : ${eivo.zip_code}, ${eivo.main_adress}, ${eivo.detail_adress}, ${eivo.extra_adress}</span>
                    <span>퇴사일 : ${eivo.last_date}</span>
                    <span>재직상태 : ${eivo.employment_status}</span>
                </div>
                <div id="emp_skill">
                    <c:forEach var="k" items="${skill_list}">
                        <input type="checkbox" value="${k.skillCD}" checked disabled><span>${k.skill}</span>
                    </c:forEach>
                </div>
            </article>
            <article>
                <table id="management_project_table">
                    <caption>참여하고 있는 프로젝트</caption>
                    <thead>
                        <tr>
                            <th>선택</th>
                            <th>프로젝트명</th>
                            <th>계열</th>
                            <th>고객사</th>
                            <th>시작일</th>
                            <th>종료일</th>
                            <th>투입일</th>
                            <th>철수일</th>
                            <th>역할</th>
                            <th>평가</th>
                            <th>진행 상태</th>
                            <th>비고</th>
                        </tr>
                    </thead>
                    <tbody id="empPro_area"></tbody>
                </table>
                <input type="button" name="management_project_delete" id="management_project_delete_btn" value="참여 프로젝트 삭제" onclick="management_project_delete()">
                <input type="button" name="management_project_update" id="management_project_update_btn" value="참여 프로젝트 수정" onclick="management_project_update()">
            </article>
            <article>
                <input type="button" value="프로젝트 검색" onclick="project_search()">
                <table id="in_emp_project_table">
                    <caption>프로젝트 등록</caption>
                    <thead>
                        <tr>
                            <th>선택</th>
                            <th>프로젝트명</th>
                            <th>계열</th>
                            <th>고객사</th>
                            <th>시작일</th>
                            <th>종료일</th>
                            <th>투입일</th>
                            <th>철수일</th>
                            <th>역할</th>
                            <th>평가</th>
                            <th>진행 상태</th>
                        </tr>
                    </thead>
                    <tbody id="inEmpPro_area"></tbody>
                </table>
                <input type="button" value="프로젝트 등록" onclick="in_emp_project_insert()">
                <input type="button" value="등록 프로젝트 삭제" onclick="in_emp_project_delete()">
            </article>
            <input type="button" value="상세보기 이동" onclick="move_detail()">
            <input type="button" value="닫기" onclick="close_project_management()">
        </section>
        <script>

            // 참여한 프로젝트 삭제 ajax
            function delete_management_project_ajax(delete_pe_list){
                $.ajax({
                    type: "post",
                    url: "management_project_delete",
                    data: JSON.stringify(delete_pe_list),
                    contentType: "application/json",
                    dataType: "json",
                    success: function (res) {
                        $(".dl_area").empty();
                        $(".dl_area").load("/employee/emp_management_project?emp_idx="+"${emp_idx}")
                    },
                    error: function(error) {
                        console.error('Error:', error);
                    }
                });
            }

            // 참여한 프로젝트 삭제 리스트 추출
            function management_project_delete(){
                let check_emp =$("#management_project_table").find('input[type="checkbox"]').filter(':checked');

                if(check_emp.length > 0){
                    let deleteChk = confirm("정말 삭제하시겠습니까?");

                    if (deleteChk) {
                        let delete_pe_list = []
                        $.each(check_emp, function (idx, k) {
                            delete_pe_list.push($(k).val())
                        });
                        delete_management_project_ajax(delete_pe_list)
                    } else {
                        alert("삭제가 취소되었습니다.")
                        return
                    }
                }else{
                    alert("삭제할 사원을 체크해주세요")
                    return
                }
            }

            // 참여한 프로젝트 수정 ajax
            function update_management_project_ajax(update_pe_list){
                $.ajax({
                    type: "post",
                    url: "management_project_update",
                    data: JSON.stringify(update_pe_list),
                    contentType: "application/json",
                    dataType: "json",
                    success: function (res) {
                        $(".dl_area").empty();
                        $(".dl_area").load("/employee/emp_management_project?emp_idx="+"${emp_idx}")
                    },
                    error: function(error) {
                        console.error('Error:', error);
                    }
                });
            }

            // 참여한 프로젝트 수정 리스트 추출
            function management_project_update(){
                let check_emp =$("#management_project_table").find('input[type="checkbox"]').filter(':checked');
                let update_pe_list = []
                $.each(check_emp, function (idx, k) {
                    let tr =$(k).closest("tr")
                    update_json={}
                    update_json["pe_idx"] = $(k).val()
                    update_json["in_date"] = tr.find("input[name='in_date']").val()
                    update_json["out_date"] = tr.find("input[name='out_date']").val()
                    update_json["roleCD"] = tr.find("select[name='roleCD']").val()
                    update_json["scoreCD"] = tr.find("select[name='scoreCD']").val()
                    if(
                        tr.find("input[name='in_date']").data("value") == tr.find("input[name='in_date']").val() &&  
                        tr.find("input[name='out_date']").data("value") == tr.find("input[name='out_date']").val() &&  
                        tr.find("select[name='roleCD']").data("value") == tr.find("select[name='roleCD']").val() &&  
                        tr.find("select[name='scoreCD']").data("value") == tr.find("select[name='scoreCD']").val() 
                    ){
                        return true
                    }
                    update_pe_list.push(update_json)
                });

                if(check_emp.length > 0 && check_emp.length == update_pe_list.length){
                    let updateChk = confirm("정말 수정하시겠습니까?");

                    if (updateChk) {
                        update_management_project_ajax(update_pe_list)
                    } else {
                        alert("수정이 취소되었습니다.")
                        return
                    }
                }else{
                    alert("수정 사항과 수정할 프로젝트를 체크해주세요")
                    return
                }
            }

            function checkboxChk(k){
                if($(k).data("value") == $(k).val()){
                    $(k).css("backgroundColor", "");
                }else{
                    $(k).css("backgroundColor", "gray");
                    $(k).closest("tr").find("input[type='checkbox']").prop("checked", true)
                }
            }
            function in_dateChk(k){
                let out_date = $(k).closest("tr").find("input[name='out_date']")
                if(out_date.val() != "" && out_date.val() < $(k).val()){
                    alert("투입일은 철수일보다 클 수 없습니다.")
                    $(k).css("backgroundColor", "");
                    $(k).val($(k).data("value"))
                    return
                }else{
                    if($(k).data("value") == $(k).val()){
                        $(k).css("backgroundColor", "");
                    }else{
                        $(k).css("backgroundColor", "gray");
                        $(k).closest("tr").find("input[type='checkbox']").prop("checked", true)
                    }
                }
            }

            function out_dateChk(k){
                let in_date = $(k).closest("tr").find("input[name='in_date']")
                if(in_date.val() != "" && in_date.val() > $(k).val()){
                    alert("철수일은 투입일보다보다 작을 수 없습니다.")
                    $(k).css("backgroundColor", "");
                    $(k).val($(k).data("value"))
                    return
                }else{
                    if($(k).data("value") == $(k).val()){
                        $(k).css("backgroundColor", "");
                    }else{
                        $(k).css("backgroundColor", "gray");
                        $(k).closest("tr").find("input[type='checkbox']").prop("checked", true)
                    }
                }
            }

            function project_search(){
                window.open("emp_project_search", "팝업 테스트","width=1000, height=1000, top=10, right=10")
            }
            function pop_in_data(tag_data){
                in_project_list.push($(tag_data).find("[name='project_idx']").val())
                $("#inEmpPro_area").append($(tag_data));
            }
            function in_emp_project_delete(){
                let check_in_pro =$("#inEmpPro_area").find('input[type="checkbox"]').filter(':checked');
                
                if(check_in_pro.length > 0){
                    let deleteChk = confirm("등록할 프로젝트를 리스트에서 제거하시겠습니까?");
                    if (deleteChk) {
                        $.each(check_in_pro, function (idx, k) {
                            let tr =$(k).closest("tr")
                            in_project_list = in_project_list.filter(function(j) {
                                return j !== $(k).val();
                            });
                            $(tr).remove()
                        });
                    } else {
                        alert("리스트에서 프로젝트 제거가 취소되었습니다.")
                        return
                    }
                }else{
                    alert("제거할 프로젝트를 체크해주세요")
                    return
                }
            }

            // 참여한 프로젝트 수정 ajax
            function insert_management_project_ajax(insert_in_project_list){
                $.ajax({
                    type: "post",
                    url: "management_project_insert",
                    data: JSON.stringify(insert_in_project_list),
                    contentType: "application/json",
                    dataType: "json",
                    success: function (res) {
                        $(".dl_area").empty();
                        $(".dl_area").load("/employee/emp_management_project?emp_idx="+"${emp_idx}")
                    },
                    error: function(error) {
                        console.error('Error:', error);
                    }
                });
            }
            function in_emp_project_insert(){
                let check_in_pro =$("#inEmpPro_area").find('input[type="checkbox"]').filter(':checked');
                if(check_in_pro.length > 0){
                    let insertChk = confirm("정말 프로젝트를 추가하시겠습니까?");

                    if (insertChk) {
                        let insert_in_project_list = []
                        $.each(check_in_pro, function (idx, k) {
                            let tr =$(k).closest("tr")
                            insert_json={}
                            insert_json["emp_idx"] = "${emp_idx}"
                            insert_json["project_idx"] = $(k).val()
                            insert_json["in_date"] = tr.find("input[name='in_date']").val()
                            insert_json["out_date"] = tr.find("input[name='out_date']").val()
                            insert_json["roleCD"] = tr.find("select[name='roleCD']").val()
                            insert_json["scoreCD"] = tr.find("select[name='scoreCD']").val()
                            insert_in_project_list.push(insert_json)
                        });
                        insert_management_project_ajax(insert_in_project_list)
                    } else {
                        alert("프로젝트 추가가 취소되었습니다.")
                        return
                    }
                }else{
                    alert("추가할 프로젝트를 체크해주세요")
                    return
                }
            }
            function close_project_management(){
                $(".dl_box").remove()
                $(".dl_area").remove()
            }
            function move_detail(){
                $(".dl_area").empty()
                $(".dl_area").load("/employee/emp_detail?emp_idx="+"${emp_idx}")
            }


        </script>
    </body>
    </html>