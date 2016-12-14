<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../layout/topNoGrid.jsp" %>
<%@include file="catalogLeft.jsp" %>
<%@include file="../layout/alert.jsp" %>

<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/bootstrap-toggle.min.css'/>">
<script type="text/javascript" src="<c:url value='/resources/js/bootstrap-toggle.min.js' />"></script>

<div id="catalogFormView" style="display: none;">

    <%--BUILD PACK FORM--%>
    <%--LEFT--%>
    <div class="col-sm-7 pt10">
        <div class="col-sm-12 pt10">
            <h4 id="catalogTitle" class="modify_h4"> 앱 개발환경 이름 </h4>
        </div>
        <div class="panel content-box col-sm-12 col-md-12">
            <div class="modify_custom_cn_box2 fl">
                <div class="modify_custom_image_box2">
                    <img src="<c:url value='/resources/images/noimage.jpg'/>" class="img-thumbnail" id="catalogImage" style="width: 100px; height: 100px;">
                </div>
            </div>
            <div class="custom_list fl">
                <ul class="mt5">
                    <li><span class="tt modify_panel_title">  요약 : </span></li>
                    <li><span id="catalogSummary" class="txt2 modify_panel_title">  summary  </span></li>
                    <li class="mt10"><span class="tt modify_panel_title"> 설명 : </span></li>
                    <li><span id="catalogDescription" class="txt2 modify_panel_title"> description </span></li>
                </ul>
            </div>
        </div>
    </div>

    <input type="hidden" id="catalogBuildPackName" name="catalogBuildPackName" value="" />

    <%--RIGHT--%>
    <div class="col-sm-5 pt10">
        <div class="col-sm-12 pt10">
            <h4 class="modify_h4">앱 생성</h4>
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
                <h4 class="modify_h4"> 앱 이름 </h4>
            </div>
            <div class="form-group has-warning has-feedback" id="div_applicationName">
                <label class="control-label sr-only" for="applicationName"></label>
                <input type="text" class="form-control modify_form_control applicationName" id="applicationName"
                       aria-describedby="inputStatus_applicationName" maxlength="100" placeholder="새 앱 이름 입력">
                <span class="glyphicon glyphicon-warning-sign custom-form-control-feedback" id="spanIcon_applicationName" aria-hidden="true"></span>
                <span id="inputStatus_applicationName" class="sr-only">(success)</span>
            </div>
            <div class="custom_ttgroup mt30">
                <h4 class="modify_h4"> 앱 URL </h4>
            </div>
            <div class="form-group has-warning has-feedback" id="div_hostName">
                <label class="control-label sr-only" for="hostName"></label>
                <input type="text" class="form-control modify_form_control hostName" id="hostName"
                       aria-describedby="inputStatus_hostName" maxlength="200" placeholder="호스트 입력">
                <span class="glyphicon glyphicon-warning-sign custom-form-control-feedback" id="spanIcon_hostName" aria-hidden="true"></span>
                <span id="inputStatus_hostName" class="sr-only">(success)</span>
            </div>
            <div class="custom_ttgroup mt30">
                <h4 class="modify_h4"> 도메인 </h4>
            </div>
            <div id="catalogDomainList" class="modify_panel_title">
            </div>
            <div id="catalogAppSampleStartCheckArea" class="custom_ttgroup mt30" style="display: none;">
                <div class="fl">
                    <h4 class="modify_h4"> 앱 시작여부 </h4>
                </div>
                <div class="fl ml20" style="margin: 6px 0 0 0;">
                    <label class="control-label sr-only" for="checkBoxAppSampleStartYn"></label>
                    <input type="checkbox" id="checkBoxAppSampleStartYn" class="ml20" name="checkBoxAppSampleStartYn" checked data-toggle="toggle" data-size="small" />
                </div>
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
<input type="hidden" id="appSampleStartYn" name="appSampleStartYn" value="<%= Constants.USE_YN_Y %>" />
<input type="hidden" id="appSampleFilePath" name="appSampleFilePath" value="" />


<%--
====================================================================================================
SCRIPT BEGIN
====================================================================================================
--%>


<script type="text/javascript">

    var BUILD_PACK_CATALOG_LIST_PROC_URL = "<c:url value='/catalog/getBuildPackCatalogList' />";
    var CATALOG_SPACE_LIST_PROC_URL = "<c:url value='/catalog/getCatalogSpaceList' />";
    var CATALOG_DOMAIN_LIST_PROC_URL = "<c:url value='/catalog/getCatalogDomainList' />";
    var CHECK_APPLICATION_NAME_PROC_URL = "<c:url value='/catalog/getCheckCatalogApplicationNameExists' />";
    var CHECK_ROUTE_EXISTS_PROC_URL = "<c:url value='/catalog/getCheckCatalogRouteExists' />";
    var CATALOG_BUILD_PACK_CF_RUN_PROC_URL = "<c:url value='/catalog/executeCatalogBuildPack' />";
    var CATALOG_HISTORY_BUILD_PACK_INSERT_PROC_URL = "<c:url value='/catalog/insertCatalogHistoryBuildPack' />";
    var SPACE_SESSION_SET_PROC_URL = "<c:url value='/space/setSpaceSession' />";
    var SPACE_MAIN_URL = "<c:url value='/space/spaceMain' />";

    var CATALOG_APPLICATION_NAME = "applicationName";
    var CATALOG_HOST_NAME = "hostName";
    var CHECK_APPLICATION_NAME = false;
    var CHECK_HOST_NAME = false;


    // GET CATALOG INSERT FORM
    var getCatalogInsertForm = function() {
        var reqCatalogNo = document.getElementById('catalogNo').value;
        if (!procCheckValidNull(reqCatalogNo)) return false;

        procCallAjax(BUILD_PACK_CATALOG_LIST_PROC_URL, {no : reqCatalogNo}, procSetCommonInsertForm);
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

        var appSampleFilePath = catalogList[0].appSampleFilePath;
        var objAppSampleFilePath = $('#appSampleFilePath');

        if (null != appSampleFilePath && '' != appSampleFilePath) {
            objAppSampleFilePath.val(appSampleFilePath);
            $('#catalogAppSampleStartCheckArea').show();
        } else {
            objAppSampleFilePath.val('<%= Constants.USE_YN_N %>');
            $('#appSampleStartYn').val('<%= Constants.USE_YN_N %>');
        }

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

        getDomainList();
    };


    // GET LIST :: DOMAIN
    var getDomainList = function() {
        procCallAjax(CATALOG_DOMAIN_LIST_PROC_URL, {}, procCallbackDomainList);
    };


    // GET LIST CALLBACK :: DOMAIN
    var procCallbackDomainList = function(data) {
        if (RESULT_STATUS_FAIL == data.RESULT) return false;

        var domainList = data.list;
        var listLength = domainList.length;
        var catalogDomainListObject = $('#catalogDomainList');
        var htmlString = [];

        for (var i = 0; i < listLength; i++) {
            htmlString.push('<p class="ml10">' + domainList[i].name + '</p>'
                    + '<input type="hidden" id="catalogDomainName_' + i + '" value="' + domainList[i].name + '">'
                    + '<input type="hidden" id="catalogDomainGuid_' + i + '" value="' + domainList[i].meta.guid + '">');
        }

        catalogDomainListObject.append(htmlString);

        procSetCompleteCatalogView();
    };


    // SET COMPLETE CATALOG VIEW
    var procSetCompleteCatalogView = function() {
        $('#catalogFormView').show();
        procCallSpinner(SPINNER_SPIN_STOP);

        $('#applicationName').focus();
        window.scrollTo(0, 0);
    };


    // CHECK APPLICATION NAME
    var procCheckApplicationName = function() {
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
    var procCallbackCheckApplicationName = function(data) {
        var resultStatus = data.RESULT;

        if (RESULT_STATUS_FAIL == resultStatus) showAlert('fail', data.RESULT_MESSAGE);
        if (RESULT_STATUS_SUCCESS == resultStatus) showAlert('success', '');

        procSetInputTextObjectName(CATALOG_APPLICATION_NAME, resultStatus);
        procSetInputTextObjectName(CATALOG_HOST_NAME, resultStatus);
        procCopyApplicationNameToHostName(true);
    };


    // COPY APPLICATION NAME TO HOST NAME
    var procCopyApplicationNameToHostName = function(reqBooleanCheck) {
        var doc = document;
        var applicationName = doc.getElementById('applicationName').value;
        var hostNameObject = $('#hostName');
        var tempValue = '';

        if ('' != applicationName) tempValue = applicationName + "." + doc.getElementById('catalogDomainName_0').value;

        hostNameObject.val(tempValue);

        if (reqBooleanCheck) procCheckHostName();
    };


    // CHECK HOST NAME
    var procCheckHostName = function() {
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
    var procCallbackCheckHostName = function(data) {
        var resultStatus = data.RESULT;

        if (RESULT_STATUS_FAIL == resultStatus) showAlert('fail', data.RESULT_MESSAGE);
        if (RESULT_STATUS_SUCCESS == resultStatus) showAlert('success', '');

        procSetInputTextObjectName(CATALOG_HOST_NAME, data.RESULT);
    };


    // SET INPUT TEXT SERVICE INSTANCE NAME
    var procSetInputTextObjectName = function(reqObjectName, resultStatus) {
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
    var procSetAvailableSave = function(reqObjectName, reqStatus) {
        if (!procCheckValidNull(reqObjectName)) return false;
        if (!procCheckValidNull(reqStatus)) return false;

        if (CATALOG_APPLICATION_NAME == reqObjectName) CHECK_APPLICATION_NAME = reqStatus;
        if (CATALOG_HOST_NAME == reqObjectName) CHECK_HOST_NAME = reqStatus;
    };


    // CATALOG CF RUN
    var procCatalogCfRun= function() {
        var applicationName = $('#applicationName');
        var hostName = $('#hostName');

        if (!CHECK_APPLICATION_NAME) {
            showAlert('fail', '<spring:message code="common.info.check.req.name" />');
            applicationName.focus();

            return false;
        }

        if (!CHECK_HOST_NAME) {
            showAlert('fail', '<spring:message code="common.info.check.req.name" />');
            hostName.focus();

            return false;
        }

        procCallSpinner(SPINNER_SPIN_START);

        var param = procSetInsertRequestParam();
        if (!param) return false;

        if (!procCheckValidParam(hostName)) return false;
        if (!procCheckStringFormat(CATALOG_APPLICATION_NAME, applicationName)) return false;
        if (!procCheckStringFormat(CATALOG_HOST_NAME, hostName)) return false;

        var catalogTypeParam = {hostName : hostName.val(),
                                buildPackName : document.getElementById('catalogBuildPackName').value,
                                appSampleStartYn : $('#appSampleStartYn').val(),
                                appSampleFilePath : $('#appSampleFilePath').val()
        };

        $.extend(param, catalogTypeParam);

        procCallAjax(CATALOG_BUILD_PACK_CF_RUN_PROC_URL, param, procCallbackCatalogCfRun);
    };


    // CALLBACK :: CATALOG CF RUN
    var procCallbackCatalogCfRun = function(data, reqParam) {
        if (RESULT_STATUS_FAIL == data.RESULT) {
            procCallSpinner(SPINNER_SPIN_STOP);
            return false;
        }

        procCallAjax(CATALOG_HISTORY_BUILD_PACK_INSERT_PROC_URL, reqParam, procCallbackInsertCatalogHistory);
    };


    // CALLBACK :: INSERT CATALOG HISTORY
    var procCallbackInsertCatalogHistory = function() {
        procCallAjax(SPACE_SESSION_SET_PROC_URL, {spaceName : document.getElementById("spaceName").value}, procMovePageSpaceMain);
    };


    // SET INSERT REQUEST PARAM
    var procSetInsertRequestParam = function() {
        var reqOrgName = currentOrg;
        var spaceName = $('#spaceName');
        var applicationName = $('#applicationName');
        var catalogNo = $('#catalogNo');

        if (!procCheckValidParam(spaceName) || !procCheckValidParam(applicationName) || !procCheckValidParam(catalogNo)) return false;

        return {orgName : reqOrgName,
                 spaceName : spaceName.val(),
                 name : applicationName.val(),
                 catalogNo : catalogNo.val()
        };
    };


    // CHECK VALID PARAM
    var procCheckValidParam = function(reqObj) {
        if (!procCheckValidNull(reqObj)) return false;

        if (!procCheckValidNull(reqObj.val())) {
            showAlert('fail', '<spring:message code="common.info.empty.req.data" />');
            reqObj.focus();
            procCallSpinner(SPINNER_SPIN_STOP);
            return false;

        } else {
            return true;
        }
    };


    // CHECK STRING FORMAT
    var procCheckStringFormat = function(reqObjectName, reqStringObject) {
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
    $("#applicationName").on("keyup", function() {
        procCheckApplicationName();
    });


    // BIND :: INPUT TEXT BOX KEY UP
    $("#hostName").on("keyup", function() {
        procCheckHostName();
    });


    // BIND :: TOGGLE CHANGE
    $("#checkBoxAppSampleStartYn").on("change", function() {
        var appSampleStartYn = $("#appSampleStartYn");

        if ($(this).prop('checked')) {
            appSampleStartYn.val('<%= Constants.USE_YN_Y %>');
        } else {
            appSampleStartYn.val('<%= Constants.USE_YN_N %>');
        }
    }).bootstrapToggle({
        on: '실행',
        off: '정지',
        width: 60
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
