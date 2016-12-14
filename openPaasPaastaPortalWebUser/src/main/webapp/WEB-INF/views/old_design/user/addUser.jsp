<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>PaaSTA</title>
    <!-- Bootstrap -->
    <link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <c:if test="${not empty success}">
        <meta http-equiv="refresh" content="5;url=/login"/>
    </c:if>
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
    </style>

</head>
<body>
<div class="container">
    <div id="loginbox" class="mainbox col-md-6 col-md-offset-3 col-sm-6 col-sm-offset-3">
        <div class="row">
            <div class="iconmelon">
            </div>
        </div>
        <form name='login' action="<c:url value='/requestEmailAuthentication' />" method='POST'>
            <fieldset>
                <div class="panel">
                    <div class="panel-heading" style="background-color: rgb(249, 161, 27)">
                        <div class="panel-title text-center" style="background-color: rgb(249, 161, 27)"><img
                                src="/resources/images/logo.png"></div>
                    </div>
                    <c:if test="${not empty success}">
                    <div>
                        <div class="panel-body">
                            <div class="form-group text-center">
                                <h3>인증 이메일 발송 완료.</h3><br>
                                <h4>이메일을 확인하시기 바랍니다.</h4>
                                <h4 style="color : red">5초 후 로그인 페이지로 이동합니다.</h4><br>
                                </P>
                            </div>
                        </div>
                        </c:if>
                        <c:if test="${empty success}">
                        <div>
                            <div class="panel-body">
                                <div class="form-group text-center">
                                    <h3>계정을 생성하세요.</h3><br>
                                    <h4>계정으로 사용할 이메일을 입력하세요.</h4>
                                    <h4>인증 완료 후 계정을 생성 할 수 있습니다.</h4><br>
                                    </P>
                                </div>
                                <div class="form-group">
                                    <input class="form-control" style="align-items: center;"
                                           placeholder="sample@example.com" name="id" type="email"
                                           value="${id}"
                                           required="required"
                                           <%--pattern="^[a-zA-Z0-9-\_.]+@[a-zA-Z0-9-\_.]+\.[a-zA-Z0-9.]{2,5}$">--%>
                                           pattern="^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$">
                                </div>
                                <c:if test="${not empty error}">
                                    <div style="color: red">${error}</div>
                                </c:if>
                                <c:if test="${empty error}">
                                    <div>&nbsp</div>
                                </c:if>
                                <div>
                                    <input class="btn btn-lg btn-login btn-block" name="submit" type="submit"
                                           value="인증 메일 보내기">

                                </div>
                            </div>
                        </div>
                        </c:if>
                        <div>
                            <span class="btn-block text-right"><a href="/login">로그인</a></span>
                        </div>
            </fieldset>
        </form>
    </div>
</div>
</body>
</html>