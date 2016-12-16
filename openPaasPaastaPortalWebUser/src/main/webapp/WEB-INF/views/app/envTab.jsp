<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
    var environment = {};
    var updateEnvironment = {};

    $(document).ready(function () {
        getApplicationEnv(false)
    });


    function getApplicationEnv(isUpdated) {

        var param = {
            orgName: currentOrg,
            spaceName: currentSpace,
            name: currentApp
        }

        $.ajax({
            url: "/app/getApplicationEnv",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function (data) {
                if (data) {

                    document.getElementById("systemProvidedEnv").innerHTML = JSON.stringify(data, undefined, 2)
                    if (JSON.stringify(data.environment_json) == "{}") {
                        document.getElementById("noEnvMsg").style = ""
                    } else {
                        $.each(data.environment_json, function (eventID, eventData) {
                            setUpdateUserEnvBox(eventID, eventData, isUpdated)
                        });
                        document.getElementById("noEnvMsg").style = "display: none"
                    }
                    environment = data.environment_json
                }
            },
            error: function (xhr, status, error) {
                showAlert("fail", JSON.parse(xhr.responseText).message)
            },
            complete: function () {

            }
        });
    }

    function updateApplicationEnv(isDeleted, appEnvName) {

        var param = {
            orgName: currentOrg,
            spaceName: currentSpace,
            name: currentApp,
            environment: updateEnvironment
        }

        $.ajax({
            url: "/app/updateApplicationEnv",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function (data) {
                if (data) {
                    if (isDeleted) {
                        deleteAction(appEnvName)
                    }
                    getApplicationEnv(true)
                }
            },
            error: function (xhr, status, error) {
                getApplicationEnv(false)
                showAlert("fail", JSON.parse(xhr.responseText).message)
            },
            complete: function () {

            }
        });
    }

    function changeApplicationEnv(doWhat, appEnvName, appEnvValue) {

        switch (doWhat) {
            case 'add':
                updateEnvironment[appEnvName] = appEnvValue;
                updateApplicationEnv();
                break;
            case 'modify':
                var appEnvValue = $("#" + appEnvName + "UpdateTextField").val()
                updateEnvironment[appEnvName] = appEnvValue;
                updateApplicationEnv();
                break;
            case 'delete':
                $('#modal').modal('hide');
                delete updateEnvironment[appEnvName]
                updateApplicationEnv(true, appEnvName);
                break;
        }

    }


    function toggleAddUserEnvBox() {

        $("#addUserEnvBox").slideToggle()
    }


    function toggleUpdateUserEnvBox(appEnvName) {

        $("#" + appEnvName + "UpdateBox").slideToggle()
    }


    function envInputValidation(appEnvName, appEnvValue) {
        if (appEnvName == "") {
            //환경변수 이름이 없음
            document.getElementById("btn-addUserEnv").disabled = true;

        } else if (environment.hasOwnProperty(appEnvName)) {
            //환경변수 이름이 이미 존재함
            document.getElementById("btn-addUserEnv").disabled = true;

        } else if (appEnvValue == "") {
            //환경변수 값이 없음
            document.getElementById("btn-addUserEnv").disabled = true;

        } else if (appEnvName.includes(' ') || appEnvValue.includes(' ')) {
            // 변수 이름/값에 공백이 포함
            document.getElementById("btn-addUserEnv").disabled = true;

        } else {
            document.getElementById("btn-addUserEnv").disabled = false;
        }

    }


    function setUpdateUserEnvBox(eventID, eventData, isUpdated) {

        var updateUserEnvBox =
                "<div class='env-list-box' id='userEnvBox" + eventID + "'>" +
                "<div>" + eventID +
                "<button type='button' class='close'  onclick=removeEnvPopUp('" + eventID + "')>" +
                "<span class='glyphicon glyphicon-remove' style='font-size: 14px;' aria-hidden='true'></span>" +
                "</button>" +
                "<button type='button' class='close' style='margin-right: 8px' onclick=toggleUpdateUserEnvBox('" + eventID + "')>" +
                "<span class='glyphicon glyphicon-info-sign' style='font-size: 14px;' aria-hidden='true'></span>" +
                "</button>" +
                "</div>" +
                "<div id='" + eventID + "UpdateBox' style='display: none; margin: 10px'>" +
                "<input class='form-control' id='" + eventID + "UpdateTextField' type='text' maxlength='200' value='" + eventData + "' size='15' style='width: 50%;'>" +
                "<div style='float: right'>" +
                "<button type='button' class='btn btn-cancel btn-sm' onclick=toggleUpdateUserEnvBox('" + eventID + "')>취소" +
                "</button>" +
                "<button type='button' class='btn btn-save btn-sm' onclick=changeApplicationEnv('modify','" + eventID + "')>저장" +
                "</button>" +
                "</div>" +
                "</div>" +
                "</div>"

        if (isUpdated) {
            if (!environment.hasOwnProperty(eventID)) {
                //env가 추가된 경우
                $("#appEnv").append(updateUserEnvBox)
                $("#envNameTextField").val("")
                $("#envValueTextField").val("")
                $("#addUserEnvBox").hide()
                showAlert("success", "사용자 환경변수가 추가되었습니다. 이 작업을 반영 하려면 앱을 리스테이징하세요.")

            } else if (environment.hasOwnProperty(eventID) && environment[eventID] != eventData) {

                $("#" + eventID + "UpdateTextField").value = eventData
                $("#" + eventID + "UpdateBox").hide()
                showAlert("success", "사용자 환경변수가 변경되었습니다. 이 작업을 반영 하려면 앱을 리스테이징하세요.")

            } else if (environment.hasOwnProperty(eventID) && environment[eventID] == eventData) {
                //env 값이 그대로인 경우
            }
        } else {
            updateEnvironment[eventID] = eventData
            $("#appEnv").append(updateUserEnvBox)
        }
    }


    function deleteAction(appEnvName) {
        if ($.isEmptyObject(updateEnvironment)) {
            document.getElementById("noEnvMsg").style = ""
        }
        $("#userEnvBox" + appEnvName).remove()
        showAlert("success", "사용자 환경변수가 삭제되었습니다. 이 작업을 반영 하려면 앱을 리스테이징하세요.")
    }

    function removeEnvPopUp(appEnvName) {
        $("#modalTitle").html("환경변수 삭제");
        $("#modalText").html("환경변수 '" + appEnvName + "'를 삭제하시겠습니까?");
        $("#modalCancelBtn").text("취소");
        $("#modalExecuteBtn").text("삭제");
        $("#modalExecuteBtn").show();
        $('#modalExecuteBtn').attr('onclick', "changeApplicationEnv('delete','" + appEnvName + "')");

        $('#modal').modal('toggle');
    }

</script>
<div class="tab-title-box" style="text-align:center;background-color: #fafafa;"><font style="padding-left:38px;">사용자
    정의</font>
    <button type="button" class="btn btn-point btn-sm" style="float: right; margin:-3px"
            onclick="toggleAddUserEnvBox()">+ 추가
    </button>
</div>
<div class="tab-title-box" id="addUserEnvBox" style="display: none;">
    <input class='form-control' id="envNameTextField" type='text' maxlength='100' placeholder="환경변수 이름"
           style='width: 70%; height: 35px; margin: 1px;'
           onkeyup="envInputValidation(envNameTextField.value, envValueTextField.value)"><br>
    <input class='form-control' id="envValueTextField" type='text' maxlength='100' placeholder="값"
           style='width: 70%; height: 35px; margin: 1px;margin-left: 95px;'
           onkeyup="envInputValidation(envNameTextField.value, envValueTextField.value)">

    <div style="float: right">
        <button type="button" class="btn btn-cancel btn-sm"
                onclick="toggleAddUserEnvBox()">취소
        </button>
        <button id="btn-addUserEnv" type="button" class="btn btn-save btn-sm"
                onclick="changeApplicationEnv('add',envNameTextField.value, envValueTextField.value)" disabled="true"
                style='margin-top: -8px;'>추가
        </button>
    </div>
</div>


<div>
    <div class="env-list-box" id="noEnvMsg" style="display: none;">사용자 정의 환경변수 없음</div>
    <div id="appEnv"></div>
</div>

<div style="margin-top: 10px">
    <div class="tab-title-box" style="margin-top: 10px; background-color: #fafafa;">
        시스템 제공
    </div>
    <pre id="systemProvidedEnv" style="border:none; line-height: 20px; font-size: small; height:150px;">

    </pre>

</div>
