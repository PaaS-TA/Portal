<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../layout/top.jsp" %>
<%@include file="../layout/left.jsp" %>
<%@include file="../layout/alert.jsp" %>

<div id="myQuestionViewArea">
    <div class="form-group custom-search-form">
        <div class="col-sm-12 pt10">
            <h4> 내 문의 </h4>
        </div>
        <div class="panel content-box col-sm-12 col-md-12">
            <label class="control-label sr-only" for="searchKeyword"></label>
            <div class="input-group">
            <span class="input-group-addon">
                <span class="glyphicon glyphicon-search" aria-hidden="true"></span>
            </span>
                <input type="text" class="form-control custom-input-text" id="searchKeyword"
                       maxlength="100" placeholder="검색어를 입력하세요." onkeypress="procCheckSearchFormKeyEvent(event);"/>
            </div>
            <div>
                <div class="mt20 mb10 fr">
                    <button type="button" id="buttonMoveInsertForm" class="btn btn-primary btn-sm"> 문의하기 </button>
                </div>
                <div id="myQuestionMessageArea" class="ml10 mt30 fl">
                </div>
                <table id="myQuestionTableArea" class="table table-striped table-hover t1">
                    <thead>
                    <tr>
                        <th> No </th>
                        <th> 분류 </th>
                        <th> 제목 </th>
                        <th> 답변상태 </th>
                        <th> 등록일 </th>
                    </tr>
                    </thead>
                    <tbody id="myQuestionTable">
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


<%--
====================================================================================================
SCRIPT BEGIN
====================================================================================================
--%>


<script type="text/javascript">

    var MY_QUESTION_LIST_PROC_URL = "<c:url value='/myQuestion/getMyQuestionList' />";
    var MY_QUESTION_INSERT_FORM_URL = "<c:url value='/myQuestion/myQuestionMain/create' />";
    var MY_QUESTION_UPDATE_FORM_URL = "<c:url value='/myQuestion/myQuestionMain/update' />";
    var MY_QUESTION_DETAIL_FORM_URL = "<c:url value='/myQuestion/myQuestionMain/detail' />";
    var LOADED_LIST_COUNT = 0;


    // GET LIST
    var getMyQuestionList = function(reqPageNo) {
        $('#buttonGetMoreList').hide();

        var param = {searchKeyword : document.getElementById('searchKeyword').value,
                     pageSize : '<%= Constants.MY_QUESTION_PAGE_SIZE %>',
                     pageNo : reqPageNo
        };

        procCallAjax(MY_QUESTION_LIST_PROC_URL, param, procCallbackGetMyQuestionList);
    };


    // GET LIST CALLBACK
    var procCallbackGetMyQuestionList = function(data, reqParam) {
        if (RESULT_STATUS_FAIL == data.RESULT) {
            procCallSpinner(SPINNER_SPIN_STOP);
            return false;
        }

        var objTableArea = $('#myQuestionTableArea');
        var objTable = $('#myQuestionTable');
        var objMessageArea = $('#myQuestionMessageArea');
        var listLength = data.list.length;
        var resultCreated = null;
        var htmlString = [];

        var reqPageNo = reqParam.pageNo;
        document.getElementById('currentPageNo').value = reqPageNo;

        if ('<%= Constants.MY_QUESTION_PAGE_NO %>' == reqPageNo) {
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
            var totalListCount = resultList[0].totalCount;

            for (var i = 0; i < listLength; i++) {
                resultCreated = (resultList[i].created).substring(0, 16);

                htmlString.push('<tr style="cursor:pointer;" onclick="procMoveMyQuestionUpdateForm(\''
                        + resultList[i].no + '\', \'' + resultList[i].status + '\')">'
                        + '<td class="col-md-1 tac">' + resultList[i].no + '</td>'
                        + '<td class="col-md-2 tac">' + resultList[i].classificationValue + '</td>'
                        + '<td class="col-md-6"><span class="ml10">' + resultList[i].title + '</span></td>'
                        + '<td class="col-md-1 tac">' + resultList[i].statusValue + '</td>'
                        + '<td class="col-md-2 tac">' + resultCreated + '</td>'
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

        $('#myQuestionViewArea').show();
        procCallSpinner(SPINNER_SPIN_STOP);
    };


    // GET MORE LIST
    var procGetMoreList = function() {
        getMyQuestionList(parseInt(document.getElementById('currentPageNo').value) + 1);
    };


    // CHECK SEARCH FORM KEY EVENT
    var procCheckSearchFormKeyEvent = function(e) {
        if (e.keyCode==13 && e.srcElement.type != 'textarea') {
            getMyQuestionList(<%= Constants.MY_QUESTION_PAGE_NO %>);
        }
    };


    // MOVE MY QUESTION UPDATE FORM
    var procMoveMyQuestionUpdateForm = function(reqNo, reqStatus) {
        if (!procCheckValidNull(reqNo)) return false;

        var reqUrl = '<%= Constants.MY_QUESTION_STATUS_WAITING %>' == reqStatus ? MY_QUESTION_UPDATE_FORM_URL : MY_QUESTION_DETAIL_FORM_URL;

        procMovePage(reqUrl + "/" + reqNo);
    };


    // INIT PAGE
    var procInitPage = function() {
        $('#myQuestionViewArea').hide();
        procCallSpinner(SPINNER_SPIN_START);

        getMyQuestionList(<%= Constants.MY_QUESTION_PAGE_NO %>);
    };


    // BIND :: BUTTON EVENT
    $("#buttonMoveInsertForm").on("click", function() {
        procMovePage(MY_QUESTION_INSERT_FORM_URL);
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
