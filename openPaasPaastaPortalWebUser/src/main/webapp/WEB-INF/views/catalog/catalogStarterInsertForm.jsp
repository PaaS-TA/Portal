<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../layout/top.jsp" %>
<%@include file="catalogLeft.jsp" %>
<%@include file="../layout/alert.jsp" %>

<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/bootstrap-toggle.min.css'/>">
<script type="text/javascript" src="<c:url value='/resources/js/bootstrap-toggle.min.js' />"></script>
<link rel="stylesheet" href="<c:url value='/resources/css/custom-common.css' />">

<div id="catalogFormView" style="padding-top: 1px; display: none;">
    <div class="panel content-box col-sm-12 col-md-12 mt-5">
        <div class="col-sm-12 pt0">
            <h4 id="catalogTitle" class="modify_h4 fwb"> title </h4>
            <hr>
            <h6 id="catalogDescription" style="color: #a2a2a2; margin-top: -10px;"> desc </h6>
        </div>
    </div>
    <div class="panel content-box col-sm-12 col-md-12">
        <div class="col-sm-12 pt10">
            <div class="fl">
                <h4 class="modify_h4 fwb"> 앱 템플릿 구성 </h4>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-6 col-md-3">
                <div class="applist" data-toggle="tooltip" data-placement="bottom" title="description"
                     id="catalogBuildPackDescription">
                    <img src="<c:url value='/resources/images/noimage.jpg'/>" class="img-circle"
                         id="catalogBuildPackImage">
                    <div class="name">
                        <p id="catalogBuildPackNameTitle"> name </p>
                    </div>
                </div>
            </div>
            <div id="catalogServicePackList">
            </div>
        </div>
    </div>

    <input type="hidden" id="catalogBuildPackName" name="catalogBuildPackName" value="" />

    <div class="row" style="margin-top:-19px">
        <div class="panel content-box col-md-6 col-md-offset-13">
            <div class="col-sm-4 pt0">
                <h4 class="modify_h4 fwb"> 앱 생성 </h4>
            </div>
            <div class="col-sm-12 mt20">
                <span style="font-size:18px;"> 조직 </span>
            </div>
            <div class="col-sm-12 pt5 ml1">
                <span id="catalogOrgName" style="color:#a2a2a2;"> org </span>
            </div>
            <div class="col-sm-12 mt20">
                <span style="font-size:18px;"> 공간 </span>
            </div>
            <div class="col-sm-12 pt5">
                <label for="spaceName" class="control-label sr-only"></label>
                <select id="spaceName" name="spaceName" class="form-control"
                        style="border-radius: 5px; height: 31px;
                        background:url(/resources/images/btn_down.png) no-repeat right;">
                </select>
            </div>
            <div class="col-sm-12 mt20">
                <span style="font-size:18px;">앱 이름 </span>
            </div>
            <div class="col-sm-12 mt10">
                <div class="form-group has-warning has-feedback" id="div_applicationName">
                    <label class="control-label sr-only" for="applicationName"></label>
                    <input type="text" class="form-control" id="applicationName"
                           aria-describedby="inputStatus_applicationName" maxlength="100" placeholder="새 앱 이름 입력">
                    <span class="glyphicon glyphicon-warning-sign custom-form-control-feedback"
                          id="spanIcon_applicationName" aria-hidden="true"></span>
                    <span id="inputStatus_applicationName" class="sr-only">(success)</span>
                </div>
            </div>
            <div class="col-sm-12 mt20">
                <span style="font-size:18px;">앱 URL</span>
            </div>
            <div class="col-sm-12 mt10">
                <div class="form-group has-warning has-feedback" id="div_hostName">
                    <label class="control-label sr-only" for="hostName"></label>
                    <input type="text" class="form-control" id="hostName"
                           aria-describedby="inputStatus_hostName" maxlength="100" placeholder="호스트 입력">
                    <span class="glyphicon glyphicon-warning-sign custom-form-control-feedback"
                          id="spanIcon_hostName" aria-hidden="true"></span>
                    <span id="inputStatus_hostName" class="sr-only">(success)</span>
                </div>
            </div>
            <div class="col-sm-12 mt20">
                <span style="font-size:18px;"> 메모리(MB) </span>
            </div>
            <div class="col-sm-12 pt5">
                <label for="memorySize" class="control-label sr-only"></label>
                <select id="memorySize" name="memorySize" class="form-control"
                        style="border-radius: 5px; height: 31px;
                        background:url(/resources/images/btn_down.png) no-repeat right;">
                </select>
            </div>
            <div class="col-sm-12 mt20">
                <span style="font-size:18px;"> 디스크(MB) </span>
            </div>
            <div class="col-sm-12 pt5">
                <label for="diskSize" class="control-label sr-only"></label>
                <select id="diskSize" name="diskSize" class="form-control"
                        style="border-radius: 5px; height: 31px;
                        background:url(/resources/images/btn_down.png) no-repeat right;">
                </select>
            </div>
            <div class="col-sm-12 mt20">
                <span style="font-size:18px;">도메인</span>
            </div>
            <div id="catalogDomainList" class="col-sm-12 pt5 ml1">
            </div>
            <div id="catalogAppSampleStartCheckArea" class="col-sm-12 mt20 mb10" style="height: 28px; display: none;">
                <div class="fl">
                    <span style="font-size:18px;">앱 시작여부</span>
                </div>
                <div class="ml20 fl">
                    <label class="control-label sr-only" for="checkBoxAppSampleStartYn"></label>
                    <input type="checkbox" id="checkBoxAppSampleStartYn" name="checkBoxAppSampleStartYn"
                           checked data-toggle="toggle" data-size="mini" data-style="ios" />
                </div>
            </div>
        </div>
        <div class="panel content-box col-md-6 col-md-offset-13">
            <div class="col-sm-12 pt0">
                <h4 class="modify_h4 fwb"> 서비스 이용사양 선택 </h4>
            </div>
            <div id="catalogServicePlanList">
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-5 pt20 tar ml60 fr">
            <button type="button" id="btnSave" class="btn btn-point btn-sm">
                생성
            </button>
            <button type="button" id="btnCancel" class="btn btn-cancel btn-sm">
                취소
            </button>
        </div>
    </div>
</div>

<%--HIDDEN VALUE--%>
<input type="hidden" id="catalogNo" name="catalogNo" value="<c:out value='${CATALOG_NO}' default='' />" />
<input type="hidden" id="appSampleStartYn" name="appSampleStartYn" value="<%= Constants.USE_YN_Y %>" />
<input type="hidden" id="appSampleFilePath" name="appSampleFilePath" value="" />
<input type="hidden" id="resultAppGuid" name="resultAppGuid" value="" />


<%--
====================================================================================================
SCRIPT BEGIN
====================================================================================================
--%>


<script type="text/javascript">

    var STARTER_CATALOG_LIST_PROC_URL = "<c:url value='/catalog/getStarterNamesList' />";
    var CATALOG_SPACE_LIST_PROC_URL = "<c:url value='/catalog/getCatalogSpaceList' />";
    var CATALOG_MULTI_SERVICE_PLAN_LIST_PROC_URL = "<c:url value='/catalog/getCatalogMultiServicePlanList' />";
    var CATALOG_DOMAIN_LIST_PROC_URL = "<c:url value='/catalog/getCatalogDomainList' />";
    var CATALOG_STARTER_RELATION_LIST_PROC_URL = "<c:url value='/catalog/getCatalogStarterRelationList' />";
    var CHECK_APPLICATION_NAME_PROC_URL = "<c:url value='/catalog/getCheckCatalogApplicationNameExists' />";
    var CHECK_ROUTE_EXISTS_PROC_URL = "<c:url value='/catalog/getCheckCatalogRouteExists' />";
    var CHECK_SERVICE_INSTANCE_NAME_PROC_URL = "<c:url value='/catalog/getCheckCatalogServiceInstanceNameExists' />";
    var CATALOG_STARTER_CF_RUN_PROC_URL = "<c:url value='/catalog/executeCatalogStarter' />";
    var CATALOG_HISTORY_STARTER_INSERT_PROC_URL = "<c:url value='/catalog/insertCatalogHistoryStarter' />";
    var SPACE_SESSION_SET_PROC_URL = "<c:url value='/space/setSpaceSession' />";
    var SPACE_MAIN_URL = "<c:url value='/space/spaceMain' />";

    var RESULT_CATALOG_STARTER_SERVICE_PLAN_LIST = [];
    var CATALOG_APPLICATION_NAME = "applicationName";
    var CATALOG_HOST_NAME = "hostName";
    var CATALOG_SERVICE_INSTANCE_NAME = "requestServiceInstanceName";
    var CHECK_APPLICATION_NAME = false;
    var CHECK_HOST_NAME = false;

    var COMMON_CODE_LIST_PROC_URL = "<c:url value='/commonCode/getCommonCode' />";
    var CATALOG_APP_MEMORY_SIZE = "<%= Constants.CATALOG_APP_MEMORY_SIZE %>";
    var CATALOG_APP_DISK_SIZE = "<%= Constants.CATALOG_APP_DISK_SIZE %>";


    // GET CATALOG INSERT FORM
    var getCatalogInsertForm = function () {
        var reqCatalogNo = document.getElementById('catalogNo').value;
        if (!procCheckValidNull(reqCatalogNo)) return false;

        procCallAjax(STARTER_CATALOG_LIST_PROC_URL, {no : reqCatalogNo}, procSetCommonInsertForm);
    };


    // SET COMMON INSERT FORM
    var procSetCommonInsertForm = function (data) {
        if (RESULT_STATUS_FAIL == data.RESULT) return false;

        var catalogList = data.list;
        var catalogDescriptionObject = $('#catalogDescription');
        var catalogDescription = catalogList[0].description;

        $('#catalogTitle').text(catalogList[0].name);
        $('#catalogImage').attr('src', procCheckImage(catalogList[0].thumbImgPath));
        $('#catalogOrgName').text(currentOrg);

        catalogDescriptionObject.html(catalogDescription.replace(/\r?\n/g, '<br>')).attr('title', catalogDescription);

        getSpaceList();
    };


    // GET LIST :: SPACE
    var getSpaceList = function () {
        var reqOrgName = currentOrg;
        if (!procCheckValidNull(reqOrgName)) {
            procSetCompleteCatalogView();
            return false;
        }

        procCallAjax(CATALOG_SPACE_LIST_PROC_URL, {orgName : reqOrgName}, procCallbackSpaceList);
    };


    // GET LIST CALLBACK :: SPACE
    var procCallbackSpaceList = function (data) {
        if (RESULT_STATUS_FAIL == data.RESULT) return false;

        var spaceList = data.list;
        var listLength = spaceList.length;
        var objSelectBox = $('#spaceName');
        var spaceName = '';
        var selectedCss = '';
        var htmlString = [];

        for (var i = 0; i < listLength; i++) {
            spaceName = spaceList[i].name;
            selectedCss = (spaceName == currentSpace)? ' selected' : '';
            htmlString.push("<option style='color: #626262;' value='" + spaceName + "'" + selectedCss + ">" + spaceName + "</option>");
        }

        objSelectBox.append(htmlString);
        getApplicationMemorySizeList();
        getApplicationDiskSizeList();
        getStarterRelationList();
    };


    // GET APPLICATION MEMORY SIZE LIST
    var getApplicationMemorySizeList = function() {
        procCallAjax(COMMON_CODE_LIST_PROC_URL + "/" + CATALOG_APP_MEMORY_SIZE, null, procCallbackApplicationMemorySizeList);
    };


    // GET APPLICATION MEMORY SIZE LIST CALLBACK
    var procCallbackApplicationMemorySizeList = function(data) {
        if (RESULT_STATUS_FAIL == data.RESULT) return false;

        var objSelectBox = $('#memorySize');
        var listLength = data.list.length;
        var htmlString = [];

        for (var i = 0; i < listLength; i++) {
            htmlString.push("<option style='color: #626262;' value='" + data.list[i].key + "'>" + data.list[i].value + "</option>");
        }

        objSelectBox.append(htmlString);
    };


    // GET APPLICATION DISK SIZE LIST
    var getApplicationDiskSizeList = function() {
        procCallAjax(COMMON_CODE_LIST_PROC_URL + "/" + CATALOG_APP_DISK_SIZE, null, procCallbackApplicationDiskSizeList);
    };


    // GET APPLICATION DISK SIZE LIST CALLBACK
    var procCallbackApplicationDiskSizeList = function(data) {
        if (RESULT_STATUS_FAIL == data.RESULT) return false;

        var objSelectBox = $('#diskSize');
        var listLength = data.list.length;
        var htmlString = [];

        for (var i = 0; i < listLength; i++) {
            htmlString.push("<option style='color: #626262;' value='" + data.list[i].key + "'>" + data.list[i].value + "</option>");
        }

        objSelectBox.append(htmlString);
    };


    // STARTER :: GET RELATION LIST
    var getStarterRelationList = function () {
        var reqCatalogNo = document.getElementById('catalogNo').value;
        if (!procCheckValidNull(reqCatalogNo)) return false;

        procCallAjax(CATALOG_STARTER_RELATION_LIST_PROC_URL, {catalogNo : reqCatalogNo}, procCallbackStarterRelationList);
    };


    // GET LIST CALLBACK :: STARTER :: GET RELATION LIST
    var procCallbackStarterRelationList = function (data) {
        if (RESULT_STATUS_FAIL == data.RESULT) return false;

        var buildPackList = data.buildPackList;
        var servicePackList = data.servicePackList;
        var servicePackListLength = data.servicePackList.length;
        var objDiv = $('#catalogServicePackList');
        var reqArrayParam = [];
        var htmlString = [];

        RESULT_CATALOG_STARTER_SERVICE_PLAN_LIST = [];

        // STARTER RELATION :: BUILD PACK
        $('#catalogBuildPackImage').attr('src', procCheckImage(buildPackList[0].thumbImgPath));
        $('#catalogBuildPackNameTitle').text(buildPackList[0].name);
        $('#catalogBuildPackDescription').attr('title', buildPackList[0].description);
        $('#catalogBuildPackName').val(buildPackList[0].buildPackName);

        var appSampleFilePath = buildPackList[0].appSampleFilePath;
        if (null != appSampleFilePath && '' != appSampleFilePath) {
            $('#appSampleFilePath').val(appSampleFilePath);
            $('#catalogAppSampleStartCheckArea').show();
        } else {
            $('#appSampleStartYn').val('<%= Constants.USE_YN_N %>');
        }

        for (var i = 0; i < servicePackListLength; i++) {
            reqArrayParam.push({
                servicePackName: servicePackList[i].servicePackName,
                name: servicePackList[i].name,
                parameter: servicePackList[i].parameter
            });

            htmlString.push('<div class="col-sm-6 col-md-3">'
                + '<div class="applist" data-toggle="tooltip" data-placement="bottom" title="'
                + servicePackList[i].description + '">'
                + '<img src=' + procCheckImage(servicePackList[i].thumbImgPath) + ' class="img-circle">'
                + '<div class="name"><p>' +  servicePackList[i].name
                + '</p></div></div></div>');
        }

        getMultiServicePlanList(reqArrayParam);

        objDiv.append(htmlString);

        $('[data-toggle="tooltip"]').tooltip();

        // BIND :: BUTTON EVENT
        $(".btnViewDocument").on("click", function () {
            showAlert('success', 'READY FOR DOCUMENTS!');
        });
    };


    // GET LIST :: STARTER :: MULTI SERVICE PLAN
    var getMultiServicePlanList = function (reqArrayServiceName) {
        if (!procCheckValidNull(reqArrayServiceName)) return false;

        var param = {orgName : currentOrg,
                     spaceName : document.getElementById('spaceName').value,
                     servicePlanList : reqArrayServiceName
        };

        procCallAjax(CATALOG_MULTI_SERVICE_PLAN_LIST_PROC_URL, param, procCallbackMultiServicePlanList);
    };


    // GET LIST CALLBACK :: STARTER :: MULTI SERVICE PLAN LIST
    var procCallbackMultiServicePlanList = function (data) {
        if (RESULT_STATUS_FAIL == data.RESULT) return false;

        var objDiv = $('#catalogServicePlanList');
        var htmlString = [];

        RESULT_CATALOG_STARTER_SERVICE_PLAN_LIST = data.list;

        var resultList = data.list;
        var listCount = resultList.length;

        for (var i = 0; i < listCount; i++) {
            var tempCss = (i > 0)? ' mt50': ' mt20';
            var parameter = resultList[i].parameter;

            if (undefined == parameter || null == parameter || 'null' == parameter) parameter = '';

            htmlString.push('<div class="col-sm-9' + tempCss + '">'
                + '<span style="font-size:18px;">' + resultList[i].name + '</span></div>'
                + '<div class="col-sm-3 fr' + tempCss + '" style="height: 28px;">'
                + '<div class="fr"><div class="fl"><span style="color:#a2a2a2;">앱 연결여부</span></div>'
                + '<div class="ml10 fl">'
                + '<label class="control-label sr-only" for="checkBoxAppBindYn_' + i + '"></label>'
                + '<input type="checkbox" id="checkBoxAppBindYn_' + i + '" class="checkBoxAppBindYn ml20" '
                + 'name="checkBoxAppBindYn_' + i + '" checked data-toggle="toggle" '
                + 'data-size="mini" data-style="ios" /></div></div></div>'
                + '<input type="hidden" id="appBindYn_' + i + '" name="appBindYn_' + i + '" '
                + 'value="' + '<%= Constants.USE_YN_Y %>' + '" />'

                + '<div class="col-sm-12 mt10">'
                + '<div id="div_requestServiceInstanceName_' + i + '" class="form-group has-warning has-feedback">'
                + '<label class="control-label sr-only" for="requestServiceInstanceName_' + i + '"></label>'
                + '<input type="text" class="form-control requestServiceInstanceName" '
                + 'id="requestServiceInstanceName_' + i + '" '
                + 'aria-describedby="inputStatus_requestServiceInstanceName_' + i + '" maxlength="100" '
                + 'placeholder="서비스 이름 입력">'
                + '<span class="glyphicon glyphicon-warning-sign custom-form-control-feedback" '
                + 'id="spanIcon_requestServiceInstanceName_' + i + '" aria-hidden="true"></span>'
                + '<span id="inputStatus_requestServiceInstanceName_' + i + '" '
                + 'class="sr-only">(success)</span></div></div>'

                + '<div class="col-sm-12 mt10"><span style="font-size:18px;"> 서비스 파라미터 </span></div>'
                + '<div class="col-sm-12 mt10"><div class="form-group has-default has-feedback">'
                + '<label class="control-label sr-only" for="serviceParameter_' + i + '"></label>'
                + '<input type="text" class="form-control" id="serviceParameter_' + i + '" maxlength="100" '
                + 'placeholder="(Optional) 서비스 파라미터 입력" value=\'' + parameter + '\'></div></div>'

                + '<div class="col-sm-12 mt10"><span style="font-size:18px;"> 서비스 이용사양 선택 </span></div>'
                + '<div class="col-sm-12 pt5">'
                + '<label for="servicePlan_' + i + '" class="control-label sr-only"></label>'
                + '<select id="servicePlan_' + i + '" name="servicePlan_' + i + '" class="form-control servicePlan" '
                + 'style="border-radius: 5px; height: 31px; '
                + 'background:url(/resources/images/btn_down.png) no-repeat right;"></select>'
                + '<div class="col-sm-12 pt5 ml1 mt5"><div <span style="color:#a2a2a2;" '
                + 'id="servicePlanDescription_' + i + '"></span></div></div>'
                + '<input type="hidden" id="requestServiceInstanceName_' + i + '_check"'
                + ' name="requestServiceInstanceName_' + i + '_check"' + ' value="' + RESULT_STATUS_FAIL + '" />');
        }

        objDiv.append(htmlString);

        for (var j = 0; j < listCount; j++) {
            var resultSubList = resultList[j].list;
            var subListCount = resultSubList.length;

            htmlString = [];
            for (var k = 0; k < subListCount; k++) {
                htmlString.push('<option style="color: #626262;" value="' + resultSubList[k].guid + '">' + resultSubList[k].name + '</option>');

                if (k == 0) $('#servicePlanDescription_' + j).text(resultSubList[k].description);
            }

            $('#servicePlan_' + j).append(htmlString);
        }

        // GET DOMAIN LIST :: STARTER
        getDomainList();

        // BIND :: SELECT BOX CHANGE
        $(".servicePlan").on("change", function () {
            procSetServicePlanDescription(this.id);
        });

        // BIND :: INPUT TEXT BOX KEY UP
        $(".requestServiceInstanceName").on("keyup", function () {
            var tempArray = this.id.split('_');

            procCheckServiceInstanceName(tempArray[1], false);
            procCheckAllServiceInstanceName();
        });

        // BIND :: TOGGLE CHANGE
        $(".checkBoxAppBindYn").on("change", function () {
            var tempArray = this.id.split('_');
            var appBindYn = $("#appBindYn_" + tempArray[1]);

            if ($(this).prop('checked')) {
                appBindYn.val('<%= Constants.USE_YN_Y %>');
            } else {
                appBindYn.val('<%= Constants.USE_YN_N %>');
            }
        }).bootstrapToggle({
            on: 'ON',
            off: 'OFF',
            width: 60
        });
    };


    // GET LIST :: DOMAIN
    var getDomainList = function () {
        procCallAjax(CATALOG_DOMAIN_LIST_PROC_URL, {}, procCallbackDomainList);
    };


    // GET LIST CALLBACK :: DOMAIN
    var procCallbackDomainList = function (data) {
        if (RESULT_STATUS_FAIL == data.RESULT) return false;

        var domainList = data.list;
        var listLength = domainList.length;
        var objDiv = $('#catalogDomainList');
        var htmlString = [];

        for (var i = 0; i < listLength; i++) {
            htmlString.push('<span style="color: #a2a2a2;">' + domainList[i].name + '</span>'
                    + '<input type="hidden" id="catalogDomainName_' + i + '" value="' + domainList[i].name + '">'
                    + '<input type="hidden" id="catalogDomainGuid_' + i + '" value="' + domainList[i].meta.guid + '">');
        }

        objDiv.append(htmlString);

        procSetCompleteCatalogView();
    };


    // SET COMPLETE CATALOG VIEW
    var procSetCompleteCatalogView = function () {
        $('#catalogFormView').show();
        $('#footer').show();
        procCallSpinner(SPINNER_SPIN_STOP);

        $('#applicationName').focus();
        window.scrollTo(0, 0);
    };


    // CHECK APPLICATION NAME
    var procCheckApplicationName = function () {
        var applicationNameObject= $('#applicationName');

        if (!procCheckStringFormat(CATALOG_APPLICATION_NAME, applicationNameObject)) {
            var resultStatusFail = RESULT_STATUS_FAIL;
            procSetInputTextObjectName(CATALOG_APPLICATION_NAME, resultStatusFail);
            procSetInputTextObjectName(CATALOG_HOST_NAME, resultStatusFail);
            procCopyApplicationNameToHostName(false);
            return false;
        }

        var param = {orgName : currentOrg,
                     spaceName : document.getElementById('spaceName').value,
                     name : applicationNameObject.val()
        };

        procCallAjax(CHECK_APPLICATION_NAME_PROC_URL, param, procCallbackCheckApplicationName);
    };


    // GET LIST CALLBACK :: CHECK APPLICATION NAME
    var procCallbackCheckApplicationName = function (data) {
        var resultStatus = data.RESULT;

        if (RESULT_STATUS_FAIL == resultStatus) showAlert('fail', data.RESULT_MESSAGE);
        if (RESULT_STATUS_SUCCESS == resultStatus) showAlert('success', '');

        procSetInputTextObjectName(CATALOG_APPLICATION_NAME, resultStatus);
        procSetInputTextObjectName(CATALOG_HOST_NAME, resultStatus);
        procCopyApplicationNameToHostName(true);
    };


    // COPY APPLICATION NAME TO HOST NAME
    var procCopyApplicationNameToHostName = function (reqBooleanCheck) {
        var doc = document;
        var applicationName = doc.getElementById('applicationName').value;
        var hostNameObject = $('#hostName');
        var tempValue = '';

        if ('' != applicationName) tempValue = applicationName + "." + doc.getElementById('catalogDomainName_0').value;

        hostNameObject.val(tempValue);

        if (reqBooleanCheck) {
            procCheckHostName();
            procCopyApplicationNameToServiceInstanceName();
        }
    };


    // CHECK HOST NAME
    var procCheckHostName = function () {
        var hostNameObject= $('#hostName');

        if (!procCheckStringFormat(CATALOG_HOST_NAME, hostNameObject)) {
            procSetInputTextObjectName(CATALOG_HOST_NAME, RESULT_STATUS_FAIL);
            return false;
        }

        var doc = document;
        var param = {orgName : currentOrg,
                     spaceName : doc.getElementById('spaceName').value,
                     domainName : doc.getElementById('catalogDomainName_0').value,
                     routeName : hostNameObject.val()
        };

        procCallAjax(CHECK_ROUTE_EXISTS_PROC_URL, param, procCallbackCheckHostName);
    };


    // GET LIST CALLBACK :: CHECK HOST NAME
    var procCallbackCheckHostName = function (data) {
        var resultStatus = data.RESULT;

        if (RESULT_STATUS_FAIL == resultStatus) showAlert('fail', data.RESULT_MESSAGE);
        if (RESULT_STATUS_SUCCESS == resultStatus) showAlert('success', '');

        procSetInputTextObjectName(CATALOG_HOST_NAME, data.RESULT);
    };


    // COPY APPLICATION NAME TO SERVICE INSTANCE NAME
    var procCopyApplicationNameToServiceInstanceName = function () {
        var servicePlanList = RESULT_CATALOG_STARTER_SERVICE_PLAN_LIST;
        var listCount = servicePlanList.length;

        for (var i = 0; i < listCount; i++) {
            var requestServiceInstanceName = $('#requestServiceInstanceName_' + i);
            requestServiceInstanceName.val('');
            requestServiceInstanceName.val(document.getElementById('applicationName').value + '-' + servicePlanList[i].servicePackName + '-instance');

            procCheckServiceInstanceName(i, true);
        }
    };


    // CHECK SERVICE INSTANCE NAME
    var procCheckServiceInstanceName = function (reqServiceInstanceNameIndex, booleanCheckAllStatus) {
        var requestServiceInstanceName = $('#requestServiceInstanceName_' + reqServiceInstanceNameIndex).val();

        var param = {orgName : currentOrg,
                     spaceName : document.getElementById('spaceName').value,
                     serviceInstanceName : requestServiceInstanceName,
                     reqServiceInstanceNameObject : CATALOG_SERVICE_INSTANCE_NAME + '_' + reqServiceInstanceNameIndex,
                     booleanCheckAllStatus : booleanCheckAllStatus
        };

        procCallAjax(CHECK_SERVICE_INSTANCE_NAME_PROC_URL, param, procCallbackCheckServiceInstanceName);
    };


    // GET CALLBACK :: CHECK SERVICE INSTANCE NAME
    var procCallbackCheckServiceInstanceName = function (data, reqParam) {
        var resultStatus = data.RESULT;
        var reqServiceInstanceNameObject = reqParam.reqServiceInstanceNameObject;

        $('#' + reqServiceInstanceNameObject + '_check').val(resultStatus);

        if (RESULT_STATUS_FAIL == resultStatus) showAlert('fail', data.RESULT_MESSAGE);

        procSetInputTextObjectName(reqServiceInstanceNameObject, data.RESULT);
    };


    // CHECK ALL SERVICE INSTANCE NAME
    var procCheckAllServiceInstanceName = function () {
        var listCount = RESULT_CATALOG_STARTER_SERVICE_PLAN_LIST.length;
        var reqObjectName = CATALOG_SERVICE_INSTANCE_NAME;
        var serviceInstanceName = null;
        var reqServiceInstanceName = null;

        for (var i = 0; i < listCount; i++) {
            var resultStatusSuccess = RESULT_STATUS_SUCCESS;
            $('#' + reqObjectName + '_' + i + '_check').val(resultStatusSuccess);
            procSetInputTextObjectName(reqObjectName + '_' + i, resultStatusSuccess);
        }

        for (var j = 0; j < listCount; j++) {
            serviceInstanceName = $('#requestServiceInstanceName_' + j).val();

            for (var k = j + 1; k < listCount; k++) {
                reqServiceInstanceName = $('#requestServiceInstanceName_' + k).val();

                if (serviceInstanceName == reqServiceInstanceName) {
                    var resultStatusFail = RESULT_STATUS_FAIL;
                    $('#' + reqObjectName + '_' + j + '_check').val(resultStatusFail);
                    $('#' + reqObjectName + '_' + k + '_check').val(resultStatusFail);

                    procSetInputTextObjectName(reqObjectName + '_' + j, resultStatusFail);
                    procSetInputTextObjectName(reqObjectName + '_' + k, resultStatusFail);
                }
            }
        }
    };


    // SET INPUT TEXT SERVICE INSTANCE NAME
    var procSetInputTextObjectName = function (reqObjectName, resultStatus) {
        var divObject = $('#div_' + reqObjectName);
        var spanIconObject = $('#spanIcon_' + reqObjectName);
        var resultDivClass = '';
        var resultSpanIconClass = '';

        procSetAvailableSave(reqObjectName, false);

        if (RESULT_STATUS_SUCCESS == resultStatus) {
            resultDivClass = 'form-group has-success has-feedback';
            resultSpanIconClass = 'glyphicon glyphicon-ok custom-form-control-feedback';

            procSetAvailableSave(reqObjectName, true);
        }

        if (RESULT_STATUS_FAIL == resultStatus || RESULT_STATUS_FAIL_DUPLICATED == resultStatus) {
            resultDivClass = 'form-group has-error has-feedback';
            resultSpanIconClass = 'glyphicon glyphicon-remove custom-form-control-feedback';
        }

        if ('' == $('#' + reqObjectName).val()) {
            resultDivClass = 'form-group has-warning has-feedback';
            resultSpanIconClass = 'glyphicon glyphicon-warning-sign custom-form-control-feedback';
        }

        divObject.attr('class', '').addClass(resultDivClass);
        spanIconObject.attr('class', '').addClass(resultSpanIconClass);
    };


    // SET INPUT TEXT SERVICE INSTANCE NAME
    var procSetAvailableSave = function (reqObjectName, reqStatus) {
        if (!procCheckValidNull(reqObjectName)) return false;
        if (!procCheckValidNull(reqStatus)) return false;

        if (CATALOG_APPLICATION_NAME == reqObjectName) CHECK_APPLICATION_NAME = reqStatus;
        if (CATALOG_HOST_NAME == reqObjectName) CHECK_HOST_NAME = reqStatus;
    };


    // SET SERVICE PLAN DESCRIPTION
    var procSetServicePlanDescription = function (reqSelectBoxId) {
        if (!procCheckValidNull(reqSelectBoxId)) return false;

        var tempArray = reqSelectBoxId.split('_');
        var reqSelectBoxIndex = tempArray[1];
        var subServicePlanList = null;
        var subServicePlanListCount = 0;

        var servicePlanList = RESULT_CATALOG_STARTER_SERVICE_PLAN_LIST;
        var servicePlanListCount = servicePlanList.length;

        for (var i = 0; i < servicePlanListCount; i++) {
            subServicePlanList = servicePlanList[i].list;
            subServicePlanListCount = subServicePlanList.length;

            for (var j = 0; j < subServicePlanListCount; j++) {
                if (subServicePlanList[j].guid == $('#' + reqSelectBoxId).val()) {
                    $('#servicePlanDescription_' + reqSelectBoxIndex).text(subServicePlanList[j].description);
                }
            }
        }
    };


    // CATALOG CF RUN
    var procCatalogCfRun= function () {
        var doc = document;
        var applicationNameObject = $('#applicationName');
        var hostNameObject = $('#hostName');

        if (!CHECK_APPLICATION_NAME) {
            showAlert('fail', '<spring:message code="common.info.check.req.name" />');
            applicationNameObject.focus();
            return false;
        }

        if (!CHECK_HOST_NAME) {
            showAlert('fail', '<spring:message code="common.info.check.req.name" />');
            hostNameObject.focus();
            return false;
        }

        var listCount = RESULT_CATALOG_STARTER_SERVICE_PLAN_LIST.length;

        for (var i = 0; i < listCount; i++) {
            var requestServiceInstanceNameCheck = $('#requestServiceInstanceName_' + i + '_check');

            if (RESULT_STATUS_FAIL == requestServiceInstanceNameCheck.val()) {
                showAlert('fail', '<spring:message code="common.info.check.req.name" />');
                $('#requestServiceInstanceName_' + i).focus();
                return false;
            }
        }

        procCallSpinner(SPINNER_SPIN_START);

        var param = procSetInsertRequestParam();
        if (!param) return false;

        if (!procCheckValidParam(hostNameObject)) return false;
        if (!procCheckStringFormat(CATALOG_APPLICATION_NAME, applicationNameObject)) return false;
        if (!procCheckStringFormat(CATALOG_HOST_NAME, hostNameObject)) return false;

        var servicePlanList = [];
        for (var j = 0; j < listCount; j++) {
            servicePlanList.push({
                serviceInstanceName: $('#requestServiceInstanceName_' + j).val(),
                servicePlan: $('#servicePlan_' + j).val(),
                appBindYn: $('#appBindYn_' + j).val(),
                parameter: $('#serviceParameter_' + j).val()
            });
        }

        var catalogTypeParam = {hostName : hostNameObject.val(),
                                buildPackName : doc.getElementById('catalogBuildPackName').value,
                                appSampleStartYn : doc.getElementById('appSampleStartYn').value,
                                appSampleFilePath : doc.getElementById('appSampleFilePath').value,
                                servicePlanList : servicePlanList};

        $.extend(param, catalogTypeParam);

        procCallAjax(CATALOG_STARTER_CF_RUN_PROC_URL, param, procCallbackCatalogCfRun);
    };


    // SET INSERT REQUEST PARAM
    var procSetInsertRequestParam = function () {
        var reqOrgName = currentOrg;
        var spaceName = $('#spaceName');
        var applicationName = $('#applicationName');
        var catalogNo = $('#catalogNo');

        if (!procCheckValidParam(spaceName) || !procCheckValidParam(applicationName) || !procCheckValidParam(catalogNo)) return false;

        return {
            orgName: reqOrgName,
            spaceName: spaceName.val(),
            name: applicationName.val(),
            catalogNo: catalogNo.val(),
            memorySize: $('#memorySize').val(),
            diskSize: $('#diskSize').val()
        };
    };


    // CHECK VALID PARAM
    var procCheckValidParam = function (reqObj) {
        if (!procCheckValidNull(reqObj)) return false;

        if (!procCheckValidNull(reqObj.val())) {
            showAlert('fail', '<spring:message code="common.info.empty.req.data" />');
            procCallSpinner(SPINNER_SPIN_STOP);
            reqObj.focus();
            return false;
        }

        return true;
    };


    // CALLBACK :: CATALOG CF RUN
    var procCallbackCatalogCfRun = function (data, reqParam) {
        var doc = document;

        if (RESULT_STATUS_FAIL == data.RESULT) {
            procCallAjax(SPACE_SESSION_SET_PROC_URL, {spaceName : doc.getElementById("spaceName").value}, procMovePageSpaceMain);
            return false;
        }

        doc.getElementById('resultAppGuid').value = data.APP_GUID;

        procCallAjax(CATALOG_HISTORY_STARTER_INSERT_PROC_URL, reqParam, procCallbackInsertCatalogHistory);
    };


    // CALLBACK :: INSERT CATALOG HISTORY
    var procCallbackInsertCatalogHistory = function () {
        procCallAjax(SPACE_SESSION_SET_PROC_URL, {spaceName : document.getElementById("spaceName").value}, procMovePageSpaceMain);
    };


    // CHECK STRING FORMAT
    var procCheckStringFormat = function (reqObjectName, reqStringObject) {
        if (!procCheckValidNull(reqObjectName)) return false;
        if (!procCheckValidNull(reqStringObject)) return false;

//        var regExpPattern = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
        var regExpPattern = /[\{\}\[\]\/?,;:|\)*~`!^+<>\#$%&\\\=\(\'\"]/gi;
        var regExpBlankPattern = /[\s]/g;
        var reqString = reqStringObject.val();

        // CHECK VALID
        if (regExpPattern.test(reqString) || regExpBlankPattern.test(reqString)) {
            showAlert('fail', '<spring:message code="common.info.check.req.name" />');
            procSetAvailableSave(reqObjectName, false);
            procCallSpinner(SPINNER_SPIN_STOP);
            reqStringObject.focus();
            return false;
        }

        return true;
    };


    // MOVE PAGE SPACE MAIN
    var procMovePageSpaceMain = function () {
        procCallSpinner(SPINNER_SPIN_STOP);
        procMovePage(SPACE_MAIN_URL + "/" + document.getElementById('spaceName').value);
    };


    // INIT PAGE
    var procInitPage = function () {
        $('#footer').hide();
        procCallSpinner(SPINNER_SPIN_START);
        getCatalogLeftMenuList();
    };


    // BIND :: BUTTON EVENT
    $("#btnSave").on("click", function () {
        procCatalogCfRun();
    });


    // BIND :: BUTTON EVENT
    $("#btnCancel").on("click", function () {
        procMovePage(CATALOG_HOME_URL);
    });


    // BIND :: BUTTON EVENT
    $(".btnViewDocument").on("click", function () {
        showAlert('success', 'READY FOR DOCUMENTS!');
    });


    // BIND :: INPUT TEXT BOX KEY UP
    $("#applicationName").on("keyup", function () {
        procCheckApplicationName();
    });


    // BIND :: INPUT TEXT BOX KEY UP
    $("#hostName").on("keyup", function () {
        procCheckHostName();
    });


    // BIND :: INPUT TEXT BOX KEY UP
    $(".requestServiceInstanceName").on("keyup", function () {
        procCheckServiceInstanceName();
    });


    // BIND :: INPUT TEXT BOX KEY UP
    $("#checkBoxAppSampleStartYn").on("change", function () {
        var appSampleStartYn = $("#appSampleStartYn");

        if ($(this).prop('checked')) {
            appSampleStartYn.val('<%= Constants.USE_YN_Y %>');
        } else {
            appSampleStartYn.val('<%= Constants.USE_YN_N %>');
        }
    }).bootstrapToggle({
        on: 'ON',
        off: 'OFF',
        width: 60
    });


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


<%@include file="../layout/bottom.jsp" %>
