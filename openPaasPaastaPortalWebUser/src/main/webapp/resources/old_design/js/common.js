/**
 * Portal Web User - common.js
 **/

// Create Base64 Object
var Base64={_keyStr:"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",encode:function(e){var t="";var n,r,i,s,o,u,a;var f=0;e=Base64._utf8_encode(e);while(f<e.length){n=e.charCodeAt(f++);r=e.charCodeAt(f++);i=e.charCodeAt(f++);s=n>>2;o=(n&3)<<4|r>>4;u=(r&15)<<2|i>>6;a=i&63;if(isNaN(r)){u=a=64}else if(isNaN(i)){a=64}t=t+this._keyStr.charAt(s)+this._keyStr.charAt(o)+this._keyStr.charAt(u)+this._keyStr.charAt(a)}return t},decode:function(e){var t="";var n,r,i;var s,o,u,a;var f=0;e=e.replace(/[^A-Za-z0-9+/=]/g,"");while(f<e.length){s=this._keyStr.indexOf(e.charAt(f++));o=this._keyStr.indexOf(e.charAt(f++));u=this._keyStr.indexOf(e.charAt(f++));a=this._keyStr.indexOf(e.charAt(f++));n=s<<2|o>>4;r=(o&15)<<4|u>>2;i=(u&3)<<6|a;t=t+String.fromCharCode(n);if(u!=64){t=t+String.fromCharCode(r)}if(a!=64){t=t+String.fromCharCode(i)}}t=Base64._utf8_decode(t);return t},_utf8_encode:function(e){e=e.replace(/rn/g,"n");var t="";for(var n=0;n<e.length;n++){var r=e.charCodeAt(n);if(r<128){t+=String.fromCharCode(r)}else if(r>127&&r<2048){t+=String.fromCharCode(r>>6|192);t+=String.fromCharCode(r&63|128)}else{t+=String.fromCharCode(r>>12|224);t+=String.fromCharCode(r>>6&63|128);t+=String.fromCharCode(r&63|128)}}return t},_utf8_decode:function(e){var t="";var n=0;var r=c1=c2=0;while(n<e.length){r=e.charCodeAt(n);if(r<128){t+=String.fromCharCode(r);n++}else if(r>191&&r<224){c2=e.charCodeAt(n+1);t+=String.fromCharCode((r&31)<<6|c2&63);n+=2}else{c2=e.charCodeAt(n+1);c3=e.charCodeAt(n+2);t+=String.fromCharCode((r&15)<<12|(c2&63)<<6|c3&63);n+=3}}return t}};


function getOrgs(isRemoveOrgFromUser) {

    var param = {};

    $.ajax({
        url: "/org/getOrgs",
        method: "POST",
        data: JSON.stringify(param),
        dataType: 'json',
        async: 'false',
        contentType: "application/json",
        success: function (data) {
            if (data.length > 0) {
                setOrgSelectBox(data,isRemoveOrgFromUser);
                if ($(location).attr('pathname') == '/user/myPage') {
                    sortMyOrgs(data)
                }
            } else if($(location).attr('pathname') != '/org/createOrgMain'){
                location.href = "/org/createOrgMain";
            }
        },
        error: function (xhr, status, error) {
            location.href = "/login";
        }
    });
}

function getSpaces(orgName) {

    var param = {
        orgName: orgName
    };

    $.ajax({
        url: "/space/getSpaces",
        method: "POST",
        data: JSON.stringify(param),
        dataType: 'json',
        contentType: "application/json",
        success: function (data) {
            if (data) {
                setSpaceList(data)
            }
        },
        error: function (xhr, status, error) {
            $("#spaceList *").remove();
        },
        complete: function () {
            $('#createSpaceBox').hide()
        }
    });
}

//org session 저장
function setOrgSession(orgName, isRemoveOrgFromUser){

    currentOrg = orgName;

    var param = {
        orgName: currentOrg
    };

    $.ajax({
        url: "/org/setOrgSession",
        method: "POST",
        async: 'false',
        data: JSON.stringify(param),
        dataType: 'json',
        contentType: "application/json",
        success:  function () {
            document.getElementById("menuCurrentOrg").textContent = currentOrg;
            if(!isRemoveOrgFromUser){
                moveLocationOrgMain()
            }
        },
        complete: function () {

        }
    });
}


function getManagedOrgForUser() {

    var managedOrgList;
    var param = {};

    $.ajax({
        url: "/user/getListForTheUser/managed_organizations",
        method: "POST",
        data: JSON.stringify(param),
        dataType: 'json',
        contentType: "application/json",
        success: function (data) {
            if(isAdmin == true){
                isOrgManaged = true;
            } else {
                managedOrgList = data;
                $.each(managedOrgList, function (eventID, eventData) {
                    if (eventData.orgName == currentOrg) {
                        isOrgManaged = true;
                        return false;
                    }
                    isOrgManaged = false;
                });
            }

            if ($(location).attr('pathname') == '/org/orgMain') {
                setOrgManagerButton()
            }
        },
        error: function (xhr, status, error) {
            showAlert("fail", JSON.parse(xhr.responseText).message);
        }
    });
}

//space session 저장
function setSpaceSession(spaceName){

    var param = {
        spaceName: spaceName
    };

    $.ajax({
        url: "/space/setSpaceSession",
        method: "POST",
        data: JSON.stringify(param),
        dataType: 'json',
        contentType: "application/json",
        success: function (data) {
            if(spaceName){
                $("#"+currentSpace+"-SpaceList-SpaceName").css('color','');
                currentSpace = spaceName;
                if(spaceName != null){
                    spaceListColorChange(spaceName)
                }
                moveLocationSpaceMain()
            }
        },
        complete: function(){

        }
    });
}

//orgMain 으로 화면전환
function moveLocationOrgMain(){
    if(currentOrg == null || $(location).attr('pathname') != '/org/orgMain'){
        location.href="/org/orgMain";
    } else {
        getOrgSummary()
    }
}

//spaceMain 으로 화면전환
function moveLocationSpaceMain(){
    if($(location).attr('pathname') != '/space/spaceMain') {
        location.href = "/space/spaceMain";
    } else {
        getSpaceSummary();
    }
}

//알림창 공통 함수
function showAlert(type, message){

    id = $('#dropdownTopMenu').text().trim();

    if(type == "success"){
        color = "blue";
    }else if(type == "fail"){
        color = "red";
    }else{
        color = type;
    }

    if (AXUtil.getCookie("cookie_alert_close" + id) != "Y") {

        $("#alert").show();
    }

    $("#alertMsg").fadeOut(500);
    $("#alertMsg").html("<font color='"+ color +"'>" + message + "</font>");
    $('#alertMsg').fadeIn(1000);

    //setTimeout("hideAlert()",3000);

    //알림메세지 쿠키 저장
    AXUtil.setCookie("cookie_alert5"+id, AXUtil.getCookie("cookie_alert4"+id),"1",{path:"/"});
    AXUtil.setCookie("cookie_alert4"+id, AXUtil.getCookie("cookie_alert3"+id),"1",{path:"/"});
    AXUtil.setCookie("cookie_alert3"+id, AXUtil.getCookie("cookie_alert2"+id),"1",{path:"/"});
    AXUtil.setCookie("cookie_alert2"+id, AXUtil.getCookie("cookie_alert1"+id),"1",{path:"/"});
    AXUtil.setCookie("cookie_alert1"+id, Base64.encode("<font color='"+ color +"'>" + message + "</font>") , "1",{path:"/"});

    //alert(AXUtil.getCookie("cookie_alert1"));유치권은 특약으로 배제가능

}

//알림창 숨기기
function hideAlert() {
    $('#alert').hide();
}


function alertList(){
    id = $('#dropdownTopMenu').text().trim();

    $("#modalTitle").html("알림 내역");
    if(AXUtil.getCookie("cookie_alert1"+id) == ""){
        AXUtil.setCookie("cookie_alert1"+id, Base64.encode("파스타 포털에 오신걸 환영합니다.","euc-kr"),"1",{path:"/"});
    }

    $("#modalText").html(Base64.decode(AXUtil.getCookie("cookie_alert1"+id)) + "<br>" +
                           Base64.decode(AXUtil.getCookie("cookie_alert2"+id)) + "<br>" +
                           Base64.decode(AXUtil.getCookie("cookie_alert3"+id)) + "<br>" +
                           Base64.decode(AXUtil.getCookie("cookie_alert4"+id)) + "<br>" +
                           Base64.decode(AXUtil.getCookie("cookie_alert5"+id)));


    $("#modalCancelBtn").text("확인");
    $("#modalExecuteBtn").hide();

    if (AXUtil.getCookie("cookie_alert_close" + id) == "Y") {
        $("#modalExecuteBtn").text("알림창켜기");
        $("#modalExecuteBtn").show();
        $('#modalExecuteBtn').attr('onclick', 'openAlert();');
    }else {
        $("#modalExecuteBtn").text("알림창끄기");
        $("#modalExecuteBtn").show();
        $('#modalExecuteBtn').attr('onclick', 'closeAlert();');
    }

    $('#modal').modal('toggle');
}


function closeAlert(){
    id = $('#dropdownTopMenu').text().trim();
    AXUtil.setCookie("cookie_alert_close" + id, "Y", "1", {path: "/"});
    $('#alert').hide();
    $("#modalExecuteBtn").text("알림창켜기");
    $('#modalExecuteBtn').attr('onclick', 'openAlert();');
}

function openAlert(){
    id = $('#dropdownTopMenu').text().trim();
    AXUtil.setCookie("cookie_alert_close" + id, "N", "1", {path: "/"});
    $('#alert').show();
    $("#modalExecuteBtn").text("알림창끄기");
    $('#modalExecuteBtn').attr('onclick', 'closeAlert();');
}


//SpaceList 글자색 변환
function spaceListColorChange(spaceName) {
    if ($(location).attr('pathname') != '/org/orgMain') {
        if(spaceName === currentSpace){
            $("#"+spaceName+"-SpaceList-SpaceName").css('color','rgba(255, 165, 0, 0.55)');
        }
    }
}


// CALL AJAX
var procCallAjax = function(reqUrl, param, callback, reqAsyncBoolean) {
    var reqData = "";
    var reqMethod = "POST";
    var reqAsync = true;

    if (null == param) {
        reqData = JSON.stringify({});
        reqMethod = "GET";
    }

    if (null != param) reqData = JSON.stringify(param);
    if (null != reqAsyncBoolean && undefined != reqAsyncBoolean && (typeof(reqAsyncBoolean) === "boolean")) reqAsync = reqAsyncBoolean;

    $.ajax({
        url: reqUrl,
        method: reqMethod,
        data: reqData,
        async: reqAsync,
        dataType: 'json',
        contentType: "application/json",
        success: function(data) {
            if (data) {
                callback(data, param);
            } else {
                var resData = {RESULT : RESULT_STATUS_SUCCESS,
                               RESULT_MESSAGE : RESULT_STATUS_SUCCESS_MESSAGE};

                callback(resData, param);
            }
        },
        error: function(xhr, status, error) {
            // var resData = {RESULT : RESULT_STATUS_FAIL,
            //                RESULT_MESSAGE : JSON.parse(xhr.responseText).message};

            var failMessage = RESULT_STATUS_FAIL_MESSAGE;

            if (null != xhr && null != JSON.parse(xhr.responseText).message) failMessage = JSON.parse(xhr.responseText).message;

            var resData = {RESULT : RESULT_STATUS_FAIL,
                           RESULT_MESSAGE : failMessage};

            callback(resData, param);

            console.log("ERROR :: error :: ", error);
            showAlert('fail', failMessage);
            procCallSpinner(SPINNER_SPIN_STOP);
        },
        complete : function(data) {
            console.log("COMPLETE :: data :: ", data);
        }
    });
};


// SERIALIZE OBJECT OF FORM
jQuery.fn.serializeObject = function() {
    var jsonObj = null;

    try {
        if (this[0].tagName && this[0].tagName.toUpperCase() == "FORM" ) {
            var arr = this.serializeArray();

            if (arr) {
                jsonObj = {};
                jQuery.each(arr, function() {
                    jsonObj[this.name] = this.value;
                });
            }
        }
    } catch(e) {
        console.log(e.message);
    }

    return jsonObj;
};


// MOVE PAGE
var procMovePage = function(pageUrl, reqBlank) {
    if (pageUrl == null || pageUrl.length < 1) return false;

    if (USE_YN_Y == reqBlank) {
        window.open('about:blank').location.href = pageUrl;
    } else {
        location.href = pageUrl;
    }
};

// Input Text Field Change
function textFieldChange(id, status){
    document.getElementById(id+"-TextField").className = "form-control-"+status;
    document.getElementById(id+"-StatusIcon").className = "glyphicon status-icon-"+status;
}

//입력창 열때, 입력필드로 커서이동
function toggleBox(id) {
    if($("#"+id+"Box").is(":hidden")) {
        $("#"+id+"Box").slideToggle();
        $("#"+id+"-TextField").focus()
    } else {
        $("#"+id+"Box").slideToggle()
    }
}


// COMMON SPINNER VALUE
var COMMON_SPINNER = null;
var SPINNER_SPIN_START = 'START';
var SPINNER_SPIN_STOP = 'STOP';
var SPINNER_REQUEST_COUNT = 0;


// CALL SPINNER
var procCallSpinner = function(reqStatus) {
    var modalMask = $('#modalMask');

    if ('' == reqStatus || undefined === reqStatus || SPINNER_SPIN_START == reqStatus) {
        window.scrollTo(0, 0);
        modalMask.modal('toggle');
        COMMON_SPINNER = new Spinner().spin();
    }

    if (null == COMMON_SPINNER) return false;

    if ('' != reqStatus && SPINNER_SPIN_STOP == reqStatus) {
        COMMON_SPINNER.stop();
        modalMask.modal('hide');
        window.scrollTo(0, 0);
    }
};


// INIT AJAX EVENT FOR SPINNER
var procInitAjaxEventForSpinner = function() {
    $(document).on({
        ajaxSend: function() {
            procCallCommonSpinner(SPINNER_SPIN_START);
        },
        ajaxError: function() {
            SPINNER_REQUEST_COUNT = 0;
            procCallCommonSpinner(SPINNER_SPIN_STOP);
        },
        ajaxStop: function() {
            SPINNER_REQUEST_COUNT = 0;
            procCallCommonSpinner(SPINNER_SPIN_STOP);
        }
    });
};


// CALL COMMON SPINNER
var procCallCommonSpinner = function(reqStatus) {
    var modalMask = $('#modalMask');
    if ('' == reqStatus || undefined === reqStatus || SPINNER_SPIN_START == reqStatus) {
        if (0 == SPINNER_REQUEST_COUNT) {
            window.scrollTo(0, 0);
            modalMask.modal('toggle');
            COMMON_SPINNER = new Spinner();
            COMMON_SPINNER.spin();
        }

        SPINNER_REQUEST_COUNT++;
    }

    if (null == COMMON_SPINNER) {
        SPINNER_REQUEST_COUNT = 0;
        return false;
    }

    if ('' != reqStatus && SPINNER_SPIN_STOP == reqStatus) {
        COMMON_SPINNER.stop();
        modalMask.modal('hide');
        COMMON_SPINNER = null;
        $('.modal-backdrop').hide();
        $('.spinner').hide();
        window.scrollTo(0, 0);

        SPINNER_REQUEST_COUNT = 0;
    }
};


// POPUP
var procPopup = function(reqTitle, reqMessage, procFunction) {
    var objButtonText = $('#modalExecuteBtn');

    $("#modalTitle").html(reqTitle + ' ' + reqMessage.split(' ')[0]);
    $("#modalText").html(reqMessage);

    objButtonText.html(reqMessage.split(' ')[0]);
    objButtonText.attr('onclick', procFunction);

    $('#modal').modal('toggle');
};


// MOVE PAGE
var procDownload = function(filePath, fileName) {
    if (filePath == null || filePath.length < 1) return false;
    if (fileName == null || fileName.length < 1) return false;

    var reqDownloadUrl = "/download/url";
    reqDownloadUrl += "?url=" + filePath + "&originalFileName=" + fileName;

    location.href = reqDownloadUrl;
};


// CHECK VALID NULL OR EMPTY
var procCheckValidNull = function(reqValue) {
    if (typeof reqValue === 'object') return null != reqValue;
    if (typeof reqValue === 'boolean') return null != reqValue;
    if (typeof reqValue === 'string') return !(null == reqValue || '' == reqValue);
    if (typeof reqValue === 'number') return !(null == reqValue || '' == reqValue);
};


// GET LIST
var procGetTopMenuList = function() {
    procCallAjax('/menu/getUserMenuList', {}, procCallbackGetTopMenuList);
};


// GET LIST CALLBACK
var procCallbackGetTopMenuList= function(data) {
    if (RESULT_STATUS_FAIL == data.RESULT) return false;

    var menuList = data.list;
    var listLength = menuList.length;
    var objMenu = $('#navbarMenuList');
    var htmlString = [];
    var tempTarget = "";

    for (var i = 0; i < listLength; i++) {
        htmlString.push('<li><a href="javascript:void(0);" '
            + tempTarget
            + 'onclick="procMovePage(\'' + menuList[i].menuPath + '\', \'' + menuList[i].openWindowYn + '\');">'
            + '<span> ' + menuList[i].menuName + ' </span></a></li>');
    }

    objMenu.append(htmlString);
};


// CHECK VALID STRING SPACE
var procCheckValidStringSpace = function(reqString) {
    if (undefined != reqString && null != reqString) {
        return (0 != reqString.replace(/ /g,"").length);
    }

    var objString = $('.toCheckString');
    if (undefined == objString || null == objString) {
        showAlert("fail", RESULT_STATUS_FAIL_MESSAGE);
        return false;
    }

    var objStringLength = objString.length;
    for (var i = 0; i < objStringLength; i++) {
        if (0 == objString[i].value.replace(/ /g,"").length) {
            objString.eq(i).focus();
            showAlert("fail", INFO_EMPTY_REQUEST_DATA);
            return false;
        }
    }

    return true;
};


// CHECK VALID URL
var procCheckValidUrl = function(reqUrl) {
    if (!procCheckValidNull(reqUrl)) return false;

    var urlExp = /http:\/\/([\w\-]+\.)+/g;
    return urlExp.test(reqUrl);
};

