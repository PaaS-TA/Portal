<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
		}
	</style>
</head>

<body>

<div class="w800px text-center">
	<form name='login' action="<c:url value='/login' />" method='POST'>
		<div class="mt150">
			<span class="login-icons"><img src="<c:url value='/resources/images/mainuser.png' />"></span>
		</div>
		<div class="form-group text-center mt65 ">
			<div><span class="login-font">MEMBER LOGIN</span></div>
			<div><span class="login-font2">사용자 포탈에 오신 것을 환영합니다.</span></div>
		</div>
		<div class="text-center mt15">
			<input class="login-form" placeholder="yourmail@example.com" name="id" id="id" type="text" value="" maxlength="100">
		</div>
		<div class="text-center">
			<input class="login-form" placeholder="Password" name="password" type="password" value="" maxlength="100">
		</div>
		<c:choose>
			<c:when test="${not empty error}">
				<div class="text-center mt15 alert alert-danger" style="width:45%;height:28px;">
					<span class="glyphicon glyphicon-warning-sign"></span>
					<font style="padding-left:7px;font-size:13px;">아이디 또는 비밀번호가 맞지 않습니다.</font>
				</div>
			</c:when>
			<c:otherwise><div>&nbsp</div></c:otherwise>
		</c:choose>
		<div class="text-center w340px" style="margin: 10px auto 0;">
			<span class="fl" ><a id="createAcount" style="color:#faa51b;" href="<c:url value='/user/addUser' />">계정생성</a></span>
			<span class="fr"><a id="resetPassword" style="color:#faa51b;" href="<c:url value='/user/resetPassword' />">비밀번호 재설정</a></span>
		</div>
		<div class="text-center mt80">
			<button name="submit" type="submit" class="btn btn-primary btn-lg" style="width:180px; background-color:#faa51b; border-color:#faa51b; font-weight: normal;">LOGIN</button>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		</div>
	</form>
</div>

<script type="text/javascript">

	// ON LOAD
	$(document.body).ready(function () {
		document.getElementById('id').focus();
	});

</script>

</body>
</html>