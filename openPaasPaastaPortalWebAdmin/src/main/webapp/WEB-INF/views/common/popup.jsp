<%@page contentType="text/html" pageEncoding="UTF-8" %>

<div class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"> &times; </span></button>
                <h1 id="popupTitle" class="modal-title"> TITLE </h1>
            </div>
            <div class="modal-body">
                <p id="popupMessage"> MESSAGE </p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" id="popupButtonText"> SAVE CHANGES </button>
                <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="procClosePopup();"> 취소 </button>
            </div>
        </div>
    </div>
</div>
