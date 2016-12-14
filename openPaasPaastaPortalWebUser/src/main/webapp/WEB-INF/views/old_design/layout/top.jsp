<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<%--CONSTANT--%>
<%@ page import="org.openpaas.paasta.portal.web.user.common.Constants" %>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <!-- axis 공통요소 -->
    <script type="text/javascript" src="//code.jquery.com/jquery-2.2.4.js"></script>
    <script type="text/javascript" src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
    <link rel="stylesheet" type="text/css" href="/resources/axisj/ui/arongi/AXJ.css"/>
    <script type="text/javascript" src="/resources/axisj/lib/AXJ.js"></script>

    <!-- axis 추가하는 UI 요소 -->
    <link rel="stylesheet" type="text/css" href="/resources/axisj/ui/arongi/AXInput.css"/>
    <link rel="stylesheet" type="text/css" href="/resources/axisj/ui/arongi/AXSelect.css"/>
    <link rel="stylesheet" type="text/css" href="/resources/axisj/ui/arongi/AXGrid.css"/>
    <script type="text/javascript" src="/resources/axisj/lib/AXInput.js"></script>
    <script type="text/javascript" src="/resources/axisj/lib/AXSelect.js"></script>
    <script type="text/javascript" src="/resources/axisj/lib/AXGrid.js"></script>



    <!-- 공통 css -->
    <link href="/resources/css/bootstrap.css" rel="stylesheet">
    <link href="/resources/css/common.css" rel="stylesheet">
    <link href="/resources/css/dashboard.css" rel="stylesheet">


    <!-- 공통 js -->
    <script type="text/javascript" src="/resources/js/common.js"></script>
    <script type="text/javascript" src="/resources/js/spin.js"></script>


    <!-- bootstrap -->
    <script type="text/javascript" src="/resources/bootstrap/js/bootstrap.js"></script>

    <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css">

</head>
<script>
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

    var RESULT_STATUS_SUCCESS_MESSAGE = "<spring:message code='common.info.result.success' />";
    var RESULT_STATUS_FAIL_MESSAGE = "<spring:message code='common.system.error.message' />";
    var INFO_EMPTY_REQUEST_DATA = "<spring:message code='common.info.empty.req.data' />";

    // GET TOP MENU LIST
    procGetTopMenuList();

</script>

<body>

<sec:authentication var="role" property="principal.username"/>
<nav class="navbar navbar-fixed-top" id="top">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="/org/orgMain"><img src="/resources/images/logo.png"></a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul id="navbarMenuList" class="nav navbar-nav navbar-right">
            </ul>
        </div>
    </div>
</nav>