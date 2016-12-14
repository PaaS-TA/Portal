<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../layout/top.jsp" %>
<%@include file="../layout/left.jsp" %>
<%@include file="../layout/alert.jsp" %>

<div id="orgMainWrapper" style="padding-top: 1px; display: none;">
    <%-- ORG PANEL --%>
    <%@include file="orgPanel.jsp" %>

    <div class="row" style="margin-top:-19px">
        <%-- SPACE PANEL--%>
        <%@include file="spacePanel.jsp" %>

        <%-- DOAMIN PANEL--%>
        <%@include file="domainPanel.jsp" %>

        <div class="panel content-box col-md-6 col-md-offset-13 fr">
            <%-- USER PANEL--%>
            <%@include file="userPanel.jsp" %>

            <%-- INVITE USER PANEL--%>
            <%@include file="inviteUserPanel.jsp" %>
        </div>
    </div>
</div>

<%--FOR FOOTER--%>
<div class="row">


<script type="text/javascript">

    var commonValueDomainPrivate = 'private';
    var commonValueDomainShared = 'shared';
    var commonValueDomainAdd = 'add';
    var commonValueDomainDelete = 'delete';
    var commonValueUserOrg = 'org';
    var commonValueUserSpace = 'space';
    var commonValueUserOrgManager = 'OrgManager';
    var commonValueUserBillingManager = 'BillingManager';
    var commonValueUserOrgAuditor = 'OrgAuditor';
    var commonValueUserSpaceManager = 'SpaceManager';
    var commonValueUserSpaceDeveloper = 'SpaceDeveloper';
    var commonValueUserSpaceAuditor = 'SpaceAuditor';
    var commonValueInviteResendEmail = 'resendEmail';
    var commonValueInviteCancelInvite = 'cancelInvite';
    var commonValueInviteDeleteUserOrg = 'deleteUserOrg';


    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // ORG AREA
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    // SET ORG MAIN BUTTONS
    var procSetOrgMainButtons = function () {
        var objRenameOrgBtn = $("#renameOrgBtn");
        var objDeleteOrgBtn = $("#deleteOrgBtn");
        var objCreateSpaceBtn = $("#createSpaceBtn");

        if (isOrgManaged) {
            objRenameOrgBtn.show();
            objDeleteOrgBtn.show();
            objCreateSpaceBtn.show();
        } else {
            objRenameOrgBtn.hide();
            objDeleteOrgBtn.hide();
            objCreateSpaceBtn.hide();
        }
    };


    // CHANGE ORG NAME INPUT BOX :: KEYUP EVENT
    var procChangeOrgNameInputBox = function () {
        var objRenameOrgBtn = $('#renameOrgBtn');

        if ($('#org').val() == currentOrg) {
            objRenameOrgBtn.attr('disabled', true);
        } else {
            objRenameOrgBtn.attr('disabled', false);
        }
    };


    // RENAME ORG MODAL
    var procRenameOrgModal = function () {
        var objModalExecuteBtn;

        if (!procCheckBlank()) return false;

        $("#modalTitle").html("조직명 수정");
        $("#modalText").html(currentOrg + " 조직명을 " + $('#org').val() + " 으로 수정하시겠습니까?");
        $("#modalCancelBtn").text("취소");

        objModalExecuteBtn = $("#modalExecuteBtn");
        objModalExecuteBtn.text("수정");
        objModalExecuteBtn.show();
        objModalExecuteBtn.attr('onclick', 'procRenameOrg();');

        $('#modal').modal('toggle');
    };


    // CHECK BLANK
    var procCheckBlank = function () {
        var objOrg = $("#org");
        var orgName = objOrg.val();
        var createOrgValidation;

        if (orgName.includes(' ')) {
            showAlert("fail", "조직명은 공백을 포함할 수 없습니다.");
            objOrg.focus();
            return false;
        }

        createOrgValidation = /^[a-zA-Z-_.0-9ㄱ-ㅎ|ㅏ-ㅣ|가-힣]{1,15}\s?[a-zA-Z-_.0-9ㄱ-ㅎ|ㅏ-ㅣ|가-힣]{1,15}$/;
        if (!createOrgValidation.test(orgName)) {
            showAlert("fail", "조직이름은 2자이상 30자 이하, 특수문자는 bar(-)와 underscore(_)만 허용합니다.");
            objOrg.focus();
            return false;
        }

        return true;
    };


    // RENAME ORG
    var procRenameOrg = function () {
        var param = {
            orgName: currentOrg,
            newOrgName: $('#org').val()
        };

        procCallAjax("/org/renameOrg", param, procCallbackRenameOrg);
    };


    // RENAME ORG CALLBACK
    var procCallbackRenameOrg = function (data) {
        var orgName;

        if (RESULT_STATUS_FAIL == data.RESULT) {
            return false;
        }

        showAlert('success', "조직명이 수정되었습니다.");

        orgName = $('#org').val();
        procSetOrgSession(orgName);
        procGetOrgs();

        $('#renameOrgBtn').attr('disabled', true);
        $('#modal').modal('hide');
    };


    // DELETE ORG MODAL
    var procDeleteOrgModal = function () {
        var objModalExecuteBtn;

        $("#modalTitle").html("조직명 삭제");
        $("#modalText").html("조직을 삭제하면 되돌릴 수 없습니다." + " <br> " + currentOrg + " 를 삭제하시겠습니까?");
        $("#modalCancelBtn").text("취소");

        objModalExecuteBtn = $("#modalExecuteBtn");
        objModalExecuteBtn.text("삭제");
        objModalExecuteBtn.show();
        objModalExecuteBtn.attr('onclick', 'procDeleteOrg();');

        $('#modal').modal('toggle');
    };


    // DELETE ORG
    var procDeleteOrg = function () {
        procCallAjax("/org/deleteOrg", {orgName: currentOrg}, procCallbackDeleteOrg);
    };


    // DELETE ORG CALLBACK
    var procCallbackDeleteOrg = function (data) {
        if (RESULT_STATUS_FAIL == data.RESULT) {
            return false;
        }

        showAlert('success', "조직이 삭제되었습니다.");
        procSetOrgSession(null);

        $('#renameOrgBtn').attr('disabled', true);
        $('#modal').modal('hide');
    };


    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // ORG AREA :: WEB IDE
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    function getWebIdeUser() {
        var param = {
            userId: $('#dropdownTopMenu').text().trim(),
            orgName: currentOrg
        };

        $.ajax({
            url: "/webIdeUser/getUser",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function (data) {
                if (data) {
                    $("#webIdeLinkBtn").hide();
                    $("#webIdeApplyBtn").hide();
                    $("#webIdeCancelBtn").hide();

                    if (data.useYn == "Y") {
                        $('#webIdeUrl').val(data.url);
                        $("#webIdeLinkBtn").show();
                        $("#webIdeCancelBtn").show();
                    } else if (data.useYn == "N" && isOrgManaged == true) {
                        $("#webIdeCancelBtn").show();
                    } else if (isOrgManaged == true) {
                        $("#webIdeApplyBtn").show();
                    }
                }
            }
        });
    }


    function openWebIdeUrl() {
        window.open($('#webIdeUrl').val(), '_blank');
    }


    function applyWebIdeModal() {
        $("#modalTitle").html("WEB IDE 사용 신청");
        $("#modalText").html("WEB IDE(Eclipse Che)는 브라우저 기반 IDE 입니다.<br> 자세한 사항은 다음의 링크를 클릭해주십시요.<br> <a href='http://www.eclipse.org/che/' target='_blank'>http://www.eclipse.org/che/</a><br><br>  WEB IDE를 신청 하시면 관리자의 승인 후 조직 단위로 WEB IDE 영역이 할당됩니다. <br>" + currentOrg + " 조직의 WEB IDE 사용을 신청하시겠습니까?");
        $("#modalCancelBtn").text("취소");
        $("#modalExecuteBtn").text("신청");
        $("#modalExecuteBtn").show();
        $('#modalExecuteBtn').attr('onclick', 'applyWebIde();');

        $('#modal').modal('toggle');
    }


    function applyWebIde() {
        var param = {
            userId: $('#dropdownTopMenu').text().trim(),
            orgName: currentOrg
        };

        $.ajax({
            url: "/webIdeUser/insertUser",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function (data) {
                if (data) {
                    showAlert('success', "WEB IDE 사용이 신청되었습니다.");
                    $("#webIdeCancelBtn").show();
                    $("#webIdeApplyBtn").hide();
                }
            },
            complete: function (data) {
                $('#modal').modal('hide');
            }
        });
    }


    function cancelWebIdeModal() {
        $("#modalTitle").html("WEB IDE 신청 취소");
        $("#modalText").html("" + currentOrg + " 조직의 WEB IDE 사용 신청을 취소하시겠습니까?");
        $("#modalCancelBtn").text("취소");
        $("#modalExecuteBtn").text("취소신청");
        $("#modalExecuteBtn").show();
        $('#modalExecuteBtn').attr('onclick', 'cancelWebIde();');

        $('#modal').modal('toggle');
    }


    function cancelWebIde() {
        $.ajax({
            url: "/webIdeUser/deleteUser",
            method: "POST",
            data: JSON.stringify({orgName: currentOrg}),
            dataType: 'json',
            contentType: "application/json",
            success: function (data) {
                if (data) {
                    showAlert('success', "WEB IDE 사용 신청이 취소되었습니다.");
                    $("#webIdeCancelBtn").hide();
                    $("#webIdeApplyBtn").show();
                }
            },
            complete: function (data) {
                $('#modal').modal('hide');
            }
        });
    }


    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // SPACE AREA
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    // REF COMMON
    // SET SPACE LIST
    var procSetSpaceListTable = function (data) {
        var spaceList = data.spaces;
        var memoryLimit = data.memoryLimit;
        var objNoneSpaceMessageArea = $('#noneSpaceMessageArea');
        var objSpaceListTableHeader = $('#spaceListTableHeader');
        var objSpaceListTable = $('#spaceListTable');
        var htmlString = [];

        if (null == spaceList || 0 == spaceList.length) {
            objSpaceListTableHeader.hide();
            objNoneSpaceMessageArea.show();
        } else {
            objSpaceListTable.html('');
            $.each(spaceList, function (id, data) {
                htmlString.push('<tr><td><div align="center"><div class="ml10" style="padding-bottom: 0;">'
                    + '<a href="#" onclick="procSetSpaceSession(\'' + data.name + '\');"><span style="font-size: 22px; font-weight: bold;">' + data.name
                    + '</span></a></div><div style="padding-bottom: 10px;">'
                    + '<span style="font-size: 15px;">' + parseInt(data.memDevTotal / memoryLimit * 100) + "% 메모리 사용중"
                    + '</span></div></div></td><td><div align="center"><div style="padding-bottom: 0;">'
                    + '<span style="font-size: 22px; font-weight: bold;">' + data.appCount
                    + '</span></div><div style="padding-bottom: 10px;"><span style="font-size: 15px;">'
                    + "사용중:" + data.appCountStarted + " 중지됨:" + data.appCountStopped + " 다운됨:" + data.appCountCrashed
                    + '</span></div></div></td><td><div align="center"><div style="padding-bottom: 10px; margin-top:15px;">'
                    + '<span style="font-size: 22px; font-weight: bold;">' + data.serviceCount + '</span></div></div></td></tr>');
            });

//            procSetSpaceSession(data.name);

            objNoneSpaceMessageArea.hide();
            objSpaceListTable.append(htmlString);
            objSpaceListTableHeader.show();
        }

        // SET USER LIST
        procSetUserListSelectBox(spaceList);
    };


    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // DOMAIN AREA
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    // GET DOMAIN LIST
    var procGetDomainList = function (reqStatus, doWhat, domainName) {
        var param;

        if (commonValueDomainPrivate == reqStatus) {
            $('#domainListTable').html('');
        }

        param = {
            reqStatus: reqStatus,
            doWhat: doWhat,
            domainName: domainName
        };

        procCallAjax("/domain/getDomains/" + reqStatus, param, procCallbackGetDomainList);
    };


    // GET DOMAIN LIST CALLBACK
    var procCallbackGetDomainList = function (data, reqParam) {
        if (RESULT_STATUS_FAIL == data.RESULT) {
            return false;
        }

        if (commonValueDomainAdd == reqParam.doWhat || commonValueDomainDelete == reqParam.doWhat) {
            procGetDomainList(commonValueDomainPrivate);
        } else {
            procSetDomainList(reqParam.reqStatus, data);
        }
    };


    // SET DOMAIN LIST
    var procSetDomainList = function (status, data) {
        var domainListObject = $('#domainListTable');
        var htmlString = [];
        var objHiddenDomainCount = $('#hiddenDomainCount');
        var tempDomainCount = 0;

        if (commonValueDomainPrivate == status) {
            objHiddenDomainCount.val(0);

            $.each(data, function (eventID, eventData) {
                htmlString.push('<tr><td><div align="center"><div class="mt10">'
                    + '<span style="font-size: 15px;">'
                    + eventData.name + '</span></div></div></td><td><div align="center">'
                    + '<div style="margin-top: 2px;">'
                    + '<span style="font-size: 15px; color: #b6b6b6;">'
                    + '<button type="button" class="btn btn-cancel btn-sm" '
                    + 'onclick="procDeletePrivateDomainModal(\'' + eventData.name + '\');" '
                    + 'style="margin-top: 3px; margin-bottom: 3px;">'
                    + '삭제</button></span></div></div></td></tr>');
                tempDomainCount++;
            });

            procGetDomainList('shared');
            domainListObject.append(htmlString);
            objHiddenDomainCount.val(tempDomainCount);
        }

        if (commonValueDomainShared == status) {
            tempDomainCount = objHiddenDomainCount.val();

            $.each(data, function (eventID, eventData) {
                htmlString.push('<tr><td><div align="center"><div style="margin-top: 2px;">'
                    + '<span style="font-size: 15px;">' + eventData.name
                    + '</span></div></div></td><td><div align="center"><div style="margin-top: 2px;">'
                    + '<span style="font-size: 15px; color: #b6b6b6;">SHARED</span></div></div></td></tr>');

                tempDomainCount++;
            });

            domainListObject.append(htmlString);
            $('#domainCnt').html(tempDomainCount);
        }
    };


    // CHECK DOMAIN VALIDATION
    var procCheckDomainValidation = function (id) {
        var newDomain = $("#addDomain-TextField").val();
        var domainExp = /^([a-zA-Z0-9]+([a-zA-Z0-9-][a-zA-Z0-9]+)*\.){1,}[a-zA-Z0-9]+([a-zA-Z0-9-][a-zA-Z0-9]+)?$/;

        if (newDomain == "") {
            //도메인 이름이 없음
            textFieldChange(id, 'warning');
            document.getElementById("btn-addDomain").disabled = true;
        } else {
            if (domainExp.test(newDomain)) {
                textFieldChange(id, 'ok');
                document.getElementById("btn-addDomain").disabled = false;
            } else {
                //적절하지 않은 도메인 명
                textFieldChange(id, 'error');
                document.getElementById("btn-addDomain").disabled = true;
            }
        }
    };


    // ADD DOMAIN
    var procAddDomain = function () {
        var domainName = $("#addDomain-TextField").val();
        var param = {
            orgName: currentOrg,
            spaceName: $("#spaceList").find('li').find('a')[0].textContent,
            domainName: domainName
        };

        procCallAjax("/domain/addDomain", param, procCallbackAddDomain);
    };


    // ADD DOMAIN CALLBACK
    var procCallbackAddDomain = function (data, reqParam) {
        if (RESULT_STATUS_FAIL == data.RESULT) {
            return false;
        }

        procGetDomainList(commonValueDomainPrivate, commonValueDomainAdd, reqParam.domainName);
        procClickCreateFormCancel('addDomain');
        showAlert("success","도메인을 추가하였습니다.")
    };


    // DELETE PRIVATE DOMAIN MODAL
    var procDeletePrivateDomainModal = function (domainName) {
        var objModalExecuteBtn;

        $("#modalTitle").html("도메인 삭제");
        $("#modalText").html("'" + domainName + "' 도메인을 삭제하시겠습니까?");
        $("#modalCancelBtn").text("취소");

        objModalExecuteBtn = $("#modalExecuteBtn");
        objModalExecuteBtn.text("삭제");
        objModalExecuteBtn.show();
        objModalExecuteBtn.attr('onclick', 'procDeletePrivateDomain(\'' + domainName + '\')');

        $('#modal').modal('toggle');
    };


    // DELETE PRIVATE DOMAIN
    var procDeletePrivateDomain = function (domainName) {
        var param = {
            orgName: currentOrg,
            spaceName: $("#spaceList").find('li').find('a')[0].textContent,
            domainName: domainName
        };

        procCallAjax("/domain/deleteDomain", param, procCallbackDeletePrivateDomain);
    };


    // DELETE PRIVATE DOMAIN CALLBACK
    var procCallbackDeletePrivateDomain = function (data) {
        if (RESULT_STATUS_FAIL == data.RESULT) {
            return false;
        }

        showAlert("success", "도메인을 삭제하였습니다.");
        procGetDomainList(commonValueDomainPrivate, commonValueDomainDelete);

        $('#modal').modal('hide');
    };


    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //  USER AREA ;: LIST
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    var USER_LIST;

    // SET USER LIST SELECT BOX
    var procSetUserListSelectBox = function (reqSpaceList) {
        var objUserTabSelectBoxCurrentOrg = $("#userTabSelectBox-currentOrg");
        var objUserTabSelectBoxSpaceList = $("#userTabSelectBox-spaceList");

        objUserTabSelectBoxCurrentOrg.html('');
        objUserTabSelectBoxSpaceList.html('');
        objUserTabSelectBoxCurrentOrg.append("<option>" + currentOrg + "</option>");

        $.each(reqSpaceList, function (eventID, eventData) {
            objUserTabSelectBoxSpaceList.append("<option>" + eventData.name + "</option>")
        });

        procGetAllUserList();
    };


    // GET ALL USER LIST
    var procGetAllUserList = function () {
        procCallAjax("/org/getAllUsers", {orgName: currentOrg}, procCallbackGetAllUserList);
    };


    // GET ALL USER LIST CALLBACK
    var procCallbackGetAllUserList = function (data) {
        var tempList = [];

        if (RESULT_STATUS_FAIL == data.RESULT) {
            return false;
        }

        USER_LIST = [];
        $.each(data, function (eventId, eventData) {
            tempList.push({
                'userName': eventData.userName,
                'userGuid': eventData.userGuid,
                'inviteYn': eventData.inviteYn,
                'token': eventData.token
            });
        });

        USER_LIST = tempList;

        procSetUserTableForOrg(data);
        procSetUserTableForSpace(data);
        procGetUserRoleList(commonValueUserOrg);
    };


    // CHANGE SELECT BOX
    var procChangeUserSelectBox = function () {
        var selectedId = $('#userTab-org-space-selectBox option:selected').parent().attr('id');
        var checkOrg = 'userTabSelectBox-currentOrg';
        var checkSpace = 'userTabSelectBox-spaceList';
        var reqStatus;

        procCallSpinner(SPINNER_SPIN_START);

        if (checkOrg == selectedId) {
            reqStatus = commonValueUserOrg;
        }

        if (checkSpace == selectedId) {
            reqStatus = commonValueUserSpace;
        }

        procGetUserRoleList(reqStatus);
    };


    // GET USER ROLE LIST
    var procGetUserRoleList = function (reqStatus) {
        var reqUrl;
        var param = {
            orgName: currentOrg,
            userList: USER_LIST
        };

        switch (reqStatus) {
            case commonValueUserOrg:
                reqUrl = "/org/getUsersForOrgRole";
                break;
            case commonValueUserSpace:
                reqUrl = "/space/getUsersForSpaceRole";
                param['spaceName'] = $('#userTabSelectBox-spaceList option:selected').val();
                break;
            default:
                break;
        }

        procCallAjax(reqUrl, param, procCallbackGetUserRoleList);
    };


    // GET USER ROLE LIST CALLBACK
    var procCallbackGetUserRoleList = function (data, reqParam) {
        if (RESULT_STATUS_FAIL == data.RESULT) {
            return false;
        }

        // ORG
        if (!reqParam.spaceName && data[0].orgName === reqParam.orgName) {
            procSetUserTableForOrg(data);
        }

        // SPACE
        if (reqParam.spaceName && data[0].orgName === reqParam.orgName &&
            data[0].spaceName === $("#userTabSelectBox-spaceList option:selected").val()) {
            procSetUserTableForSpace(data);
        }
    };


    // SET USER TABLE FOR ORG
    var procSetUserTableForOrg = function (data) {
        var userListObject = $('#userListTable');
        var htmlString = [];
        var currentUserName = $('#thisUserId').val();
        var userCount = 0;
        var userRoleList;
        var checkedOrgManager;
        var checkedBillingManager;
        var checkedOrgAuditor;
        var userName;
        var token;
        var userGuid;
        var inviteYn;
        var checkedOwnerDisabledCss;
        var reSendEmailButtonHtml;
        var cancelInviteButtonHtml;
        var deleteUserOrgButtonHtml;
        var checkedInvitedDisabledCss;

        userListObject.html('');
        $.each(data, function (eventId, eventData) {
            userRoleList = eventData.userRoles;
            checkedOrgManager = '';
            checkedBillingManager = '';
            checkedOrgAuditor = '';
            userName = eventData.userName;
            token = eventData.token;
            userGuid = eventData.userGuid;
            inviteYn = eventData.inviteYn;

            // SET ROLE
            $.each(userRoleList, function (subEventId, subEventData) {
                if (commonValueUserOrgManager == subEventData) {
                    checkedOrgManager = ' checked ';
                }
                if (commonValueUserBillingManager == subEventData) {
                    checkedBillingManager = ' checked ';
                }
                if (commonValueUserOrgAuditor == subEventData) {
                    checkedOrgAuditor = ' checked ';
                }
            });

            if (currentUserName == userName) {
                checkedOwnerDisabledCss = ' disabled ';
            } else {
                checkedOwnerDisabledCss = '';
            }

            if (USE_YN_Y == inviteYn) {
                reSendEmailButtonHtml = '<div style="margin: 12px 0;"><button type="button" ' +
                    'class="btn btn-default btn-sm" ' +
                    'onClick="procCommonProcessInvitedUser(\'' + commonValueInviteResendEmail + '\', \'' + token + '\');" ' +
                    'id="reSend_' + userName + '">초대재전송</button></div>';

                cancelInviteButtonHtml = '<div style="margin: 12px 0;"><button type="button" ' +
                    'class="btn btn-red btn-sm ml5" style="padding: 4px 16px;"' +
                    'onClick="procCommonProcessInvitedUser(\'' + commonValueInviteCancelInvite + '\', \'' + token + '\');" ' +
                    'id="reSend_' + userName + '">초대취소</button></div>';

                checkedInvitedDisabledCss = ' disabled ';

            } else {
                reSendEmailButtonHtml = '';
                cancelInviteButtonHtml = '';
                checkedInvitedDisabledCss = '';
            }

            if (USE_YN_N == inviteYn && currentUserName != userName) {
                deleteUserOrgButtonHtml = '<div style="margin: 12px 0;"><button type="button" ' +
                    'class="btn btn-cancel btn-sm ml5" style="padding: 4px 16px;"' +
                    'onClick="procCommonProcessInvitedUser(\'' + commonValueInviteDeleteUserOrg + '\', \'' + token + '\', \''
                    + currentOrg + '\', \'' + userName + '\', \'' + userGuid + '\');" ' +
                    'id="reSend_' + userName + '">멤버취소</button></div>';
            } else {
                deleteUserOrgButtonHtml = '';
            }

            htmlString.push('<tr><td><div align="center"><div style="margin: 56px 0;"><span style="font-size: 15px;">'
                + userName + '</span>' + reSendEmailButtonHtml + cancelInviteButtonHtml + deleteUserOrgButtonHtml
                + '</div></div></td><td><div align="left"><div style="margin-top: 2px;">'
                + '<div class="checkbox"><label>'
                + '<input type="checkbox" value="" '
                + checkedOrgManager + checkedInvitedDisabledCss + checkedOwnerDisabledCss
                + ' onclick="procClickUserRoleCheckBox(this, \'' + userName + '\', \''
                + userGuid + '\', \'OrgManager\', \'org\');">OrgManager(조직 관리자)<br>'
                + '<h3 style="margin-top: 2px;margin-left: -15px; color: #a0a0a0;">'
                + '사용자를 조직에 초대하고 플랜 선택 및 자원 사용을 제한</h3></label></div>'
                + '<div class="checkbox mt10"><label>'
                + '<input type="checkbox" value="" ' + checkedBillingManager + checkedInvitedDisabledCss
                + ' onclick="procClickUserRoleCheckBox(this, \'' + userName + '\', \''
                + userGuid + '\', \'BillingManager\', \'org\');">BillingManager(조직 결제 관리자)<br>'
                + '<h3 style="margin-top: 2px;margin-left: -15px; color: #a0a0a0;">'
                + '결제 계정과 결제 정보를 관리</h3></label></div>'
                + '<div class="checkbox mt10"><label>'
                + '<input type="checkbox" value="" ' + checkedOrgAuditor + checkedInvitedDisabledCss
                + ' onclick="procClickUserRoleCheckBox(this, \'' + userName + '\', \''
                + userGuid + '\', \'OrgAuditor\', \'org\');">OrgAuditor(조직 참관인)<br>'
                + '<h3 style="margin-top: 2px;margin-left: -15px; color: #a0a0a0;">'
                + '조직의 사용자, 역할, 도메인, 쿼타정보를 열람</h3></label></div></div></div></td></tr>');

            userCount++;
        });

        userListObject.append(htmlString);
        $('#userCnt').html(userCount);

        $('#orgMainWrapper').show();
        $('#footer').show();
        procCallSpinner(SPINNER_SPIN_STOP);
    };


    // SET USER TABLE FOR SPACE
    var procSetUserTableForSpace = function (data) {
        var userListObject = $('#userListTable');
        var htmlString = [];
        var currentUserName = $('#thisUserId').val();
        var userCount = 0;
        var userRoleList;
        var checkedSpaceManager;
        var checkedSpaceDeveloper;
        var checkedSpaceAuditor;
        var userName;
        var token;
        var userGuid;
        var inviteYn;
        var checkedOwnerDisabledCss;
        var reSendEmailButtonHtml;
        var cancelInviteButtonHtml;
        var deleteUserOrgButtonHtml;
        var checkedInvitedDisabledCss;

        userListObject.html('');
        $.each(data, function (eventId, eventData) {
            userRoleList = eventData.userRoles;
            checkedSpaceManager = '';
            checkedSpaceDeveloper = '';
            checkedSpaceAuditor = '';
            userName = eventData.userName;
            token = eventData.token;
            userGuid = eventData.userGuid;
            inviteYn = eventData.inviteYn;

            // SET ROLE
            $.each(userRoleList, function (subEventId, subEventData) {
                if (commonValueUserSpaceManager == subEventData) {
                    checkedSpaceManager = ' checked ';
                }
                if (commonValueUserSpaceDeveloper == subEventData) {
                    checkedSpaceDeveloper = ' checked ';
                }
                if (commonValueUserSpaceAuditor == subEventData) {
                    checkedSpaceAuditor = ' checked ';
                }
            });

            if (currentUserName == userName) {
                checkedOwnerDisabledCss = ' disabled ';
            } else {
                checkedOwnerDisabledCss = '';
            }

            if (USE_YN_Y == inviteYn) {
                reSendEmailButtonHtml = '<div style="margin: 12px 0;"><button type="button" ' +
                    'class="btn btn-default btn-sm" ' +
                    'onClick="procCommonProcessInvitedUser(\'' + commonValueInviteResendEmail + '\', \'' + token + '\');" ' +
                    'id="reSend_' + userName + '">초대재전송</button></div>';

                cancelInviteButtonHtml = '<div style="margin: 12px 0;"><button type="button" ' +
                    'class="btn btn-red btn-sm ml5" style="padding: 4px 16px;"' +
                    'onClick="procCommonProcessInvitedUser(\'' + commonValueInviteCancelInvite + '\', \'' + token + '\');" ' +
                    'id="reSend_' + userName + '">초대취소</button></div>';

                checkedInvitedDisabledCss = ' disabled ';

            } else {
                reSendEmailButtonHtml = '';
                cancelInviteButtonHtml = '';
                checkedInvitedDisabledCss = '';
            }

            if (USE_YN_N == inviteYn && currentUserName != userName) {
                deleteUserOrgButtonHtml = '<div style="margin: 12px 0;"><button type="button" ' +
                    'class="btn btn-cancel btn-sm ml5" style="padding: 4px 16px;"' +
                    'onClick="procCommonProcessInvitedUser(\'' + commonValueInviteDeleteUserOrg + '\', \'' + token + '\', \''
                    + currentOrg + '\', \'' + userName + '\', \'' + userGuid + '\');" ' +
                    'id="reSend_' + userName + '">멤버취소</button></div>';
            } else {
                deleteUserOrgButtonHtml = '';
            }

            htmlString.push('<tr><td><div align="center"><div style="margin: 56px 0;"><span style="font-size: 15px;">'
                + userName + '</span>' + reSendEmailButtonHtml + cancelInviteButtonHtml + deleteUserOrgButtonHtml
                + '</div></div></td><td><div align="left"><div style="margin-top: 2px;">'
                + '<div class="checkbox"><label>'
                + '<input type="checkbox" value="" '
                + checkedSpaceManager + checkedInvitedDisabledCss + checkedOwnerDisabledCss
                + ' onclick="procClickUserRoleCheckBox(this, \'' + userName + '\', \''
                + userGuid + '\', \'SpaceManager\', \'space\');">SpaceManager(조직 관리자)<br>'
                + '<h3 style="margin-top: 2px;margin-left: -15px; color: #a0a0a0;">'
                + '사용자를 공간에 초대하고 해당 공간의 기능을 관리</h3></label></div>'
                + '<div class="checkbox mt10"><label>'
                + '<input type="checkbox" value="" ' + checkedSpaceDeveloper + checkedInvitedDisabledCss
                + ' onclick="procClickUserRoleCheckBox(this, \'' + userName + '\', \''
                + userGuid + '\', \'SpaceDeveloper\', \'space\');">SpaceDeveloper(조직 결제 관리자)<br>'
                + '<h3 style="margin-top: 2px;margin-left: -15px; color: #a0a0a0;">'
                + '애플리케이션과 서비스를 생성 및 관리하고 로그를 확인</h3></label></div>'
                + '<div class="checkbox mt10"><label>'
                + '<input type="checkbox" value="" ' + checkedSpaceAuditor + checkedInvitedDisabledCss
                + ' onclick="procClickUserRoleCheckBox(this, \'' + userName + '\', \''
                + userGuid + '\', \'SpaceAuditor\', \'space\');">SpaceAuditor(조직 참관인)<br>'
                + '<h3 style="margin-top: 2px;margin-left: -15px; color: #a0a0a0;">'
                + '공간의 로그 및 설정 정보를 열람</h3></label></div></div></div></td></tr>');

            userCount++;
        });

        userListObject.append(htmlString);
        $('#userCnt').html(userCount);

        procCallSpinner(SPINNER_SPIN_STOP);
    };


    // CLICK USER ROLE CHECK BOX
    var procClickUserRoleCheckBox = function (checkbox, userName, userGuid, userRole, orgOrSpace) {
        procCallSpinner(SPINNER_SPIN_START);

        if (checkbox.checked) {
            procChangeUserRole(userName, userGuid, userRole, "set", orgOrSpace);
        } else {
            procChangeUserRole(userName, userGuid, userRole, "unset", orgOrSpace)
        }
    };


    // CHANGE USER ROLE
    var procChangeUserRole = function (userName, userGuid, userRole, type, orgOrSpace) {
        var reqUrl;
        var reqType;
        var successMessage;
        var orgName = currentOrg;
        var selectedSpace = $("#userTabSelectBox-spaceList option:selected").val();
        var param = {
            orgName: orgName,
            userRole: userRole
        };

        reqType = type + "-" + orgOrSpace;

        switch (reqType) {
            case 'set-org':
                reqUrl = "/org/setOrgRole";
                param['userName'] = userName;
                param['successMessage'] = "사용자 " + userName + "에게 " + orgName + " 조직에 대한 "
                    + userRole + " 역할이 부여되었습니다.";
                break;
            case 'unset-org':
                reqUrl = "/org/unsetOrgRole";
                param['userGuid'] = userGuid;
                param['successMessage'] = "사용자 " + userName + "의 " + orgName + " 조직에 대한 "
                    + userRole + " 역할이 제거되었습니다.";
                break;
            case 'set-space':
                reqUrl = "/space/setSpaceRole";
                param['spaceName'] = selectedSpace;
                param['userName'] = userName;
                param['successMessage'] = "사용자 " + userName + "에게 " + param['spaceName'] + " 공간에 대한 "
                    + userRole + " 역할이 부여되었습니다.";
                break;
            case 'unset-space':
                reqUrl = "/space/unsetSpaceRole";
                param['spaceName'] = selectedSpace;
                param['userGuid'] = userGuid;
                param['successMessage'] = "사용자 " + userName + "의 " + param['spaceName'] + " 공간에 대한 "
                    + userRole + " 역할이 제거되었습니다.";
                break;
            default:
                console.log('SWITCH DEFAULT');
                break;
        }

        procCallAjax(reqUrl, param, procCallbackChangeUserRole);
    };


    // CHANGE USER ROLE
    var procCallbackChangeUserRole = function (data, reqParam) {
        procCallSpinner(SPINNER_SPIN_STOP);

        if (RESULT_STATUS_FAIL == data.RESULT) {
            return false;
        }

        showAlert("success", reqParam.successMessage);
    };


    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //  USER AREA ;: INVITE FORM
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    // VIEW INVITE FORM
    var procViewInviteForm = function () {
        $('#userListFormArea').hide();
        $('#invitedFormSpaceListArea').show();
        $('#inviteUserFormArea').show();
        $('#inviteUserId').focus();
    };


    // COMMON PROCESS INVITED USER
    var procCommonProcessInvitedUser = function (reqStatus, token, orgName, userName, userGuid) {
        var reqUrl = '';
        var param = {};

        procCallSpinner(SPINNER_SPIN_START);

        if (commonValueInviteResendEmail == reqStatus) {
            reqUrl = '/invite/inviteEmailReSend';
            param = {
                reqStatus: reqStatus,
                token: token
            };
        }

        if (commonValueInviteCancelInvite == reqStatus) {
            reqUrl = '/invite/cancelInvite';
            param = {
                reqStatus: reqStatus,
                token: token
            };
        }

        if (commonValueInviteDeleteUserOrg == reqStatus) {
            reqUrl = '/org/deleteUserOrg';
            param = {
                reqStatus: reqStatus,
                orgName: orgName,
                userName: userName,
                userGuid: userGuid
            };
        }

        procCallAjax(reqUrl, param, procCallbackCommonProcessInvitedUser);
    };


    // COMMON PROCESS INVITED USER CALLBACK
    var procCallbackCommonProcessInvitedUser = function (data, reqParam) {
        var reqStatus;

        procCallSpinner(SPINNER_SPIN_STOP);

        if (RESULT_STATUS_FAIL == data.RESULT) {
            return false;
        }

        reqStatus = reqParam.reqStatus;

        if (commonValueInviteResendEmail == reqStatus) showAlert("success", "이메일 재전송을 성공하였습니다.");

        if (commonValueInviteCancelInvite == reqStatus) {
            showAlert("success", "초대취소를 성공하였습니다.");
            procGetAllUserList();
        }

        if (commonValueInviteDeleteUserOrg == reqStatus) {
            showAlert("success", "멤버삭제를 성공하였습니다.");
            procGetAllUserList();
        }
    };


    // ADD USER ROLE
    var procAddUserRole = function () {
        if (procCheckInviteValidation()) {
            procCheckUserValidation();
        }
    };


    // CHECK INVITE VALIDATION
    var procCheckInviteValidation = function () {
        var inviteUserId = $("#inviteUserId").val();
        var thisUserId;
        var userList;
        var userListCount;
        var tempMap;
        var i;

        if (inviteUserId == null || inviteUserId == "") {
            showAlert("error", '사용자 이메일을 입력하세요.');
            return false;
        }

        thisUserId = $('#thisUserId').val();

        if (inviteUserId == thisUserId) {
            showAlert("error", '본인을 초대할 수 없습니다.');
            return false;
        }

        userList = USER_LIST;
        userListCount = userList.length;

        for (i = 0; i < userListCount; i++) {
            tempMap = userList[i];

            if(inviteUserId == tempMap.userName){
                showAlert("error", '현재 조직에 초대된 사용자 입니다.');
                return false;
            }
        }

        return true;
    };


    // CHECK INVITE USER VALIDATION
    var procCheckUserValidation = function () {
        procCallAjax("/user/getUser", {userId: $("#inviteUserId").val()}, procCallbackUserValidationCheck);
    };


    // CHECK INVITE USER VALIDATION CALLBACK
    var procCallbackUserValidationCheck = function (data) {
        if (RESULT_STATUS_FAIL == data.RESULT) {
            return false;
        }

        if (data.User == null) {
            showAlert("success", '<spring:message code="User_not_found" />');
            return false;
        }

        procSendEmailInviteUser();
    };


    // SEND EMAIL INVITE USER
    var procSendEmailInviteUser = function () {
        var objInvitedFormOrgListTable = $("#invitedFormOrgListTable");
        var objInvitedFormSpaceListTable = $("#invitedFormSpaceListTable");
        var row = objInvitedFormSpaceListTable.find('tr');
        var rowCount = row.length / 3;
        var tempList = [];
        var dataList = [];
        var param;
        var i;

        for (i = 1; i <= rowCount; i++) {
            if ($('#spaceManagers' + i).prop("checked")) {
                tempList = [];
                tempList.push("space");
                tempList.push(row[(i - 1) * 3].children[0].textContent.trim());
                tempList.push(commonValueUserSpaceManager);
                dataList.push(tempList);
            }
            if ($('#spaceDevelopers' + i).prop("checked")) {
                tempList = [];
                tempList.push("space");
                tempList.push(row[(i - 1) * 3].children[0].textContent.trim());
                tempList.push(commonValueUserSpaceDeveloper);
                dataList.push(tempList);
            }
            if ($('#spaceAuditors' + i).prop("checked")) {
                tempList = [];
                tempList.push("space");
                tempList.push(row[(i - 1) * 3].children[0].textContent.trim());
                tempList.push(commonValueUserSpaceAuditor);
                dataList.push(tempList);
            }
        }

        if ($('#orgManagers').prop("checked")) {
            tempList = [];
            tempList.push("org");
            tempList.push(objInvitedFormOrgListTable.find('tr')[0].children[0].textContent.trim());
            tempList.push(commonValueUserOrgManager);
            dataList.push(tempList);
        }
        if ($('#orgBillingManagers').prop("checked")) {
            tempList = [];
            tempList.push("org");
            tempList.push(objInvitedFormOrgListTable.find('tr')[0].children[0].textContent.trim());
            tempList.push(commonValueUserBillingManager);
            dataList.push(tempList);
        }
        if ($('#orgAuditors').prop("checked")) {
            tempList = [];
            tempList.push("org");
            tempList.push(objInvitedFormOrgListTable.find('tr')[0].children[0].textContent.trim());
            tempList.push(commonValueUserOrgAuditor);
            dataList.push(tempList);
        }

        if (0 == dataList.length) {
            showAlert("fail", '초대할 정보가 없습니다.');
            return false;
        }

        param = {
            inviteUserId: $("#inviteUserId").val(),
            dataList: dataList
        };

        procCallAjax("/invite/inviteEmailSend", param, procCallbackSendEmailInviteUser);

    };


    // SEND EMAIL INVITE USER CALLBACK
    var procCallbackSendEmailInviteUser = function (data) {
        if (RESULT_STATUS_FAIL == data.RESULT) {
            return false;
        }

        if (data.rtnCnt > 0) {
            showAlert("success", '<spring:message code="common.info.result.success" />');
        } else {
            showAlert("fail", '<spring:message code="common.info.result.fail" />');
        }

        procGetAllUserList();
        procResetInviteForm();
    };


    // RESET INVITE FORM
    var procResetInviteForm = function () {
        procSelectAllOrgInInviteForm(false);
        procSelectAllSpaceInInviteForm(false);

        $('#invitedFormSpaceListArea').hide();
        $('#inviteUserFormArea').hide();
        $('#userListFormArea').show();
        $('#inviteUserId').val('');
    };


    // SELECT ALL ORG IN INVITE FORM
    var procSelectAllOrgInInviteForm = function (reqStatus) {
        var objOrgCheckboxButton = $("#invitedFormOrgCheckboxButton");
        var bChk;

        if (null != reqStatus && undefined != reqStatus) {
            bChk = reqStatus;
        } else {
            bChk = objOrgCheckboxButton.prop("checked");
        }

        $('#orgManagers').prop("checked", bChk);
        $('#orgBillingManagers').prop("checked", bChk);
        $('#orgAuditors').prop("checked", bChk);
        objOrgCheckboxButton.prop("checked", bChk);
    };


    // SELECT ALL SPACE IN INVITE FORM
    var procSelectAllSpaceInInviteForm = function (reqStatus) {
        var objSpaceCheckboxButton = $("#invitedFormSpaceCheckboxButton");
        var objSpaceListTable = $("#invitedFormSpaceListTable");
        var row = objSpaceListTable.find('tr');
        var bChk;
        var i;

        if (null != reqStatus && undefined != reqStatus) {
            bChk = reqStatus;
        } else {
            bChk = objSpaceCheckboxButton.prop("checked");
        }

        for (i = 1; i <= row.length; i++) {
            $('#spaceManagers' + i).prop("checked", bChk);
            $('#spaceDevelopers' + i).prop("checked", bChk);
            $('#spaceAuditors' + i).prop("checked", bChk);
        }

        objSpaceCheckboxButton.prop("checked", bChk);
    };


    // DOMAIN INPUT BOX :: KEY PRESS EVENT
    $("#addDomain-TextField").keypress(function (e) {
        if (e.which == 13) {
            e.preventDefault();
            if(document.getElementById("btn-addDomain").disabled == false) {
                procAddDomain();
            }
        }
    });


    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // INIT
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    // GET ORG SUMMARY
    var procGetOrgSummary = function () {
        procCallSpinner(SPINNER_SPIN_START);
        procCallAjax("/org/getOrgSummary", {orgName: currentOrg}, procCallbackGetOrgSummary);
    };


    // GET ORG SUMMARY CALLBACK
    var procCallbackGetOrgSummary = function (data) {
        var objOrg;

        if (RESULT_STATUS_FAIL == data.RESULT) {
            return false;
        }

        $("#memoryUsage").text(data.memoryUsage / 1024);
        $("#memoryLimit").text(data.memoryLimit / 1024);
        $("#memoryPercent").text(parseInt(data.memoryUsage / data.memoryLimit * 100));
        $("#memoryBar").css("width", data.memoryUsage / data.memoryLimit * 100 + "%");
        $("#spaceCnt").html(data.spaces.length);

        objOrg = $('#org');
        objOrg.val(currentOrg);

        procSetOrgMainButtons();
        getWebIdeUser();
        procSetSpaceListTable(data);
        procGetDomainList(commonValueDomainPrivate);
        procResetInviteForm();
        procInitInviteForm(objOrg.val());

    };


    // INIT INVITE FORM
    var procInitInviteForm = function (orgName) {
        procCallAjax("/space/getSpaces", {orgName: orgName}, procCallbackInitInviteForm);
    };


    // INIT INVITE FORM CALLBACK
    var procCallbackInitInviteForm = function (data) {
        var objInvitedFormSpaceList;
        var htmlString;
        var tempCount;

        if (RESULT_STATUS_FAIL == data.RESULT) {
            return false;
        }

        objInvitedFormSpaceList = $('#invitedFormSpaceListTable');
        htmlString = [];
        tempCount = 1;

        $('#invitedFormCurrentOrg').text(currentOrg);

        objInvitedFormSpaceList.html('');
        $.each(data, function (eventID, eventData) {
            htmlString.push('<tr><td rowspan="3" style="text-align: center; vertical-align:middle;">'
                + eventData.name + '</td><td>'
                + '<input style="margin-left: 10px;" type="checkbox" id="spaceManagers'+ tempCount +'"/>'
                + '<span style="margin-left: 5px; font-size: 14px;">공간 관리자(Space Managers)</span><br>'
                + '<h3 style="margin-top: 2px; margin-left: 10px; color: #a0a0a0;">'
                + '사용자를 조직에 초대하고 조직내 할당된 공간에 대한 사용자의 역할을 관리</h3></td></tr><tr><td>'
                + '<input style="margin-left: 10px;" type="checkbox" id="spaceDevelopers'+ tempCount +'"/>'
                + '<span style="margin-left: 5px; font-size: 14px;">공간 개발자(Space Development)</span><br>'
                + '<h3 style="margin-top: 2px; margin-left: 10px; color: #a0a0a0;">'
                + '앱과 서비스를 생성, 삭제 관리할수 있고 앱에대한 로그와 문서들에 접근</h3></td></tr><tr><td>'
                + '<input style="margin-left: 10px;" type="checkbox" id="spaceAuditors'+ tempCount +'"/>'
                + '<span style="margin-left: 5px; font-size: 14px;">공간 감사(Space Auditor)</span><br>'
                + '<h3 style="margin-top: 2px; margin-left: 10px; color: #a0a0a0;">'
                + '공간의 사용자, 역할, 도메인, 쿼타정보를 열람</h3></td></tr>');
            tempCount++;
        });

        objInvitedFormSpaceList.append(htmlString);
        $('#invitedFormSpaceListArea').show();
    };


    $(document).ready(function () {
        $('#footer').hide();
        procGetOrgSummary();
    });


</script>

<%@include file="../layout/bottom.jsp" %>
