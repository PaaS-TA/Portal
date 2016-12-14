<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../layout/top.jsp" %>
<%@include file="../layout/left.jsp" %>
<%@include file="../layout/alert.jsp" %>

<%--FILE UPLOAD--%>
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/fileUpload.css'/>">

<div id="boardViewArea">
    <div class="panel content-box col-sm-12 col-md-12 mt-5">
        <div class="col-sm-12 pt0">

            <c:set var="insertFlag" value="${INSERT_FLAG}"/>
            <c:set var="checkCudC" value="<%= Constants.CUD_C %>"/>
            <c:set var="checkCudU" value="<%= Constants.CUD_U %>"/>
            <c:set var="checkCudR" value="<%= Constants.CUD_R %>"/>

            <c:choose>
                <c:when test="${insertFlag eq checkCudC}">
                    <h4 class="modify_h4 fwb"> 커뮤니티 새 글 등록 </h4>
                </c:when>
                <c:when test="${insertFlag eq checkCudU}">
                    <h4 class="modify_h4 fwb"> 커뮤니티 글 상세 </h4>
                </c:when>
                <c:when test="${insertFlag eq checkCudR}">
                    <h4 class="modify_h4 fwb"> 커뮤니티 답글 등록 </h4>
                </c:when>
            </c:choose>
        </div>

        <div class="panel content-box col-sm-12 col-md-12">
            <form id="boardForm" name="boardForm" class="form-horizontal" role="form">

                <%--<c:when test="${insertFlag ne checkCudC}">--%>

                <c:choose>
                    <c:when test="${insertFlag eq checkCudU}">
                        <div class="form-group">
                            <div class="col-sm-8 mt15" style="margin-left:8.5%;">

                                <table class="table table-bordered">
                                    <tr>
                                        <td style="background-color:#fbfaf9;">
                                            <div align="center">
                                                <div>
                                                    <span style="font-size: 15px;">NO</span>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div align="center">
                                                <div>
                                                    <span id="boardNoView" name="boardNoView"></span>
                                                </div>
                                            </div>
                                        </td>
                                        <td style="background-color:#fbfaf9;">
                                            <div align="center">
                                                <div>
                                                    <span style="font-size: 15px;">작성자</span>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div align="center">
                                                <div>
                                                    <span id="userId" name="userId"></span>
                                                </div>
                                            </div>
                                        </td>
                                        <td style="background-color:#fbfaf9;">
                                            <div align="center">
                                                <div>
                                                    <span style="font-size: 15px;">게시일</span>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div align="center">
                                                <div>
                                                    <span id="created" name="created"></span>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="col-sm-2 tar fr mt25">
                            <span style="font-weight: bold; color: gray; font-size: large; display: none;"
                                  id="beforeEdit">
                                <span id="boardModify" style="cursor: pointer; "> <button type="button"
                                                                                          class="btn btn-point btn-sm">수정</button></span>
                                <span id="boardDelete" style="cursor: pointer; "><button type="button"
                                                                                         class="btn btn-cancel btn-sm">삭제</button></span>
                            </span>
                                <span style="font-weight: bold; color: gray; font-size: large; display: none;"
                                      id="afterEdit">
                                <span id="modifySave" style="cursor: pointer; "><button type="button"
                                                                                        class="btn btn-point btn-sm"
                                                                                        style="display:none;">저장</button></span>
                                <span id="modifyCancel" style="cursor: pointer; "><button type="button"
                                                                                          class="btn btn-cancel btn-sm"
                                                                                          style="display:none;">취소</button></span>
                            </span>
                            </div>
                        </div>

                    </c:when>
                </c:choose>

                <div class="form-group">
                    <label class="control-label col-sm-1"> 제목 </label>
                    <div class="col-sm-11">
                        <input type="text" class="form-control modify_form_control toCheckString" id="title"
                               name="title" maxlength="100" style="background: white; cursor: text"
                               onkeypress="if(event.keyCode=='13') return false;">
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-1" for="content"> 내용 </label>
                    <div class="col-sm-11">
                        <textarea class="form-control modify_form_control" rows="10" id="content" name="content"
                                  style="background: white; cursor: text"></textarea>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-1"> 파일 </label>

                    <div class="col-sm-11">
                        <div id="fileEdit">

                            <%-- File Drag & Drop --%>
                            <div id="reqFileArea" class="custom-container fl" role="main">
                                <div class="custom-box">
                                    <div class="">
                                        <svg class="custom-box-icon" xmlns="http://www.w3.org/2000/svg" width="50"
                                             height="43" viewBox="0 0 50 43">
                                            <path d="M48.4 26.5c-.9 0-1.7.7-1.7 1.7v11.6h-43.3v-11.6c0-.9-.7-1.7-1.7-1.7s-1.7.7-1.7 1.7v13.2c0 .9.7 1.7 1.7 1.7h46.7c.9 0 1.7-.7 1.7-1.7v-13.2c0-1-.7-1.7-1.7-1.7zm-24.5 6.1c.3.3.8.5 1.2.5.4 0 .9-.2 1.2-.5l10-11.6c.7-.7.7-1.7 0-2.4s-1.7-.7-2.4 0l-7.1 8.3v-25.3c0-.9-.7-1.7-1.7-1.7s-1.7.7-1.7 1.7v25.3l-7.1-8.3c-.7-.7-1.7-.7-2.4 0s-.7 1.7 0 2.4l10 11.6z"></path>
                                        </svg>
                                        <div id="reqFileLabel" class="req_file_label"><strong> Choose a
                                            file </strong><span class="custom-box-dragndrop"> or drag it here. </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="fl">
                                <label for="reqFile" class="sr-only"> FILE </label>
                                <input type="file" name="files[]" id="reqFile" class="req_file_object">
                            </div>


                            <%-- File Delete & upload --%>
                            <div class="col-sm-12 fl pd0">
                                <div class="panel panel-default">
                                    <div class="panel-body pd10" style="min-height: 48px;">
                                        <div class="fl" style="margin: 3px 0 0 0;">
                                            <span id="reqFileName"
                                                  class="modify_panel_title"> 파일 첨부는 1개 파일만 가능합니다. </span>
                                        </div>
                                        <div id="fileDeleteButtonArea" class="ml10 fl" style="display: none;">
                                            <button type="button" id="btnDeleteFile" class="btn btn-save"> 첨부파일 삭제
                                            </button>
                                        </div>
                                        <div class="fr">
                                            <button type="button" id="btnFileSearch" class="btn fr">
                                                <span class="glyphicon glyphicon-folder-open"></span>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <%-- File Message & Size --%>
                            <div class="col-sm-12 fl mb10 pd0">
                                <div class="fl">
                                    <span class="glyphicon glyphicon-info-sign modify_span_size custom_color_warning"></span><span
                                        class="modify_span_size custom_color_warning"> 하위 버전(IE9 이하)의 브라우저는 Drag & Drop 기능을 지원하지 않습니다. </span>
                                </div>
                                <div class="fr">
                                    (<span id="reqFileSize" class="modify_span_size"> 0 </span> KB
                                    / <%= Constants.MY_QUESTION_LIMIT_FILE_SIZE_MB %> MB)
                                </div>
                            </div>
                        </div>
                        <%-- fileEdit END--%>


                        <div id="fileView">
                            <div class="col-sm-12 fl pd0">
                                <div class="panel panel-default">
                                    <div class="panel-body pd10" style="min-height: 48px;">
                                        <div class="fl" style="margin: 3px 0 0 0;">
                                            <span id="fileIcon" class="glyphicon glyphicon-file"
                                                  style="display: none;"></span>
                                            <span id="attachedFileLabel" class="modify_panel_title"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
                <%-- File Area END --%>

                <%-- HIDDEN VALUE --%>
                <input type="hidden" id="no" name="no" value="<c:out value='${BOARD_NO}' default='' />"/>
                <input type="hidden" id="fileName" name="fileName" value=""/>
                <input type="hidden" id="filePath" name="filePath" value=""/>
                <input type="hidden" id="fileSize" name="fileSize" value=""/>
                <input type="hidden" id="orgFileName" name="orgFileName" value=""/>
                <input type="hidden" id="orgFilePath" name="orgFilePath" value=""/>
                <input type="hidden" id="orgFileSize" name="orgFileSize" value=""/>

            </form>

            <div class="form-group">
                <div class="col-sm-12 pd0" align="right">
                    <div class="">
                        <c:choose>
                            <c:when test="${insertFlag eq checkCudU}">
                                <button type="button" class="btn btn-orange btn-sm" id="btnReply">답변쓰기</button>
                                <button type="button" class="btn btn-cancel btn-sm" id="btnList">목록</button>
                            </c:when>
                            <c:otherwise>
                                <button type="button" class="btn btn-orange btn-sm" id="btnSave"
                                        style="margin-top: 0px">등록
                                </button>
                                <button type="button" class="btn btn-save  btn-sm" id="btnList" style="margin-top: 0px">
                                    취소
                                </button>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>


            <c:choose>
                <c:when test="${insertFlag eq checkCudU}">
                    <%-- COMMENT AREA --%>
                    <div id="boardCommentViewArea">
                        <div class="form-group col-sm-12 mt20">
                            <hr>
                            <div class="col-sm-12 pt10">
                                <label class="control-label col-sm-1"> 댓글 </label>
                                <span class="glyphicon glyphicon-chevron-down" id="commentDown"
                                      style="cursor: pointer;"></span>
                                <span class="glyphicon glyphicon-chevron-up" id="commentUp"
                                      style="cursor: pointer;"></span>
                            </div>
                        </div>


                        <form id="commentForm" name="commentForm" class="form-horizontal" role="form">
                                <%-- Comment Area --%>
                            <div id="commentArea">
                                    <%-- Comment List --%>
                                <div class="col-sm-12">
                                    <table class="table table-hover t1" border="0" frame="void">
                                        <tbody id="boardCommentList">
                                        </tbody>
                                    </table>
                                </div>
                                <div id="hiddenPosition"></div>
                                    <%-- Comment Input --%>
                                <div class="col-sm-11" style="padding-right: 10px;">
                                    <textarea class="form-control modify_form_control" rows="3" id="commentContent"
                                              name="content"
                                              style="background: white; cursor: text; height: 50px; "></textarea>
                                </div>
                                <div class="col-sm-1" style="padding-left: 0px;">
                                    <button type="button" class="btn btn-cancel btn-sm" id="btnNewCommentSave"
                                            style="height: 50px; margin-top: 0px;">댓글등록
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>

                </c:when>
            </c:choose>


        </div>
        <%-- board box END --%>
    </div>
    <%-- div "form-group custom-search-form" END --%>
</div> <%-- boardViewArea END--%>


<%-- 댓글 reply & modify  area --%>
<div class="col-sm-12" id="commentReplyBox" style="display: none; background: white">

</div>

<%--------------------------------------- Hidden Value -----------------------------------------------%>
<%-- insertFlag --%>
<input type="hidden" id="insertFlag" name="insertFlag" value="<c:out value='${INSERT_FLAG}' default='' />"/>

<%-- board hidden value --%>
<form id="boardHiddenForm">
    <input type="hidden" id="boardNo" name="boardNo" value="<c:out value='${BOARD_NO}' default='' />"/>
    <input type="hidden" id="groupNo" name="groupNo" value="<c:out value='${GROUP_NO}' default='' />"/>
    <input type="hidden" id="parentNo" name="parentNo" value="<c:out value='${PARENT_NO}' default='' />"/>
</form>

<%-- board comment value --%>
<input type="hidden" id="boardCommentNo" name="boardCommentNo" value=""/>
<input type="hidden" id="boardCommentGroupNo" name="boardCommentGroupNo" value=""/>
<input type="hidden" id="boardCommentParentNo" name="boardCommentParentNo" value=""/>
<textarea style="display: none;" id="boardCommentContent" name="boardCommentContent" value=""></textarea>

<%-- get this user --%>
<input type="hidden" id="thisUserId" value='<sec:authentication property="principal.username" />'/>
<%--<input type="hidden" id="thisGetUserId" value=''/>--%>


<%--
====================================================================================================
SCRIPT BEGIN
====================================================================================================
--%>


<script type="text/javascript">

    /* Board */
    var INSERT_FLAG = "<c:out value='${INSERT_FLAG}' default='' />";
    var TO_LIST = "/board/boardMain";

    var GET_PROC_URL = "<c:url value='/board/getBoard' />";
    var CATEGORY_LIST_PROC_URL = "<c:url value='/commonCode/getCommonCode' />";

    var INSERT_PROC_URL = "<c:url value='/board/insertBoard' />";
    var UPDATE_PROC_URL = "<c:url value='/board/updateBoard' />";
    var DELETE_PROC_URL = "<c:url value='/board/deleteBoard' />";
    var GET_REPLY_NUM_PROC_URL = "<c:url value='/board/getReplyNum' />";

    var UPLOAD_FILE_PROC_URL = "<c:url value='/board/uploadFile'/>";
    var DELETE_FILE_PROC_URL = "<c:url value='/board/deleteFile'/>";

    var BOARD_REPLY_FORM_URL = "<c:url value='/board/boardMain/reply' />";

    var CUD_U = "<%= Constants.CUD_U%>";
    var CUD_C = "<%= Constants.CUD_C%>";
    var CUD_R = "<%= Constants.CUD_R%>";

    var DELETE_MESSAGE = "<spring:message code='common.info.popup.delete.message' />";

    var INIT_MESSAGE = "파일 첨부는 1개 파일만 가능합니다.";
    var REQUEST_FILE;
    var REQUEST_FILE_OBJECT;
    REQUEST_FILE_OBJECT = $('#reqFile');


    /* Board Comment */
    var GET_BOARD_COMMENT_LIST_PROC_URL = "<c:url value='/board/getBoardCommentList' />";
    var INSERT_BOARD_COMMENT_PROC_URL = "<c:url value='/board/insertBoardComment' />";
    var UPDATE_BOARD_COMMENT_PROC_URL = "<c:url value='/board/updateBoardComment' />";
    var DELETE_BOARD_COMMENT_PROC_URL = "<c:url value='/board/deleteBoardComment' />";
    var GET_COMMENT_REPLY_NUM_PROC_URL = "<c:url value='/board/getCommentReplyNum' />";

    var THIS_USER = '';

    var replyNum;

    /************************************************************************************/

    $(document).ready(function () {

        console.log("thisUser ::: " + $('#thisUserId').val());
        THIS_USER = $('#thisUserId').val();

        var no = ${BOARD_NO};

        $("#boardNo").val(${BOARD_NO});
        $("#groupNo").val(${GROUP_NO});
        $("#parentNo").val(${PARENT_NO});

        $("#beforeEdit").hide();
        $("#afterEdit").hide();

        $("#fileEdit").hide();
        $("#fileView").hide();

        $('.custom_text_align').css('text-align', 'left');

        procCallSpinner(SPINNER_SPIN_START);
        if (INSERT_FLAG == CUD_U) {

            //    procCallSpinner(SPINNER_SPIN_START);
            procGetBoard();
            procGetBoardComment();

            $("#commentUp").hide();
            $("#commentArea").show();


        } else if (INSERT_FLAG == CUD_R) {

            procGetContent();

        } else if (INSERT_FLAG == CUD_C) {

            $("#fileEdit").show();
            procCallSpinner(SPINNER_SPIN_STOP);
        }

    });


    function procGetContent() {
        var no = ${PARENT_NO};

        var param = {
            no: no
        }
        procCallAjax(GET_PROC_URL, param, procCallbackGetContent);
    }

    var procCallbackGetContent = function (data) {
        var replyContent = "\r\n" +
                "\r\n" +
                "\r\n" +
                "-------------------------------------------------------------------------------------------------------" +
                "\r\n" +
                "\r\n" +
                data.info.content;


        $("#content").val(replyContent);

        $("#fileView").hide();
        $("#fileEdit").show();

        procCallSpinner(SPINNER_SPIN_STOP);

    }

    /*************************************** Comment */

    $('#commentDown').click(function () {

        $('#commentArea').slideToggle('slow', function () {

            $("#commentDown").hide();
            $("#commentUp").show();
            $("#commentArea").hide();

        });
    });

    $('#commentUp').click(function () {
        $("#commentUp").hide();
        $("#commentDown").show();
        $('#commentArea').slideToggle('slow', function () {
            $("#commentArea").show();
        });
    });


    function procGetBoardComment() {
        var boardNo = ${BOARD_NO};
        var param = {
            boardNo: boardNo
        }
        procCallAjax(GET_BOARD_COMMENT_LIST_PROC_URL, param, procCallbackGetBoardComment);
    }

    var procCallbackGetBoardComment = function (data) {
        //    var objTable = $("#boardCommentList");
        //    var htmlString = [];
        var getList = data.list;

        //    objTable.empty();
        //    objTable.html('');

        for (var i = 0; i < getList.length; i++) {

            if (getList[i] != undefined) {

                var thisBlank_info = "";
                var textIndent = 10;

                if (getList[i].level > 0) { // level == depth, 0: 원글, 1~: 답글
                    textIndent = getList[i].level * 30;
                    thisBlank_info = thisBlank_info + "└ ";
                }

                $("#boardCommentList").append(
                        "<tr style='border-left: none; border-right: none; '>"
                        + "<td style='padding-left: " + textIndent + "px; border-left: 0px solid; border-right: 0px solid; '>"
                        + thisBlank_info + "<span style='color:gray; font-size: small; '>" + getList[i].userId + "　　　　" + getList[i].created.substring(0, 19) + "</span>"
                        + "<br style='padding-bottom: 10px'>"
                        + "<span id='commentContentView'>" + getList[i].content + "</span>"
                        + "</td>"

                        + "<td  style='width: 18%; border-left: none; border-right: none; '>"
                        + "<span id='commentEditArea" + i + "' >"
                        + "<span style='cursor: pointer;' onclick='procCommentModify(" + getList[i].no + ",\"" + getList[i].content + "\")'><button type=\"button\" class=\"btn btn-point btn-sm\">수정</button></span>" + " " + "<span  style='cursor: pointer;' onclick='procCommentDelete(" + getList[i].no + "," + getList[i].replyNum + ")'><button type=\"button\" class=\"btn btn-cancel btn-sm\">삭제</button></span> "
                        + "<span id='replySpan' style='cursor: pointer;' onclick='commentReply(" + getList[i].no + "," + getList[i].parentNo + "," + getList[i].groupNo + ")'><button type=\"button\" class=\"btn btn-orange btn-sm\">댓글</button></span> "
                        + "</span>"
                        + ""
                        + " </td>"

                        + "</tr>"
                );

                //console.log("getList[i].userId ::: " + getList[i].userId);
                //console.log("THIS_USER ::: " + THIS_USER);


                if (getList[i].userId != THIS_USER) {
                    $('#commentEditArea' + i).attr('style', 'display: none;');
                }
            }
        }

        //     objTable.append(htmlString);

        console.log("# procGetBoardComment - SPINNER_SPIN_STOP");
        procCallSpinner(SPINNER_SPIN_STOP);

    }


    // SAVE
    var procNewCommentSave = function () {
        console.log("CHECK ::::: procNewCommentSave #1");

        if ($("#commentContent").val().trim() == '') {
            $("#commentContent").focus();
            return false;
        }

        procCallSpinner(SPINNER_SPIN_START);
        procCommentInsert({RESULT: RESULT_STATUS_SUCCESS, path: '<%= Constants.NONE_VALUE %>'});

        console.log("CHECK ::::: procNewCommentSave #2");

    };

    // INSERT
    var procCommentInsert = function (data) {
        console.log("procInsert ###  #1");

        var boardNo = ${BOARD_NO};
        var commentContent = $("#commentContent").val().trim();

        var param = {
            content: commentContent,
            boardNo: boardNo,
            parentNo: -1,
            groupNo: -1

        }

        procCallAjax(INSERT_BOARD_COMMENT_PROC_URL, param, procCallbackCommentInsert);
        console.log("procInsert ###  #3 end");
    };


    // INSERT COMMENT CALLBACK
    var procCallbackCommentInsert = function (data) {

        if (RESULT_STATUS_SUCCESS == data.RESULT) {
            showAlert("success", '<spring:message code="common.info.result.success" />');

            refreshCommentList();

            $("#commentContent").val('');
            $("#commentReplyContent").val('');
            $("#commentReplyContent").empty();


        } else {
            //   procCallSpinner(SPINNER_SPIN_STOP);
            showAlert("fail", data.RESULT_MESSAGE);

        }
    };

    function refreshCommentList() {
        $("#boardCommentList").empty();
        procGetBoardComment();
    }

    /******************************** Board */


    function procGetBoard() {

        var no = ${BOARD_NO};

        var param = {
            no: no
        }
        procCallAjax(GET_PROC_URL, param, procCallbackGetBoard);
    }

    var procCallbackGetBoard = function (data) {
        $("#title").attr('disabled', 'disabled');
        $("#content").attr('disabled', 'disabled');

        if ($('#thisUserId').val() == data.info.userId) {
            $("#beforeEdit").show();
            $("#fileView").show();
        }

        replyNum = data.info.replyNum;


        $("#boardNoView").text(${BOARD_NO});

        $("#userId").text(data.info.userId);
        $("#created").text(data.info.created.substring(0, 19));
        $("#title").val(data.info.title);
        $("#content").val(data.info.content);

        var fileName = data.info.fileName;
        var fileSize = data.info.fileSize;
        var filePath = data.info.filePath;

        if ('' != fileName) {
            var filePath = data.info.filePath;
            var fileSize = data.info.fileSize;

            $('#fileName').val(fileName);
            $('#filePath').val(filePath);
            $('#fileSize').val(fileSize);
            $('#orgFileName').val(fileName);
            $('#orgFilePath').val(filePath);
            $('#orgFileSize').val(fileSize);

            procSetFileLabel(fileName, fileSize, filePath);

            $('#fileIcon').attr('style', 'display: show;');

            $("#attachedFileLabel").text($('#reqFileName').text());
            $("#attachedFileLabel").html($('#reqFileName').html());

        } else {

            $("#attachedFileLabel").text("첨부파일없음");

        }

        procSetCompleteView();

        procCallSpinner(SPINNER_SPIN_STOP);

    }


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

        fileSize = Math.round(fs / byteUnit);
        $("#attachedFileSize").empty();
        $("#attachedFileSize").append("(" + fileSize + printUnit + ")");

    }


    // SAVE
    var procSave = function () {
        if (!procCheckValidStringSpace()) return false;
        //    return false;
        if (!procCheckValid()) return false;

        procCallSpinner(SPINNER_SPIN_START);

        //    console.log("formData " + formData);
        var formData = getFileFormData();
        //    console.log("formData " + formData);


        if (!formData) {
            //   console.log("file nono" + formData);
            procInsert({RESULT: RESULT_STATUS_SUCCESS, path: '<%= Constants.NONE_VALUE %>'});
        } else {
            //    console.log("file yes " + formData);
            procUploadFile(formData, UPLOAD_FILE_PROC_URL, procInsert);
        }
    };


    // CHECK VALID
    var procCheckValid = function () {
//        var reqTitle = $('#title');
        var reqContent = $('#content');

        <%--if (reqTitle.val() == '') {--%>
        <%--showAlert("fail", '<spring:message code="common.info.empty.req.data" />');--%>
        <%--reqTitle.focus();--%>
        <%--return false;--%>
        <%--}--%>

        if (reqContent.val() == '') {
            showAlert("fail", INFO_EMPTY_REQUEST_DATA);
            //showAlert("fail", '<spring:message code="common.info.empty.req.data" />');
            reqContent.focus();
            return false;
        }

        return true;
    };


    // INSERT
    var procInsert = function (data) {
        console.log("procInsert #### 1");
        if (RESULT_STATUS_SUCCESS != data.RESULT) {
            showAlert("fail", data.RESULT_MESSAGE);

            //   procCallSpinner(SPINNER_SPIN_STOP);
            return false;
        }
        console.log("procInsert #### 2");

        var resultPath = data.path;
        if ('<%= Constants.NONE_VALUE %>' != resultPath) $("#filePath").val(resultPath);

        console.log("procInsert #### 3");

        var param = $("#boardForm").serializeObject();
        var param2 = $("#boardHiddenForm").serializeObject();
        $.extend(param, param2);

        var insertFlag = $('#insertFlag').val();

        console.log("procInsert #### 4");
        // INSERT
        if (CUD_C == insertFlag || CUD_R == insertFlag) {
            console.log("procInsert #### 5");
            procCallAjax(INSERT_PROC_URL, param, procCallbackInsert);
        }

        // UPDATE
        if (CUD_U == insertFlag) {
            console.log("procInsert #### 6");
            procCallAjax(UPDATE_PROC_URL, param, procCallbackUpdate);
        }
    };
    // INSERT CALLBACK
    var procCallbackInsert = function (data) {
        console.log("procCallbackInsert #### ");
        if (RESULT_STATUS_SUCCESS == data.RESULT) {
            showAlert("success", '<spring:message code="common.info.result.success" />');
            procMovePage(TO_LIST);

        } else {
            procCallSpinner(SPINNER_SPIN_STOP);
            showAlert("fail", data.RESULT_MESSAGE);
        }
    };
    // UPDATE CALLBACK
    var procCallbackUpdate = function (data) {
        console.log("procCallbackUpdate #### ");
        if (RESULT_STATUS_SUCCESS == data.RESULT) {
            // procDeleteFile();
            showAlert("success", '<spring:message code="common.info.result.success" />');

            procGetBoard();
            $("#fileEdit").hide();
            $("#fileView").show();

            $("#beforeEdit").show();
            $("#afterEdit").hide();

            $("#boardCommentViewArea").show();

        } else {
            procCallSpinner(SPINNER_SPIN_STOP);
            showAlert("fail", data.RESULT_MESSAGE);
        }
    };

    // DELETE FILE
    var procDeleteFile = function () {
        if (procDeleteFileCheckValid()) {
            var param = {filePath: $("#orgFilePath").val()};
            procCallAjax(DELETE_FILE_PROC_URL, param, procCallbackDeleteFile);

        } else {
            procMovePage(TO_LIST);
        }
    };

    // DELETE FILE CHECK VALID
    var procDeleteFileCheckValid = function () {
        var insertFlag = $('#insertFlag').val();
        var orgFilePath = $("#orgFilePath").val();
        var filePath = $("#filePath").val();

        return !("" != insertFlag && CUD_U == insertFlag && (orgFilePath == filePath || orgFilePath == "" || orgFilePath == null));
    };

    // DELETE
    var procDelete = function () {
        //    $('div.modal').modal('toggle');
        procCallSpinner(SPINNER_SPIN_START);
        procCallAjax(DELETE_PROC_URL, {no: $("#no").val()}, procCallbackDelete);
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
    // // DELETE FILE CALLBACK
    var procCallbackDeleteFile = function () {
        procMovePage(TO_LIST);
    };

    // SET FILE INFO
    var procSetFileInfo = function (reqFile) {
        var fileName = reqFile[0].name;
        var limitFileSizeMb = '<%= Constants.MY_QUESTION_LIMIT_FILE_SIZE_MB %>';
        var limitFileSize = parseInt(limitFileSizeMb) << 20;
        var orgFileSize = reqFile[0].size;

        if (limitFileSize < orgFileSize) {
            var alertMessage = '파일 크기는 ' + limitFileSizeMb + ' MB 를 넘을 수 없습니다.';
            showAlert("fail", alertMessage);
            window.scrollTo(0, 0);
            return false;

        } else {
            showAlert("success", '<spring:message code="common.system.welcome.message" />');
        }

        REQUEST_FILE = reqFile;

        procSetFileLabel(fileName, orgFileSize, '<%= Constants.NONE_VALUE %>');
    };

    // SET FILE LABEL
    var procSetFileLabel = function (reqFileName, reqOrgFileSize, reqFilePath) {

        if (null == reqFileName || '' == reqFileName) return false;

        var fileSize = procConvertFormatNumber(procCalculateFloor(parseInt(reqOrgFileSize) / 1024, 2));
        var fileName = reqFileName + " (" + fileSize + " KB)";

        $('#fileName').val(reqFileName);
        $('#fileSize').val(reqOrgFileSize);
        $('#fileName').text(reqFileName);
        $('#fileSize').text(reqOrgFileSize);

        if ('<%= Constants.NONE_VALUE %>' != reqFilePath) {
            var linkHtml = '<a href="javascript:void(0);"  onclick="procDownload(\'' + reqFilePath + '\', \'' + reqFileName + '\')">' + fileName + '</a>';
            // var linkHtml = '<a href="' + reqFilePath + '" target="_blank">' + fileName + '</a>';
            $('#reqFileName').html(linkHtml);

        } else {
            $('#reqFileName').text(fileName);
        }

        $('#reqFileLabel').text(fileName);
        $('#reqFileSize').text(fileSize);
        $('#fileDeleteButtonArea').show();

        // BIND :: BUTTON EVENT
        $("#btnDeleteFile").on("click", function () {
            procDeleteFileLabel();
        });

        var objBox = $('.custom-box');
        objBox.fadeOut('fast', function () {
            objBox.addClass('custom-selected-file');
            objBox.fadeIn('fast');
        });

        $("#filePath").val(reqFilePath);

        $("#attachedFileLabel").text(reqFileName);
        $("#attachedFileLabel").attr("style", "cursor:pointer");
        $("#attachedFileLink").attr("href", $("#filePath").val());
        setAttachedFileSize(reqOrgFileSize);


    };

    // DELETE FILE LABEL
    var procDeleteFileLabel = function () {
        var reqFileLabel = $('#reqFileLabel');
        var reqFileName = $('#reqFileName');
        var fileDeleteButtonArea = $('#fileDeleteButtonArea');

        fileDeleteButtonArea.hide();
        reqFileName.text(INIT_MESSAGE);

        var tempHtml = '<strong> Choose a file </strong><span class="custom-box-dragndrop"> or drag it here. </span>';
        reqFileLabel.html(tempHtml);

        $('#fileName').val('');
        $('#filePath').val('');
        $('#fileSize').val('');
        $('#reqFileSize').text('0');

        var objBox = $('.custom-box');
        objBox.fadeOut('fast', function () {
            objBox.removeClass('custom-selected-file');
            objBox.fadeIn('fast');
        });
    };


    /////////////////////////
    // SET COMPLETE VIEW
    var procSetCompleteView = function () {
        $('#boardViewArea').show();
        $('#custom_footer').show();

        $('#title').focus();
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

        $('.custom_text_align').css('text-align', 'left');
        $('#reqFileName').text(INIT_MESSAGE);

    };


    // BIND :: BUTTON EVENT
    $("#reqFileArea, #btnFileSearch").on("click", function () {
        REQUEST_FILE_OBJECT.click();
    });


    // BIND :: FILE CHANGE
    REQUEST_FILE_OBJECT.on("change", function () {
        procSetFileInfo($(this)[0].files);
    });


    // BIND :: BUTTON EVENT
    $("#btnSave").on("click", function () {
        procSave();
    });

    // BIND :: BUTTON EVENT
    $("#btnList").on("click", function () {
        procMovePage(TO_LIST);
    });

    // BIND :: BUTTON EVENT
    $("#btnReply").on("click", function () {

        var boardNo = $("#boardNo").val();
        var groupNo = $("#groupNo").val();

        var hiddenForm = $('#boardHiddenForm');
        $('#boardHiddenForm #boardNo').val(-1);
        $('#boardHiddenForm #groupNo').val(groupNo);
        $('#boardHiddenForm #parentNo').val(boardNo);

        hiddenForm.attr({action: BOARD_REPLY_FORM_URL, method: "GET"}).submit();


    });

    /********************************************************************************* Board ***/

    // 수정
    $("#boardModify").on("click", function () {
        console.log("boardModify click");

        $("#beforeEdit").hide();
        $("#afterEdit").show();

        $("#title").attr('disabled', false);
        $("#content").attr('disabled', false);
        $("#title").focus();


        $("#fileView").hide();
        $("#fileEdit").show();

        $("#boardCommentViewArea").hide();

    });

    // 삭제
    $("#boardDelete").on("click", function () {
        console.log("boardDelete click");
        procCallSpinner(SPINNER_SPIN_START);
        procCallbackGetReplyNum();

    });

    var procCallbackGetReplyNum = function () {
        procCallSpinner(SPINNER_SPIN_STOP);

        if (replyNum > 0) {

            var objButtonText = $('#modalExecuteBtn');

            $("#modalTitle").html('게시글');
            $("#modalText").html('답글이 있는 게시글은 삭제할 수 없습니다.');

            objButtonText.html('확인');
            objButtonText.attr('onclick', '$("#modal").modal("toggle");');

            $("#modalCancelBtn").hide();

            $('#modal').modal('toggle');


        } else {
            procPopup('게시글', DELETE_MESSAGE, 'procDelete();');

        }

    }
    // 저장
    $("#modifySave").on("click", function () {
        procSave();

    });
    // 취소
    $("#modifyCancel").on("click", function () {
        $("#title").attr('disabled', 'disabled');
        $("#content").attr('disabled', 'disabled');

        $("#afterEdit").hide();
        $("#beforeEdit").show();

        $("#fileView").show();
        $("#fileEdit").hide();

        $("#boardCommentViewArea").show();

    });
    /*************************************************************************** Comment *********/

//    // BIND :: BUTTON EVENT
    $("#btnNewCommentSave").on("click", function () {
        procNewCommentSave();
    });

    function procCommentModify(reqNo, reqContent) {

        var objButtonText = $('#modalExecuteBtn');
        var commentReplyBox = $('#commentReplyBox');
        var htmlString = [];

        htmlString.push("<div class='col-sm-12' >"
                + "<textarea class='form-control modify_form_control' rows='3' id='commentContentModify' style='background: white; cursor: text;  ' >" + reqContent + "</textarea>"
                + "</div>"
                + "<br><br><br><br>"
        );
        commentReplyBox.append(htmlString);

        $("#modalTitle").html('댓글 수정');
        $("#modalText").html(commentReplyBox.children());


        reqContent = $("#commentContentModify").val();

        $("#boardCommentNo").val(reqNo);
        $("#boardCommentContent").val(reqContent);

        objButtonText.html('저장');
        objButtonText.attr('onclick', 'procBeforeModify();');
        //objButtonText.attr('onclick', '$("#boardCommentContent").val($("#commentContentModify").val()); procDoModify();');

        $('#modal').modal('toggle');


    }

    function procBeforeModify() {
        console.log("procBeforeModify : " + $("#commentContentModify").val().trim() + "");

        if ($("#commentContentModify").val().trim() == '') {
            $("#commentContentModify").focus();
            return false;
        }

        $("#boardCommentContent").val($("#commentContentModify").val());
        procDoModify();

    }

    function procDoModify() {

        $('#modal').modal('toggle');

        var reqNo = $("#boardCommentNo").val();
        var reqContent = $("#boardCommentContent").val().trim();

        console.log("reqContent : " + reqContent + "###");
        //console.log("========================");
        //console.log("reqContent : " + reqContent.trim() + "###");


        var param = {
            no: reqNo,
            content: reqContent
        }

        procCallSpinner(SPINNER_SPIN_START);
        procCallAjax(UPDATE_BOARD_COMMENT_PROC_URL, param, procCallbackCommentUpdate);


    }
    var procCallbackCommentUpdate = function (data) {
        console.log("procCallbackCommentUpdate #1");

        if (RESULT_STATUS_SUCCESS == data.RESULT) {
            showAlert("success", '<spring:message code="common.info.result.success" />');

            refreshCommentList();

        } else {
            procCallSpinner(SPINNER_SPIN_STOP);
            showAlert("fail", data.RESULT_MESSAGE);
        }

    }

    function procGetCommentReplyNum(reqNo) {
        $("#boardCommentNo").val(reqNo);
        var param = {no: reqNo};
        procCallSpinner(SPINNER_SPIN_START);
        procCallAjax(GET_COMMENT_REPLY_NUM_PROC_URL, param, procCommentDelete);

    }

    function procCommentDelete(no, replyNum) {

        procCallSpinner(SPINNER_SPIN_STOP);

        if (replyNum > 0) { // level == depth, 0: 원글, 1~: 답글

            var objButtonText = $('#modalExecuteBtn');

            $("#modalTitle").html('댓글');
            $("#modalText").html('답 댓글이 있는 댓글은 삭제할 수 없습니다.');

            objButtonText.html('확인');
            objButtonText.attr('onclick', '$("#modal").modal("toggle");');

            $("#modalCancelBtn").hide();
            $('#modal').modal('toggle');


        } else {

            $("#modalCancelBtn").show();
            procPopup('댓글', DELETE_MESSAGE, 'procCallSpinner(SPINNER_SPIN_START); procCallAjax(DELETE_BOARD_COMMENT_PROC_URL, {no : ' + no + '}, procCallbackCommentDelete);');

        }
    }


    var procCallbackCommentDelete = function (data) {
        console.log("check ::: procCallbackCommentDelete");

        //$('#modal').modal('toggle');

        if (RESULT_STATUS_SUCCESS == data.RESULT) {
            showAlert("success", '<spring:message code="common.info.result.success" />');
            refreshCommentList();

        } else {
            procCallSpinner(SPINNER_SPIN_STOP);
            showAlert("fail", data.RESULT_MESSAGE);
        }

    }


    function commentReply(reqNo, reqParentNo, reqGroupNo) {

        var objButtonText = $('#modalExecuteBtn');
        var commentReplyBox = $('#commentReplyBox');
        var htmlString = [];

        htmlString.push("<div class='col-sm-12' >"
                + "<textarea class='form-control modify_form_control' rows='3' id='commentReplyContent' style='background: white; cursor: text;  '></textarea>"
                + "</div>"
                + "<br><br><br><br>"
        );
        commentReplyBox.append(htmlString);

        $("#modalTitle").html('답 댓글 쓰기');
        $("#modalText").html(commentReplyBox.children());

        objButtonText.html('등록');
        //objButtonText.attr('onclick', 'replySave();');
        objButtonText.attr('onclick', 'replySave();');

        $('#modal').modal('toggle');

        $("#boardCommentNo").val(reqNo);
        $("#boardCommentGroupNo").val(reqGroupNo);
        $("#boardCommentParentNo").val(reqParentNo);

    }


    function replySave() {

        var commentReplyContent = $("#commentReplyContent").val().trim();
        console.log("commentReplyContent :" + commentReplyContent + "##");

        if (commentReplyContent == '') {
            $("#commentReplyContent").focus();
            return false;
        }

        $('#modal').modal('toggle');


        var boardNo = ${BOARD_NO};
        var parentNo = $("#boardCommentNo").val();
        var groupNo = $("#boardCommentGroupNo").val();

        console.log("commentReplyContent " + commentReplyContent + "###");

        var param = {
            content: commentReplyContent,
            boardNo: boardNo,
            parentNo: parentNo,
            groupNo: groupNo

        };


        //procCallSpinner(SPINNER_SPIN_START);
        procCallAjax(INSERT_BOARD_COMMENT_PROC_URL, param, procCallbackCommentInsert);

    }//);


    // 저장
    $("#commentSave").on("click", function () {
        procSave();
    });

    /****************************************************************/


</script>

<%--FILE UPLOAD--%>
<script type="text/javascript" src="<c:url value='/resources/js/fileUpload.js' />"></script>


<%--
<%--
====================================================================================================
SCRIPT END
====================================================================================================
--%>


<%@include file="../layout/bottom.jsp" %>
