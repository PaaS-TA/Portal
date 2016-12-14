<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>

    /**
     * Require Files for AXISJ UI Component...
     * Based        : jQuery
     * Javascript   : AXJ.js, AXGrid.js, AXInput.js, AXSelect.js
     * CSS          : AXJ.css, AXGrid.css, AXButton.css, AXInput.css, AXSelector.css
     */
    var myGrid = new AXGrid();
    var fnObj = {
        pageStart: function(){

            myGrid.setConfig({
                targetID : "AXGridTarget",
                theme : "AXGrid",
                fitToWidth:true,
                height:"auto",
                viewMode:"grid",
                colGroup : [
                    {key:"name", label:"공간", width:"350", align:"center"},
                    {key:"instances", label:"인스턴스", width:"80", align:"center"},
                    {key:"memory", label:"메모리", width:"80", align:"center"},
                    {key:"updatedAt", label:"수정일자", width:"180", align:"center"},
                    {key:"state", label:"상태", width:"80", align:"center"},
                    {key:"update", label:" ", width:"120", align:"left"}
                ],

                body : {


                    rows: [
                        [
                            {key:"name",  align:"left", formatter:function(){
                                return  "<div id='appNameNormal"+this.index+"' style='padding-bottom:10px'><span style='font-size:22px;font-weight: bold'><a href='#none' onclick=\"setAppSession('"+this.item.name+"','"+this.item.guid+"');\">" + this.item.name  + "</a></span></div>" +
                                        "<div id='appNameEdit"+this.index+"' style='display:none;'><input type='text' maxlength='100' style='width:250px' class='form-control'  id='newAppName" + this.index  + "' value='" + this.item.name  + "'>" +
                                        " <button type='button' class='btn btn-save btn-sm btn-sm' onclick=\"renameApp('"+ this.item.name + "', 'newAppName" + this.index + "');\">변경</button>" +
                                        " <button type='button' class='btn btn-cancel btn-sm' onclick=\"$('#appNameNormal"+this.index+"').show(); $('#appNameEdit"+this.index+"').hide();\">취소</button>" +
                                        "</div>" +
                                         this.item.urls[0] ;
                            },
                                editor: {
                                    type: "text"
                                }
                            },
                            {key:"instances",  align:"center"},
                            {key:"memory",  align:"center"},
                            {key:"updatedAt",  align:"center", formatter:function(){
                                if(this.item.updatedAt != null) {
                                    return this.item.updatedAt.replace('T', '  ').replace('Z', ' ');
                                }
                            }},
                            {key:"state",  align:"center", formatter:function(){


                                var icon_class;
                                if(this.item.state == 'STARTED'){
                                    icon_class = "glyphicon-stop";
                                }else{
                                    icon_class = "glyphicon-play";
                                }

                                return  this.item.state ;
                            }},
                            {key:"update",  align:"center", formatter:function(){


                                var icon_class;
                                if(this.item.state == 'STARTED'){
                                    icon_class = "glyphicon-stop";
                                }else{
                                    icon_class = "glyphicon-play";
                                }

                                return "<button type='button' class='btn btn-save btn-sm' aria-label='Left Align' onclick='stateExec(\""+this.item.name+"\",\""+this.item.state +"\");'>"+
                                        "<span class='glyphicon "+icon_class+"' aria-idden='true'></span>"+
                                        "</button> &nbsp;"+
                                        "<button type='button' class='btn btn-default btn-sm' aria-label='Left Align' onclick='popContextMenu(\""+this.item.name+"\","+this.index+");'>"+
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
                    theme:"AXContextMenu", // 선택항목
                    width:"150", // 선택항목
                    menu:[
                        {
                            userType:1, label:"앱 이름 변경", className:"edit", onclick:function(){

                            if(this.sendObj){
                                //myGrid.setEditor(this.sendObj.item, this.sendObj.index);
                                $("#appNameNormal"+this.sendObj.index).hide();
                                $("#appNameEdit"+this.sendObj.index).show();

                            }
                        }
                        },
                        {
                            userType:1, label:"앱 삭제", className:"minus", onclick:function(){
                            deleteAppModal(this.sendObj.item.name);

                        }
                        }
                    ],
                    filter:function(id){
                        return true;
                    }
                }



            });

            var data = {
                list: appList
            };

            myGrid.setData(data);

        },

        changeView: function(viewMode){
            if(viewMode == "grid"){
                myGrid.changeGridView({
                    viewMode:viewMode
                });
            }else if(viewMode == "icon") {
                myGrid.changeGridView({
                    viewMode: viewMode,
                    view: {
                        // 속성이 없을때 예외 처리 마지막에 구현
                        width: "440",
                        height: "120",
                        label: {left: "5", top: "5", width: "60", height: "110"},
                        description: {left: "70", top: "10", width: "370", height: "115", style: "color:#333;"},
                        format: function () {

                            var state_text;
                            var icon_class;
                            if(this.item.state == 'STARTED'){
                                icon_class = "glyphicon-stop";
                                state_text = "실행 중";
                            }else{
                                icon_class = "glyphicon-play";
                                state_text = "정지";
                            }

                            return {

                                label: "<div style='margin:3px;'><img src='https://api.jujucharms.com/charmstore/v5/~cf-charmers/trusty/cf-dea-31/icon.svg' width=50 height=50 style='border:1px solid #ccc;'></div>" +
                                        "<div style='margin:3px;'></div>",

                                description: "<span id='appNameNormal"+this.index+"' style='font-size:22px;font-weight: bold'><a href='#none' onclick=\"setAppSession('"+this.item.name+"','"+this.item.guid+"');\">" + this.item.name + "</a><br></span>" +

                                                "<div id='appNameEdit"+this.index+"' style='display:none;'><input type='text' maxlength='100' style='width:250px' class='form-control'  id='newAppName" + this.index  + "' value='" + this.item.name  + "'>" +
                                                    " <button type='button' class='btn btn-save btn-sm btn-sm' onclick=\"renameApp('"+ this.item.name + "', 'newAppName" + this.index + "');\">변경</button>" +
                                                    " <button type='button' class='btn btn-cancel btn-sm' onclick=\"$('#appNameNormal"+this.index+"').show(); $('#appNameEdit"+this.index+"').hide();\">취소</button>" +
                                                "</div>" +

                                                this.item.urls[0] + "<br><br>" +
                                                "<div style='font-size:14px;'>" +
                                                state_text + "&nbsp;&nbsp;" +
                                                "<button type='button' class='btn btn-save btn-sm' aria-label='Left Align' onclick='stateExec(\""+this.item.name+"\",\""+this.item.state +"\");'>"+
                                                "<span class='glyphicon "+icon_class+"' aria-hidden='true'></span>" +
                                                "</button> &nbsp;"+
                                                "<button type='button' class='btn btn-default btn-sm' aria-label='Left Align' onclick='popContextMenu(\""+this.item.name+"\","+this.index+");'>"+
                                                "<span class='glyphicon glyphicon-cog' aria-hidden='true'></span>"+
                                                "</button> "+
                                                "</div>"
                            }
                        }
                    }

                });
            }
        }
    };

    function popContextMenu(name, index){
        AXContextMenu.open({id:"AXGridTargetContextMenu", sendObj: {index: index, item: {name: name} } }, event);
    }



    function setAppSession(name,guid){
        param = {
            name: name,
            guid: guid
        }

        $.ajax({
            url: "/app/setAppSession",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            complete: function(){
                location='/app/appMain'
            }
        });
    }




    function stateExec(appName, state){

        $('#modalMask').modal('toggle');
        var spinner = new Spinner().spin();

        param = {
            orgName: currentOrg,
            spaceName: currentSpace,
            name: appName
        }

        var url;
        if(state == "STARTED"){
            url = "/app/stopApp";
        }else{
            url = "/app/startApp";
        }

        $.ajax({
            url: url,
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function(data){
                if(data) {
                    if (url == "/app/stopApp"){
                        showAlert("success","앱이 중지되었습니다.");


                    }else{
                        showAlert("success","앱이 시작되었습니다.");

                    }
                }
            },

            error: function(xhr,status,error){
                showAlert('fail', JSON.parse(xhr.responseText).message);
            },

            complete : function(data){
                getSpaceSummary();
                spinner.stop();
                $('#modalMask').modal('hide');

            }

        });
    }




    function renameApp(name, newName){

        if(newName == ""){
            alert("앱 이름을 입력해 주십시요.");
            return false;
        }

        param = {
            orgName: currentOrg,
            spaceName: currentSpace,
            name: name,
            newName: $('#'+newName).val()
        }

        $.ajax({
            url: "/app/renameApp",
            method: "POST",
            async: "false",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function(data){
                if(data){
                    showAlert("success","앱명이 수정되었습니다.");
                }
            },
            error: function(xhr,status,error){
                showAlert("fail",JSON.parse(xhr.responseText).message);
            },
            complete : function(data){
                $('#modal').modal('hide');
                getSpaceSummary();
            }

        });
    }


    function deleteAppModal(name){

        $("#modalTitle").html("앱 삭제");
        $("#modalText").html("앱를 삭제하면 되돌릴 수 없습니다. <br> "+name+" 를  삭제하시겠습니까?");
        $("#modalCancelBtn").text("취소");
        $("#modalExecuteBtn").text("삭제");
        $("#modalExecuteBtn").show();
        $('#modalExecuteBtn').attr("onclick", "deleteApp('"+name+"')");

        $('#modal').modal('toggle');
    }

    function deleteApp(name){

        param = {
            orgName: currentOrg,
            spaceName: currentSpace,
            name: name
        }

        $.ajax({
            url: "/app/deleteApp",
            method: "POST",
            async: "false",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function(data){
                if(data){
                    deleteRoute(name)
                    showAlert("success","앱이 삭제되었습니다.");
                    location = "/space/spaceMain";
                }
            },
            error: function(xhr,status,error){
                showAlert("fail",JSON.parse(xhr.responseText).message);
            },
            complete : function(data){
                $('#modal').modal('hide');
                getSpaceSummary();
            }

        });
    }

    function deleteRoute(appName){

        var urls= $.grep(appList, function(e){ return e.name === appName; })[0].urls;
        param = {
            orgName: currentOrg,
            spaceName: currentSpace,
            urls: urls
        }

        $.ajax({
            url: "/app/deleteRoute",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function(data){
                if(data){

                }
            },
            error: function(xhr,status,error){
                showAlert("fail",JSON.parse(xhr.responseText).message)
            }
        });
    }



</script>


<div align="right" style='margin:3px;display:none;' id="AXGridTargetView" >
    <button type="button" class="btn btn-save btn-sm" onclick="fnObj.changeView('icon');">썸네일</button>
    <button type="button" class="btn btn-save btn-sm" onclick="fnObj.changeView('grid');">리스트</button>
</div>

<div id="AXGridTarget" style="height:320px;"></div>

<div id="AXGridTargetEmpty" style="margin:30px;height:100px;display:none;" align="center">
    생성한 앱이 없습니다. 앱 생성을 클릭 하여 작성하거나 <a href="#none">카탈로그</a>를 찾아보십시오.
</div>