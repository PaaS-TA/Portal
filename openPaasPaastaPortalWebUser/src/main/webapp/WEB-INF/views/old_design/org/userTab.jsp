<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>

    userList = [];
    currentUserName = htmlDecode("<sec:authentication property='principal.username' />");

    function initUserTab() {
        userList = [];
        $("#allUserList *").remove();
        $("#userTabSelectBox-currentOrg *").remove();
        $("#userTabSelectBox-spaceList *").remove();

        $('#inviteUserTab-org-space-selectBox').hide();
        $('#userTable-container').hide();
        $('#userTab-noUserMessage').hide();
        $('#userTab-errorMessage').hide();
        $('#userTab-spinner').show();

        setUserTabSelectBox();
        orgUserListInit();
    }

    //셀렉트 박스 변경시 이벤트
    function changeSelectBox() {
        var label = $('#userTab-org-space-selectBox :selected').parent().attr('label');
        if (label == '조직') {
            $('#userTab-noUserMessage').hide();
            $('#userTab-errorMessage').hide();
            $('#userTable-container').hide();
            $('#userTab-spinner').show();
            getUsersForOrgOrSpace('org');
        } else if (label == '공간') {
            $('#userTab-noUserMessage').hide();
            $('#userTab-errorMessage').hide();
            $('#userTable-container').hide();
            $('#userTab-spinner').show();
            getUsersForOrgOrSpace('space');
        }

        if (null == $("#userTabSelectBox-currentOrg option:selected").val()) {
            $("#inviteBtn").prop("disabled", true)
        } else {
            $("#inviteBtn").prop("disabled", false)
        }
    }


    //조직에 접근이 가능한 모든 유저를 가져온다.
    function orgUserListInit() {

        $("#userCnt").html('<i class="fa fa-refresh fa-spin" id="userCnt-image" style="font-size:11px"></i>');
        var param = {
            orgName: currentOrg
        };

        $.ajax ({
            url: "/org/getAllUsers",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function(data) {
                if(data && data !="") {
                    //응답된 값이 현재 org에서의 요청에 대한 응답인지 확인
                    if(data[0].orgName === param.orgName){
                        $.each(data, function (eventID, eventData) {
                            userList.push({'userName':eventData.userName, 'userGuid':eventData.userGuid, 'inviteYn':eventData.inviteYn, 'token':eventData.token});
                        });
                        userTableControl(data,'org',"init");
                        //사용자 카운트 갱신
                        $("#userCnt").html($("#allUserList").find($(".userTab-row")).length);
                    }
                } else {
                    //사용자가 없는 경우
                    $('#userTab-spinner').hide();
                    $('#userTab-noUserMessage').show();
                    $("#userCnt").html("0");
                }
                $("#userTab-org-space-selectBox").attr("disabled", false);
                showAlert("success", '<spring:message code="common.info.result.success" />');
            },
            error: function(xhr,status,error){
                console.log("ERROR :: data :: ", error);
                showAlert("fail",error);//JSON.parse(xhr.responseText).message);
                $('#userTab-spinner').hide();
                $('#userCnt-image').attr("class", "glyphicon glyphicon-remove-circle");
                $('#userCnt-image').css("color", "red");
                $('#userTab-errorMessage').show();
                showAlert("success", '<spring:message code="common.info.result.fail" />');
            },
            complete: function (data) {
                $('#userTab-spinner').hide();
            }
        });
    }

    function htmlDecode(value){
        return $('<div/>').html(value).text();
    }

    //조직과 공간목록을 표현하는 셀렉트박스를 생성
    function setUserTabSelectBox() {
        $("#userTabSelectBox-currentOrg").append("<option>"+currentOrg+"</option>");
        $.each(spaceList, function (eventID, eventData) {
            $("#userTabSelectBox-spaceList").append("<option>"+eventData.name+"</option>")
        });
        //처음 유저목록을 가져올 때까지 셀렉트박스 비활성화
        $("#userTab-org-space-selectBox").attr("disabled", true);
    }

    //조직 및 공간의 역할명을 관리
    function userRoleManage(orgOrSpace) {
        switch (orgOrSpace){
            case 'org': var userRoleList = ['OrgManager', 'BillingManager','OrgAuditor'] ;break;
            case 'space': var userRoleList = ['SpaceManager','SpaceDeveloper','SpaceAuditor']; break;
        }
        return userRoleList;
    }


    function changeRole(userName, userRole, type, orgOrSpace){

        var param = {
            orgName: currentOrg,
            userRole: userRole
        };
        var url;
        var successMessage;

        type = type+"-"+orgOrSpace;

        switch (type){
            case 'set-org':
                param['userName']=userName;
                successMessage = "사용자 "+userName+"에게 "+currentOrg+" 조직에 대한 "+userRole+" 역할이 부여되었습니다.";
                url = "/org/setOrgRole"; break;
            case 'unset-org':
                param['userGuid'] = $.grep(userList, function(e){ return e.userName === userName; })[0].userGuid;
                successMessage = "사용자 "+userName+"의 "+currentOrg+" 조직에 대한 "+userRole+" 역할이 제거되었습니다.";
                url = "/org/unsetOrgRole"; break;
            case 'set-space':
                param['spaceName']= $("#userTabSelectBox-spaceList option:selected").val();
                param['userName']=userName;
                successMessage = "사용자 "+userName+"에게 "+ param['spaceName']+" 공간에 대한 "+userRole+" 역할이 부여되었습니다.";
                url = "/space/setSpaceRole"; break;
            case 'unset-space':
                param['spaceName']= $("#userTabSelectBox-spaceList option:selected").val();
                param['userGuid'] = $.grep(userList, function(e){ return e.userName === userName; })[0].userGuid;
                successMessage = "사용자 "+userName+"의 "+ param['spaceName']+" 공간에 대한 "+userRole+" 역할이 제거되었습니다.";
                url = "/space/unsetSpaceRole"; break;
        }

        $.ajax ({
            url: url,
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function(data) {
                if(data){
                    refreshCheckBoxes(orgOrSpace);
                    showAlert("success",successMessage);
                }
            },
            error: function(xhr,status,error){
                getUsersForOrgOrSpace(orgOrSpace);
                $("[id='"+userName + "-" + userRole + "-Role']").prop("checked", false);

                showAlert("fail",JSON.parse(xhr.responseText).message)
            }
        });
    }


    //역할 설정이 완료된 이후 다시 체크박스 disable을 해제
    function refreshCheckBoxes(orgOrSpace){
        var userRoleList = userRoleManage(orgOrSpace);
        for (var i = 0, len = userRoleList.length; i < len; i++) {
            $.each(userList, function (eventID, eventData) {
                if(currentUserName != eventData.userName || userRoleList[i] != 'OrgManager'){
                    $("[id='"+eventData.userName + "-" + userRoleList[i] + "-Role']").attr("disabled", false);
                }
            });
        }
    }

    //체크박스 선택시 이벤트가 완료되기 전까지 체크박스 비활성화
    function checkBoxDisable(orgOrSpace) {
        $.each(userList, function (eventID, eventData) {
            var userRoleList = userRoleManage(orgOrSpace);
            for (var i = 0, len = userRoleList.length; i < len; i++) {
                $("[id='"+eventData.userName + "-"+userRoleList[i]+"-Role']").attr("disabled", true);
            }
        });
    }


    //조직이나 공간에 대해 특정 Role을 가진 유저를 가져온다.
    function getUsersForOrgOrSpace(orgOrSpace) {
        var param = {
            orgName: currentOrg,
            userList: userList
        };

        switch (orgOrSpace){
            case 'org':
                var url = "/org/getUsersForOrgRole"; break;
            case 'space':
                var url = "/space/getUsersForSpaceRole";
                param['spaceName']=$("#userTabSelectBox-spaceList option:selected").val(); break;
        }

        $.ajax ({
            url: url,
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function(data) {
                if(data && data != "") {
                    if(!param.spaceName && data[0].orgName === param.orgName){
                        userTableControl(data,orgOrSpace)
                    } else if(param.spaceName && data[0].orgName === param.orgName &&
                            data[0].spaceName === $("#userTabSelectBox-spaceList option:selected").val()){
                        userTableControl(data,orgOrSpace)
                    }
                }
                else {
                    $('#userTab-spinner').hide();
                    $('#userTab-noUserMessage').show();
                }
            },
            error: function(xhr,status,error){
                $('#userTab-spinner').hide();
                $('#userTab-errorMessage').show();
                showAlert("fail",JSON.parse(xhr.responseText).message)
            }
        });
    }
    //유저목록 테이블을 생성
    function setUserTable(data) {

        var orgName = currentOrg;
        $.each(userList, function(eventId, eventData){
            var appendValue =
                "<div class='userTab-row'>"+
                "<div class='userTab-content-left'>" + eventData.userName +"<br>";
            if(eventData.inviteYn=='Y') {
                appendValue = appendValue + "&nbsp;&nbsp;<button type='button' class='btn btn-default btn-xs' onClick='reSendEmail(\"" + eventData.token + "\")' id='reSend_" + eventData.userName + "'> 초대재전송</button>" ;
                appendValue = appendValue + "&nbsp;&nbsp;<button type='button' class='btn btn-danger btn-xs' onClick='cancelInvite(\"" + eventData.token + "\")' id='reSend_" + eventData.userName + "'> 초대취소</button>" ;
            }
            if(eventData.inviteYn=='N' && eventData.userName!=currentUserName) {
                appendValue = appendValue + "&nbsp;&nbsp;<button type='button' class='btn btn-danger btn-xs' onClick='deleteUserOrg(\"" + orgName + "\", \"" + eventData.userName + "\", \"" + eventData.userGuid + "\")' id='reSend_" + eventData.userName + "'> 멤버취소</button>" ;
            }
            appendValue = appendValue + "</div> "
                        + "<div class='userTab-content-middle' style='text-align: left' id='"+eventData.userName+"-userRoleSet'> </div>"
                        + "</div>";


            //현재 계정 사용자의 역할정보를 맨위에 보이도록..
            if(eventData.userName == currentUserName){
                $("#allUserList").prepend(appendValue)
            } else {
                $("#allUserList").append(appendValue)
            }
        });
    }

    //각각의 역할 별로 체크박스를 만듦
    function setUserRoleCheckBoxes(orgOrSpace) {

        $.each(userList, function (eventID, eventData) {
            $("[id='"+eventData.userName+"-userRoleSet'] *").remove();
            var userRoleList = userRoleManage(orgOrSpace);

            for (var i = 0, len = userRoleList.length; i < len; i++) {
                $("[id='"+eventData.userName + "-userRoleSet']").append(
                    "<div class='checkbox' style='float: left; width:50%; margin: 0%'>" +
                    "<label><input id='" + eventData.userName + "-"+userRoleList[i]+"-Role' type='checkbox' class='custom_cursor_pointer' " +
                    " onclick=onClickCheckBox(this,'" + eventData.userName + "','"+userRoleList[i]+"','"+orgOrSpace+"')>" +
                    ""+userRoleList[i]+"</label>" +
                    "</div> "
                )
            }
        });
    }

    function setUserRole(data) {
        //유저가 갖고 있는 역할에 체크박스 표시
        $.each(data, function (eventId, eventData) {
            $.each(eventData.userRoles, function (eventId, userRole) {
                $("[id='"+eventData.userName + "-" + userRole + "-Role']").prop("checked", true);
                if (userRole == 'OrgManager') {
                    //자기 자신의 OrgManager Role은 제거할 수 없도록 checkbox 비활성화
                    $("[id='"+currentUserName + "-OrgManager-Role']").prop("disabled", "disabled");
                }
            });
        //초대받을경우에는 checkbox비활성화
            if(eventData.inviteYn=='Y'){
                $("[id='"+eventData.userName + "-OrgManager-Role']").prop("disabled", "disabled");
                $("[id='"+eventData.userName + "-BillingManager-Role']").prop("disabled", "disabled");
                $("[id='"+eventData.userName + "-OrgAuditor-Role']").prop("disabled", "disabled");
                $("[id='"+eventData.userName + "-SpaceManager-Role']").prop("disabled", "disabled");
                $("[id='"+eventData.userName + "-SpaceDeveloper-Role']").prop("disabled", "disabled");
                $("[id='"+eventData.userName + "-SpaceAuditor-Role']").prop("disabled", "disabled");
            }
        });

    }

    //체크박스 선택시 이벤트
    function onClickCheckBox(checkbox, userName, userRole, orgOrSpace) {

        checkBoxDisable(orgOrSpace);

        if (checkbox.checked === true ) {
            changeRole(userName,userRole,"set",orgOrSpace)
        }
        else {
            changeRole(userName,userRole,"unset",orgOrSpace)
        }
    }

    function userTableControl(data, orgOrSpace, type){
        if(type === "init"){
            setUserTable(data);
        }
        if(orgOrSpace === "org"){
            $("#orgRole-description").show();
            $("#spaceRole-description").hide();
        } else if(orgOrSpace === "space") {
            $("#orgRole-description").hide();
            $("#spaceRole-description").show();
        }
        setUserRoleCheckBoxes(orgOrSpace);
        setUserRole(data);
        $('#userTab-spinner').hide();
        $('#userTable-container').show()
    }

    function inviteUserTab(){
        $('#userTab1').hide();
        $('#inviteUserTab').show();
        initInviteOrg($("#userTabSelectBox-currentOrg option:selected").val());

    }

    function reSendEmail(token){
        var param = {
            token: token
        };
        var url = "/invite/inviteEmailReSend";
        procCallSpinner(SPINNER_SPIN_START);
        $.ajax ({
            url: url,
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function(data) {
                if(data.token != "") {
                    showAlert("success","이메일 재전송을 성공하였습니다.")
                }
            },
            error: function(xhr,status,error){
                $('#userTab-errorMessage').show();
                showAlert("fail",JSON.parse(xhr.responseText).message)
            },
            complete: function (data) {
                procCallSpinner(SPINNER_SPIN_STOP);
            }
        });
    }
    function  cancelInvite(token){
        var param = {
            token: token
        };
        var url = "/invite/cancelInvite";
        procCallSpinner(SPINNER_SPIN_START);
        $.ajax ({
            url: url,
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function(data) {
                showAlert("success","초대취소를 성공하였습니다.");
                initUserTab();
            },
            error: function(xhr,status,error){
                $('#userTab-errorMessage').show();
                showAlert("fail",JSON.parse(xhr.responseText).message)
            },
            complete: function (data) {
                procCallSpinner(SPINNER_SPIN_STOP);
            }
        });
    }
    function  deleteUserOrg(orgName, userName,userGuid){
        var param = {
            orgName: orgName,
            userName: userName,
            userGuid: userGuid
        };
        var url = "/org/deleteUserOrg";
        procCallSpinner(SPINNER_SPIN_START);
        $.ajax ({
            url: url,
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function(data) {
                showAlert("success","멤버삭제를 성공하였습니다.");
                initUserTab();
            },
            error: function(xhr,status,error){
                $('#userTab-errorMessage').show();
                showAlert("fail",JSON.parse(xhr.responseText).message)
            },
            complete: function (data) {
                procCallSpinner(SPINNER_SPIN_STOP);
            }
        });
    }





</script>
    <div style="margin-bottom: 3px">
        <select id="userTab-org-space-selectBox" class="form-control" style="width: 40%; height:35px;" onchange="changeSelectBox()">
            <optgroup label="조직" id="userTabSelectBox-currentOrg"></optgroup>
            <optgroup label="공간" id="userTabSelectBox-spaceList"></optgroup>
        </select>
        <div style="float: right; margin-right: 3px" name="divInviteBtn">
            <input type="button" id="inviteBtn"  name="inviteBtn"  class="btn btn-success btn-sm"  value="사용자 초대하기"  onclick="inviteUserTab()"/>
        </div>
    </div>
    <div style="overflow:hidden;">
        <div id="userTab-spinner" class="userTable-spinner" style="width: 60%; float: left;">
            <span> 사용자 목록과 역할을 불러오는 중입니다. </span>
            <i class="fa fa-refresh fa-spin" style="font-size:15px;"></i>
        </div>
        <div id="userTab-noUserMessage" style="display: none; width: 60%; float: left;">
            <span class='userTab-content-message' >사용자가 없습니다.</span>
        </div>
        <div id="userTab-errorMessage" style="display: none; width: 60%; float: left;">
            <span class='userTab-content-message' style="color:rgba(255, 0, 0, 0.58);">사용자 목록을 불러오는 중에 오류가 발생했습니다.</span>
        </div>

        <div id="userTable-container" style="display: none; width: 60%; float: left;">
            <div class="userTab-table" id="userTable-title">
                <div class='userTab-row'>
                    <div class='userTab-title-left'>사용자</div>
                    <div class='userTab-title-middle'>역할설정</div>
                </div>
            </div>
            <div class="userTab-table" style="margin-top: 0px" id="allUserList"></div>
        </div>
        <div id="orgRole-description" style="width: 35%; float: right; display: none">
            <div style='font-size: medium; font-weight: bold'>조직 역할</div>
            <div style='font-weight: bold'>OrgManager(조직 관리자)</div>
            <div>사용자를 조직에 초대하고 플랜 선택 및 자원 사용을 제한</div><br>
            <div style='font-weight: bold'>BillingManager(조직 결제 관리자)</div>
            <div>결제 계정과 결제 정보를 관리</div><br>
            <div style='font-weight: bold'>OrgAuditor(조직 참관인)</div>
            <div>조직의 사용자, 역할, 도메인, 쿼타정보를 열람</div>
        </div>
        <div id="spaceRole-description" style="width: 35%; float: right; display: none">
            <div style='font-size: medium; font-weight: bold'>공간 역할</div>
            <div style='font-weight: bold'>SpaceManager(공간 관리자)</div>
            <div>사용자를 공간에 초대하고 해당 공간의 기능을 관리</div><br>
            <div style='font-weight: bold'>SpaceDeveloper(개발자)</div>
            <div>애플리케이션과 서비스를 생성 및 관리하고 로그를 확인</div><br>
            <div style='font-weight: bold'>SpaceAuditor(공간 참관인)</div>
            <div>공간의 로그 및 설정 정보를 열람</div>
        </div>
    </div>