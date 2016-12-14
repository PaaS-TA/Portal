/*FILE UPLOAD*/

(function($, window, document) {

    var isAdvancedUpload = function() {
        var div = document.createElement('div');
        return ( ( 'draggable' in div ) || ( 'ondragstart' in div && 'ondrop' in div ) ) && 'FormData' in window && 'FileReader' in window;
    }();

    $('.custom-box').each(function() {
        var thisForm = $(this);
        var requestFile = REQUEST_FILE_OBJECT;  // REQUIRED
        var droppedFile = false;

        var showFiles = function(requestFile) {
            procSetFileInfo(requestFile);
        };

        requestFile.on('change', function(e) {
            showFiles(e.target.files);
        });

        if (isAdvancedUpload) {
            thisForm.on('drag dragstart dragend dragover dragenter dragleave drop', function(e) {
                e.preventDefault();
                e.stopPropagation();
            }).on('dragover dragenter', function() {
                thisForm.addClass('is-dragover');
            }).on('dragleave dragend drop', function() {
                thisForm.removeClass('is-dragover');
            }).on('drop', function(e) {
                droppedFile = e.originalEvent.dataTransfer.files;
                REQUEST_FILE = e.originalEvent.dataTransfer.files;
                showFiles(droppedFile);
            });
        }
    });

})(jQuery, window, document);


// FILE FORM DATA
var getFileFormData = function() {
    var reqFileObject = REQUEST_FILE;
    if (null == reqFileObject || undefined === reqFileObject) return false;

    var formData = new FormData();
    formData.append("file", reqFileObject[0]);

    return formData;
};


// UPLOAD FILE
var procUploadFile = function(formData, reqUploadUrl, reqProcFunction) {
    console.log("procUploadFile ####");
    $.ajax({
        url : reqUploadUrl
        , method : "POST"
        , processData : false
        , contentType : false
        , data : formData
        , dataType : "json"
        , success : function(data){
            if (data) {
                reqProcFunction(data);
            } else {
                var resData = {RESULT : RESULT_STATUS_SUCCESS,
                                RESULT_MESSAGE : "<spring:message code='common.info.result.success' />"};

                reqProcFunction(resData);
            }
        },
        error: function(xhr, status, error) {
            procCallSpinner(SPINNER_SPIN_STOP);

            var resData = {RESULT : RESULT_STATUS_FAIL,
                            RESULT_MESSAGE : JSON.parse(xhr.responseText).customMessage};

            reqProcFunction(resData);
            console.log("FILE UPLOAD ERROR :: error :: ", error);
        },
        complete : function(data) {
            console.log("FILE UPLOAD COMPLETE :: data :: ", data);
        }
    });
};
