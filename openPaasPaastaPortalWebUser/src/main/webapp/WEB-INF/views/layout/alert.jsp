<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="notice" role="alert" id="alert" style="display: none">
    <button type="button" class="close" aria-label="Close" onClick="$('#alert').hide()">
        <span aria-hidden="true">&times;</span></button>
    <h1><span class="glyphicon glyphicon-volume-up" aria-hidden="true"></span> 알림사항</h1>
    <span class="txt" id="alertMsg" style="margin: 2px 0 0 0;"> <spring:message code="common.system.welcome.message" /> </span>
</div>


<script>
    id = $('#dropdownTopMenu').text().trim().substring(0, 5);
    if (AXUtil.getCookie("cookie_alert_close" + id) != "Y") {
        $("#alert").show();
    }
</script>


<div class="col-sm-9 col-sm-offset-4 col-md-10 col-md-offset-2 main">

    <!-- MODAL -->
    <div class="modal fade" id="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="modalTitle">제목</h4>
                </div>
                <div class="modal-body" id="modalText">
                    내용
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-red btn-sm" id="modalExecuteBtn"
                            style="margin: 0;">실행</button>
                    <button type="button" class="btn btn-cancel2 btn-sm" id="modalCancelBtn"
                            data-dismiss="modal" style="margin: 0;">취소</button>
                </div>
            </div>
        </div>
    </div>

    <!-- MODAL MASK -->
    <div class="modal fade" id="modalMask" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    </div>
