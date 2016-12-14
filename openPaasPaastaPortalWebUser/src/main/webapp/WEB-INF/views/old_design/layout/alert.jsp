<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Alert
<div class="alert alert-warning alert-dismissible fade in" role="alert" id="alert">
    <button type="button" class="close" aria-label="Close" onClick="$('#alert').hide()"><span aria-hidden="true">&times;</span></button>
    <strong><span id="alertMsg">알림영역!</span></strong>
</div>
-->


<div class="notice" role="alert" id="alert" style="display: none">
    <button type="button" class="close" aria-label="Close" onClick="$('#alert').hide()"><span aria-hidden="true">&times;</span></button>

    <h1><span class="glyphicon glyphicon-volume-up" aria-hidden="true"></span> 알림사항</h1>
    <span class="txt" id="alertMsg"> <spring:message code="common.system.welcome.message" /> </span>
</div>

<script>
    id = $('#dropdownTopMenu').text().trim();
    if (AXUtil.getCookie("cookie_alert_close" + id) != "Y") {
        $("#alert").show();    }
</script>


<%--ALARM--%>
<%--
<div id="alertWrap" class="alertWrap">
    <div id="alertDiv" class="alert">
        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
    </div>
</div>
--%>



<!-- Modal -->
<div class="modal fade" id="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="modalTitle">제목</h4>
            </div>
            <div class="modal-body" id="modalText">
                내용
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="modalExecuteBtn" >실행</button>
                <button type="button" class="btn btn-save" id="modalCancelBtn" data-dismiss="modal">취소</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal Mask -->
<div class="modal fade" id="modalMask" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
</div>