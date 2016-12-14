<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../layout/top.jsp" %>
<%@include file="../layout/left.jsp" %>
<%@include file="../layout/alert.jsp" %>

<%--FILE UPLOAD--%>
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/fileUpload.css'/>">

<div id="documentsViewArea">
    <div class="form-group custom-search-form">
    <div class="col-sm-12 pt10">
        <h4 class="modify_h4"> 문서 상세 </h4>
    </div>

    <div class="panel content-box col-sm-12 col-md-12">
        <form id="documentsForm" name="documentsForm" class="form-horizontal" role="form">
            <div class="form-group">
                <label class="control-label col-sm-1 custom_text_align custom_control_label" for="classification"> 분류 </label>
                <div class="col-sm-11">
                    <input type="text" class="form-control modify_form_control" id="classification" name="classification" maxlength="100" style="background: white; cursor: text" disabled>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-1 custom_text_align custom_control_label" for="title"> 제목 </label>
                <div class="col-sm-11">
                    <input type="text" class="form-control modify_form_control" id="title" name="title" maxlength="100"  style="background: white; cursor: text" disabled>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-1 custom_text_align custom_control_label" for="content"> 내용 </label>
                <div class="col-sm-11">
                    <textarea class="form-control modify_form_control" rows="10" id="content" name="content" style="background: white; cursor: text" disabled></textarea>
                </div>
            </div>


            <div class="form-group">
                <label class="control-label col-sm-1 custom_text_align custom_control_label" > 파일 </label>

                <div class="col-sm-11">

                    <div class="col-sm-12 fl pd0">
                        <div class="panel panel-default">
                            <div class="panel-body pd10" style="min-height: 48px;">
                                <div class="fl" style="margin: 3px 0 0 0;">
                                    <span id="fileIcon" class="glyphicon glyphicon-save-file" style="display: none;"></span>
                                    <span id="reqFileName" class="modify_panel_title"  style="display: none;"></span>
                                    <span id="attachedFileLabel" class="modify_panel_title"/>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>

            <%-- HIDDEN VALUE --%>
            <input type="hidden" id="no" name="no" value="<c:out value='${DOCUMENT_NO}' default='' />" />
            <input type="hidden" id="fileName" name="fileName" value="" />
            <input type="hidden" id="filePath" name="filePath" value="" />
            <input type="hidden" id="fileSize" name="fileSize" value="" />

        </form>

        <div class="form-group">
            <div class="col-sm-12 pd0" align="right">
                <div class="">
                    <button type="button" class="btn btn-default" id="btnList">목록</button>

                </div>
            </div>
        </div>

    </div>
    </div>
</div>

<%-- Hidden Value --%>
<input type="hidden" id="classificationValue" name="classificationValue" value="" />


<%--
====================================================================================================
SCRIPT BEGIN
====================================================================================================
--%>


<script type="text/javascript">

    var TO_LIST = "/documents/documentsMain";
    var GET_PROC_URL = "<c:url value='/documents/getDocument' />";

    var CATEGORY_LIST_PROC_URL = "<c:url value='/commonCode/getCommonCode' />";
    var DOCUMENTS_CLASSIFICATION = "<%= Constants.DOCUMENTS_CLASSIFICATION %>";

    var INIT_MESSAGE = "파일 첨부는 1개 파일만 가능합니다.";
    var REQUEST_FILE;''
    var REQUEST_FILE_OBJECT;
    REQUEST_FILE_OBJECT = $('#reqFile');

     $(document).ready(function(){

         $('.custom_text_align').css('text-align', 'left');

         procGetDocument();

     });

 function procGetDocument() {
     procCallSpinner(SPINNER_SPIN_START);
     var no = ${DOCUMENT_NO};

     console.log("no : " + no);

     var param = {
         no : no
     }
     procCallAjax(GET_PROC_URL, param, procCallbackGetDocument);
 }

 var procCallbackGetDocument = function (data) {

     $("#title").val(data.info.title);
     $('#classificationValue').val(data.info.classificationValue);
     $("#content").val(data.info.content);

     procCallAjax(CATEGORY_LIST_PROC_URL + "/" + DOCUMENTS_CLASSIFICATION, null, procCallbackCategoryList);

     var fileName = data.info.fileName;
     var fileSize = data.info.fileSize;
     var filePath = data.info.filePath;

     $('#fileName').val(fileName);
     $('#filePath').val(filePath);
     $('#fileSize').val(fileSize);

     procSetFileLabel(fileName, fileSize, filePath);

     $('#fileIcon').attr('style', 'display: show;');

     $("#attachedFileLabel").text($('#reqFileName').text());
     $("#attachedFileLabel").html($('#reqFileName').html());

     procCallSpinner(SPINNER_SPIN_STOP);

 }


 // GET CATEGORY LIST CALLBACK
 var procCallbackCategoryList = function(data) {

     if (RESULT_STATUS_FAIL == data.RESULT) return false;

     var objSelectBox = $('#classification');
     var listLength = data.list.length;
     var htmlString = [];
     var classificationValue = $('#classificationValue').val();

     for (i = 0; i < listLength; i++) {
         if (classificationValue == data.list[i].value)
             objSelectBox.val(data.list[i].value);
     }

 };

/*
 function setAttachedFileSize(fs) {
     $("#fileSize").text(fs);

     var kb = 1024;
     var mb = 1048576;
     var byteUnit;
     var printUnit;

     if (fs > mb) {
         byteUnit = mb;
         printUnit = "mb";
     }
     else if (fs > kb) {
         byteUnit = kb;
         printUnit = "kb";
     }

     fileSize = Math.round(fs/byteUnit);
     $("#attachedFileSize").empty();
     $("#attachedFileSize").append("(" + fileSize + printUnit + ")");

 }*/

    // SET FILE LABEL
    var procSetFileLabel = function(reqFileName, reqOrgFileSize, reqFilePath) {
        if (null == reqFileName || '' == reqFileName) return false;

        var fileSize = procConvertFormatNumber(procCalculateFloor(parseInt(reqOrgFileSize) / 1024, 2));
        var fileName = reqFileName + " (" + fileSize + " KB)";

        $('#fileName').val(reqFileName);
        $('#fileSize').val(reqOrgFileSize);

        if ('<%= Constants.NONE_VALUE %>' != reqFilePath) {
            var linkHtml = '<a href="javascript:void(0);"  onclick="procDownload(\'' + reqFilePath + '\', \'' + reqFileName + '\')">' + fileName + '</a>';
            $('#reqFileName').html(linkHtml);

        } else {
            $('#reqFileName').text(fileName);
        }

        $('#reqFileLabel').text(fileName);
        $('#reqFileSize').text(fileSize);
        $('#fileDeleteButtonArea').show();

        // BIND :: BUTTON EVENT
        $("#btnDeleteFile").on("click", function() {
            procDeleteFileLabel();
        });

        var objBox = $('.custom-box');
        objBox.fadeOut('fast', function () {
            objBox.addClass('custom-selected-file');
            objBox.fadeIn('fast');
        });
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

</script>

<%--FILE UPLOAD--%>
<script type="text/javascript" src="<c:url value='/resources/js/fileUpload.js' />"></script>


<%--
====================================================================================================
SCRIPT END
====================================================================================================
--%>


<%@include file="../layout/bottom.jsp" %>
