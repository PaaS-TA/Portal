<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../layout/topNoGrid.jsp" %>
<%@include file="catalogLeft.jsp" %>
<%@include file="../layout/alert.jsp" %>

<div id="catalogFormView" style="display: none;">

    <%--SERVICE PACK FORM--%>
    <%--LEFT--%>
    <div class="col-sm-7 pt10">
        <div class="col-sm-12 pt10">
            <h4 id="catalogTitle" class="modify_h4"> 서비스 이름 </h4>
        </div>
        <div class="panel content-box col-sm-12 col-md-12">
            <div class="modify_custom_cn_box2 fl">
                <div class="modify_custom_image_box2">
                    <img src="<c:url value='/resources/images/noimage.jpg'/>" class="img-thumbnail" id="catalogImage" style="width: 100px; height: 100px;">
                </div>
            </div>
            <div class="custom_list fl">
                <ul class="mt5">
                    <li><span class="tt modify_panel_title"> 요약 : </span></li>
                    <li><span id="catalogSummary" class="txt2 modify_panel_title"> summary </span></li>
                    <li class="mt10"><span class="tt modify_panel_title"> 설명 : </span></li>
                    <li><span id="catalogDescription" class="txt2 modify_panel_title"> description </span></li>
                </ul>
            </div>
        </div>
    </div>

    <input type="hidden" id="catalogServicePackName" name="catalogServicePackName" value="" />

    <%--RIGHT--%>
    <div class="col-sm-5 pt10">
        <div class="col-sm-12 pt10">
            <h4 class="modify_h4">서비스 생성</h4>
        </div>
        <div class="panel content-box col-sm-12 col-md-12">
            <div class="custom_ttgroup">
                <h4 class="modify_h4"> 조직 </h4>
            </div>
            <div class="ml10 modify_panel_title catalogOrgName">
            </div>
            <div class="custom_ttgroup mt30">
                <h4 class="modify_h4"> 공간 </h4>
            </div>
            <div class="form-group ">
                <label for="spaceName" class="control-label sr-only"></label>
                <select id="spaceName" name="spaceName" class="form-control modify_form_control">
                </select>
            </div>
            <div class="custom_ttgroup mt30">
                <h4 class="modify_h4"> 서비스 이름 </h4>
            </div>
            <div class="form-group has-warning has-feedback" id="div_serviceInstanceName">
                <label class="control-label sr-only" for="serviceInstanceName"></label>
                <input type="text" class="form-control modify_form_control serviceInstanceName" id="serviceInstanceName"
                       aria-describedby="inputStatus_serviceInstanceName" maxlength="100" placeholder="새 서비스 이름 입력">
                <span class="glyphicon glyphicon-warning-sign custom-form-control-feedback" id="spanIcon_serviceInstanceName" aria-hidden="true"></span>
                <span id="inputStatus_serviceInstanceName" class="sr-only">(success)</span>
            </div>
            <div class="custom_ttgroup mt30">
                <h4 class="modify_h4"> 앱 </h4>
            </div>
            <div class="form-group ">
                <label for="appName" class="control-label sr-only"></label>
                <select id="appName" name="appName" class="form-control modify_form_control">
                    <option value="<%= Constants.NONE_VALUE %>"> 연결 없이 시작 </option>
                </select>
            </div>
            <div class="custom_ttgroup mt30">
                <h4 class="modify_h4"> 서비스 이용사양 선택 </h4>
            </div>
            <div id="servicePlanList">
            </div>

            <div id="servicePlanDescription">
            </div>
        </div>
    </div>
    <div class="col-sm-12 pt10 pb10">
        <div class="fr">
            <button type="button" class="btn btn-default btnSave btn-sm" id="btnSave"> 생성 </button>
            <button type="button" class="btn btn-save btnCancel btn-sm" id="btnCancel"> 취소 </button>
        </div>
    </div>
</div>

<%--HIDDEN VALUE--%>
<input type="hidden" id="catalogNo" name="catalogNo" value="<c:out value='${CATALOG_NO}' default='' />" />


<%--
====================================================================================================
SCRIPT BEGIN
====================================================================================================
--%>


<script type="text/javascript">

    var SERVICE_PACK_CATALOG_LIST_PROC_URL = "<c:url value='/catalog/getServicePackCatalogList' />";
    var CATALOG_SPACE_LIST_PROC_URL = "<c:url value='/catalog/getCatalogSpaceList' />";
    var CATALOG_APP_LIST_PROC_URL = "<c:url value='/catalog/getCatalogAppList' />";
    var CATALOG_SERVICE_PLAN_LIST_PROC_URL = "<c:url value='/catalog/getCatalogServicePlanList' />";
    var CHECK_SERVICE_INSTANCE_NAME_PROC_URL = "<c:url value='/catalog/getCheckCatalogServiceInstanceNameExists' />";
    var CATALOG_SERVICE_PACK_CF_RUN_PROC_URL = "<c:url value='/catalog/executeCatalogServicePack' />";
    var CATALOG_HISTORY_SERVICE_PACK_INSERT_PROC_URL = "<c:url value='/catalog/insertCatalogHistoryServicePack' />";
    var CATALOG_STARTER_RE_STAGE_CF_RUN_PROC_URL = "<c:url value='/app/restageApp' />";
    var SPACE_SESSION_SET_PROC_URL = "<c:url value='/space/setSpaceSession' />";
    var SPACE_MAIN_URL = "<c:url value='/space/spaceMain/viewMode/thumbNail' />";

    var RESULT_CATALOG_SERVICE_PACK_SERVICE_PLAN_LIST = [];
    var CATALOG_SERVICE_INSTANCE_NAME = "serviceInstanceName";
    var CHECK_SERVICE_INSTANCE_NAME = false;


    // GET CATALOG INSERT FORM
    var getCatalogInsertForm = function() {
        var reqCatalogNo = document.getElementById('catalogNo').value;
        if (!procCheckValidNull(reqCatalogNo)) return false;

        procCallAjax(SERVICE_PACK_CATALOG_LIST_PROC_URL, {no : reqCatalogNo}, procSetCommonInsertForm);
    };


    // SET COMMON INSERT FORM
    var procSetCommonInsertForm = function(data) {
        if (RESULT_STATUS_FAIL == data.RESULT) return false;

        var catalogList = data.list;
        var catalogSummaryObject = $('#catalogSummary');
        var catalogDescriptionObject = $('#catalogDescription');
        var catalogSummary = catalogList[0].summary;
        var catalogDescription = catalogList[0].description;

        $('#catalogTitle').text(catalogList[0].name);
        $('#catalogImage').attr('src', procCheckImage(catalogList[0].thumbImgPath));
        $('.catalogOrgName').text(currentOrg);

        catalogSummaryObject.html(catalogSummary.replace(/\r?\n/g, '<br>')).attr('title', catalogSummary);
        catalogDescriptionObject.html(catalogDescription.replace(/\r?\n/g, '<br>')).attr('title', catalogDescription);

        $('#catalogServicePackName').val(catalogList[0].servicePackName);

        getSpaceList();
    };


    // GET LIST :: SPACE
    var getSpaceList = function() {
        var reqOrgName = currentOrg;
        if (!procCheckValidNull(reqOrgName)) {
            procSetCompleteCatalogView();
            return false;
        }

        procCallAjax(CATALOG_SPACE_LIST_PROC_URL, {orgName : reqOrgName}, procCallbackSpaceList);
    };


    // GET LIST CALLBACK :: SPACE
    var procCallbackSpaceList = function(data) {
        if (RESULT_STATUS_FAIL == data.RESULT) return false;

        var spaceList = data.list;
        var listLength = spaceList.length;
        var objSelectBox = $('#spaceName');
        var htmlString = [];

        for (var i = 0; i < listLength; i++) {
            if (spaceList[i].name == currentSpace) {
                htmlString.push("<option value='" + spaceList[i].name + "' selected>" + spaceList[i].name + "</option>");
            } else {
                htmlString.push("<option value='" + spaceList[i].name + "'>" + spaceList[i].name + "</option>");
            }

        }

        objSelectBox.append(htmlString);

        getServicePlanList(document.getElementById('catalogServicePackName').value);
    };


    // GET LIST :: SERVICE PLAN
    var getServicePlanList = function(reqServiceName) {
        if (!procCheckValidNull(reqServiceName)) return false;

        var param = {orgName : currentOrg,
                     spaceName : document.getElementById('spaceName').value,
                     servicePackName : reqServiceName
        };

        procCallAjax(CATALOG_SERVICE_PLAN_LIST_PROC_URL, param, procCallbackServicePlanList);
    };


    // GET LIST CALLBACK :: SERVICE PLAN
    var procCallbackServicePlanList = function(data) {
        if (RESULT_STATUS_FAIL == data.RESULT) return false;

        var catalogFormServicePlanListObject = $('#servicePlanList');
        var htmlString = [];

        RESULT_CATALOG_SERVICE_PACK_SERVICE_PLAN_LIST = data.list;

        var resultList = data.list;
        var listCount = resultList.length;

        htmlString.push('<div class="form-group "><label for="servicePlan" class="control-label sr-only"></label>'
                + '<select id="servicePlan" name="servicePlan" class="form-control modify_form_control servicePlan"></select>'
                + '<div class="custom_ttgroup modify_panel_title mt10 ml10" id="servicePlanDescription"></div></div>');

        catalogFormServicePlanListObject.append(htmlString);

        htmlString = [];
        for (var i = 0; i < listCount; i++) {
            htmlString.push('<option value="' + resultList[i].guid + '">' + resultList[i].name + '</option>');
        }

        $('#servicePlan').append(htmlString);
        $('#servicePlanDescription').text(resultList[0].description);

        getAppList(document.getElementById('spaceName').value);

        // BIND :: SELECT BOX CHANGE
        $(".servicePlan").on("change", function() {
            procSetServicePlanDescription(this.id);
        });
    };


    // GET LIST :: APP
    var getAppList = function(reqSpaceName) {
        if (!procCheckValidNull(reqSpaceName)) return false;

        var reqOrgName = currentOrg;
        if (!procCheckValidNull(reqOrgName)) {
            procSetCompleteCatalogView();
            return false;
        }

        var param = {orgName : reqOrgName,
                     spaceName : reqSpaceName
        };

        procCallAjax(CATALOG_APP_LIST_PROC_URL, param, procCallbackAppList);
    };


    // GET LIST CALLBACK :: APP
    var procCallbackAppList = function(data) {
        if (RESULT_STATUS_FAIL == data.RESULT) return false;

        var appList = data.list;
        var listLength = appList.length;
        var objSelectBox = $('#appName');
        var htmlString = [];

        for (var i = 0; i < listLength; i++) {
            htmlString.push("<option value='" + appList[i].guid + "<%= Constants.STRING_SEPARATOR %>" + appList[i].name + "'>" + appList[i].name + "</option>");
        }

        objSelectBox.append(htmlString);

        procSetCompleteCatalogView();
    };


    // SET COMPLETE CATALOG VIEW
    var procSetCompleteCatalogView = function() {
        $('#catalogFormView').show();
        procCallSpinner(SPINNER_SPIN_STOP);

        $('#serviceInstanceName').focus();
        window.scrollTo(0, 0);
    };


    // CHECK SERVICE INSTANCE NAME
    var procCheckServiceInstanceName = function() {
        var serviceInstanceNameObject= $('#serviceInstanceName');

        if (!procCheckStringFormat(serviceInstanceNameObject)) {
            procSetInputTextObjectName(RESULT_STATUS_FAIL, CATALOG_SERVICE_INSTANCE_NAME);

            return false;
        }

        var param = {orgName : currentOrg,
                     spaceName : document.getElementById('spaceName').value,
                     serviceInstanceName : serviceInstanceNameObject.val()
        };

        procCallAjax(CHECK_SERVICE_INSTANCE_NAME_PROC_URL, param, procCallbackCheckServiceInstanceName);
    };


    // GET LIST CALLBACK :: CHECK SERVICE INSTANCE NAME
    var procCallbackCheckServiceInstanceName = function(data) {
        var resultStatus = data.RESULT;

        if (RESULT_STATUS_FAIL == resultStatus) showAlert('fail', data.RESULT_MESSAGE);

        procSetInputTextObjectName(resultStatus, CATALOG_SERVICE_INSTANCE_NAME);
    };


    // SET INPUT TEXT SERVICE INSTANCE NAME
    var procSetInputTextObjectName = function(resultStatus, reqObjectName) {
        var divObject = $('#div_' + reqObjectName);
        var spanIconObject = $('#spanIcon_' + reqObjectName);
        var resultDivClass = '';
        var resultSpanIconClass = '';

        procSetAvailableSave(false);

        if (RESULT_STATUS_SUCCESS == resultStatus) {
            resultDivClass = 'form-group has-success has-feedback';
            resultSpanIconClass = 'glyphicon glyphicon-ok custom-form-control-feedback';

            procSetAvailableSave(true);
        }

        if (RESULT_STATUS_FAIL == resultStatus || RESULT_STATUS_FAIL_DUPLICATED == resultStatus) {
            resultDivClass = 'form-group has-error has-feedback';
            resultSpanIconClass = 'glyphicon glyphicon-remove custom-form-control-feedback';
        }

        if ('<%= Constants.NONE_VALUE %>' == resultStatus || '' == $('#' + reqObjectName + '').val()) {
            resultDivClass = 'form-group has-warning has-feedback';
            resultSpanIconClass = 'glyphicon glyphicon-warning-sign custom-form-control-feedback';
        }

        divObject.attr('class', '').addClass(resultDivClass);
        spanIconObject.attr('class', '').addClass(resultSpanIconClass);
    };


    // SET INPUT TEXT SERVICE INSTANCE NAME
    var procSetAvailableSave = function(reqStatus) {
        if (!procCheckValidNull(reqStatus)) return false;

        CHECK_SERVICE_INSTANCE_NAME = reqStatus;
    };


    // SET SERVICE PLAN DESCRIPTION
    var procSetServicePlanDescription = function(reqSelectBoxId) {
        if (!procCheckValidNull(reqSelectBoxId)) return false;

        var servicePlanList = RESULT_CATALOG_SERVICE_PACK_SERVICE_PLAN_LIST;
        var servicePlanListCount = servicePlanList.length;

        for (var i = 0; i < servicePlanListCount; i++) {
            if (servicePlanList[i].guid == $('#' + reqSelectBoxId).val()) {
                $('#servicePlanDescription').text(servicePlanList[i].description);
            }
        }
    };


    // CATALOG CF RUN
    var procCatalogCfRun= function() {
        if (!CHECK_SERVICE_INSTANCE_NAME) {
            showAlert('fail', '<spring:message code="common.info.check.req.name" />');
            $('#serviceInstanceName').focus();

            return false;
        }

        procCallSpinner(SPINNER_SPIN_START);

        var param = procSetInsertRequestParam();
        if (!param) return false;

        var appName = $('#appName');
        var servicePlan = $('#servicePlan');

        if (!procCheckValidParam(appName)) return false;
        if (!procCheckValidParam(servicePlan)) return false;

        var tempArray = appName.val().split('<%= Constants.STRING_SEPARATOR %>');
        var reqAppName = tempArray[1];
        var appBindYn = '<%= Constants.USE_YN_N %>';

        if ('<%= Constants.NONE_VALUE %>' != appName.val()) appBindYn = '<%= Constants.USE_YN_Y %>';

        var catalogTypeParam = {appName : reqAppName,
                                servicePlan : servicePlan.val(),
                                appBindYn : appBindYn
        };

        $.extend(param, catalogTypeParam);

        procCallAjax(CATALOG_SERVICE_PACK_CF_RUN_PROC_URL, param, procCallbackCatalogCfRun);

    };

    // CALLBACK :: CATALOG CF RUN
    var procCallbackCatalogCfRun = function(data, reqParam) {
        if (RESULT_STATUS_FAIL == data.RESULT) {
            procCallSpinner(SPINNER_SPIN_STOP);
            return false;
        }

        procCallAjax(CATALOG_HISTORY_SERVICE_PACK_INSERT_PROC_URL, reqParam, procCallbackInsertCatalogHistory);
    };


    // CALLBACK :: INSERT CATALOG HISTORY
    var procCallbackInsertCatalogHistory = function(data) {
        if (RESULT_STATUS_FAIL == data.RESULT) {
            procCallSpinner(SPINNER_SPIN_STOP);
            return false;
        }

        var doc = document;
        var appName = doc.getElementById('appName').value;
        var spaceName = doc.getElementById("spaceName").value;

        if ('<%= Constants.NONE_VALUE %>' == appName) {
            procCallAjax(SPACE_SESSION_SET_PROC_URL, {spaceName : spaceName}, procMovePageSpaceMain);
            return false;
        }

        var tempArray = appName.split('<%= Constants.STRING_SEPARATOR %>');
        var reqAppName = tempArray[0];

        var param = {orgName : currentOrg,
                     spaceName : spaceName,
                     guid : reqAppName
        };

        // RE-STAGE SERVICE
        procCallAjax(CATALOG_STARTER_RE_STAGE_CF_RUN_PROC_URL, param, procCallbackStarterReStage);
    };


    // CALLBACK :: STARTER RE STAGE
    var procCallbackStarterReStage = function() {
        procCallAjax(SPACE_SESSION_SET_PROC_URL, {spaceName : document.getElementById("spaceName").value}, procMovePageSpaceMain);
    };


    // CHECK STRING FORMAT
    var procCheckStringFormat = function(reqStringObject) {
        if (!procCheckValidNull(reqStringObject)) return false;

//        var regExpPattern = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
        var regExpPattern = /[\{\}\[\]\/?,;:|\)*~`!^+<>\#$%&\\\=\(\'\"]/gi;
        var regExpBlankPattern = /[\s]/g;
        var reqString = reqStringObject.val();

        // CHECK VALID
        if (regExpPattern.test(reqString) || regExpBlankPattern.test(reqString)) {
            showAlert('fail', '<spring:message code="common.info.check.req.name" />');
            procSetAvailableSave(false);
            procCallSpinner(SPINNER_SPIN_STOP);
            reqStringObject.focus();

            return false;
        }

        return true;
    };


    // SET INSERT REQUEST PARAM
    var procSetInsertRequestParam = function() {
        var reqOrgName = currentOrg;
        var spaceName = $('#spaceName');
        var serviceInstanceName = $('#serviceInstanceName');
        var catalogNo = $('#catalogNo');

        if (!procCheckValidParam(spaceName) || !procCheckValidParam(serviceInstanceName) || !procCheckValidParam(catalogNo)) return false;

        return {orgName : reqOrgName,
                spaceName : spaceName.val(),
                serviceInstanceName : serviceInstanceName.val(),
                catalogNo : catalogNo.val()
        };
    };


    // CHECK VALID PARAM
    var procCheckValidParam = function(reqObj) {
        if (!procCheckValidNull(reqObj)) return false;

        if (!procCheckValidNull(reqObj.val())) {
            showAlert('fail', '<spring:message code="common.info.empty.req.data" />');
            procCallSpinner(SPINNER_SPIN_STOP);
            reqObj.focus();
            return false;

        } else {
            return true;
        }
    };


    // MOVE PAGE SPACE MAIN
    var procMovePageSpaceMain = function() {
        procCallSpinner(SPINNER_SPIN_STOP);
        procMovePage(SPACE_MAIN_URL);
    };


    // INIT PAGE
    var procInitPage = function() {
        procCallSpinner(SPINNER_SPIN_START);
        getCatalogLeftMenuList();
    };


    // BIND :: BUTTON EVENT
    $("#btnSave").on("click", function() {
        procCatalogCfRun();
    });


    // BIND :: BUTTON EVENT
    $("#btnCancel").on("click", function() {
        procMovePage(CATALOG_HOME_URL);
    });


    // BIND :: BUTTON EVENT
    $(".btnViewDocument").on("click", function() {
        showAlert('success', 'READY FOR DOCUMENTS!');
    });


    // BIND :: INPUT TEXT BOX KEY UP
    $("#serviceInstanceName").on("keyup", function() {
        procSetInputTextObjectName('<%= Constants.NONE_VALUE %>', CATALOG_SERVICE_INSTANCE_NAME);
        procCheckServiceInstanceName();
    });


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


<%@include file="../layout/bottom.jsp" %>
