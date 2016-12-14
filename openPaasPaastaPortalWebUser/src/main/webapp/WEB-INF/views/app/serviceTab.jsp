<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>

    var serviceOpt = new Array();

    $(window).load(function () {
        getServices();
    });


    function getServices() {

        param = {
            orgName: currentOrg,
            spaceName: currentSpace
        }

        $.ajax({
            url: "/space/getSpaceSummary",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function (data) {

                $("#spaceList2").html("");

                $.each(data.services, function (id, list) {

                    var services = new Object();

                    if (list.servicePlan == undefined) {
                        servicePlan = "";
                    } else {
                        servicePlan = list.servicePlan.name;
                    }

                    if (list.servicePlan == undefined) {
                        label = "user-provided";

                    } else {
                        label = list.servicePlan.service.label;
                    }


                    if (JSON.stringify(serviceList).indexOf(list.name) < 0) {
                        $("#serviceSelect").append("<option value='" + list.name + "'>" + list.name + "</option>");
                    } else {
                        $("#spaceList2").append(" <tr height='40'>" +
                                "<td style='height:20px;padding-left:20px;text-align:left;color:#979696' width='25%' class='eventTable'> " + list.name + "</td>" +
                                "<td style='padding-left:20px;text-align:left;color:#979696' width='25%' class='eventTable' > &nbsp;" + servicePlan + "</td>" +
                                "<td style='padding-left:20px;text-align:left;color:#979696' width='25%' class='eventTable' > &nbsp;" + label + "</td>" +
                                "<td style='padding-left:20px;text-align:center;color:#979696' width='20%' class='eventTable'> <button type='button' class='btn btn-delete  btn-sm' style='margin-top: 0px;' onClick='unbindService(\"" + list.name + "\")'>연결해제</button> </td>" +
                                "</tr>");
                    }

                });

            }
        });
    }


    function bindService() {

        $('#modalMask').modal('toggle');
        var spinner = new Spinner().spin();

        param = {
            orgName: currentOrg,
            spaceName: currentSpace,
            name: currentApp,
            serviceName: $("#serviceSelect").val()
        }

        $.ajax({
            url: "/app/bindService",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",

            success: function (data) {
                showAlert("success", $("#serviceSelect").val() + " 서비스가 연결되었습니다");
            },

            error: function (xhr, status, error) {
                showAlert("fail", JSON.parse(xhr.responseText).message);
            },

            complete: function (data) {
                getAppSummary();
                setTimeout("getServices()", 200);
                spinner.stop();
                $('#modalMask').modal('hide');
            }
        });

    }


    function unbindService(serviceName) {

        $('#modalMask').modal('toggle');
        var spinner = new Spinner().spin();

        param = {
            orgName: currentOrg,
            spaceName: currentSpace,
            name: currentApp,
            serviceName: serviceName
        }

        $.ajax({
            url: "/app/unbindService",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",

            success: function (data) {
                showAlert("success", serviceName + " 서비스가 해제되었습니다");
            },

            error: function (xhr, status, error) {
                showAlert("fail", JSON.parse(xhr.responseText).message);
            },

            complete: function (data) {
                getAppSummary();
                setTimeout("getServices()", 200);
                spinner.stop();
                $('#modalMask').modal('hide');
            }
        });

    }

</script>

<div align="right" style='margin:px;' id="createSpaceBtn">
    <button type="button" class="btn btn-save btn-sm" style='margin-top: -20px;margin-right: 11px;'
            onclick="toggleBox('addService')">
        + 서비스 연결
    </button>
</div>
<div class="tab-title-box" id="addServiceBox" style="display: none">

    <div class="inner-addon right-addon">

        서비스명 : <select id="serviceSelect" style="width: 20%;height: 30px"></select>&nbsp;&nbsp;&nbsp;

        파라미터 : <input id="addServiceParam" type="text" maxlength="200" class="form-control-warning" style="width: 25%;">

        <button id="btn-addService" type="button" class="btn btn-save btn-sm" style='margin-top: -3px;'
                onclick="bindService()">
            연결
        </button>
        <button type="button" class="btn btn-cancel btn-sm" style='margin-top: -3px;' onclick="toggleBox('addService')">
            취소
        </button>

    </div>

</div>

<div style="margin: 0px 0px 0px 0px;width:100%;">
    <table width="100%" class="event-table">
        <thead>
        <tr height="40">
            <th style="background-color: #f6f6f6; padding-left:20px; text-align:left;"><font size="3px">이름</font></th>
            <th style="background-color: #f6f6f6; padding-left:20px; text-align:left;"><font size="3px">제공서비스</font>
            </th>
            <th style="background-color: #f6f6f6; padding-left:20px; text-align:left;"><font size="3px">서비스명</font></th>
            <th style="background-color: #f6f6f6; padding-left:20px; text-align:center;"><font size="3px">연결해제</font>
            </th>
        </tr>
        </thead>
        <tbody id="spaceList2">
        </tbody>
    </table>
</div>
