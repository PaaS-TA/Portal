<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ include file="../common/common.jsp"%>

<%--FOR CHARTS--%>
<script type="text/javascript" src="<c:url value='/resources/js/highcharts.js' />"></script>
<script type="text/javascript" src="<c:url value='/resources/js/exporting.js' />"></script>

<div class="search_box">
    <h2> 대시보드 </h2>
    <div class="box mb20">
        <div class="form-group ">
            <div class="col-sm-3 fl">
                <div class="admin_main_dash_board_top_square">
                    <div class="fl">
                        <h4 class="modify_h4"> 조직 수 </h4>
                    </div>
                    <div class="mt20 tac">
                        <h1 id="organizationCount" class="custom_modify_h1" style="display: none;"> 0 </h1>
                    </div>
                </div>
            </div>
            <div class="col-sm-3 fl">
                <div class="admin_main_dash_board_top_square">
                    <div class="fl">
                        <h4 class="modify_h4"> 공간 수 </h4>
                    </div>
                    <div class="mt20 tac">
                        <h1 id="spaceCount" class="custom_modify_h1" style="display: none;"> 0 </h1>
                    </div>
                </div>
            </div>
            <div class="col-sm-3 fl">
                <div class="admin_main_dash_board_top_square">
                    <div class="fl">
                        <h4 class="modify_h4"> APP 수 </h4>
                    </div>
                    <div class="mt20 tac">
                        <h1 id="applicationCount" class="custom_modify_h1" style="display: none;"> 0 </h1>
                    </div>
                </div>
            </div>
            <div class="col-sm-3 fl">
                <div class="admin_main_dash_board_top_square" style="margin: 10px 0;">
                    <div class="fl">
                        <h4 class="modify_h4"> 사용자 수 </h4>
                    </div>
                    <div class="mt20 tac">
                        <h1 id="userCount" class="custom_modify_h1" style="display: none;"> 0 </h1>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="chartContainer" style="width: 100%; min-height: 400px; margin: 0 auto; display: none;"></div>
    <div id="emptySpaceMessageArea" style="display: none;">
        <h4 class="modify_h4 tac" style="min-height: 200px; line-height: 200px;"> 생성된 공간이 없습니다. </h4>
    </div>
</div>
<div id="btnMoveMainArea" style="display: none;">
    <div class="fr">
        <button type="button" class="btn btn-default" id="btnMoveMain"> 목록 </button>
    </div>
</div>
<div class="cl_b"></div>

<%--HIDDEN VALUE--%>
<input type="hidden" id="organizationId" name="organizationId" value="<c:out value='${ORGANIZATION_ID}' default='' />" />


<%--
====================================================================================================
SCRIPT BEGIN
====================================================================================================
--%>


<script type="text/javascript">

    var MAIN_DASH_BOARD_URL = "<c:url value='/main' />";
    var MAIN_DASH_BOARD_ORGANIZATION_URL = "<c:url value='/main/organization' />";
    var TOTAL_COUNT_LIST_PROC_URL = "<c:url value='/main/getTotalCountList' />";
    var TOTAL_ORGANIZATION_LIST_PROC_URL = "<c:url value='/main/getTotalOrganizationList' />";
    var TOTAL_SPACE_LIST_PROC_URL = "<c:url value='/main/getTotalSpaceList' />";


    // GET LIST
    var getTotalCountList = function() {
        procCallAjax(TOTAL_COUNT_LIST_PROC_URL, {}, procCallbackGetTotalCountList);
    };


    // GET LIST CALLBACK
    var procCallbackGetTotalCountList = function(data) {
//        var resultList = data.list[0];
//        var organizationCount = $('#organizationCount');
//        var spaceCount = $('#spaceCount');
//        var applicationCount = $('#applicationCount');
//        var userCount = $('#userCount');
//
//        organizationCount.text(resultList.organizationCount);
//        spaceCount.text(resultList.spaceCount);
//        applicationCount.text(resultList.applicationCount);
//        userCount.text(resultList.userCount);
//
//        organizationCount.fadeIn();
//        spaceCount.fadeIn();
//        applicationCount.fadeIn();
//        userCount.fadeIn();

        var organizationId = $('#organizationId').val();

        if ('' == organizationId) {
            getTotalOrganizationList();
        } else {
            getTotalSpaceList(organizationId);
        }
    };

////////////////////////////////////////////////////////////////

    // GET LIST
    var getTotalOrganizationList = function() {
        procCallAjax(TOTAL_ORGANIZATION_LIST_PROC_URL, {}, procCallbackGetTotalOrganizationList);
    };


    // GET LIST CALLBACK
    var procCallbackGetTotalOrganizationList = function(data) {
        setOrganizationChart(data);
    };


    // GET LIST
    var getTotalSpaceList = function(reqOrganizationId) {
        procCallAjax(TOTAL_SPACE_LIST_PROC_URL, {organizationId : reqOrganizationId}, procCallbackGetTotalSpaceList);
    };


    // GET LIST CALLBACK
    var procCallbackGetTotalSpaceList = function(data) {
        setSpaceChart(data);
    };


    // SET MAIN CHART
    var setOrganizationChart = function(data) {
        var resultList = data.list;
        var chartContainer = $('#chartContainer');
        var listLength = resultList.length;

        // SET OPTIONS
        var chartOptions = setOrganizationChartOptions(resultList);

        // EXECUTE CHART
        chartContainer.css('height', listLength * 50 + 'px');
        chartContainer.fadeIn();
        chartContainer.highcharts(chartOptions);

        // SET LINK
        var arrayOrganizationName = $('.highcharts-xaxis-labels text');

        for (var i = 0; i < listLength; i++) {
            arrayOrganizationName[i].onclick = function() {
                procMovePage(MAIN_DASH_BOARD_ORGANIZATION_URL + "/" + getOrganizationId($(this).children().text(), resultList));
            };
        }

        $('.highcharts-xaxis-labels tspan').on("mouseover", function() {
            $(this).attr('style', 'cursor: pointer;');
        });
    };


    // GET ORGANIZATION ID
    var getOrganizationId = function(reqOrganizationName, reqList) {
        var resultList = reqList;
        var listLength = resultList.length;
        var resultOrganizationId = '';

        for (var i = 0; i < listLength; i++) {
            if (reqOrganizationName == resultList[i].organizationName) {
                resultOrganizationId = resultList[i].organizationId;
            }
        }

        return resultOrganizationId;
    };


    // SET CHART OPTIONS
    var setOrganizationChartOptions = function(resultList) {
        var listLength = resultList.length;
        var arrayOrganizationName = [];
        var arraySpaceCount = [];
        var arrayApplicationCount = [];
        var arrayUserCount = [];
        var organizationName = '';

        for (var i = 0; i < listLength; i++) {
            organizationName = resultList[i].organizationName;
            arrayOrganizationName.push(organizationName);

            for (var j = 0; j < listLength; j++) {
                if (organizationName == resultList[j].organizationName) {
                    arraySpaceCount.push(resultList[j].spaceCount);
                    arrayApplicationCount.push(resultList[j].applicationCount);
                    arrayUserCount.push(resultList[j].userCount);
                }
            }
        }

        arrayOrganizationName.join(',');
        arraySpaceCount.join(',');
        arrayApplicationCount.join(',');
        arrayUserCount.join(',');

        return {
            chart: {
                type: 'bar'
            },
            title: {
                text: ''
            },
            subtitle: {
                text: ''
            },
            xAxis: {
                categories: arrayOrganizationName,
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
                name: 'APP',
                data: arrayApplicationCount
            }, {
                name: '공간',
                data: arraySpaceCount
            }, {
                name: '사용자',
                data: arrayUserCount
            }]
        };
    };


    // SET MAIN CHART
    var setSpaceChart = function(data) {
        var resultList = data.list;
        var chartContainer = $('#chartContainer');
        var listLength = resultList.length;

        // CHECK EMPTY SPACE
        if (0 == listLength) {
            setViewEmptySpaceMessageArea();
            return false;
        }

        // SET OPTIONS
        var chartOptions = setSpaceChartOptions(resultList);

        // EXECUTE CHART
        chartContainer.css('height', listLength * 80 + 'px');
        chartContainer.fadeIn();
        chartContainer.highcharts(chartOptions);

        // VIEW BUTTON
        $('#btnMoveMainArea').fadeIn();

        // BIND :: BUTTON EVENT
        $("#btnMoveMain").on("click", function() {
            procMovePage(MAIN_DASH_BOARD_URL);
        });
    };


    // VIEW EMPTY SPACE MESSAGE AREA
    var setViewEmptySpaceMessageArea = function () {
        $('#emptySpaceMessageArea').fadeIn();
        $('#btnMoveMainArea').fadeIn();

        $("#btnMoveMain").on("click", function() {
            procMovePage(MAIN_DASH_BOARD_URL);
        });
    };


    // SET CHART OPTIONS
    var setSpaceChartOptions = function(resultList) {
        var listLength = resultList.length;
        var arraySpaceName = [];
        var arrayApplicationCount = [];
        var spaceName = '';

        for (var i = 0; i < listLength; i++) {
            spaceName = resultList[i].spaceName;
            arraySpaceName.push(spaceName);

            for (var j = 0; j < listLength; j++) {
                if (spaceName == resultList[j].spaceName) {
                    arrayApplicationCount.push(resultList[j].applicationCount);
                }
            }
        }

        arraySpaceName.join(',');
        arrayApplicationCount.join(',');

        return {
            chart: {
                type: 'bar'
            },
            title: {
                text: ''
            },
            subtitle: {
                text: ''
            },
            xAxis: {
                categories: arraySpaceName,
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
                name: 'APP',
                data: arrayApplicationCount
            }]
        };
    };


    // INIT PAGE
    var procInitPage = function() {
        getTotalCountList();
        procAlert("info", WELCOME_MESSAGE);
    };


    // ON LOAD
    $(document.body).ready(function() {
        procInitPage();
    });

</script>


<%--
====================================================================================================
SCRIPT END
====================================================================================================
--%>


<%--FOOTER--%>
<%@ include file="../common/footer.jsp"%>

