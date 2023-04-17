<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../includes/header.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");
	session = request.getSession();
	session.getAttribute("member");
%>

<title>BOOK45 마이페이지</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" />
<link rel="stylesheet" type="text/css" href="/resources/css/member/mypage.css">
<link rel="stylesheet" href="/resources/css/common.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

	<div id="container">
		<div id="wrap" align="center">
			<h1>My Page</h1>
			
			<form role="form" name="myPageForm2" method="post" id="myPageForm2">
				<input type="hidden" name="id" value="${member.id}">
				<img src="https://blog.kakaocdn.net/dn/c3vWTf/btqUuNfnDsf/VQMbJlQW4ywjeI8cUE91OK/img.jpg">
				
				<table>	
					<tr>
						<th>아이디</th>
						<td>${member.id}</td>
					</tr>
					<tr>
						<th>이름</th>
						<td>${member.name}</td>
					</tr>
					<tr>
						<th>닉네임</th>
						<td>${member.nickname}</td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td>${member.phone}</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td>${member.email}</td>
					</tr>
					<tr>
						<th>주소</th>
						<td>(${member.zipCode})
						${member.addressRoad},
						${member.addressDetail}</td>
					</tr>
					<tr>
						<th>등급</th>
						<c:if test="${member.lev == 'B'}">
						<td>일반회원</td>
						</c:if>
						<c:if test="${member.lev == 'A'}">
						<td>관리자</td>
						</c:if>
					</tr>	
	            	<tr>
	            		<th>보유 포인트</th>
	            		<td><fmt:formatNumber value="${member.point}" pattern="#,###"></fmt:formatNumber></td>
	            	</tr>
				</table>
				<br> <br> 
				
			</form>
			<input type="button" id="btn" class="listBtn" value="주문 내역" data-oper="${member.id}" onclick="location.href='/member/orderList'">
			<input type="button" id="btn" value="회원 정보 수정" onclick="location.href='/member/update/${member.id}'"> 
			<input type="button" id="btn" value="취소" onclick="location.href='/main'"> 
			<input type="submit" id="btn" value="회원 탈퇴" data-oper="delete" class="deleteBtn">
		</div>
		<form id="listForm" action="/member/orderList" method="get">
	        <input type="hidden" name="id" class="id">
	    </form>
	</div>
	
<script>
	let formObj = $("#myPageForm2");
	let id = $(".id");
	
	$(".deleteBtn").on("click", function(e) {
		e.preventDefault();
		let confirmMsg = confirm("정말로 탈퇴하시겠습니까?");
		
		let operation = $(this).data("oper");
		if (confirmMsg) {
			if (operation === 'delete') {
			
				formObj.attr("action", "/member/delete");
			}
			
			alert("회원 탈퇴가 완료되었습니다.");
			formObj.submit();
		}
	});
	
	$(".listBtn").on("click", function(e){
	    e.preventDefault();
	    let id = $(this).data("oper");

	    $("#listForm").find("input[name='id']").val(id);
	    $("#listForm").submit();

	});
</script>
<%@ include file="../includes/footer.jsp" %>