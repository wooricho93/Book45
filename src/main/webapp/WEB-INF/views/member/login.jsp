<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book45 로그인</title>
<link rel="stylesheet" type="text/css" href="/resources/css/member/login.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
</head>
<body>
<% session.invalidate(); %>
<div id="container">
	<h2>
		<a href="/main">
			<img alt="LOGO" src="https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FCdrYl%2FbtrUTKBvWql%2FneUhG0VH9Jro8xRV8EGl61%2Fimg.png">
		</a>
	</h2>
	<form method="post" id="loginForm">
		<table>
			<tr>
				<td colspan="2"> <input type="text" name="id" id="id" placeholder="아이디를 입력해 주세요"> </td>
			</tr>
			<tr>
				<td colspan="2"> <input type="password" name="pass" id="pass" placeholder="비밀번호를 입력해 주세요"> </td>
			</tr>
			<c:if test="${result == 0}">
			<tr class="loginWarning">
				<td>아이디 또는 비밀번호를 잘못 입력하셨습니다.</td>
			</tr>
			</c:if>
			<tr>
				<td colspan="2" align="center">
					<input type="button" value="로그인" id="login"><br>
					<input type="button" value="회원가입" id="join" onclick="location.href='/member/terms'">
				</td>
			</tr>
		</table>
		<div class="kakaoLoginBox">
			<a class="kakaoLogin" href="https://kauth.kakao.com/oauth/authorize?client_id=f7e37b028d7961466d599e8f8452424c&redirect_uri=http://localhost:8081/member/kakaoLogin&response_type=code"><img src="/resources/img/ico_sns02.png" alt=""></a>
		</div>
	</form>
</div>

<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
$("#login").click(function() {
	$("#loginForm").attr("action", "/member/login.do");
	$("#loginForm").submit();
});
</script>
</body>
</html>