<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016-06-17
  Time: 오전 9:18
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../layout/top.jsp" %>
<%@include file="../layout/left.jsp" %>
<%@include file="../layout/alert.jsp" %>


<script>

    $(document).ready(function () {
        if(currentOrg == 'null'){
            $("#btn-cancelCreateOrg").hide()
            document.getElementById("menuCurrentOrg").textContent = "";
            document.getElementById("menuCurrentOrg").onclick="";
            showAlert("success","조직이 없습니다. 먼저 조직을 생성하세요.")
        }


        $('#createOrg-TextField').keypress(function (e) {
            if (e.which == 13) {
                e.preventDefault();
                if(document.getElementById("btn-createOrg").disabled == false){
                    createOrg($("#createOrg-TextField").val())
                }
            }
        });
    });

    function createOrg() {
        var newOrgName = $("#createOrg-TextField").val()
        var param = {
            newOrgName: newOrgName
        }

        $.ajax({
            url: "/org/createOrg",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function (data) {
                if(data){
                    createSpaceDev(newOrgName)
                }
            },
            error: function (xhr,status,error) {
                textFieldChange('createOrg','error')
                showAlert("fail",JSON.parse(xhr.responseText).message);
            }
        });
    }

    function createSpaceDev(orgName) {

        var param = {
            orgName: orgName,
            newSpaceName: "dev"
        }

        $.ajax({
            url: "/space/createSpace",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function (data) {
                if(data){
                    setOrgSession(orgName)
                }
            },
            error: function (xhr,status,error) {
                textFieldChange('createOrg','error')
                showAlert("fail",JSON.parse(xhr.responseText).message);
            }
        });
    }

    function createOrg_validation(id) {
        var newOrgName = $("#"+id+"-TextField").val()
        //이름 정규식 영문2자 이상, 특수문자는 -와 _만 허용
        var createOrg_validation=/^[a-zA-Z-_.0-9ㄱ-ㅎ|ㅏ-ㅣ|가-힣]{1,15}\s?[a-zA-Z-_.0-9ㄱ-ㅎ|ㅏ-ㅣ|가-힣]{1,15}$/;

        if (!createOrg_validation.test(newOrgName)) {

            if (newOrgName==""){
                textFieldChange(id,'warning')
                document.getElementById("statusMessage").textContent="조직 이름을 입력하세요."
            } else{
                textFieldChange(id,'error')
                document.getElementById("statusMessage").textContent="조직이름은 2자이상 30자 이하, 특수문자는 bar(-)와 underscore(_)만 허용합니다."
            }
            document.getElementById("btn-createOrg").disabled = true

        } else if (newOrgName.includes(' ')) {
            textFieldChange(id,'error')
            document.getElementById("statusMessage").textContent="조직이름은 공백을 포함할 수 없습니다."
            document.getElementById("btn-createOrg").disabled = true

        } else if($("#orgList [value = '"+newOrgName+"']").text()!=""){
            document.getElementById("btn-createOrg").disabled = true
            textFieldChange(id,'error')
            document.getElementById("statusMessage").textContent="이미 존재하는 조직 이름입니다."
        } else{
            textFieldChange(id,'ok')
            document.getElementById("btn-createOrg").disabled = false
            document.getElementById("statusMessage").textContent=""
        }
    }

</script>

<br>
<br>
<div style="margin-left:2%; width:98%; height: 70%;">
    <div>
    <h1>개방형 플랫폼에서 애플리케이션 개발과 배포, 관리를 시작하세요.</h1>
    </div>

    <div style="margin-left: 3%; width: 95%">
        <h4 style="margin-bottom: 15px; margin-top: 80px; font-size: medium">조직을 생성하세요.</h4>
        <div style="width:55%; float: left;">

            <div id="createOrgBox" style="width:58%; float: left;">
                <label style="font-size: small; color: grey">
                    조직명
                </label>

                <div class="inner-addon right-addon">
                    <input id="createOrg-TextField" type="text" maxlength="100" class="form-control-warning" onkeyup="createOrg_validation('createOrg')" placeholder="e.g.account-org" style="padding-right: 30px">
                    <span id="createOrg-StatusIcon" class="glyphicon status-icon-warning" style="right: 5px; padding:7px; position: absolute"></span>

                    <button id="btn-createOrg" type="button" class="btn btn-save btn-sm" style="width: 100%; margin-top: 3px" onclick="createOrg()" disabled="true">
                        조직 생성
                    </button>
                    <button id="btn-cancelCreateOrg" type="button" class="btn btn-cancel btn-sm" style="width: 100%; margin-top: 1px" onclick="moveLocationOrgMain()">
                        취소
                    </button>

                </div>

            </div>

            <div id="statusMessage" style="width: 39%;font-size: x-small; color: crimson; float: right; margin-left: 1%; margin-right: 2%; margin-top: 20px;">
               조직 이름을 입력하세요.
            </div>

        </div>

        <div style="width:25%; float: right; margin-right: 20%">

            <h3>조직은 컴퓨팅 리소스, 애플리케이션 및 서비스를 포괄하는 개발 계정입니다.</h3><br>
            <h3>개인이나 다수의 공동 작업자가 소유 하거나 사용 할 수 있습니다.</h3><br>
            <h3>프로젝트의 이름이나 팀의 이름으로 조직의 조직의 이름을 설정하세요.</h3><br>

        </div>
    </div>
</div>

<%@include file="../layout/bottom.jsp" %>