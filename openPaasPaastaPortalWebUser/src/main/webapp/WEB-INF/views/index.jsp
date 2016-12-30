<!--
=================================================================
* 시  스  템  명 : PaaS-TA 사용자 포탈
* 업    무    명 : 인덱스
* 프로그램명(ID) : index.jsp(인덱스)
* 프로그램  개요 : 인덱스 화면
* 작    성    자 : 김도준
* 작    성    일 : 2016.04.20
=================================================================
수정자 / 수정일 :
수정사유 / 내역 :
=================================================================
-->
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>PaaS-TA</title>

    <!-- JQUERY -->
    <script type="text/javascript" src="<c:url value='/resources/js/lib/jquery-2.2.4.js' />"></script>

    <!-- BOOTSTRAP -->
    <link href="<c:url value='/resources/css/bootstrap.css' />" rel="stylesheet">
    <script type="text/javascript" src="<c:url value='/resources/bootstrap/js/bootstrap.js' />"></script>

    <%--CSS--%>
    <link rel="stylesheet" href="<c:url value='/resources/css/common.css' />">
    <link rel="stylesheet" href="<c:url value='/resources/css/dashboard.css' />">

    <style>
        body {
            font-family: "Spoqa Han Sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
            background-color: #fff;
        }
    </style>
</head>
<body>

<!-- 로그인 바-->
<div class="topbar">
    <div class="container-fluid">
        <ul class="indexlogin fr">
            <li><a href="/login">로그인</a></li>
        </ul>
    </div>
</div>
<!-- //로그인 바-->
<!-- top배너-->
<div class="indexcontent">
    <div class="fl">
        <img src="<c:url value='/resources/images/indexlogo.png' />" style="margin-top:105px;margin-left:50px;">
    </div>
</div>
<!-- //top배너-->
<!-- 파스타 소개 20161205수정-->
<div class="pt65 pb65" style="background-color:#262a31;">
    <p class="text-center" style="color:#9da8ae;font-size:16px; width:1010px; text-align:left;"> 파스-타는 클라우드 인프라 환경을 제어하면서 응용 프로그램을 쉽게 개발하고 안정적으로 운영되도록 관리·지원하는 클라우드 플랫폼입니다.파스-타는 글로벌하게 검증된 오픈소스를 활용하여 개발되고, 전체가 오픈소스로 개방되므로 누구나 이를 자유롭게 활용하고 개작 가능합니다. 클라우드 인프라(IaaS) 제공자는 파스-타를 활용하여 플랫폼 서비스까지 제공함으로써,미래 경쟁력있는 클라우드 서비스로 발전가능하며, 클라우드 SW(SaaS) 제공자는 다양한 인프라를 지원하는 파스-타 기반의 SaaS 개발로 파편화된 플랫폼 상에서 플램폼별 중복개발을 피하고,쉽고 빠르게 서비스를 개발하고 운영할 수 있습니다.파스-타는 파스(PaaS)와 타(TA)의 합성어로, 영어로는 파스(PaaS), 고마워(TA, Thanks 구어체)의 의미를, 한글로는 파스에 타(탑승)라는 중의적 의미입니다.
    </p>
</div>
<!-- //파스타 소개-->
<!-- 구조도-->
<div class="text-center" style="background-color:#f1f1f1">
    <img src="<c:url value='/resources/images/plan.png' />" class="mt100 mb100">
</div>
<!-- //구조도-->
<!-- 특징 20161205수정-->
<div class="container">
    <div class="row service">
        <div class="col-xs-4 col-md-4 mt100">
            <div class="row">
                <div class="col-xs-4 col-md-11"><img src="<c:url value='/resources/images/gear_img.png' />"></div>
                <div class="col-xs-8 col-md-11 icontxt">
                    <h4 style="line-height:22px;letter-spacing:-1px;"><b>손쉬운 가상머신 설정과 실행</b></h4>
                    <p style="letter-spacing:-1px;color:#929191;font-size:14px;">높은 추상화 수준의 가상머신 설정 기능을 제공함으로써 다양한 유형의 개발·운영 환경을 손쉽게 설정하고 실행</p>
                </div>
            </div>
        </div>
        <div class="col-xs-4 col-md-4 mt100">
            <div class="row">
                <div class="col-xs-4 col-md-11"><img src="<c:url value='/resources/images/tools_img.png' />"></div>
                <div class="col-xs-8 col-md-11 icontxt">
                    <h4 style="line-height:22px;letter-spacing:-1px;"><b>템플릿 기반 빠른 개발 환경 구성</b></h4>
                    <p style="letter-spacing:-1px;color:#929191;font-size:14px;">미리 구성된 어플리케이션 개발환경<br>생성 및 관리기능 제공</p>
                </div>
            </div>
        </div>
        <div class="col-xs-4 col-md-4 mt100">
            <div class="row">
                <div class="col-xs-4 col-md-11"><img src="<c:url value='/resources/images/desktop_img.png' />"></div>
                <div class="col-xs-8 col-md-11 icontxt">
                    <h4 style="line-height:22px;letter-spacing:-1px;"><b>이식성 높은 환경 제공</b></h4>
                    <p style="letter-spacing:-1px;color:#929191;font-size:14px;">어플리케이션을 손쉽게 이식할 수 있는 획일화된<br>개발·테스트·운영 환경 제공</p>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="container">
    <div class="row service">
        <div class="col-xs-4 col-md-4 mt80">
            <div class="row">
                <div class="col-xs-4 col-md-11"><img src="<c:url value='/resources/images/cloud_img.png' />"></div>
                <div class="col-xs-8 col-md-11 icontxt">
                    <h4 style="line-height:22px;letter-spacing:-1px;"><b>플랫폼 서비스(PaaS) 통합 권한 관리</b></h4>
                    <p style="letter-spacing:-1px;color:#929191;font-size:14px;">PaaS 서비스 내 사용자, 조직 및 각 공간의 통합 관리 기능과 조직, 공간 별 권한 관리 기능 제공</p>
                </div>
            </div>
        </div>
        <div class="col-xs-4 col-md-4 mt80">
            <div class="row">
                <div class="col-xs-4 col-md-11"><img src="<c:url value='/resources/images/unlock_img.png' />"></div>
                <div class="col-xs-8 col-md-11 icontxt">
                    <h4 style="line-height:22px;letter-spacing:-1px;"><b>자동화된 서비스 스케일링</b></h4>
                    <p style="letter-spacing:-1px;color:#929191;font-size:14px;">가상머신들과 서비스들의 주기적인 상태 체크를 통해 리소스 부족 시 자동 확장 및 장애발생 시 자동 복구 기능 제공</p>
                </div>
            </div>
        </div>
        <div class="col-xs-4 col-md-4 mt80 mb100">
            <div class="row">
                <div class="col-xs-4 col-md-11"><img src="<c:url value='/resources/images/search_img.png' />"></div>
                <div class="col-xs-8 col-md-11 icontxt">
                    <h4 style="line-height:22px;letter-spacing:-1px;"><b>운영현황 통합 모니터링</b></h4>
                    <p style="letter-spacing:-1px;color:#929191;font-size:14px;">기반 IaaS, PaaS 서비스, 컨테이너에 이르는 모든 PaaS 서비스의 구성 요소에 대한 통합 모니터링 기능 및 분석 기능 제공</p>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- //특징-->
<!-- 지원회사-->
<div class="indexcontent2">
    <div class="text-center">
        <img src="<c:url value='/resources/images/support.png' />" style="margin-top:40px;">
    </div>
</div>
<!-- //지원회사-->
<!-- 기능 -->
<div class="text-center" style="background-color:#f1f1f1">
    <img src="<c:url value='/resources/images/laptop.png' />" class="mt100 mb100">
</div>
<!-- //기능 -->
<!-- 생태계 -->
<div class="text-center" style="background-color:#faa51b">
    <img src="<c:url value='/resources/images/system.png' />" class="mt80 mb80">
</div>
<!-- //생태계 -->
<!-- 협력기업-->
<div class="text-center">
    <img src="<c:url value='/resources/images/business.png' />" class="mt80 mb80">
</div>
<!-- //협력기업 -->
</body>
</html>
