<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@include file="../layout/top.jsp" %>
<%@include file="../layout/left.jsp" %>
<%@include file="../layout/alert.jsp" %>

<script>
    $(document).ready(function (){
        $("#updateEmail").click(function (){

            var newUserId = $("#newUserIdInput").val();

            if( updateEmail_validation_check(newUserId) ) {
                var old_user_id = $("#oldUserId").val();

                var param = {
                    userId : newUserId
                };

                updateEmail(old_user_id, param);
            }
        });

        $("#newUserIdInput").keyup(function (){
            updateEmail_validation_check($(this).val());
        });
    });

    <!-- ajax -->
    function updateEmail(user_id, body) {

        var url = "/user/updateUserEmail/"+user_id;

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
    function updateEmail_validation_check(newUserId) {
        var result = true;
        var validation_email = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;

        var emailValidationAlert = $("#emailValidationAlert");
        var emailConfictAlert = $("#emailConfictAlert");
        var emailAlert = $("#emailOkAlert");

        if( !validation_email.test(newUserId) ) {
            result = false;
            emailConfictAlert.hide();
            emailAlert.hide();
            emailValidationAlert.show();
        } else if( newUserId == $("#oldUserId").val() ) {
            result = false;
            emailValidationAlert.hide();
            emailAlert.hide();
            emailConfictAlert.show();
        }

        if( result ) {
            emailValidationAlert.hide();
            emailConfictAlert.hide();
            emailAlert.show();
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
    <input type="hidden" id="oldUserId" value=${oldUserId}>
</form>

<div class="row" style="min-height: 600px;">
    <div class="panel content-box col-sm-3 col-md-6" style="margin-top:150px; margin-left:380px;">
        <div class="col-sm-6 pt0">
            <h4 class="modify_h4 fwb mt10">이메일 변경</h4>
        </div>

        <div style="padding:80px 5px 20px;margin-left:80px; ">

            <form class="form-horizontal" role="form">
                <div class="form-group">
                    <label class="control-label col-sm-3" style="width:130px"> <span
                            style="font-weight:normal; font-size:15px;">현재 이메일</span></label>
                    <label class="control-label col-sm-9" style="text-align: left;width:60%"> ${oldUserId}</label>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-3" for="newUserIdInput" style="width:130px"><span
                            style="font-weight:normal; font-size:15px">변경할 이메일</span></label>
                    <div class="col-sm-9" style="text-align: left;width:60%">
                        <input class="form-control" type="text" maxlength="100" id="newUserIdInput">
                        <p id="emailValidationAlert" style="color: red; display: none;" ><span class="glyphicon glyphicon-ban-circle"></span> 이메일 형식이 올바르지 않습니다.</p>
                        <p id="emailConfictAlert" style="color: red; display: none; " ><span class="glyphicon glyphicon-ban-circle"></span> 기존 이메일과 동일합니다.</p>
                        <p id="emailOkAlert" style="color: green; display: none;" ><span class="glyphicon glyphicon-ok-circle"></span> 사용할 수 있는 이메일 입니다.</p>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-9 col-sm-offset-3">
                        <br>
                        <button type="button" class="btn btn-cancel btn-sm" id="updateEmail">인증하기</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<%@include file="../layout/bottom.jsp" %>