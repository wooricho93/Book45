<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ include file="../includes/header.jsp"%>

<title>BOOK45 주문 상세 조회</title>

<link rel="stylesheet" type="text/css" href="/resources/css/order/orderDetail.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

<div id="container" align="center">
	<h1 align="center">주문내역 조회</h1>
	<div class="orderInfo">
		<table class="table1">
			<c:if test="${empty orderAlbumDetail}">
				<tr>
					<td colspan="2" style="border-bottom: none; font-size: 14px; text-align: right;"> 주문일: <fmt:formatDate value="${orderDate}" pattern="yyyy-MM-dd"/></td>
				</tr>
				<tr>
					<th>주문번호</th>
					<td style="border-top: 1px solid #dddddd;">${orderNum}</td>
				</tr>
				<tr>
					<th>수령인</th>
					<td>${name}</td>
				</tr>
				<tr>   
					<th>주소</th>
					<td>(${zipCode}) ${addressRoad} ${addressDetail}</td>
				</tr>
				<tr>   
					<th>전화번호</th>
					<td><c:out value="${phone}" /></td>
				</tr>
			</c:if>
			<c:if test="${empty orderBookDetail}">
				<tr>
					<td colspan="2" style="border-bottom: none; font-size: 14px; text-align: right;"> 주문일: <fmt:formatDate value="${orderDateA}" pattern="yyyy-MM-dd"/></td>
				</tr>
				<tr>
					<th>주문번호</th>
					<td style="border-top: 1px solid #dddddd;">${orderNumA}</td>
				</tr>
				<tr>
					<th>수령인</th>
					<td>${nameA}</td>
				</tr>
				<tr>   
					<th>주소</th>
					<td>(${zipCodeA}) ${addressRoadA} ${addressDetailA}</td>
				</tr>
				<tr>   
					<th>전화번호</th>
					<td><c:out value="${phoneA}"/></td>
				</tr>
			</c:if>
		</table>
	</div>
	<table class="table2">
		<tr>
			<th width="20%">이미지</th> <th width="50%">상품명</th> <th width="10%">가격</th> <th width="10%">구입 수량</th> <th width="10%">결제 금액</th>
		</tr>
		<c:choose>
			<c:when test="${empty orderAlbumDetail}">
				<c:forEach var="orderDetail" items="${orderBookDetail}">
					<tr>
						<td><img src="${orderDetail.pictureUrl}" id="cover1"></td>
						<td><c:out value="${orderDetail.title}"/></td>
						<td><fmt:formatNumber pattern="###,###,### 원" value="${orderDetail.price}" /><p>배송비 <fmt:formatNumber value="${orderDetail.deliveryCost}" pattern="#,### 원"></fmt:formatNumber></p></td> 
						<td><c:out value="${orderDetail.amount}" /></td>
						<td><fmt:formatNumber pattern="###,###,### 원" value="${orderDetail.price * orderDetail.amount}"/>               
					</tr>
				</c:forEach>
					<tr>
						<td colspan="5">배송상태: ${orderState}</td>
					</tr>
			</c:when>
			<c:when test = "${empty orderBookDetail}">
				<c:forEach var="orderDetail" items="${orderAlbumDetail}">
					<tr>
						<td><img src="${orderDetail.albumPictureUrl}" id="cover2"></td>
						<td><c:out value="${orderDetail.albumTitle}"/></td>
						<td><fmt:formatNumber pattern="###,###,### 원" value="${orderDetail.albumPrice}" /><p>배송비 <fmt:formatNumber value="${orderDetail.deliveryCost}" pattern="#,### 원"></fmt:formatNumber></p></td> 
						<td><c:out value="${orderDetail.amount}" />개</td>
						<td><fmt:formatNumber pattern="###,###,### 원" value="${orderDetail.albumPrice * orderDetail.amount}"/>               
					</tr>
				</c:forEach>
				<tr>
					<td colspan="5">배송상태: ${orderStateA}</td>
				</tr>
			</c:when>
		</c:choose>
	</table>
</div>           
   
<%@ include file="../includes/footer.jsp" %>