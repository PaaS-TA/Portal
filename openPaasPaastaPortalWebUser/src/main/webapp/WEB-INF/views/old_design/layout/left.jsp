<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
    var isAdmin = <%=request.isUserInRole("ROLE_ADMIN")%>;

    $(document).ready(function () {
        getOrgs()
        getManagedOrgForUser()

        $('#createSpace-TextField').keypress(function (e) {
            if (e.which == 13) {
                e.preventDefault();
                if (document.getElementById("btn-createSpace").disabled == false) {
                    createSpace()
                }
            }
        });
    });


    function setOrgSelectBox(data,isRemoveOrgFromUser) {
        $("#orgList *").remove();
        $.each(data, function (eventID, eventData) {
            $("#orgList").append(
                "<li value='"+eventData.name+"'>" +
                    "<a style='cursor:pointer' onclick=selectOrg('"+eventData.name+"')>"+eventData.name+"</a>" +
                "</li>"
            );
        });

        var isOrgExist = true;
        if ($("#orgList [value = '"+currentOrg+"']").text() == "") {
            isOrgExist = false;
        }

        if (!isOrgExist || currentOrg == null || currentOrg == "null") {
            currentOrg =  $("#orgList").find('li').find('a')[0].textContent
            currentSpace = null
            setOrgSession(currentOrg, isRemoveOrgFromUser)
        }  else{
            document.getElementById("menuCurrentOrg").textContent = currentOrg;
        }
        getSpaces(currentOrg)
    }

    function setSpaceList(data) {
        $("#spaceList *").remove();
        $.each(data, function (eventID, eventData) {
            $("#spaceList").append(
                "<li value='"+eventData.name+"'>" +
                    "<span onclick='selectSpace($(this).text());'>" +
                        "<a id='"+eventData.name+"-SpaceList-SpaceName' href='#'>"+eventData.name+"</a>" +
                    "</span>" +
                "</li>"
            )
            spaceListColorChange(eventData.name)
        });
    }

    function selectOrg(orgName) {

        currentSpace = null
        setOrgSession(orgName);
        setSpaceSession(currentSpace)

        getManagedOrgForUser()
        getSpaces(currentOrg)
    }


    function selectSpace(spaceName) {
        setSpaceSession(spaceName);
    }

    function createSpace(spaceName) {

        if(spaceName){
            newSpaceName = spaceName;
        }else{
            var newSpaceName = $("#createSpace-TextField").val();
        }

        var param = {
            orgName: currentOrg,
            newSpaceName: newSpaceName
        }

        $.ajax({
            url: "/space/createSpace",
            method: "POST",
            async: false,
            data: JSON.stringify(param),
            dataType: 'json',
            contentType: "application/json",
            success: function (data) {

                showAlert("success", currentOrg + " 조직에 " + newSpaceName + " 공간이 생성되었습니다.");
                getOrgSummary()
                getSpaces(currentOrg)
                //clickCreateSpaceCancel() - 추후 수정

            },
            error: function (xhr, status, error) {
                showAlert("fail", JSON.parse(xhr.responseText).message);
            }
        });
    }

    function toggleCreateSpaceBox(id) {
        if (isOrgManaged) {
            toggleBox(id)
        }
        else {
            showAlert("fail", currentOrg + " 조직에 공간을 생성할 권한이 없습니다.");
        }
    }


    function spaceExistCheck() {
        var newSpaceName = $("#createSpace-TextField").val();

        if (newSpaceName =="") {
            textFieldChange("createSpace", "warning")
            document.getElementById("btn-createSpace").disabled = true;
            document.getElementById("errortxt").className = "errortxt dpn";
        } else if (newSpaceName != "" && $("#spaceList [value = '"+newSpaceName+"']").text() == "") {
            textFieldChange("createSpace", "ok")
            document.getElementById("btn-createSpace").disabled = false;
            document.getElementById("errortxt").className = "errortxt dpn";
        } else {
            textFieldChange("createSpace", "error")
            document.getElementById("btn-createSpace").disabled = true;
            document.getElementById("errortxt").className = "errortxt";
        }
    }

    function notYet() {
        alert("not yet")
    }

    function toggleMenu(id){
        $("#"+id).slideToggle()
    }

    function clickCreateSpaceCancel(){
        $("#createSpaceBox").slideToggle()
        var reset = function() {
            $("#createSpace-TextField").val("");
            textFieldChange('createSpace', 'warning')
        }
        setTimeout(reset, 500)
    }

    function setLeftUsername(username){
        $("#left_username").text(username);
    }

    function setLeftProfileImage(imgPath){
        $("#left_profileImagePath").attr("src", imgPath);
    }








</script>

<div class="container-fluid" id="main">
    <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
            <div class="userinfo">
                <sec:authentication property="principal.imgPath" var="imgPath"/>
                <c:choose>
                    <c:when test="${not empty imgPath}"><img class="circle" id="left_profileImagePath" src="<c:url value='${imgPath}'/>" alt="사용자"/></c:when>
                    <c:otherwise><img class="circle" id="left_profileImagePath" src="<c:url value='/resources/images/userpic.png'/>" alt="사용자"/></c:otherwise>
                </c:choose>
                <div class="name" id="left_username"><sec:authentication property="principal.name" /></div>
                <div class="dropdown">
                    <a class="mail dropdown-toggle" data-toggle="dropdown" id="dropdownTopMenu" href="javascript:void(0);">
                        <sec:authentication property="principal.username" /><span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownTopMenu" style="width: 100%;">
                        <li role="presentation"><a role="menuitem" href="#none" onClick="alertList()">알림</a></li>
                        <li role="presentation"><a role="menuitem" href="/user/myPage">내 계정</a></li>
                        <li role="presentation"><a role="menuitem" href="<c:url value='/myQuestion/myQuestionMain' />">내 문의</a></li>
                        <li role="presentation"><a href="javascript:document.getElementById('logout').submit()">로그아웃</a></li>
                    </ul>

                    <c:url value="/logout" var="logoutUrl"/>
                    <form id="logout" action="${logoutUrl}" method="post">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    </form>
                </div>
            </div>
            <div class="group_btn">
                <span><a href="/org/createOrgMain">조직생성</a></span>
            </div>
            <ul class="left-currentorg">
                <li>
                    <span>
                        <p id="menuCurrentOrg" style="float:left; width:85%;cursor:pointer" onclick="selectOrg(this.textContent)"></p>
                        <a style="float:right; width:15%;cursor:pointer" onclick="toggleMenu('orgList')"></a>
                    </span>
                </li>
            </ul>
            <!--조직 리스트 보기-->
            <ul id="orgList" class="smenu" style="display:none">
            </ul>
            <!--조직공간선택시 나타남-->
            <!--공간 생성-->
            <div class="area_btn">
                <span onclick="toggleCreateSpaceBox('createSpace')" style="cursor:pointer"><a>공간생성</a></span>
            </div>
            <!--공간버튼 클릭시 나타나는 팝업-->
            <div id="createSpaceBox" class="createSpace_pop" style="display: none;">

                <div class="inner-addon right-addon">
                    <input id="createSpace-TextField" maxlength="100" type="text" class="form-control-warning" onkeyup="spaceExistCheck()" placeholder="공간이름을 입력하세요." style="font-size: 13;margin: 0px; padding-right: 25px">
                    <span id="createSpace-StatusIcon" class="glyphicon status-icon-warning" style="padding:5px; right: 5; position: absolute"></span>
                    <p id="errortxt" class="errortxt dpn">공간명이 존재합니다.</p>
                    <button type="button" class="btn btn-cancel btn-sm" onclick="clickCreateSpaceCancel()" style="margin-top: 3px;margin-bottom: 3px">
                        취소
                    </button>
                    <button id="btn-createSpace" type="button" class="btn btn-save btn-sm" onclick="createSpace()" disabled="true" style="margin-top: 3px;margin-bottom: 3px">
                        생성
                    </button>
                </div>


            </div>
            <!--공간버튼 클릭시 나타나는 팝업-->
            <ul id="spaceList" class="left-spacelist">
            </ul>
            <!--//공간 생성-->
        </div>
        <div class="col-sm-9 col-sm-offset-4 col-md-10 col-md-offset-2 main">

