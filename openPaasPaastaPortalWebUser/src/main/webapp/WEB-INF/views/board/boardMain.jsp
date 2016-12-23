<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../layout/top.jsp" %>
<%@include file="../layout/left.jsp" %>
<%@include file="../layout/alert.jsp" %>

<div id="boardViewArea">

    <div class="panel content-box col-sm-12 col-md-12 mt-5">
        <div class="col-sm-12 pt0">
            <h4 class="modify_h4 fwb"> 커뮤니티 </h4>
        </div>


        <div class="panel content-box col-sm-12 col-md-12">
            <label class="control-label sr-only" for="searchKeyword"></label>

            <div class="input-group col-sm-2" style="float: left">
                <select id="searchTypeColumn-board" name="searchTypeColumn-board" class="form-control"
                        style="border-radius: 8px; background:url(/resources/images/btn_down.png) no-repeat right; width:95%;">
                    >
                    <option value="<%= Constants.SEARCH_TYPE_ALL %>">전체</option>
                    <option value="<%= Constants.SEARCH_TYPE_TITLE %>">제목</option>
                    <option value="<%= Constants.SEARCH_TYPE_USERID %>">작성자</option>
                    <option value="<%= Constants.SEARCH_TYPE_TITLE_CONTENT %>">제목 + 본문</option>
                </select>
            </div>
            <div class="input-group col-sm-10" style="float: left">
                <input type="text" class="form-control custom-input-text" id="searchKeyword" maxlength="100"
                       placeholder="검색어를 입력하세요."
                       onkeypress="procCheckSearchFormKeyEvent(event);">
                <span class="input-group-addon">
                    <span class="glyphicon glyphicon-search" aria-hidden="true"></span>
                </span>
            </div>
            <p><br></p>

            <div id="boardMessageArea" class="ml10 mt30 fl"></div>

            <div>
                <div class="col-sm-5 pt35 tar ml60 fr">
                    <button type="button" id="buttonMoveInsertForm" class="btn btn-point btn-sm"
                            style="margin-top: -20px"> 글쓰기
                    </button>
                </div>

                <table id="boardTableArea" class="table table-bordered table-hover">
                    <thead>
                    <tr>
                        <th style="text-align:center;">NO</th>
                        <th style="text-align:center;">제목</th>
                        <th style="text-align:center;">작성자</th>
                        <th style="text-align:center;">게시일</th>
                    </tr>
                    </thead>
                    <tbody id="boardTable">
                    </tbody>
                </table>

                <div class="text-center">
                    <ul id="boardPagination" class="pagination pagination-sm"></ul>
                </div>

            </div>
        </div>
    </div>


</div>


<%--HIDDEN VALUE--%>
<input type="hidden" id="currentPageNo" name="currentPageNo" value=""/>
<input type="hidden" id="fileDownload" name="fileDownload" value=""/>
<input type="hidden" id="thisUserId" value='<sec:authentication property="principal.username" />'/>


<form id="boardHiddenForm">
    <input type="hidden" id="boardNo" name="boardNo" value=""/>
    <input type="hidden" id="parentNo" name="parentNo" value=""/>
    <input type="hidden" id="groupNo" name="groupNo" value=""/>

</form>

<%--
====================================================================================================
SCRIPT BEGIN
====================================================================================================
--%>


<%-- twbs-pagination library --%>
<script type="text/javascript" src="/resources/js/lib/jquery.twbsPagination.js"></script>

<script type="text/javascript">

    var BOARD_LIST_PROC_URL = "<c:url value='/board/getBoardList' />";
    var BOARD_VIEW_FORM_URL = "<c:url value='/board/boardMain/view' />";
    var BOARD_CREATE_FORM_URL = "<c:url value='/board/boardMain/create' />";
    var LOADED_LIST_COUNT = 0;

    var USE_YN_Y = "<%= Constants.USE_YN_Y %>";
    var SEARCH_TYPE_ALL = "<%= Constants.SEARCH_TYPE_ALL %>";

    var TOTAL_LENGTH = 1;
    var PER = <%= Constants.PAGE_LIMIT %>;
    var PAGES = 0;

    // ON LOAD
    $(document.body).ready(function () {
        procInitPage();
    });

    // INIT PAGE
    var procInitPage = function () {
        getBoardListUser(<%= Constants.PAGE_OFFSET %>);

    };

    // GET LIST
    var getBoardListUser = function (reqPageNo) {

        $('#buttonGetMoreList').hide();

        var searchTypeColumn = $('#searchTypeColumn-board').val();
        var param = {
            searchKeyword: document.getElementById('searchKeyword').value,
            searchTypeColumn: searchTypeColumn,
            pageOffset: reqPageNo,
            pageLimit: PER
        };

        procCallSpinner(SPINNER_SPIN_START);
        procCallAjax(BOARD_LIST_PROC_URL, param, procCallbackGetBoardListUser);
    };


    // GET LIST CALLBACK
    var procCallbackGetBoardListUser = function (data, reqParam) {
        $("#boardTable").empty();

        if (RESULT_STATUS_FAIL == data.RESULT) {
            procCallSpinner(SPINNER_SPIN_STOP);
            return false;
        }

        var objTableArea = $('#boardTableArea');
        var objTable = $('#boardTable');
        var objMessageArea = $('#boardMessageArea');
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
        $("#boardTable").empty();

        if ($('#boardPagination').data("twbs-pagination")) {
            $('#boardPagination').twbsPagination('destroy');
        }

        if (listLength < 1) {
            objTableArea.hide();
            objTable.hide();
            objMessageArea.append('<spring:message code="common.info.empty.data" />');
            objMessageArea.show();
            procCallSpinner(SPINNER_SPIN_STOP);

        } else {
            TOTAL_LENGTH = data.list[0].listLength;
            PAGES = Math.ceil(TOTAL_LENGTH / PER);

            printData(data);
            paging();

        }
    };

    function printData(data) {
        $("#boardTable").empty();

        var objTableArea = $('#boardTableArea');
        var objTable = $('#boardTable');
        var objMessageArea = $('#boardMessageArea');
        var listLength = data.list.length;
        var resultCreated = null;
        var htmlString = [];

        if (listLength < 1) {
            objTableArea.hide();
            objTable.hide();
            objMessageArea.append('<spring:message code="common.info.empty.data" />');
            objMessageArea.show();


        } else {
            var resultList = data.list;
            var totalListCount = resultList[0].listLength;

            for (var i = 0; i < PER; i++) {

                if (resultList[i] != undefined) {
                    var thisTitle = "";
                    var textIndent = 10;

                    if (resultList[i].level > 0) { // level == depth, 0: 원글, 1~: 답글
                        textIndent = resultList[i].level * 30;
                        thisTitle = "└ ";
                    }

                    var commentNum = resultList[i].commentNum;
                    var thisComment = "";
                    if (commentNum > 0) {
                        thisComment = thisComment + "[" + commentNum + "]";
                    }

                    if (resultList[i].filePath != '') { // 파일 있으면

                        var fileSize = procConvertFormatNumber(procCalculateFloor(parseInt(resultList[i].fileSize) / 1024, 2));

                        htmlString.push('<tr id="trID" >'
                                + '<td class="col-md-1 tac"><span style="font-size: 15px;">' + resultList[i].no + '</td>'
                                + '<td class="col-md-6" style="padding-left: ' + textIndent + 'px;">'
                                + ' <span style="font-size: 15px;"> ' + thisTitle + '</span>'
                                + '<span id="titleId" style="cursor:pointer;" onclick="procMoveBoardView(\'' + resultList[i].no + '\',\'' + resultList[i].parentNo + '\',\'' + resultList[i].groupNo + '\')">' + resultList[i].title + '</span>'
                                + '<a href="javascript:void(0);"  onclick="procDownload(\'' + resultList[i].filePath + '\', \'' + resultList[i].fileName + '\');" data-toggle="tooltip" data-placement="right" title="' + resultList[i].fileName + ' (' + fileSize + ' KB)">'
                                + ' <span id="fileIcon" class="glyphicon glyphicon-save-file" aria-hidden="true"></span> </a> '
                                + ' <span style="font-size: 15px;"> ' + thisComment + '</span>'
                                + '</td>'
                                + '<td class="col-md-1 tac"><span style="font-size: 15px;">' + masking(resultList[i].userId) + '</td>'
                                + '<td class="col-md-1 tac"><span style="font-size: 15px;">' + resultList[i].created.substring(0, 10) + '</td>'
                                + '</tr>');


                    } else {
                        htmlString.push('<tr id="trID" >'
                                + '<td class="col-md-1 tac"><span style="font-size: 15px;">' + resultList[i].no + '</td>'
                                + '<td class="col-md-6" style="padding-left: ' + textIndent + 'px;">'
                                + ' <span style="font-size: 15px;"> ' + thisTitle + '</span>'
                                + '<span id="titleId" style="cursor:pointer;" onclick="procMoveBoardView(\'' + resultList[i].no + '\',\'' + resultList[i].parentNo + '\',\'' + resultList[i].groupNo + '\')">' + resultList[i].title + '</span>'
                                + ' <span style="font-size: 15px;"> ' + thisComment + '</span>'
                                + '</td>'
                                + '<td class="col-md-1 tac"><span style="font-size: 15px;">' + masking(resultList[i].userId) + '</td>'
                                + '<td class="col-md-1 tac"><span style="font-size: 15px;">' + resultList[i].created.substring(0, 10) + '</td>'
                                + '</tr>');
                    }
                }
            }
        }

        objMessageArea.hide();
        objTable.append(htmlString);
        objTable.show();
        objTableArea.show();

        procCallSpinner(SPINNER_SPIN_STOP);

    }

    function masking(str) {
        var strLength = str.length;
        var result = str[0] + str[1];
        var j = 100000;

        for (var i = 2; i < strLength; i++) {
            if (str[i] == "@") {
                j = i;
                break;
            }
            result = result + "*";
        }

        for (var i = j; i < strLength; i++) {
            result = result + str[i];
        }

        return result;
    }

    function paging() {

        $("#boardTable").empty();

        if ($('#boardPagination').data("twbs-pagination")) {
            $('#boardPagination').twbsPagination('destroy');
        }

        $('#boardPagination').twbsPagination({
            totalPages: PAGES,  // 전체 page 수
            visiblePages: 5,  // 출력될 page 수

            onPageClick: function (event, page) {

                var offSet = (page - 1) * PER;
                getBoardListUser2(offSet);

            }
        });

    }

    // GET LIST
    var getBoardListUser2 = function (reqPageNo) {

        $('#buttonGetMoreList').hide();

        var searchTypeColumn = $('#searchTypeColumn-board').val();
        var param = {
            searchKeyword: document.getElementById('searchKeyword').value,
            searchTypeColumn: searchTypeColumn,

            pageOffset: reqPageNo,
            pageLimit: PER
        };

        procCallAjax(BOARD_LIST_PROC_URL, param, printData);
    };

    // CHECK SEARCH FORM KEY EVENT
    var procCheckSearchFormKeyEvent = function (e) {
        if (e.keyCode == 13 && e.srcElement.type != 'textarea') {

            getBoardListUser(0);
        }
    };

    //    // MOVE Board VIEW
    var procMoveBoardView = function (boardNo, parentNo, groupNo) {

        var hiddenForm = $('#boardHiddenForm');
        $('#boardHiddenForm #boardNo').val(boardNo);
        $('#boardHiddenForm #parentNo').val(parentNo);
        $('#boardHiddenForm #groupNo').val(groupNo);

        hiddenForm.attr({action: BOARD_VIEW_FORM_URL, method: "POST"}).submit();
    };

    // BIND :: KEY UP EVENT
    $("#searchKeyword").on("keyup", function () {
        //   procSearchKeyword($("#myQuestionType").val(), $("#searchKeyword").val());
    });

    // BIND :: KEY UP EVENT
    $("#buttonMoveInsertForm").on("click", function () {
        procMovePage(BOARD_CREATE_FORM_URL);
    });

    // CALCULATE FLOOR
    var procCalculateFloor = function (reqNumber, reqPosition) {
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
====================================================================================================e
SCRIPT END
====================================================================================================
--%>

<%@include file="../layout/bottom.jsp" %>
