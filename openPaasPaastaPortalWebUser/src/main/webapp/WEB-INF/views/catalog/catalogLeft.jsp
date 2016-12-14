<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container-fluid" id="main">
    <div class="row">

        <%--LEFT MENU--%>
        <div class="col-sm-3 col-md-2 sidebar">
            <%--USER INFO--%>
            <%@include file="../layout/leftUserInfo.jsp" %>

                <div id="catalogLeftMenuArea">
                    <%--CATALOG MENU--%>
                    <div class="group_btn">
                        <span><a href="javascript:void(0);" onclick="procMoveCatalogPage('<%= Constants.CATALOG_TYPE_ALL %>')" class="">전체보기</a></span>
                    </div>
                    <div class="group_btn">
                        <span><a href="javascript:void(0);" onclick="procMoveCatalogPage('<%= Constants.CATALOG_TYPE_STARTER %>')" class="">앱 템플릿</a></span>
                    </div>
                    <ul id="catalogStarterMenuList" class="smenu">
                    </ul>
                    <div class="group_btn">
                        <span><a href="javascript:void(0);" onclick="procMoveCatalogPage('<%= Constants.CATALOG_TYPE_BUILD_PACK %>')" class="">앱 개발환경</a></span>
                    </div>
                    <ul id="catalogBuildPackMenuList" class="smenu">
                    </ul>
                    <div class="group_btn">
                        <span><a href="javascript:void(0);" onclick="procMoveCatalogPage('<%= Constants.CATALOG_TYPE_SERVICE_PACK %>')" class="">서비스</a></span>
                    </div>
                    <ul id="catalogServicePackMenuList" class="smenu">
                    </ul>
                </div>
        </div>

<script type="text/javascript">

    var CATALOG_HOME_URL = "<c:url value='/catalog/catalogMain' />";
    var CATALOG_LEFT_MENU_LIST_PROC_URL = "<c:url value='/catalog/getCatalogLeftMenuList' />";
    var CATALOG_TYPE_ALL = '<%= Constants.CATALOG_TYPE_ALL %>';
    var CATALOG_TYPE_HISTORY = '<%= Constants.CATALOG_TYPE_HISTORY %>';
    var CATALOG_TYPE_STARTER = '<%= Constants.CATALOG_TYPE_STARTER %>';
    var CATALOG_TYPE_BUILD_PACK = '<%= Constants.CATALOG_TYPE_BUILD_PACK %>';
    var CATALOG_TYPE_SERVICE_PACK = '<%= Constants.CATALOG_TYPE_SERVICE_PACK %>';

    var <%= Constants.CATALOG_TYPE_STARTER %>_MenuList = null;
    var <%= Constants.CATALOG_TYPE_BUILD_PACK %>_MenuList = null;
    var <%= Constants.CATALOG_TYPE_SERVICE_PACK %>_MenuList = null;
    var <%= Constants.CATALOG_TYPE_HISTORY %>_List = null;
    var <%= Constants.CATALOG_TYPE_STARTER %>_List = null;
    var <%= Constants.CATALOG_TYPE_BUILD_PACK %>_List = null;
    var <%= Constants.CATALOG_TYPE_SERVICE_PACK %>_List = null;


    // MOVE CATALOG PAGE
    var procMoveCatalogPage = function (reqCatalogType, reqCatalogSubType) {
        var reqUrl = CATALOG_HOME_URL;

        if (CATALOG_TYPE_ALL != reqCatalogType) {
            reqUrl += "/" + reqCatalogType;

            if (null != reqCatalogSubType && '' != reqCatalogSubType) {
                reqUrl += "/" + reqCatalogSubType;
            }
        }

        procMovePage(reqUrl);
    };


    // CHECK IMAGE
    var procCheckImage = function (reqImagePath) {
        return null == reqImagePath || '' == reqImagePath ? "<c:url value='/resources/images/noimage.jpg'/>" : reqImagePath;
    };


    // GET LIST :: CATALOG LEFT MENU
    var getCatalogLeftMenuList = function () {
        procCallAjax(CATALOG_LEFT_MENU_LIST_PROC_URL, {}, procCallbackGetCatalogLeftMenuList);
    };


    // GET LIST CALLBACK :: CATALOG LEFT MENU
    var procCallbackGetCatalogLeftMenuList = function (data) {
        var objCatalogStarterMenu = $('#catalogStarterMenuList');
        var objCatalogBuildPackMenu = $('#catalogBuildPackMenuList');
        var objCatalogServicePackMenu = $('#catalogServicePackMenuList');

        <%= Constants.CATALOG_TYPE_STARTER %>_MenuList = data.starterList;
        <%= Constants.CATALOG_TYPE_BUILD_PACK %>_MenuList = data.buildPackList;
        <%= Constants.CATALOG_TYPE_SERVICE_PACK %>_MenuList = data.servicePackList;

        var starterMenuList = data.starterList;
        var buildPackMenuList = data.buildPackList;
        var servicePackMenuList = data.servicePackList;

        var starterMenuListLength = starterMenuList.length;
        var buildPackMenuListLength = buildPackMenuList.length;
        var servicePackMenuListLength = servicePackMenuList.length;


        var currentPage = document.location.href;
        var tempCount = 0;

        if (currentPage.search("http://") > -1) {
            currentPage = currentPage.substr(7);
            var tempArr = currentPage.split('/');

            if ('catalog' != tempArr[1]) tempCount++;
        }


        // MENU :: STARTER
        var htmlString = [];
        var cssString = '';
        objCatalogStarterMenu.html('');

        for (var i = 0; i < starterMenuListLength; i++) {
            if ('starter' == tempArr[3] && starterMenuList[i].key == tempArr[4]) {
                cssString = ' style=\"line-height: 22px; color: #faa51b; background: #fff url(/resources/images/groupsmenu02.png) 0 0 no-repeat; font-weight: bold;\" ';
            } else {
                cssString = '';
            }

            htmlString.push('<li><span><a href="javascript:void(0);" '
                    + 'onclick="procMoveCatalogPage(CATALOG_TYPE_STARTER, \''
                    + starterMenuList[i].key + '\')"' + cssString + '> ' + starterMenuList[i].value
                    + ' </a></span></li>');
        }

        objCatalogStarterMenu.append(htmlString);


        // MENU :: BUILD PACK
        htmlString = [];
        objCatalogBuildPackMenu.html('');
        for (var j = 0; j < buildPackMenuListLength; j++) {
            if ('buildPack' == tempArr[3] && buildPackMenuList[j].key == tempArr[4]) {
                cssString = ' style=\"line-height: 22px; color: #faa51b; background: #fff url(/resources/images/groupsmenu02.png) 0 0 no-repeat; font-weight: bold;\" ';
            } else {
                cssString = '';
            }

            htmlString.push('<li><span><a href="javascript:void(0);" '
                    + 'onclick="procMoveCatalogPage(CATALOG_TYPE_BUILD_PACK, \''
                    + buildPackMenuList[j].key + '\')"' + cssString + '> ' + buildPackMenuList[j].value
                    + ' </a></span></li>');
        }

        objCatalogBuildPackMenu.append(htmlString);


        // MENU :: SERVICE PACK
        htmlString = [];
        objCatalogServicePackMenu.html('');
        for (var k = 0; k < servicePackMenuListLength; k++) {
            if ('servicePack' == tempArr[3] && servicePackMenuList[k].key == tempArr[4]) {
                cssString = ' style=\"line-height: 22px; color: #faa51b; background: #fff url(/resources/images/groupsmenu02.png) 0 0 no-repeat; font-weight: bold;\" ';
            } else {
                cssString = '';
            }

            htmlString.push('<li><span><a href="javascript:void(0);" '
                    + 'onclick="procMoveCatalogPage(CATALOG_TYPE_SERVICE_PACK, \''
                    + servicePackMenuList[k].key + '\')"' + cssString + '> ' + servicePackMenuList[k].value
                    + ' </a></span></li>');
        }

        objCatalogServicePackMenu.append(htmlString);
        $('#catalogLeftMenuArea').show();

        var doc = document;
        var catalogNo = doc.getElementById('catalogNo').value;

        if (null == catalogNo || '' == catalogNo) {
            // LIST
            getCatalogList(doc.getElementById('catalogType').value);

        } else {
            // INSERT FORM
            getCatalogInsertForm();
        }
    };

</script>
