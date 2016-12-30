<!--
=================================================================
* 시  스  템  명 : PaaS-TA 사용자 포탈
* 업    무    명 : 사용량 조회
* 프로그램명(ID) : usageMain.jsp(사용량조회)
* 프로그램  개요 : 사용량을 조회하는 화면
* 작    성    자 : 김도준
* 작    성    일 : 2016.09.23
=================================================================
수정자 / 수정일 :
수정사유 / 내역 :
=================================================================
-->
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../layout/top.jsp" %>
<%@include file="../layout/left.jsp" %>
<%@include file="../layout/alert.jsp" %>

<%--FOR CHARTS--%>
<script type="text/javascript" src="<c:url value='/resources/js/highcharts.js' />"></script>
<script type="text/javascript" src="<c:url value='/resources/js/exporting.js' />"></script>

<div id="usageViewArea" class="ViewArea" style="display: none; position: relative;">
    <div class="panel content-box col-sm-12 col-md-12 mt-5">
        <div class="col-sm-12 pt20">
            <div class="fl">
                <h4 class="modify_h4 fwb"> 사용량 조회 </h4>
            </div>
            <div class="fl">
                <p class="mt10 ml20"> 사용 중인 앱의 메모리 사용량을 조회합니다. </p>
            </div>
        </div>
        <div class="panel content-box col-sm-12 col-md-12">
            <div class="mr10 mt10 fl"> 조직 </div>
            <div class="mr40 fl">
                <select id="selectOrganization" class="form-control" title="" style="min-width: 150px;">
                    <option value=""> TEST </option>
                </select>
            </div>
            <div class="mr10 mt10 fl"> 공간 </div>
            <div class="mr40 fl">
                <select id="selectSpace" class="form-control" title="" style="min-width: 150px;">
                    <option value=""> ALL </option>
                </select>
            </div>
            <div class="mr10 mt10 fl"> 조회월 </div>
            <div class="mr10 fl">
                <div class="mr10 fl">
                    <select id="selectFromYear" class="form-control" title="">
                        <option value=""> 10 </option>
                    </select>
                </div>
                <div class="mr10 mt10 fl"> 년 </div>
            </div>
            <div class="mr10 fl">
                <div class="mr10 fl">
                    <select id="selectFromMonth" class="form-control" title="">
                        <option value=""> 10 </option>
                    </select>
                </div>
                <div class="mt10 fl"> 월 </div>
            </div>
            <div class="mr10 mt10 fl"> ~ </div>
            <div class="mr10 fl">
                <div class="mr10 fl">
                    <select id="selectToYear" class="form-control" title="">
                        <option value=""> 10 </option>
                    </select>
                </div>
                <div class="mr10 mt10 fl"> 년 </div>
            </div>
            <div class="mr20 fl">
                <div class="mr10 fl">
                    <select id="selectToMonth" class="form-control" title="">
                        <option value=""> 10 </option>
                    </select>
                </div>
                <div class="mr10 mt10 fl"> 월 </div>
            </div>
            <div id="searchMonth" class="mr10 mt10 fl">
                <div class="mr10 fl">
                    <input type="radio" id="searchMonth_1" name="searchMonth" value="1" title=""> 1 개월
                </div>
                <div class="mr10 fl">
                    <input type="radio" id="searchMonth_6" name="searchMonth" value="6" title=""> 6 개월
                </div>
                <div class="mr10 fl">
                    <input type="radio" id="searchMonth_12" name="searchMonth" value="12" title=""> 12 개월
                </div>
            </div>
            <div class="mr10 fl">
                <button type="button" class="btn btn-point btnSearch btn-sm mt5" id="btnSearch" style="margin: 0;"> 조회 </button>
            </div>
        </div>

        <div class="cl_b"></div>
        <div class="col-sm-12">
            <div id="noUsageMessageArea" class="mt10 mb10 fl" style="width: 100%; padding: 20px; display: none;">
                <span>사용량 조회에 실패했습니다. 관리자에게 문의하시기 바랍니다.</span>
            </div>
        </div>
        <div class="col-sm-12">
            <div id="chartMainTitle" class="mt10 mb10 fl" style="width: 100%; border: 1px solid #dddddd; padding: 20px; display: none;">
                <div class="fl"> 전체 사용량 GB-시간 </div>
                <div class="ml20 mr20 fl" data-toggle="tooltip" data-placement="bottom" title="GB-시간 = 총 GB 앱 * 앱 인스턴스 수 * 총 실행시간" id="usageDescription"> [IMG] </div>
                <div id="totalUsage" class="fl"> 200 </div>
            </div>
            <div id="chartMainContainer" style="width: 100%; min-height: 400px; margin: 0 auto; display: none;"></div>
            <div id="chartSubTitle" class="mt30 mb10" style="border: 1px solid #dddddd; padding: 20px; display: none;">
                앱별 사용량 GB-시간
            </div>
            <div id="chartSubContainer" style="width: 100%; min-height: 400px; margin: 0 auto; display: none;"></div>
            <div id="emptySpaceMessageArea" style="display: none;">
                <h4 class="tac" style="min-height: 200px; line-height: 200px;"> 생성된 공간이 없습니다. </h4>
            </div>
        </div>
    </div>
</div>

<%--
====================================================================================================
SCRIPT BEGIN
====================================================================================================
--%>


<script type="text/javascript">

    var USAGE_ORGANIZATION_LIST_PROC_URL = "<c:url value='/usage/getUsageOrganizationList' />";
    var USAGE_SPACE_LIST_PROC_URL = "<c:url value='/usage/getUsageSpaceList' />";
    var USAGE_SEARCH_LIST_PROC_URL = "<c:url value='/usage/getUsageSearchList' />";


    // GET LIST :: ORGANIZATION
    var getOrganizationList = function () {
        procCallAjax(USAGE_ORGANIZATION_LIST_PROC_URL, {}, procCallbackOrganizationList);
    };


    // GET LIST CALLBACK :: SPACE
    var procCallbackOrganizationList = function (data) {
        if (RESULT_STATUS_FAIL == data.RESULT) return false;

        var resultList = data.list;
        var listLength = resultList.length;
        var objSelectBox = $('#selectOrganization');
        var htmlString = [];

        for (var i = 0; i < listLength; i++) {
            htmlString.push("<option value='" + resultList[i].value + "<%= Constants.STRING_SEPARATOR %>" + resultList[i].guid + "'>" + resultList[i].name + "</option>");
        }

        objSelectBox.html(htmlString);

        getSpaceList(objSelectBox.val());
    };


    // GET LIST :: SPACE
    var getSpaceList = function (reqOrgValue) {
        if (!procCheckValidNull(reqOrgValue)) return false;

        var tempArray = reqOrgValue.split('<%= Constants.STRING_SEPARATOR %>');
        var reqOrgName = tempArray[0];

        procCallAjax(USAGE_SPACE_LIST_PROC_URL, {orgName : reqOrgName}, procCallbackSpaceList);
    };


    // GET LIST CALLBACK :: SPACE
    var procCallbackSpaceList = function (data) {
        var objSelectBox = $('#selectSpace');
        var htmlString = [];

        if (RESULT_STATUS_FAIL == data.RESULT) {
            htmlString.push("<option value='<%= Constants.NONE_VALUE %><%= Constants.STRING_SEPARATOR %><%= Constants.NONE_VALUE %>'> 공간 없음 </option>");

            $('#chartMainTitle').hide();
            $('#chartMainContainer').hide();
            $('#chartSubTitle').hide();
            $('#chartSubContainer').hide();
            $('#emptySpaceMessageArea').show();
            $('#usageViewArea').show();

            procCallSpinner(SPINNER_SPIN_STOP);

        } else {
            var resultList = data.list;
            var listLength = resultList.length;

            htmlString.push("<option value='<%= Constants.SEARCH_TYPE_ALL %><%= Constants.STRING_SEPARATOR %><%= Constants.SEARCH_TYPE_ALL %>'> ALL </option>");
            for (var i = 0; i < listLength; i++) {
                htmlString.push("<option value='" + resultList[i].value + "<%= Constants.STRING_SEPARATOR %>" + resultList[i].guid + "'>" + resultList[i].name + "</option>");
            }
        }

        $('[data-toggle="tooltip"]').tooltip();
        objSelectBox.html(htmlString);

        if (RESULT_STATUS_FAIL != data.RESULT) getMainUsageList();
    };


    // GET LIST
    var getMainUsageList = function () {
        var doc = document;
        var fromYear = doc.getElementById("selectFromYear").value;
        var toYear = doc.getElementById("selectToYear").value;
        var fromMonth = doc.getElementById("selectFromMonth").value;
        var toMonth = doc.getElementById("selectToMonth").value;

        if (fromMonth.length < 2) fromMonth = "0" + fromMonth;
        if (toMonth.length < 2) toMonth = "0" + toMonth;

        fromMonth = fromYear + fromMonth + "";
        toMonth = toYear + toMonth + "";

        var tempOrgArray = doc.getElementById("selectOrganization").value.split('<%= Constants.STRING_SEPARATOR %>');
        var tempSpaceArray = doc.getElementById("selectSpace").value.split('<%= Constants.STRING_SEPARATOR %>');
        var param = {orgGuid : tempOrgArray[1],
                     spaceGuid : ('<%= Constants.SEARCH_TYPE_ALL %>' == tempSpaceArray[1]) ? tempSpaceArray[1].toLowerCase() : tempSpaceArray[1],
                     fromMonth : fromMonth,
                     toMonth : toMonth
        };

        procCallAjax(USAGE_SEARCH_LIST_PROC_URL, param, procCallbackGetMainUsageList);
    };


    // GET LIST CALLBACK
    var procCallbackGetMainUsageList = function (data) {
        if (RESULT_STATUS_SUCCESS != data.RESULT) {
            showAlert('fail', data.RESULT_MESSAGE);
            procCallSpinner(SPINNER_SPIN_STOP);
            $('#usageViewArea').show();
            $('#noUsageMessageArea').show();
            return false;
        }

        setMainUsageChart(data);
    };


    // SET MAIN CHART
    var setMainUsageChart = function (data) {
        var resultData = data.RESULT_ABACUS;
        var resultList = resultData.monthly_usage_arr;
        var chartMainContainer = $('#chartMainContainer');

        // SET OPTIONS
        var chartOptions = setMainUsageChartOptions(resultList);

        // EXECUTE CHART
        chartMainContainer.fadeIn();
        chartMainContainer.highcharts(chartOptions);

        $('#totalUsage').html(parseFloat(resultData.sum.toFixed(2)) + " (GB)");

        setSubUsageChart(data);
    };


    // SET CHART OPTIONS
    var setMainUsageChartOptions = function (resultList) {
        var listLength = resultList.length;
        var arrayMonth = [];
        var arrayUsage = [];

        for (var i = 0; i < listLength; i++) {
            arrayMonth.push(parseInt(resultList[i].month.substring(4)) + " 월");
            arrayUsage.push(parseFloat(resultList[i].sum.toFixed(2)));
        }

        arrayMonth.join(',');
        arrayUsage.join(',');

        return {
            chart: {
                type: 'column'
            },
            title: {
                text: ''
            },
            subtitle: {
                text: ''
            },
            xAxis: {
                categories: arrayMonth,
                labels: {
                    style: {'font-size': '16px'}
                }
            },
            yAxis: {
                min: 0,
                title: {
                    text: ''
                }
            },
            plotOptions: {
                bar: {
                    dataLabels: {
                        enabled: true
                    }
                }
            },
            legend: {
                align: 'center',
                itemStyle: {
                    'fontSize': '16px'
                }
            },
            credits: {
                enabled: false
            },
            series: [{
                name: '사용량 (GB)',
                data: arrayUsage
            }]
        };
    };


    // SET SUB CHART
    var setSubUsageChart = function (data) {
        var resultList = data.RESULT_ABACUS.total_app_usage_arr;
        var chartSubContainer = $('#chartSubContainer');

        // SET OPTIONS
        var chartOptions = setSubUsageChartOptions(resultList);

        // EXECUTE CHART
        chartSubContainer.fadeIn();
        chartSubContainer.highcharts(chartOptions);

        $('#usageViewArea').show();

        $('#emptySpaceMessageArea').hide();
        $('#chartMainTitle').show();
        $('#chartSubTitle').show();

        procCallSpinner(SPINNER_SPIN_STOP);
    };


    // SET CHART OPTIONS
    var setSubUsageChartOptions = function (resultList) {
        var listLength = resultList.length;
        var arrayAppName = [];
        var arrayUsage = [];
        var tempAppName = "";

        for (var i = 0; i < listLength; i++) {
            tempAppName = resultList[i].app_name;

            if ("<%= Constants.ABACUS_DELETED_APP %>" != tempAppName) {
                arrayAppName.push(tempAppName);
                arrayUsage.push(parseFloat(resultList[i].app_usage.toFixed(2)));
            }

        }

        arrayAppName.join(',');
        arrayUsage.join(',');

        return {
            chart: {
                type: 'column'
            },
            title: {
                text: ''
            },
            subtitle: {
                text: ''
            },
            xAxis: {
                categories: arrayAppName,
                labels: {
                    style: {'font-size': '16px'}
                }
            },
            yAxis: {
                min: 0,
                title: {
                    text: ''
                }
            },
            plotOptions: {
                bar: {
                    dataLabels: {
                        enabled: true
                    }
                }
            },
            legend: {
                align: 'center',
                itemStyle: {
                    'fontSize': '16px'
                }
            },
            credits: {
                enabled: false
            },
            series: [{
                name: '사용량 (GB)',
                data: arrayUsage
            }]
        };
    };


    // CHECK VALID SEARCH MONTH
    var procCheckValidSearchMonth = function () {
        var checkLimitMonth = 11;
        var doc = document;
        var today = new Date();
        var checkResult = 0;

        var currentYearNum = Number(today.getFullYear());
        var currentMonthNum = Number(today.getMonth() + 1);

        var fromYearNum = Number(doc.getElementById("selectFromYear").value);
        var toYearNum = Number(doc.getElementById("selectToYear").value);
        var fromMonthNum = Number(doc.getElementById("selectFromMonth").value);
        var toMonthNum = Number(doc.getElementById("selectToMonth").value);

        var resultCheck = ((toYearNum * 12) + toMonthNum) - ((fromYearNum * 12) + fromMonthNum);

        // CHECK MONTH LIMIT
        if (resultCheck > checkLimitMonth) {
            showAlert('fail', "사용량 조회 범위는 " + (checkLimitMonth + 1) + "개월 입니다.");
            setSelectBoxYear();
            setSelectBoxMonth(1);
            return false;
        }

        // CHECK CURRENT
        if (currentYearNum == fromYearNum && currentMonthNum < fromMonthNum) checkResult++;
        if (currentYearNum == toYearNum && currentMonthNum < toMonthNum) checkResult++;
        if (fromYearNum > toYearNum) checkResult++;
        if (fromYearNum == toYearNum && fromMonthNum > toMonthNum) checkResult++;

        if (checkResult > 0) {
            showAlert('fail', "사용량 조회 범위를 초과하였습니다.");
            setSelectBoxYear();
            setSelectBoxMonth(1);
        } else {
            getMainUsageList();
        }
    };


    // SET SELECT BOX :: YEAR
    var setSelectBoxYear = function (reqYearFrom, reqYearTo) {
        var objSelectBoxYearFrom = $('#selectFromYear');
        var objSelectBoxYearTo = $('#selectToYear');
        var htmlString = [];

        var today = new Date();
        var year = today.getFullYear();
        var fromYear = today.getFullYear();
        var toYear = today.getFullYear();
        var tempResult = 0;
        var tempCss = "";

        if (undefined !== reqYearFrom || undefined !== reqYearTo) {
            fromYear = reqYearFrom;
            toYear = reqYearTo;
        }

        for (var i = 0; i < 5; i++) {
            tempResult = year - i;
            tempCss = (tempResult == fromYear) ? " selected" : "";
            htmlString.push("<option value='" + tempResult + "'" + tempCss + ">" + tempResult + "</option>");
        }

        objSelectBoxYearFrom.html(htmlString);

        htmlString = [];
        for (var j = 0; j < 5; j++) {
            tempResult = year - j;
            tempCss = (tempResult == toYear) ? " selected" : "";
            htmlString.push("<option value='" + tempResult + "'" + tempCss + ">" + tempResult + "</option>");
        }

        objSelectBoxYearTo.html(htmlString);
    };


    // SET SELECT BOX :: MONTH
    var setSelectBoxMonth = function (reqMonth) {
        var objSelectBoxMonthFrom = $('#selectFromMonth');
        var objSelectBoxMonthTo = $('#selectToMonth');
        var htmlString = [];

        var today = new Date();
        var year = today.getFullYear();
        var month = today.getMonth() + 1;
        var tempMonth = 0;
        var tempCss = "";

        if (undefined === reqMonth) reqMonth = 1;

        if (1 == reqMonth) {
            tempMonth = month;
            setSelectBoxYear(year, year);
        }

        if (6 == reqMonth) {

            if ((month - 6) < 0) {
                tempMonth = 12 - (6 - month);
                setSelectBoxYear(year - 1, year);
            } else {
                tempMonth = month - 5;
                setSelectBoxYear(year, year);
            }
        }

        if (12 == reqMonth) {
            tempMonth = month + 1;
            setSelectBoxYear(year - 1, year);
        }

        for (var i = 1; i < 13; i++) {
            tempCss = (i == tempMonth) ? " selected" : "";
            htmlString.push("<option value='" + i + "'" + tempCss + ">" + i + "</option>");
        }

        objSelectBoxMonthFrom.html(htmlString);

        htmlString = [];
        for (var j = 1; j < 13; j++) {
            tempCss = (j == month) ? " selected" : "";
            htmlString.push("<option value='" + j + "'" + tempCss + ">" + j + "</option>");
        }

        objSelectBoxMonthTo.html(htmlString);

        $("#searchMonth_" + reqMonth).prop('checked', true);
    };


    // CHANGE ORGANIZATION
    var procChangeOrganization = function (reqOrgValue) {
        $('#chartMainTitle').hide();
        $('#chartMainContainer').hide();
        $('#chartSubTitle').hide();
        $('#chartSubContainer').hide();
        $('#emptySpaceMessageArea').hide();
        $('#usageViewArea').hide();

        procCallSpinner(SPINNER_SPIN_START);
        getSpaceList(reqOrgValue);
    };


    // BIND :: SELECT BOX CHANGE
    $('#selectOrganization').on("change", function () {
        procChangeOrganization(this.value);
    });


    // BIND :: RADIO BUTTON EVENT
    $('#searchMonth').find("div > input").on("click", function () {
        setSelectBoxMonth(this.value);
    });


    // BIND :: BUTTON EVENT
    $('#btnSearch').on("click", function () {
        $('#noUsageMessageArea').hide();
        procCallSpinner(SPINNER_SPIN_START);
        procCheckValidSearchMonth();
    });


    // INIT PAGE
    var procInitPage = function () {
        procCallSpinner(SPINNER_SPIN_START);

        setSelectBoxYear();
        setSelectBoxMonth(1);
        getOrganizationList();
    };


    // ON LOAD
    $(document.body).ready(function () {
        procInitPage();
    });

</script>


<%--
====================================================================================================
SCRIPT END
====================================================================================================
--%>


<%--FOOTER--%>
<%@include file="../layout/bottom.jsp" %>
