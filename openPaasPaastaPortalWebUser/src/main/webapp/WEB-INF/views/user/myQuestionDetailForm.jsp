<!--
=================================================================
* 시  스  템  명 : PaaS-TA 사용자 포탈
* 업    무    명 : 내 문의
* 프로그램명(ID) : myQuestionDetailForm.jsp(내문의상세조회)
* 프로그램  개요 : 내 문의를 상세 조회하는 화면
* 작    성    자 : 김도준
* 작    성    일 : 2016.08.25
=================================================================
수정자 / 수정일 :
수정사유 / 내역 :
=================================================================
-->
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../layout/top.jsp" %>
<%@include file="../layout/left.jsp" %>
<%@include file="../layout/alert.jsp" %>

<div id="myQuestionViewArea" style="display: none;">
    <div class="panel content-box col-sm-12 col-md-12 mt-5">
        <div class="col-sm-12">
            <h4 class="modify_h4 fwb"> 내 문의 </h4>
        </div>
        <div class="col-sm-12 col-md-12 mt10">
            <div class="col-sm-12" style="border: 1px solid #dddddd; border-radius: 10px;">
                <div class="pd10" style="min-height: 40px;">
                    <div class="fl"><span id="classification"> 스타터 </span></div>
                    <div class="ml50 fl"><span id="title"> 스타터 사용법 문의 </span></div>
                    <div class="ml20 fr"><span id="created"> 2016-12-06 13:10 </span></div>
                </div>
                <div class="pd20" style="border-top: 1px solid #dddddd; border-bottom: 1px solid #dddddd; min-height: 140px;">
                    <span id="content"> 문의 내용 </span>
                </div>
                <div id="fileNameArea" class="pd10" style="min-height: 40px;">
                    <span> 첨부 파일 : </span><span id="fileName"> test.jpg (20 KB) </span>
                </div>
            </div>
            <div class="col-sm-12 pd20" style="border: 1px solid #dddddd; border-radius: 10px; min-height: 200px; background-color: #999999; margin: 10px 0;">
                <div class="col-sm-1 fl">
                    <h4 class="custom_color_white"> 답변 </h4>
                </div>
                <div class="col-sm-11 pd20 fl" style="border: 1px solid #eeeeee; border-radius: 10px; min-height: 176px; background-color: #ffffff;">
                    <span id="answerContent"> 답변 내용 </span>
                </div>
                <div class="col-sm-1 fl">
                </div>
                <div class="col-sm-11 mt10 pd0 fl">
                    <div class="fl">
                        <div id="answerFileNameArea">
                            <span id="answerFileName" class="custom_color_white"> test2.jpg (20 KB)</span>
                        </div>
                    </div>
                    <div class="fr">
                        <span id="answerCreated" class="custom_color_white"> 2016-12-07 09:10:55 </span>
                    </div>
                </div>
            </div>
            <div class="form-group mt20">
                <div class="col-sm-12 pd0 mt10 tar">
                    <button type="button" class="btn btn-danger btn-sm fl" id="btnDelete"> 삭제 </button>
                    <button type="button" class="btn btn-cancel btn-sm" id="btnList"> 목록 </button>
                </div>
            </div>
        </div>
    </div>
</div>

<%--HIDDEN VALUE--%>
<input type="hidden" id="no" name="no" value="<c:out value='${MY_QUESTION_NO}' default='' />" />
<input type="hidden" id="filePath" name="filePath" value="" />


<%--
====================================================================================================
SCRIPT BEGIN
====================================================================================================
--%>


<script type="text/javascript">

    var HOME_URL = "<c:url value='/myQuestion//myQuestionMain' />";
    var LIST_PROC_URL = "<c:url value='/myQuestion//getMyQuestionList' />";
    var ANSWER_LIST_PROC_URL = "<c:url value='/myQuestion/getMyQuestionAnswer' />";
    var DELETE_FILE_PROC_URL = "<c:url value='/myQuestion/deleteFile'/>";
    var DELETE_PROC_URL = "<c:url value='/myQuestion/deleteMyQuestion' />";


    // GET LIST
    var getMyQuestionList = function () {
        var param = {no : $('#no').val(),
                     pageSize : 1,
                     pageNo : 1
        };

        procCallAjax(LIST_PROC_URL, param, procCallbackGetMyQuestionList);
    };


    // GET LIST CALLBACK
    var procCallbackGetMyQuestionList = function (data) {
        var resultData = data.list[0];

        $('#classification').text(resultData.classificationValue);
        $('#title').text(resultData.title);
        $('#content').html(resultData.content.replace(/\r?\n/g, '<br>'));
        $('#created').text((resultData.created).substring(0, 16));

        var fileName = resultData.fileName;
        if (null != fileName && '' != fileName) {
            var filePath = resultData.filePath;
            $('#filePath').val(filePath);

            procSetFileLabel(fileName, resultData.fileSize, filePath, false);
        }

        getMyQuestionAnswer();
    };


    // GET LIST
    var getMyQuestionAnswer = function () {
        procCallAjax(ANSWER_LIST_PROC_URL, {no : $('#no').val()}, procCallbackGetMyQuestionAnswer);
    };


    // GET LIST CALLBACK
    var procCallbackGetMyQuestionAnswer = function (data) {
        var resultData = data.info;

        $('#answerContent').html(resultData.content.replace(/\r?\n/g, '<br>'));
        $('#answerCreated').text((resultData.created).substring(0, 16));

        var fileName = resultData.fileName;
        if (null != fileName && '' != fileName) {
            var filePath = resultData.filePath;
            procSetFileLabel(fileName, resultData.fileSize, filePath, true);
        }

        procSetCompleteView();
    };


    // DELETE
    var procDelete = function () {
        $('div.modal').modal('toggle');
        procCallAjax(DELETE_PROC_URL, {no : $("#no").val(), questionNo: $("#no").val()}, procCallbackDelete);
    };


    // DELETE CALLBACK
    var procCallbackDelete = function (data) {
        if (RESULT_STATUS_SUCCESS == data.RESULT) {
            procDeleteFile();
            showAlert("success", '<spring:message code="common.info.result.success" />');

        } else {
            procCallSpinner(SPINNER_SPIN_STOP);
            showAlert("fail", data.RESULT_MESSAGE);
        }
    };


    // DELETE FILE
    var procDeleteFile = function () {
        var filePath = $("#filePath").val();
        if ('' != filePath) {
            procCallAjax(DELETE_FILE_PROC_URL, {filePath : filePath}, procCallbackDeleteFile);

        } else {
            procMovePage(HOME_URL);
        }
    };


    // // DELETE FILE CALLBACK
    var procCallbackDeleteFile = function () {
        procMovePage(HOME_URL);
    };


    // SET FILE LABEL
    var procSetFileLabel = function (reqFileName, reqOrgFileSize, reqFilePath, reqAnswerCheck) {
        if (null == reqFileName || '' == reqFileName) return false;

        var fileSize = procConvertFormatNumber(procCalculateFloor(parseInt(reqOrgFileSize) >> 10, 2));
        var resultFileSize = 'NaN' != fileSize ? " (" + fileSize + " KB)" : '';

        var fileName = reqFileName + resultFileSize;
        var fileNameObject = $('#fileName');
        var fileNameAreaObject = $('#fileNameArea');
        var tempCss = '';

        if (reqAnswerCheck) {
            fileNameObject = $('#answerFileName');
            fileNameAreaObject = $('#answerFileNameArea');
            tempCss = 'style="color: #ffffff;"';
        }

        if ('' != reqFilePath) {
            var linkHtml = '<a href="javascript:void(0);" ' + tempCss +  ' onclick="procDownload(\'' + reqFilePath + '\', \'' + reqFileName + '\')">' + fileName + '</a>';
            fileNameObject.html(linkHtml);

        } else {
            fileNameObject.text(fileName);
        }

        fileNameAreaObject.show();
    };


    // SET COMPLETE VIEW
    var procSetCompleteView = function () {
        $('#myQuestionViewArea').show();
        $('#custom_footer').show();
        procCallSpinner(SPINNER_SPIN_STOP);
    };


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


    // INIT PAGE
    var procInitPage = function () {
        $('#fileNameArea').hide();
        $('#answerFileNameArea').hide();
        $('#myQuestionViewArea').hide();
        $('#custom_footer').hide();
        procCallSpinner(SPINNER_SPIN_START);

        getMyQuestionList();
    };


    // BIND :: BUTTON EVENT
    $("#btnList").on("click", function () {
        procMovePage(HOME_URL);
    });


    // BIND :: BUTTON EVENT
    $("#btnDelete").on("click", function () {
        procPopup('내 문의', "<spring:message code='common.info.popup.delete.message' />", 'procDelete();');
    });


    // ON LOAD
    $(document.body).ready(function () {
        procInitPage();
    });

</script>


<%--
====================================================================================================
SCRIPT END
====================================================================================================
--%>


<%@include file="../layout/bottom.jsp" %>
