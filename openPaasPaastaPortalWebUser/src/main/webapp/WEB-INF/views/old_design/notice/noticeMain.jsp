<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../layout/top.jsp" %>
<%@include file="../layout/left.jsp" %>
<%@include file="../layout/alert.jsp" %>

<div id="docoumentsViewArea">
    <div class="form-group custom-search-form">
        <div class="col-sm-12 pt10">
            <h4> 공지 </h4>
        </div>

        <div class="panel content-box col-sm-12 col-md-12">
            <label class="control-label sr-only" for="searchKeyword"></label>
            <div class="input-group">
            <span class="input-group-addon">
                <span class="glyphicon glyphicon-search" aria-hidden="true"></span>
            </span>
                <input type="text" class="form-control custom-input-text" id="searchKeyword" maxlength="100" placeholder="검색어를 입력하세요."
                       onkeypress="procCheckSearchFormKeyEvent(event);">
            </div>
            <p><br></p>
            <div id="noticeMessageArea" class="ml10 mt30 fl"></div>
            <div>
                <table id="noticeTableArea" class="table table-striped table-hover t1">
                    <thead>
                    <tr>
                        <th>No.</th>
                        <th>분류</th>
                        <th>제목</th>
                        <th>게시일</th>
                    </tr>
                    </thead>
                    <tbody id="importantNoticeTable">
                    </tbody>
                    <tbody id="noticeTable">
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

<form id="noticeHiddenForm">
    <input type="hidden" id="noticeNo" name="noticeNo" value="" />
</form>

<%--
====================================================================================================
SCRIPT BEGIN
====================================================================================================
--%>

<script type="text/javascript">

    var NOTICE_LIST_PROC_URL = "<c:url value='/notice/getNoticeList' />";
    var NOTICE_VIEW_FORM_URL = "<c:url value='/notice/noticeMain/view' />";
    var LOADED_LIST_COUNT = 0;
    var USE_YN_Y = "<%= Constants.USE_YN_Y %>";
    var SEARCH_TYPE_ALL = "<%= Constants.SEARCH_TYPE_ALL %>";

    // GET LIST
    var getNoticeListUser = function(reqPageNo) {
        $('#buttonGetMoreList').hide();

        var searchKeyword = document.getElementById('searchKeyword').value;
        console.log("searchKeyword : " + searchKeyword);
        var param = {
            searchKeyword : searchKeyword,
            searchTypeColumn : SEARCH_TYPE_ALL,
            pageOffset : reqPageNo
        };

        procCallAjax(NOTICE_LIST_PROC_URL, param, procCallbackGetNoticeListUser);

        if (reqPageNo == 0) {
            var param2 = {
             //   important : 'true'
            }
            $.extend(param2, param);
            procCallAjax(NOTICE_LIST_PROC_URL, param2, procCallbackGetNoticeImportantList);
        }
    };


    // GET LIST CALLBACK
    var procCallbackGetNoticeImportantList = function(data, reqParam) {
        if (RESULT_STATUS_FAIL == data.RESULT) {
            procCallSpinner(SPINNER_SPIN_STOP);
            return false;
        }

        $('#importantNoticeTable').empty();

        var objTableArea = $('#noticeTableArea');
        var objTableImportant = $('#importantNoticeTable');
        var objMessageArea = $('#noticeMessageArea');
        var listLength = data.list.length;
        var resultCreated = null;
        var htmlStringImportant = [];
        var reqPageNo = reqParam.pageOffset;

        objMessageArea.html('');

        if (listLength < 1) {
            objTableImportant.hide();

        } else {
            var resultList = data.list;
            for (var i = 0; i < listLength; i++) {
                if (resultList[i].useYn == USE_YN_Y) {
                    // 중요공지
                    if (resultList[i].important == "true") {
                        var fileSize = procConvertFormatNumber(procCalculateFloor(parseInt(resultList[i].fileSize) / 1024, 2));
                        if (resultList[i].filePath != '') { // 파일 있으면
                            htmlStringImportant.push('<tr id="trID" style="color:rgb(249, 161, 27); font-weight:bold;" >'
                                    + '<td class="col-md-1 tac">' + resultList[i].no + '</td>'
                                    + '<td class="col-md-2 tac">' + resultList[i].classificationValue + '</td>'
                                    + '<td class="col-md-4">'
                                            + '<span id="titleId" style="cursor:pointer;" onclick="procMoveNoticeView(\'' + resultList[i].no + '\')">' + resultList[i].title + '</span>'
                                            + '<a href="javascript:void(0);"  onclick="procDownload(\'' + resultList[i].filePath + '\', \'' + resultList[i].fileName + '\');" data-toggle="tooltip" data-placement="right" title="' + resultList[i].fileName + ' ('+ fileSize + ' KB)">'
                                            + ' <span id="fileIcon" class="glyphicon glyphicon-save-file" style="color:rgb(249, 161, 27);" aria-hidden="true"></span> </a> '
                                    + '</td>'
                                    + '<td class="col-md-2 tac">' + resultList[i].startDate.substring(0,10) + ' ~ ' + resultList[i].endDate.substring(0,10) + '</td>'
                                    + '</tr>');
                        } else {
                            htmlStringImportant.push('<tr id="trID" style="color:rgb(249, 161, 27); font-weight:bold; ">'
                                    + '<td class="col-md-1 tac">' + resultList[i].no + '</td>'
                                    + '<td class="col-md-2 tac">' + resultList[i].classificationValue + '</td>'
                                    + '<td class="col-md-4"><span id="titleId" style="cursor:pointer;" onclick="procMoveNoticeView(\'' + resultList[i].no + '\')">' + resultList[i].title + '</span></td>'
                                    + '<td class="col-md-2 tac">' + resultList[i].startDate.substring(0,10) + ' ~ ' + resultList[i].endDate.substring(0,10) + '</td>'
                                    + '</tr>');
                        }
                    }
                }
            }

            objMessageArea.hide();
            objTableImportant.append(htmlStringImportant);
            objTableImportant.show();
            objTableArea.show();
        }
    };

    // GET LIST CALLBACK
    var procCallbackGetNoticeListUser = function(data, reqParam) {
        if (RESULT_STATUS_FAIL == data.RESULT) {
            procCallSpinner(SPINNER_SPIN_STOP);
            return false;
        }

        var objTableArea = $('#noticeTableArea');
        var objTable = $('#noticeTable');
        var objMessageArea = $('#noticeMessageArea');
        var listLength = data.list.length;
        var resultCreated = null;
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
            var totalListCount = resultList[0].rowNum;
            for (var i = 0; i < listLength; i++) {
                if (resultList[i].useYn == USE_YN_Y) {
                    var fileSize = procConvertFormatNumber(procCalculateFloor(parseInt(resultList[i].fileSize) / 1024, 2));

                    if (resultList[i].filePath != '') { // 파일 있으면
                        htmlString.push('<tr id="trID" >'
                                + '<td class="col-md-1 tac">' + resultList[i].no + '</td>'
                                + '<td class="col-md-2 tac">' + resultList[i].classificationValue + '</td>'
                                + '<td class="col-md-4">'
                                + '<span id="titleId" style="cursor:pointer;" onclick="procMoveNoticeView(\'' + resultList[i].no + '\')">' + resultList[i].title + '</span>'
                                + '<a href="javascript:void(0);"  onclick="procDownload(\'' + resultList[i].filePath + '\', \'' + resultList[i].fileName + '\');" data-toggle="tooltip" data-placement="right" title="' + resultList[i].fileName + ' ('+ fileSize + ' KB)">'
                                + ' <span id="fileIcon" class="glyphicon glyphicon-save-file" aria-hidden="true"></span> </a> '
                                + '</td>'
                                + '<td class="col-md-2 tac">' + resultList[i].startDate.substring(0,10) + ' ~ ' + resultList[i].endDate.substring(0,10) + '</td>'
                                + '</tr>');
                    } else {
                        htmlString.push('<tr id="trID" >'
                                + '<td class="col-md-1 tac">' + resultList[i].no + '</td>'
                                + '<td class="col-md-2 tac">' + resultList[i].classificationValue + '</td>'
                                + '<td class="col-md-4"><span id="titleId" style="cursor:pointer;" onclick="procMoveNoticeView(\'' + resultList[i].no + '\')">' + resultList[i].title + '</span></td>'
                                + '<td class="col-md-2 tac">' + resultList[i].startDate.substring(0,10) + ' ~ ' + resultList[i].endDate.substring(0,10) + '</td>'
                                + '</tr>');
                    }
                }
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
        }
        procCallSpinner(SPINNER_SPIN_STOP);
    };

    // GET MORE LIST
    var procGetMoreList = function() {
        procCallSpinner(SPINNER_SPIN_START);
        getNoticeListUser(parseInt(document.getElementById('currentPageNo').value) + 10);
    };

//    // MOVE Notice VIEW
    var procMoveNoticeView = function(noticeNo) {
        var hiddenForm = $('#noticeHiddenForm');
        $('#noticeHiddenForm #noticeNo').val(noticeNo);
        hiddenForm.attr({action:NOTICE_VIEW_FORM_URL, method:"POST"}).submit();
    };

    // INIT PAGE
    var procInitPage = function() {
        procCallSpinner(SPINNER_SPIN_START);
        getNoticeListUser(<%= Constants.PAGE_OFFSET %>);
    };


    // CHECK SEARCH FORM KEY EVENT
    var procCheckSearchFormKeyEvent = function(e) {
        console.log("dddd");
        if (e.keyCode==13 && e.srcElement.type != 'textarea') {
           // procCallSpinner(SPINNER_SPIN_START);
            getNoticeListUser(0);
        }
    };


    // BIND :: KEY UP EVENT
    $("#searchKeyword").on("keyup", function() {
        console.log("qqqqq");
      //  procCallSpinner(SPINNER_SPIN_START);
        getNoticeListUser(0);
       // procSearchKeyword($("#myQuestionType").val(), $("#searchKeyword").val());
    });


    // BIND :: KEY UP EVENT
    $("#buttonMoveInsertForm").on("click", function() {
    //    procMovePage(MY_QUESTION_INSERT_FORM_URL);
    });


    // ON LOAD
    $(document.body).ready(function() {
        procInitPage();
    });


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



</script>

<%--
====================================================================================================
SCRIPT END
====================================================================================================
--%>

<%@include file="../layout/bottom.jsp" %>
