<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../includes/header.jsp" %>
<%
   request.setCharacterEncoding("UTF-8");
   session = request.getSession();
   session.getAttribute("member");
%>

<title>BOOK45 관리자 페이지</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" />
<link rel="stylesheet" type="text/css" href="/resources/css/member/mypage.css">
<link rel="stylesheet" href="/resources/css/common.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

<div id="wrap" align="center">
	<h1>회원 정보</h1>
	<form role="form" name="myPageForm2" method="post" id="myPageForm2">
           <img src="https://blog.kakaocdn.net/dn/c3vWTf/btqUuNfnDsf/VQMbJlQW4ywjeI8cUE91OK/img.jpg">
           <table>   
			<tr>
				<th>아이디</th>
					<td>${member2.id}</td>
			</tr>
			<tr>
				<th>이름</th>
				<td>${member2.name}</td>
			</tr>
			<tr>
				<th>닉네임</th>
				<td>${member2.nickname}</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>${member2.phone}</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>${member2.email}</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>(${member2.zipCode})
				${member2.addressRoad}
				${member2.addressDetail}</td>
			</tr>
			<tr>
				<th>등급</th>
				<c:if test="${member2.lev == 'B'}">
					<td>일반회원</td>
				</c:if>
				<c:if test="${member2.lev == 'A'}">
					<td>관리자</td>
				</c:if>
			</tr>   
			<tr>
				<th>보유 포인트</th>
				<td><fmt:formatNumber value="${member2.point}" pattern="#,###"></fmt:formatNumber></td>
			</tr>
		</table>
	</form>
	<input type="button" id="btn" value="회원 삭제" data-oper="delete" class="deleteBtn"> 
	<input type="button" id="btn" value="취소" onclick="location.href='/admin/memberList'"> 
</div>
      
   
<script>
let formObj = $("form");

$(".deleteBtn").on("click", function(e) {
	e.preventDefault();
	
	confirmMsg = confirm("정말로 삭제하시겠습니까?");
	
	let operation = $(this).data("oper");
	if (confirmMsg) {
		if (operation === 'delete') {
		   formObj.attr("action", "/admin/delete");
		}
		
		alert("삭제가 완료되었습니다.");
		formObj.submit();
	}
	
});
</script>
<%@ include file="../includes/footer.jsp" %>