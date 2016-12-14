<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<form>
    <div class="panel content-box col-sm-12 col-md-12 mt-5">
        <div class="col-sm-12 pt0">
            <h4 class="modify_h4 fwb"> 조직 </h4>
        </div>
        <div class="box_group">
            <div class="in_group w700px">
                <label for="org" class="control-label sr-only"></label>
                <input type="text" maxlength="100" id="org" class="form-control2" onkeyup="procChangeOrgNameInputBox();"
                       onkeydown="if (event.keyCode == 13) {procRenameOrgModal(); return false;}">
                <button type="button" class="btn btn-cancel btn-sm" onClick="procRenameOrgModal();"
                        id="renameOrgBtn" disabled>
                    이름변경
                </button>
                <button type="button" class="btn btn_del" onClick="procDeleteOrgModal();" id="deleteOrgBtn">
                    <span class="glyphicon glyphicon-trash"></span>
                </button>
                <button type="button" id="webIdeApplyBtn" class="btn btn-point btn-sm" onclick="applyWebIdeModal();"
                        style='display: none;'>
                    WEB IDE 신청
                </button>
                <img width="30px" id="webIdeLinkBtn" onclick="openWebIdeUrl();"
                     style="cursor: pointer; border-radius: 3px; margin-top:-9px; display: none;"
                     src="<c:url value='/resources/images/web_ide.png' />">
                <button type="button" id="webIdeCancelBtn" class="btn btn-cancel btn-sm" onclick="cancelWebIdeModal();"
                        style='display: none;'>
                    WEB IDE 신청 취소
                </button>
                <input type="hidden" id="webIdeUrl" value="" />
            </div>
        </div>
        <div class="box_group">
            <div class="progress ml10 mt20 w302px fl">
                <div class="progress-bar" role="progressbar" id="memoryBar" aria-valuenow="0" aria-valuemin="0"
                     aria-valuemax="100" style="width: 20%;">
                </div>
            </div>
            <span class="pr_txt fl">
                    <span id="memoryUsage">0.00</span>GB 사용중 / <span id="memoryLimit">0.0</span>GB</span>
        </div>
    </div>
</form>
