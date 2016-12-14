<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- axis 공통요소 -->
    <link rel="stylesheet" type="text/css" href="/resources/axisj/ui/arongi/AXJ.css"/>
    <script type="text/javascript" src="/resources/axisj/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="/resources/axisj/lib/AXJ.js"></script>

    <!-- axis 추가하는 UI 요소 -->
    <link rel="stylesheet" type="text/css" href="/resources/axisj/ui/arongi/AXInput.css"/>
    <link rel="stylesheet" type="text/css" href="/resources/axisj/ui/arongi/AXSelect.css"/>
    <link rel="stylesheet" type="text/css" href="/resources/axisj/ui/arongi/AXGrid.css"/>
    <script type="text/javascript" src="/resources/axisj/lib/AXInput.js"></script>
    <script type="text/javascript" src="/resources/axisj/lib/AXSelect.js"></script>
    <script type="text/javascript" src="/resources/axisj/lib/AXGrid.js"></script>

    <!-- 공통js -->
    <script type="text/javascript" src="/resources/js/common.js"></script>

    <style>
        .container {
            width: 100%;
            borer: 0px
        }

        .top {
            background: darkslategray;
            height: 3em;
            width: 100%;
            color: white;
        }

        .bottom {
            background: darkslategray;
            height: 3em;
            bottom: 0;
            width: 100%;
            float: left;
            color: white;
        }

        .left {
            background: darkslategray;
            width: 5em;
            float: left;
            height: 85%;
            width: 220px;
            color: white;
        }

        .content {
            background: white;
            height: 80%;
            width: 80%;
            float: left;
        }

        html, body {
            height: 100%;
        }

        /* unvisited link */
        a:link {
            color: white;
        }

        /* visited link */
        a:visited {
            color: white;
        }

        /* mouse over link */
        a:hover {
            color: white;
        }

        /* selected link */
        a:active {
            color: white;
        }

    </style>
</head>

<body>
<div class="container">
    <div class="top">
        <div style="float: left;font-size: 26px;">PaaS-TA Portal</div>

        <div style="float: left;text-align: right;width: 40%">
                       카탈로그
        </div>
        <div style="float: left;text-align: right;width: 6%">
            도움말
        </div>
        <div style="float: left;text-align: right;width: 7%">
             커뮤니티
        </div>
        <div style="float: left;text-align: right;width: 6%">
           문서
        </div>
        <div style="float: left;text-align: right;width: 6%">
            공지
        </div>
        <div style="float: right;">
            <a href="${pageContext.request.contextPath}/main/userPage">UserPage</a> | <a
                href="${pageContext.request.contextPath}/main/adminPage">AdminPage</a> | <a
                href="javascript:document.getElementById('logout').submit()">Logout</a>
        </div>
    </div>

    <c:url value="/logout" var="logoutUrl"/>
    <form id="logout" action="${logoutUrl}" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    </form>

