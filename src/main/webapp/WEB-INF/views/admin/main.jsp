<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>

<title>BOOK45 관리자 페이지</title>

<link rel="stylesheet" type="text/css" href="/resources/css/common.css">
<link rel="stylesheet" type="text/css" href="/resources/css/admin/main.css">

<div id="wrap" align="center">
	<h1>관리자 페이지</h1>
	<div id="div1">
		<button id="adBtn" onclick="location.href='/admin/memberList'">회원 관리</button>
		<button id="adBtn" onclick="location.href='/admin/orderList'">주문 내역 조회</button>
	</div>
	<div id="div2">
		<button id="adBtn" onclick="location.href='/admin/manageBook'">도서 관리</button>
		<button id="adBtn" onclick="location.href='/admin/manageAlbum'">앨범 관리</button>
	</div>
</div>
	
	
<%@ include file="../includes/footer.jsp" %>