<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ include file="../common/common.jsp"%>

<%--////////////////////////////////////////////////////////////////////////////////////////////////////--%>
<%--CODE :: BIGIN--%>
<%--////////////////////////////////////////////////////////////////////////////////////////////////////--%>

<%--INPUT FORM--%>
<div id="statusTitle" class="ml10 mb20">
<c:choose>
    <c:when test="${INSERT_FLAG eq Constants.CUD_U}">
        <h1>앱 템플릿 상세</h1>
    </c:when>
    <c:when test="${INSERT_FLAG eq Constants.CUD_C}">
        <h1>앱 템플릿 등록</h1>
    </c:when>
</c:choose>
</div>


<form class="form-horizontal" role="form" id="starterForm" name="starterForm">
    <input type="hidden" id="thumb_image_path" value="${thumb_image_path}">
    <div class="form-group">
        <label class="control-label col-sm-1" for="starterName">이름:</label>
        <div class="col-sm-10">
            <input type="text" maxlength="100" class="form-control toCheckString" id="starterName">
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-1" for="categoryList">분류:</label>
        <div class="col-sm-10">
            <select class="form-control" id="categoryList">
<%--                <option>분류 1</option>
                <option>분류 2</option>
                <option>분류 3</option>
                <option>분류 4</option>--%>
            </select>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-1" for="buildPackList">앱 개발환경:</label>
        <div class="col-sm-10">
            <select class="form-control" id="buildPackList">
                <%-- build pack area --%>
            </select>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-1" for="servicePackList">서비스:</label>
        <div class="col-sm-5" style="width: 37.5%">
            <select multiple class="form-control" id="servicePackList" name="servicePackList" style="height: 90px; line-height: 90px;">
                <%-- service pack area --%>
            </select>
        </div>

        <div class="col-sm-1" style="text-align: center; padding: 8px 0;">
            <div><input type="button" class="btn btn-default" onClick="SelectMoveRows(document.starterForm.servicePackList, document.starterForm.selectedServicePackList)" value=">" > </div>
            <div><input type="button" class="btn btn-default" onClick="SelectMoveRows(document.starterForm.selectedServicePackList, document.starterForm.servicePackList)" value="<" > </div>
        </div>

        <div class="col-sm-5" style="width: 37.5%">
            <select multiple class="form-control" id="selectedServicePackList" name="selectedServicePackList" style="height: 90px; line-height: 90px;">
                <%-- selected service pack area --%>
            </select>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-1" for="thumbnail">섬네일:<br>(50 * 50)</label>
        <div class="col-sm-10">
            <input type="file" class="filestyle" data-buttonName="btn-default btn-sm"  data-buttonText="파일 찾기" id="thumbnail" accept="image/png, image/jpeg, image/gif">
        </div>
        <div class="col-sm-10">
            <div id="divPreviewMessage" class="divPreviewMessage" style="display: none;">
            </div>
        </div>
        <div>
        <div class="col-sm-10">
            <div id="divPreview" class="divPreview">
                <div class="fl">
                    <a href="javascript:void(0);" class="custom-thumbnail">
                        <img id="preview" src="" alt="preview">
                    </a>
                </div>
                <div class="divImageInfo fl ml20">
                    <label id="labelThumbName"></label>
                    <button id="btnResetImg" type="button" class="btn btn-default ml5" aria-label="썸네일 지우기">
                        <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                    </button>
                </div>
            </div>
        </div>
        </div>

    </div>
    <div class="form-group">
        <label class="control-label col-sm-1" for="useYn">공개:</label>
        <div class="col-sm-10">
            <label class="radio-inline"><input type="radio" id="useYn" name="useYn" value="Y" checked="checked">Y</label>
            <label class="radio-inline"><input type="radio" name="useYn" value="N">N</label>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-1" for="summary">요약:</label>
        <div class="col-sm-10">
            <input type="text" maxlength="200" class="form-control toCheckString" id="summary">
        </div>

    </div>
    <div class="form-group">
        <label class="control-label col-sm-1" for="description">설명:</label>
        <div class="col-sm-10">
            <textarea class="form-control" rows="5" id="description"></textarea>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-offset-1 col-sm-10 " align="right" id = "statusActivity"> <%-- delete id --%>
            <div class="divButtons">
            <c:choose>
                <c:when test="${INSERT_FLAG eq CONSTANT_CUD}">
                    <button type="button" class="btn btn-danger fl" id="btnDelete">삭제</button>
                    <button type="button" class="btn btn-default" id="btnCancel">취소</button>
                    <button type="button" class="btn btn-success" id="btnRegist">저장</button>
                </c:when>
                <c:otherwise>
                    <button type="button" class="btn btn-default" id="btnCancel">취소</button>
                    <button type="button" class="btn btn-success" id="btnRegist">등록</button>
                </c:otherwise>
            </c:choose>
            </div>
        </div>
    </div>

    <input type="hidden" id="resInsertFlag" name="resInsertFlag" value="<c:out value='${INSERT_FLAG}' default='' />" />
    <input type="hidden" id="resCudU" name="resCudU" value="<c:out value='${CONSTANT_CUD}' default='' />" />

    <input type="hidden" id="oldThumbImgPath" name="oldThumbImgPath" value="" />

    <input type="hidden" id="thumbImgPath" name="thumbImgPath" value="" />
    <input type="hidden" id="thumbImgName" name="thumbImgName" value="" />
    <input type="hidden" id="no" name="no" value="<c:out value='${REQUEST_NO}' default='' />" />

</form>


<%--////////////////////////////////////////////////////////////////////////////////////////////////////--%>
<%--CODE :: END--%>
<%--////////////////////////////////////////////////////////////////////////////////////////////////////--%>

<%--FOOTER--%>
<%@ include file="../common/footer.jsp"%>

<%--
====================================================================================================
SCRIPT BEGIN
====================================================================================================
--%>

<script type="text/javascript">
    var CATEGORY_HOME_URL = "<c:url value='/catalog/catalogMain' />";
    var CATEGORY_LIST_PROC_URL = "<c:url value='/commonCode/getCommonCode' />";

    var INSERT_FLAG = "<c:out value='${INSERT_FLAG}' default='' />";
    var DELETE_FLAG = false;

    var STARTER_CATALOG_ID = "<%= Constants.STARTER_CATALOG_ID %>";

    var BUILD_PACK_NAMES_LIST_PROC_URL = "<c:url value='/catalog/getBuildPackNamesList' />";
    var SERVICE_PACK_NAMES_LIST_PROC_URL = "<c:url value='/catalog/getServicePackNamesList' />";

    var GET_PROC_URL = "<c:url value='/catalog/getOneStarterCatalog' />";
    var INSERT_PROC_URL = "<c:url value='/catalog/insertStarterCatalog' />";
    var DUPLICATED_PROC_URL = "<c:url value='/catalog/getStarterCatalogCount' />";
    var UPDATE_PROC_URL = "<c:url value='/catalog/updateStarterCatalog' />";
    var DELETE_PROC_URL = "<c:url value='/catalog/deleteStarterCatalog' />";

    var SAVED_NAME = null;
    var SAVED_THUMBNAIL_NAME = null;

    var IMAGE_UPLOAD_PROC_URL = "<c:url value='/catalog/uploadThumbnailImage'/>";
    var IMAGE_DELETE_PROC_URL = "<c:url value='/catalog/deleteThumbnailImage'/>";
    var MAX_SIZE = 500; // KB

    var RESULT_STATUS_SUCCESS = "SUCCESS";
    var RESULT_STATUS_FAIL = "FAIL";

    var buildPackCategoryNoFromDB;
    var servicePackCategoryNoListFromDB;





    /******************************************************************************************* CRUD -> **************/
    function insertStarter(data) {
        console.log("CHECK:: 08 or 12 :: insertStarter");

        var starterName = $("#starterName").val();
        var categoryList = $("#categoryList").val(); // classification
        var thumbpath = $("#thumbImgPath").val();
        var thumbname = $("#thumbImgName").val();
        var useYn = $("input[name=useYn]:checked").val();
        var summary = $("#summary").val();
        var description = $("#description").val();
        var buildPackList = $("#buildPackList").val(); // no

        var selectedServicePackList = [];
        var getList = document.getElementById("selectedServicePackList");
        for (var i = 0; i < getList.length; i++) {
            selectedServicePackList[i] = getList.options[i].value;
        }
//
//        console.log("thumbpath : " + thumbpath);
//        console.log("thumbname : " + thumbname);

        param = {
            name : starterName,
            classification : categoryList,
            thumbImgName : thumbname,
            thumbImgPath : thumbpath,
            useYn : useYn,
            summary : summary,
            description : description,
            buildPackCategoryNo : buildPackList,
            servicePackCategoryNoList : selectedServicePackList
        };

        procCallAjax(INSERT_PROC_URL, param, procCallbackCRUDStarterCatalog);

    }

    function updateStarter(data) {
        console.log("CHECK:: 08 or 12 :: updateStarter");

        var no = ${REQUEST_NO};

        var thumbpath = $("#thumbImgPath").val();
        var thumbname = $("#thumbImgName").val();

        var starterName = $("#starterName").val();
        var categoryList = $("#categoryList").val();
        var useYn = $("input[name=useYn]:checked").val();
        var summary = $("#summary").val();
        var description = $("#description").val();
        var buildPackList = $("#buildPackList").val();

        var selectedServicePackList = [];
        var getList = document.getElementById("selectedServicePackList");
        for (var i = 0; i < getList.length; i++) {
            selectedServicePackList[i] = getList.options[i].value;
        }

        param = {
            no : no,
            name : starterName,
            classification : categoryList,
            thumbImgName : thumbname,
            thumbImgPath : thumbpath,
            useYn : useYn,
            summary : summary,
            description : description,
            starterCategoryNo : no,
            buildPackCategoryNo : buildPackList,
            servicePackCategoryNoList : selectedServicePackList
        };

        procCallAjax(UPDATE_PROC_URL, param, procCallbackCRUDStarterCatalog);

    }

    function deleteStarter() {

/*        var no = ${REQUEST_NO};

        param = {
            no : no,
            starterCategoryNo : no
        }*/


        procDeleteFile();

//        procCallAjax(DELETE_PROC_URL, param, procCallbackCRUDStarterCatalog);

        /*if (confirm("삭제하시겠습니까?")!= 0) {

        }*/
    }

    var procCallbackCRUDStarterCatalog = function (data) { // CRUD 공동 사용중

        console.log("CHECK:: 08d/09i/13u - delete05:: procCallbackCRUDStarterCatalog");

        if (RESULT_STATUS_SUCCESS == data.RESULT) {

            procAlert("success", '<spring:message code="common.info.result.success" />'); // message api에서 입력안함
            procMovePage(CATEGORY_HOME_URL + "/<%= Constants.TAB_NAME_STARTER %>");

        } else if (RESULT_STATUS_FAIL == data.RESULT) {

            procAlert("danger", data.RESULT_MESSAGE);
        }
    }

    /******************************************************************************************* <- CRUD **************/

    // PROCESS CHECK VALID
    var procCheckValid = function() {
        console.log("CHECK:: 03 :: procCheckValid");

        var reqServicePack = [];
        var getList = document.getElementById("selectedServicePackList");
        for (var i = 0; i < getList.length; i++) {
            reqServicePack[i] = getList.options[i].value;
        }

        if (reqServicePack == '') {
            procAlert("warning", '<spring:message code="common.info.empty.req.data" />');
            $('#selectedServicePackList').focus();
            return false;
        }

        return true;
    };


    // PROCESS CHECK DUPLICATED NAME
    function procCheckDuplicatedName() {

        console.log("CHECK:: 02 :: procCheckDuplicatedName");

        if (!procCheckValidStringSpace()) return false;
        if (!procCheckValid()) return false; // 이름,요약 체크

        // name 바뀌었는지 체크

        var currentName = $("#starterName").val();
    //    console.log("SAVED_NAME : " + SAVED_NAME);
    //    console.log("currentName : " + currentName);


        if (SAVED_NAME != currentName) {    // 이름 변경 -> DB에 동일 이름 있는지 체크 후 -> 파일업로드체크
            console.log("CHECK:: 04 :: procCheckValid :: name check if :: before call duplicated_proc");

            var param = {name: $('#starterName').val()};

            procCallAjax(DUPLICATED_PROC_URL, param, procCallBackDuplicated);

        } else {                            // 이름 변경 없을 시 -> 파일업로드체크
            console.log("CHECK:: 04 :: procCheckValid :: name check else");
            console.log("CHECK:: 05 :: procCheckValid :: before checkFileUpload");

            checkFileUpload();
        }

    };

    var procCallBackDuplicated = function (data) {
        console.log("CHECK:: 05 :: procCallBackDuplicated ");
        if (data != -1 && RESULT_STATUS_SUCCESS != data.RESULT) { // db 중복 체크
            $('#starterName').focus();
            return false;
        } else { // 중복없음
            console.log("CHECK:: 05 :: procCheckValid :: before checkFileUpload");

            checkFileUpload();
        }


    }

    /************************************************************************************** file upload 관련 -> ******/

    function checkFileUpload() { // 파일 업로드 결정
        console.log("CHECK:: 06 :: checkFileUpload");

        var currentThumbImgName = $("#labelThumbName").text();

        console.log("check - current img name : " + currentThumbImgName);
        console.log("check - saved img name : " + SAVED_THUMBNAIL_NAME);

        if ("" != INSERT_FLAG && "<%= Constants.CUD_U %>" == INSERT_FLAG) { // UPDATE
            if (currentThumbImgName != '' && SAVED_THUMBNAIL_NAME != currentThumbImgName) {
                console.log("CHECK:: 07 :: checkFileUpload - ifif - update/imageO");
                // 이미지 변경이 있을시 : 삭제 - 파일 업로드 - 업데이트
                procDeleteFile();
            } else {
                console.log("CHECK:: 07 :: checkFileUpload - ifelse - update/imageX");
                // 이미지 변경 없을 시 : 이미지 업로드 없이 업데이트
                updateStarter();
            }
        }
        else { // INSERT
            if (currentThumbImgName != '') {
                console.log("CHECK:: 07 :: checkFileUpload - elseif - insert/imageO");
                // 이미지 업로드
                var formData = getFileFormData();
                if (formData != undefined) uploadFile(formData);
            } else {
                console.log("CHECK:: 07 :: checkFileUpload - elseelse - insert/imageX");
                // 이미지 없이 insert
                insertStarter();
            }

        }


    }
/*
     function decideCU() {
     console.log("CHECK:: 06 :: decideCU");

     // UPDATE
     if ("" != INSERT_FLAG && "<%= Constants.CUD_U %>" == INSERT_FLAG) {
     console.log("CHECK:: 07 :: decideCU :: IF (update)");
     updateStarter();

     }
     // INSERT
     else {
     console.log("CHECK:: 07 :: decideCU :: else (insert)");
     // call insert
     insertStarter();
     }

     }*/


    // FILE FORM DATA
    var getFileFormData = function() {
        var reqThumbnail = $("#thumbnail");
        if (reqThumbnail[0].files[0] === undefined) return undefined;

        var formData = new FormData();
        formData.append("file", reqThumbnail[0].files[0]);

        return formData;
    };

    // UPLOAD FILE
    var uploadFile = function(formData) {
        console.log("CHECK:: 08i or 09u :: uploadFile");
        $.ajax({
            url : IMAGE_UPLOAD_PROC_URL
            , method : "POST"
            , processData : false
            , contentType : false
            , data : formData
            , dataType : "json"
            , success : function(data){
                procCallbackUploadFile(data);
            },
            error: function(xhr, status, error) {
                procAlert("danger", JSON.parse(xhr.responseText).customMessage);

                console.log("ERROR :: data :: ", error);
            },
            complete : function(data) {
                console.log("COMPLETE :: data :: ", data);
            }
        });
    };

    // UPLOAD FILE CALLBACK
    var procCallbackUploadFile = function(data) {
        console.log("CHECK:: 10 :: procCallbackUploadFile");
        if (RESULT_STATUS_SUCCESS == data.RESULT) {
            console.log("CHECK:: 11 :: success uploadFile");

            $("#thumbImgPath").val(data.path);
            $("#thumbImgName").val($("#labelThumbName").text());

            console.log("th path : " + $("#thumbImgPath").val());
            console.log("th name : " + $("#thumbImgName").val());

            // UPDATE
            if ("" != INSERT_FLAG && "<%= Constants.CUD_U %>" == INSERT_FLAG) {
                updateStarter();
            }
            // INSERT
            else {
                insertStarter();
            }



                console.log("interrupt" + interrr);

         //   procMovePage(CATEGORY_HOME_URL + "/<%= Constants.TAB_NAME_STARTER %>");

            //console.log("CHECK:: 08 :: procCallbackUploadFile :: before decideCU");
         //   decideCU();

        } else if (RESULT_STATUS_FAIL == data.RESULT) {
            procAlert("danger", data.RESULT_MESSAGE);
        }
    };

    // PREVIEW
    var setPreView = function(objThumbnail) {
        var this_form = objThumbnail[0];
        var file    = this_form.files[0];
        var preview = $('#preview');
//        var reader  = new FileReader();
        var img_size = 0;

        if (file) {
            // image file check
            var pathHeader = this_form.value.lastIndexOf("\\");
            var pathMiddle = this_form.value.lastIndexOf(".");
            var pathEnd = this_form.value.length;
            var filename = this_form.value.substring(pathHeader + 1, pathEnd);
            var ext = this_form.value.substring(pathMiddle + 1, pathEnd).toLowerCase();

            if (ext != "jpg" && ext != "png" && ext != "gif") {
                procAlert('info', '이미지 파일(jpg, png, gif)만 등록 가능합니다.');
                //jasny bootstrap fileinput을 이용함. 참고는 http://www.jasny.net/bootstrap/javascript/#fileinput 참조바람
                resetThumbnail();
                return false;
            }

            // file 읽어 오기
            var reader = new FileReader();

            reader.onload = function(e) {
                $('#divPreviewMessage').attr('style', 'display: none;');
                var image = new Image();
                // 파일의 내용을 읽어서 넣어준다.
                image.src = e.target.result;
                img_size = Math.round(e.total / 1024);
            };

            reader.onloadend = function (e) {
                if (img_size > MAX_SIZE) {
                    resetThumbnail();

                    var alertMessage = '이미지 크기는 ' + MAX_SIZE + 'Kb 를 넘을 수 없습니다.';
                    var divPreviewMessage = $("#divPreviewMessage");

                    divPreviewMessage.text(alertMessage);
                    divPreviewMessage.attr('style', 'display: block;');

                    procAlert('danger', alertMessage);

                    return false;
                }
                $('#divPreview').attr('style', 'display: block; height: 94px;');
                preview.attr("src", e.target.result);

                $("#labelThumbName").text(filename);

            };

            reader.readAsDataURL(file);

        } else {
            resetThumbnail();
        }
    };

    // RESET THUMBNAIL
    var resetThumbnail = function() {
        $('#thumbnail').filestyle('clear');
        $('#preview').attr('src', '');
        $("#labelThumbName").text('');

        $('#divPreview').attr('style', 'display: none;');
        $('#divPreviewMessage').attr('style', 'display: none;');

    };

    var procDeleteFile = function() {
        console.log("CHECK:: 08 - delete01:: procDeleteFile");

            var param = {
                thumbImgPath : $("#oldThumbImgPath").val()
            };

            procCallAjax(IMAGE_DELETE_PROC_URL, param, procCallbackDeleteFile);

    };

    var procCallbackDeleteFile = function() {

        //DELETE_FLAG = true
        console.log("CHECK:: 08 - delete02:: call back procDeleteFile");

        // DELETE
        if (DELETE_FLAG) {
            console.log("CHECK:: 08 - delete04:: delete : before delete");
            var no = ${REQUEST_NO};

            param = {
                no : no,
                starterCategoryNo : no
            }
            procCallAjax(DELETE_PROC_URL, param, procCallbackCRUDStarterCatalog);

        }
        // UPDATE
        else {// 삭제 후 새파일 업로드! // true check?
            console.log("CHECK:: 08 - delete03:: update : before new upload");

            var formData = getFileFormData();
            if (formData != undefined) uploadFile(formData);

        }


    };


    /************************************************************************************** <- file upload 관련 ******/




    /*******************/
    /* .ready function */
    /*******************/
    $(document.body).ready(function() {
        procAlert("info", WELCOME_MESSAGE);

        param = {

        };

        if (INSERT_FLAG == "<%= Constants.CUD_C %>") { // 등록

            buildPackCategoryNoFromDB = -1;
            servicePackCategoryNoListFromDB = null;

        //    setBuildPackCategoryNoFromDB(-1);
        //    setServicePackCategoryNoListFromDB(null);

            procCallAjax(BUILD_PACK_NAMES_LIST_PROC_URL, param, procCallbackGetBuildPackNamesList);
            procCallAjax(SERVICE_PACK_NAMES_LIST_PROC_URL, param, procCallbackGetServicePackNamesList);

            procCallAjax(CATEGORY_LIST_PROC_URL + "/" + STARTER_CATALOG_ID, null, procCallbackCategoryList);


        } else { // 상세

            var reqNo = ${REQUEST_NO};

            if (reqNo != -1) {
                param = {
                    no : reqNo
                }
                procCallAjax(GET_PROC_URL, param, procCallbackGetOneStarter);

            }
        }

        // init Thumbnail
        resetThumbnail();

        $("#thumbnail").on("change", function(){
            setPreView($(this));
        });

        // FILE UPLOADER RESIZE
    //    $('.form-control').attr('style', 'height: 35px;');


    });

    var procCallbackGetOneStarter = function (data) {

        SAVED_NAME = data.info.name;
        SAVED_THUMBNAIL_NAME = data.info.thumbImgName;
        DELETE_FLAG = false;

        $("#starterName").val(data.info.name);
        $("#categoryList").val(data.info.classification);
        $("#thumbImgName").val(data.info.thumbImgName);
        $("#thumbImgPath").val(data.info.thumbImgPath);

        $("#oldThumbImgPath").val(data.info.thumbImgPath);

        $('#divPreview').attr('style', 'display: block; height: 94px;');
        $('#preview').attr('src', $("#thumbImgPath").val());
        $("#labelThumbName").text($("#thumbImgName").val());

        var useYnValue = data.info.useYn;
        if (useYnValue == "Y") $("input:radio[name='useYn']:radio[value='Y']").attr("checked", true);
        else if (useYnValue == "N") $("input:radio[name='useYn']:radio[value='N']").attr("checked", true);

        $("#summary").val(data.info.summary);
        $("#description").val(data.info.description);

        buildPackCategoryNoFromDB = data.info.buildPackCategoryNo;
        servicePackCategoryNoListFromDB = data.info.servicePackCategoryNoList;

//        setBuildPackCategoryNoFromDB(data.info.buildPackCategoryNo);
//        setServicePackCategoryNoListFromDB(data.info.servicePackCategoryNoList);

        procCallAjax(BUILD_PACK_NAMES_LIST_PROC_URL, param, procCallbackGetBuildPackNamesList);
        procCallAjax(SERVICE_PACK_NAMES_LIST_PROC_URL, param, procCallbackGetServicePackNamesList);

        procCallAjax(CATEGORY_LIST_PROC_URL + "/" + STARTER_CATALOG_ID, null, procCallbackCategoryList);
    }

    var procCallbackGetBuildPackNamesList = function (data) {

        if (buildPackCategoryNoFromDB == -1) {  // 등록
            for (var i = 0; i < data.list.length; i ++) {
                $("#buildPackList").append("<option value='"+data.list[i].no+"'> "+data.list[i].name+" </option>");
            }
        }
        else {                                   // 상세
            for (var i = 0; i < data.list.length; i ++) {
                if (data.list[i].no == buildPackCategoryNoFromDB)
                    $("#buildPackList").append("<option value='"+data.list[i].no+"' selected='selected'> "+data.list[i].name+" </option>");
                else
                    $("#buildPackList").append("<option value='"+data.list[i].no+"'> "+data.list[i].name+" </option>");
            }
        }
    }

    var procCallbackGetServicePackNamesList = function (data) {
        console.log("procCallbackGetServicePackNamesList");
        console.log("servicePackCategoryNoListFromDB : " + servicePackCategoryNoListFromDB);
        console.log("nameslist data : " + data.list);
        console.log("data : " + data.list.length);

        if (servicePackCategoryNoListFromDB == null) { // 등록
            for (var i = 0; i < data.list.length; i ++) {
                $("#servicePackList").append("<option value='"+data.list[i].no+"'> "+data.list[i].name+" </option>");
            }
        }
        else { // 상세
            console.log("le" + servicePackCategoryNoListFromDB.length);
            for (var i = 0; i < servicePackCategoryNoListFromDB.length; i++) {
                console.log("list : " + servicePackCategoryNoListFromDB[i]);
            }

            for (var i = 0; i < data.list.length; i ++) {
       //         console.log("dataNo : " + data.list[i].no + "            name: " + data.list[i].name);
       //         console.log("if : " + servicePackCategoryNoListFromDB.includes(data.list[i].no));

                if (servicePackCategoryNoListFromDB.includes(data.list[i].no)) {
                    $("#selectedServicePackList").append("<option value='" + data.list[i].no + "'> " + data.list[i].name + " </option>");
                } else {
                    $("#servicePackList").append("<option value='" + data.list[i].no + "'> " + data.list[i].name + " </option>");
                }
            }

        }


    }

/*    // GET CATEGORY LIST
    var getCategoryList = function() {
        procCallAjax(CATEGORY_LIST_PROC_URL + "/" + STARTER_CATALOG_ID, null, procCallbackCategoryList);
    };*/

    // GET CATEGORY LIST CALLBACK
    var procCallbackCategoryList = function(data) {

        if (RESULT_STATUS_FAIL == data.RESULT) return false;

        var objSelectBox = $('#categoryList');
        var listLength = data.list.length;
        var htmlString = [];

        for (i = 0; i < listLength; i++) {
            htmlString.push("<option value='" + data.list[i].key + "'>" + data.list[i].value + "</option>");
        }

        objSelectBox.append(htmlString);


    };


    /************************************************************/
    /* service pack box moves 관련 (SelectMoveRows, SelectSort) */
    /************************************************************/
    function SelectMoveRows(SS1,SS2)
    {
        var SelID='';
        var SelText='';
        // Move rows from SS1 to SS2 from bottom to top
        for (i=SS1.options.length - 1; i>=0; i--)
        {
            if (SS1.options[i].selected == true)
            {
                SelID=SS1.options[i].value;
                SelText=SS1.options[i].text;
                var newRow = new Option(SelText,SelID);
                SS2.options[SS2.length]=newRow;
                SS1.options[i]=null;
            }
        }
        SelectSort(SS2);
    }
    function SelectSort(SelList)
    {
      /*  console.log("== sort");
        console.log("== sort length" + SelList.length);
        console.log("== sort text" + SelList[0].text);
        console.log("== sort value" + SelList[0].value);*/

        var ID='';
        var Text='';
        for (x=0; x < SelList.length - 1; x++)
        {
            for (y=x + 1; y < SelList.length; y++)
            {
                if (SelList[x].value > SelList[y].value)
                {
                    // Swap rows
                    ID=SelList[x].value;
                    Text=SelList[x].text;
                    SelList[x].value=SelList[y].value;
                    SelList[x].text=SelList[y].text;
                    SelList[y].value=ID;
                    SelList[y].text=Text;
                }
            }
        }
    }

    /***********/
    /* Buttons */
    /***********/
    // BIND :: BUTTON EVENT
    $("#btnRegist").on("click", function() {
        console.log("CHECK:: 01 :: btnRegist");

        // 이름 체크 -> 파일 체크 -> C/U 결정
        procCheckDuplicatedName();

    });

    // BIND :: BUTTON EVENT
    $("#btnCancel").on("click", function() {
        procMovePage(CATEGORY_HOME_URL + "/<%= Constants.TAB_NAME_STARTER %>");
    });

    // BIND :: BUTTON EVENT
    $("#btnDelete").on("click", function() {

        DELETE_FLAG = true;
      //  deleteStarter();
//        procPopup('카탈로그', DELETE_MESSAGE, 'deleteStarter();');
        procPopup('카탈로그', DELETE_MESSAGE, 'procDeleteFile();');
        //procPopup('카탈로그', DELETE_MESSAGE, 'procDelete(' + $('#no').val() + ');');
    });

    //procDeleteFile();

    $("#btnResetImg").on("click", function() {
        $("#thumbImgPath").val('');
        $("#thumbImgName").val('');
        resetThumbnail();
    });

/*    $("#btnRevertImg").on("click", function() {

    });*/

    // BIND :: BUTTON EVENT
    $("#btnSearch").on("click", function() {
        // TEST
        procAlert("success", "CATALOG :: BEGIN");
    });


</script>
<%--
====================================================================================================
SCRIPT END
====================================================================================================
--%>
