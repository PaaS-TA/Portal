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

		.btn-login {
			color: #fff;
			border-color: rgb(249, 161, 27);
			background-color: rgb(249, 161, 27)
		}

		.span-left {
			float: left;
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
				<form name='login' action="<c:url value='/login' />" method='POST'>
					<fieldset>
						<div class="form-group text-center">
							<span>사용자 포탈에 오신 것을 환영합니다.</span>
						</div>
						<div class="form-group">
							<input class="form-control" placeholder="yourmail@example.com" name="id" id="id" type="text" value="" maxlength="100">
						</div>
						<div class="form-group">
							<input class="form-control" placeholder="Password" name="password" type="password" value="" maxlength="100">
							<c:choose>
								<c:when test="${not empty error}"><div style="color: red">${error}</div></c:when>
								<c:when test="${not empty message}"><div>${message}</div></c:when>
								<c:otherwise><div>&nbsp</div></c:otherwise>
							</c:choose>
						</div>
						<input class="btn btn-lg btn-login btn-block" name="submit" type="submit" value="Login">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					</fieldset>
				</form>
				<hr/>
				<div>
					<span class="span-left" ><a id="createAcount" href="/user/addUser">계정생성</a></span>
					<span class="span-right"><a id="resetPassword" href="/user/resetPassword">비밀번호 재설정</a></span>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
<script type="text/javascript">

	// ON LOAD
	var initPage = function() {
		document.getElementById('id').focus();
	};

</script>
</html>