<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%--
  Created by IntelliJ IDEA.
  User: rex
  Date: 7/4/2016
  Time: 5:15 PM
  To change this template use File | Settings | File Templates.
--%>

<div>
    <div style="float: right; padding: 0 0 10px 0;">
        <button type="button" class="btn btn-primary btn-sm"
                onclick="procMovePage(STARTER_INSERT_FORM_URL, '<%= Constants.CUD_C %>');">앱 템플릿 등록</button>

        <%--"procAlert('info', 'CLICK'); procMovePage('<c:url value='/catalog/starterForm/?status=insert'/>'--%>
    </div>
    <div id="starterListMessageArea">
    </div>
    <table id="starterListTableArea" class="table table-striped table-hover t1">
        <thead>
        <tr>
            <th>이름</th>
            <th>요약</th>
            <th>분류</th>
            <th>공개</th>
        </tr>
        </thead>
        <tbody id="starterList">

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

    var STARTER_LIST_PROC_URL = "<c:url value='/catalog/getStarterNamesList' />";
    var STARTER_INSERT_FORM_URL = "<c:url value='/catalog/starterForm' />";

    // MOVE PAGE
    var procMoveStarterInsertForm = function(reqParam) {
        var hiddenForm = $('#hiddenForm');
        $('#no').val(reqParam);

        console.log("no: " + $('#no').val(reqParam))

        hiddenForm.attr({action:STARTER_INSERT_FORM_URL, method:"POST"}).submit();
    };

    // GET LIST
    var getStarterList = function(reqParam) {
        var param = {};

        if (null != reqParam && "" != reqParam) param = reqParam;

        procCallAjax(STARTER_LIST_PROC_URL, param, procCallbackGetStarterList);
    };

    // GET LIST CALLBACK
    var procCallbackGetStarterList = function (data) {
        var objTable = $("#starterList");
        var objTableArea = $('#starterListTableArea');
        var objMessageArea = $('#starterListMessageArea');
        var listLength = data.list.length;
        var htmlString = [];

        objTable.html('');
        objMessageArea.html('');

        if (listLength < 1) {
            objTableArea.hide();

            objMessageArea.append('<spring:message code="common.info.empty.data" />');
            objMessageArea.show();
            <%--objTable.append('<tr><td colspan="4">' + '<spring:message code="common.info.empty.data" />' + '</td></tr>');--%>

        } else {
            var catalogList = data.list;
            var reqParam = {};

            for (i = 0; i < listLength; i++) {
                reqParam = {name: catalogList[i].name};
                //htmlString.push('<tr style="cursor:pointer;" onclick="location.href='/catalog/starterForm?status=info&no=\'' + catalogList[i].no + '\'">'
                htmlString.push('<tr style="cursor:pointer;" onclick="procMoveStarterInsertForm(\'' + catalogList[i].no + '\')">'
                        + '<td class="col-md-3">' + catalogList[i].name + '</td>'
                        + '<td class="col-md-4">' + catalogList[i].summary + '</td>'
                        + '<td class="col-md-2 tac">' + catalogList[i].classificationValue + '</td>'
                        + '<td class="col-md-1 tac">' + catalogList[i].useYn + '</td>'
                        + '</tr>');
            }

            objMessageArea.hide();

            objTable.append(htmlString);
            objTableArea.show();

            /*for (var i = 0; i < listLength; i++) {
                objTable.append( //procMoveStarterInsertForm
                        //<tr style="cursor:pointer;" onclick="procMoveBuildPackInsertForm(\'' + catalogList[i].no + '\')">'
                        //  onclick=location.href='/catalog/starterForm?status=info&no="+data.list[i].no+"'>" +
                        "<tr style='cursor:pointer;' onclick=location.href='/catalog/starterForm?status=info&no="+ data.list[i].no + "'>" +
                      //  "<tr style='cursor:pointer;' onclick='procMoveStarterInsertForm(" + data.list[i].no + ")'>" +
                        "<td>"+ data.list[i].name +"</td>" +
                        "<td>"+ data.list[i].summary +" </td>" +
                        "<td style='text-align: center;'>"+ data.list[i].classification +"</td>" +
                        "<td style='text-align: center;'>"+ data.list[i].useYn +"</td>" +
                        "</tr>"
                );
            }*/
        }
    }


    $(document.body).ready(function () {
        procAlert("info", WELCOME_MESSAGE);

        // GET LIST
        getStarterList();
    });

</script>

<%--
====================================================================================================
SCRIPT END
====================================================================================================
--%>