<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>PaaSTA</title>

    <!-- Bootstrap -->
    <link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: white;
        }

        #loginbox {
            margin-top: 30px;
        }

        #loginbox > div:first-child {
            padding-bottom: 10px;
        }

        .iconmelon {
            display: block;
            margin: auto;
        }

        #form > div {
            margin-bottom: 25px;
        }

        #form > div:last-child {
            margin-top: 10px;
            margin-bottom: 10px;
        }

        .panel {
            background-color: transparent;
        }

        .panel-body {
            padding-top: 30px;
            background-color: rgba(2555,255,255,.3);
        }

        .iconmelon,
        .im {
            position: relative;
            width: 150px;
            height: 150px;
            display: block;
            fill: #525151;
        }

        .iconmelon:after,
        .im:after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
        }

        .span-right {
            float: right;
        }
    </style>

</head>
<body onload="initPage();">
<div class="container">

    <div id="loginbox" class="mainbox col-md-6 col-md-offset-3 col-sm-6 col-sm-offset-3">

        <div class="row">
            <div class="iconmelon">
            </div>
        </div>

        <div class="panel panel-default" >
            <div class="panel-heading" style="background-color: rgb(249, 161, 27)">
                <div class="panel-title text-center" style="background-color: rgb(249, 161, 27)"><img src="/resources/images/logo.png"></div>
            </div>

            <div class="panel-body" >
                <form name='login'>
                    <fieldset>
                        <div class="form-group text-center">
                            <c:out value='${msg }'/>
                        </div>
                    </fieldset>
                </form>
                <hr/>
                <div>
                    <span class="span-right"><a id="resetPassword" href="/myQuestion/myQuestionMain/create">문의하러 가기</a></span>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>