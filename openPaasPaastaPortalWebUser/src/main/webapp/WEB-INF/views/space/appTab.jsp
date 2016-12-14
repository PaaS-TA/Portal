<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>

    /**
     * Require Files for AXISJ UI Component...
     * Based        : jQuery
     * Javascript   : AXJ.js, AXGrid.js, AXInput.js, AXSelect.js
     * CSS          : AXJ.css, AXGrid.css, AXButton.css, AXInput.css, AXSelector.css
     */
    var myGrid = new AXGrid();
    var fnObj = {
        pageStart: function () {

            myGrid.setConfig({
                targetID: "AXGridTarget",
                theme: "AXGrid",
                fitToWidth: true,
                height: "auto",
                viewMode: "grid",

                colGroup: [
                    {key: "name", label: "공간", width: "280", align: "center"},
                    {key: "state", label: "상태", width: "100", align: "center"},
                    {key: "update", label: "설정", width: "150", align: "center"}
                ],

                body: {
                    rows: [
                        [
                            {
                                key: "name", align: "left", formatter: function () {
                                return "<br><h1 id='appNameNormal" + this.index + "' class=''><a href='#none' onclick=\"setAppSession('" + this.item.name + "','" + this.item.guid + "');\">" + this.item.name + "</a></div>" +
                                        "<h1 id='appNameEdit" + this.index + "' style='display:none;'><input type='text' maxlength='100' style='width:160px;height: 30px' class='form-control'  id='newAppName" + this.index + "' value='" + this.item.name + "'>" +
                                        "<button type='button' class='btn btn-save btn-sm btn-sm' onclick=\"renameApp('" + this.item.name + "', 'newAppName" + this.index + "');\" style='margin-top: 0px'>변경</button>" +
                                        " <button type='button' class='btn btn-cancel btn-sm' onclick=\"$('#appNameNormal" + this.index + "').show(); $('#appNameEdit" + this.index + "').hide();\" style='margin-top: 0px'>취소</button>" +
                                        "</h1>" +
                                        "<h6 class='media-heading ml10'>" + this.item.urls[0] + "</h6>" +
                                        "<p class='ml10'>인스턴스 : " + this.item.instances + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;메모리 : " + this.item.memory + "</p><br>"

                            },
                                editor: {
                                    type: "text"
                                }
                            },
                            {
                                key: "state", align: "center", formatter: function () {


                                var state_text;
                                var icon_class;
                                if (this.item.state == 'STARTED') {
                                    icon_class = "glyphicon-stop";
                                    state_text = "실행 중";
                                    btn_text = "정지";
                                } else {
                                    icon_class = "glyphicon-play";
                                    state_text = "정지";
                                    btn_text = "실행";
                                }

                                return state_text;
                            }
                            },
                            {
                                key: "update", align: "center", formatter: function () {


                                var state_text;
                                var icon_class;
                                if (this.item.state == 'STARTED') {
                                    icon_class = "glyphicon-stop";
                                    state_text = "실행 중";
                                    btn_text = "정지";
                                } else {
                                    icon_class = "glyphicon-play";
                                    state_text = "정지";
                                    btn_text = "실행";
                                }

                                return "<button type='button' class='btn btn-default' style='width:120' onclick='stateExec(\"" + this.item.name + "\",\"" + this.item.state + "\");'><b>" + btn_text + "</b></button><br>" +
                                        "<button type='button' class='btn btn-primary' style='width:120;padding:2px 20px' onclick='popContextMenu(\"" + this.item.name + "\"," + this.index + ");'><b>설정</b></button>";

                            }
                            }
                        ]
                    ],
                },

                page: {
                    paging: false,
                    display: false
                },


                contextMenu: {
                    theme: "AXContextMenu", // 선택항목
                    width: "150", // 선택항목
                    menu: [
                        {
                            userType: 1, label: "앱 이름 변경", className: "edit", onclick: function () {

                            if (this.sendObj) {
                                //myGrid.setEditor(this.sendObj.item, this.sendObj.index);
                                $("#appNameNormal" + this.sendObj.index).hide();
                                $("#appNameEdit" + this.sendObj.index).show();

                            }
                        }
                        },
                        {
                            userType: 1, label: "앱 삭제", className: "minus", onclick: function () {
                            deleteAppModal(this.sendObj.item.name);

                        }
                        }
                    ],
                    filter: function (id) {
                        return true;
                    }
                }


            });

            var data = {
                list: appList
            };

            myGrid.setData(data);


        },

        changeView: function (viewMode) {
            if (viewMode == "grid") {

                $("#appGridBtn").text("썸네일");
                viewModeApp = "icon";

                myGrid.changeGridView({
                    viewMode: viewMode
                });
            } else if (viewMode == "icon") {

                $("#appGridBtn").text("리스트");
                viewModeApp = "grid";

                myGrid.changeGridView({
                    viewMode: viewMode,
                    view: {
                        // 속성이 없을때 예외 처리 마지막에 구현
                        width: $(window).width() / 2.82,
                        height: "120",
                        label: {left: "0", top: "0", width: "0", height: "0"},
                        description: {
                            left: "5",
                            top: "5",
                            width: $(window).width() / 2.82,
                            height: "115",
                            style: "color:#333;"
                        },
                        format: function () {

                            var state_text;
                            var icon_class;
                            if (this.item.state == 'STARTED') {
                                icon_class = "glyphicon-stop";
                                state_text = "실행 중";
                                btn_text = "정지";
                            } else {
                                icon_class = "glyphicon-play";
                                state_text = "정지";
                                btn_text = "실행";
                            }

                            getAppSummary(this.item.guid);


                            var appImageUrl;
                            param = {
                                guid: this.item.guid
                            }

                            $.ajax({
                                url: "/app/getAppImageUrl",
                                method: "POST",
                                async: false,
                                data: JSON.stringify(param),
                                dataType: 'json',
                                contentType: "application/json",
                                success: function (data) {
                                    if (data) {
                                        appImageUrl = data.appImageUrl;
                                    }
                                }
                            });

                            if (appImageUrl == null) {
                                appImageUrl = "https://api.jujucharms.com/charmstore/v5/~cf-charmers/trusty/cf-dea-31/icon.svg";
                            }

                            return {

                                description: "<table class='table table-striped' border='0'>" +
                                "<tr>" +
                                "<td>" +
                                "<ul class='media-list'>" +
                                "<li class='media'>" +
                                "<a class='pull-left' href='#'>" +
                                "<img src='" + appImageUrl + "' width=70 height=70 style='border:1px solid #ccc;'>" +
                                " </a>" +
                                "<div class='media-body'>" +
                                "<h1 id='appNameNormal" + this.index + "' class='media-heading'><a href='#none' onclick=\"setAppSession('" + this.item.name + "','" + this.item.guid + "');\">" + this.item.name + "</a></h1>" +

                                "<h1 id='appNameEdit" + this.index + "' class='media-heading' style='display:none;'><input type='text' maxlength='100' style='width:200px;height: 30px' class='form-control'  id='newAppName" + this.index + "' value='" + this.item.name + "'>" +
                                "<button type='button' class='btn btn-save btn-sm btn-sm' onclick=\"renameApp('" + this.item.name + "', 'newAppName" + this.index + "');\" style='margin-top: 0px'>변경</button>" +
                                " <button type='button' class='btn btn-cancel btn-sm' onclick=\"$('#appNameNormal" + this.index + "').show(); $('#appNameEdit" + this.index + "').hide();\" style='margin-top: 0px'>취소</button>" +
                                "</h1>" +

                                "<h6 class='media-heading' >" + this.item.urls[0] + "</h6>" +
                                "<p><b>" + state_text + "<b> &nbsp; <span id='" + this.item.guid + "'></span></p> " +
                                "</div>" +
                                "</li>" +
                                "</ul>" +
                                "</td>" +
                                "<td>" +
                                "<div class='pt20'>" +
                                "<button type='button' class='btn btn-default' style='width:120' onclick='stateExec(\"" + this.item.name + "\",\"" + this.item.state + "\");'><b>" + btn_text + "</b></button> &nbsp; <br>" +
                                "<button type='button' class='btn btn-primary' style='width:120;padding:2px 20px' onclick='popContextMenu(\"" + this.item.name + "\"," + this.index + ");'><b>설정</b></button> &nbsp; " +
                                "</div>" +
                                "</td>" +
                                "</tr>" +
                                "</table>"

                            }
                        }
                    }

                });
            }
        }
    };

    function popContextMenu(name, index) {
        AXContextMenu.open({id: "AXGridTargetContextMenu", sendObj: {index: index, item: {name: name}}}, event);
    }


    function setAppSession(name, guid) {
        param = {
            name: name,
            guid: guid
        }

        $.ajax({
            url: "/app/setAppSession",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            complete: function () {
                location = '/app/appMain'
            }
        });
    }


    function stateExec(appName, state) {

        $('#modalMask').modal('toggle');
        var spinner = new Spinner().spin();

        param = {
            orgName: currentOrg,
            spaceName: currentSpace,
            name: appName
        }

        var url;
        if (state == "STARTED") {
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
                        showAlert("success", "앱이 중지되었습니다.");


                    } else {
                        showAlert("success", "앱이 시작되었습니다.");

                    }
                }
            },

            error: function (xhr, status, error) {
                showAlert('fail', JSON.parse(xhr.responseText).message);
            },

            complete: function (data) {
                getSpaceSummary();
                spinner.stop();
                $('#modalMask').modal('hide');

            }

        });
    }


    function renameApp(name, newName) {

        if (newName == "") {
            alert("앱 이름을 입력해 주십시요.");
            return false;
        }

        param = {
            orgName: currentOrg,
            spaceName: currentSpace,
            name: name,
            newName: $('#' + newName).val()
        }

        $.ajax({
            url: "/app/renameApp",
            method: "POST",
            async: "false",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function (data) {
                if (data) {
                    showAlert("success", "앱명이 수정되었습니다.");
                }
            },
            error: function (xhr, status, error) {
                showAlert("fail", JSON.parse(xhr.responseText).message);
            },
            complete: function (data) {
                $('#modal').modal('hide');
                getSpaceSummary();
            }

        });
    }


    function deleteAppModal(name) {

        $("#modalTitle").html("앱 삭제");
        $("#modalText").html("앱를 삭제하면 되돌릴 수 없습니다. <br> " + name + " 를  삭제하시겠습니까?");
        $("#modalCancelBtn").text("취소");
        $("#modalExecuteBtn").text("삭제");
        $("#modalExecuteBtn").show();
        $('#modalExecuteBtn').attr("onclick", "deleteApp('" + name + "')");

        $('#modal').modal('toggle');
    }

    function deleteApp(name) {

        param = {
            orgName: currentOrg,
            spaceName: currentSpace,
            name: name
        }

        $.ajax({
            url: "/app/deleteApp",
            method: "POST",
            async: "false",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function (data) {
                if (data) {
                    deleteRoute(name)
                    showAlert("success", "앱이 삭제되었습니다.");
                    location = "/space/spaceMain";
                }
            },
            error: function (xhr, status, error) {
                showAlert("fail", JSON.parse(xhr.responseText).message);
            },
            complete: function (data) {
                $('#modal').modal('hide');
                getSpaceSummary();
            }

        });
    }

    function deleteRoute(appName) {

        var urls = $.grep(appList, function (e) {
            return e.name === appName;
        })[0].urls;
        param = {
            orgName: currentOrg,
            spaceName: currentSpace,
            urls: urls
        }

        $.ajax({
            url: "/app/deleteRoute",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function (data) {
                if (data) {

                }
            },
            error: function (xhr, status, error) {
                showAlert("fail", JSON.parse(xhr.responseText).message)
            }
        });
    }

    function getAppSummary(guid) {

        param = {
            guid: guid
        };

        $.ajax({
            url: "/app/getAppSummary",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function (data) {
                if (data) {

                    $.each(data.services, function (key, serviceObj) {

                        if (serviceObj.service_plan != undefined) {


                            param = {
                                serviceName: serviceObj.service_plan.service.label
                            }

                            $.ajax({
                                url: "/service/getServiceImageUrl",
                                method: "POST",
                                data: JSON.stringify(param),
                                dataType: 'json',
                                contentType: "application/json",
                                success: function (data) {
                                    if (data) {
                                        serviceImageUrl = data.serviceImageUrl;

                                        $("#" + guid).append("<img src='" + serviceImageUrl + "' width='25'> ");

                                    }
                                }
                            });
                        }

                    });


                }
            }
        });
    }




</script>


<div id="AXGridTarget" style="height:320px;"></div>

<div id="AXGridTargetEmpty" style="margin:30px;height:100px;display:none;" align="center">
    생성한 앱이 없습니다. 앱 생성을 클릭 하여 작성하거나 <a href="#none">카탈로그</a>를 찾아보십시오.
</div>