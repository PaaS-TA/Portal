<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../layout/top.jsp" %>
<%@include file="../layout/left.jsp" %>
<%@include file="../layout/alert.jsp" %>

<script>

    var appList;
    var serviceList;
    var memoryLimit;
    var curIndex;
    var viewModeApp = "grid";
    var viewModeSpace = "grid";

    $(document).ready(function () {
        // AFTER CREATING SERVICE INSTANCE IN CATALOG SERVICE PACK MENU
        var requestSpaceName = $('#requestSpaceName').val();

        if ('' != requestSpaceName) {
            currentSpace = requestSpaceName;
            getSpaceSummary();
            return false;
        }

        if ('' != $('#viewMode').val()) {
            getSpaceSummary(1, 'icon');

        } else {
            getSpaceSummary();
        }
    });

    function getSpaceSummary(index, view) {

        $('#modalMask').modal('toggle');
        var spinner = new Spinner().spin();

        $('#space').val(currentSpace);

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
                if (data) {
                    $("#memoryUsage").text(data.memoryUsage / 1024);
                    $("#memoryLimit").text(data.memoryLimit / 1024);
                    if (data.memoryLimit != 0) {
                        $("#memoryPercent").text(parseInt(data.memoryUsage / data.memoryLimit * 100));
                        $("#memoryBar").css("width", data.memoryUsage / data.memoryLimit * 100 + "%");
                    } else {
                        $("#memoryPercent").text(0);
                        $("#memoryBar").css("width", "0%");
                    }

                    appList = data.apps;
                    $("#appCnt").html(appList.length);

                    serviceList = data.services;
                    $("#serviceCnt").html(serviceList.length);

                    memoryLimit = data.memoryLimit;

                    if (appList == "") {
                        emptyApp();
                    } else {
                        $("#appTab").show();
                        $("#AXGridTarget").show();
                        $("#AXGridTargetView").show();
                        $("#AXGridTargetEmpty").hide();


                        fnObj.pageStart();
                        fnObj.changeView("icon");


                    }

                    if (serviceList == "") {
                        emptyService();
                    } else {
                        $("#serviceTab").show();
                        $("#AXGridTarget2").show();
                        $("#AXGridTarget2View").show();
                        $("#AXGridTarget2Empty").hide();
                        $("#createUP-Btn").hide();

                        fnObj2.pageStart();
                        fnObj2.changeView("icon");
                    }
                }
            },

            error: function (xhr, status, error) {
                emptyApp();
                emptyService();
            },

            complete: function (data) {
                if (index == 1) {
                    $('#myTabs li:eq(1) a').tab('show');
                    $('#appTab').hide();
                    $("#serviceTab").tab('show');

                    fnObj2.changeView(view);

                } else {
                    $('#myTabs li:eq(0) a').tab('show');
                    $('#appTab').tab('show');
                    $("#serviceTab").hide();
                    fnObj.changeView(view);

                }

                spinner.stop();
                $('#modalMask').modal('hide');

            }

        });
    }


    function emptyApp() {
        $("#AXGridTarget").hide();
        $("#AXGridTargetView").hide();
        $("#AXGridTargetEmpty").show();
    }

    function emptyService() {
        $("#AXGridTarget2").hide();
        $("#AXGridTarget2View").hide();
        $("#AXGridTarget2Empty").show();
        $("#createUP-Btn").hide();
    }


    function renameSpaceModal() {

        $("#modalTitle").html("공간이름 수정");
        $("#modalText").html(currentSpace + "공간명을 " + $('#space').val() + " 으로 수정하시겠습니까?");
        $("#modalCancelBtn").text("취소");
        $("#modalExecuteBtn").text("수정");
        $("#modalExecuteBtn").show();
        $('#modalExecuteBtn').attr('onclick', 'renameSpace();');

        $('#modal').modal('toggle');
    }

    function renameSpace() {
        param = {
            orgName: currentOrg,
            spaceName: currentSpace,
            newSpaceName: $('#space').val()
        }

        $.ajax({
            url: "/space/renameSpace",
            method: "POST",
            async: "false",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function (data) {
                if (data) {
                    showAlert('success', "공간이 수정되었습니다.");
                }
                setSpaceSession($('#space').val());
                currentSpace = $('#space').val();
                getSpaces(currentOrg);

                $('#renameSpaceBtn').attr('disabled', true);

            },
            error: function (xhr, status, error) {
                showAlert('fail', JSON.parse(xhr.responseText).message);
            },
            complete: function (data) {
                $('#modal').modal('hide');
            }

        });
    }


    function deleteSpaceModal() {

        $("#modalTitle").html("공간 삭제");
        $("#modalText").html("공간를 삭제하면 되돌릴 수 없습니다. <br> " + currentSpace + " 를  삭제하시겠습니까?");
        $("#modalCancelBtn").text("취소");
        $("#modalExecuteBtn").text("삭제");
        $("#modalExecuteBtn").show();
        $('#modalExecuteBtn').attr('onclick', 'deleteSpace()');

        $('#modal').modal('toggle');
    }

    function deleteSpace() {

        param = {
            orgName: currentOrg,
            spaceName: currentSpace,
        }

        $.ajax({
            url: "/space/deleteSpace",
            method: "POST",
            async: "false",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function (data) {
                if (data) {
                    showAlert('success', "공간이 삭제되었습니다.");

                    location = "/org/orgMain";

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


    function changeSpaceName() {

        if ($('#space').val() == currentSpace) {
            $('#renameSpaceBtn').attr('disabled', true);
        } else {
            $('#renameSpaceBtn').attr('disabled', false);
        }

    }


</script>

<!--공간-->
<form>
    <div class="panel content-box col-sm-12 col-md-12 mt-5">
        <div class="col-sm-12 pt0">
            <h4 class="modify_h4 fwb"> 공간 </h4>
        </div>
        <div class="box_group">
            <div class="in_group w700px">
                <input type="text" name="space" id="space" class="form-control2" onkeyup="changeSpaceName()"
                       onkeydown="if(event.keyCode==13) { renameSpaceModal(); return false;}">
                <button type="button" class="btn btn-cancel btn-sm" onClick="renameSpaceModal()" id="renameSpaceBtn"
                        disabled>
                    이름변경
                </button>
                <button type="button" class="btn btn_del" onClick="deleteSpaceModal()" id="deleteSpaceBtn">
                    <span class="glyphicon glyphicon-trash"></span>
                </button>
                <button type="button" class="btn btn-cancel btn-sm" onClick="location='/catalog/catalogMain/buildPack'">
                    앱생성
                </button>
                <button type="button" class="btn btn-cancel btn-sm"
                        onClick="location='/catalog/catalogMain/servicePack'">
                    서비스생성
                </button>
            </div>
        </div>
        <div class="box_group">
            <div class="progress ml10 mt20 w302px fl">
                <div class="progress-bar" role="progressbar" id="memoryBar" aria-valuenow="0" aria-valuemin="0"
                     aria-valuemax="100" style="width: 20%;">
                </div>
            </div>
            <span class="pr_txt fl"><span id="memoryUsage">0</span>GB 사용중 / <span
                    id="memoryLimit">0</span>GB (앱 할당량)</span>
        </div>
    </div>
</form>
<!--//공간-->

<!--애플리케이션-->

<div class="row">
    <div class="panel content-box col-sm-3 col-md-6 col-md-offset-13">
        <div class="col-sm-6 pt0">
            <h4 class="modify_h4 fwb"> 애플리케이션(<span id="appCnt">0</span>) </h4>
        </div>
        <div class="col-sm-6 pt5 tar">
            <button type="button" class="btn btn-save btn-sm" onclick="fnObj.changeView(viewModeApp);"
                    style="margin-top: 0px" id="appGridBtn">리스트
            </button>
            &nbsp;
        </div>
        <div class="col-sm-12 pt20">

            <%@include file="./appTab.jsp" %>

        </div>
    </div>

    <div class="panel content-box col-sm-3 col-md-6 col-md-offset-13">
        <div class="col-sm-3 pt0">
            <h4 class="modify_h4 fwb"> 서비스(<span id="serviceCnt">0</span>) </h4>
        </div>
        <div class="col-sm-9 pt5 tar">
            <button type="button" class="btn btn-createUserProvided btn-sm" onclick="toggleCreateUPBox()"
                    style='margin-top: 0px'>User Provided
                생성
            </button>
            <button type="button" class="btn btn-save btn-sm" onclick="fnObj2.changeView(viewModeSpace);"
                    style="margin-top: 0px" id="spaceGridBtn">리스트
            </button>
            &nbsp;
        </div>
        <div class="col-sm-12 pt20">

            <%@include file="./serviceTab.jsp" %>

        </div>
    </div>

</div>

<!--//애플리케이션-->


<input type="hidden" id="viewMode" name="viewMode" value="<c:out value='${VIEW_MODE}' default='' />"/>
<input type="hidden" id="requestSpaceName" name="requestSpaceName" value="<c:out value='${SPACE_NAME}' default='' />"/>

<%@include file="../layout/bottom.jsp" %>