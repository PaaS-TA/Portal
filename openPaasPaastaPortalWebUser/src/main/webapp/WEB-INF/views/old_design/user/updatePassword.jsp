<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@include file="../layout/top.jsp" %>
<%@include file="../layout/left.jsp" %>
<%@include file="../layout/alert.jsp" %>

<script>
    $(document).ready(function(){
        $("#updatePassword").click(function(){

            var oldPassword = $("#currentPasswordInput").val();
            var newPassword = $("#confirmPasswordInput").val();

            if( password_validation_check(newPassword) ) {
                var user_id = $("#userId").val();
                console.log("user id: " + user_id);
                var param = {
                    oldPassword : oldPassword,
                    password : newPassword
                };

                updatePassword(user_id, param);
            }
        });

        $("#confirmPasswordInput").keyup(function(){
            password_validation_check($(this).val());
        });
    });

    <!-- ajax -->
    function updatePassword(user_id, body) {

        var url = "/user/updateUserPassword/"+user_id;

        $.ajax({
            url: url,
            method: "PUT",
            data: JSON.stringify(body),
            dataType: 'json',
            contentType: "application/json",
            success: function(data){
                $("#logout").submit();
            },
            error: function(xhr,status,error){
                showAlert("fail",JSON.parse(xhr.responseText).message);
            }
        });
    }

    <!-- validation -->
    function password_validation_check(confimPassword) {
        var result = true;

        var passwordNotConfirmedAlert = $("#passwordNotConfirmedAlert");

        if( confimPassword != $("#newPasswordInput").val() ) {
            result = false;
            passwordNotConfirmedAlert.show();
        } else {
            result = true;
            passwordNotConfirmedAlert.hide();
        }

        return result;
    }

</script>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

</head>
<form id="user">
    <input type="hidden" id="userId" value=${userId}>
</form>

<div class="col-sm-12" style="padding: 20px 0px 0px 0px;">

    <!-- 비밀번호 변경 -->
    <div class="col-sm-4" style="padding:0px;">

        <h4 style="font-weight:bold">비밀번호 변경</h4>

        <div class="content-box" style="padding:20px 20px; ">
            <form class="form-horizontal" role="form">
                <div class="form-group">
                    <label class="control-label col-sm-4" for="currentPasswordInput">현재 비밀번호</label>
                    <div class="col-sm-8">
                        <input type="password" maxlength="100" class="form-control"  id="currentPasswordInput">
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="confirmPasswordInput">새 비밀번호</label>
                    <div class="col-sm-8">
                        <input type="password" maxlength="100" class="form-control"  id="newPasswordInput">
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4">새 비밀번호 확인</label>
                    <div class="col-sm-8">
                        <input type="password" maxlength="100" class="form-control"  id="confirmPasswordInput">
                        <p id="passwordNotConfirmedAlert" style="color: red; display: none; ">
                            <span class="glyphicon glyphicon-ban-circle"></span>입력한 비밀 번호와 일치하지 않습니다.
                        </p>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-8 col-sm-offset-4">
                    <button type="button" class="btn btn-default btn-md" id="updatePassword">변경하기</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<%@include file="../layout/bottom.jsp" %>