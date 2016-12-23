<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../layout/top.jsp" %>
<%@include file="../layout/left.jsp" %>
<%@include file="../layout/alert.jsp" %>

<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<style>
    body {
        font-family: "Spoqa Han Sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
    }

</style>

<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<script src="//malsup.github.com/jquery.form.js"></script>
<script type="text/javascript" src="/resources/js/raphael-2.1.4.min.js"></script>
<script type="text/javascript" src="/resources/axisj/lib/AXModal.js"></script>
<script type="text/javascript" src="/resources/axisj/lib/AXJ.js"></script>

<link href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet">
<script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
<script>

    var instances;
    var memory;
    var disk;
    var serviceList;
    var pUseYn;
    var icon_class;
    var apmUrl;
    var apmAppName;
    var apmServer;
    var vcapServices;

    var routeList = [];

    $(document).ready(function () {

        $("#instances").spinner({
            min: 1, max: 1000, step: 1, start: 0
        });
        $("#memory").spinner({
            min: 256, max: 1000000, step: 256, start: 0
        });

        $("#disk").spinner({
            min: 256, max: 1000000, step: 256, start: 0
        });
        $('[data-toggle="tooltip"]').tooltip({
            delay: {"show": 0, "hide": 500}
        });
        $('.tooltip-right').tooltip({
            placement: 'right',
            size: '10px',
            viewport: {selector: 'body', padding: 2}
        });

        getAppSummary();
        getAppEvents();

        $('#reducetoggle').on('onblur', function () {
            $("[data-toggle='tooltip']").tooltip({delay: {"show": 500, "hide": 1000}});
        })

        //setInterval("getAppEvents()", 15000);

    });

    function sleep(num) {
        var now = new Date();
        var stop = now.getTime() + num;
        while (true) {
            now = new Date();
            if (now.getTime() > stop)return;
        }
    }

    var AutoScaleToggleWorking = false;

    function getAppAutoScaleToggle(pMode) {
        //alert(pMode);
        if (AutoScaleToggleWorking == true) {
            return;
        }

        AutoScaleToggleWorking = true;

        var url;
        var useYn;
        if (pMode == 'get') {
            url = "/app/getAppAutoScaleInfo";
        }
        if (pMode == 'update') {
            url = "/app/updateAppAutoScale";
        }

        if ($("#toggle").prop('checked')) {
            increaseYn = 'Y';
            $("#appUse").prop("checked", true);
        } else {
            increaseYn = 'N';
            $("#appUse").prop("checked", false);
        }

        if ($("#reducetoggle").prop('checked')) {
            decreaseYn = 'Y';
            $("#appUse2").prop("checked", true);
        } else {
            decreaseYn = 'N';
            $("#appUse2").prop("checked", false);
        }


        var param = {
            mode: pMode
            , url: url
            , guid: currentAppGuid
            , autoIncreaseYn: increaseYn
            , autoDecreaseYn: decreaseYn
        };
        var options = {
            url: "/app/getAppAutoScaleInfo",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function (data) {
                var pUseYn;
                var pUseYn2 = 'N';
                if (data.list == null) {
                    pUseYn = 'N';
                } else {
                    pUseYn = data.list.autoIncreaseYn;
                    pUseYn2 = data.list.autoDecreaseYn;
                }

                if (pMode == "get") {
                    setAutoScaling(pUseYn);
                    setAutoScaling2(pUseYn2);
                }

            },
            error: function (xhr, status, error) {
                showAlert("fail", JSON.parse(xhr.responseText).message)
            },
            complete: function () {
                sleep(1000);
                AutoScaleToggleWorking = false;
            }
        };
        $.ajax(options);
    }

    /**
     * Auto-Scaling toogle  변환
     */

    function setAutoScaling(pUseYn) {
        if (pUseYn == 'Y') {
            $("#toggle").prop("checked", true);
        } else {
            $("#toggle").prop("checked", false);

        }
    }

    function setAutoScaling2(pUseYn2) {
        if (pUseYn2 == 'Y') {
            $("#reducetoggle").prop("checked", true);

        } else {
            $("#reducetoggle").prop("checked", false);

        }
    }


    function getAppSummary() {

        $('#modalMask').modal('toggle');
        var spinner = new Spinner().spin();

        param = {
            guid: currentAppGuid
        };

        routeList = [];

        $.ajax({
            url: "/app/getAppSummary",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function (data) {
                if (data) {
                    $("#app").val(data.name);

                    $("#state").text(data.state);

                    if (data.routes[0] != null) {
                        $("#uris").html("<a target='_blank' href='http://" + data.routes[0].host + "." + data.routes[0].domain.name + "'>" + data.routes[0].host + "." + data.routes[0].domain.name + "</a>");
                    }

                    var tooltipUris = "";
                    var tempTooltipUris = "";

                    $.each(data.routes, function (eventID, eventData) {
                        tempTooltipUris = eventData.host + "." + eventData.domain.name;
                        tooltipUris = tooltipUris + tempTooltipUris + "<br>"

                        routeList.push(tempTooltipUris);
                    });

                    $("#uris").tooltip({
                        content: tooltipUris,
                        track: true,
                        open: function (event, ui) {
                            ui.tooltip.css("max-width", "500px");
                        }

                    });


                    if (data.package_updated_at != null) {
                        $("#updated").text(data.package_updated_at.replace('T', '  ').replace('Z', ' '));
                    }

                    if (data.detected_buildpack != null && data.detected_buildpack != "") {
                        $("#buildpack").text(data.detected_buildpack.substring(0, 40) + "..");
                    } else if (data.buildpack != null) {
                        $("#buildpack").text(data.buildpack.substring(0, 40) + "..");
                    }


                    $("#instances").val(data.instances);
                    $("#memory").val(data.memory);
                    $("#disk").val(data.disk_quota);

                    instances = data.instances;
                    memory = data.memory;
                    disk = data.disk_quota;

                    serviceList = data.services;
                    $("#serviceCnt").html(serviceList.length);


                    $.each(serviceList, function (key, serviceObj) {
                        if (serviceObj.service_plan != undefined) {
                            if (serviceObj.service_plan.service != undefined && serviceObj.service_plan.service.label == "Pinpoint") {
                                $("#apmBtn").attr("disabled", false);

                                if (data.detected_start_command.indexOf("org.springframework.boot.loader.WarLauncher") > 0) {
                                    apmServer = "SPRING_BOOT";
                                } else {
                                    apmServer = "TOMCAT";
                                }

                                apmAppName = data.detected_start_command.substring(data.detected_start_command.indexOf("applicationName") + 16);
                                apmAppName = apmAppName.substring(0, apmAppName.indexOf(" "));
                                apmAppName = apmAppName.replace('"', '');

                                getServiceInstance(serviceObj.name);
                            }
                        }

                    });


                    if (data.state == "STARTED") {
                        $("#stateButton").text("중지");
                        $("#state").text("실행 중");
                        icon_class =
                                $("#appBorder").css('box-shadow', '0px 0px 2px 2px #00FF00');
                        getAppStats();
                        setInterval("getAppStats()", 30000);

                    } else if (data.state == "STOPPED") {
                        $("#stateButton").text("시작");
                        $("#state").text("정지");
                        icon_class =
                                $("#appBorder").css('box-shadow', '0px 0px 2px 2px #BBBBBB');
                    } else {
                        $("#stateButton").text("시작");
                        $("#appBorder").css('box-shadow', '0px 0px 2px 2px #FF0000');
                    }
                    initRouteTab(data);
                    $("#uris").tooltip();

                }
            },

            error: function (xhr, status, error) {
                location = "/login";
            },

            complete: function (data) {

                spinner.stop();
                $('#modalMask').modal('hide');

            }

        });

    }


    function getServiceInstance(name) {

        param = {
            orgName: currentOrg,
            spaceName: currentSpace,
            name: name
        };

        $.ajax({
            url: "/service/getServiceInstance",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function (data) {
                if (data) {
                    apmUrl = data.dashboardUrl + "/" + apmAppName + "@" + apmServer;
                }
            }
        });
    }


    function openApmUrl() {

        window.open(apmUrl, '_blank');

    }


    function getAppStats() {

        param = {
            guid: currentAppGuid
        };

        $.ajax({
            url: "/app/getAppStats",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function (data) {
                if (data) {

                    var cpu = 0;
                    var mem = 0;
                    var disk = 0;
                    var cnt = 0;

                    $.each(data, function (key, dataobj) {
                        if (procCheckValidNull(dataobj.stats.usage.cpu)) cpu = cpu + dataobj.stats.usage.cpu * 100;
                        if (procCheckValidNull(dataobj.stats.usage.mem)) mem = mem + dataobj.stats.usage.mem / dataobj.stats.mem_quota * 100;
                        if (procCheckValidNull(dataobj.stats.usage.disk)) disk = disk + dataobj.stats.usage.disk / dataobj.stats.disk_quota * 100;
                        cnt++;
                    });
                    $("#g1").text((cpu / cnt).toFixed(1) + "%");
                    $("#g2").text((mem / cnt).toFixed(1) + "%");
                    $("#g3").text((disk / cnt).toFixed(1) + "%");

                    $("#g1bar").css("width", Math.round(cpu / cnt) + "%")
                    $("#g2bar").css("width", Math.round(mem / cnt) + "%")
                    $("#g3bar").css("width", Math.round(disk / cnt) + "%")

                    // $("#instances").val(cnt);
                    //$("#memory").val(data[0].stats.mem_quota / 1024 / 1024);
                    //$("#disk").val(data[0].stats.disk_quota / 1024 / 1024);

                    // alert(data.records[0].usage.cpu);

                    if (data[0].state == "RUNNING") {
                        $("#stateButton").text("중지");
                        $("#appBorder").css('box-shadow', '0px 0px 2px 2px #00FF00');
                    } else if (data[0].state == "CRASHED" || data[0].state == "DOWNED") {
                        $("#stateButton").text("시작");
                        $("#appBorder").css('box-shadow', '0px 0px 2px 2px #FF0000');
                        $("#state").text(data[0].state);
                    } else {
                        $("#stateButton").text("시작");
                        $("#appBorder").css('box-shadow', '0px 0px 2px 2px #BBBBBB');
                        $("#state").text(data[0].state);
                    }

                    procSetAppStatusTab(data);


                }
            },

            error: function (xhr, status, error) {

            }
        });
    }


    function renameAppModal() {

        $("#modalTitle").html("앱이름 수정");
        $("#modalText").html(currentApp + "앱명을 " + $('#app').val() + " 으로 수정하시겠습니까?");
        $("#modalCancelBtn").text("취소");
        $("#modalExecuteBtn").text("수정");
        $("#modalExecuteBtn").show();
        $('#modalExecuteBtn').attr('onclick', 'renameApp();');

        $('#modal').modal('toggle');
    }

    function renameApp() {
        param = {
            orgName: currentOrg,
            spaceName: currentSpace,
            name: currentApp,
            newName: $('#app').val()
        };

        $.ajax({
            url: "/app/renameApp",
            method: "POST",
            async: "false",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function (data) {
                if (data) {
                    showAlert('success', "앱명이 수정되었습니다.");
                    currentApp = $('#app').val();
                }


                $('#renameAppModalBtn').attr('disabled', true);

                getAppEvents();


            },
            error: function (xhr, status, error) {
                showAlert('fail', JSON.parse(xhr.responseText).message);
            },
            complete: function (data) {
                $('#modal').modal('hide');
            }

        });
    }


    function deleteAppModal() {

        $("#modalTitle").html("앱 삭제");
        $("#modalText").html("앱를 삭제하면 되돌릴 수 없습니다. <br> " + currentApp + " 를  삭제하시겠습니까?");
        $("#modalCancelBtn").text("취소");
        $("#modalExecuteBtn").text("삭제");
        $("#modalExecuteBtn").show();
        $('#modalExecuteBtn').attr('onclick', 'deleteApp()');

        $('#modal').modal('toggle');
    }

    function deleteApp() {
        param = {
            orgName: currentOrg,
            spaceName: currentSpace,
            name: currentApp,
            guid: currentAppGuid
        };

        $.ajax({
            url: "/app/deleteApp",
            method: "POST",
            async: "false",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function (data) {
                if (data) {
                    deleteRoute();
                    //$("#modalExecuteBtn").hide();
                    //$("#modalCancelBtn").text("확인");
                }
            },
            error: function (xhr, status, error) {
                showAlert('fail', JSON.parse(xhr.responseText).message);
            },
            complete: function (data) {
                $('#modal').modal('hide');
            }
        });
    }


    function deleteRoute() {
        param = {
            orgName: currentOrg,
            spaceName: currentSpace,
            urls: routeList
        };

        $.ajax({
            url: "/app/deleteRoute",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function (data) {
                if (data) {
                    showAlert('success', "앱이 삭제되었습니다.");
                    location = "/space/spaceMain";
                }
            },
            error: function (xhr, status, error) {
                showAlert("fail", JSON.parse(xhr.responseText).message)
            },
            complete: function (data) {
                $('#modal').modal('hide');
            }
        });
    }


    function stateExec() {

        $('#modalMask').modal('toggle');
        var spinner = new Spinner().spin();

        param = {
            orgName: currentOrg,
            spaceName: currentSpace,
            name: currentApp
        };

        var url;
        if ($("#state").text() == "실행 중") {
            url = "/app/stopApp";
        } else {
            url = "/app/startApp";
        }

        $.ajax({
            url: url,
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function (data) {
                if (data) {
                    if (url == "/app/stopApp") {
                        showAlert('success', "앱이 중지되었습니다.");
                        $("#stateButton").text("시작");
                        $("#state").text("중지");
                        $("#appBorder").css('box-shadow', '0px 0px 2px 2px #CCCCCC');

                        getAppEvents();

                    } else {
                        showAlert('success', "앱이 시작되었습니다.");
                        $("#stateButton").text("중지");
                        $("#state").text("중지");
                        $("#appBorder").css('box-shadow', '0px 0px 2px 2px #00FF00');

                        getAppStats();
                        getAppEvents();
                    }
                }
            },

            error: function (xhr, status, error) {
                showAlert('fail', JSON.parse(xhr.responseText).message);
            },

            complete: function (data) {
                spinner.stop();
                $('#modalMask').modal('hide');

            }

        });
    }


    function updateApp() {
        var instancesChange = 0;
        var memoryChange = 0;
        var diskChange = 0;
        var msg = "";

        if (instances != $('#instances').val()) {
            instancesChange = $('#instances').val();
            msg = "앱 인스턴스를 변경했습니다.";
        }

        if (memory != $('#memory').val()) {
            memoryChange = $('#memory').val();
            msg = "앱 메모리를 변경했습니다.";
        }

        if (disk != $('#disk').val()) {
            diskChange = $('#disk').val();
            msg = "앱 디스크를 변경했습니다.";
        }

        if (msg == "") {
            showAlert('fail', "앱 변경 사항이 없습니다.");
            return;
        }

        $('#modalMask').modal('toggle');
        var spinner = new Spinner().spin();


        param = {
            orgName: currentOrg,
            spaceName: currentSpace,
            name: currentApp,
            guid: currentAppGuid,
            instances: instancesChange,
            memory: memoryChange,
            diskQuota: diskChange
        };

        $.ajax({
            url: "/app/updateApp",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function (data) {
                if (data) {
                    showAlert('success', msg);
                    instances = $('#instances').val();
                    memory = $('#memory').val();
                    disk = $('#disk').val();
                    getAppEvents();
                    $('#instanceSaveBtn').attr('disabled', true);
                }
            },

            error: function (xhr, status, error) {
                showAlert('fail', JSON.parse(xhr.responseText).message);
            },

            complete: function (data) {
                spinner.stop();
                $('#modalMask').modal('hide');

            }
        });
    }


    function restageApp() {

        $('#modalMask').modal('toggle');
        var spinner = new Spinner().spin();


        param = {
            orgName: currentOrg,
            spaceName: currentSpace,
            guid: currentAppGuid
        };

        $.ajax({
            url: "/app/restageApp",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function (data) {
                if (data) {


                    showAlert('success', "앱이 리스테이징 되었습니다.");
                }
            },

            error: function (xhr, status, error) {
                showAlert('fail', JSON.parse(xhr.responseText).message);
            },

            complete: function (data) {
                spinner.stop();
                $('#modalMask').modal('hide');

            }
        });
    }

    function cancel() {
        $("#memory").val(memory);
        $("#instances").val(instances);
        $("#disk").val(disk);
    }


    function changeAppName() {

        if ($('#app').val() == currentApp) {
            $('#renameAppModalBtn').attr('disabled', true);
        } else {
            $('#renameAppModalBtn').attr('disabled', false);
        }

    }


</script>

<div class="panel content-box col-sm-3 col-md-5 col-md-offset-13  mt-5">
    <table width="100%" style="margin:10px 10px 80px 10px;line-height:2.7em;font-size:15px;">
        <tr>
            <td>앱 이름</td>
            <td><input type="text" name="app" id="app" size="10" class="form-control3" maxlength="30"
                       style="line-height:1.5em;width:200px"
                       onkeyup="changeAppName()" onkeydown="if(event.keyCode==13) { renameAppModal(); return false;}">
                <button type="button" class="btn btn-cancel btn-sm" onClick="renameAppModal()" style="margin-top: -4px"
                        id="renameAppModalBtn" disabled>
                    이름변경
                </button>
                <button type="button" class="btn btn_del" onClick="deleteAppModal()" style="margin-top: -4px">
                    <span class="glyphicon glyphicon-trash"></span>
                </button>
            </td>
        </tr>
        <tr>
            <td>앱 URL</td>
            <td><span id="uris" style="color:#a2a2a2" title="tooltip"></span></td>
        </tr>
        <tr>
            <td>마지막 푸시 날짜 &nbsp;</td>
            <td><span id="updated" style="color:#a2a2a2"></span></td>
        </tr>
        <tr>
            <td>앱 개발환경</td>
            <td><span id="buildpack" style="color:#a2a2a2"></span></td>
        </tr>
        <tr>
            <td>앱 상태</td>
            <td><b><span id="state"></span></b>&nbsp;
                <button id="stateButton" type="button" class="btn btn-default" style="margin-bottom:0px"
                        onClick="stateExec()"><b>시작</b></button>
                <button id="restageButton" type="button" class="btn btn-primary" onClick="restageApp()"><b>리스테이지</b>
                </button>
            </td>
        </tr>

    </table>

</div>
<!--//내용-->
<!--인스턴스 설정-->
<div class="panel-gray content-box col-sm-3 col-md-7 col-md-offset-13 mt-5">
    <table width="96%" style="margin: 0px 0px 0px 20px;" border="0">
        <tr>
            <td width="25%" style="font-size:20px; padding:0 0 10px 18px; color:#fff">&nbsp;&nbsp;인스턴스</td>
            <td width="25%" style="font-size:19px; padding:0 0 11px 10px; color:#fff">&nbsp;&nbsp;메모리(MB)</td>
            <td width="25%" style="font-size:19px; padding:0 0 11px 8px; color:#fff">&nbsp;&nbsp;디스크(MB)</td>
            <td width="15%"></td>
        </tr>
        <tr>
            <td style="width:10%">
                      <span class="quantity">
                        <input id="instances" name="instances" size="5" maxlength="3" style="width:100px"
                               onfocus="$('#instanceSaveBtn, #instanceCancelBtn').attr('disabled', false);">
                      </span>
            </td>
            <td>
                      <span class="quantity">
                        <input id="memory" name="memory" size="5" maxlength="7" style="width:100px"
                               onfocus="$('#instanceSaveBtn, #instanceCancelBtn').attr('disabled', false);">
                      </span>
            </td>
            <td>
                      <span class="quantity">
                        <input id="disk" name="disk" size="5" maxlength="7" style="width:100px"
                               onfocus="$('#instanceSaveBtn, #instanceCancelBtn').attr('disabled', false);">
                      </span>
            </td>
            <td align="right">
                <button type="button" class="btn btn-save btn-sm" onClick="updateApp()" id="instanceSaveBtn">
                    저장
                </button>
                <button type="button" class="btn btn-cancel2 btn-sm"
                        onClick="cancel();$('#instanceSaveBtn, #instanceCancelBtn').attr('disabled', true);"
                        id="instanceCancelBtn">
                    취소
                </button>
            </td>
        </tr>
    </table>
</div>
<!--//인스턴스 설정-->


<!--그래프-->
<div class="panel content-box col-sm-3 col-md-7 col-md-offset-13">
    <table width="98%" style="margin-left:10px; margin-right: 10px;" border="0">
        <tr>
            <td align="left" width="18%">
                <span style="position: relative;font-size: 14px">가상머신 자동확장&nbsp;</span>
            </td>
            <td align="left" width="10%">
                <div class="onoffswitch">
                    <input type="checkbox" name="onoffswitch" class="onoffswitch-checkbox" id="toggle"
                           onClick="getAppAutoScaleToggle('update')">
                    <label class="onoffswitch-label" for="toggle">
                        <span class="onoffswitch-inner"></span>
                        <span class="onoffswitch-switch"></span>
                    </label>
                </div>
            </td>
            <td align="left" width="18%">
                <span style="position: relative;font-size: 14px">가상머신 자동축소</span>&nbsp;
            </td>
            <td align="left" width="7%">
                <div class="onoffswitch2">
                    <input type="checkbox" name="onoffswitch2" class="onoffswitch2-checkbox" id="reducetoggle"
                           onClick="getAppAutoScaleToggle('update')">
                    <label class="onoffswitch2-label" for="reducetoggle">
                        <span class="onoffswitch2-inner"></span>
                        <span class="onoffswitch2-switch"></span>
                    </label>
                </div>
            </td>
            <td align="left" width="15%">
                <span class="glyphicon glyphicon-exclamation-sign" style="height:10px;color:#c90305"></span>
                <span id="provider"
                      style="position: relative; height:10px;color:#c90305; align-content: center"
                      data-toggle="tooltip" data-placement="right" data-size="mini"
                      title="인스턴스 자동 축소는 시스템에 영향을 줄 수 있습니다.">경고 </span>
            </td>
            <td align="right" width="20%">
                <%@include file="envAppScale.jsp" %>

                <button type="button" id="apmBtn" class="btn btn-orange btn-sm " onclick="openApmUrl()"
                        style="margin-top: 0px" disabled>
                    APM 대시보드
                </button>
            </td>
        </tr>
    </table>
    <table width="98%" style="margin-left:10px; margin-right:10px; margin-top:0px;" border="0">
        <tr>
            <td align="left" width="10%" style="padding:9px 0px 0px 1px;">
                <span><font
                        style="color:#929292; letter-spacing: 3px; font-size: 22px; font-weight: bold;">CPU</font></span>
            </td>
            <td align="left">
                <div class="graph ml10 mt20">
                    <div id="g1bar" class="graph-cpubar" role="graph" id="memoryBar" aria-valuenow="0" aria-valuemin="0"
                         aria-valuemax="100" style="width: 0%;">
                        <span style="color:#fff; float:right;margin-right:15px;margin-top:3px;font-size: 15px"></span>
                    </div>
                    &nbsp;
                    <span id="g1"></span>
                </div>
            </td>
        </tr>
        <tr>
            <td align="left" width="10%">
                <span><font style="color:#929292; letter-spacing: -2px; font-size: 20px; font-weight: bold;">메모리</font></span>
            </td>
            <td align="left">
                <div class="graph ml10 mt-3">
                    <div id="g2bar" class="graph-memoriebar graph-memoriebar-info" role="progressbar" aria-valuenow="20"
                         aria-valuemin="0" aria-valuemax="100" style="width: 0%">
                        <span style="color:#fff; float:right;margin-right:15px;margin-top:3px;font-size: 15px"></span>
                    </div>
                    &nbsp;
                    <span id="g2"></span>
                </div>
            </td>
        </tr>
        <tr>
            <td align="left" width="10%">
                <span><font style="color:#929292; letter-spacing: -2px; font-size: 20px; font-weight: bold;">디스크</font></span>
            </td>
            <td align="left">
                <div class="graph ml10 mt-3">
                    <div id="g3bar" class="graph-diskbar graph-diskbar-warning" role="progressbar" aria-valuenow="100"
                         aria-valuemin="0" aria-valuemax="100" style="width: 0%">
                        <span style="color:#fff; float:right;margin-right:15px;margin-top:3px;font-size: 15px"></span>
                    </div>
                    &nbsp;
                    <span id="g3"></span>
                </div>
            </td>
        </tr>
    </table>
</div>
<!--//그래프-->


<div class="panel content-box col-sm-12 col-md-12 mt-50 col-md-offset-13 w98" style="margin-bottom: 20px;">
    <div class="col-sm-12 pt0">

        <div class="content" style="min-width: 1130px">
            <!-- Nav tabs -->
            <ul class="nav nav-tabs" role="tablist" id="myTabs">
                <li role="presentation" class="active"><a href="#eventTab" aria-controls="eventTab" role="tab"
                                                          data-toggle="tab">이벤트</a>
                </li>
                <li role="presentation"><a href="#statusTab" aria-controls="statusTab" role="tab"
                                           data-toggle="tab">상태</a>
                </li>
                <li role="presentation"><a href="#serviceTab" aria-controls="serviceTab" role="tab" data-toggle="tab">서비스(<span
                        id="serviceCnt">0</span>)</a>
                </li>
                <li role="presentation"><a href="#envTab" aria-controls="envTab" role="tab" data-toggle="tab">환경변수</a>
                </li>
                <li role="presentation"><a href="#routeTab" aria-controls="routeTab" role="tab"
                                           data-toggle="tab">라우트(<span
                        id="routeCount">0</span>)</a>
                </li>
                <li role="presentation"><a href="#logTab" aria-controls="logTab" role="tab" data-toggle="tab"
                                           onClick="LogTabinit();">로그</a>
                </li>
                <!--<li role="presentation"><a href="#deliveryTab" aria-controls="deliveryTa
        </div>b" role="tab" data-toggle="tab" onClick="$('#eventTab').hide();$('#serviceTab').hide();$('#envTab').hide();$('#routeTab').hide();$('#logTab').hide();$('#deliveryTab').show();">배포정보</a></li>-->
            </ul>
            <!-- Tab panes -->
            <div class="tab-content" style="min-width: 1130px">

                <div role="tabpanel" class="tab-pane fade in active" id="eventTab">
                    <%@include file="./eventTab.jsp" %>
                </div>

                <div role="tabpanel" class="tab-pane fade in " id="statusTab">
                    <%@include file="./statusTab.jsp" %>
                </div>

                <div role="tabpanel" class="tab-pane fade in " id="serviceTab">
                    <%@include file="./serviceTab.jsp" %>
                </div>

                <div role="tabpanel" class="tab-pane fade in " id="envTab">
                    <%@include file="./envTab.jsp" %>
                </div>

                <div role="tabpanel" class="tab-pane fade in " id="routeTab">
                    <%@include file="./routeTab.jsp" %>
                </div>

                <div role="tabpanel" class="tab-pane fade in " id="logTab">
                    <%@include file="./logTab.jsp" %>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="../layout/bottom.jsp" %>
