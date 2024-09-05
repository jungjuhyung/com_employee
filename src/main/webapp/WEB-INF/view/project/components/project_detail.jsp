<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <script>
            function pro_detail_ajax(option){
                let proEmp_data={
                    "project_idx":"${prvo.project_idx}"
                }
                if(typeof option =="undefined"){
                    proEmp_data["option"] = null
                }else{
                    proEmp_data["option"] = option
                }
                $.ajax({
                    type: "post",
                    url: "proEmpCus_list",
                    contentType: "application/json",
                    data: JSON.stringify(proEmp_data),
                    dataType: "json",
                    success: function (res) {
                        let tbody = $("#proEmp_area");
                        tbody.empty()
                        $.each(res, function (idx, k) {
                            let tr = $("<tr>")
                            tr.append($("<td>").text(k.emp_name));
                            tr.append($("<td>").text(k.class_d));
                            tr.append($("<td>").text(k.lebel));
                            tr.append($("<td>").text(k.field));
                            if(k.in_date != null){
                                tr.append($("<td>").text(k.in_date));
                            }else{
                                tr.append($("<td>").text("-"));
                            }
                            if(k.out_date != null){
                                tr.append($("<td>").text(k.out_date));
                            }else{
                                tr.append($("<td>").text("-"));
                            }
                            tr.append($("<td>").text(k.role));
                            tr.append($("<td>").text(k.score));
                            tbody.append(tr) 
                        });
                    },
                    error: function(error) {
                        console.error('Error:', error);
                    }
                });
            }
            pro_detail_ajax();
        </script>
    </head>
    <body>
        <section id="pro_detail_sec">
            <article id="customer_res">
                <div>${prvo.project_name}</div>
                <div> ${prvo.customer_name}</div>
                <div>
                    <c:choose>
                        <c:when test="${prvo.cp_num == '' || prvo.cp_num == null}" >
                            <c:choose>
                                <c:when test="${prvo.main_num != '' || prvo.main_num != null}" >
                                    <span>회사 번호 : ${prvo.main_name}</span>
                                </c:when>
                                <c:otherwise>
                                    <span>등록된 번호가 없습니다.</span>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <span>대표 번호 : ${prvo.cp_num}</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </article>
            <article id="project_info">
                <c:choose>
                    <c:when test="${prvo.p_start_date == '' || prvo.p_start_date == null}" >
                        <div>시작일 : <span>예정이 없습니다.</span></div>
                    </c:when>
                    <c:otherwise>
                        <div>시작일 : <span>${prvo.p_start_date}</span></div>
                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${prvo.p_last_date == '' || prvo.p_last_date == null}" >
                        <div>종료일 : <span>예정이 없습니다.</span></div>
                    </c:when>
                    <c:otherwise>
                        <div>종료일 : <span>${prvo.p_last_date}</span></div>
                    </c:otherwise>
                </c:choose>
                <div>
                    주소 : <span>${prvo.p_zip_code}, ${prvo.p_main_adress}, ${prvo.p_detail_adress}, ${prvo.p_extra_adress}</span>
                </div>
                <div>
                    대표PM : <span>${prvo.rep_pm_name}(${prvo.rep_pm_phone})</span>
                </div>
            </article>
            <article>
                <div>프로젝트 유형 : <span>${prvo.project_class}</span></div>
                <div>프로젝트 진행상태 : <span>${prvo.project_status}</span></div>
                <div>기술 조건 : <span>${prvo.skill_condision}</span></div>
            </article>
            <article id="pro_skill_res">
                <c:forEach var="k" items="${skill_list}">
                    <input type="checkbox" value="${k.skillCD}" checked disabled><span>${k.skill}</span>
                </c:forEach>
            </article>
            <article>
                <input type="button" name="update_pro_detail_btn" id="update_pro_detail_btn" value="수정" onclick="update_pro_detail('${prvo.project_idx}')">
                <input type="button" name="delete_pro_detail_btn" id="delete_pro_detail_btn" value="삭제" onclick="delete_pro_detail('${prvo.project_idx}')">
            </article>
            <article>
                <fieldset>
                    <legend>비고</legend>
                    ${prvo.note}
                </fieldset>
            </article>
        </section>
        <section>
            <article>
                <caption>투입인원</caption>
                <select name="detail_option" id="detail_option" onchange="pro_detail_ajax(this.value)">
                    <option value="in_date">투입일</option>
                    <option value="out_date">철수일</option>
                </select>
                <table>
                    <thead>
                        <tr>
                            <th>이름</th>
                            <th>직급</th>
                            <th>기술 등급</th>
                            <th>기술 분야</th>
                            <th>투입일</th>
                            <th>철수일</th>
                            <th>역할</th>
                            <th>평가</th>
                        </tr>
                    </thead>
                    <tbody id="proEmp_area"></tbody>
                </table>
                <input type="button" name="pro_management_emp" id="pro_management_emp_btn" value="투입인원 관리" onclick="pro_management_emp('${prvo.project_idx}')">
            </article>
            <input type="button" value="닫기" onclick="close_detail()">
        </section>
        <script>
            function delete_pro_detail(pro_idx){
                let deleteChk = confirm("정말 삭제하시겠습니까?");
                if (deleteChk) {
                    let delete_pro_detail = [project_idx]
                    delete_pro_ajax(delete_pro_detail)
                    $(".dl_area").remove()
                    $(".dl_box").remove()
                } else {
                    alert("삭제가 취소되었습니다.")
                    return
                }
            }

            // 프로젝트 수정 페이지
            function update_pro_detail(project_idx){
                    $(".dl_area").empty();
                    $(".dl_area").load("/employee/project_update_in?project_idx="+project_idx)
            }

            // 프로젝트 투입인원 관리
            function pro_management_emp(project_idx){
                $(".dl_area").empty();
                $(".dl_area").load("/employee/pro_management_emp?project_idx="+project_idx)
            }
            function close_detail(){
                $(".dl_box").remove()
                $(".dl_area").remove()
            }
        </script>
    </body>
    </html>