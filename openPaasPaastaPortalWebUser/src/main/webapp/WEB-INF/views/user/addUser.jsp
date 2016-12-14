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

    <c:if test="${not empty success}">
        <meta http-equiv="refresh" content="5;url=/login"/>
    </c:if>

    <style>
        body {
            font-family: "Spoqa Han Sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
            background-color: #ffffff;
        }
    </style>
</head>
<body>
<form name='login' action="<c:url value='/requestEmailAuthentication' />" method='POST'>
    <fieldset>
        <div class="logoback mt80 text-center">
            <span><img style="margin-top:40px;" src="<c:url value='/resources/images/user_biglogo.png' />"></span>
        </div>
        <div class="w800px text-center">
            <c:if test="${not empty success}">
                <div class="form-group text-center mt65 ">
                    <div><span class="login-font">인증 이메일 발송 완료.</span></div>
                    <div class="mt5"><span class="login-font2">이메일을 확인하시기 바랍니다.<br> 5초 후 로그인 페이지로 이동합니다.</span></div>
                </div>
            </c:if>
            <c:if test="${empty success}">
                <div class="form-group text-center mt65 ">
                    <div><span class="login-font">계정을 생성하세요.</span></div>
                    <div class="mt5"><span class="login-font2">계정으로 사용할 이메일을 입력하세요.<br>인증 완료 후 계정을 생성 할 수 있습니다.</span></div>
                </div>
                <div class="text-center mt15">
                    <input class="login-form" placeholder="yourmail@example.com" name="id" type="email" value="${id}" required="required" maxlength="100"
                           pattern="^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$">
                </div>
                <c:if test="${not empty error}">
                    <div style="color: red">${error}</div>
                </c:if>
                <c:if test="${empty error}">
                    <div>&nbsp;</div>
                </c:if>
            </c:if>
            <div class="text-center w340px" style="margin: 10px auto 0;">
                <span class="span-right" ><a id="createAcount" style="color:#faa51b;" href="<c:url value='/login' />">로그인</a></span>
            </div>
            <c:if test="${empty success}">
                <div class="text-center mt80">
                    <button type="submit" class="btn btn-primary btn-lg" style="width:180px; background-color:#faa51b; border-color:#faa51b; font-weight: normal;">인증메일보내기</button>
                </div>
            </c:if>
        </div>
    </fieldset>
</form>
</body>
</html>