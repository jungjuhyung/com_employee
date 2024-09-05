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
        <form action="customer_insert_pop" method="post">
            <label for="customer_name">
                고객사명
                <input type="text" name="customer_name" id="customer_name" value="" required placeholder="고객사명">
            </label>
            <label for="main_num">
                대표 번호
                <input type="text" name="f_phone" id="main_num" class="main_num" value="" maxlength="3" oninput="insert_numChk(this)" required>
                <span>-</span>
                <input type="text" name="m_phone" class="main_num" value="" maxlength="4" oninput="insert_numChk(this)" required>
                <span>-</span>
                <input type="text" name="e_phone" class="main_num" value="" maxlength="4" oninput="insert_numChk(this)" required>
            </label>
            <div>
                <label for="fieldCD">
                    고객사 계열
                    <select id="divisionCD" name="divisionCD" required>
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
                    <select id="sizeCD" name="sizeCD" required>
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
                    <select id="businessCD" name="businessCD" required>
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
            <div>
                <fieldset>
                    <legend>비고</legend>
                    <textarea name="note" id="note"></textarea>
                </fieldset>
            </div>
            <input type="submit" value="등록하기">
            <input type="button" value="이전" onclick="search_customer_pop_in()">
        </form>
        <script>
            function search_customer_pop_in(){
                location.href = "/employee/customer_search_pop_in"
            }
            // 숫자 입력 체크
            function insert_numChk(num) {
                let value = num.value;
                num.value = value.replace(/\D/g, '');
            }
        </script>
        
    </body>
</html>