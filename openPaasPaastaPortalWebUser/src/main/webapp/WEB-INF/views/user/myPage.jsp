<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../layout/top.jsp" %>
<%@include file="../layout/left.jsp" %>
<%@include file="../layout/alert.jsp" %>

<form id="user_detail">
    <input type="hidden" id="userId" value=${user.userId}>
    <input type="hidden" id="userName" value="${user.userName}">
    <input type="hidden" id="status" value=${user.status}>
    <input type="hidden" id="address" value=${user.address}>
    <input type="hidden" id="addressDetail" value=${user.addressDetail}>
    <input type="hidden" id="tellPhone" value=${user.tellPhone}>
    <input type="hidden" id="zipCode" value=${user.zipCode}>
    <input type="hidden" id="adminYn" value=${user.adminYn}>
    <input type="hidden" id="imgPath" value=${user.imgPath}>
</form>

<div class="row">
    <div class="col-sm-6 pt0">
        <h4 class="modify_h4 fwb mt10">내 계정</h4>
    </div>
</div>

<div class="row">
    <%--LOGIN INFO--%>
    <div class="panel content-box col-sm-3 col-md-6 col-md-offset-13" style="height:237px;">
        <div class="col-sm-12 pt0 dropdown">
            <div class="fl">
                <h4 class="modify_h4 fwb">로그인정보</h4>
            </div>
            <div class="fr">
                <label class="glyphicon glyphicon-cog dropdown-toggle" id="dropdownMenu1"
                       data-toggle="dropdown" aria-expanded="false" aria-hidden="true" style="float: right; cursor: pointer; font-size: 22px;">
                </label>
                <ul class="dropdown-menu dropdown-menu-right" role="menu" aria-labelledby="dropdownMenu1">
                    <li role="presentation"><a role="menuitem" href="<c:url value='/user/updateUserEmail' />">이메일 변경</a></li>
                    <li role="presentation"><a role="menuitem" href="<c:url value='/user/updateUserPassword' />">비밀번호 변경</a></li>
                </ul>
            </div>
        </div>
        <div style="padding:50px 20px 10px;">
            <form class="form-horizontal" role="form">
                <div class="form-group">
                    <label class="control-label col-md-2 col-sm-4 mt-3" style="width: 11%; text-align: left;font-weight:normal;" for="emailText">이메일</label>
                    <label class="control-label col-md-10 col-sm-8" id="emailText" style="text-align: left; font-weight:normal; border:1px solid #e5e4e4;border-radius:3px; width: 88%; height:31px; padding:4px 15px;">
                        <span class="mt-3" style="color:#bab9b9;">${user.userId}</span>
                    </label>
                </div>
            </form>
        </div>
    </div>

    <%--USER INFO--%>
    <div class="panel content-box col-sm-3 col-md-6 col-md-offset-13">
        <div class="col-sm-12 pt0">
            <h4 class="modify_h4 fwb">사용자정보</h4>
        </div>
        <div class="col-sm-12" style="padding:20px 10px 0 0">
            <div class="col-sm-4">
                <div class="form-group">

                    <a class="user_img" id="userImgUpdate" aria-label="프로필 사진 변경" href="#" onclick="getUploadProfileImgPopup()" >

                        <c:choose>
                            <c:when test="${not empty imgPath}">
                            <img id="userImgDiv" class="circle event-table" style="width:135px; height:135px;" src="<%= Constants.IMAGE_PATH_PREFIX %>${user.imgPath}">
                            </c:when>
                            <c:otherwise>
                            <img id="userImgDiv" class="circle event-table" style="width:135px; height:135px;" src="<c:url value='/resources/images/userpic.png' />">
                            </c:otherwise>
                        </c:choose>

                        <span class="user_img" id="userImgUpdateText" hidden style="width: 135px; padding: 8px 0; font-size: 12px;">변경</span>
                    </a>
                </div>
            </div>
            <div class="col-sm-8">
                <form class="form-horizontal" role="form">
                    <div class="form-group">
                        <label class="control-label col-md-1 col-sm-1" style="width: 20%; text-align: left;font-weight:normal;" for="userNameInput"> 이름 </label>
                        <div class="col-md-5 col-sm-5" style="width: 79%">
                            <input class="form-control4" type="text" id="userNameInput" value="${user.userName}" maxlength="100">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-1 col-sm-1" style="width: 20%; text-align: left;font-weight:normal;" for="tellPhoneInput"> 전화번호 </label>
                        <div class="col-md-5 col-sm-5" style="width: 79%">
                            <input class="form-control4" type="text" id="tellPhoneInput" value="${user.tellPhone}" maxlength="100">
                        </div>
                    </div>
                </form>
                <div class="mt20">
                    <div class="fr">
                        <button type="button" id="deleteUserBtn" class="btn btn-cancel btn-sm mt3">
                            계정삭제
                        </button>
                        <button type="button" id="movePageUsageMain" class="btn btn-orange btn-sm mt3">
                            사용량 조회
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <%--MY QUESTION--%>
    <div class="panel content-box col-sm-3 col-md-6 col-md-offset-13">
        <div class="col-sm-12 pt0">
            <h4 class="modify_h4 fwb">나의문의
                <span class="glyphicon glyphicon-plus" aria-hidden="true" style="float:right; cursor:pointer; font-size:22px;" onclick="procMovePage(MY_QUESTION_INSERT_FORM_URL);"></span>
            </h4>
            <div style="padding:20px 10px 0 0;">
                <form class="form-horizontal" role="form">
                    <ul class="form-group list-group mt-15" id="myQuestions">
                    </ul>
                </form>
            </div>
        </div>
    </div>

    <input type="hidden" id="questionNo" name="questionNo" value="" />
    <input type="hidden" id="filePath" name="filePath" value="" />

    <%--MY ORGANIZATION--%>
    <div class="panel content-box col-sm-3 col-md-6 col-md-offset-13">
        <div class="col-sm-12 pt0">
            <h4 class="modify_h4 fwb">나의조직
                <span class="glyphicon glyphicon-plus" aria-hidden="true" style="float:right; cursor:pointer; font-size:22px;" onclick="goToCreateOrgPage();"></span>
            </h4>
            <div style="padding:20px 10px 0 0;">
                <form class="form-horizontal" role="form">
                    <ul class="form-group list-group" id="myOrgList">
                    </ul>
                    <div align="center" id="showMoreOrgs" style="font-size :16px">
                        <span id="showMoreOrgsIcon" class="glyphicon glyphicon-chevron-down" aria-hidden="false" style="cursor: pointer;"></span>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>

    var MY_QUESTION_INSERT_FORM_URL = "<c:url value='/myQuestion/myQuestionMain/create' />";
    var MY_QUESTION_UPDATE_FORM_URL = "<c:url value='/myQuestion/myQuestionMain/update' />";
    var MY_QUESTION_DETAIL_FORM_URL = "<c:url value='/myQuestion/myQuestionMain/detail' />";
    var DELETE_FILE_PROC_URL = "<c:url value='/myQuestion/deleteFile'/>";
    var DELETE_PROC_URL = "<c:url value='/myQuestion/deleteMyQuestion' />";

    $(document).ready(function () {
        $("#userNameInput").focusout(function (){

            var user_id = $("#userId").val();

            var userNameInput = $("#userNameInput");

            if( updateUserDetail_username_validation_check(userNameInput) ) {
                $("#userName").val(userNameInput.val());

                var param = {
                    userName : userNameInput.val()
                };

                updateUserDetail(user_id, param);
            }
        });

        $("#tellPhoneInput").focusout(function (){

            var user_id = $("#userId").val();
            var tellPhoneInput = $("#tellPhoneInput");

            if( updateUserDetail_tellPhone_validation_check(tellPhoneInput) ) {
                $("#tellPhone").val(tellPhoneInput.val());

                var param = {
                    tellPhone : tellPhoneInput.val()
                };

                updateUserDetail(user_id, param);
            }
        });

        getMyQuestions();

        $('#showMoreOrgs').click(function () {
            if($('#myOrgList li').length > orgPage*5){
                orgPage++;
                $('#myOrgList li:lt('+orgPage*5+')').show();
            } else{
                orgPage = 1;
                $('#myOrgList li').not(':lt('+orgPage*5+')').hide();
            }
            iconChange()
        });

        $("#deleteUserBtn").click(function (){
            showDeleteUserPopUp();
        });

        // MOVE PAGE USAGE MAIN
        $("#movePageUsageMain").on("click", function () {
            procMovePage('<c:url value='/usage/usageMain'/>');
        });

        // USER IMAGE MOUSE EVENT
        $("#userImgUpdate").mouseover(function (){
            $("#userImgUpdateText").show();
        }).mouseout(function (){
            $("#userImgUpdateText").hide();
        });

    });
    <!--End $(document).ready -->

    function removeOrgFromUser(orgName){

        var isRemoveOrgFromUser = true;

        param = {
            orgName:orgName
        };

        $.ajax({
            url: "/org/removeOrgFromUser",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            async: 'false',
            contentType: "application/json",
            success: function (data){
                if(data){
                    getOrgs(isRemoveOrgFromUser)
                }
            },
            error: function (xhr,status,error){
                showAlert("danger", JSON.parse(xhr.responseText).message);
            },
            complete: function () {
                $('#modal').modal('hide');
                $("#myOrgList *").remove()
            }
        });

    }


    <!-- popup -->
    function removeOrgFromUserModal(orgName){
        $("#modalTitle").html("조직 탈퇴");

        var adminYN = '${user.adminYn}';
        var yes = '<%= Constants.USE_YN_Y %>';
        var objModalCancelBtn = $("#modalCancelBtn");
        var objModalExecuteBtn = $("#modalExecuteBtn");

        if (adminYN == yes) {
            $("#modalText").html("관리자는 조직을 탈퇴할 수 없습니다.");
            objModalCancelBtn.text("확인");
            objModalExecuteBtn.hide();
            objModalCancelBtn.show();

            $('#modal').modal('toggle');

        } else {
            $("#modalText").html("조직을 탈퇴하면 조직에 대한 모든 권한을 잃습니다. <br> "+orgName+" 조직에서 모든 권한을 철회하시겠습니까?");
            objModalCancelBtn.text("취소");
            objModalExecuteBtn.text("탈퇴");
            objModalExecuteBtn.show();
            objModalExecuteBtn.attr('onclick', "removeOrgFromUser('"+orgName+"')");

            $('#modal').modal('toggle');
        }
    }

    function showDeleteUserPopUp(){

        var popBody = "계정 삭제를 선택 하면 모든 조직과 공간이 삭제 되며 되돌릴 수 없습니다. <br>" +
                $("#userId").val() + "을(를) 삭제하시겠습니까?" +
                "<table align='center'>" +
                "<tr>" +
                "<td><input type='text' maxlength='100' id='deleteEmailInput' placeholder='이메일 입력'></td>" +
                "</tr>" +
                "<tr>" +
                "<td><input type='password' maxlength='100' id='deletePasswordInput' placeholder='비밀번호 입력'></td>" +
                "</tr>" +
                "</table>";

        //title
        $("#modalTitle").html("계정 삭제");
        //body
        $("#modalText").html(popBody);
        // button
        $("#modalCancelBtn").text("취소");

        var objModalExecuteBtn = $("#modalExecuteBtn");
        objModalExecuteBtn.text("계정삭제");
        objModalExecuteBtn.show();
        objModalExecuteBtn.attr('onclick', "deleteUser_btn_click()");

        $('#modal').modal('toggle');

        $("#deleteEmailInput").click(function (){
            $(this).attr("placeholder", "");
        });
        $("#deletePasswordInput").click(function (){
            $(this).attr("placeholder", "");
        });


    }

    function deleteUser_btn_click() {
        var deleteEmailVal = $("#deleteEmailInput").val();
        var deletePasswordVal = $("#deletePasswordInput").val();

        if (deleteUser_validation_check(deleteEmailVal, deletePasswordVal)) {
            var userId = $("#userId").val();

            var param = {
                password : deletePasswordVal
            };

            deleteUser(userId, param);
        }
    }

    function showUploadProfileImgPopup(popBody) {
        //title
        $("#modalTitle").html("프로필 사진 변경");
        //body
        // button
        $("#modalCancelBtn").text("취소");
        $("#modalText").html(popBody);

        var objModalExecuteBtn = $("#modalExecuteBtn");
        objModalExecuteBtn.text("프로필 사진으로 지정");
        objModalExecuteBtn.show();
        objModalExecuteBtn.attr('onclick', "uploadProfileImg_btn_click()");

        disableModalExecuteBtn(true);

        $('#modal').modal('toggle');

    }

    function disableModalExecuteBtn(flag) {
        $('#modalExecuteBtn').attr("disabled", flag);
    }


    function uploadProfileImg_btn_click() {
        uploadProfileImage(uploadProfileImageCallback);
    }

    function uploadProfileImageCallback(path) {
        $("#userImgDiv").attr("src", IMAGE_PATH_PREFIX+path);

        var param = {
            imgPath : path
        };

        updateUserDetail($("#userId").val(), param);

        // 팝업 창 닫음
        $('#modal').modal('toggle');
    }

    <!-- ajax -->
    function updateUserDetail(user_id, body) {

        var url = "/user/updateUser/"+user_id;

        $.ajax({
            url: url,
            method: "PUT",
            data: JSON.stringify(body),
            dataType: 'json',
            contentType: "application/json",
            success: function (data){
                var userNameInput = $("#userNameInput");
                var tellPhoneInput = $("#tellPhoneInput");
                var userImgPath = body.imgPath;

                $("#userName").val(userNameInput.val());
                $("#tellPhone").val(tellPhoneInput.val());
                $("#imgPath").val(userImgPath);

                // left.jsp
                setLeftUsername(userNameInput.val());
                if (userImgPath!=undefined) setLeftProfileImage(userImgPath);

                showAlert("success","사용자 정보가 변경되었습니다.");
            },
            error: function (xhr,status,error){
                showAlert("danger",JSON.parse(xhr.responseText).message);
            }
        });
    }

    function deleteUser(user_id, body) {
        var url = "/user/deleteUser/"+user_id;

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
                showAlert("danger",JSON.parse(xhr.responseText).message);
            }
        });
    }

    function getMyQuestions() {

        var param = {};

        $.ajax({
            url: "/myQuestion/getMyQuestionsInMyAccount",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            async: 'false',
            contentType: "application/json",
            success: function (data){
                if(data){
                    setMyQuestions(data)
                }
            },
            error: function (xhr,status,error){
                showAlert("danger",JSON.parse(xhr.responseText).message);
            },
            complete: function () {

            }
        });
    }

    function getUploadProfileImgPopup() {
        var url = "/user/getUploadProfileImgPopup";

        $.ajax({
            url: url,
            method: "GET",
            success: function (data){

                showUploadProfileImgPopup(data);

            },
            error: function (xhr,status,error){
                showAlert("danger",JSON.parse(xhr.responseText).message);
            }
        });
    }

    <!-- end ajax -->

    function setMyQuestions(data) {
        var objMyQuestions = $("#myQuestions");
        objMyQuestions.html("");

        $.each(data, function (eventID, eventData) {
            objMyQuestions.append(
                    "<li class='list-group-item' data-toggle='tooltip' title='" + eventData.title + "' >" +
                    "<span class='pull-right' " +
                    "onclick='deleteQuestion(\"" + eventData.no + "\")' style='cursor: pointer;'>" +
                    "<span style='font-family: Symbol; margin-top: 3px;'>&#180;</span></span><a href='javascript:void(0);' " +
                    "onclick='procMoveMyQuestionUpdateForm(\"" + eventData.no + "\", \"" + eventData.status + "\")'>" + eventData.title + "</a>" +
                    "<input type='hidden' id='filePath_" + eventData.no + "' name='filePath_" + eventData.no + "' value='" + eventData.filePath + "' /></li>"
            );
        });
    }

    function clickMyOrg(orgName) {

        setOrgSession(orgName)

    }

    function goToCreateOrgPage(){
        location.href='/org/createOrgMain'
    }



    <!-- validation check -->
    function updateUserDetail_username_validation_check(userNameInput) {
        var userName = userNameInput.val();

        var result = true;

        //이름 정규식 한글, 영문 혼용x
        var userName_validation_check1=/^[a-zA-Z]{2,50}\s?[a-zA-Z]{2,50}$/;
        var userName_validation_check2=/^[가-힣]{2,10}$/;

        if ( userName == $("#userName").val() ) {
            result = false;
        }
        else if ( !(userName_validation_check1.test(userName) || userName_validation_check2.test(userName)) ) {
            showAlert("warning", "이름은 한글 최소 2글자 최대 10글자 또는 영문 최소 2글자 최대 50글자여야합니다.");
            result = false;
        }
        return result;
    }

    function updateUserDetail_tellPhone_validation_check(tellPhoneInput) {
        var tellPhone = tellPhoneInput.val();

        var result = true;

        // 숫자만 8~11자리
        var tellPhone_validation_check=/^[0-9]{8,11}$/;

        if ( tellPhone == $("#tellPhone").val() ) {
            result = false;
        }
        else if ( !tellPhone_validation_check.test(tellPhone) ) {
            showAlert("warning", "전화번호는 0-9까지 숫자만 사용할 수 있으며, 11자리까지 가능합니다.");
            result = false;
        }

        return result;
    }

    function deleteUser_validation_check(deleteEmailVal, deletePasswordVal) {
        var userId = $("#userId").val();

        var result = true;

        if (userId != deleteEmailVal) {
            setAlertMsg("Email이 일치하지 않습니다.");
            result = false;
        } else if (deletePasswordVal=="") {
            setAlertMsg("비밀번호를 확인하세요.");
            result = false;
        }

        return result;
    }

    <!-- alertMsg Util-->
    function setAlertMsg(msg) {
        $("#alertMsg").html(msg);
    }

    function sortMyOrgs(data){

        data.sort(function (a,b) {
            var aTimestamp =  a.meta.updated != null ? a.meta.updated : a.meta.created;
            var bTimestamp = b.meta.updated != null ? b.meta.updated : b.meta.created;

            return aTimestamp > bTimestamp ? -1 : aTimestamp < bTimestamp ? 1 : 0
        });

        setMyOrgs(data)
    }

    function setMyOrgs(data){

        $.each(data, function (eventID,eventData) {

            $("#myOrgList").append(
                    "<li class='list-group-item'>" +
                    "<span class='pull-right' id='btn-removeOrgFromUser' style='cursor: pointer;' onclick=removeOrgFromUserModal('"+eventData.name+"')>" +
                    "<span style='font-family: symbol; margin-top: 3px;'>&#180;</span></span>" +
                    "<a href='#' onClick=clickMyOrg('"+eventData.name+"')>" +
                    eventData.name +
                    "</a>" +
                    "</li> "
            )
        });

        orgPage = 1;

        if(data.length <= 5){
            $("#showMoreOrgsIcon").hide()
        } else{
            $('#myOrgList li').not(':lt('+orgPage*5+')').hide();
        }
    }

    function iconChange(){
        if ($('#myOrgList li').length > orgPage*5){
            document.getElementById("showMoreOrgsIcon").className="glyphicon glyphicon-triangle-bottom"
        } else {
            document.getElementById("showMoreOrgsIcon").className="glyphicon glyphicon-triangle-top"
        }
    }


    // MOVE MY QUESTION UPDATE FORM
    var procMoveMyQuestionUpdateForm = function (reqNo, reqStatus) {
        if (!procCheckValidNull(reqNo)) return false;

        var reqUrl = '<%= Constants.MY_QUESTION_STATUS_WAITING %>' == reqStatus ? MY_QUESTION_UPDATE_FORM_URL : MY_QUESTION_DETAIL_FORM_URL;

        procMovePage(reqUrl + "/" + reqNo);
    };


    function deleteQuestion(reqNo){
        var doc = document;
        doc.getElementById("questionNo").value = reqNo;
        doc.getElementById("filePath").value = doc.getElementById("filePath_" + reqNo).value;

        procPopup('내 문의', "<spring:message code='common.info.popup.delete.message' />", 'procDelete();');
    }


    // DELETE
    var procDelete = function () {
        $('div.modal').modal('toggle');
        procCallSpinner(SPINNER_SPIN_START);

        procCallAjax(DELETE_PROC_URL, {no : document.getElementById("questionNo").value}, procCallbackDelete);
    };


    // DELETE CALLBACK
    var procCallbackDelete = function (data) {
        if (RESULT_STATUS_SUCCESS == data.RESULT) {
            procDeleteFile();
            showAlert("success", '<spring:message code="common.info.result.success" />');

        } else {
            procCallSpinner(SPINNER_SPIN_STOP);
            showAlert("fail", data.RESULT_MESSAGE);
        }
    };


    // DELETE FILE
    var procDeleteFile = function () {
        var filePath = document.getElementById("filePath").value;
        if ('' != filePath) {
            procCallAjax(DELETE_FILE_PROC_URL, {filePath : filePath}, procCallbackDeleteFile);

        } else {
            procCallSpinner(SPINNER_SPIN_STOP);
            getMyQuestions();
        }
    };


    // DELETE FILE CALLBACK
    var procCallbackDeleteFile = function () {
        procCallSpinner(SPINNER_SPIN_STOP);
        getMyQuestions();
    };

</script>

<%@include file="../layout/bottom.jsp" %>