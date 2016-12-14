<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../layout/top.jsp" %>
<%@include file="../layout/left.jsp" %>

<div class="content" style="padding:10px;">

    <script id="jscode">
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
                    height:400,
                    colGroup : [
                        {key:"id", label:"ID", width:"60", align:""},
                        {key:"name", label:"App이름", width:"200"},
                        {key:"memory", label:"메모리", width:"100", align:"left"},
                        {key:"instances", label:"인스턴스수", width:"100", align:"left"},
                        {key:"state", label:"상태", width:"100", align:"right", align:"left"},
                        {key:"diskQuota", label:"디스크할당", width:"100", align:"left", formatter:"money"},
                        {key:"createdAt", label:"생성일자", width:"140", align:"center", formatter:"datetime"},
                        {key:"updatedAt", label:"수정일자", width:"140", align:"center", formatter:"datetime"}
                    ],
                    colHead : {
                        rows: [
                            [
                                {colSeq:0, rowspan:1},
                                {colSeq:1, align:"center"},
                                {colSeq:2, rowspan:1},
                                {colSeq:3, rowspan:1},
                                {colSeq:4, rowspan:1},
                                {colSeq:5, rowspan:1},
                                {colSeq:6, rowspan:1},
                                {colSeq:7, rowspan:1}
                            ]
                        ]
                    },
                    body : {
                        onclick: function(){
                            toast.push(Object.toJSON({index:this.index, r:this.r, c:this.c, item:this.item, page:this.page}));

                        }
                    },

                    page:{
                        paging:false,
                        pageNo:1,
                        pageSize:10
                    }
                });

                myGrid.setList({

                });

                //myGrid.setDataSet({price:123000, amount:10});
            }

        };
        jQuery(document.body).ready(function(){fnObj.pageStart()});



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


    <div id="AXPage">

        <!-- s.AXPageBody  -->
        <div id="AXPageBody" class="SampleAXSelect">
            <div id="demoPageTabTarget" class="AXdemoPageTabTarget"></div>
            <div class="AXdemoPageContent">

                <div class="title">
                    <h1>Apps 리스트</h1>
                </div>

                <div id="AXGridTarget" style="height:250px;"></div>
                <div class="H20"></div>

            </div>

        </div>
        <!-- e.AXPageBody  -->


    </div>


</div>

<%@include file="../layout/bottom.jsp" %>