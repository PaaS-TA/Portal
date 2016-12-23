<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>

    function initRouteTab(data) {

        $("#domainSelectBox *").remove()

        $.each(data.available_domains, function (eventID, eventData) {
            $("#domainSelectBox").append("<option value='" + eventData.name + "'>" + eventData.name + "</option>");
        });

        $("#urisBox *").remove()

        var routeCount = 0;

        $.each(data.routes, function (eventID, eventData) {
            var uri = eventData.host + "." + eventData.domain.name
            $("#urisBox").append(
                    "<div style='height: 50px; line-height: 50px; margin-left: 3px'; color:#979696;>" +
                    "<a href= 'http://" + uri + "' target='_blank'><font color='#979696'>" + uri +
                    "</font></a>" +
                    "<button style='float:right; margin: 10px' type='button' class='btn btn-cancel btn-sm' " +
                    "onclick=removeUriModal('" + eventData.host + "','" + eventData.domain.name + "')>연결해제" +
                    "</button>" +
                    "</div>"
            );

            routeCount++;

        });

        $('#routeCount').html(routeCount);

        $('#addRoute-TextField').keypress(function (e) {
            if (e.which == 13) {
                e.preventDefault();
                if (document.getElementById("btn-addRoute").disabled == false) {
                    addApplicationRoute('addRoute')
                }
            }
        });


    }

    function toggleAddRouteBox() {
        $('#addRouteBox').slideToggle()
    }


    function removeUriModal(host, domainName) {

        $("#modalTitle").html("라우트 해제");
        $("#modalText").html("'" + currentApp + "'과 '" + host + "." + domainName + "'의 연결을 해제하시겠습니까?");
        $("#modalCancelBtn").text("취소");
        $("#modalExecuteBtn").text("해제");
        $("#modalExecuteBtn").show();
        $('#modalExecuteBtn').attr('onclick', "removeApplicationRoute('" + host + "','" + domainName + "')");

        $('#modal').modal('toggle');
    }

    function addApplicationRoute(id) {

        var param = {
            orgName: currentOrg,
            spaceName: currentSpace,
            name: currentApp,
            host: $("#addRoute-TextField").val(),
            domainName: $("#domainSelectBox").val()
        }

        $.ajax({
            url: "/app/addApplicationRoute",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function (data) {
                if (data) {
                    getAppSummary()
                    document.getElementById("addRoute-TextField").value = ""
                    $('#addRouteBox').hide()
                    showAlert("success", "라우트가 추가되었습니다.")
                }
            },
            error: function (xhr, status, error) {
                textFieldChange(id, 'error')
                showAlert("fail", JSON.parse(xhr.responseText).message)

            },
            complete: function () {

            }
        });

    }

    function removeApplicationRoute(host, domainName) {

        param = {
            orgName: currentOrg,
            spaceName: currentSpace,
            name: currentApp,
            host: host,
            domainName: domainName
        }

        $.ajax({
            url: "/app/removeApplicationRoute",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function (data) {
                if (data) {
                    getAppSummary()
                    document.getElementById("addRoute-TextField").value = ""
                    $("#addRouteBox").hide()
                    showAlert("success", "라우트가 해제되었습니다.")
                }
            },
            error: function (xhr, status, error) {

                showAlert("fail", JSON.parse(xhr.responseText).message)

            },
            complete: function () {
                $('#modal').modal('hide');
            }
        });

    }

    function routeValidation(id) {
        var domainName = $("#domainSelectBox").val();
        var hostName = $("#" + id + "-TextField").val()
        var uri = hostName + "." + domainName
        //hostName에는 .(dot)허용안함
        var route_validation = /^[a-zA-Z-_0-9]{1,70}\s?[a-zA-Z-_0-9]{1,70}$/;

        if (hostName == "") {
            //호스트이름이 없음
            textFieldChange(id, 'warning')
            document.getElementById("btn-addRoute").disabled = true;

        } else if (isExistUri(uri)) {
            //현재 앱에 바인드된 호스트명과 동일
            textFieldChange(id, 'error')
            document.getElementById("btn-addRoute").disabled = true;
        } else {
            if (!route_validation.test(hostName)) {
                //영문이 아닌 문자가 포함되었거나 70자를 초과하는 경우
                textFieldChange(id, 'error')
                document.getElementById("btn-addRoute").disabled = true;
            } else {
                textFieldChange(id, 'ok')
                document.getElementById("btn-addRoute").disabled = false;
            }
        }
    }

    function isExistUri(uri) {
        var uris = $("#urisBox").find('div').find('a')
        var isExist = false
        $.each(uris, function (eventID, eventData) {
            if (eventData.textContent == uri) {
                isExist = true
                return false
            }
        });
        return isExist
    }

</script>
<div class="custom-tab-title-box" style="background-color: #f5f7f8;">라우트
    <button type="button" style="float: right; margin:-3px" class="btn btn-save btn-sm" onclick="toggleBox('addRoute')">
        + 연결
    </button>
</div>

<div class="tab-title-box" id="addRouteBox" style="display: none">

    <div class="inner-addon right-addon">
        <input id="addRoute-TextField" type="text" maxlength="200" class="form-control-warning"
               onkeyup="routeValidation('addRoute')" placeholder="추가할 호스트 이름을 입력하세요." style="width: 50%;">
        <span id="addRoute-StatusIcon" class="glyphicon status-icon-warning"></span>

        <select id="domainSelectBox" style="width: 20%;"></select>
        <div style="float:right; margin-top: 10px">
            <button type="button" class="btn btn-cancel btn-sm" onclick="toggleBox('addRoute')">
                취소
            </button>
            <button id="btn-addRoute" type="button" class="btn btn-save btn-sm"
                    onclick="addApplicationRoute('addRoute')" disabled="true" style='margin-top: -8px;'>
                추가
            </button>
        </div>
    </div>

</div>

<div class="route-list-box" id="urisBox">

</div>
