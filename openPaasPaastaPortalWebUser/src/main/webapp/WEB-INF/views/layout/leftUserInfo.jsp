<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="userinfo">
    <sec:authentication property="principal.imgPath" var="imgPath"/>
    <c:choose>
        <c:when test="${not empty imgPath}"><img class="circle" id="left_profileImagePath" src="<c:url value='${imgPath}'/>" alt="사용자"/></c:when>
        <c:otherwise><img class="circle" id="left_profileImagePath" src="<c:url value='/resources/images/userpic.png'/>" alt="사용자"/></c:otherwise>
    </c:choose>
    <div class="name" id="left_username"><sec:authentication property="principal.name" /></div>
    <div class="dropdown">
        <a class="mail dropdown-toggle" data-toggle="dropdown" id="dropdownTopMenu" href="javascript:void(0);">
            <sec:authentication property="principal.username" /><span class="caret"></span>
        </a>
        <ul class="left-menu-dropdown-menu" role="menu" aria-labelledby="dropdownTopMenu">
            <li role="presentation"><a role="menuitem" href="javascript:void(0);" onClick="alertList();">알림</a></li>
            <li role="presentation"><a role="menuitem" href="<c:url value='/user/myPage' />">내 계정</a></li>
            <li role="presentation"><a role="menuitem" href="<c:url value='/myQuestion/myQuestionMain' />">내 문의</a></li>
            <li role="presentation"><a href="javascript:document.getElementById('logout').submit()">로그아웃</a></li>
        </ul>

        <c:url value="/logout" var="logoutUrl"/>
        <form id="logout" action="${logoutUrl}" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>
    </div>
</div>
