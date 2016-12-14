<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="panel content-box col-md-6 col-md-offset-13" style="height: 630px;">
    <div class="col-sm-4 pt0">
        <h4 class="modify_h4 fwb"> 공간(<span id="spaceCnt">0</span>) </h4>
    </div>
    <div class="col-sm-8 pt5 tar pb20">
        <button type="button" class="btn btn-point btn-sm" onclick="procToggleBox('createSpaceInOrgMain');">
            공간생성
        </button>
    </div>

    <!--공간생성 클릭시-->
    <div id="createSpaceInOrgMainBox" class="col-sm-12 inner-addon left-addon" style="display: none;">
        <input id="createSpaceInOrgMain-TextField" maxlength="100" type="text" class="form-control-warning"
               onkeyup="procSpaceExistCheck('createSpaceInOrgMain');" placeholder="공간이름을 입력하세요."
               style="width: 84%; font-size: 11px; color: #c2c2c4; margin: 0; padding-left: 5px">
        <span id="createSpaceInOrgMain-StatusIcon" class="glyphicon status-icon-warning"
              style="display: none;"></span>
        <button type="button" class="btn btn-cancel btn-sm"
                onclick="procClickCreateFormCancel('createSpaceInOrgMain');"
                style="margin-top: 3px; margin-bottom: 3px;">
            취소
        </button>
        <button id="btn-createSpaceInOrgMain" type="button" class="btn btn-save btn-sm"
                onclick="procCreateSpace('createSpaceInOrgMain');" disabled
                style="margin-top: 3px; margin-bottom: 3px;">
            생성
        </button>
    </div>
    <!--//공간생성 클릭시-->

    <%--SPACE LIST--%>
    <div class="col-sm-12 pt20">
        <table id="spaceListTableHeader" class="table table-striped table-bordered" style="display: none;">
            <thead>
            <tr>
                <th style="text-align: center;">공간</th>
                <th style="text-align: center;">앱</th>
                <th style="text-align: center;">서비스</th>
            </tr>
            </thead>
            <tbody id="spaceListTable">
            </tbody>
        </table>
        <div id="noneSpaceMessageArea" align="center" style="display: none;">공간을 생성해 주세요.</div>
    </div>
</div>