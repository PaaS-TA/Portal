<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container-fluid" id="main">
    <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
            <div class="userinfo">
                <sec:authentication property="principal.imgPath" var="imgPath"/>
                <c:choose>
                    <c:when test="${not empty imgPath}"><img src="<c:url value='${imgPath}'/>" alt="사용자"/></c:when>
                    <c:otherwise><img src="<c:url value='/resources/images/userpic.png'/>" alt="사용자"/></c:otherwise>
                </c:choose>
                <div class="name"><sec:authentication property="principal.name" /></div>
                <div class="dropdown">
                    <a class="mail dropdown-toggle" data-toggle="dropdown" id="dropdownTopMenu" href="javascript:void(0);">
                        <sec:authentication property="principal.username" /><span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownTopMenu" style="width: 100%;">
                        <li role="presentation"><a role="menuitem" href="#" onClick="alertList()">알림</a></li>
                        <li role="presentation"><a role="menuitem" href="<c:url value='/user/myPage' />">내 계정</a></li>
                        <li role="presentation"><a role="menuitem" href="<c:url value='/myQuestion/myQuestionMain' />">내 문의</a></li>
                        <li role="presentation"><a href="javascript:document.getElementById('logout').submit()">로그아웃</a></li>
                    </ul>
                    <c:url value="/logout" var="logoutUrl"/>
                    <form id="logout" action="${logoutUrl}" method="post">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    </form>
                </div>
            </div>

            <%--CATALOG MENU--%>
            <div class="custom_catalog_btn">
                <span><a href="javascript:void(0);" onclick="procMoveCatalogPage('<%= Constants.CATALOG_TYPE_ALL %>')" class="">전체보기</a></span>
            </div>
            <div class="custom_catalog_btn">
                <span><a href="javascript:void(0);" onclick="procMoveCatalogPage('<%= Constants.CATALOG_TYPE_STARTER %>')" class="">앱 템플릿</a></span>
            </div>
            <ul id="catalogStarterMenuList" class="custom_left_catalog_list">
            </ul>
            <div class="custom_catalog_btn">
                <span><a href="javascript:void(0);" onclick="procMoveCatalogPage('<%= Constants.CATALOG_TYPE_BUILD_PACK %>')" class="">앱 개발환경</a></span>
            </div>
            <ul id="catalogBuildPackMenuList" class="custom_left_catalog_list">
            </ul>
            <div class="custom_catalog_btn">
                <span><a href="javascript:void(0);" onclick="procMoveCatalogPage('<%= Constants.CATALOG_TYPE_SERVICE_PACK %>')" class="">서비스</a></span>
            </div>
            <ul id="catalogServicePackMenuList" class="custom_left_catalog_list">
            </ul>
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
            var procMoveCatalogPage = function(reqCatalogType, reqCatalogSubType) {
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
            var procCheckImage = function(reqImagePath) {
                return null == reqImagePath || '' == reqImagePath ? "<c:url value='/resources/images/noimage.jpg'/>" : reqImagePath;
            };


            // GET LIST :: CATALOG LEFT MENU
            var getCatalogLeftMenuList = function() {
                procCallAjax(CATALOG_LEFT_MENU_LIST_PROC_URL, {}, procCallbackGetCatalogLeftMenuList);
            };


            // GET LIST CALLBACK :: CATALOG LEFT MENU
            var procCallbackGetCatalogLeftMenuList = function(data) {
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

                // MENU :: STARTER
                var htmlString = [];
                for (var i = 0; i < starterMenuListLength; i++) {
                    htmlString.push('<li><span><a href="javascript:void(0);" '
                            + 'onclick="procMoveCatalogPage(CATALOG_TYPE_STARTER, \''
                            + starterMenuList[i].key + '\')"> ' + starterMenuList[i].value
                            + ' </a></span></li>');
                }

                objCatalogStarterMenu.append(htmlString);

                // MENU :: BUILD PACK
                htmlString = [];
                for (var j = 0; j < buildPackMenuListLength; j++) {
                    htmlString.push('<li><span><a href="javascript:void(0);" '
                            + 'onclick="procMoveCatalogPage(CATALOG_TYPE_BUILD_PACK, \''
                            + buildPackMenuList[j].key + '\')"> ' + buildPackMenuList[j].value
                            + ' </a></span></li>');
                }

                objCatalogBuildPackMenu.append(htmlString);

                // MENU :: SERVICE PACK
                htmlString = [];
                for (var k = 0; k < servicePackMenuListLength; k++) {
                    htmlString.push('<li><span><a href="javascript:void(0);" '
                            + 'onclick="procMoveCatalogPage(CATALOG_TYPE_SERVICE_PACK, \''
                            + servicePackMenuList[k].key + '\')"> ' + servicePackMenuList[k].value
                            + ' </a></span></li>');
                }

                objCatalogServicePackMenu.append(htmlString);

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

        <div class="col-sm-9 col-sm-offset-4 col-md-10 col-md-offset-2 main">
