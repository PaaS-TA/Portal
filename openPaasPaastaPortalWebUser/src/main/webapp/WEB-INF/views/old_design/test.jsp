<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<body onload='document.loginForm.username.focus();'>
<h1>PaaS-TA Portal!</h1>

<c:if test="${not empty error}"><div>${error}</div></c:if>
<c:if test="${not empty message}"><div>${message}</div></c:if>

<p>현재 시간 : ${serverTime}.
<p>총 사용자 수 : <font color="red">${count}</font>명 </p>


<form name='login' action="<c:url value='/login' />" method='POST'>
	<table>
		<tr>
			<td>id:</td>
			<td><input type='text' maxlength='100' name='id' value=''></td>
		</tr>
		<tr>
			<td>Password:</td>
			<td><input type='password' maxlength='100' name='password' /></td>
		</tr>
		<tr>
			<td colspan='2'><input name="submit" type="submit" value="submit" /></td>
		</tr>
		<tr>
			<td>user/user</td>
		</tr>
		<tr>
			<td>admin/admin</td>
		</tr>
	</table>
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>

</body>
</html>
