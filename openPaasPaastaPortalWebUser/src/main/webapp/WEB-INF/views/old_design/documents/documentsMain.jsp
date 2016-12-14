<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../layout/top.jsp" %>
<%@include file="../layout/left.jsp" %>
<%@include file="../layout/alert.jsp" %>

<div id="docoumentsViewArea">
    <div class="form-group custom-search-form">
        <div class="col-sm-12 pt10">
            <h4> 문서 </h4>
        </div>

        <div class="panel content-box col-sm-12 col-md-12">
            <label class="control-label sr-only" for="searchKeyword"></label>
            <div class="input-group">

                <input type="text" class="form-control custom-input-text" id="searchKeyword" maxlength="100" placeholder="검색어를 입력하세요."
                       onkeypress="procCheckSearchFormKeyEvent(event);">
                <span class="input-group-addon">
                <span class="glyphicon glyphicon-search" aria-hidden="true"></span>
                </span>
            </div>
            <p><br></p>
            <div id="documentsMessageArea" class="ml10 mt30 fl"></div>
            <div>
                <table id="documentsTableArea" class="table table-striped table-hover t1">
                    <thead>
                    <tr>
                        <th>No.</th>
                        <th>분류</th>
                        <th>제목</th>
                        <th>게시일</th>
                    </tr>
                    </thead>
                    <tbody id="documentsTable">
                    </tbody>
                </table>
                <div id="buttonGetMoreList" class="mt30 tac">
                    <button type="button" class="btn btn-primary btn-sm" onclick="procGetMoreList();">
                        <span class="glyphicon glyphicon-triangle-bottom" aria-hidden="true"></span>
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<%--HIDDEN VALUE--%>
<input type="hidden" id="currentPageNo" name="currentPageNo" value="" />
<input type="hidden" id="fileDownload" name="fileDownload" value="" />


<form id="documentsHiddenForm">
    <input type="hidden" id="documentNo" name="documentNo" value="" />

</form>

<%--
====================================================================================================
SCRIPT BEGIN
====================================================================================================
--%>

<script type="text/javascript">

    var DOCUMENTS_LIST_PROC_URL = "<c:url value='/documents/getDocumentsList' />";
    var DOCUMENTS_VIEW_FORM_URL = "<c:url value='/documents/documentsMain/view' />";
    var LOADED_LIST_COUNT = 0;

    // GET LIST
    var getDocumentsListUser = function(reqPageNo) {
        $('#buttonGetMoreList').hide();

        var param = {
            searchKeyword : document.getElementById('searchKeyword').value,
            searchTypeColumn: '<%= Constants.SEARCH_TYPE_DOCUMENTS %>',
            pageOffset : reqPageNo,
            searchTypeUseYn : '<%= Constants.USE_YN_Y %>'
        };

        procCallAjax(DOCUMENTS_LIST_PROC_URL, param, procCallbackGetDocumentsListUser);
    };


    // GET LIST CALLBACK
    var procCallbackGetDocumentsListUser = function(data, reqParam) {
        if (RESULT_STATUS_FAIL == data.RESULT) {
            procCallSpinner(SPINNER_SPIN_STOP);
            return false;
        }
        var objTableArea = $('#documentsTableArea');
        var objTable = $('#documentsTable');
        var objMessageArea = $('#documentsMessageArea');
        var listLength = data.list.length;
        var htmlString = [];
        var reqPageNo = reqParam.pageOffset;
        document.getElementById('currentPageNo').value = reqPageNo;

        if ('<%= Constants.PAGE_OFFSET %>' == reqPageNo) {
            LOADED_LIST_COUNT = 0;
            objTable.html('');
        }
        objMessageArea.html('');

        if (listLength < 1) {
            objTableArea.hide();
            objTable.hide();
            objMessageArea.append('<spring:message code="common.info.empty.data" />');
            objMessageArea.show();

        } else {
            var resultList = data.list;
            var totalListCount = resultList[0].listLength;
            for (var i = 0; i < listLength; i++) {
                var fileSize = procConvertFormatNumber(procCalculateFloor(parseInt(resultList[i].fileSize) / 1024, 2));
                htmlString.push('<tr>'
                        + '<td class="col-md-1 tac">' + resultList[i].no + '</td>'
                        + '<td class="col-md-2 tac">' + resultList[i].classificationValue + '</td>'
                        + '<td class="col-md-7"><span id="titleId"  style="cursor:pointer;" onclick="procMoveDocumentsView(\'' + resultList[i].no + '\')">' + resultList[i].title + '</span>'
                            +'<a href="javascript:void(0);"  onclick="procDownload(\'' + resultList[i].filePath + '\', \'' + resultList[i].fileName + '\');" data-toggle="tooltip" data-placement="right" title="' + resultList[i].fileName + ' ('+ fileSize + ' KB) ' + '">'
                            + ' <span id="fileIcon" class="glyphicon glyphicon-save-file"  aria-hidden="true"></span> </a> '
                        + '</td>'
                        + '<td class="col-md-2 tac">' + resultList[i].created.substring(0,10) + '</td>' // substring(0,16)
                        + '</tr>');
            }

            LOADED_LIST_COUNT += listLength;

            if (totalListCount > LOADED_LIST_COUNT) {
                $('#buttonGetMoreList').animate({
                    opacity: "show"
                });
            }

            objMessageArea.hide();
            objTable.append(htmlString);
            objTable.show();
            objTableArea.show();
        }

        procCallSpinner(SPINNER_SPIN_STOP);
    };

    // GET MORE LIST
    var procGetMoreList = function() {
        procCallSpinner(SPINNER_SPIN_START);
        getDocumentsListUser(parseInt(document.getElementById('currentPageNo').value) + 10);
    };

    // CHECK SEARCH FORM KEY EVENT
    var procCheckSearchFormKeyEvent = function(e) {
        if (e.keyCode==13 && e.srcElement.type != 'textarea') {
            procCallSpinner(SPINNER_SPIN_START);
            getDocumentsListUser(0);
        }
    };

//    // MOVE DOCUMENTS VIEW
    var procMoveDocumentsView = function(documentNo) {

        var hiddenForm = $('#documentsHiddenForm');
        $('#documentsHiddenForm #documentNo').val(documentNo);

        hiddenForm.attr({action:DOCUMENTS_VIEW_FORM_URL, method:"POST"}).submit();
    };


    // CALCULATE FLOOR
    var procCalculateFloor = function(reqNumber, reqPosition) {
        var digits = Math.pow(10, reqPosition);
        var num = Math.round(reqNumber * digits) / digits;

        return num.toFixed(reqPosition);
    };

    // CONVERT FORMAT NUMBER
    var procConvertFormatNumber = function (reqString) {
        return reqString.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    };

    // BIND :: BUTTON EVENT
    $("#btnList").on("click", function() {
        procMovePage(TO_LIST);
    });

    // INIT PAGE
    var procInitPage = function() {
        procCallSpinner(SPINNER_SPIN_START);
        getDocumentsListUser(<%= Constants.PAGE_OFFSET %>);
    };

    // BIND :: KEY UP EVENT
    $("#searchKeyword").on("keyup", function() {
     //   procSearchKeyword($("#myQuestionType").val(), $("#searchKeyword").val());
    });


    // BIND :: KEY UP EVENT
    $("#buttonMoveInsertForm").on("click", function() {
    //    procMovePage(MY_QUESTION_INSERT_FORM_URL);
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
