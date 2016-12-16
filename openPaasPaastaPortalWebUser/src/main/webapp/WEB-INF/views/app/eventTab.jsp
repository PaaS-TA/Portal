<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    .eventTable {
        border: 1px solid;
        border-color: #b1bec7;
    }
</style>
<script>

    var page = 1;
    var eventList;

    function getAppEvents() {

        param = {
            guid: currentAppGuid
        }

        $.ajax({
            url: "/app/getAppEvents",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function (data) {
                if (data) {

                    limit = 0;

                    eventList = data.resources;
                    $("#eventList").html("");
                    page = 1;
                    getEventList(eventList);

                }
            },

            error: function (xhr, status, error) {
                showAlert("fail", JSON.parse(xhr.responseText).message);
            },
        });
    }


    function getEventList(eventList) {

        cnt = 0

        $.each(eventList, function (id, list) {
            cnt++;

            //alert(eventList.length + " / " + (page-1)*5);

            if (eventList.length < (page - 1) * 5) {
                $("#eventMoreBtn").hide();
                return false;
            }

            if (cnt <= (page - 1) * 5) {
                return true;
            }

            if (list.entity.type == "app.crash") {
                list.entity.metadata.request = "app:CRASHED";
            } else if (list.entity.type == "audit.app.restage") {
                list.entity.metadata.request = "app:RESTAGE";
            } else if (list.entity.type == "audit.app.create") {
                list.entity.metadata.request = "app:CREATE";
            } else if (list.entity.metadata.request == null) {
                list.entity.metadata.request = "";
            }

            var requestText = JSON.stringify(list.entity.metadata.request).replace('{', '').replace('}', '').replace(/"/gi, '');
            var icon;

            if (requestText == "state:STARTED") {
                icon = "<span class='glyphicon glyphicon-play btn-lg' style='color:#faa51b'  aria-hidden='true'></span>";
            } else if (requestText == "state:STOPPED") {
                icon = "<span class='glyphicon glyphicon-stop btn-lg' style='color:#979696'  aria-hidden='true'></span>";
            } else if (requestText == "app:CRASHED") {
                icon = "<span class='glyphicon glyphicon-exclamation-sign btn-lg' style='color:#ff0000' aria-hidden='true'></span>";
            } else {
                icon = "<span class='glyphicon glyphicon-arrow-up btn-lg' aria-hidden='true' style='color:#faa51b'></span>";
            }

            $("#eventList").append(" <tr height='30'>" +
                    "<td style='padding-left:20px;padding-left:2%;' width='10%' class='event-table' ><font size='3px'> " + icon + "</font></td>" +
                    "<td style='padding-left:20px;text-align:center;color:#979696' width='18%' class='eventTable' align='center'> " + list.metadata.created_at.replace('T', '  ').replace('Z', '') + "</td>" +
                    "<td style='padding-left:20px;text-align:center;color:#979696' width='20%' class='eventTable'> &nbsp;" + list.entity.type + "</td>" +
                    "<td style='padding-left:20px;text-align:center;color:#979696' width='15%' class='eventTable'> &nbsp;" + list.entity.actor_name + "</td>" +
                    "<td style='padding-left:20px;text-align:center;color:#979696' width='37%' class='eventTable'> &nbsp;" + requestText + "</td>" +
                    "</tr>");

            if (cnt >= page * 5) {
                return false;
            }

        });
        page++;
        $(".content").scrollTop($(".content")[0].scrollHeight);

    }

</script>
<div style="margin: 0px 0px 0px 10px;width:98%;">
    <table width="100%" class="event-table">
        <thead>
        <tr height="40">
            <td style="background-color: #f6f6f6; padding-left:20px;" colspan="5"><font size="4px"> 최근 이벤트</font></td>
        </tr>
        </thead>
        <tbody id="eventList">
        </tbody>
    </table>
</div>
<div align="center" style="margin: 5px;width:99%;">
    <span class="glyphicon glyphicon-chevron-down btn-lg" style="cursor:pointer"
          onClick="getEventList(eventList);"></span>
</div>
