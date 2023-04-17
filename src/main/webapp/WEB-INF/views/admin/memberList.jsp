<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ include file="../includes/header.jsp" %>
<%
	String id = (String)session.getAttribute("id");	
%>

<title>BOOK45 관리자 - 회원 목록</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" />
<link rel="stylesheet" type="text/css" href="/resources/css/admin/memberList.css">
<link rel="stylesheet" type="text/css" href="/resources/css/common.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

<div id="down">
	<form role="form" method="post" name="frm">
	<input type="hidden" name="id" value="${member2.id}">
	<div id="wrap" align="center">
		<h2 align="center"> 회원 목록 </h2>
		<table class="list" align="center">
			<tr>
				<th>아이디</th> <th>이름</th> <th>전화번호</th> <th>이메일</th> <th>등급</th> <th colspan="3">회원 관리</th>
			</tr>
			<c:forEach var="member" items="${memberList}">
				<tr class="record">
					<td> ${member.id} </td>
					<td> ${member.name} </td>
					<td> ${member.phone} </td>
					<td> ${member.email} </td>
					<td> ${member.lev} </td>
					<td><input type="button" value="정보 수정" id="btn" onclick="location.href='/admin/update?id=${member.id}'"></td>
					<td><input type="button" value="주문 내역" id="btn" class="listBtn" data-oper="${member.id}" onclick="location.href='/order/orderList'"></td>
					<td><input type="button" value="회원 삭제" id="btn" onclick="location.href='/admin/delete?id=${member.id}'"></td>
				</tr>
			</c:forEach>
		</table>
	</div>
	</form>
	<form id="listForm" action="/member/orderList" method="get">
        <input type="hidden" name="id" class="id">
    </form>
</div>

<script type="text/javascript">
let formObj = $("form");

$(".deleteBtn").on("click", function(e) {
	e.preventDefault();
	
	let operation = $(this).data("oper");
	
	if (operation === 'delete') {
		formObj.attr("action", "/admin/delete");
	}
	formObj.submit();
});

$(".listBtn").on("click", function(e){
    e.preventDefault();
    let id = $(this).data("oper");

    $("#listForm").find("input[name='id']").val(id);
    $("#listForm").submit();

});
</script>
<%@ include file="../includes/footer.jsp" %>