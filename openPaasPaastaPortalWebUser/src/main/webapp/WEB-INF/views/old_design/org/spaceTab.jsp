<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>


    /**
     * Require Files for AXISJ UI Component...
     * Based        : jQuery
     * Javascript   : AXJ.js, AXGrid.js, AXInput.js, AXSelect.js
     * CSS          : AXJ.css, AXGrid.css, AXButton.css, AXInput.css, AXSelector.css
     */
    var pageID = "ajax";
    var myGrid = new AXGrid();
    var itemSum = 0;

    var fnObj = {
        pageStart: function(){

            myGrid.setConfig({
                targetID : "AXGridTarget",
                theme : "AXGrid",
                fitToWidth:true,
                height:"auto",
                viewMode:"grid",
                colGroup : [
                    {key:"name", label:"공간", width:"200", align:"center"},
                    {key:"appCount", label:"앱", width:"200", align:"center"},
                    {key:"serviceCount", label:"서비스", width:"200", align:"center"}
                ],


                body : {
                    rows: [
                        [
                            {key:"name",  align:"left", formatter:function(){
                                return  "<div style='padding-bottom:10px'><span style='font-size:22px;font-weight: bold'><a href='#none' onclick=\"setSpaceSession('"+this.item.name+"');location='/space/spaceMain'\">" + this.item.name  + "</a></span></div>" +
                                        parseInt(this.item.memDevTotal / memoryLimit *100)  + "% 메모리 사용중";
                            }},
                            {key:"appCount",  align:"center", formatter:function(){
                                return  "<div style='padding-bottom:10px'><span style='font-size:22px;font-weight: bold'>" + this.item.appCount  + "</span></div>" +
                                        "사용중:"+ this.item.appCountStarted +" 중지됨:"+ this.item.appCountStopped +" 다운됨:"+ this.item.appCountCrashed +"";
                            }},
                            {key:"serviceCount",  align:"center", formatter:function(){
                                return  "<span style='font-size:22px;font-weight: bold'>" + this.item.serviceCount  + "</span>";
                            }}
                        ]
                    ],

                },

                page:{
                    paging:false,
                    pageNo:1,
                    pageSize:10
                },


                editor: {
                    rows: [
                        [
                            {colSeq:0, align:"left", rowspan:"2", valign:"top"
                                , form:{type:"text", value:"itemValue", height:"30", style:"maxlength:'4'"}
                                , AXBind:{type:"text", config:{min:0, max:5}}}
                        ]
                    ],
                    response: function(){

                        if(this.index == null){ // 추가
                            if(this.res.item.name == ""){
                                showAlert("fail", INFO_EMPTY_REQUEST_DATA);
                                $('#AXGridTarget_AX_name_AX_0_AX_0').focus();
                                //alert("공간 이름을 입력해 주십시요.");
                                return false;
                            }else{
                                createSpace(this.res.item.name);
                                getOrgSummary();
                            }

                        }
                    }
                }




            });

            var data = {
                list: spaceList
            };

            $('#tabs a[href="#spaceTab"]').tab('show');

            myGrid.setData(data);

        },
        appendGrid: function(index){
            var item = {name:''};
            myGrid.appendList(item);
            $("#AXGridTarget_AX_editorButtons_AX_save").val("생성");
            $("#AXGridTarget_AX_editorButtons_AX_save").attr("class","btn btn-save btn-sm");
            $("#AXGridTarget_AX_editorButtons_AX_cancel").attr("class","btn btn-cancel btn-sm");
            $('#AXGridTarget_AX_name_AX_0_AX_0').focus();

        }

    };

    //Axis grid fomatter 추가
    Object.extend(AXGrid.prototype.formatter, {
        "datetime": function (formatter, item, itemIndex, value, key, CH, CHidx) {
            if (!value) return '';

            return (value).date().print("yyyy-mm-dd hh:mi:ss");
        }
    });

    Object.extend(AXGrid.prototype.formatter, {
        "date": function (formatter, item, itemIndex, value, key, CH, CHidx) {
            if (!value) return '';

            return (value).date().print("yyyy-mm-dd");
        }
    });




</script>


<div align="right" style='margin:3px; display:none;' id="createSpaceBtn">
    <button type="button" class="btn btn-save btn-sm" onclick="fnObj.appendGrid();" >
        + 공간 생성
    </button>
</div>

<div id="AXGridTarget" style="height:320px;"></div>
<div class="H20"></div>