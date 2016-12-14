<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>

    /**
     * Require Files for AXISJ UI Component...
     * Based        : jQuery
     * Javascript   : AXJ.js, AXGrid.js, AXInput.js, AXSelect.js
     * CSS          : AXJ.css, AXGrid.css, AXButton.css, AXInput.css, AXSelector.css
     */
    var myGrid2 = new AXGrid();

    var fnObj2 = {
        pageStart: function () {

            myGrid2.setConfig({
                targetID : "AXGridTarget2",
                theme : "AXGrid",
                fitToWidth:true,
                height:"auto",
                viewMode:"grid",
                colGroup : [
                    {key:"name", label:"이름", width:"350", align:"center"},
                    {key:"label", label:"제공서비스", width:"150", align:"center"},
                    {key:"plan", label:"연결앱수", width:"80", align:"center"},
                    {key:"boundApps", label:"서비스명", width:"150", align:"center"},
                    {key:"update", label:" ", width:"80", align:"left"}
                ],

                body : {
                    rows: [
                        [
                            {key:"name",  align:"left", formatter:function(){
                                return  "<div id='spaceNameNormal"+this.index+"' tyle='padding-bottom:10px'><span style='font-size:22px;font-weight: bold'>" + this.item.name  + "</span></div>" +
                                        "<div id='spaceNameEdit"+this.index+"' style='display:none;'><input type='text' maxlength='100' style='width:250px' class='form-control'  id='newServiceName" + this.index  + "' value='" + this.item.name  + "'>" +
                                        " <button type='button' class='btn btn-save btn-sm' onclick=\"renameInstanceService('"+ this.item.guid + "', 'newServiceName" + this.index + "','grid');\">변경</button>" +
                                        " <button type='button' class='btn btn-cancel btn-sm' onclick=\"$('#spaceNameNormal"+this.index+"').show(); $('#spaceNameEdit"+this.index+"').hide();\">취소</button>" +
                                        "</div>";
                            }},
                            {key:"servicePlanName",  align:"left", formatter:function(){

                                if(this.item.servicePlanName == null){
                                    this.item.servicePlanName = "";
                                }

                                return  "<div style='padding-bottom:10px'><span style='font-size:16px;font-weight: '>" + this.item.servicePlanName + "</span></div>" ;
                            }},
                            {key:"boundAppCount",  align:"center", formatter:function(){
                                return  "<div style='padding-bottom:10px'><span style='font-size:16px;font-weight: '>" + this.item.boundAppCount + "</span></div>" ;
                            }},
                            {key:"serviceLabel",  align:"left", formatter:function(){

                                if(this.item.serviceLabel == null){
                                    this.item.serviceLabel = "user-provided";
                                }

                                return  "<span style='width:130px'>" + this.item.serviceLabel + "</span>";
                            }},
                            {key:"update",  align:"center", formatter:function(){

                                return "<button type='button' class='btn btn-default btn-sm' aria-label='Left Align' onclick='popContextMenu2(\""+this.item.name+"\","+this.index+");'>"+
                                        "<span class='glyphicon glyphicon-cog' aria-hidden='true'></span>"+
                                        "</button> ";
                            }}

                        ]
                    ],
                },


                page:{
                    paging:false
                },

                contextMenu: {
                    theme: "AXContextMenu", // 선택항목
                    width: "180", // 선택항목
                    menu: [
                        {
                            userType: 1, label: "서비스 이름 변경", className : "edit", onclick: function () {

                            if(this.sendObj) {
                                $("#spaceNameNormal"+this.sendObj.index).hide();
                                $("#spaceNameEdit"+this.sendObj.index).show();
                            }
                        }
                        },
                        {
                            userType: 1, label: "서비스 삭제", className: "minus", onclick: function () {
                            if (this.sendObj) {
                                deleteServiceModal(serviceList[this.sendObj.index].guid);
                            }
                        }
                        }
                    ],
                    filter: function (id) {
                        return true;
                    }
                }
            });

            var data = {
                list: serviceList
            };

            myGrid2.setData(data);

        },


        changeView: function(viewMode){

            if(viewMode == "grid"){
                myGrid2.changeGridView({
                    viewMode:viewMode
                });
            }else if(viewMode == "icon") {
                myGrid2.changeGridView({
                    viewMode: viewMode,
                    view: {
                        // 속성이 없을때 예외 처리 마지막에 구현
                        width: "440",
                        height: "120",
                        label: {left: "5", top: "5", width: "60", height: "110"},
                        description: {left: "70", top: "10", width: "370", height: "115", style: "color:#333;"},
                        format: function () {

                            return {

                                label: "<div style='margin:3px;'><img src='https://api.jujucharms.com/charmstore/v5/~cf-charmers/trusty/cf-dea-31/icon.svg' width=50 height=50 style='border:1px solid #ccc;'></div>" +
                                "<div style='margin:3px;'></div>",

                                description: "<span id='spaceNameNormal"+this.index+"' style='font-size:22px;font-weight: bold'>" + this.item.name + "<br></span> " +

                                            "<div id='spaceNameEdit"+this.index+"' style='display:none;'><input type='text' maxlength='100' style='width:250px' class='form-control'  id='newServiceName" + this.index  + "' value='" + this.item.name  + "'>" +
                                            " <button type='button' class='btn btn-save btn-sm btn-sm' onclick=\"renameInstanceService('"+ this.item.guid + "', 'newServiceName" + this.index + "','icon');\">변경</button>" +
                                            " <button type='button' class='btn btn-cancel btn-sm btn-sm' onclick=\"$('#spaceNameNormal"+this.index+"').show(); $('#spaceNameEdit"+this.index+"').hide();\">취소</button>" +
                                            "</div>" +

                                            this.item.serviceLabel + "<br>" +
                                            this.item.servicePlanName + "<br>" +
                                            "<div style='font-size:14px;'> 연결앱 수: " +
                                            this.item.boundAppCount + "&nbsp;&nbsp;" +
                                            "<button type='button' class='btn btn-default btn-sm' aria-label='Left Align' onclick='popContextMenu2(\""+this.item.name+"\","+this.index+", \""+this.item.servicePlanName+"\");'>"+
                                            "<span class='glyphicon glyphicon-cog' aria-hidden='true'></span>"+
                                            "</button> "+
                                            "</div>"
                            }
                        }
                    }

                });
            }
        }

    }


    function popContextMenu2(name, index, servicePlanName){
        if(servicePlanName === ""){
            AXContextMenu.bind({
                id:"userProvidedContextMenu",
                theme:"AXContextMenu", // 선택항목
                width:"180", // 선택항목
                menu:[
                    {
                        userType: 1, label: "서비스 이름 변경", className : "edit", onclick: function () {

                        if(this.sendObj) {
                            $("#spaceNameNormal"+this.sendObj.index).hide();
                            $("#spaceNameEdit"+this.sendObj.index).show();
                        }
                    }
                    },
                    {
                        userType: 1, label: "서비스 수정", className: "copy", onclick: function () {
                        if (this.sendObj) {
                            clickUpdateUPService(serviceList[this.sendObj.index].name);
                        }
                    }
                    },
                    {
                        userType: 1, label: "서비스 삭제", className: "minus", onclick: function () {
                        if (this.sendObj) {
                            deleteServiceModal(serviceList[this.sendObj.index].guid);
                        }
                    }
                    }
                ]
            });
            AXContextMenu.open({id:"userProvidedContextMenu", sendObj: {index: index, item: {name: name} } }, event);
        } else {
            AXContextMenu.open({id:"AXGridTarget2ContextMenu", sendObj: {index: index, item: {name: name} } }, event);
        }
    }



    function renameInstanceService(guid, newName){


        param = {
            orgName: currentOrg,
            spaceName: currentSpace,
            guid : guid,
            newName: $('#'+newName).val()
        }

        $.ajax({
            url: "/service/renameInstanceService",
            method: "POST",
            async: "false",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function(data){
                if(data){
                    showAlert('success',"서비스 이름이 수정되었습니다.");
                    getSpaceSummary(1,myGrid2.config.viewMode);
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


    function deleteServiceModal(guid){

        $("#modalTitle").html("서비스 삭제");
        $("#modalText").html("서비스를 삭제하면 되돌릴 수 없습니다. <br> 삭제하시겠습니까?");
        $("#modalCancelBtn").text("취소");
        $("#modalExecuteBtn").text("삭제");
        $("#modalExecuteBtn").show();
        $('#modalExecuteBtn').attr("onclick", "deleteService('"+guid+"')");

        $('#modal').modal('toggle');
    }

    function deleteService(guid){

        var tempServiceList = serviceList;
        var tempServiceListLength = tempServiceList.length;
        var boundAppCount = 0;
        var serviceName = "";
        var reqUrl = "";
        var param = {};

        for (var i = 0; i < tempServiceListLength; i++) {
            if (guid == tempServiceList[i].guid) {
                boundAppCount = tempServiceList[i].boundAppCount;
                serviceName = tempServiceList[i].name;
            }
        }

        if (0 != boundAppCount) {
            reqUrl = "/service/deleteInstanceServiceForBoundApp";

            param = {
                orgName: currentOrg,
                spaceName: currentSpace,
                guid: guid,
                name: currentApp,
                serviceName: serviceName
            }
        } else {
            reqUrl = "/service/deleteInstanceService";

            param = {
                orgName: currentOrg,
                spaceName: currentSpace,
                guid: guid
            };
        }

        $.ajax({
            url: reqUrl,
            method: "POST",
            async: "false",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function(data){
                if(data){
                    showAlert('success',"서비스가 삭제되었습니다.");
                    getSpaceSummary(1,myGrid2.config.viewMode);
                }
            },
            error: function(xhr,status,error){
                showAlert("fail",JSON.parse(xhr.responseText).message);
            },
            complete : function(data){
                $('#modal').modal('hide');
            }

        });
    }


    function createUserProvidedService(){

        param = {
            orgName: currentOrg,
            spaceName: currentSpace,
            serviceInstanceName: $("#createUP-Name-TextField").val(),
            credentials:  $("#createUP-Credentials-TextField").val(),
            syslogDrainUrl: $("#createUP-SyslogURL-TextField").val()
        }

        $.ajax({
            url: "/service/createUserProvidedService",
            method: "POST",
            async: "false",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function(data) {
                if(data) {
                    showAlert("success","User Provided 서비스가 생성되었습니다.");
                    getSpaceSummary(1,myGrid2.config.viewMode);
                    clickCreateUPCancelBtn()
                }
            },
            error: function(xhr,status,error) {
                showAlert("fail",JSON.parse(xhr.responseText).message);
            },
            complete : function(data) {

            }
        });
    }


    function toggleCreateUPBox(){
        $("#createUserProvided").slideToggle();
    }


    function UPValidation(id, originValue){
        var inputValue = $("#"+id+"-TextField").val()
        var action = id.split('-')[0];
        var type = id.split('-')[1];

        if(action === 'updateUP' && originValue === inputValue){
            textFieldChange(id, "warning");
            updateBTNOnOrOff()
            //수정 시에는 기존값을 입력하면 warning 표시를 한다.
        } else if (inputValue == "") { //입력값이 없음

            if(type === "SyslogURL"){
                textFieldChange(id, "ok");
            } else {
                textFieldChange(id, "warning");
            }
            btnControll(action)
        } else {
            switch (type) {
                case 'Name' : nameValidation(id, inputValue); break;
                case 'Credentials' : credentialsValidation(id, inputValue); break;
                case 'SyslogURL'  : syslogUrlValidation(id, inputValue); break;
                default : break;
            }

            btnControll(action)
        }
    }

    function nameValidation(id, inputValue) {
        var inputValidation= /^([a-zA-Z0-9.]+([a-zA-Z0-9-.][a-zA-Z0-9.]+)*){1,}?$/;
        var cnt = $.grep(serviceList, function(obj){ return obj.name == inputValue; }).length;
        if(inputValidation.test(inputValue) && cnt == 0){
            textFieldChange(id, "ok");
        } else {
            textFieldChange(id, "error");
        }
    }

    function btnControll(action){
        if(action === 'createUP'){
            createBTNOnOrOff()
        } else if(action ==='updateUP'){
            updateBTNOnOrOff()
        }
    }


    function credentialsValidation(id, inputValue) {
        //var inputValidation= /^([']{1}).*([']{1})$/;
        try {
            JSON.parse(inputValue)
            textFieldChange(id, "ok");
        } catch(e) {
            textFieldChange(id, "error");
        }

    }


    function syslogUrlValidation(id, inputValue) {
        var inputValidation= /^([a-zA-Z0-9/:]+([a-zA-Z0-9-][a-zA-Z0-9]+)*\.){1,}[a-zA-Z0-9]+([a-zA-Z0-9-][a-zA-Z0-9]+)?$/;

        if(inputValidation.test(inputValue)){
            textFieldChange(id, "ok");
        } else {
            textFieldChange(id, "error");
        }
    }


    function createBTNOnOrOff() {
        if(document.getElementById("createUP-Name-TextField").className === "form-control-ok" &&
            document.getElementById("createUP-Credentials-TextField").className === "form-control-ok" &&
            document.getElementById("createUP-SyslogURL-TextField").className === "form-control-ok"
        ) {
            document.getElementById("btn-addUserProvided").disabled = false;
        } else {
            document.getElementById("btn-addUserProvided").disabled = true;
        }
    }

    function updateBTNOnOrOff() {
        if(document.getElementById("updateUP-Name-TextField").className != "form-control-error" &&
            document.getElementById("updateUP-Credentials-TextField").className != "form-control-error" &&
            document.getElementById("updateUP-SyslogURL-TextField").className != "form-control-error")
        {
            if(document.getElementById("updateUP-Name-TextField").className === "form-control-ok" ||
                document.getElementById("updateUP-Credentials-TextField").className === "form-control-ok" ||
                document.getElementById("updateUP-SyslogURL-TextField").className === "form-control-ok")
            {
                document.getElementById("modalExecuteBtn").disabled = false;
            } else {
                document.getElementById("modalExecuteBtn").disabled = true;
            }
        } else {
            document.getElementById("modalExecuteBtn").disabled = true;
        }
    }


    function clickCreateUPCancelBtn() {
        $("#createUserProvided").slideToggle();
        var reset = function() {
            $("#createUP-Name-TextField").val("");
            $("#createUP-Credentials-TextField").val("");
            $("#createUP-SyslogURL-TextField").val("");
            textFieldChange('createUP-Name', "warning");
            textFieldChange('createUP-Credentials', "warning");
            textFieldChange('createUP-SyslogURL', "ok");
        }
        setTimeout(reset, 500)
    }

    function clickUpdateUPService(UPServiceInstanceName) {
        getUPService(UPServiceInstanceName)
    }

    function getUPService(userProvidedInstanceName){
        var param = {
            orgName: currentOrg,
            spaceName: currentSpace,
            serviceInstanceName: userProvidedInstanceName
        };

        $.ajax({
            url: "/service/getUserProvidedService",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function (data) {
                if (data) {
                    setUpdateUPServiceModal(data)
                }
            },
            error: function(xhr,status,error){
                showAlert("fail",JSON.parse(xhr.responseText).message);
            }
        });
    }

    function setUpdateUPServiceModal(data){

        var serviceInstanceName = data.entity.name;
        var credentials = JSON.stringify(data.entity.credentials);
        var syslogDrainUrl = data.entity.syslog_drain_url;

        $("#modalTitle").html("서비스 수정");
        $("#modalText").html(
            "<div style='width: 120px; float:left; margin-top: 14px;'>서비스 이름</div> " +
            "<div class='inner-addon right-addon'> " +
            "<input id='updateUP-Name-TextField' type='text' maxlength='100' class='form-control-warning' onkeyup=UPValidation(\"updateUP-Name\",'"+serviceInstanceName+"') value='"+serviceInstanceName+"' style='width: 70%'> " +
            "<span id='updateUP-Name-StatusIcon' class='glyphicon status-icon-warning'></span> " +
            "</div> " +
            "<div style='width: 120px; float:left; margin-top: 14px'>Credentials</div> " +
            "<div class='inner-addon right-addon'> " +
            "<input id='updateUP-Credentials-TextField' type='text' maxlength='100' class='form-control-warning' onkeyup=UPValidation(\"updateUP-Credentials\",'"+credentials+"') value='"+credentials+"' style='width: 70%'> " +
            "<span id='updateUP-Credentials-StatusIcon' class='glyphicon status-icon-warning'></span> " +
            "</div> " +
            "<div style='width: 120px; float:left; margin-top: 14px'>Syslog Drain URL</div> " +
            "<div class='inner-addon right-addon'>" +
            "<input id='updateUP-SyslogURL-TextField' type='text' maxlength='100' class='form-control-warning' onkeyup=UPValidation(\"updateUP-SyslogURL\",'"+syslogDrainUrl+"') value='"+syslogDrainUrl+"' style='width: 70%'> " +
            "<span id='updateUP-SyslogURL-StatusIcon' class='glyphicon status-icon-warning'></span> " +
            "</div>"
        );
        $("#modalCancelBtn").text("취소");
        $("#modalExecuteBtn").text("수정");
        $("#modalExecuteBtn").show();
        $('#modalExecuteBtn').attr("onclick", "updateUPService('"+serviceInstanceName+"')");

        $('#modal').modal('toggle');
    }

    function updateUPService(userProvidedInstanceName) {

        var param = {
            orgName: currentOrg,
            spaceName: currentSpace,
            serviceInstanceName: userProvidedInstanceName,
            newServiceInstanceName: $("#updateUP-Name-TextField").val(),
            credentials: $("#updateUP-Credentials-TextField").val(),
            syslogDrainUrl: $("#updateUP-SyslogURL-TextField").val()
        };

        $.ajax({
            url: "/service/updateUserProvidedService",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function (data) {
                if (data) {
                    getSpaceSummary(1,myGrid2.config.viewMode);
                    showAlert("success","User Provided 서비스가 수정되었습니다.");
                }
            },
            error: function(xhr,status,error){
                showAlert("fail",JSON.parse(xhr.responseText).message);
            },
            complete : function(data){
                $('#modal').modal('hide');
            }
        });
    }

</script>


<div align="right" style='margin:3px;display:none;' id="AXGridTarget2View" >
    <button type="button" class="btn btn-createUserProvided btn-sm" onclick="toggleCreateUPBox()">User Provided 생성</button>
    <button type="button" class="btn btn-save btn-sm" onclick="fnObj2.changeView('icon');">썸네일</button>
    <button type="button" class="btn btn-save btn-sm" onclick="fnObj2.changeView('grid');">리스트</button>
</div>

<div id="createUP-Btn" align="right" style='margin:3px;display:none;'>
    <button  type="button" class="btn btn-createUserProvided btn-sm" onclick="toggleCreateUPBox()">User Provided 생성</button>
</div>

<div id="createUserProvided" class="create-userProvided-box" style="display: none;">
    <div style="margin-top: 5px">
        <div style="width: 120px; float:left; margin-top: 14px;">서비스 이름</div>
        <div class="inner-addon right-addon">
            <input id="createUP-Name-TextField" type="text" maxlength="100" class="form-control-warning" onkeyup="UPValidation('createUP-Name')" placeholder="서비스 이름" style="width: 60%">
            <span id="createUP-Name-StatusIcon" class="glyphicon status-icon-warning"></span>
        </div>
    </div>
    <div style="margin-top: 5px">
        <div style="width: 120px; float:left; margin-top: 14px">Credentials</div>
        <div class="inner-addon right-addon">
            <input id="createUP-Credentials-TextField" type="text" maxlength="200" class="form-control-warning" onkeyup="UPValidation('createUP-Credentials')" placeholder='EXAMPLE: {"username":"admin","password":"pa55woRD"}' style="width: 60%">
            <span id="createUP-Credentials-StatusIcon" class="glyphicon status-icon-warning"></span>
        </div>
    </div>
    <div style="margin-top: 5px">
        <div style="width: 120px; float:left; margin-top: 14px">Syslog Drain URL</div>
        <div class="inner-addon right-addon">
            <input id="createUP-SyslogURL-TextField" type="text" maxlength="200" class="form-control-ok" onkeyup="UPValidation('createUP-SyslogURL')" placeholder="Syslog Drain URL" style="width: 60%">
            <span id="createUP-SyslogURL-StatusIcon" class="glyphicon status-icon-ok"></span>
            <div style="float:right">
                <button type="button" class="btn btn-cancel btn-sm" onclick="clickCreateUPCancelBtn()">
                    취소
                </button>
                <button id="btn-addUserProvided" type="button" class="btn btn-save btn-sm" onclick="createUserProvidedService()" disabled="true">
                    추가
                </button>
            </div>
        </div>
    </div>
</div>

<div id="AXGridTarget2" style="height:320px;"></div>

<div id="AXGridTarget2Empty" style="margin:30px;height:100px;display:none;"  align="center">
    등록된 서비스가 없습니다. 서비스 추가를 클릭하여 연결하거나 <a href="#none">카탈로그</a>를 찾아보십시오
</div>
