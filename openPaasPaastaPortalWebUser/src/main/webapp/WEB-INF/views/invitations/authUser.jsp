<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<script type="text/javascript" src="//code.jquery.com/jquery-2.2.4.js"></script>
<head>
    <title>PaaSTA</title>
    <!-- Bootstrap -->
    <link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <%--<c:if test="${not empty success}">--%>
        <%--<meta http-equiv="refresh" content="5;url=/"/>--%>
    <%--</c:if>--%>
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
        <form name='login' action="<c:url value='/user/authUpdateUser'/>" method='POST'>
            <fieldset>
                <div class="panel">
                    <div class="panel-heading" style="background-color: rgb(249, 161, 27)">
                        <div class="panel-title text-center" style="background-color: rgb(249, 161, 27)"><img
                                src="/resources/images/logo.png"></div>
                    </div>

                    <c:if test="${not empty success}">
                        <div class="panel-body">
                            <div class="form-group text-left">
                                <h3>인증 이메일 발송 완료.</h3><br>
                                <h4>이메일을 확인하시기 바랍니다.</h4>
                                <h4 style="color : red">5초 후 로그인 페이지로 이동합니다.</h4><br>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${empty success}">
                        <div class="panel-body">
                            <div class="form-group text-left">
                                <h3>계정을 생성하세요.</h3>
                                <h4>사용자 정보를 입력하세요.</h4><br>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-4" style="text-align: inherit;">이&nbsp; &nbsp;메&nbsp;
                                    &nbsp;일 :</label>
                                <div class="col-sm-8">
                                    <input class="form-control" style="text-align: left;" name="userId" readonly value="${userId}"> </input>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-4" style="text-align: inherit;">이&nbsp;
                                    &nbsp;름:</label>
                                <div class="col-sm-8">
                                    <input type="text" maxlength="100" class="form-control" id="username" name ="username" required="required">
                                    <input type="hidden" class="form-control" id="status" name ="status" value="1">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-4" for="confirmPasswordInput">비밀번호:</label>
                                <div class="col-sm-8">
                                    <input type="password" maxlength="100" class="form-control" id="newPasswordInput" name="password">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-4">비밀번호 확인:</label>
                                <div class="col-sm-8">
                                    <input type="password" maxlength="100" class="form-control" id="confirmPasswordInput">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-4" style="height:25px"></label>
                                <div class="col-sm-8">
                                    <c:if test="${empty error}">
                                        <div style="color: red">${error}</div>
                                    </c:if>
                                    <p id="passwordNotConfirmedAlert" style="color: red; display:none">
                                        <span class="glyphicon glyphicon-ban-circle">입력한 비밀 번호와 일치하지 않습니다.</span>
                                    </p>
                                </div>
                            </div>
                            <div class="form-group" style="padding-bottom: 15px">
                                <button type="submt" class="btn btn-login btn-lg btn-block" id="authEmail">
                                    계정생성
                                </button>
                            </div>
                        </div>
                    </c:if>

                </div>
            </fieldset>
        </form>
        <div>
            <span class="span-left"><a href="/">홈페이지 가기</a></span>
            <span class="span-right"><a href="/login">로그인</a></span>
        </div>

    </div>
</div>
</body>
</html>
<script>
    $(document).ready(function () {

        $("#confirmPasswordInput").keyup(function () {
            password_validation_check($(this).val());
        });
    });
    <!-- validation -->
    function password_validation_check(confimPassword) {
        var result = true;

        var passwordNotConfirmedAlert = $("#passwordNotConfirmedAlert");

        if (confimPassword != $("#newPasswordInput").val()) {
            result = false;
            passwordNotConfirmedAlert.show();
        } else {
            result = true;
            passwordNotConfirmedAlert.hide();
        }

        return result;
    }


</script>