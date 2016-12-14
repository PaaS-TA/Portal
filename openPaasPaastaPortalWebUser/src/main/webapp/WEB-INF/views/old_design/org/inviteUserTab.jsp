<%@page contentType="text/html" pageEncoding="UTF-8" %>
<script>
    var inviteOrg;
    function initInviteOrg(orgName) {
        inviteOrg = orgName;
        setInviteOrg(orgName);
    }
    function getSpacesByOrg(orgName) {
        var param = {
            orgName: orgName
        };
        $.ajax({
            url: "/space/getSpaces",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function (spaceByOrg) {
                if (spaceByOrg) {
                    setInviteSpaceList(spaceByOrg);
                    showAlert("success", '<spring:message code="common.info.result.success" />');
                }
            },
            error: function (xhr, status, error) {
                <%--showAlert("fail", '<spring:message code="common.info.result.fail" />');--%>
            },
        });
    }
    function inviteCancelBtn(){
        $('#userTab1').show();
        $('#inviteUserTab').hide();
    }
    function selectOrgAll(){
        var bChk = $("#orgAll").prop("checked");
        $('#orgManagers').prop("checked",bChk);
        $('#orgBillingManagers').prop("checked",bChk);
        $('#orgAuditors').prop("checked",bChk);
    }
    function selectSpaceAll(){
        var spaceByOrg = $("#spaceByOrg");
        var row = spaceByOrg.find('tr');
        var bChk = $("#spaceAll").prop("checked");
        for(var i = 1;i <= row.length;i++){
            $('#spaceManagers'+i).prop("checked",bChk);
            $('#spaceDevelopers'+i).prop("checked",bChk);
            $('#spaceAuditors'+i).prop("checked",bChk);
        }
    }
    function setInviteOrg(orgName){
        $("#orgList1 *").remove();
        $("#orgList1").append(
                "<tr style=' height:18px'>"+
                '<td width="40%">'+orgName+'</td>'+
                '<td width="20%"><input type = checkbox id ="orgManagers"/></td>'+
                '<td width="20%"><input type = checkbox id ="orgBillingManagers"/></td>'+
                '<td width="20%"><input type = checkbox id ="orgAuditors" /></td>'+
                '</tr>'
        );
        getSpacesByOrg(orgName);
    }
    function  setInviteSpaceList(data){
        $("#spaceByOrg *").remove();
        var n = 1;
        $.each(data, function (eventID, eventData) {
            if(data){
                $("#spaceByOrg").append(
                        "<tr style=' height:18px'>"+
                        '<td width="40%">'+eventData.name+'</td>'+
                        '<td width="20%"><input type = checkbox id ="spaceManagers'+ n +'"  /></td>'+
                        '<td width="20%"><input type = checkbox id ="spaceDevelopers'+ n +'" /></td>'+
                        '<td width="20%"><input type = checkbox id ="spaceAuditors'+ n +'" /></td>'+
                        '</tr>'
                );
                n++;
            }else{
                $("#spaceByOrg").append(
                        '<tr>'+
                        '<td colspan="4"> 조회된 내역이 없습니다.</td>'+
                        '</tr>'
                )
            }

        });
    }

    function validataionCheck() {
        var inviteUserId = $("#inviteuUerId")[0].value;
        if(inviteUserId==null || inviteUserId==""){
            showAlert("error", '사용자 이메일을 입력하세요.');
            return;
        }
        var thisUserId =$('#thisUserId').val();
        var rtn = false;

        if(inviteuUerId==thisUserId){
            showAlert("error", '본인을 초대할 수 없습니다.');
            return false;
        }
        for (var i=0;i<userList.length; i++){
            var map = userList[i];
            if(inviteUserId == map.userName){
                showAlert("error", '현재 조직에 초대된 사용자 입니다.');
                return false;
            }
        }
        procCallSpinner(SPINNER_SPIN_START);
        var param = {
            userId: inviteUserId
        };
        $.ajax({
            url: "/user/getUser",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function (data) {
                if(data.User==null){
                    showAlert("success", '<spring:message code="User_not_found" />');
                    return false;
                }

                else{
                   inviteOrgSpaceRole();
                    return true;
                }
            },
            error: function (xhr, status, error) {
                showAlert("fail", '<spring:message code="common.info.result.fail" />');
            },
            complete: function (data) {
                procCallSpinner(SPINNER_SPIN_STOP);
            }
        });
        return rtn;
    }
    function addOrgSpaceRole() {
        validataionCheck();
    }
    function inviteOrgSpaceRole() {
        var spaceByOrg = $("#spaceByOrg");
        var row = spaceByOrg.find('tr');
        var dataList = [];

        for(var i=1;i <= row.length;i++){

            if($('#spaceManagers'+i).prop("checked")){
                var list= [];
                list.push("space");
                list.push(row[i-1].children[0].textContent);
                list.push("SpaceManager");
                dataList.push(list);
            }
            if($('#spaceDevelopers'+i).prop("checked")){
                var list= [];
                list.push("space");
                list.push(row[i-1].children[0].textContent);
                list.push("SpaceDeveloper");
                dataList.push(list);
            }
            if($('#SpaceAuditor'+i).prop("checked")){
                var list= [];
                list.push("space");
                list.push(row[i-1].children[0].textContent);
                list.push("spaceAuditors");
                dataList.push(list);
            }
        }
        if($('#orgManagers').prop("checked")){
            var list= [];
            list.push("org");
            list.push( $("#orgList1").find('tr')[0].children[0].textContent);
            list.push("OrgManager");
            dataList.push(list);
        }
        if($('#orgBillingManagers').prop("checked")){
            var list= [];
            list.push("org");
            list.push( $("#orgList1").find('tr')[0].children[0].textContent);
            list.push("BillingManager");
            dataList.push(list);
        }
        if($('#orgAuditors').prop("checked")){
            var list= [];
            list.push("org");
            list.push( $("#orgList1").find('tr')[0].children[0].textContent);
            list.push("OrgAuditor");
            dataList.push(list);
        }
        if(dataList.length==0){
            showAlert("fail", '초대할 정보가 없습니다.');
            return;
        }
        var param = {
            inviteUserId: $("#inviteuUerId")[0].value,
            dataList: dataList
        };
        $.ajax({
            url: "/invite/inviteEmailSend",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function (spaceByOrg) {
                if (spaceByOrg.rtnCnt>0) {
                    showAlert("success", '<spring:message code="common.info.result.success" />');

                }else{
                    showAlert("fail", '<spring:message code="common.info.result.fail" />');
                }
                $('#userTab1').show();
                $('#inviteUserTab').hide();
            },
            error: function (xhr, status, error) {
                showAlert("fail", '<spring:message code="common.info.result.fail" />');
            },
            complete: function (data) {
                initUserTab();
            }

        });
    }
</script>

<div style="overflow:hidden; font-size: 13px">
    <form name='inviteForm' onsubmit='addOrgSpaceRole()'>
        <input type="hidden" id="thisUserId" value='<sec:authentication property="principal.username" />'/>
        <div class="tab-title-box" style="background-color: #e2e3e4;margin-top: 0px;" >
            새로운 사용자를 초대
        </div>
        <div style=" height:14px"> </div>
        <div class="form-group">
            <label style=" float: left; width : 15%">&nbsp; &nbsp;사&nbsp;용&nbsp;자&nbsp;  &nbsp;이&nbsp;메&nbsp;일&nbsp; &nbsp;:&nbsp; </label>
        </div>
        <input class="form-control" style="align-items: center; margin-top: 0px; width: 50%"
               placeholder="sample@example.com" id="inviteuUerId" type="email"
               value="${inviteuUerId}"
               required="required"
               pattern="^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$"/>
    </form>
    <div style=" height:15px"> </div>
    <div id="inviteUserTab-spinner" class="userTable-spinner" style="width: 50%; float: left; position: relative" hidden>
        <span> 사용자를 초대중입니다.. </span>
        <i class="fa fa-refresh fa-spin" style="font-size:15px;"></i>
    </div>
    <div style=" height:15px"> </div>
    <div id="inviteUserTab-initspinner" class="userTable-spinner" style="width: 50%; float: left; position: relative" hidden>
        <span> 사용자를 초대중입니다.. </span>
        <i class="fa fa-refresh fa-spin" style="font-size:15px;"></i>
    </div>
    <div>
        <div id="orgTable-container" style=" float: left;width:60%; position: relative">
            <div class="tab-title-box" style="background-color: #e2e3e4; font-style: inherit;">
                할당된 조직
            </div>
            <div style=" height:1px"> </div>
            <table class="table table-striped table-hover t1" name="orgTable1">
                <thead>
                <tr align="top">
                    <th width="40%">조직</th>
                    <th width="20%">조직관리</th>
                    <th width="20%">조직결제관리</th>
                    <th width="20%">조직감사</th>
                </tr>
                </thead>
                <tbody id="orgList1">
                </tbody>
                <tfoot>
                <tr style="background-color: #FFFFFF;margin-top: 0px;">
                    <td colspan="4"><input type = checkbox  name = "orgAll"  id = "orgAll" onclick="selectOrgAll()">전체선택</td>
                </tr>
                </tfoot>
            </table>
        </div>
        <div id='orgRole-description' style='width: 35%; float: right;'>
            <div style='font-weight: bold'>조직 역할</div><br>
            <div style='font-weight: bold'>조직 관리자(Org Managers)</div>
            <div>사용자를 조직에 초대하고 조직내 모든 공간에 대한 사용자의 역할을 관리</div>
            <div style='font-weight: bold'>조직 결제 관리자(Org Billing Manager)</div>
            <div>결제 계정과 결제 정보를 관리</div>
            <div style='font-weight: bold'>조직감사(Org Auditor)</div>
            <div>조직의 사용자, 역할, 도메인, 쿼타정보를 열람</div>

        </div>
    </div>
    <div>

        <div id="spaceTable-container" style=" float: left; width: 60%; position: relative">
            <div class="tab-title-box" style="background-color: #e2e3e4;width:100%; font-style: inherit;">
                할당된 공간
            </div>
            <div style=" height:1px"> </div>
            <table class="table table-striped table-hover t1" name="orgSpace1">
                <thead>
                <tr>
                    <th width="40%">공간</th>
                    <th width="20%">공간관리</th>
                    <th width="20%">공간개발관리</th>
                    <th width="20%">공간감사</th>
                </tr>
                </thead>
                <tbody id="spaceByOrg" name ="spaceByOrg">
                </tbody>
                <tfoot>
                <tr>
                    <td colspan="4"><input type =checkbox id="spaceAll" name ="spaceAll" onclick="selectSpaceAll()">전체선택</td>
                </tr>
                </tfoot>
            </table>
        </div>
        <div id='userRole-description' style='width: 35%; float: right;'>
            <div style='font-weight: bold'>공간 역할<br></div>
            <div style='font-weight: bold'>공간 관리자(Space Managers)</div>
            <div>사용자를 조직에 초대하고 조직내 할당된 공간에 대한 사용자의 역할을 관리</div>
            <div style='font-weight: bold'>공간 개발자(Space Development)</div>
            <div>앱과 서비스를 생성, 삭제 관리할수 있고 앱에대한 로그와 문서들에 접근</div>
            <div style='font-weight: bold'>공간 감사(Space Auditor)</div>
            <div>조직의 사용자, 역할, 도메인, 쿼타정보를 열람</div>

        </div>
    </div>
    <div style="float: right; margin-top: 10px">
        <button type="button" class="btn btn-cancel btn-sm" onclick="inviteCancelBtn()">
            취소
        </button>
        <button id="btn-addDomain" type="button" class="btn btn-success btn-sm" onclick="addOrgSpaceRole()">
            초대
        </button>
    </div>
</div>
