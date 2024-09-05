<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    </head>
    <body>
        <section id="pro_update_sec">
            <article id="customer_res">
                <div>
                    <label for="">
                        *프로젝트명
                        <input type="text" name="project_name" value="${prvo.project_name}" placeholder="프로젝트명">
                    </label>
                </div>
                <div id="pro_customer_area">
                    <label for="customer_name">
                        *고객사명
                        <input type="text" name="customer_name" value="${prvo.customer_name}" readonly>
                    </label>
                    <label for="f_cus_phone">
                        *고객사 번호
                        <input type="text" id="f_cus_phone" class="cp_num" name="f_cus_phone" value="${f_cp_phone}" maxlength="3" oninput="insert_numChk(this)">
                        <span>-</span>
                        <input type="text" id="m_cus_phone" class="cp_num" name="m_cus_phone" value="${m_cp_phone}" maxlength="4" oninput="insert_numChk(this)">
                        <span>-</span>
                        <input type="text" id="e_cus_phone" class="cp_num" name="e_cus_phone" value="${e_cp_phone}" maxlength="4" oninput="insert_numChk(this)">
                        <input type="hidden" name="main_num" value="${prvo.main_num}" ">
                    </label>
                    <input type="hidden" name="customer_idx" value="${prvo.customer_idx}" ">
                    <input type="button" value="고객사 검색/등록" onclick="customer_search()">
                    <br>
                    <label>
                        회사 번호 사용
                        <input type="checkbox" name="use_main_num" onchange="use_main_num(this)">
                    </label>
                </div>
            </article>
            <article id="project_info">
                <div>
                    <label for="p_start_date">
                        시작일
                        <input type="date" name="p_start_date" value="${prvo.p_start_date}" min="0000-01-01" max="9999-12-31">
                    </label>
                </div>
                <div>
                    <label for="p_last_date">
                        종료일
                        <input type="date" name="p_last_date" value="${prvo.p_last_date}" min="0000-01-01" max="9999-12-31">
                    </label>
                </div>
                <div>
                    <label for="">
                        주소
                        <input type="text" id="sample6_postcode" name="p_zip_code" value="${prvo.p_zip_code}" placeholder="우편번호">
                        <input type="button" onclick="adress_search()" value="우편번호 찾기"><br>
                        <input type="text" id="sample6_address" name="p_main_adress" value="${prvo.p_main_adress}" placeholder="주소"><br>
                        <input type="text" id="sample6_detailAddress" name="p_detail_adress" value="${prvo.p_detail_adress}" placeholder="상세주소">
                        <input type="text" id="sample6_extraAddress" name="p_extra_adress" value="${prvo.p_extra_adress}" placeholder="참고항목">
                    </label>
                </div>
                <div>
                    <label for="rep_pm_name">
                        대표 PM
                        <input type="text" id="rep_pm_name" name="rep_pm_name" value="${prvo.rep_pm_name}">
                    </label>
                    <label for="rep_pm_phone">
                        대표 PM 번호
                        <input type="text" id="rep_pm_phone" class="rep_pm_phone" name="f_phone" value="${f_phone}" maxlength="3" oninput="insert_numChk(this)">
                        <span>-</span>
                        <input type="text" id="rep_pm_phone" class="rep_pm_phone" name="m_phone" value="${m_phone}" maxlength="4" oninput="insert_numChk(this)">
                        <span>-</span>
                        <input type="text" id="rep_pm_phone" class="rep_pm_phone" name="e_phone" value="${e_phone}" maxlength="4" oninput="insert_numChk(this)">
                    </label>
                </div>
            </article>
            <article>
                <label for="project_classCD">
                    프로젝트 유형
                    <select id="project_classCD" name="project_classCD">
                        <c:forEach items="${project_class_list}" var="k">
                            <c:choose>
                                <c:when test="${k.classification_code == ''}" >
                                    <option value="${k.classification_code}">선택해주세요</option>
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${k.classification_code == prvo.project_classCD}" >
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
                <label for="project_statusCD">
                    진행 상태
                    <select id="project_statusCD" name="project_statusCD">
                        <c:forEach items="${project_status_list}" var="k">
                            <c:choose>
                                <c:when test="${k.classification_code == ''}" >
                                    <option value="${k.classification_code}">선택해주세요</option>
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${k.classification_code == prvo.project_statusCD}" >
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
                <label for="skill_condisionCD">
                    기술 조건
                    <select id="skill_condisionCD" name="skill_condisionCD">
                        <c:forEach items="${skill_condision_list}" var="k">
                            <c:choose>
                                <c:when test="${k.classification_code == ''}" >
                                    <option value="${k.classification_code}">선택해주세요</option>
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${k.classification_code == prvo.skill_condisionCD}" >
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
            </article>
            <article id="pro_skill_update">
                <c:forEach var="k" items="${skill_list}">
                    <c:choose>
                        <c:when test="${k.classification_code == ''}" >
                        </c:when>
                        <c:otherwise>
                            <c:choose>
                                <c:when test="${fn:contains(project_skill_values, k.classification_code)}" >
                                    <input type="checkbox" name="skillCD" value="${k.classification_code}" checked><span>${k.code_name}</span>
                                </c:when>
                                <c:otherwise>
                                    <input type="checkbox" name="skillCD" value="${k.classification_code}"><span>${k.code_name}</span>
                                </c:otherwise>
                            </c:choose>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </article>
            <article>
                <textarea name="note" id="note">${prvo.note}</textarea>
            </article>
            <input type="button" value="프로젝트 등록" onclick="project_update_go(this)">
            <input type="button" value="닫기" onclick="close_update()">
        </section>
        <script>
            // 수정 함수
            function project_update_ajax(project_update_data){
                $.ajax({
                    type: "post",
                    url: "project_update_ajax",
                    contentType: "application/json",
                    data: JSON.stringify(project_update_data),
                    dataType: "json",
                    success: function (res) {
                        if(res != null){
                            let dl_area = $(".dl_area");
                            dl_area.empty()
                            dl_area.load("/employee/project_detail?project_idx="+res)
                            project_search_ajax();
                        }
                    },
                    error: function(error) {
                        console.error('Error:', error);
                    }
                });
            }

            // 유효성 검사 및 데이터 담기
            function project_update_go(section){
                let project_update_data = {};
                let update_section = $(section).closest('section');

                let input_texts = update_section.find('input[type="text"]');
                let input_dates = update_section.find('input[type="date"]');
                let checkboxs = $("#pro_skill_update").find('input[type="checkbox"]').filter(':checked');
                let selects = update_section.find('select');
                let input_note = update_section.find('textarea[name="note"]');
                let input_customer_idx = update_section.find('input[name="customer_idx"]');
                
            
                let input_project_name = update_section.find('input[name="project_name"]');
                let input_customer_name = update_section.find('input[name="customer_name"]');
                let input_f_cus_phone = update_section.find('input[name="f_cus_phone"]');
                let input_m_cus_phone = update_section.find('input[name="m_cus_phone"]');
                let input_e_cus_phone = update_section.find('input[name="e_cus_phone"]');

                if(input_project_name.val() == ""){
                    alert("이름을 입력해주세요")
                    input_project_name.focus()
                    return
                }
                if(input_customer_name.val() == ""){
                    alert("이름을 입력해주세요")
                    input_customer_name.focus()
                    return
                }
                
                if(input_f_cus_phone.val() ==  ""){
                    alert("고객사 번호 앞자리를 입력해주세요")
                    input_f_cus_phone.focus()
                    return
                }
                if(input_m_cus_phone.val() ==  ""){
                    alert("고객사 번호 중간 자리를 입력해주세요")
                    input_m_cus_phone.focus()
                    return
                }
                if(input_e_cus_phone.val() ==  ""){
                    alert("고객사 번호 뒷자리를 입력해주세요")
                    input_e_cus_phone.focus()
                    return
                }
                
                $.each(input_texts, function (idx, k) { 
                    if (k.name) {
                        project_update_data[k.name] = k.value;
                    }
                });
                $.each(selects, function (idx, k) { 
                    if (k.name) {
                        project_update_data[k.name] = k.value;
                    }
                });
                $.each(input_dates, function (idx, k) { 
                    if (k.name) {
                        project_update_data[k.name] = k.value;
                    }
                });
         
                let chk_val = []
                $.each(checkboxs, function (idx, k) {
                    if($(k).attr('name')){
                        chk_val.push($(k).val())
                    }
                });
                project_update_data["skill_list"] = chk_val;
                project_update_data["customer_idx"] = input_customer_idx.val();
                project_update_data["note"] = input_note.val();
                
                project_update_ajax(project_update_data)
            }
            
            // 숫자 입력 체크
            function insert_numChk(num) {
                let value = num.value;
                num.value = value.replace(/\D/g, '');
            }

            function close_update(){
                $(".dl_box").remove()
                $(".dl_area").remove()
            }

            function customer_search(){
                window.open("customer_search_pop_in", "고객사 검색","width=1000, height=1000, top=10, right=10")
            }

            function add_customer_pop(customer_idx, customer_name, main_num){
                let pro_customer_area = $("#pro_customer_area")
                pro_customer_area.find("[name='customer_idx']").val(customer_idx)
                pro_customer_area.find("[name='customer_name']").val(customer_name)
                pro_customer_area.find("[name='main_num']").val(main_num)
            }

            function use_main_num(tag){
                let pro_customer_area = $("#pro_customer_area")
                let customer_name = pro_customer_area.find("[name='customer_name']")
                let cp_num = pro_customer_area.find("[name='main_num']")
                let f_cus_phone = pro_customer_area.find("[name='f_cus_phone']")
                let m_cus_phone = pro_customer_area.find("[name='m_cus_phone']")
                let e_cus_phone = pro_customer_area.find("[name='e_cus_phone']")
                if($(tag).prop("checked")){
                    if(customer_name.val() == ''){
                        alert("고객사를 선택해주세요")
                        $(tag).prop("checked", false)
                        return
                    }else{
                        let cp_num_array = $(cp_num).val().split("-")
                        f_cus_phone.val(cp_num_array[0])
                        f_cus_phone.attr("readonly", true);
                        m_cus_phone.val(cp_num_array[1])
                        m_cus_phone.attr("readonly", true);
                        e_cus_phone.val(cp_num_array[2])
                        e_cus_phone.attr("readonly", true);
                    }
                }else{
                    f_cus_phone.val("")
                    f_cus_phone.attr("readonly", false);
                    m_cus_phone.val("")
                    m_cus_phone.attr("readonly", false);
                    e_cus_phone.val("")
                    e_cus_phone.attr("readonly", false);
                    return
                }
            }
            // 주소 찾기 api
            function adress_search() {
                new daum.Postcode({
                    oncomplete: function(data) {
                        // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
        
                        // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                        // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                        var addr = ''; // 주소 변수
                        var extraAddr = ''; // 참고항목 변수
        
                        //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                        if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                            addr = data.roadAddress;
                        } else { // 사용자가 지번 주소를 선택했을 경우(J)
                            addr = data.jibunAddress;
                        }
        
                        // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                        if(data.userSelectedType === 'R'){
                            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                                extraAddr += data.bname;
                            }
                            // 건물명이 있고, 공동주택일 경우 추가한다.
                            if(data.buildingName !== '' && data.apartment === 'Y'){
                                extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                            }
                            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                            if(extraAddr !== ''){
                                extraAddr = ' (' + extraAddr + ')';
                            }
                            // 조합된 참고항목을 해당 필드에 넣는다.
                            document.getElementById("sample6_extraAddress").value = extraAddr;
                        
                        } else {
                            document.getElementById("sample6_extraAddress").value = '';
                        }
        
                        // 우편번호와 주소 정보를 해당 필드에 넣는다.
                        document.getElementById('sample6_postcode').value = data.zonecode;
                        document.getElementById("sample6_address").value = addr;
                        // 커서를 상세주소 필드로 이동한다.
                        document.getElementById("sample6_detailAddress").focus();
                    }
                }).open();
            }
        </script>
    </body>
</html>