<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<%--CONSTANT--%>
<%@ page import="org.openpaas.paasta.portal.web.user.common.Constants" %>

<!DOCTYPE html>
<html lang="ko">
<head>
        <%--DESIGN_NEW--%>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>PaaS-TA</title>

        <!-- JQUERY -->
        <script type="text/javascript" src="<c:url value='/resources/js/lib/jquery-2.2.4.js' />"></script>
        <script type="text/javascript" src="<c:url value='/resources/js/lib/jquery-ui.js' />"></script>

        <!-- AXIS COMMON -->
        <script type="text/javascript" src="<c:url value='/resources/axisj/lib/AXJ.js' />"></script>

        <%
            String requestURL = request.getAttribute("javax.servlet.forward.request_uri").toString();
            String exceptUrl = "/space/spaceMain";
            String tempExceptUrl = "/org/orgMainTemp";

            if (requestURL.contains(exceptUrl) || requestURL.contains(tempExceptUrl)) {
        %>

            <!-- AXIS COMMON -->
            <link rel="stylesheet" type="text/css" href="<c:url value='/resources/axisj/ui/arongi/AXJ.css' />"/>

            <!-- AXIS UI -->
            <link rel="stylesheet" type="text/css" href="<c:url value='/resources/axisj/ui/arongi/AXInput.css' />"/>
            <link rel="stylesheet" type="text/css" href="<c:url value='/resources/axisj/ui/arongi/AXSelect.css' />"/>
            <link rel="stylesheet" type="text/css" href="<c:url value='/resources/axisj/ui/arongi/AXGrid.css' />"/>
            <script type="text/javascript" src="<c:url value='/resources/axisj/lib/AXInput.js' />"></script>
            <script type="text/javascript" src="<c:url value='/resources/axisj/lib/AXSelect.js' />"></script>
            <script type="text/javascript" src="<c:url value='/resources/axisj/lib/AXGrid.js' />"></script>

        <%
            }
        %>

        <!-- BOOTSTRAP -->
        <link href="<c:url value='/resources/css/bootstrap.css' />" rel="stylesheet">
        <script type="text/javascript" src="<c:url value='/resources/bootstrap/js/bootstrap.js' />"></script>

        <!-- CSS -->
        <link rel="stylesheet" href="<c:url value='/resources/css/common.css' />">
        <link rel="stylesheet" href="<c:url value='/resources/css/dashboard.css' />">
        <%--<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css">--%>
        <link rel="stylesheet" href="<c:url value='/resources/css/custom-common.css' />">

        <!-- JS -->
        <script type="text/javascript" src="<c:url value='/resources/js/common.js' />"></script>
        <script type="text/javascript" src="<c:url value='/resources/js/spin.js' />"></script>

        <style>
            body {
                font-family: "Spoqa Han Sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
                background-color: #ffffff;
            }
        </style>
        <%--DESIGN_NEW--%>
</head>

<script type="text/javascript">

    var id = "<%=session.getAttribute("id")%>";
    var currentOrg = "<%=session.getAttribute("currentOrg")%>";
    var currentSpace = "<%=session.getAttribute("currentSpace")%>";
    var currentApp = "<%=session.getAttribute("currentApp")%>";
    var currentAppGuid = "<%=session.getAttribute("currentAppGuid")%>";
    var isOrgManaged;

    /*COMMON VALUE*/
    var RESULT_STATUS_SUCCESS = "<%= Constants.RESULT_STATUS_SUCCESS %>";
    var RESULT_STATUS_FAIL = "<%= Constants.RESULT_STATUS_FAIL %>";
    var RESULT_STATUS_FAIL_DUPLICATED = "<%= Constants.RESULT_STATUS_FAIL_DUPLICATED %>";

    var CUD_C = "<%= Constants.CUD_C%>";
    var CUD_U = "<%= Constants.CUD_U%>";
    var USE_YN_Y = "<%= Constants.USE_YN_Y %>";
    var USE_YN_N = "<%= Constants.USE_YN_N %>";

    var RESULT_STATUS_SUCCESS_MESSAGE = "<spring:message code='common.info.result.success' />";
    var RESULT_STATUS_FAIL_MESSAGE = "<spring:message code='common.system.error.message' />";
    var INFO_EMPTY_REQUEST_DATA = "<spring:message code='common.info.empty.req.data' />";

</script>

<body>

<%--TOP MENU--%>
<sec:authentication var="role" property="principal.username"/>
<nav class="navbar navbar-fixed-top">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="javascript:void(0);" onclick="procMovePage('<c:url value='/org/orgMain'/>')"><img src="<c:url value='/resources/images/logo.png' />"/></a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul id="navbarMenuList" class="nav navbar-nav navbar-right">
            </ul>

        </div>
    </div>
</nav>
