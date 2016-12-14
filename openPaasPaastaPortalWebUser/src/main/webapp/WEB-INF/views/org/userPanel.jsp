<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="col-sm-4 pt0">
    <h4 class="modify_h4 fwb"> 사용자(<span id="userCnt">0</span>) </h4>
</div>
<div class="col-sm-8 pt5 tar">
    <button type="button" class="btn btn-point btn-sm" onClick="procViewInviteForm();" >
        사용자 초대하기
    </button>
</div>

<div id="userListFormArea">
    <div class="col-sm-12 pt20">
        <label for="userTab-org-space-selectBox" class="control-label sr-only"></label>
        <select id="userTab-org-space-selectBox" name=""
                class="form-control" style="border-radius: 5px; height: 31px; "
                onchange="procChangeUserSelectBox();">
            <optgroup id="userTabSelectBox-currentOrg" style="color:#b6b6b6;" label="조직">
            </optgroup>
            <optgroup id="userTabSelectBox-spaceList" style="color:#b6b6b6;" label="공간">
            </optgroup>
        </select>
    </div>

    <div class="col-sm-12 pt20">
        <table class="table table-striped table-bordered">
            <thead>
            <tr>
                <th style="min-width: 160px; text-align: center;">사용자</th>
                <th style="text-align: center;">역할설정</th>
            </tr>
            </thead>
            <tbody id="userListTable">
            </tbody>
        </table>
    </div>
</div>