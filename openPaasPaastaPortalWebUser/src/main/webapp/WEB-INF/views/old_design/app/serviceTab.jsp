<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>

    var serviceOpt = new Array();

    $(window).load(function(){
        getServices();
    });


    function getServices(){

        param = {
            orgName: currentOrg,
            spaceName: currentSpace
        }

        $.ajax({
            url: "/space/getSpaceSummary",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function (data) {


                $.each(data.services, function (id, list) {
                    if (0 == serviceList.length) return false;

                    var services = new Object();

                    if(JSON.stringify(serviceList).indexOf(list.name) < 0 ) {
                        services.value = list.name;
                        services.text = list.name;
                        serviceOpt.push(services);
                    }


                });

            }
        });
    }


    /**
     * Require Files for AXISJ UI Component...
     * Based        : jQuery
     * Javascript   : AXJ.js, AXGrid.js, AXInput.js, AXSelect.js
     * CSS          : AXJ.css, AXGrid.css, AXButton.css, AXInput.css, AXSelector.css
     */
    var myGrid1 = new AXGrid();

    var fnObj1 = {
        pageStart: function () {

            myGrid1.setConfig({
                targetID : "AXGridTarget1",
                theme : "AXGrid",
                fitToWidth:true,
                height:"auto",
                viewMode:"grid",
                colGroup : [
                    {key:"name", label:"이름", width:"300", align:"left"},
                    {key:"label", label:"제공서비스", width:"150", align:"left"},
                    {key:"boundApps", label:"서비스명", width:"200", align:"left"},
                    {key:"unbind", label:" ", width:"100", align:"center"},
                ],

                body : {
                    rows: [
                        [
                            {key:"name",  align:"left", formatter:function(){
                                return  "<div style='padding-bottom:10px'><span style='font-size:22px;font-weight: bold'>" + this.item.name  + "</span></div>" ;
                            }},
                            {key:"servicePlanName",  align:"left", formatter:function(){

                                if(this.item.service_plan == undefined){
                                    return  "<div style='padding-bottom:10px'><span style='font-size:16px;font-weight: '></span></div>" ;
                                }else{
                                    return  "<div style='padding-bottom:10px'><span style='font-size:16px;font-weight: '>" + this.item.service_plan.name + "</span></div>" ;
                                }

                            }},
                            {key:"serviceLabel",  align:"left", formatter:function(){

                                if(this.item.service_plan == undefined){
                                    return  "<span style='width:130px'>user-provided</span>&nbsp; &nbsp;&nbsp;";

                                }else {
                                    return "<span style='width:130px'>" + this.item.service_plan.service.label + "</span>&nbsp; &nbsp;&nbsp;";
                                }
                            }},
                            {key:"unbind",  align:"center", formatter:function(){

                                    return "<button type='button' class='btn btn-delete  btn-sm' onClick='unbindService(\""+this.item.name+"\")'>" +
                                            "연결해제" +
                                            "</button> ";

                            }},
                        ]
                    ],
                },


                page:{
                    paging:false
                },



                editor: {
                    rows: [
                        [
                            {colSeq:0, align:"left", rowspan:"2", valign:"top",
                                form: {
                                    type: "select",
                                    options: serviceOpt,
                                    AXBind:{
                                        type:"select", config: {
                                            onChange: function () {
                                                //trace(this);
                                            }
                                        }
                                    }
                                }

                            }
                        ]
                    ],
                    response: function(){

                        bindService(this.res.item.name);

                    }
                }

            });


            var data = {
                list: serviceList
            };

            myGrid1.setData(data);

        },

        appendGrid: function(index){
            var item = {name:''};

            myGrid1.appendList(item);

            $("#AXGridTarget1_AX_editorButtons_AX_save").val("연결");
            $("#AXGridTarget1_AX_editorButtons_AX_save").attr("class","btn btn-save btn-sm");
            $("#AXGridTarget1_AX_editorButtons_AX_cancel").attr("class","btn btn-cancel btn-sm");

        }

    }


    function bindService(serviceName){

        $('#modalMask').modal('toggle');
        var spinner = new Spinner().spin();

        param = {
            orgName: currentOrg,
            spaceName: currentSpace,
            name: currentApp,
            serviceName: serviceName
        }

        $.ajax({
            url: "/app/bindService",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",

            success: function (data) {
                showAlert("success",serviceName+" 서비스가 연결되었습니다");
            },

            error: function(xhr,status,error){
                showAlert("fail",JSON.parse(xhr.responseText).message);
            },

            complete : function(data){
                getAppSummary();
                spinner.stop();
                $('#modalMask').modal('hide');
            }
        });

    }


    function unbindService(serviceName){

        $('#modalMask').modal('toggle');
        var spinner = new Spinner().spin();

        param = {
            orgName: currentOrg,
            spaceName: currentSpace,
            name: currentApp,
            serviceName: serviceName
        }

        $.ajax({
            url: "/app/unbindService",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",

            success: function (data) {
                showAlert("success",serviceName+" 서비스가 해제되었습니다");
            },

            error: function(xhr,status,error){
                showAlert("fail",JSON.parse(xhr.responseText).message);
            },

            complete : function(data){
                getAppSummary();
                spinner.stop();
                $('#modalMask').modal('hide');
            }
        });

    }



</script>

<div align="right" style='margin:3px;' id="createSpaceBtn">
    <button type="button" class="btn btn-save btn-sm" onclick="fnObj1.appendGrid();" >
        + 서비스 연결
    </button>
</div>
<div style="margin: 5px;width:99%;">
    <div id="AXGridTarget1" style="height:220px;"></div>
</div>
