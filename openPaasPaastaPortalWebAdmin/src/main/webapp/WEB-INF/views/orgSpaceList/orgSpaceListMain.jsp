<%--
  Created by IntelliJ IDEA.
  User: Dojun
  Date: 2016-09-06
  Time: 오후 2:35
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ include file="../common/common.jsp"%>
<script>
    var GET_ORGS_FOR_ADMIN_URL = "<c:url value='/orgSpaceList/getOrgsForAdmin'/>";
    var GET_SPACES_FOR_ADMIN_URL = "<c:url value='/orgSpaceList/getSpacesForAdmin'/>";

    $(document).ready(function(){
        getOrgsForAdmin()

    });

    function getOrgsForAdmin(){
        procCallAjax(GET_ORGS_FOR_ADMIN_URL, {},procCallbackGetOrgs)
    }

    var procCallbackGetOrgs = function(data) {
        $("#orgTable").hide();
        $("#noSpaceMessage").hide();

        if(data.orgList.length === 0){
            $("#noOrgMessage").show();
        } else {
            $("#orgTable").append(
                    "<div class='mainViewArea-table-title'>"+
                    "<div class='table-contentLeft'>번호</div>"+
                    "<div class='table-contentRight'>조직 이름</div>"+
                    "</div>"
            )

            var sortAry = new Array();
            for (var i = 0; i < data.orgList.length; i++) {
                sortAry[i] = data.orgList[i].orgName.value;
            }
            sortAry.sort();

            for (var i = 0; i < data.orgList.length; i++) {
                $("#orgTable").append (
                        "<div id='orgSpaceViewArea-table-content-org-no"+(i+1)+"' class='mainViewArea-table-content' name='"+sortAry[i].toString().toLowerCase()+"' onclick=selectOrg('"+sortAry[i]+"')>"+
                        "<div class='table-contentLeft'>"+(i+1)+"</div>"+
                        "<div class='table-contentRight'>"+sortAry[i]+"</div>"+
                        "</div>"
                )
            }

//            $.each(data.orgList, function (eventId, org) {
//                $("#orgTable").append (
//                        "<div id='orgSpaceViewArea-table-content-org-no"+(eventId+1)+"' class='mainViewArea-table-content' name='"+org.orgName.value.toLowerCase()+"' onclick=selectOrg('"+org.orgName.value+"')>"+
//                        "<div class='table-contentLeft'>"+(eventId+1)+"</div>"+
//                        "<div class='table-contentRight'>"+org.orgName.value+"</div>"+
//                        "</div>"
//                )
//            });

            changeTableContentColor("org")
            $("#orgTable").show();
            selectOrg(sortAry[0]);
        }
    }

    function getSpacesForAdmin(orgName){
        $("#spaceTable").hide();
        $("#noSpaceMessage").hide();
        procCallAjax(GET_SPACES_FOR_ADMIN_URL, {"orgName":orgName},procCallbackGetSpaces)
    }

    var procCallbackGetSpaces = function(data) {

        $("#spaceTable *").remove();
        $("#spaceTable").hide();
        $("#noSpaceMessage").hide();

        if(data.spaceList.length === 0){
            $("#noSpaceMessage").show();
        } else {
            $("#spaceTable").append(
                    "<div class='mainViewArea-table-title'>"+
                    "<div class='table-contentLeft'>번호</div>"+
                    "<div class='table-contentRight'>공간 이름</div>"+
                    "</div>"
            )
            $.each(data.spaceList, function (eventId, space) {
                $("#spaceTable").append (
                        "<div id='orgSpaceViewArea-table-content-space-no"+(eventId+1)+"' class='mainViewArea-table-content' style='cursor: text'>"+
                        "<div class='table-contentLeft'>"+(eventId+1)+"</div>"+
                        "<div class='table-contentRight'>"+space.spaceName.value+"</div>"+
                        "</div>"
                )
            });
            changeTableContentColor("space")
            $("#spaceTable").show();
        }
    }

    function selectOrg(orgName){
        getSpacesForAdmin(orgName)
    }

    function searchOrg() {
        $('#spaceTable').hide();
        $('#noSpaceMessage').hide();

        var input = $("#org-searchKeyword").val().toLowerCase();

        if(input === ""){
            $('#noSearchOrgMessage').hide();
            $('#orgTable').show();
            $('#orgTable div[id*="orgSpaceViewArea-table-content-org-no"]').show();
            changeTableContentColor("org")
        } else{
            $('#orgTable div[id*="orgSpaceViewArea-table-content-org-no"]').hide();

            if($('#orgTable div[name*="'+input+'"]').length > 0){
                $('#noSearchOrgMessage').hide();
                $('#orgTable').show();
                $('#orgTable div[name*="'+input+'"]').show();
                changeTableContentColor("org")
            } else{
                $('#orgTable').hide();
                $('#noSearchOrgMessage').show();
            }
        }
    }

    function changeTableContentColor(orgOrSpace) {
        var listToShow = $('#'+orgOrSpace+'Table div[id*="orgSpaceViewArea-table-content-'+orgOrSpace+'-no"]:not([style*="display: none"])')
        $.each(listToShow, function (eventId, eventData){
            if(eventId%2 === 1){
                document.getElementById(eventData.id).className = "mainViewArea-table-content content-v2"
            } else {
                document.getElementById(eventData.id).className = "mainViewArea-table-content"
            }
        });
    }



</script>


<%--TITLE--%>
<div class="col-sm-6 pt30">
    <h4 class="modify_h4 fwn">조직 및 공간 조회</h4>
</div>

<%--SEARCH FORM--%>
<div class="content-box2 col-md-12 col-md-offset-13">
    <div class="box">
        <div class="input-group col-sm-12 ml20">
            <div class="input-group-btn">
                <button type="button" id="btnSearch" class="btn" style="margin: 0 0 0 0; color: #c4c3c3; background-color: #f7f7f9; height: 30px;">
                    <span class="glyphicon glyphicon-search" style="top: -1px; left: 4px;"></span>
                </button>
            </div>
            <input type="text" id="org-searchKeyword" class="form-control ml3" style="top: -6px; left: -3px; width: 99%;" maxlength="100" placeholder="검색어를 입력하세요." onkeyup="searchOrg()">
        </div>
    </div>
</div>

<div class="row">
    <div class="panel content-box col-sm-12 col-md-12 mt-50 col-md-offset-13 w98">
        <div class="col-sm-6 pt5"> </div>

        <div style="margin: 20px 0 0 10px; width:98%;">

            <div class="box" align="center">
                <div class="custom-boxL" style="width: 49.5%">

                    <div class="orgArea">
                        <div class="mainViewArea-table" id="orgTable" style="display: none">
                        </div>
                        <div id="noOrgMessage" class='mainViewArea-message' style="display: none">생성된 조직이 없습니다.</div>
                        <div id="noSearchOrgMessage" class='mainViewArea-message' style="display: none">검색된 조직이 없습니다.</div>
                    </div>
                </div>

                <div class="custom-boxR" style="width: 49.5%">
                    <div class="spaceArea">
                        <div id="spaceTable" class="mainViewArea-table" style="display: none">
                        </div>
                        <div id="noSpaceMessage" class='mainViewArea-message' style="display: none">생성된 공간이 없습니다.</div>
                    </div>

                </div>
            </div>

        </div>
    </div>
</div>

<%--///////////--%>

<%--
<div class="mainViewArea" id="orgSpaceViewArea">
    <h2> 조직 및 공간 조회 </h2>
    <div class="orgArea">
        <label class="control-label sr-only" for="org-searchKeyword"></label>
        <div class="input-group">
            <span class="input-group-addon">
                <span class="glyphicon glyphicon-search" aria-hidden="true"></span>
            </span>
            <input type="text" class="form-control custom-input-text" id="org-searchKeyword" maxlength="100" placeholder="검색어를 입력하세요." onkeyup="searchOrg()">
        </div>

<div class="box">
    <div class="custom-boxL">
        <div class="orgArea">
            <div class="mainViewArea-table" id="orgTable" style="display: none">
            </div>
            <div id="noOrgMessage" class='mainViewArea-message' style="display: none">생성된 조직이 없습니다.</div>
            <div id="noSearchOrgMessage" class='mainViewArea-message' style="display: none">검색된 조직이 없습니다.</div>
        </div>
    </div>

    <div class="custom-boxR">
        <div class="spaceArea">
            <div id="spaceTable" class="mainViewArea-table" style="display: none">
            </div>
            <div id="noSpaceMessage" class='mainViewArea-message' style="display: none">생성된 공간이 없습니다.</div>
        </div>
    </div>
</div>--%>

<%--FOOTER--%>
<%@ include file="../common/footer.jsp"%>