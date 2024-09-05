<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
    </head>
    <body>
        <section id-="project_emp_info_section">
            <article id="project_emp_info_emp">
                <div>이름 : 아무개</div>
                <div>전화번호 : 아무개</div>
                <div>개발분야 : 아무개</div>
                <div>직급 : 아무개</div>
            </article>
            <article id="project_emp_info_project">
                <label for="in_date">
                    투입일
                    <input type="date" id="in_date" name="in_date">
                </label>
                <label for="out_date">
                    투입일
                    <input type="date" id="out_date" name="out_date">
                <fieldset>
                    <legend>비고</legend>
                    <textarea name="note" id="note" value=""></textarea>
                </fieldset>
            </article>
        </section>
    </body>
    </html>