<%@page contentType="text/html" pageEncoding="UTF-8" %>

<div>
    <div style="float: right; padding: 0 0 10px 0;">
        <button type="button" class="btn btn-primary btn-sm"
                onclick="procMovePage(SERVICE_PACK_INSERT_FORM_URL, '<%= Constants.CUD_C %>');"> 서비스 등록 </button>
    </div>
    <div id="servicePackMessageArea">
    </div>
    <table id="servicePackTableArea" class="table table-striped table-hover t1">
        <thead>
        <tr>
            <th> 이름 </th>
            <th> 요약 </th>
            <th> 분류 </th>
            <th> 공개 </th>
        </tr>
        </thead>
        <tbody id="servicePackListTable">
        </tbody>
    </table>
</div>

<form id="hiddenForm">
    <input type="hidden" id="no" name="no" value="" />
</form>


<%--
====================================================================================================
SCRIPT BEGIN
====================================================================================================
--%>


<script type="text/javascript">

    var SERVICE_PACK_LIST_PROC_URL = "<c:url value='/catalog/getServicePackCatalogList' />";
    var SERVICE_PACK_INSERT_FORM_URL = "<c:url value='/catalog/servicePackForm' />";


    // GET LIST
    var getServicePackList = function(reqParam) {
        var param = {};

        if (null != reqParam && "" != reqParam) param = reqParam;

        procCallAjax(SERVICE_PACK_LIST_PROC_URL, param, procCallbackGetServicePackList);
    };


    // GET LIST CALLBACK
    var procCallbackGetServicePackList = function(data) {
        var objTable = $('#servicePackListTable');
        var objTableArea = $('#servicePackTableArea');
        var objMessageArea = $('#servicePackMessageArea');
        var listLength = data.list.length;
        var htmlString = [];

        objTable.html('');
        objMessageArea.html('');

        if (listLength < 1) {
            objTableArea.hide();

            objMessageArea.append('<spring:message code="common.info.empty.data" />');
            objMessageArea.show();

        } else {
            var catalogList = data.list;

            for (var i = 0; i < listLength; i++) {
                htmlString.push('<tr style="cursor:pointer;" onclick="procMoveServicePackInsertForm(\'' + catalogList[i].no + '\')">'
                        + '<td class="col-md-3">' + catalogList[i].name + '</td>'
                        + '<td class="col-md-4">' + catalogList[i].summary + '</td>'
                        + '<td class="col-md-2 tac" style="text-align: center;">' + catalogList[i].classificationValue + '</td>'
                        + '<td class="col-md-1 tac" style="text-align: center;">' + catalogList[i].useYn + '</td>'
                        + '</tr>');
            }

            objMessageArea.hide();

            objTable.append(htmlString);
            objTableArea.show();
        }
    };


    // MOVE PAGE
    var procMoveServicePackInsertForm = function(reqNo) {
        document.getElementById('no').value = reqNo;
        $('#hiddenForm').attr({action:SERVICE_PACK_INSERT_FORM_URL, method:"POST"}).submit();
    };


    // ON LOAD
    $(document.body).ready(function() {
        getServicePackList();
    });

</script>


<%--
====================================================================================================
SCRIPT END
====================================================================================================
--%>
