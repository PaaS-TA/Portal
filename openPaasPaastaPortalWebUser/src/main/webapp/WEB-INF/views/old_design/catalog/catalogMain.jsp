<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../layout/topNoGrid.jsp" %>
<%@include file="catalogLeft.jsp" %>
<%@include file="../layout/alert.jsp" %>

<div id="catalogViewListArea">

    <%--SEARCH FORM--%>
    <div class="form-group custom-search-form">
        <label class="control-label sr-only" for="searchKeyword"></label>
        <div class="input-group">
            <span class="input-group-addon">
                <span class="glyphicon glyphicon-search" aria-hidden="true"></span>
            </span>
            <input type="text" class="form-control custom-input-text" id="searchKeyword" maxlength="100" placeholder="검색어를 입력하세요.">
        </div>
    </div>

    <%--RECENTLY TASK--%>
    <div id="catalogView_<%= Constants.CATALOG_TYPE_HISTORY %>" class="catalogViewArea">
        <div class="col-sm-12 pt20">
            <h4 class="modify_h4 fwb"> 최근 작업 </h4>
        </div>
        <div id="catalogType_<%= Constants.CATALOG_TYPE_HISTORY %>" class="panel content-box col-sm-12 col-md-12">
        </div>
    </div>

    <%--STARTER--%>
    <div id="catalogView_<%= Constants.CATALOG_TYPE_STARTER %>" class="catalogViewArea">
        <div class="col-sm-12 pt10">
            <div class="fl">
                <h4 class="modify_h4 fwb"> 앱 템플릿 </h4>
            </div>
            <div class="fl ml50">
                <h4 class="modify_h4"> 자주 사용되는 앱의 개발환경과 서비스를 함께 제공합니다. </h4>
            </div>
        </div>
        <div id="catalogType_<%= Constants.CATALOG_TYPE_STARTER %>" class="panel content-box col-sm-12 col-md-12">
        </div>
    </div>

    <%--BUILD PACK--%>
    <div id="catalogView_<%= Constants.CATALOG_TYPE_BUILD_PACK %>" class="catalogViewArea">
        <div class="col-sm-12 pt10">
            <div class="fl">
                <h4 class="modify_h4 fwb"> 앱 개발환경 </h4>
            </div>
            <div class="fl ml50">
                <h4 class="modify_h4"> 앱의 프레임워크 및 개발환경을 제공합니다. </h4>
            </div>
        </div>
        <div id="catalogType_<%= Constants.CATALOG_TYPE_BUILD_PACK %>" class="panel content-box col-sm-12 col-md-12">
        </div>
    </div>

    <%--SERVICE PACK--%>
    <div id="catalogView_<%= Constants.CATALOG_TYPE_SERVICE_PACK %>" class="catalogViewArea">
        <div class="col-sm-12 pt10">
            <div class="fl">
                <h4 class="modify_h4 fwb"> 서비스 </h4>
            </div>
            <div class="fl ml50">
                <h4 class="modify_h4"> 외부에서 제공되는 다양한 서비스들을 제공합니다. </h4>
            </div>
        </div>
        <div id="catalogType_<%= Constants.CATALOG_TYPE_SERVICE_PACK %>" class="panel content-box col-sm-12 col-md-12">
        </div>
    </div>
</div>

<%--HIDDEN VALUE--%>
<input type="hidden" id="catalogType" name="catalogType" value="<c:out value='${CATALOG_TYPE}' default='<%= Constants.CATALOG_TYPE_ALL %>' />" />
<input type="hidden" id="catalogSubType" name="catalogSubType" value="<c:out value='${CATALOG_SUB_TYPE}' default='' />" />
<input type="hidden" id="catalogNo" name="catalogNo" value="" />


<%--
====================================================================================================
SCRIPT BEGIN
====================================================================================================
--%>


<script type="text/javascript">

    var CATALOG_HISTORY_LIST_PROC_URL = "<c:url value='/catalog/getCatalogHistoryList' />";
    var STARTER_CATALOG_LIST_PROC_URL = "<c:url value='/catalog/getStarterNamesList' />";
    var BUILD_PACK_CATALOG_LIST_PROC_URL = "<c:url value='/catalog/getBuildPackCatalogList' />";
    var SERVICE_PACK_CATALOG_LIST_PROC_URL = "<c:url value='/catalog/getServicePackCatalogList' />";
    var CATALOG_INSERT_FORM_URL = "<c:url value='/catalog/catalogMain/create' />";


    // GET LIST
    var getCatalogList = function(reqCatalogType) {
        procCallSpinner(SPINNER_SPIN_START);

        if (!procCheckValidNull(reqCatalogType)) return false;

        var param = {reqCatalogType : CATALOG_TYPE_HISTORY};
        procCallAjax(CATALOG_HISTORY_LIST_PROC_URL, param, procCallbackGetCatalogList);

        // GET LIST :: ALL
        if (CATALOG_TYPE_ALL == reqCatalogType) {
            param = {reqCatalogType : CATALOG_TYPE_STARTER, searchTypeUseYn : 'Y'};
            procCallAjax(STARTER_CATALOG_LIST_PROC_URL, param, procCallbackGetCatalogList);

            param = {reqCatalogType : CATALOG_TYPE_BUILD_PACK, searchTypeUseYn : 'Y'};
            procCallAjax(BUILD_PACK_CATALOG_LIST_PROC_URL, param, procCallbackGetCatalogList);

            param = {reqCatalogType : CATALOG_TYPE_SERVICE_PACK, searchTypeUseYn : 'Y'};
            procCallAjax(SERVICE_PACK_CATALOG_LIST_PROC_URL, param, procCallbackGetCatalogList);

        } else {
            param = {reqCatalogType : reqCatalogType, searchTypeUseYn : 'Y'};

            // GET LIST :: STARTER
            if (CATALOG_TYPE_STARTER == reqCatalogType) procCallAjax(STARTER_CATALOG_LIST_PROC_URL, param, procCallbackGetCatalogList);

            // GET LIST :: BUILD PACK
            if (CATALOG_TYPE_BUILD_PACK == reqCatalogType) procCallAjax(BUILD_PACK_CATALOG_LIST_PROC_URL, param, procCallbackGetCatalogList);

            // GET LIST :: SERVICE PACK
            if (CATALOG_TYPE_SERVICE_PACK == reqCatalogType) procCallAjax(SERVICE_PACK_CATALOG_LIST_PROC_URL, param, procCallbackGetCatalogList);
        }
    };


    // GET LIST CALLBACK
    var procCallbackGetCatalogList = function(data, reqParam) {
        var reqCatalogType = reqParam.reqCatalogType;
        var catalogTypeList = data.list;

        // CATALOG HISTORY
        if (CATALOG_TYPE_HISTORY == reqCatalogType) <%= Constants.CATALOG_TYPE_HISTORY %>_List = catalogTypeList;

        // STARTER CATALOG
        if (CATALOG_TYPE_STARTER == reqCatalogType) <%= Constants.CATALOG_TYPE_STARTER %>_List = catalogTypeList;

        // BUILD PACK CATALOG
        if (CATALOG_TYPE_BUILD_PACK == reqCatalogType) <%= Constants.CATALOG_TYPE_BUILD_PACK %>_List = catalogTypeList;

        // SERVICE PACK CATALOG
        if (CATALOG_TYPE_SERVICE_PACK == reqCatalogType) <%= Constants.CATALOG_TYPE_SERVICE_PACK %>_List = catalogTypeList;

        procSetViewCatalogList(catalogTypeList, reqCatalogType, '');

    };


    // SET VIEW LIST
    var procSetViewCatalogList = function(reqList, reqCatalogType, reqSearchKeyword) {
        if (null == reqSearchKeyword) reqSearchKeyword = '';

        reqSearchKeyword = reqSearchKeyword.toLowerCase();
        reqSearchKeyword = reqSearchKeyword.replace(/\s/gi, '');

        var reqListLength = reqList.length;
        var objCatalogView = $('#catalogView_' + reqCatalogType);
        var objCatalogTypeView = $('#catalogType_' + reqCatalogType);
        var stringName = "";
        var stringSummary = "";
        var checkEmptyViewCount = 0;
        var checkEmptyTypeCount = 0;
        var reqCatalogNo = "";

        objCatalogView.hide();
        objCatalogTypeView.html('');

        // CATALOG HISTORY
        var htmlString = [];
        if (CATALOG_TYPE_HISTORY == reqCatalogType) {
            if (reqListLength == 0) {
                htmlString.push('<spring:message code="common.info.empty.data" />');
                objCatalogTypeView.append(htmlString);
                objCatalogView.show();
            }

            if (reqListLength > 0) {
                for (var i = 0; i < reqListLength; i++) {
                    stringName = reqList[i].name.toLowerCase();
                    stringSummary = reqList[i].summary.toLowerCase();
                    reqCatalogNo = "" == stringName ? '\'<%= Constants.NONE_VALUE %>\'' : reqList[i].catalogNo;

                    if (stringName.indexOf(reqSearchKeyword) > -1 || stringSummary.indexOf(reqSearchKeyword) > -1) {
                        htmlString.push('<div class="modify_custom_cn_box" '
                                + 'onclick="procMoveCatalogInsertFormPage(\'' + reqList[i].catalogType + '\', ' + reqCatalogNo + ');" data-toggle="tooltip" data-placement="bottom" '
                                + 'title="' + reqList[i].description + '"><div class="modify_custom_image_box">'
                                + '<img src=' + procCheckImage(reqList[i].thumbImgPath) + ' class="img-thumbnail" style="width: 100px; height: 100px;">'
                                + '</div><div class="mt15 ml5 mr5 tac" style="word-break: keep-all;"><span class="modify_span_size">' +  reqList[i].name + '</span></div></div>');

                        checkEmptyViewCount++;
                    }
                }

                if (checkEmptyViewCount > 0) {
                    objCatalogTypeView.append(htmlString);
                    objCatalogView.show();
                }
            }
        }

        // CATALOG TYPE
        if (CATALOG_TYPE_HISTORY != reqCatalogType) {
            var catalogMenuList = null;
            var catalogMenuListLength = 0;
            var objCatalogTypeTitleView = $('#catalogTypeTitle_' + reqCatalogType);
            objCatalogTypeTitleView.hide();

            // STARTER CATALOG
            if (CATALOG_TYPE_STARTER == reqCatalogType) {
                catalogMenuList = <%= Constants.CATALOG_TYPE_STARTER %>_MenuList;
                catalogMenuListLength = catalogMenuList.length;
            }

            // BUILD PACK CATALOG
            if (CATALOG_TYPE_BUILD_PACK == reqCatalogType) {
                catalogMenuList = <%= Constants.CATALOG_TYPE_BUILD_PACK %>_MenuList;
                catalogMenuListLength = catalogMenuList.length;
            }

            // SERVICE PACK CATALOG
            if (CATALOG_TYPE_SERVICE_PACK == reqCatalogType) {
                catalogMenuList = <%= Constants.CATALOG_TYPE_SERVICE_PACK %>_MenuList;
                catalogMenuListLength = catalogMenuList.length;
            }

            if (reqListLength == 0) {
                htmlString.push('<spring:message code="common.info.empty.data" />');
                objCatalogTypeView.append(htmlString);
                objCatalogView.show();
            }

            if (reqListLength > 0) {
                htmlString = [];
                for (var j = 0; j < catalogMenuListLength; j++) {

                    for (var k = 0; k < reqListLength; k++) {
                        if (catalogMenuList[j].key == reqList[k].classification) {
                            stringName = reqList[k].name.toLowerCase();
                            stringSummary = reqList[k].summary.toLowerCase();

                            if (stringName.indexOf(reqSearchKeyword) > -1 || stringSummary.indexOf(reqSearchKeyword) > -1) {
                                checkEmptyTypeCount++;
                            }
                        }
                    }

                    var reqCatalogSubType = document.getElementById('catalogSubType').value;

                    if (CATALOG_TYPE_ALL == reqCatalogType || catalogMenuList[j].key == reqCatalogSubType || '' == reqCatalogSubType) {
                        if (checkEmptyTypeCount > 0) {
                            htmlString.push('<div class="modify_custom_ttgroup mb10"><div class="fl"><h4 class="modify_h4 fwb">' + catalogMenuList[j].value
                                    + '</h4></div><div class="fl ml50"><h4 class="modify_h4">' + catalogMenuList[j].summary + '</h4></div></div>');
                        }
                    }

                    checkEmptyTypeCount = 0;

                    for (var m = 0; m < reqListLength; m++) {
                        if (catalogMenuList[j].key == reqList[m].classification) {
                            stringName = reqList[m].name.toLowerCase();
                            stringSummary = reqList[m].summary.toLowerCase();

                            if (CATALOG_TYPE_ALL == reqCatalogType || catalogMenuList[j].key == reqCatalogSubType || '' == reqCatalogSubType) {
                                if (stringName.indexOf(reqSearchKeyword) > -1 || stringSummary.indexOf(reqSearchKeyword) > -1) {
                                    htmlString.push('<div class="modify_custom_cn_box" '
                                            + 'onclick="procMoveCatalogInsertFormPage(\'' + reqCatalogType + '\', ' + reqList[m].no + ');" data-toggle="tooltip" data-placement="bottom" '
                                            + 'title="' + reqList[m].description + '"><div class="modify_custom_image_box">'
                                            + '<img src=' + procCheckImage(reqList[m].thumbImgPath) + ' class="img-thumbnail" style="width: 100px; height: 100px;">'
                                            + '</div><div class="mt15 ml5 mr5 tac" style="word-break: keep-all;"><span class="modify_span_size">' +  reqList[m].name + '</span></div></div>');

                                    checkEmptyViewCount++;
                                }
                            }
                        }
                    }
                }

                if (checkEmptyViewCount > 0) {
                    objCatalogTypeView.append(htmlString);
                    objCatalogView.show();
                }
            }
        }

        $('[data-toggle="tooltip"]').tooltip();
        procCallSpinner(SPINNER_SPIN_STOP);
    };


    // SEARCH KEYWORD
    var procSearchKeyword = function(reqCatalogType, reqSearchKeyword) {
        // GET LIST :: ALL
        if (CATALOG_TYPE_ALL == reqCatalogType) {
            procSetViewCatalogList(<%= Constants.CATALOG_TYPE_HISTORY %>_List, CATALOG_TYPE_HISTORY, reqSearchKeyword);
            procSetViewCatalogList(<%= Constants.CATALOG_TYPE_STARTER %>_List, CATALOG_TYPE_STARTER, reqSearchKeyword);
            procSetViewCatalogList(<%= Constants.CATALOG_TYPE_BUILD_PACK %>_List, CATALOG_TYPE_BUILD_PACK, reqSearchKeyword);
            procSetViewCatalogList(<%= Constants.CATALOG_TYPE_SERVICE_PACK %>_List, CATALOG_TYPE_SERVICE_PACK, reqSearchKeyword);

        } else {
            procSetViewCatalogList(<%= Constants.CATALOG_TYPE_HISTORY %>_List, CATALOG_TYPE_HISTORY, reqSearchKeyword);

            // GET LIST :: STARTER
            if (CATALOG_TYPE_STARTER == reqCatalogType) {
                procSetViewCatalogList(<%= Constants.CATALOG_TYPE_STARTER %>_List, CATALOG_TYPE_STARTER, reqSearchKeyword);
            }

            // GET LIST :: BUILD PACK
            if (CATALOG_TYPE_BUILD_PACK == reqCatalogType) {
                procSetViewCatalogList(<%= Constants.CATALOG_TYPE_BUILD_PACK %>_List, CATALOG_TYPE_BUILD_PACK, reqSearchKeyword);
            }

            // GET LIST :: SERVICE PACK
            if (CATALOG_TYPE_SERVICE_PACK == reqCatalogType) {
                procSetViewCatalogList(<%= Constants.CATALOG_TYPE_SERVICE_PACK %>_List, CATALOG_TYPE_SERVICE_PACK, reqSearchKeyword);
            }
        }
    };


    // MOVE CATALOG INSERT FORM PAGE
    var procMoveCatalogInsertFormPage = function(reqCatalogType, reqCatalogNo) {
        if (!procCheckValidNull(reqCatalogType)) return false;
        if (!procCheckValidNull(reqCatalogNo)) return false;

        if ('<%= Constants.NONE_VALUE %>' == reqCatalogNo) {
            showAlert('fail', '<spring:message code="common.info.empty.data" />');
            return false;
        }

        procMovePage(CATALOG_INSERT_FORM_URL + "/" + reqCatalogType + "/" + reqCatalogNo);
    };


    // INIT PAGE
    var procInitPage = function() {
        getCatalogLeftMenuList();

        $('.catalogViewArea').hide();
    };


    // BIND :: KEY UP EVENT
    $("#searchKeyword").on("keyup", function() {
        var doc = document;
        procSearchKeyword(doc.getElementById('catalogType').value, doc.getElementById('searchKeyword').value);
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
