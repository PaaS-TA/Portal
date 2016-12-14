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
<form name='login' action="<c:url value='/user/authResetPassword' />" method='POST'>
    <fieldset>
        <div class="logoback mt80 text-center">
            <span><img style="margin-top:40px;" src="<c:url value='/resources/images/user_biglogo.png' />"></span>
        </div>
        <div class="w800px text-center">
            <c:if test="${not empty success}">
                <div class="form-group text-center mt65">
                    <div><span class="login-font2">비밀번호 재설정을 완료하였습니다.</span></div>
                    <div><span class="login-font2" style="color:#ff0000;">5초 후 로그인 페이지로 이동합니다.</span></div>
                </div>
            </c:if>
            <c:if test="${empty success}">
                <div class="form-group text-center mt65 ">
                    <div><span class="login-font">비밀번호 재설정</span></div>

                    <div class="text-center mt20 mb5">
                        <p style="margin-left:-130px; color:#a7a7a7;">${userId}</p>
                        <input type="hidden" name="userId" value="${userId}" />
                    </div>
                    <div class="text-center">
                        <input class="login-form" placeholder="새 비밀번호" type="password" maxlength="100" id="newPasswordInput" name ="password">
                    </div>
                    <div class="text-center">
                        <input class="login-form" placeholder="새 비밀번호 확인" type="password" maxlength="100" id="confirmPasswordInput">
                    </div>
                    <div id="passwordNotConfirmedAlert" class="text-center mt15 alert alert-danger" style="width: 45%; height: 28px; display:none;">
                        <span class="glyphicon glyphicon-warning-sign"></span><span style="padding-left: 7px; font-size: 13px;">입력한 비밀 번호와 일치하지 않습니다.</span>
                    </div>
                </div>
                <c:if test="${not empty error}">
                    <div style="color: red">${error}</div>
                </c:if>
                <c:if test="${empty error}">
                    <div>&nbsp;</div>
                </c:if>
            </c:if>
            <div class="text-center w340px" style="margin: 10px auto 0;">
                <span class="span-left" ><a href="<c:url value='/' />" style="color:#faa51b;">홈페이지가기</a></span>
                <span class="span-right" ><a href="<c:url value='/login' />" style="color:#faa51b;">로그인</a></span>
            </div>
            <c:if test="${empty success}">
                <div class="text-center mt80">
                    <button id="authPassword" type="submit" class="btn btn-primary btn-lg" style="width: 180px; background-color: #faa51b; border-color:#faa51b; font-weight: normal;">변경하기</button>
                </div>
            </c:if>
        </div>
    </fieldset>
</form>
<script>
    $(document).ready(function () {

        $("#confirmPasswordInput").keyup(function () {
            password_validation_check($(this).val());
        });
        $("#updatePassword").click(function (){

            var newPassword = $("#confirmPasswordInput").val();

            if( password_validation_check(newPassword) ) {
                var user_id = $("#userId").val();
                console.log("user id: " + user_id);
                var param = {
                    oldPassword : "",
                    password : newPassword
                };

                updatePassword('admin', param);
            }
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
    function updatePassword(user_id, body) {

        var url = "/user/updateUserPassword/"+user_id;

        $.ajax({
            url: url,
            method: "PUT",
            data: JSON.stringify(body),
            dataType: 'json',
            contentType: "application/json",
            success: function (data){

            },
            error: function (xhr,status,error){
                alert("fail",JSON.parse(xhr.responseText).message);
            }
        });
    }

</script>
</body>
</html>