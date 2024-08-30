<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    </head>
    <body>
        <section id="insert_sec">
            <article id="emp_res">
                <div id="emp_img">
                    <img id="emp_insert_img" src="resources/employee_image/default.png" alt="">
                    <input type="file" id="insert_img_file" name="img_file" value="" onchange="img_chk(this)">
                    <input type="button" value="기본사진 설정" onclick="img_reset()">
                </div>
                <div id="emp_info">
                    <label for="emp_name">
                        이름
                        <input type="text" id="emp_name" name="emp_name" value="">
                    </label>
                    <label for="fieldCD">
                        기술분야
                        <select id="fieldCD" name="fieldCD">
                            <c:forEach items="${field_list}" var="k">
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
                    <label for="genderCD">
                        성별
                        <select id="genderCD" name="genderCD">
                            <c:forEach items="${gender_list}" var="k">
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
                    <label for="classCD">
                        직급
                        <select id="classCD" name="classCD">
                            <c:forEach items="${class_list}" var="k">
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
                    <label for="f_resident_num">
                        주민번호
                        <input type="text" id="f_resident_num" name="f_resident_num" value="" maxlength="6" oninput="insert_numChk(this)">
                        <span>-</span>
                        <input type="password" name="b_resident_num" value="" maxlength="7" oninput="insert_numChk(this)"">
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
                                        <option value="${k.classification_code}">${k.code_name}</option>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </select>
                    </label>
                    <label for="f_phone">
                        전화번호
                        <input type="text" id="f_phone" name="f_phone" value="" maxlength="3" oninput="insert_numChk(this)">
                        <span>-</span>
                        <input type="text" id="m_phone" name="m_phone" value="" maxlength="4" oninput="insert_numChk(this)">
                        <span>-</span>
                        <input type="text" id="e_phone" name="e_phone" value="" maxlength="4" oninput="insert_numChk(this)">
                    </label>
                    <label for="employment_statusCD">
                        계약 종류
                        <select id="agreementCD" name="agreementCD">
                            <c:forEach items="${agreement_list}" var="k">
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
                    <label for="f_email">
                        이메일
                        <input type="text" id="f_email" name="f_email" value="">@
                        <select id="e_emailCD" name="e_emailCD">
                            <c:forEach items="${e_email_list}" var="k">
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
                    <label for="start_date">
                        입사일
                        <input type="date" name="start_date" id="start_date" value="" min="0000-01-01" max="9999-12-31">
                    </label>
                    <label for="">
                        주소
                        <input type="text" id="sample6_postcode" name="zip_code" value="" placeholder="우편번호">
                        <input type="button" onclick="adress_search()" value="우편번호 찾기"><br>
                        <input type="text" id="sample6_address" name="main_adress" value="" placeholder="주소"><br>
                        <input type="text" id="sample6_detailAddress" name="detaill_adress" value="" placeholder="상세주소">
                        <input type="text" id="sample6_extraAddress" name="extra_adress" value="" placeholder="참고항목">
                    </label>
                    <label for="last_date">
                        퇴사일
                        <input type="date" name="last_date" value="" id="last_date" min="0000-01-01" max="9999-12-31">
                    </label>
                    <label for="employment_statusCD">
                        재직 상태
                        <select id="employment_statusCD" name="employment_statusCD">
                            <c:forEach items="${employment_status_list}" var="k">
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
            </article>
            <article>
                <div id="emp_skill">
                    <c:forEach var="k" items="${skill_list}">
                        <c:choose>
                            <c:when test="${k.classification_code == ''}" >
                            </c:when>
                            <c:otherwise>
                                <input type="checkbox" name="skillCD" value="${k.classification_code}"><span>${k.code_name}</span>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </div>
            </article>
            <article>
                <textarea name="note" value="" id="note"></textarea>
            </article>
            <input type="button" value="사원 등록" onclick="emp_insert_go(this)">
        </section>
        <script>
            // 삽입 함수
            function insert_ajax(data){
                for (let pair of data.entries()) {
                    console.log(pair[0]+ ', '+ pair[1]); 
                }
                $.ajax({
                    type: "post",
                    url: "emp_insert",
                    data: data,
                    contentType: false,
                    processData: false,
                    dataType: "json",
                    success: function (res) {
                        if(res != null){
                            let dl_area = $(".dl_area");
                            dl_area.empty()
                            dl_area.load("/employee/emp_detail",{param: res})
                        }
                    },
                    error: function(error) {
                        console.error('Error:', error);
                    }
                });
            }

            // 유효성 검사 및 데이터 담기
            function emp_insert_go(section){
                let formData = new FormData();
                let insert_section = $(section).closest('section');

                let input_texts = insert_section.find('input[type="text"]');
                let input_dates = insert_section.find('input[type="date"]');
                let checkboxs = insert_section.find('input[type="checkbox"]').filter(':checked');
                let selects = insert_section.find('select');
                let input_img = insert_section.find('input[name="img_file"]');
                let input_note = insert_section.find('textarea[name="note"]');
                
            
                let input_name = insert_section.find('input[name="emp_name"]');
                let input_f_resident_num = insert_section.find('input[name="f_resident_num"]');
                let input_b_resident_num = insert_section.find('input[name="b_resident_num"]');
                let input_f_phone = insert_section.find('input[name="f_phone"]');
                let input_m_phone = insert_section.find('input[name="m_phone"]');
                let input_e_phone = insert_section.find('input[name="e_phone"]');
                let input_genderCD = insert_section.find('select[name="genderCD"]');

                if(input_name.val() == ""){
                    alert("이름을 입력해주세요")
                    input_name.focus()
                    return
                }
                if(input_genderCD.val() ==  ""){
                    alert("성별을 선택해주세요")
                    input_genderCD.focus()
                    return
                }
                if(input_f_resident_num.val() ==  "" || input_f_resident_num.val().length < 6){
                    alert("주민번호 앞 6자리를 입력해주세요")
                    input_f_resident_num.focus()
                    return
                }
                if(input_b_resident_num.val() ==  "" || input_b_resident_num.val().length < 7){
                    alert("주민번호 뒤 7자리를 입력해주세요")
                    input_f_resident_num.focus()
                    return
                }else{
                    formData.append(input_b_resident_num.attr('name'), $(input_b_resident_num).val());
                }
                if(input_f_phone.val() ==  ""){
                    alert("전화번호 앞자리를 입력해주세요")
                    input_f_phone.focus()
                    return
                }
                if(input_m_phone.val() ==  ""){
                    alert("전화번호 중간 자리를 입력해주세요")
                    input_m_phone.focus()
                    return
                }
                if(input_e_phone.val() ==  ""){
                    alert("전화번호 뒷자리를 입력해주세요")
                    input_e_phone.focus()
                    return
                }
                
                $.each(input_texts, function (idx, k) { 
                    if($(k).attr('name')){
                        formData.append($(k).attr('name'), $(k).val())
                    }
                });
                
                $.each(selects, function (idx, k) { 
                    if($(k).attr('name')){
                        formData.append($(k).attr('name'), $(k).val())
                    }
                });
                
                let chk_val = []
                $.each(checkboxs, function (idx, k) {
                    if($(k).attr('name')){
                        chk_val.push($(k).val())
                    }
                });
                formData.append("skill_list",chk_val)
                
                $.each(input_dates, function (idx, k) { 
                    if($(k).attr('name')){
                        formData.append($(k).attr('name'), $(k).val())
                    }
                });
                if (input_img[0].files.length > 0) {
                    formData.append(input_img.attr('name'), input_img[0].files[0]);
                }
                formData.append(input_note.attr('name'), input_note.val())
                for (let pair of formData.entries()) {
                    console.log(pair[0]+ ', '+ pair[1]); 
                }
                insert_ajax(formData)
            }
            
            // 사원 삽입 이미지 초기화
            function img_reset(){
                $('#emp_insert_img').attr("src","resources/employee_image/default.png");
                $('#insert_img_file').val("")
            }

            // 사원 이미지 미리보기
            function img_chk(img_file){
                let img = img_file.files[0];  // 파일 객체 가져오기
                if (img) {
                    let imgURL = URL.createObjectURL(img);
                    $('#emp_insert_img').attr("src",imgURL);
                }
            }

            // 숫자 입력 체크
            function insert_numChk(num) {
                let value = num.value;
                num.value = value.replace(/\D/g, ''); // 숫자가 아닌 모든 문자를 제거
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