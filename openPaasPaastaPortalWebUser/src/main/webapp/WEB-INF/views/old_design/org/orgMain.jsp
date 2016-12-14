<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../layout/top.jsp" %>
<%@include file="../layout/left.jsp" %>
<%@include file="../layout/alert.jsp" %>
<script>

    var spaceList;
    var memoryLimit;
    var webIdeUrl;

    $(document).ready(function () {
        getOrgSummary();
        //$("#inviteUserTab").hide();
        $("#myTabs").change(function(){
            alert("The text has been changed.");
        });
    });

    function getOrgSummary() {

        $('#modalMask').modal('toggle');
        var spinner = new Spinner().spin();

        $('#org').val(currentOrg);
        $('#space').val(currentSpace);

        param = {
            orgName:  currentOrg
        };

        $.ajax({
            url: "/org/getOrgSummary",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function(data){
                if(data){
                    $("#memoryUsage").text(data.memoryUsage / 1024);
                    $("#memoryLimit").text(data.memoryLimit / 1024);
                    $("#memoryPercent").text(parseInt(data.memoryUsage / data.memoryLimit * 100));
                    $("#memoryBar").css("width", data.memoryUsage / data.memoryLimit * 100 + "%");

                    spaceList = data.spaces;

                    $("#spaceCnt").html(spaceList.length);

                    memoryLimit = data.memoryLimit;

                    fnObj.pageStart();

                    setOrgManagerButton();
                    getDomains();
                    initUserTab();
                    getWebIdeUser();
                }
            },
            error: function(xhr,status,error){
                showAlert('error', JSON.parse(xhr.responseText).message);
                spinner.stop();
                $('#modalMask').modal('hide');
                $('#myTabs li:eq(0) a').tab('show');
            },
            complete : function(data){
                spinner.stop();
                $('#modalMask').modal('hide');
                $('#myTabs li:eq(0) a').tab('show');
            }
        });
    }

    function setOrgManagerButton() {
        if(isOrgManaged == true){
            $("#renameOrgBtn").show();
            $("#deleteOrgBtn").show();
            $("#createSpaceBtn").show();
        }else{
            $("#renameOrgBtn").hide();
            $("#deleteOrgBtn").hide();
            $("#createSpaceBtn").hide();
        }
    }

    function renameOrgModal() {
        if (!procCheckValidStringSpace()) return false;
        if (!procCheckBlank()) return false;

        $("#modalTitle").html("조직명 수정");
        $("#modalText").html(currentOrg + " 조직명을 "+ $('#org').val() +" 으로 수정하시겠습니까?");
        $("#modalCancelBtn").text("취소");
        $("#modalExecuteBtn").text("수정");
        $("#modalExecuteBtn").show();
        $('#modalExecuteBtn').attr('onclick', 'renameOrg();');

        $('#modal').modal('toggle');
    }

    function procCheckBlank() {
        var reqOrg = $("#org");
        var reqOrgName = $("#org").val();
        if (reqOrgName.includes(' ')) {
            showAlert("fail", "조직명은 공백을 포함할 수 없습니다.");
            reqOrg.focus();
            return false;
        }

        console.log("size : " + reqOrgName.length);
        var createOrg_validation=/^[a-zA-Z-_.0-9ㄱ-ㅎ|ㅏ-ㅣ|가-힣]{1,15}\s?[a-zA-Z-_.0-9ㄱ-ㅎ|ㅏ-ㅣ|가-힣]{1,15}$/;
        if (!createOrg_validation.test(reqOrgName)) {
            showAlert("fail", "조직이름은 2자이상 30자 이하, 특수문자는 bar(-)와 underscore(_)만 허용합니다.");
            reqOrg.focus();
            return false;


    }


        return true;
    }


    function renameOrg() {
        param = {
            orgName:currentOrg,
            newOrgName:$('#org').val()
        };

        $.ajax({
            url: "/org/renameOrg",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function(data){
                if(data){
                    showAlert('success',"조직명이 수정되었습니다.");
                }
                setOrgSession($('#org').val());
                currentOrg = $('#org').val();
                getOrgs();

                $('#renameOrgBtn').attr('disabled', true);


            },
            error: function(xhr,status,error){
                showAlert('fail', JSON.parse(xhr.responseText).message);
            },
            complete : function(data){
                $('#modal').modal('hide');
            }

        });
    }


    function deleteOrgModal() {

        $("#modalTitle").html("조직명 삭제");
        $("#modalText").html("조직을 삭제하면 되돌릴 수 없습니다. <br> "+currentOrg+" 를  삭제하시겠습니까?");
        $("#modalCancelBtn").text("취소");
        $("#modalExecuteBtn").text("삭제");
        $("#modalExecuteBtn").show();
        $('#modalExecuteBtn').attr('onclick', 'deleteOrg();');

        $('#modal').modal('toggle');
    }

    function deleteOrg() {

        param = {
            orgName:currentOrg
        };

        $.ajax({
            url: "/org/deleteOrg",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function(data){
                if(data){
                    showAlert('success',"조직이 삭제되었습니다.");
                    currentOrg = null;
                    setOrgSession(currentOrg);

                    //$("#modalExecuteBtn").hide();
                    //$("#modalCancelBtn").text("확인");
                }
            },

            error: function(xhr,status,error){
                showAlert('fail', JSON.parse(xhr.responseText).message);
            },

            complete : function(data){
                $('#modal').modal('hide');
            }

        });
    }

    function getWebIdeUser(){

        param = {
            userId:  $('#dropdownTopMenu').text().trim(),
            orgName:  currentOrg
        };

        $.ajax({
            url: "/webIdeUser/getUser",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function(data){
                if(data){

                    $("#webIdeLinkBtn").hide();
                    $("#webIdeApplyBtn").hide();
                    $("#webIdeCancelBtn").hide();

                    if(data.useYn == "Y") {
                        webIdeUrl = data.url;
                        $("#webIdeLinkBtn").show();
                        $("#webIdeCancelBtn").show();
                    }else if(data.useYn == "N" && isOrgManaged == true) {
                        $("#webIdeCancelBtn").show();
                    }else if(isOrgManaged == true){
                        $("#webIdeApplyBtn").show();
                    }
                }
            }
        });
    }

    function openWebIdeUrl(){

        window.open(webIdeUrl, '_blank');

    }

    function applyWebIdeModal() {

        $("#modalTitle").html("WEB IDE 사용 신청");
        $("#modalText").html("WEB IDE(Eclipse Che)는 브라우저 기반 IDE 입니다.<br> 자세한 사항은 다음의 링크를 클릭해주십시요.<br> <a href='http://www.eclipse.org/che/' target='_blank'>http://www.eclipse.org/che/</a><br><br>  WEB IDE를 신청 하시면 관리자의 승인 후 조직 단위로 WEB IDE 영역이 할당됩니다. <br>"+currentOrg+" 조직의 WEB IDE 사용을 신청하시겠습니까?");
        $("#modalCancelBtn").text("취소");
        $("#modalExecuteBtn").text("신청");
        $("#modalExecuteBtn").show();
        $('#modalExecuteBtn').attr('onclick', 'applyWebIde();');

        $('#modal').modal('toggle');
    }

    function applyWebIde(){

        param = {
            userId:  $('#dropdownTopMenu').text().trim(),
            orgName:  currentOrg
        };

        $.ajax({
            url: "/webIdeUser/insertUser",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function(data){
                if(data){
                    showAlert('success',"WEB IDE 사용이 신청되었습니다.");
                    $("#webIdeCancelBtn").show();
                    $("#webIdeApplyBtn").hide();
                }
            },
            complete : function(data){
                $('#modal').modal('hide');
            }
        });

    }


    function cancelWebIdeModal() {

        $("#modalTitle").html("WEB IDE 신청 취소");
        $("#modalText").html(""+currentOrg+" 조직의 WEB IDE 사용 신청을 취소하시겠습니까?");
        $("#modalCancelBtn").text("취소");
        $("#modalExecuteBtn").text("취소신청");
        $("#modalExecuteBtn").show();
        $('#modalExecuteBtn').attr('onclick', 'cancelWebIde();');

        $('#modal').modal('toggle');
    }

    function cancelWebIde(){

        param = {
            orgName:  currentOrg
        };

        $.ajax({
            url: "/webIdeUser/deleteUser",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function(data){
                if(data){
                    showAlert('success',"WEB IDE 사용 신청이 취소되었습니다.");
                    $("#webIdeCancelBtn").hide();
                    $("#webIdeApplyBtn").show();
                }
            },
            complete : function(data){
                $('#modal').modal('hide');
            }
        });
    }

    function changeOrgName(){

        if($('#org').val() == currentOrg){
            $('#renameOrgBtn').attr('disabled', true );
        }else{
            $('#renameOrgBtn').attr('disabled', false);
        }

    }

    function clickUserTab(){
        $("#userTab1").show();
        $("#inviteUserTab").hide();
    }

</script>


<div class="search_box">
        <div class="box_group">
            <label class="label1" for="org" class="">조직</label>
            <div class="in_group w270px">
                <input type="text" maxlength="100" id="org" class="form-control toCheckString" onkeyup="changeOrgName();" onkeydown="if(event.keyCode==13) { renameOrgModal();  return false;}">
            </div>
            <button type="button" class="btn btn-cancel btn-sm" style='display:none;'  onClick="renameOrgModal()" id="renameOrgBtn" disabled>
                이름변경
            </button>
            <button type="button" class="btn btn_del" style='display:none;' onClick="deleteOrgModal()" id="deleteOrgBtn" >
                <span class="glyphicon glyphicon-trash"></span>
            </button>
            <button type="button" id="webIdeApplyBtn" class="btn btn-save btn-sm" onclick="applyWebIdeModal()" style='display:none;'  >
                WEB IDE 신청
            </button>
            <image src="/resources/images/web_ide.png" width="30"  id="webIdeLinkBtn"  onclick="openWebIdeUrl()" style='cursor:pointer; display:none;' >
            </image>
            <button type="button" id="webIdeCancelBtn" class="btn btn-save btn-sm" onclick="cancelWebIdeModal()" style='display:none;'  >
                WEB IDE 신청 취소
            </button>
        </div>
        <div class="box_group">
            <div class="progress ml80 w200px fl">
                <div class="progress-bar" role="progressbar" id="memoryBar" aria-valuenow="0" aria-valuemin="0"
                     aria-valuemax="100" style="width: 0%;">
                </div>
            </div>
            <span class="pr_txt fl"><span id="memoryUsage">0</span>GB 사용중 / <span id="memoryLimit">0</span>GB</span>
            <!--<button type="button" class="btn btn_extend">
                <span class="glyphicon glyphicon-resize-full"><span class="txt">할당량확장</span></span>
            </button>-->
        </div>
</div>
<!--//20160712변경-->
<!--메인탭-->
<div class="content">
    <ul class="nav nav-tabs" role="tablist"  id="myTabs">
        <li role="presentation" class="active"><a href="#spaceTab" aria-controls="spaceTab" role="tab" data-toggle="tab">공간(<span id="spaceCnt">0</span>)</a></li>
        <li role="presentation"><a href="#domainTab" aria-controls="appTab" role="tab" data-toggle="tab">도메인(<span id="domainCnt">0</span>)</a></li>
        <li role="presentation"><a href="#userTab" aria-controls="serviceTab" role="tab" data-toggle="tab" onclick="clickUserTab()">사용자(<span id="userCnt"><i class="fa fa-refresh fa-spin" style="font-size:11px" onclick="selectUserTab()"></i></span>)</a></li>
    </ul>
</div>
<!--메인탭-->
<!-- Tab panes -->
<div class="tab-content">

    <div role="tabpanel" class="tab-pane fade in active" id="spaceTab">
        <%@include file="./spaceTab.jsp" %>
    </div>
    <div role="tabpanel" class="tab-pane fade" id="domainTab">
        <%@include file="./domainTab.jsp" %>
    </div>
    <div role="tabpanel" class="tab-pane fade" id="userTab" style="overflow-scrolling: auto" >
        <div id="userTab1">
            <%@include file="./userTab.jsp" %>
        </div>
        <div id="inviteUserTab" >
            <%@include file="./inviteUserTab.jsp" %>
        </div>
    </div>
</div>
<%@include file="../layout/bottom.jsp" %>
