<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>JSP_PROJECT</title>
        <!-- Jquery -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

        <%-- CSS --%>
        <link rel="stylesheet" type="text/css" href="resources/common/reset.css">
        <link rel="stylesheet" type="text/css" href="resources/common/common_area.css">
        <link rel="stylesheet" type="text/css" href="resources/common/dark_light.css">
        <script>
        </script>
    </head>
    <body>
        <%@ include file="/WEB-INF/view/common/header.jsp"%>
        <section id="common_area">
            <%@ include file="/WEB-INF/view/common/sideBar.jsp"%>
            <section id=content_area>
                <%@ include file="/WEB-INF/view/project/components/project_search.jsp"%>
            </section>
        </section>
    </body>
</html>