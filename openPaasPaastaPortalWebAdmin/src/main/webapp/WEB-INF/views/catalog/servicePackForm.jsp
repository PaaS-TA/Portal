<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ include file="../common/common.jsp"%>
<script type="text/javascript" src="<c:url value='/resources/js/fileUpload.js' />"></script>

    <div class="col-sm-6 pt30">
        <c:choose>
            <c:when test="${INSERT_FLAG eq Constants.CUD_U}">
                <h4 class="modify_h4 fwn">서비스 상세</h4>
            </c:when>
            <c:when test="${INSERT_FLAG eq Constants.CUD_C}">
                <h4 class="modify_h4 fwn">서비스 등록</h4>
            </c:when>
        </c:choose>

    </div>
    <!--인스턴스 설정-->
    <div class="col-md-11 col-md-offset-14">
        <form class="form-horizontal" role="form" id="catalogForm" name="catalogForm">
            <input type="hidden" id="thumb_image_path" value="${thumb_image_path}">
            <div class="form-group">
                <label class="control-label col-sm-2" for="name">이름</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control" id="name" name="name">
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-2" for="classification">분류</label>
                <div class="col-sm-9">
                    <select class="form-control" id="classification" style="background:url(/resources/images/btn_down.png) no-repeat right; background-color:#fafafa;">
                        <%-- Category Area --%>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-2" for="servicePackName">서비스</label>
                <div class="col-sm-9">
                    <select class="form-control" id="servicePackName" name="servicePackName" style="background:url(/resources/images/btn_down.png) no-repeat right; background-color:#fafafa;">
                        <%-- build pack area --%>
                    </select>
                </div>
            </div>


            <div class="form-group">
                <label class="control-label col-sm-2" for="thumbnail">썸네일<br><font style="font-size:13px;color:#ababab;">(50X50)</font></label>

                <div class="col-sm-8">
                    <input type="text" class="form-control" id="thumbnail" style="width: 102%; background: white; cursor: default" disabled>
                </div>
                <div class="col-sm-1">
                    <button type="button" class="btn btn-cancel btn-sm tar" style="margin-top:11px;margin-left:-5px;" onclick="$('#hiddenThumbnail').click()">
                        <span class="glyphicon glyphicon-floppy-disk"></span>&nbsp;파일찾기
                    </button>
                    <input type="file" id="hiddenThumbnail" style="display: none">
                </div>
                <div>
                    <div class="col-sm-9">
                        <div id="divPreview" class="divPreview"  style="width: 99.9%;">
                            <div class="fl">
                                <a href="javascript:void(0);" class="custom-thumbnail">
                                    <img id="preview" src="" >
                                </a>
                            </div>
                            <div class="fl" style="padding:15px 10px;">
                                <a id="thumbname"></a>
                            </div>
                            <div class="divImageInfo fl ml20">
                                <label id="labelThumbName" style="padding-right: 20px"></label>
                                <button id="btnResetImg" type="button" class="btn-del" aria-label="썸네일 지우기">
                                    <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-2" for="servicePackName">파라미터</label>
                <div class="col-sm-6" style="width: 55%">
                    <input type="text" class="form-control" id="parameter">
                </div>
                <div class="col-sm-3" style="text-align: center; width: 20%; padding-right: 10px">
                    <div style="margin-top:15px;margin-left:-20px;">
                        ex) {"permissions":"read-only"}
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-2" for="useYn_Y">공개</label>
                <div class="col-sm-9 mt10">
                    <label class="radio-inline">
                        <input type="radio" id="useYn_Y" name="useYn" value="<%= Constants.USE_YN_Y %>"> Y
                    </label>
                    <label class="radio-inline">
                        <input type="radio" id="useYn_N" name="useYn" value="<%= Constants.USE_YN_N %>"> N
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-2" for="summary">요약</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control" id="summary" name="summary">
                </div>

            </div>
            <div class="form-group">
                <label class="control-label col-sm-2" for="description">설명</label>
                <div class="col-sm-9">
                    <textarea class="form-control" rows="5" id="description" name="description"></textarea>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-1 col-sm-9 " align="right" id = "statusActivity">
                    <div class="divButtons" style="width:97.8%;">
                        <c:set var="insertFlag" value="${INSERT_FLAG}" />
                        <c:set var="checkCudU" value="<%= Constants.CUD_U %>" />
                        <c:choose>
                            <c:when test="${insertFlag eq checkCudU}">
                                <button type="button" class="btn btn_del2 fl ml-22" id="btnDelete">삭제</button>
                                <button type="button" class="btn btn-cancel2 btn-sm" id="btnCancel">취소</button>
                                <button type="button" class="btn btn-save btn-sm" id="btnRegist">저장</button>
                            </c:when>
                            <c:otherwise>
                                <button type="button" class="btn btn-cancel2 btn-sm" id="btnCancel">취소</button>
                                <button type="button" class="btn btn-save btn-sm" id="btnRegist">등록</button>
                            </c:otherwise>
                        </c:choose>

                    </div>
                </div>
            </div>

            <input type="hidden" id="orgThumbImgPath" name="orgThumbImgPath" value="" />
            <input type="hidden" id="thumbImgPath" name="thumbImgPath" value="" />
            <input type="hidden" id="thumbImgName" name="thumbImgName" value="" />
            <input type="hidden" id="orgName" name="orgName" value="" />
            <input type="hidden" id="no" name="no" value="<c:out value='${REQUEST_NO}' default='' />" />

        </form>
    </div>
    <!--//인스턴스 설정-->
    <div class="row">
    </div>

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
        var CATALOG_LIST_PROC_URL = "<c:url value='/catalog/getServicePackCatalogList' />";
        var CATEGORY_LIST_PROC_URL = "<c:url value='/commonCode/getCommonCode' />";
        var SERVICE_PACK_LIST_PROC_URL = "<c:url value='/catalog/getServicePackList' />";
        var DUPLICATED_PROC_URL = "<c:url value='/catalog/getServicePackCatalogCount' />";
        var INSERT_PROC_URL = "<c:url value='/catalog/insertServicePackCatalog' />";
        var UPDATE_PROC_URL = "<c:url value='/catalog/updateServicePackCatalog' />";
        var DELETE_PROC_URL = "<c:url value='/catalog/deleteServicePackCatalog' />";
        var CHECK_DELETE_PROC_URL = "<c:url value='/catalog/getCheckDeleteServicePackCatalogCount' />";
        var UPLOAD_IMAGE_PROC_URL = "<c:url value='/catalog/uploadThumbnailImage'/>";
        var DELETE_IMAGE_PROC_URL = "<c:url value='/catalog/deleteThumbnailImage'/>";
        var SERVICE_PACK_CATALOG_ID = "<%= Constants.SERVICE_PACK_CATALOG_ID %>";
        var INSERT_FLAG = "<c:out value='${INSERT_FLAG}' default='' />";
        var CUD_U = "<%= Constants.CUD_U %>";
        var REQ_NO = "<c:out value='${REQUEST_NO}' default='' />";


        // GET CATEGORY LIST
        var getCategoryList = function() {
            procCallAjax(CATEGORY_LIST_PROC_URL + "/" + SERVICE_PACK_CATALOG_ID, null, procCallbackCategoryList);
        };


        // GET CATEGORY LIST CALLBACK
        var procCallbackCategoryList = function(data) {
            if (RESULT_STATUS_FAIL == data.RESULT) return false;

            var objSelectBox = $('#classification');
            var listLength = data.list.length;
            var htmlString = [];

            for (var i = 0; i < listLength; i++) {
                htmlString.push("<option value='" + data.list[i].key + "'>" + data.list[i].value + "</option>");
            }

            objSelectBox.append(htmlString);

            getServicePackList();
        };


        // GET SERVICE PACK LIST
        var getServicePackList = function() {
            procCallAjax(SERVICE_PACK_LIST_PROC_URL, {}, procCallbackServicePackList);
        };


        // GET SERVICE PACK LIST CALLBACK
        var procCallbackServicePackList = function(data) {
            if (RESULT_STATUS_FAIL == data.RESULT) return false;

            var objSelectBox = $('#servicePackName');
            var listLength = data.list.length;
            var htmlString = [];

            for (var i = 0; i < listLength; i++) {
                htmlString.push("<option value='" + data.list[i].name + "'>" + data.list[i].name + "</option>");
            }

            objSelectBox.append(htmlString);

            var insertFlag = INSERT_FLAG;
            if ("" != insertFlag && CUD_U == insertFlag) procUpdateForm();
        };


        // CHECK DUPLICATED NAME
        var procCheckDuplicatedName = function() {
            if (!procCheckValidStringSpace()) return false;
            if (!procCheckValid()) return false;

            var doc = document;
            var reqName = doc.getElementById('name').value;
            var orgName = doc.getElementById('orgName').value;

            // CHECK DUPLICATED NAME
            var insertFlag = INSERT_FLAG;
            if ("" != insertFlag && CUD_U == insertFlag && reqName == orgName) {
                procUploadFile({RESULT : RESULT_STATUS_SUCCESS});

            } else {
                procCallAjax(DUPLICATED_PROC_URL, {name: reqName}, procUploadFile);
            }
        };

        // PROCESS CHECK VALID
        var procCheckValid = function() {

            // name
            var name = $('#name').val();
            if (name == '') {
                procAlert("warning", '<spring:message code="common.info.empty.req.data" />');
                $('#name').focus();
                return false;
            }

            // summart
            var summary = $('#summary').val();
            if (summary == '') {
                procAlert("warning", '<spring:message code="common.info.empty.req.data" />');
                $('#summary').focus();
                return false;
            }

            return true;
        };

        // UPLOAD FILE
        var procUploadFile = function(data) {
            if (RESULT_STATUS_SUCCESS != data.RESULT) {
                $('#name').focus();
                return false;
            }

            var formData = getFileFormData();

            if (formData != undefined) {
                uploadFile(formData, UPLOAD_IMAGE_PROC_URL, procInsert);
            } else {
                procInsert();
            }
        };


        // INSERT
        var procInsert = function(data) {
            var doc = document;
            var reqUseYn = $("input:radio[name='useYn']:checked").val();
            var param = $("#catalogForm").serializeObject();

            var param2 = {
                useYn: reqUseYn,
                classification: doc.getElementById('classification').value,
                summary: doc.getElementById('summary').value,
                description: doc.getElementById('description').value,
                parameter: doc.getElementById('parameter').value
            };

            $.extend(param, param2);

            // UPDATE
            var insertFlag = INSERT_FLAG;
            if ("" != insertFlag && CUD_U == insertFlag) {
                procCallAjax(UPDATE_PROC_URL, param, procCallbackUpdate);

                // INSERT
            } else {
                procCallAjax(INSERT_PROC_URL, param, procCallbackInsert);
            }
        };


        // INSERT CALLBACK
        var procCallbackInsert = function(data) {
            if (RESULT_STATUS_SUCCESS == data.RESULT) {
                procAlert("success", '<spring:message code="common.info.result.success" />');
                procMovePage(CATEGORY_HOME_URL);

            } else {
                procAlert("danger", data.RESULT_MESSAGE);
            }
        };


        // UPDATE CALLBACK
        var procCallbackUpdate = function(data) {
            if (RESULT_STATUS_SUCCESS == data.RESULT) {
                procDeleteFile();
                procAlert("success", '<spring:message code="common.info.result.success" />');

            } else {
                procAlert("danger", data.RESULT_MESSAGE);
            }
        };


        // UPDATE FORM
        var procUpdateForm = function() {
            var reqNo = REQ_NO;
            if (null == reqNo || "" == reqNo) {
                procAlert("danger", '<spring:message code="common.system.error.message" />');
                return false;
            }

            procCallAjax(CATALOG_LIST_PROC_URL, {no: reqNo}, procCallbackUpdateForm);
        };


        // CALL BACK UPDATE FORM
        var procCallbackUpdateForm = function(data) {
            if (RESULT_STATUS_FAIL == data.RESULT) return false;

            if (data.list.length < 1) return false;

            var resultData = data.list[0];

            var reqName = $('#name');
            var reqOrgName = $('#orgName');
            var reqClassification = $('#classification');
            var reqServicePackName = $('#servicePackName');
            var reqThumbImgPath = $("#thumbImgPath");
            var reqOrgThumbImgPath = $("#orgThumbImgPath");
            var reqThumbImgName = $("#thumbImgName");
            var reqUseYn = $('#useYn_' + data.list[0].useYn);
            var reqSummary = $('#summary');
            var reqDescription = $('#description');
            var reqParameter = $('#parameter');

            reqName.val(resultData.name);
            reqOrgName.val(resultData.name);
            reqClassification.val(resultData.classification);
            reqServicePackName.val(resultData.servicePackName);
            reqThumbImgPath.val(resultData.thumbImgPath);
            reqOrgThumbImgPath.val(resultData.thumbImgPath);
            reqThumbImgName.val(resultData.thumbImgName);
            reqUseYn.attr('checked', true);
            reqSummary.val(resultData.summary);
            reqDescription.val(resultData.description);
            reqParameter.val(resultData.parameter);

            var tempThumbImgPath = reqThumbImgPath.val();

            if (tempThumbImgPath == null || tempThumbImgPath == '') {
                $('#divPreview').hide();
            } else {
                $('#divPreview').attr('style', 'display: block; height: 94px;');
                $('#preview').attr('src', tempThumbImgPath);
                $("#labelThumbName").text(reqThumbImgName.val());
            }
        };


        // CHECK DELETE
        var procCheckDelete = function() {
            $('div.modal').modal('toggle');

            var reqNo = REQ_NO;
            if (null == reqNo || "" == reqNo) return false;

            procCallAjax(CHECK_DELETE_PROC_URL, {no: reqNo}, procDelete);
        };


        // DELETE
        var procDelete = function(data) {
            if (RESULT_STATUS_SUCCESS != data.RESULT) {
                procAlert("danger", data.RESULT_MESSAGE);
                return false;
            }

            document.getElementById('thumbImgPath').value = '';

            procCallAjax(DELETE_PROC_URL, {no: REQ_NO}, procCallbackDelete);
        };


        // DELETE CALLBACK
        var procCallbackDelete = function(data) {
            if (RESULT_STATUS_SUCCESS == data.RESULT) {
                procDeleteFile();
                procAlert("success", '<spring:message code="common.info.result.success" />');

            } else {
                procAlert("danger", data.RESULT_MESSAGE);
            }
        };


        // DELETE FILE CHECK VALID
        var procDeleteFileCheckValid = function() {
            var doc = document;
            var orgThumbImgPath = doc.getElementById('orgThumbImgPath').value;
            var thumbImgPath = doc.getElementById('thumbImgPath').value;
            var insertFlag = INSERT_FLAG;

            if ("" != insertFlag && CUD_U == insertFlag) {
                if (orgThumbImgPath == thumbImgPath || orgThumbImgPath == "" || orgThumbImgPath == null) {
                    return false;
                }
            }

            return true;
        };


        // DELETE FILE
        var procDeleteFile = function() {
            if (procDeleteFileCheckValid()) {
                procCallAjax(DELETE_IMAGE_PROC_URL, {thumbImgPath : document.getElementById('orgThumbImgPath').value}, procCallbackDeleteFile);
            } else {
                procMovePage(CATEGORY_HOME_URL);
            }
        };


        // DELETE FILE CALLBACK
        var procCallbackDeleteFile = function() {
            procMovePage(CATEGORY_HOME_URL);
        };


        // RESET IMAGE
        var procResetImage = function() {
            var doc = document;
            doc.getElementById('thumbImgPath').value = '';
            doc.getElementById('thumbImgName').value = '';

            resetThumbnail();
        };


        // INIT
        var procInit = function() {
            getCategoryList();

            $('#name').focus();
            $('#useYn_Y').attr('checked', true);

            var insertFlag = INSERT_FLAG;
            if ("" != insertFlag && CUD_U == insertFlag)  procUpdateForm();

            resetThumbnail();

            $("#hiddenThumbnail").on("change", function() {
                setPreView($(this));
            });

            procAlert("info", WELCOME_MESSAGE);
        };


        // BIND :: BUTTON EVENT
        $("#btnResetImg").on("click", function() {
            procResetImage();
        });


        // BIND :: BUTTON EVENT
        $("#btnRegist").on("click", function() {
            procCheckDuplicatedName();
        });


        // BIND :: BUTTON EVENT
        $("#btnCancel").on("click", function() {
            procMovePage(CATEGORY_HOME_URL + "/<%= Constants.TAB_NAME_SERVICE_PACK %>");
        });


        // BIND :: BUTTON EVENT
        $("#btnDelete").on("click", function() {
            procPopup('카탈로그', DELETE_MESSAGE, 'procCheckDelete();');
        });


        // ON LOAD
        $(document.body).ready(function() {
            procInit();
        });
    </script>
    <%--
    ====================================================================================================
    SCRIPT END
    ====================================================================================================
    --%>
