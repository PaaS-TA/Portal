<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ include file="../common/common.jsp"%>

<%--SEARCH FORM--%>
<form id="searchForm" class="form-inline clearfix" onsubmit="return false;">
    <div class="search_box">
        <h2> 카탈로그 관리 </h2>
        <div class="box">
            <div class="form-group ">
                <label for="searchType" class="control-label"> 검색 유형 </label>
                <select id="searchType" name="searchType" class="form-control">
                    <option value="<%= Constants.SEARCH_TYPE_ALL %>"> 전체 </option>
                    <option value="<%= Constants.TAB_NAME_STARTER %>"> 앱 템플릿 </option>
                    <option value="<%= Constants.TAB_NAME_BUILD_PACK %>"> 앱 개발환경 </option>
                    <option value="<%= Constants.TAB_NAME_SERVICE_PACK %>"> 서비스 </option>
                </select>
            </div>
            <div class="form-group ">
                <label for="searchTypeColumn" class="control-label"> 검색 항목 </label>
                <select id="searchTypeColumn" name="searchTypeColumn" class="form-control">
                    <option value="<%= Constants.SEARCH_TYPE_ALL %>"> 전체 </option>
                    <option value="<%= Constants.SEARCH_TYPE_NAME %>"> 이름 </option>
                    <option value="<%= Constants.SEARCH_TYPE_SUMMARY %>"> 요약 </option>
                </select>
            </div>
            <div class="form-group ">
                <label for="searchTypeUseYn" class="control-label"> 공개 여부 </label>
                <select id="searchTypeUseYn" name="searchTypeUseYn" class="form-control">
                    <option value="<%= Constants.SEARCH_TYPE_ALL %>"> 전체 </option>
                    <option value="<%= Constants.USE_YN_Y %>"> 공개 </option>
                    <option value="<%= Constants.USE_YN_N %>"> 비공개 </option>
                </select>
            </div>
            <div class="form-group ">
                <label for="searchKeyword" class="control-label"> 검색어 </label>
                <div class="input-group">
                    <input type="text" maxlength="100" id="searchKeyword" class="form-control"
                           placeholder="검색어를 입력하세요." onkeypress="procCheckSearchFormKeyEvent(event);">
                    <div class="input-group-btn">
                        <button type="button" id="btnSearch" class="btn btn_search">
                            <span class="glyphicon glyphicon-search"></span>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>

<div class="box">
    <div>
        <ul class="nav nav-tabs">
            <li id="catalogTabs_<%= Constants.TAB_NAME_STARTER %>" class="catalogTabs active">
                <a data-toggle="tab" href="#<%= Constants.TAB_NAME_STARTER %>"> 앱 템플릿 </a>
            </li>
            <li id="catalogTabs_<%= Constants.TAB_NAME_BUILD_PACK %>" class="catalogTabs">
                <a data-toggle="tab" href="#<%= Constants.TAB_NAME_BUILD_PACK %>"> 앱 개발환경 </a>
            </li>
            <li id="catalogTabs_<%= Constants.TAB_NAME_SERVICE_PACK %>" class="catalogTabs">
                <a data-toggle="tab" href="#<%= Constants.TAB_NAME_SERVICE_PACK %>"> 서비스 </a>
            </li>
        </ul>

        <div class="tab-content">
            <div id="<%= Constants.TAB_NAME_STARTER %>" class="tab-pane fade active in">
                <%@ include file="starterTab.jsp"%>
            </div>
            <div id="<%= Constants.TAB_NAME_BUILD_PACK %>" class="tab-pane fade">
                <%@ include file="./buildPackTab.jsp"%>
            </div>
            <div id="<%= Constants.TAB_NAME_SERVICE_PACK %>" class="tab-pane fade">
                <%@ include file="./servicePackTab.jsp"%>
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

    var TAB_NAME = "<c:out value='${TAB_NAME}' default='' />";


    // SELECT TAB
    var procSelectTab = function(reqTabName) {
        if ("" == reqTabName) return false;

        $('.tab-pane.fade').removeClass('active in');
        $('#' + reqTabName).addClass('active in');
        $('#catalogTabs_' + reqTabName).tab("show");
    };


    // CHECK SEARCH FORM KEY EVENT
    var procCheckSearchFormKeyEvent = function(e) {
        if (event.keyCode == 13 && event.srcElement.type != 'textarea') {
            procGetSearchList();
        }
    };


    // GET SEARCH LIST
    var procGetSearchList = function() {
        var doc = document;
        var reqSearchType = doc.getElementById('searchType').value;
        var reqSearchTypeColumn = doc.getElementById('searchTypeColumn').value;
        var reqSearchTypeUseYn = doc.getElementById('searchTypeUseYn').value;
        var reqSearchKeyword = doc.getElementById('searchKeyword').value.toLowerCase();

        var param = {searchKeyword : reqSearchKeyword,
                     searchTypeColumn : reqSearchTypeColumn,
                     searchTypeUseYn : reqSearchTypeUseYn
        };

        if ("<%= Constants.TAB_NAME_BUILD_PACK %>" == reqSearchType) {
            getBuildPackList(param);
            procSelectTab("<%= Constants.TAB_NAME_BUILD_PACK %>");

        } else if ("<%= Constants.TAB_NAME_SERVICE_PACK %>" == reqSearchType) {
            getServicePackList(param);
            procSelectTab("<%= Constants.TAB_NAME_SERVICE_PACK %>");

        } else if ("<%= Constants.TAB_NAME_STARTER %>" == reqSearchType) {
            getStarterList(param);
            procSelectTab("<%= Constants.TAB_NAME_STARTER %>");

        } else {
            getStarterList(param);
            getBuildPackList(param);
            getServicePackList(param);

            procSelectTab("<%= Constants.TAB_NAME_STARTER %>");
        }
    };


    // BIND :: BUTTON EVENT
    $("#btnSearch").on("click", function() {
        procGetSearchList();
    });


    // ON LOAD
    $(document.body).ready(function() {
        procSelectTab(TAB_NAME);
    });

</script>
<%--
====================================================================================================
SCRIPT END
====================================================================================================
--%>

<%--FOOTER--%>
<%@ include file="../common/footer.jsp"%>
