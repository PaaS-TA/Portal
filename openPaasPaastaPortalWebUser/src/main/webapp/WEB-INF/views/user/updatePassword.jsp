<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@include file="../layout/top.jsp" %>
<%@include file="../layout/left.jsp" %>
<%@include file="../layout/alert.jsp" %>

<form id="user">
    <input type="hidden" id="userId" value=${userId}>
</form>

<div class="row" style="min-height: 600px;">
    <div class="panel content-box col-sm-3 col-md-6" style="margin-top:150px; margin-left:380px;">
        <div class="col-sm-6 pt0">
            <h4 class="modify_h4 fwb mt10">비밀번호 변경</h4>
        </div>

        <div style="padding:80px 5px 20px;margin-left:120px; ">
            <form class="form-horizontal" role="form">
                <div class="form-group">
                    <label class="control-label col-sm-3" for="currentPasswordInput"><span style="font-weight:normal; font-size:15px;">현재 비밀번호</span></label>
                    <div class="col-sm-8">
                        <input type="password" maxlength="100" class="form-control3"  id="currentPasswordInput">
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-3" for="newPasswordInput"><span style="font-weight:normal; font-size:15px;">새 비밀번호</span></label>
                    <div class="col-sm-8">
                        <input type="password" maxlength="100" class="form-control3" id="newPasswordInput">
                    </div>
                </div>
                <div class="form-group" style="min-height: 80px;">
                    <label class="control-label col-sm-3" for="confirmPasswordInput"><span style="font-weight:normal; font-size:15px;">새 비밀번호 확인</span></label>
                    <div class="col-sm-8">
                        <input type="password" maxlength="100" class="form-control3"  id="confirmPasswordInput">
                        <p id="passwordNotConfirmedAlert" style="margin: 10px 0 0 0; color: red; display: none; ">
                            <span class="glyphicon glyphicon-ban-circle"></span>입력한 비밀 번호와 일치하지 않습니다.
                        </p>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-6 tar">
                        <button type="button" class="btn btn-cancel btn-sm" id="updatePassword">변경하기</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    $(document).ready(function (){
        $("#updatePassword").click(function (){

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

        $("#confirmPasswordInput").keyup(function (){
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
            success: function (data){
                $("#logout").submit();
            },
            error: function (xhr,status,error){
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

<%@include file="../layout/bottom.jsp" %>