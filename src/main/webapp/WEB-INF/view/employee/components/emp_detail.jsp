<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <script>
            let empPro_data={
                "emp_idx":"${eivo.emp_idx}"
            }
            function detail_ajax(option){
                if(typeof cpage_v =="undefined"){
                    data["option"] = null
                }else{
                    data["option"] = option
                }
                $.ajax({
                    type: "post",
                    url: "empProCus_list",
                    contentType: "application/json",
                    data: JSON.stringify(empPro_data),
                    dataType: "json",
                    success: function (res) {
                        console.log(res)
                        let tbody = $("#empPro_area");
                        tbody.empty()
                        $.each(res, function (idx, k) {
                            let tr = $("<tr>")
                            tr.append($("<td>").text(k.project_name));
                            tr.append($("<td>").text(k.project_class));
                            tr.append($("<td>").text(k.name));
                            tr.append($("<td>").text(k.start_date));
                            if(k.last_date != null){
                                tr.append($("<td>").text(k.last_date));
                                }else{
                                tr.append($("<td>").text("-"));
                            }
                            tr.append($("<td>").text(k.in_date));
                            if(k.last_date != null){
                                tr.append($("<td>").text(k.out_date));
                                }else{
                                tr.append($("<td>").text("-"));
                            }
                            tr.append($("<td>").text(k.role));
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
            detail_ajax("${eivo.emp_idx}");
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
                <input type="button" name="update_emp_detail_btn" id="update_emp_detail_btn" value="수정" onclick="update_emp_detail('${eivo.emp_idx}')">
                <input type="button" name="delete_emp_detail_btn" id="delete_emp_detail_btn" value="삭제" onclick="delete_emp_detail('${eivo.emp_idx}')">
            </article>
            <article>
                <table>
                    <thead>
                        <tr>
                            <th>프로젝트명</th>
                            <th>계열</th>
                            <th>고객사</th>
                            <th>시작일</th>
                            <th>종료일</th>
                            <th>투입일</th>
                            <th>철수일</th>
                            <th>역할</th>
                            <th>진행 상태</th>
                            <th>비고</th>
                        </tr>
                    </thead>
                    <tbody id="empPro_area"></tbody>
                </table>
                <input type="button" name="management_project" id="management_project_btn" value="프로젝트 관리" onclick="management_project('${eivo.emp_idx}')">
            </article>
        </section>
        <script>
            function delete_emp_detail(emp_idx){
                let deleteChk = confirm("정말 삭제하시겠습니까?");
                    if (deleteChk) {
                        let delete_emp_detail = [emp_idx]
                        delete_emp_ajax(delete_emp_detail)
                        $(".dl_area").remove()
                        $(".dl_box").remove()
                    } else {
                        alert("삭제가 취소되었습니다.")
                        return
                    }
            }
        </script>
    </body>
    </html>