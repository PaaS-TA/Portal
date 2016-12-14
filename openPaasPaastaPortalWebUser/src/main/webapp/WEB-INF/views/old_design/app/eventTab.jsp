<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    .eventTable {
        border:1px solid ;
        border-color:#b1bec7;
    }
</style>
<script>

    var page = 1;
    var eventList;

    function getAppEvents(){

        param = {
            guid:  currentAppGuid
        }

        $.ajax({
            url: "/app/getAppEvents",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function(data){
                if(data){

                    limit = 0;

                    eventList = data.resources;
                    $("#eventList").html("");
                    page = 1;
                    getEventList(eventList);

                }
            },

            error: function(xhr,status,error){
                showAlert("fail",JSON.parse(xhr.responseText).message);
            },
        });
    }


    function getEventList(eventList){

        cnt=0

        $.each(eventList, function(id,list) {
            cnt++;

            //alert(eventList.length + " / " + (page-1)*5);

            if(eventList.length < (page-1)*5){
                $("#eventMoreBtn").hide();
                return false;
            }

            if(cnt <= (page-1)*5){
                return true;
            }

            if(list.entity.type == "app.crash"){
                list.entity.metadata.request = "app:CRASHED";
            }else if(list.entity.type == "audit.app.restage"){
                list.entity.metadata.request = "app:RESTAGE";
            }else if(list.entity.type == "audit.app.create"){
                list.entity.metadata.request = "app:CREATE";
            }else if(list.entity.metadata.request == null){
                list.entity.metadata.request = "";
            }

            var requestText = JSON.stringify(list.entity.metadata.request).replace('{','').replace('}','').replace(/"/gi,'');
            var icon;

            if(requestText == "state:STARTED"){
                icon = "<span class='glyphicon glyphicon-play btn-lg' style='color:00aa00'  aria-hidden='true'></span>";
            }else if(requestText == "state:STOPPED"){
                icon = "<span class='glyphicon glyphicon-stop btn-lg' aria-hidden='true'></span>";
            }else if(requestText == "app:CRASHED"){
                icon = "<span class='glyphicon glyphicon-exclamation-sign btn-lg' style='color:ff0000' aria-hidden='true'></span>";
            }else{
                icon = "<span class='glyphicon glyphicon-arrow-up btn-lg' aria-hidden='true' style='color:00aa00'></span>";
            }

            $("#eventList").append(" <tr height='30'>" +
                    "<td width='7%' class='eventTable' align='center'> " + icon + "</td>" +
                    "<td width='18%' class='eventTable' align='center'> " + list.metadata.created_at.replace('T','  ').replace('Z','') + "</td>" +
                    "<td width='20%' class='eventTable'> &nbsp;" + list.entity.type + "</td>" +
                    "<td width='15%' class='eventTable'> &nbsp;" + list.entity.actor_name + "</td>" +
                    "<td width='37%' class='eventTable'> &nbsp;" + requestText + "</td>" +
                    "</tr>");

            if(cnt >= page*5){
                return false;
            }

        });
        page++;
        $(".content").scrollTop($(".content")[0].scrollHeight);

    }

</script>
<div style="margin: 0px;width:99%;">
    <table  width="100%" class="eventTable">
        <thead>
            <tr height="40"><td style="background-color: #f5f7f8" colspan="5"> 최근 이벤트</td></tr>
        </thead>
        <tbody id="eventList">
        </tbody>
    </table>
</div>
<div align="center" style="margin: 5px;width:99%;">
    <button type="button" id="eventMoreBtn" class="btn btn-delete" onClick="getEventList(eventList);">
        <span class="glyphicon glyphicon-triangle-bottom" aria-hidden="true"></span>
    </button>
</div>
