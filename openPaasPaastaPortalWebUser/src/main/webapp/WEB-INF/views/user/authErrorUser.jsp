<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <meta http-equiv="refresh" content="10;url=/login"/>

    <title>PaaS-TA</title>

    <!-- JQUERY -->
    <script type="text/javascript" src="<c:url value='/resources/js/lib/jquery-2.2.4.js' />"></script>
    <script type="text/javascript" src="<c:url value='/resources/js/lib/jquery-ui.js' />"></script>

    <!-- BOOTSTRAP -->
    <link href="<c:url value='/resources/css/bootstrap.css' />" rel="stylesheet">
    <script type="text/javascript" src="<c:url value='/resources/bootstrap/js/bootstrap.js' />"></script>

    <%--CSS--%>
    <link rel="stylesheet" href="<c:url value='/resources/css/common.css' />">
    <link rel="stylesheet" href="<c:url value='/resources/css/dashboard.css' />">

    <style>
        body {
            font-family: "Spoqa Han Sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
            background-color: #ffffff;
        }
    </style>
</head>
<body>
<div class="logoback mt80 text-center">
    <span><img style="margin-top:40px;" src="<c:url value='/resources/images/user_biglogo.png' />"></span>
</div>
<div class="w800px text-center">
    <div class="form-group text-center mt65">
        <div><span class="login-font2" style="color:#ff0000;">${error}</span></div>
        <div><span class="login-font2">이메일을 확인하시기 바랍니다.</span></div>
        <div><span class="login-font2">10초 후 로그인 페이지로 이동합니다.</span></div>
    </div>
    <div class="text-center w340px" style="margin: 20px auto 0;">
        <span class="span-left" ><a href="<c:url value='/' />" style="color:#faa51b;">홈페이지가기</a></span>
        <span class="span-right" ><a href="<c:url value='/login' />" style="color:#faa51b;">로그인</a></span>
    </div>
</div>
</body>
</html>
