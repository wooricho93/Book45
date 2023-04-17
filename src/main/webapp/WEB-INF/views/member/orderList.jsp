<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ include file="../includes/header.jsp"%>
<%
   String id = (String)session.getAttribute("id");   
%>

<title>BOOK45 주문 조회</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" />
<link rel="stylesheet" type="text/css" href="/resources/css/member/orderList.css">
<link rel="stylesheet" type="text/css" href="/resources/css/common.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>


<div id="container" align="center">
<div class="admin_content_subject"><h1>주문 조회</h1>
</div>
	<div class="author_table_wrap">
		<!-- 게시물 O -->
		<c:if test="${listCheck != 'empty'}">
            	<table class="order_table">
            	<colgroup>
            		<col width="21%">
            		<col width="20%">
            		<col width="20%">
            	</colgroup>
            		<thead>
            			<tr>
            				<th class="orderNum">주문 번호</th>
            				<th class="orderDate">주문 날짜</th>
            				<th class="orderState">주문 상태</th>
            			</tr>
            		</thead>
            		<c:forEach items="${list}" var="list">
            		<tr>
            			<td><a class="detailBtn" href="/order/orderDetail" data-oper="${list.orderNum}"><c:out value="${list.orderNum}"/></a></td>
            			<td><fmt:formatDate value="${list.orderDate}" pattern="yyyy-MM-dd"/></td>
            			<td><c:out value="${list.orderState}"/>
            				<c:if test="${list.orderState == '배송준비'}">
            					<button class="deleteBtn" data-oper="${list.orderNum}" data-id="${member.id}">주문 취소</button>
            				</c:if>
           				</td>
            		</tr>
            		</c:forEach>
            	</table> 					
		</c:if>
		
        <!-- 게시물 x -->
        <c:if test="${listCheck == 'empty'}">
        	<table>
        	<tr>
        		<th class="orderNum">주문 번호</th>
        		<th class="orderDate">주문 날짜</th>
        		<th class="orderState">주문 상태</th>
        	</tr>
        	<tr>
        	<td colspan="3">등록된 주문이 없습니다.</td>
        	</tr>
        	</table>
        </c:if> 						
    </div> 
                
	<form id="moveForm" action="/member/orderList" method="get">
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
		<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
		<input type="hidden" name="type" value="${pageMaker.cri.type}">
		<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
	</form>   
	<!-- 상세 주문 내역 -->
	<form id="detailForm" action="/order/orderDetail" method="get">
        <input type="hidden" name="orderNum" class="orderNum">
        <input type="hidden" name="id" value="${member.id}">
    </form>
	<!-- 주문 취소 form -->
	<form id="deleteForm" action="/order/memberOrderCancel" method="post">
		<input type="hidden" name="orderNum">
		<input type="hidden" name="id" value="${member.id}">
	</form>   
</div>                              
<script>
$(".detailBtn").on("click", function(e){
    e.preventDefault();
    let orderNum = $(this).data("oper");
    $("#detailForm").find("input[name='orderNum']").val(orderNum);
    $("#detailForm").submit();
});
	
$(".deleteBtn").on("click", function(e){
	e.preventDefault();
	let orderNum = $(this).data("oper");
	
	$("#deleteForm").find("input[name='orderNum']").val(orderNum);
	$("#deleteForm").submit();
	alert("주문 취소가 완료되었습니다.");
});
</script>
<%@ include file="../includes/footer.jsp"%>