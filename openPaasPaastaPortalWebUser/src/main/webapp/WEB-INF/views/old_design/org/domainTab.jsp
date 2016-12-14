<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
    //input Text Field에서 Enter 눌렀을 때 동작
    $("#addDomain-TextField").keypress(function (e) {
        if (e.which == 13) {
            e.preventDefault();
            if(document.getElementById("btn-addDomain").disabled == false) {
                addDomain()
            }
        }
    });

    function getDomains(doWhat, domainName){
        getDomainsWithStatus('private',doWhat, domainName);
        getDomainsWithStatus('shared',doWhat, domainName);
        getDomainsWithStatus('all')
    }

    function getDomainsWithStatus(status, doWhat, domainName){
        var param = {}

        $.ajax({
            url: "/domain/getDomains/"+status,
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function(data) {
                if(data) {
                    if(status == 'all') {
                        $("#domainCnt").html(data.length)
                    } else if (status == 'private'){
                        if(doWhat == 'add'||doWhat=='delete'){
                            updateDomainBox(doWhat, domainName)
                        } else {
                            $("#privateDomainBox *").remove();
                            setDomainList(status, data)
                        }
                    } else if (status == 'shared'){
                        if(doWhat == 'add'||doWhat=='delete'){
                            //미구현
                        } else {
                            $("#sharedDomainBox *").remove();
                            setDomainList(status, data)
                        }
                    }
                }
            },
            error: function(xhr,status,error) {
                showAlert("fail",JSON.parse(xhr.responseText).message)
            },
            complete : function(data) {

            }
        });
    }

    function setDomainList(status, data) {

        if(status == "private") {
            $.each(data, function(eventID,eventData){
                $("#privateDomainBox").append(
                    "<div id='domain-"+eventData.name.replace(/./gi,'-')+"' class='domain-list-box'>"+eventData.name+
                    "<button type='button' class='close'  onclick=removePrivateDomainPopUp('"+eventData.name+"')>"+
                    "<span class='glyphicon glyphicon-remove' style='font-size: 14px;' aria-hidden='true'></span>"+
                    "</button>"+
                    "</div>"
                )
            });
        } else if (status == "shared") {
            $.each(data, function(eventID,eventData){
                $("#sharedDomainBox").append(
                    "<span style='width:70%; float:left'>"+eventData.name+"</span>"+
                    "<span style='float:center; color:darkgrey'>SHARED</span>"
                )
            });
        }
    }

    function addDomain() {

        var domainName = $("#addDomain-TextField").val()

        var param = {
            orgName: currentOrg,
            spaceName: $("#spaceList").find('li').find('a')[0].textContent,
            domainName: domainName
        }

        $.ajax ({
            url: "/domain/addDomain",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function(data) {
                if(data){
                    getDomains('add', domainName);
                    clickAddDomainCancelBtn()
                    showAlert("success","도메인을 추가하였습니다.")
                }
            },

            error: function(xhr,status,error){
                showAlert("fail",JSON.parse(xhr.responseText).message)
            },
            complete : function(data) {

            }
        });
    }

    function removePrivateDomainPopUp(domainName){
        $("#modalTitle").html("도메인 삭제");
        $("#modalText").html("'"+domainName+"' 도메인을 삭제하시겠습니까?");
        $("#modalCancelBtn").text("취소");
        $("#modalExecuteBtn").text("삭제");
        $("#modalExecuteBtn").show();
        $('#modalExecuteBtn').attr('onclick', "deleteDomain('"+domainName+"')");

        $('#modal').modal('toggle');
    }

    function deleteDomain(domainName) {

        var param = {
            orgName: currentOrg,
            spaceName: $("#spaceList").find('li').find('a')[0].textContent,
            domainName: domainName
        }

        $.ajax({
            url: "/domain/deleteDomain",
            method: "POST",
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function(data){
                if(data){
                    getDomains('delete', domainName)
                    showAlert("success","도메인을 삭제하였습니다.")
                }
            },
            error: function(xhr,status,error){
                showAlert("fail",JSON.parse(xhr.responseText).message)
            },
            complete : function(data){

            }
        });
    }

    function updateDomainBox(doWhat, domainName){
        if(doWhat == 'add'){
            $("#privateDomainBox").append(
                "<div id='domain-"+domainName.replace(/./gi,'-')+"' class='domain-list-box'>"+domainName+
                    "<button type='button' class='close'  onclick=removePrivateDomainPopUp('"+domainName+"')>"+
                        "<span class='glyphicon glyphicon-remove' style='font-size: 14px;' aria-hidden='true'></span>"+
                    "</button>"+
                "</div>"
            )
        } else if(doWhat == 'delete'){
            $("#domain-"+domainName.replace(/./gi,'-')).remove()
            $('#modal').modal('hide');
        }
    }

    function clickAddDomainCancelBtn() {
        $("#addDomainBox").slideToggle();
        var reset = function() {
            $("#addDomain-TextField").val("");
            textFieldChange('addDomain', 'warning')
        }
        setTimeout(reset, 500)
    }

    function domainValidation(id) {
        var newDomain = $("#addDomain-TextField").val()
        var domain_validation= /^([a-zA-Z0-9]+([a-zA-Z0-9-][a-zA-Z0-9]+)*\.){1,}[a-zA-Z0-9]+([a-zA-Z0-9-][a-zA-Z0-9]+)?$/;

        if (newDomain == "") {
            //도메인 이름이 없음
            textFieldChange(id, 'warning')
            document.getElementById("btn-addDomain").disabled = true;

        } else{
            if(!domain_validation.test(newDomain)) {
                //적절하지 않은 도메인 명
                textFieldChange(id, 'error')
                document.getElementById("btn-addDomain").disabled = true;
            } else {
                textFieldChange(id, 'ok')
                document.getElementById("btn-addDomain").disabled = false;
            }
        }
    }



</script>

    <div align="right" style='margin:3px;'>
        <button type="button" class="btn btn-save btn-sm" onclick="toggleBox('addDomain')" >
            도메인 추가
        </button>
    </div>
    <div class="tab-title-box" style="background-color: #e2e3e4;">
        도메인
    </div>

    <div id="addDomainBox" class="tab-title-box" style="display: none;">
        <div class="inner-addon right-addon">
            <input id="addDomain-TextField" type="text" maxlength="100" class="form-control-warning" onkeyup="domainValidation('addDomain')" placeholder="추가할 도메인을 입력하세요." style="width: 70%">
            <span id="addDomain-StatusIcon" class="glyphicon status-icon-warning"></span>
            <div style="float:right; margin-top: 10px">
                <button type="button" class="btn btn-cancel btn-sm" onclick="clickAddDomainCancelBtn()">
                    취소
                </button>
                <button id="btn-addDomain" type="button" class="btn btn-save btn-sm" onclick="addDomain()" disabled="true">
                    추가
                </button>
            </div>
        </div>
    </div>

    <div id="privateDomainBox">

    </div>
    <div id="sharedDomainBox" class="domain-shared-list-box">

    </div>