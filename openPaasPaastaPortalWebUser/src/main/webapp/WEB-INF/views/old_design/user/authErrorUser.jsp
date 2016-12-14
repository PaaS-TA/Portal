<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<script type="text/javascript" src="//code.jquery.com/jquery-2.2.4.js"></script>
<head>
    <title>PaaSTA</title>
    <link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <meta http-equiv="refresh" content="10;url=/login"/>
    <style>
        body {
            background-color: white;
        }

        #loginbox {
            margin-top: 30px;
        }

        #loginbox > div:first-child {
            padding-bottom: 10px;
        }

        .iconmelon {
            display: block;
            margin: auto;
        }

        #form > div {
            margin-bottom: 25px;
        }

        #form > div:last-child {
            margin-top: 10px;
            margin-bottom: 10px;
        }

        .panel {
            background-color: transparent;
        }

        .panel-body {
            padding-top: 30px;
            background-color: rgba(2555, 255, 255, .3);
        }

        .iconmelon {
            position: relative;
            width: 150px;
            height: 150px;
            display: block;
            fill: #525151;
        }

        .iconmelon:after :after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
        }

        .btn-login {
            color: #fff;
            border-color: rgb(249, 161, 27);
            background-color: rgb(249, 161, 27)
        }

        .span-left {
            float: left;
        }

        .span-right {
            float: right;
        }
    </style>

</head>
<body>
<div id="loginbox" class="mainbox col-md-6 col-md-offset-3 col-sm-6 col-sm-offset-3">
    <div class="row">
        <div class="iconmelon"></div>
    </div>
    <div>
        <form name='login' action="<c:url value='/user/authUpdateUser/'/>" method='GET'>
            <fieldset>
                <div class="panel">
                    <div class="panel-heading" style="background-color: rgb(249, 161, 27)">
                        <div class="panel-title text-center" style="background-color: rgb(249, 161, 27)"><img
                                src="/resources/images/logo.png"></div>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="panel-body">
                            <div class="form-group text-left">
                                <h4>${error}</h4><br>
                                <h4>이메일을 확인하시기 바랍니다.</h4>
                                <h4 style="color : red">10초 후 로그인 페이지로 이동합니다.</h4><br>
                            </div>
                        </div>
                    </c:if>
                </div>
            </fieldset>
        </form>
        <div>
            <span class="span-left"><a href="/">홈페이지 가기</a></span>
            <span class="span-right"><a href="/">로그인</a></span>
        </div>

    </div>
</div>
</body>
</html>
