<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="panel content-box col-md-6 col-md-offset-13">
    <div class="col-sm-4 pt0">
        <h4 class="modify_h4 fwb"> 도메인(<span id="domainCnt">0</span>) </h4>
        <input type="hidden" id="hiddenDomainCount" value="" />
    </div>
    <div class="col-sm-8 pt5 tar pb20">
        <button type="button" class="btn btn-point btn-sm" onclick="procToggleBox('addDomain');">
            도메인 추가
        </button>
    </div>

    <!--도메인추가 클릭시-->
    <div id="addDomainBox" class="col-sm-12 inner-addon left-addon" style="display: none;">
        <input id="addDomain-TextField" maxlength="100" type="text" class="form-control-warning"
               onkeyup="procCheckDomainValidation('addDomain')" placeholder="추가할 도메인을 입력하세요."
               style="width: 75%; font-size: 11px; color: #c2c2c4; margin: 0; padding-left: 5px"> &nbsp;
        <span id="addDomain-StatusIcon" class="glyphicon status-icon-warning" style="display: none;"></span>
        <button type="button" class="btn btn-cancel btn-sm"
                onclick="procClickCreateFormCancel('addDomain');"
                style="margin-top: 3px;margin-bottom: 3px">
            취소
        </button>
        <button id="btn-addDomain" type="button" class="btn btn-save btn-sm"
                onclick="procAddDomain();" disabled style="margin-top: 3px;margin-bottom: 3px">
            추가
        </button>
    </div>
    <!--//도메인추가 클릭시-->

    <div class="col-sm-12 pt20">
        <table class="table table-striped table-bordered">
            <thead>
            <tr>
                <th style="text-align: center;" colspan="2">도메인</th>
            </tr>
            </thead>
            <tbody id="domainListTable">
            </tbody>

        </table>
    </div>
</div>