<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../layout/top.jsp" %>
<%@include file="../layout/left.jsp" %>
<%@include file="../layout/alert.jsp" %>

<div class="row" style="min-height: 600px;">
    <div class="panel content-box col-sm-3 col-md-6" style="margin-top:150px; margin-left:60px;">
        <div class="col-sm-12 pt0">
            <h6 class="modify_h6 fwb mt10 text-center">PaaS-TA에서 애플리케이션 개발과 배포, 관리를 시작하세요.</h6>
        </div>
        <div style="padding: 80px 5px 20px; margin-left: 100px;">
            <form class="form-horizontal" role="form">
                <div class="form-group">
                    <label class="control-label col-sm-3" for="createOrg-TextField"><span style="font-weight:normal; font-size:15px;">조직명</span></label>
                    <div class="col-sm-8">
                        <input id="createOrg-TextField" type="text" maxlength="60" class="form-control-warning" onkeyup="createOrg_validation('createOrg');" placeholder="e.g.account-org">
                        <span id="createOrg-StatusIcon" class="glyphicon status-icon-warning custom-status-position"></span>
                    </div>
                    <div class="col-sm-11" id="statusMessage" style="width: 90%; color: crimson; font-size:11px; margin-top:5px; margin-right:2%; margin-left:26%;">
                        조직 이름을 입력하세요.
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-5 pt20 tar ml60">
                        <button type="button" id="btn-createOrg" class="btn btn-orange btn-sm" onclick="createOrg();" disabled>
                            조직생성
                        </button>
                        <button type="button" id="btn-cancelCreateOrg" class="btn btn-cancel btn-sm" onclick="moveLocationOrgMain();">
                            취소
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <div class="col-sm-3 col-md-5" style="margin-top:150px; margin-left:60px;">
        <div class="col-sm-12 pt0">
            <h5 class="fwb mt10"><span class="glyphicon glyphicon-ok mr10"></span>조직은 컴퓨팅 리소스, 애플리케이션 및 서비스를 포괄하는 개발 계정입니다.</h5>
            <h5 class="fwb mt20"><span class="glyphicon glyphicon-ok mr10"></span>개인이나 다수의 공동 작업자가 소유 하거나 사용 할 수 있습니다.</h5>
            <h5 class="fwb mt20"><span class="glyphicon glyphicon-ok mr10"></span>프로젝트의 이름이나 팀의 이름으로 조직의 조직의 이름을 설정하세요.</h5>
            <h5 class="fwb mt20"><span class="glyphicon glyphicon-ok mr10"></span>조직 별 메모리 제한은 10G입니다.</h5>
            <h5 class="fwb mt20"><span class="glyphicon glyphicon-ok mr10"></span>용량 추가는 나의 문의를 통해 요청해 주시기 바랍니다.</h5>
        </div>
    </div>
</div>

<script>

    $(document).ready(function () {
        if (currentOrg == 'null') {
            $("#btn-cancelCreateOrg").hide();
            document.getElementById("menuCurrentOrg").textContent = "";
            document.getElementById("menuCurrentOrg").onclick = "";
            showAlert("success", "조직이 없습니다. 먼저 조직을 생성하세요.")
        }


        $('#createOrg-TextField').keypress(function (e) {
            if (e.which == 13) {
                e.preventDefault();
                if (document.getElementById("btn-createOrg").disabled == false) {
                    createOrg($("#createOrg-TextField").val())
                }
            }
        });
    });

    function createOrg() {
        var newOrgName = $("#createOrg-TextField").val();
        var param = {
            newOrgName: newOrgName
        };

        $.ajax({
            url: "/org/createOrg",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function (data) {
                if (data) {
                    createSpaceDev(newOrgName)
                }
            },
            error: function (xhr, status, error) {
                procTextFieldChange('createOrg', 'error');
                showAlert("fail", JSON.parse(xhr.responseText).message);
            }
        });
    }

    function createSpaceDev(orgName) {

        var param = {
            orgName: orgName,
            newSpaceName: "dev"
        };

        $.ajax({
            url: "/space/createSpace",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function (data) {
                if (data) {
                    setOrgSession(orgName)
                }
            },
            error: function (xhr, status, error) {
                procTextFieldChange('createOrg', 'error');
                showAlert("fail", JSON.parse(xhr.responseText).message);
            }
        });
    }

    function createOrg_validation(id) {
        var newOrgName = $("#" + id + "-TextField").val();
        //이름 정규식 영문2자 이상, 특수문자는 -와 _만 허용
        var createOrg_validation = /^[a-zA-Z-_.0-9ㄱ-ㅎ|ㅏ-ㅣ|가-힣]{1,15}\s?[a-zA-Z-_.0-9ㄱ-ㅎ|ㅏ-ㅣ|가-힣]{1,15}$/;

        if (!createOrg_validation.test(newOrgName)) {
            if (newOrgName == "") {
                procTextFieldChange(id, 'warning');
                document.getElementById("statusMessage").textContent = "조직 이름을 입력하세요."
            } else {
                procTextFieldChange(id, 'error');
                document.getElementById("statusMessage").textContent = "조직이름은 2자이상 30자 이하, 특수문자는 bar(-)와 underscore(_)만 허용합니다."
            }
            document.getElementById("btn-createOrg").disabled = true

        } else if (newOrgName.includes(' ')) {
            procTextFieldChange(id, 'error');
            document.getElementById("statusMessage").textContent = "조직이름은 공백을 포함할 수 없습니다.";
            document.getElementById("btn-createOrg").disabled = true

        } else if ($("#orgList [value = '" + newOrgName + "']").text() != "") {
            document.getElementById("btn-createOrg").disabled = true;
            procTextFieldChange(id, 'error');
            document.getElementById("statusMessage").textContent = "이미 존재하는 조직 이름입니다."
        } else {
            procTextFieldChange(id, 'ok');
            document.getElementById("btn-createOrg").disabled = false;
            document.getElementById("statusMessage").textContent = ""
        }
    }

</script>

<%@include file="../layout/bottom.jsp" %>