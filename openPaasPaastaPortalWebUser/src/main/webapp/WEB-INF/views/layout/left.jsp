<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="container-fluid" id="main">
    <div class="row">

        <%--LEFT MENU--%>
        <div class="col-sm-3 col-md-2 sidebar">
            <%--USER INFO--%>
            <%@include file="./leftUserInfo.jsp" %>

            <%--ORG LIST--%>
            <div id="orgListArea" style="display: none;">
                <div class="group_btn">
                    <span><a href="javascript:void(0);" onclick="procMovePage('<c:url value='/org/createOrgMain'/>')" class=""> 조직생성 </a></span>
                </div>
                <%--SELECTED ORG--%>
                <ul class="smenu">
                    <li class="on" style="background-color: #eeeeee;"><a href="javascript:void(0);" id="menuCurrentOrg" onclick="procSelectOrg($(this).text());"></a></li>
                </ul>
                <%--ORG LIST--%>
                <ul id="orgList" class="ssmenu">
                </ul>
            </div>

            <%--SPACE LIST--%>
            <div id="spaceListArea" style="display: none;">
                <div class="group_btn">
                    <span><a href="javascript:void(0);" class="" onclick="procToggleCreateSpaceBox('createSpace');"> 공간생성 </a></span>
                </div>
                <div id="createSpaceBox" class="createSpace_pop" style="display: none;">
                    <div class="inner-addon left-addon <%--ml20--%> mb10">
                        <input id="createSpace-TextField" maxlength="100" type="text" class="form-control-warning" onkeyup="procSpaceExistCheck('createSpace');" placeholder="공간이름을 입력하세요." style="font-size:11px; color: #c2c2c4; margin: 0px; padding-left: 5px;">
                        <span id="createSpace-StatusIcon" class="glyphicon status-icon-warning" style="margin-left:-10px; margin-top: -5px; position: absolute;"></span>
                        <button type="button" class="btn btn-cancel btn-sm" onclick="procClickCreateFormCancel('createSpace');" style="margin-top: 3px; margin-bottom: 3px;">
                            취소
                        </button>
                        <button id="btn-createSpace" type="button" class="btn btn-save btn-sm" onclick="procCreateSpace('createSpace');" disabled style="margin-top: 3px; margin-bottom: 3px;">
                            생성
                        </button>
                    </div>
                </div>
                <%--SPACE LIST--%>
                <ul id="spaceList" class="smenu">
                </ul>
            </div>
        </div>
