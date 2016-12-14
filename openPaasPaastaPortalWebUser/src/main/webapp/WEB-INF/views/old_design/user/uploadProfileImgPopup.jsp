<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--FILE UPLOAD--%>

<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/fileUpload.css'/>">

<div class="row">
    <div id="reqFileArea" class="custom-container fl" role="main">
        <div class="custom-box" id="dndBox">
            <div class="">
                <svg class="custom-box-icon" xmlns="http://www.w3.org/2000/svg" width="50" height="43" viewBox="0 0 50 43">
                    <path d="M48.4 26.5c-.9 0-1.7.7-1.7 1.7v11.6h-43.3v-11.6c0-.9-.7-1.7-1.7-1.7s-1.7.7-1.7 1.7v13.2c0 .9.7 1.7 1.7 1.7h46.7c.9 0 1.7-.7 1.7-1.7v-13.2c0-1-.7-1.7-1.7-1.7zm-24.5 6.1c.3.3.8.5 1.2.5.4 0 .9-.2 1.2-.5l10-11.6c.7-.7.7-1.7 0-2.4s-1.7-.7-2.4 0l-7.1 8.3v-25.3c0-.9-.7-1.7-1.7-1.7s-1.7.7-1.7 1.7v25.3l-7.1-8.3c-.7-.7-1.7-.7-2.4 0s-.7 1.7 0 2.4l10 11.6z"></path>
                </svg>
                <div id="reqFileLabel" class="req_file_label"><strong> Choose a file </strong><span class="custom-box-dragndrop"> or drag it here. </span></div>
                <div id="reqFileImgLabel" class="req_file_label" hidden><img class="circle" id="left_profileImagePath" src="" alt="Profile Image"/></div>
            </div>
        </div>
    </div>
    <div class="fl">
        <label for="reqFile" class="sr-only"> FILE </label>
        <input type="file" name="files[]" id="reqFile" class="req_file_object">
    </div>
    <div class="col-sm-12 fl pd0" >
        <div class="panel panel-default" hidden>
            <div class="panel-body pd10" style="min-height: 48px;" >
                <div class="fl" style="margin: 3px 0 0 0;">
                    <span id="reqFileName" class="modify_panel_title"> 파일 첨부는 1개 파일만 가능합니다. </span>
                </div>
                <div id="fileDeleteButtonArea" class="ml10 fl" style="display: none;">
                    <button type="button" id="btnDeleteFile" class="btn btn-save btn-sm"> 첨부파일 삭제 </button>
                </div>
                <div class="fr">
                    <button type="button" id="btnFileSearch" class="btn fr">
                        <span class="glyphicon glyphicon-folder-open"></span>
                    </button>
                </div>
            </div>
        </div>
    </div>
    <div class="col-sm-12 fl mb10 pd0">
        <div class="fl">
            <span class="glyphicon glyphicon-info-sign modify_span_size custom_color_warning"></span><span class="modify_span_size custom_color_warning"> 하위 버전(IE9 이하)의 브라우저는 Drag & Drop 기능을 지원하지 않습니다. </span>
        </div>
    </div>

</div>

<script>
    var FILE_SIZE_MB = 10;
    var NONE_VALUE = 'NONE';
    var REQUEST_FILE_OBJECT;
    var REQUEST_FILE;
    REQUEST_FILE_OBJECT = $('#reqFile');

    var setFileName = function(text) {
        $("#reqFileImgLabel").hide();

        $('#reqFileLabel').text(text);
        $('#reqFileLabel').show();

        var objBox = $('.custom-box');
        objBox.fadeOut('fast', function () {
            objBox.addClass('custom-selected-file');
            objBox.fadeIn('fast');
        });
    };

    var setFileImgLabel = function(path) {
        $("#reqFileLabel").hide();

        $('#reqFileImgLabel').attr("src", path);
        $('#reqFileImgLabel').show();
    };

    // SET FILE INFO
    var procSetFileInfo = function(reqFile) {
        var reqFileData = reqFile[0];
        var fileName = reqFileData.name;
        var limitFileSizeMb = FILE_SIZE_MB;
        var limitFileSize = parseInt(limitFileSizeMb) << 20;
        var orgFileSize = reqFileData.size;

        //var pathHeader = fileName.lastIndexOf("\\");
        var pathMiddle = fileName.lastIndexOf(".");
        var pathEnd = fileName.length;
        var ext = fileName.substring(pathMiddle + 1, pathEnd).toLowerCase();

        if (limitFileSize < orgFileSize) {
            var alertMessage = '파일 크기는 ' + limitFileSizeMb + ' MB 를 넘을 수 없습니다.';
            setFileName(alertMessage);
            disableModalExecuteBtn(true);
            return false;

        }

        if (ext != "jpg" && ext != "png" && ext != "gif") {
            setFileName('이미지 파일(jpg, png, gif)만 등록 가능합니다.');
            disableModalExecuteBtn(true);
            return false;
        }

        REQUEST_FILE = reqFile;
        setFileName(fileName);
        disableModalExecuteBtn(false);
    };

    // FILE FORM DATA
    var getFileFormData = function() {
        var reqFileObject = REQUEST_FILE;
        if (null == reqFileObject || undefined === reqFileObject) return false;

        var formData = new FormData();
        formData.append("file", reqFileObject[0]);

        return formData;
    };

    // UPLOAD PROFILE IMAGE
    var uploadProfileImage = function(callback) {
        var formData = getFileFormData();

        if (!formData) {
            alert("이미지를 선택해 주세요.");
        } else {
            uploadProfileImageAjax(formData, callback);
        }
    };

    <!-- ajax -->
    // UPLOAD IMAGE ajax
    var uploadProfileImageAjax = function(fromData, callback) {
        procCallSpinner(SPINNER_SPIN_START);
        $.ajax({
            url : "/user/uploadFile"
            , method : "POST"
            , processData : false
            , contentType : false
            , data : fromData
            , dataType : "json"
            , success : function(data){
                callback(data.path);
            }
            , error: function(xhr, status, error) {
            }
            , complete: function() {
                procCallSpinner(SPINNER_SPIN_STOP);
            }
        });
    };

    $(document).ready(function () {
        // BIND :: BUTTON EVENT
        $("#reqFileArea, #btnFileSearch").on("click", function() {
            REQUEST_FILE_OBJECT.click();
        });
        // BIND :: FILE CHANGE
        REQUEST_FILE_OBJECT.on("change", function() {
            procSetFileInfo($(this)[0].files);
        });


    });
</script>

<script type="text/javascript" src="<c:url value='/resources/js/fileUpload.js' />"></script>