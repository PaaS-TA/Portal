<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="inviteUserFormArea" style="display: none;">
    <form name='inviteForm' onsubmit='procAddUserRole();'>
        <input type="hidden" id="thisUserId" value='<sec:authentication property="principal.username" />'/>
        <div class="col-sm-12 pt10">
            <div class="col-sm-3" style="padding-top: 6px; padding-left: 0;">
                <div class="form-group">
                    <label> 사용자 이메일 </label>
                </div>
            </div>
            <div class="col-sm-6 tar" style="padding-top: 2px;">
                <div class="form-group">
                    <input class="form-control" style="align-items: center; height:31px; font-size:11px;"
                           placeholder="sample@example.com" id="inviteUserId" type="email"
                           value="${inviteUserId}"
                           required="required"
                           pattern="^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$"/>
                </div>
            </div>
            <div class="col-sm-3 tar" style="padding-right: 0;">
                <button type="button" class="btn btn-cancel btn-sm" onclick="procResetInviteForm();"
                        style="margin-top: 2px; margin-bottom: 3px">
                    취소
                </button>
                <button type="button" class="btn btn-save btn-sm" onclick="procAddUserRole();"
                        style="margin-top: 2px; margin-bottom: 3px">
                    초대
                </button>
            </div>
        </div>
    </form>

    <%--할당된 조직--%>
    <div class="col-sm-12 pt20">
        <table class="table table-bordered mt-1">
            <thead>
            <tr align="top">
                <th style="text-align: center; width: 20%; background-color: #fafafa;">조직</th>
                <th style="text-align: center; background-color: #fafafa;">할당된 조직</th>
            </tr>
            </thead>
            <tbody id="invitedFormOrgListTable">
            <tr>
                <td rowspan="3" style="text-align: center; vertical-align: middle;">
                    <span id="invitedFormCurrentOrg"></span></td>
                <td><label for="orgManagers" class="control-label sr-only"></label>
                    <input style="margin-left: 10px;" type="checkbox" id="orgManagers" name="orgManagers"/>
                    <span style="margin-left: 5px; font-size: 14px;">조직 관리자(Org Managers)</span><br>
                    <h3 style="margin-top: 2px; margin-left: 10px;color: #a0a0a0;">
                        사용자를 조직에 초대하고 조직내 모든 공간에 대한 사용자의 역할을 관리</h3></td>
            </tr>
            <tr>
                <td><label for="orgBillingManagers" class="control-label sr-only"></label>
                    <input style="margin-left: 10px;" type="checkbox" id="orgBillingManagers"
                           name="orgBillingManagers"/>
                    <span style="margin-left: 5px; font-size: 14px;">조직 결제 관리자(Org Billing Manager)</span>
                    <br>
                    <h3 style="margin-top: 2px; margin-left: 10px;color: #a0a0a0;">
                        결제 계정과 결제 정보를 관리</h3></td>
            </tr>
            <tr>
                <td><label for="orgAuditors" class="control-label sr-only"></label>
                    <input style="margin-left: 10px;" type="checkbox" id="orgAuditors" name="orgAuditors"/>
                    <span style="margin-left: 5px; font-size: 14px;">조직감사(Org Auditor)</span><br>
                    <h3 style="margin-top: 2px; margin-left: 10px;color: #a0a0a0;">
                        조직의 사용자, 역할, 도메인, 쿼타정보를 열람</h3></td>
            </tr>
            </tbody>
            <tfoot>
            <tr style="background-color: #FFFFFF; margin-top: 0;">
                <td colspan="4">
                    <label for="invitedFormOrgCheckboxButton" class="control-label sr-only"></label>
                    <input type="checkbox" id="invitedFormOrgCheckboxButton"
                           onclick="procSelectAllOrgInInviteForm();">
                    <span style="margin-left: 5px; font-size: 14px;">전체선택</span></td>
            </tr>
            </tfoot>
        </table>
    </div>

    <%--할당된 공간--%>
    <div id="invitedFormSpaceListArea" class="col-sm-12 pt20" style="display: none;">
        <table class="table table-bordered mt-1">
            <thead>
            <tr align="top">
                <th style="text-align: center; width: 20%; background-color: #fafafa;">공간</th>
                <th style="text-align: center; background-color: #fafafa;">할당된 공간</th>
            </tr>
            </thead>
            <tbody id="invitedFormSpaceListTable">
            </tbody>
            <tfoot>
            <tr style="background-color: #ffffff; margin-top: 0;">
                <td colspan="4">
                    <label for="invitedFormSpaceCheckboxButton" class="control-label sr-only"></label>
                    <input type="checkbox" id="invitedFormSpaceCheckboxButton"
                           onclick="procSelectAllSpaceInInviteForm();">
                    <span style="margin-left: 5px; font-size: 14px;">전체선택</span></td>
            </tr>
            </tfoot>
        </table>
    </div>

</div>