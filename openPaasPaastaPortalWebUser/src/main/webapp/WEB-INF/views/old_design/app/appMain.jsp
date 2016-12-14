<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../layout/top.jsp" %>
<%@include file="../layout/left.jsp" %>
<%@include file="../layout/alert.jsp" %>

<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<script src="//malsup.github.com/jquery.form.js"></script>
<script type="text/javascript" src="/resources/js/raphael-2.1.4.min.js"></script>
<script type="text/javascript" src="/resources/js/justgage.js"></script>
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

    var g1;
    var g2;
    var g3;

    var routeList = [];

    $(document).ready(function () {

        $('#eventTab').show();
        $('#statusTab').hide();
        $('#serviceTab').hide();
        $('#envTab').hide();
        $('#routeTab').hide();
        $('#logTab').hide();
        $('#deliveryTab').hide();
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
            delay: { "show": 0, "hide": 500 }
        });
        $('.tooltip-right').tooltip({
            placement: 'right',
            size : '10px',
            viewport: {selector: 'body', padding: 2}
        });
        g1 = new JustGage({
            id: 'g1',
            value: 0,
            decimals: 1,
            min: 0,
            max: 100,
            title: "CPU",
            titleMinFontSize: 16,
            symbol: '%',
            pointer: true,
            gaugeWidthScale: 0.6,
            customSectors: [{
                color: '#ff0000',
                lo: 50,
                hi: 100
            }, {
                color: '#00ff00',
                lo: 0,
                hi: 50
            }],
            counter: true
        });


        g2 = new JustGage({
            id: 'g2',
            title: "메모리",
            titleMinFontSize: 16,
            value: 0,
            decimals: 1,
            min: 0,
            max: 100,
            symbol: '%',
            pointer: true,
            gaugeWidthScale: 0.6,
            customSectors: [{
                color: '#ff0000',
                lo: 50,
                hi: 100
            }, {
                color: '#00ff00',
                lo: 0,
                hi: 50
            }],
            counter: true
        });

        g3 = new JustGage({
            id: 'g3',
            title: "디스크",
            titleMinFontSize: 16,
            value: 0,
            decimals: 1,
            min: 0,
            max: 100,
            symbol: '%',
            pointer: true,
            gaugeWidthScale: 0.6,
            customSectors: [{
                color: '#ff0000',
                lo: 50,
                hi: 100
            }, {
                color: '#00ff00',
                lo: 0,
                hi: 50
            }],
            counter: true
        });
        getAppSummary();
        getAppEvents();

        $('#reducetoggle').on('onblur', function () {
            $("[data-toggle='tooltip']").tooltip({ delay:{"show":500, "hide":1000} });
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

        if($("#toggle").prop('checked')){
            increaseYn = 'Y';
        }else{
            increaseYn = 'N';
        }

        if ($("#reducetoggle").prop('checked')) {
            decreaseYn = 'Y';
        } else {
            decreaseYn = 'N';
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
                if(data.list==null){
                    pUseYn='N';
                }else{
                    pUseYn = data.list.autoIncreaseYn;
                    pUseYn2 = data.list.autoDecreaseYn;
                }

                if (pMode == "get") {
                    setAutoScaling(pUseYn);
                    setAutoScaling2(pUseYn2);
                }

            },
            error: function(xhr,status,error){
                showAlert("fail",JSON.parse(xhr.responseText).message)
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
        if(pUseYn=='Y'){
            $('#toggle').bootstrapToggle('on')
        }else{
            $('#toggle').bootstrapToggle('off')
        }
    }

    function setAutoScaling2(pUseYn2) {
        if (pUseYn2 == 'Y') {
            $('#reducetoggle').bootstrapToggle('on')
        } else {
            $('#reducetoggle').bootstrapToggle('off')
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

                    if (data.detected_buildpack != null && data.detected_buildpack != "" ) {
                        $("#buildpack").text(data.detected_buildpack.substring(0, 40) + "..");
                    } else if(data.buildpack != null) {
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


                    $.each( serviceList, function( key, serviceObj ) {
                        if(serviceObj.service_plan != undefined) {
                            if (serviceObj.service_plan.service != undefined && serviceObj.service_plan.service.label == "Pinpoint") {
                                $("#apmBtn").attr("disabled",false);

                                if (data.detected_start_command.indexOf("org.springframework.boot.loader.WarLauncher") > 0) {
                                    apmServer = "SPRING_BOOT";
                                } else {
                                    apmServer = "TOMCAT";
                                }

                                apmAppName = data.detected_start_command.substring(data.detected_start_command.indexOf("applicationName") + 16);
                                apmAppName = apmAppName.substring(0, apmAppName.indexOf(" "));
                                apmAppName = apmAppName.replace('"','');

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
                        setInterval("getAppStats()", 15000);

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

                fnObj1.pageStart();
            }

        });

    }


    function getServiceInstance(name){

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


    function openApmUrl(){

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

                        $.each( data, function( key, dataobj ) {
                            if (procCheckValidNull(dataobj.stats.usage.cpu)) cpu = cpu + dataobj.stats.usage.cpu * 100;
                            if (procCheckValidNull(dataobj.stats.usage.mem)) mem = mem + dataobj.stats.usage.mem / dataobj.stats.mem_quota * 100;
                            if (procCheckValidNull(dataobj.stats.usage.disk)) disk = disk + dataobj.stats.usage.disk / dataobj.stats.disk_quota * 100;
                            cnt++;
                        });

                        g1.refresh((cpu/cnt).toFixed(1));
                        g2.refresh((mem/cnt).toFixed(1));
                        g3.refresh((disk/cnt).toFixed(1));

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
            name: currentApp
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

                        g1.refresh(0);
                        g2.refresh(0);
                        g3.refresh(0);

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


    function changeAppName(){

        if($('#app').val() == currentApp){
            $('#renameAppModalBtn').attr('disabled', true );
        }else{
            $('#renameAppModalBtn').attr('disabled', false);
        }

    }



</script>

<div class="search_box" style="min-width: 1130px">
    <div class="box_group">
        <div id="appBorder"
             style="margin: 6px; padding: 0px; box-shadow: 0px 0px 2px 2px #BBBBBB; background-color: #f5f7f8; height: 234px;width: 38%;float: left;">

            <table width="100%" style="margin: 10px;line-height:2.7em;font-size:15px;">
                <tr>
                    <td width="120"><b>앱 이름</b></td>
                    <td> : <input type="text" name="app" id="app" size="15" maxlength="30" style="line-height:1.5em"
                              onkeyup="changeAppName()"   onkeydown="if(event.keyCode==13) { renameAppModal(); return false;}">

                        <button type="button" class="btn btn-cancel btn-sm" onClick="renameAppModal()"
                                id="renameAppModalBtn" disabled>
                            이름변경
                        </button>
                        <button type="button" class="btn btn_del" onClick="deleteAppModal()">
                            <span class="glyphicon glyphicon-trash"></span>
                        </button>
                    </td>
                </tr>
                <tr>
                    <td><b>앱 URL</b></td>
                    <td> : <span id="uris" style="color:blue" title="tooltip"></span></td>
                </tr>
                <tr>
                    <td><b>마지막 푸시 날짜</b></td>
                    <td> : <span id="updated"></span></td>
                </tr>
                <tr>
                    <td><b>앱 개발환경</b></td>
                    <td> : <span id="buildpack"></span></td>
                </tr>
                <tr>
                    <td><b>앱 상태</b></td>
                    <td> : <span id="state"></span>&nbsp;
                        <button id="stateButton" type="button" class="btn btn-save btn-sm" onClick="stateExec()">
                            시작
                        </button>
                        <button id="restageButton" type="button" class="btn btn-default btn-sm" onClick="restageApp()">
                            리스테이지
                        </button>
                    </td>
                </tr>

            </table>

        </div>


        <div style="margin: 5px;background-color: #f5f7f8; border: 0;border-color: #FFF;  font-size:15px;  height: 80px;width: 60%;float: left;">
            <table width="96%"  style="margin: 10px;" border ="0">
                <tr>
                    <td width="25%" style="font-size:15px;">&nbsp;&nbsp;인스턴스:</td>
                    <td width="25%" style="font-size:15px;">&nbsp;&nbsp;메모리(MB)</td>
                    <td  style="font-size:15px;">&nbsp;&nbsp;디스크(MB)</td>
                    <td width="20%"></td>
                </tr>
                <tr>
                    <td>&nbsp;&nbsp;<input id="instances" name="instances" size="5" maxlength="3"
                                           onfocus="$('#instanceSaveBtn, #instanceCancelBtn').attr('disabled', false);">
                    </td>
                    <td>&nbsp;&nbsp;<input id="memory" name="memory" size="5" maxlength="7"
                                           onfocus="$('#instanceSaveBtn, #instanceCancelBtn').attr('disabled', false);">
                    </td>
                    <td>&nbsp;&nbsp;<input id="disk" name="disk" size="5" maxlength="7"
                                           onfocus="$('#instanceSaveBtn, #instanceCancelBtn').attr('disabled', false);">
                    </td>
                    <td align="right">
                        <button type="button" class="btn btn-default btn-sm" onClick="updateApp()" id="instanceSaveBtn"
                                disabled>
                            저장
                        </button>
                        <button type="button" class="btn btn-save btn-sm"
                                onClick="cancel();$('#instanceSaveBtn, #instanceCancelBtn').attr('disabled', true);"
                                id="instanceCancelBtn" disabled>
                            취소
                        </button>
                    </td>
                </tr>
            </table>
        </div>

        <div style="margin: 5px;background-color: #ffffff; border: 0;border-color: #FFF; height: 30px; font-size:15px; float: left; text-align:center; width: 60%">
            <table width="96%"  style="margin-left:10px; margin-right: 10px;" border="0">
                <tr>
                    <td align="left" width="30%">
                        <span style="position: relative;top: 2px;margin-left: 10px;">가상머신 자동확장</span>&nbsp;<input
                            type="checkbox"
                            id="toggle"
                            data-toggle="toggle"
                            data-size="mini"
                            style="checked:false; min-height:16px; height:16px;top:2px"
                            onClick="getAppAutoScaleToggle('update')">
                    </td>
                    <td align="left" width="36%">
                        <span style="position: relative;top: 2px">가상머신 자동축소</span>&nbsp;<input
                            type="checkbox"
                            id="reducetoggle"
                            data-toggle="toggle"
                            style="checked:false"
                            data-size="mini"
                    >&nbsp;
                        <span class="glyphicon glyphicon-info-sign" style="height:10px;color:red; top :4px"></span>
                        <span id="provider"
                              style="position: relative;top: 3px; height:10px;color:red; align-content: center"
                              data-toggle="tooltip" data-placement="right" data-size="mini"
                              title="인스턴스 자동 축소는 시스템에 영향을 줄 수 있습니다.">경고 </span>
                    </td>
                    <td align="left" >
                        <span style="position: relative;top: 2px">설정</span>&nbsp;
                        <%@include file="envAppScale.jsp"%>
                    </td>
                    <td align="right" width="20%">
                        <button type="button" id="apmBtn" class="btn btn-save btn-sm" onclick="openApmUrl()" disabled>
                            APM 대시보드
                        </button>
                    </td>

                </tr>
            </table>
        </div>
        <div style="margin: 5px;background-color: #f5f7f8; border: 10px;border-color: #ffffff; height: 110px;width: 60%;float: left;">
            <div style="float: left;width: 33%;height: 100%;border: 1px;">
                <div id="g1"></div>
            </div>
            <div style="float: left;width: 33%;height: 100%;">
                <div id="g2"></div>
            </div>
            <div style="float: left;width: 33%;height: 100%;">
                <div id="g3"></div>
            </div>
        </div>

    </div>
</div>


<div class="content" style="min-width: 1130px">
    <!-- Nav tabs -->
    <ul class="nav nav-tabs" role="tablist" id="myTabs">
        <li role="presentation" class="active"><a href="#eventTab" aria-controls="eventTab" role="tab"
                                                  data-toggle="tab"
                                                  onClick="$('#eventTab').show();$('#statusTab').hide();$('#serviceTab').hide();$('#envTab').hide();$('#routeTab').hide();$('#logTab').hide();$('#deliveryTab').hide();">이벤트</a>
        </li>
        <li role="presentation"><a href="#statusTab" aria-controls="statusTab" role="tab" data-toggle="tab"
                                   onClick="$('#eventTab').hide();$('#statusTab').show();$('#serviceTab').hide();$('#envTab').hide();$('#routeTab').hide();$('#logTab').hide();$('#deliveryTab').hide();fnObj1.pageStart();">상태</a>
        </li>
        <li role="presentation"><a href="#serviceTab" aria-controls="serviceTab" role="tab" data-toggle="tab"
                                   onClick="$('#eventTab').hide();$('#statusTab').hide();$('#serviceTab').show();$('#envTab').hide();$('#routeTab').hide();$('#logTab').hide();$('#deliveryTab').hide();fnObj1.pageStart();">서비스(<span id="serviceCnt">0</span>)</a>
        </li>
        <li role="presentation"><a href="#envTab" aria-controls="envTab" role="tab" data-toggle="tab"
                                   onClick="$('#eventTab').hide();$('#statusTab').hide();$('#serviceTab').hide();$('#envTab').show();$('#routeTab').hide();$('#logTab').hide();$('#deliveryTab').hide();">환경변수</a>
        </li>
        <li role="presentation"><a href="#routeTab" aria-controls="routeTab" role="tab" data-toggle="tab"
                                   onClick="$('#eventTab').hide();$('#statusTab').hide();$('#serviceTab').hide();$('#envTab').hide();$('#routeTab').show();$('#logTab').hide();$('#deliveryTab').hide();">라우트(<span id="routeCount">0</span>)</a>
        </li>
        <li role="presentation"><a href="#logTab" aria-controls="logTab" role="tab" data-toggle="tab"
                                   onClick="$('#eventTab').hide();$('#statusTab').hide();$('#serviceTab').hide();$('#envTab').hide();$('#routeTab').hide();$('#logTab').show();$('#deliveryTab').hide(); LogTabinit();">로그</a>
        </li>
        <!--<li role="presentation"><a href="#deliveryTab" aria-controls="deliveryTab" role="tab" data-toggle="tab" onClick="$('#eventTab').hide();$('#serviceTab').hide();$('#envTab').hide();$('#routeTab').hide();$('#logTab').hide();$('#deliveryTab').show();">배포정보</a></li>-->
    </ul>
</div>
<!-- Tab panes -->
<div class="tab-content" style="min-width: 1130px">

    <div role="tabpanel" class="tab-pane fade in active" id="eventTab">
        <%@include file="./eventTab.jsp" %>
    </div>

    <div role="tabpanel" class="tab-pane fade in active" id="statusTab">
        <%@include file="./statusTab.jsp" %>
    </div>

    <div role="tabpanel" class="tab-pane fade in active" id="serviceTab">
        <%@include file="./serviceTab.jsp" %>
    </div>

    <div role="tabpanel" class="tab-pane fade in active" id="envTab">
        <%@include file="./envTab.jsp" %>
    </div>

    <div role="tabpanel" class="tab-pane fade in active" id="routeTab">
        <%@include file="./routeTab.jsp" %>
    </div>

    <div role="tabpanel" class="tab-pane fade in active" id="logTab">
        <%@include file="./logTab.jsp" %>
    </div>

    <div role="tabpanel" class="tab-pane fade in active" id="deliveryTab">
        <%@include file="./deliveryTab.jsp" %>
    </div>

</div>

<%@include file="../layout/bottom.jsp" %>