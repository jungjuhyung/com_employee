<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <!-- CSS -->
        <link rel="stylesheet" type="text/css" href="resources/common/sideBar.css">
    </head>
    <body>
        <aside>
            <nav>
                <c:choose>
                    <c:when test="${pageContext.request.requestURI == '/employee/'}">
                        <div data-value="main" style="background-color: gray;" onclick="handlerMenu(this.dataset.value)">
                            메인 대시보드
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div data-value="main" onclick="handlerMenu(this.dataset.value)">
                            메인 대시보드
                        </div>
                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${pageContext.request.requestURI.startsWith('/employee/employee/')}">
                        <div data-value="employee" style="background-color: gray;" onclick="handlerMenu(this.dataset.value)">
                            사원 관리
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div data-value="employee" onclick="handlerMenu(this.dataset.value)">
                            사원 관리
                        </div>
                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${pageContext.request.requestURI.startsWith('/employee/project/')}">
                        <div data-value="project" style="background-color: gray;" onclick="handlerMenu(this.dataset.value)">
                            프로젝트 관리
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div data-value="project" onclick="handlerMenu(this.dataset.value)">
                            프로젝트 관리
                        </div>
                    </c:otherwise>
                </c:choose>
            </nav>
        </aside>
        <script>
            function handlerMenu(menu){
                if(menu == 'main'){
                    location.href = "/employee"
                }else if(menu == 'employee'){
                    location.href = "/employee/employee"
                }else if(menu == 'project'){
                    location.href = "/employee/project"
                }
            }
        </script>
    </body>
</html>