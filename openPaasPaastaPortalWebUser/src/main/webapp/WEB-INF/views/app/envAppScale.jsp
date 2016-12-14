<%@page contentType="text/html" pageEncoding="UTF-8" %>
<style>
    body {
        font-family: "Spoqa Han Sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
    }
</style>

<script>

    $(document).ready(function () {
        $("#minInstance").spinner({
            min: 2, max: 20, step: 1, start: 2
        });
        $("#maxInstance").spinner({
            min: 2, max: 20, step: 1, start: 2
        });
        $("#minCpu").spinner({
            min: 10, max: 90, step: 10, start: 20
        });
        $("#maxCpu").spinner({
            min: 10, max: 90, step: 10, start: 20
        });

        $("#memoryMinSize").spinner({
            min: 10, max: 90, step: 10, start: 20
        });
        $("#memoryMaxSize").spinner({
            min: 10, max: 90, step: 10, start: 20
        });

        funCommonCode('USER_AUTOSCAILE');

    });

    function funCommonCode(codeId) {
        // var commonCode;
        $.ajax({
            url: "/commonCode/getCommonCode/" + codeId,
            method: "GET",
            commonCode: JSON.stringify({}),
            dataType: 'json',
            contentType: "application/json",
            success: function (commonCode) {

                if (commonCode.list != null) {
                    var pGuid = '';
                    var pUseYn = 'N';

                    var pMinInstance;
                    var pMaxInstance;
                    var pCpuThresholdMinPer;
                    var pCpuThresholdMaxPer;
                    var pCheckTimeSec = 5;

                    for (var i = 0; i < commonCode.list.length; i++) {
                        if ('minInstance' == commonCode.list[i].key) {
                            pMinInstance = commonCode.list[i].value;
                        }
                        if ('maxInstance' == commonCode.list[i].key) {
                            pMaxInstance = commonCode.list[i].value;
                        }
                        if ('minCpu' == commonCode.list[i].key) {
                            pCpuThresholdMinPer = commonCode.list[i].value;
                        }
                        if ('maxCpu' == commonCode.list[i].key) {
                            pCpuThresholdMaxPer = commonCode.list[i].value;
                        }
                        $("#minInstance").val(pMinInstance);
                        $("#maxInstance").val(pMaxInstance);

                        $("#minCpu").val(pCpuThresholdMinPer);
                        $("#maxCpu").val(pCpuThresholdMaxPer);

                        $("#memoryMinSize").val("20");
                        $("#memoryMaxSize").val("80");

                        $("#txtTime").val("10");
                    }
                }
            },
            error: function (xhr, status, error) {
                showAlert("fail", JSON.parse(xhr.responseText).message)
            },
            complete: function (commonCode) {
                getAppAutoScaleInfo('get');
            }
        });
    }
    function getAppAutoScaleInfo(pMode) {
        //alert(pMode);
        var increaseYn = 'N';
        var decreaseYn = 'N';

        var url;
        if (($("input[name='appUse']:checked").val()) == 'on') {
            increaseYn = 'Y'
        }
        if (($("input[name='appUse2']:checked").val()) == 'on') {
            decreaseYn = 'Y'
        }
        if (pMode == 'save') {
            if (!$("#guid").val() == "" || !$("#guid").val() == null) {
                pMode = 'update';
            }
        }
        if (pMode == 'get') {
            url = "/app/getAppAutoScaleInfo";
        }
        if (pMode == 'save') {
            url = "/app/insertAppAutoScale";
        }
        if (pMode == 'update') {
            url = "/app/updateAppAutoScale";
        }
        if (pMode == 'delete') {
            url = "/app/deleteAppAutoScale";
        }
        var param = {
            mode: pMode
            , url: url
            , guid: currentAppGuid
            , org: currentOrg
            , space: currentSpace
            , app: currentApp
            , autoIncreaseYn: increaseYn
            , autoDecreaseYn: decreaseYn
            , instanceMinCnt: parseInt($("#minInstance").val())
            , instanceMaxCnt: parseInt($("#maxInstance").val())
            , cpuThresholdMinPer: parseFloat($("#minCpu").val())
            , cpuThresholdMaxPer: parseFloat($("#maxCpu").val())
            , memoryMinSize: parseInt($("#memoryMinSize").val())
            , memoryMaxSize: parseInt($("#memoryMaxSize").val())
            , checkTimeSec: parseInt($("#txtTime").val())
        };
        var options = {
            url: "/app/getAppAutoScaleInfo",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function (data) {
                if (data.list) {
                    var pName = data.list.name;
                    var pGuid = data.list.guid;
                    var pUseYn = data.list.autoIncreaseYn;
                    var pUseYn2 = data.list.autoDecreaseYn;
                    var pMinInstance = data.list.instanceMinCnt;
                    var pMaxInstance = data.list.instanceMaxCnt;
                    var pCpuThresholdMinPer = data.list.cpuThresholdMinPer;
                    var pCpuThresholdMaxPer = data.list.cpuThresholdMaxPer;
                    var pCheckTimeSec = data.list.checkTimeSec;
                    var pMinInstance = data.list.instanceMinCnt;
                    var pMaxInstance = data.list.instanceMaxCnt;
                    var memoryMinSize = data.list.memoryMinSize;
                    var memoryMaxSize = data.list.memoryMaxSize;

                    pCpuThresholdMinPer = pCpuThresholdMinPer * 100;
                    pCpuThresholdMaxPer = pCpuThresholdMaxPer * 100;

                    if (pMode == "get") {
                        setAutoScaling(pUseYn);
                        setAutoScaling2(pUseYn2);
                    }


                    $('#reducetoggle,#toggle').change(function () {
                        getAppAutoScaleToggle('update');
                    });


                    $("#scaleApp").text(currentApp);
                    if (pUseYn == 'Y') {
                        $("#appUse").prop("checked", true);
                    } else {
                        $("#appUse").prop("checked", false);
                    }

                    if (pUseYn2 == 'Y') {
                        $("#appUse2").prop("checked", true);
                    } else {
                        $("#appUse2").prop("checked", false);
                    }

                    $("#guid").val(pGuid);
                    $("#minInstance").val(pMinInstance);
                    $("#maxInstance").val(pMaxInstance);

                    $("#minCpu").val(pCpuThresholdMinPer);
                    $("#maxCpu").val(pCpuThresholdMaxPer);
                    $("#txtTime").val(pCheckTimeSec);

                    $("#memoryMinSize").val(memoryMinSize);
                    $("#memoryMaxSize").val(memoryMaxSize);
                }
                if (data.list == null) {
                    document.getElementById("btn-delete").disabled = true;
                } else {
                    document.getElementById("btn-delete").disabled = false;
                }
            },
            error: function (xhr, status, error) {
                showAlert("fail", JSON.parse(xhr.responseText).message)
            },
            complete: function () {
                if (pMode != 'get') {
                    if (pMode == 'save') {
                        showAlert('success', currentApp + "의 AutoScaling 설정이 저장되었습니다.");
                    }
                    if (pMode == 'update') {
                        showAlert('success', currentApp + "의 AutoScaling 설정이 수정되었습니다.");
                    }
                    if (pMode == 'delete') {
                        showAlert('success', currentApp + "의 AutoScaling 설정이 삭제되었습니다.");
                    }
                    getAppAutoScaleToggle('get');
                }
            }

        };
        $.ajax(options);

    }
    function getScale() {


    }


</script>
<button type="button" class="btn btn-xs btn-primary" style="width: 30px; height: 30px;margin-top: 0px">
    <span class="glyphicon glyphicon-cog" aria-hidden="true" style="cursor: pointer;color:#fff;" data-toggle="modal"
          data-target="#scaleModal" data-placement="left" title="setting Auto-Scaling"></span>
</button>


<!-- Modal -->
<div id="scaleModal" class="modal fade bs-example-modal-lg" role="dialog" onshow="getScale()">
    <div class="modal-dialog ">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title" id="myLargeModalLabel" style="text-align: left">Auto-Scaling 설정 </h4>
            </div>
            <div class="modal-body">
                <form name='form1' action="<c:url value='/appAutoScaleModal/getAutoScaleInfo' />" method='POST'>
                    <input type="hidden" id="guid" name="guid">
                    <table class="table table-bordered">
                        <tr>
                            <th style="text-align:center; color:#848383; font-size:15px;">앱</th>
                            <td colspan="2">
                                <div align="center">
                                    <label class="checkbox-inline">
                                        <input type="checkbox" class="checked" name="appUse" id="appUse"/> 자동확장 사용&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    </label>
                                    <label class="checkbox-inline">
                                        <input type="checkbox" class="checked" name="appUse2"
                                               id="appUse2"/> 자동축소 사용
                                    </label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th style="text-align:center; color:#848383; font-size:15px; padding: 12px 0px 0px;">인스턴스 수
                                설정
                            </th>
                            <td>
                                <div align="center">
                                    <span>최소</span>

                                    <input id="minInstance" name="minInstance" size="3" maxlength="2" readonly
                                           data-toggle="tooltip"
                                           data-placement="left" title="set to less than 1 or greater than 20"/>&nbsp;개

                                </div>
                            </td>
                            <td>
                                <div align="center">
                                    <span>최대</span>

                                    <input id="maxInstance" name="maxInstance" size="3" maxlength="2" readonly
                                           data-toggle="tooltip"
                                           data-placement="left" title="set to less than 1 or greater than 20"/>&nbsp;개

                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th style="text-align:center; color:#848383; font-size:15px; padding: 12px 0px 0px;">CPU 임계값
                                설정
                            </th>
                            <td>
                                <div align="center">
                                    <span>최소</span>

                                    <input id="minCpu" name="minCpu" size="3" maxlength="2" readonly
                                           data-toggle="tooltip"
                                           data-placement="left" title="set to less than 10 or greater than 90"/>&nbsp;%

                                </div>
                            </td>
                            <td>
                                <div align="center">
                                    <span>최대</span>

                                    <input id="maxCpu" name="maxCpu" size="3" maxlength="2" readonly
                                           data-toggle="tooltip"
                                           data-placement="left" title="set to less than 10 or greater than 90"/>&nbsp;%

                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th style="text-align:center; color:#848383; font-size:15px; padding: 12px 0px 0px;">메모리 임계값
                                설정
                            </th>
                            <td>
                                <div align="center">
                                    <span style="margin-top:3px;">최소</span>

                                    <input id="memoryMinSize" name="memoryMinSize" size="3" maxlength="2" readonly
                                           data-toggle="tooltip" data-placement="left"/>&nbsp;%

                                </div>
                            </td>
                            <td>
                                <div align="center">
                                    <span>최대</span>

                                    <input id="memoryMaxSize" name="memoryMaxSize" size="3" maxlength="2" readonly
                                           data-toggle="tooltip" data-placement="left"/>&nbsp;%

                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th style="text-align:center; color:#848383; font-size:15px; padding: 12px 0px 0px;">시간 설정
                            </th>
                            <td colspan="2">
                                <div align="center">
                                    <div>
                                        <input typeof="text" id="txtTime" class="text-right" data-placement="left"
                                               title="set to less than 10 or greater than 20"
                                               style="padding-right: 5px;"/>&nbsp;초
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
            <div class="modal-footer">
                <div style="float : left">
                    <input type="button" id="btn-delete" name="btn-delete" class="btn btn-danger btn-sm"
                           style="vertical-align:baseline;margin-top: 0px" data-dismiss="modal" value="삭제"
                           onclick="getAppAutoScaleInfo('delete')"/>
                </div>
                <div style="float : right">
                    <input type="button" class="btn btn-cancel btn-sm" data-dismiss="modal" style="margin-top: 0px"
                           value="취소"/>
                    <input type="button" class="btn btn-success btn-sm" data-dismiss="modal" style="margin-top: 0px"
                           value="저장" onclick="getAppAutoScaleInfo('save')"/>
                </div>
            </div>
        </div> <!-- 모달 콘텐츠 -->
    </div> <!-- 모달 다이얼로그 -->
</div>
<!-- 모달 전체 윈도우 -->

