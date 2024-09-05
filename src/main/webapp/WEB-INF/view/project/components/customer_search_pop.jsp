<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    </head>
    <body>
        <form>
            <label for="customer_name">
                고객사명
                <input type="text" name="customer_name" id="customer_name" value="" placeholder="고객사명">
            </label>
            <div>
                <label for="fieldCD">
                    고객사 계열
                    <select id="divisionCD" name="divisionCD">
                        <c:forEach items="${division_list}" var="k">
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
                <label for="sizeCD">
                    고객사 규모
                    <select id="sizeCD" name="sizeCD">
                        <c:forEach items="${size_list}" var="k">
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
                <label for="businessCD">
                    사업 구분
                    <select id="businessCD" name="businessCD">
                        <c:forEach items="${business_list}" var="k">
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
            <input type="button" value="검색" onclick="project_search_pop(this.form)">
            <input type="button" value="검색 초기화" onclick="reset_form(this.form)">
        </form>
        <div id="search_customer_area">
            <table>
                <caption>고객사 검색</caption>
                <thead>
                    <tr>
                        <th>고객사명</th>
                        <th>계열</th>
                        <th>규모</th>
                        <th>사업 구분</th>
                        <th>대표 번호</th>
                        <th>등록일</th>
                        <th>선택</th>
                    </tr>
                </thead>
                <tbody id="search_customer_tbody">
                    <tr>
                        <td colspan="7">검색해주세요</td>
                    </tr>
                </tbody>
            </table>
            <input type="button" value="고객사 등록" onclick="customer_insert_pop()">
            <div id="customer_search_paging_area">
            </div>
        </div>
        <script>
            customer_search_data={}
            // 검색 ajax
            function project_search_pop_ajax(cpage_v){
                if(typeof cpage_v =="undefined"){
                    customer_search_data["cpage"] = null
                }else{
                    customer_search_data["cpage"] = cpage_v
                }
                $.ajax({
                    type: "post",
                    url: "customer_search_pop_ajax",
                    contentType: "application/json",
                    data: JSON.stringify(customer_search_data),
                    dataType: "json",
                    success: function (res) {
                        let tbody = $("#search_customer_tbody")
                        let paging_area = $("#customer_search_paging_area")
                        paging_area.empty()
                        tbody.empty()
                        $.each(res.cus_list, function (idx, k) {
                            let tr = $("<tr>")
                            tr.append($("<td>").attr("name","customer_name").text(k.customer_name));
                            tr.append($("<td>").attr("name","division").text(k.division));
                            tr.append($("<td>").attr("name","size").text(k.size));
                            tr.append($("<td>").attr("name","business").text(k.business));
                            tr.append($("<td>").attr("name","main_num").text(k.main_num));
                            tr.append($("<td>").append($('<input type="button" onclick="select_cus_pop('+k.customer_idx+')" value="선택">')))
                            tbody.append(tr) 
                        });
                        paging_area.append(paging(res.paging))
                        customer_search_data = res.cus_opt
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
                        customer_search_data[k.name] = k.value;
                    }
                });
                selects.forEach(k => {
                    if (k.name) {
                        customer_search_data[k.name] = k.value;
                    }
                });
                customer_search_data["cpage"] = "1";
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
            function select_cus_pop(customer_idx){
                let tr = $(event.target).closest("tr")
                window.opener.add_customer_pop(customer_idx, tr.find("[name='customer_name']").text(),tr.find("[name='main_num']").text())
                window.close()
            }

            function customer_insert_pop(){
                location.href="/employee/customer_insert_pop_in"
            }
        </script>
    </body>
</html>