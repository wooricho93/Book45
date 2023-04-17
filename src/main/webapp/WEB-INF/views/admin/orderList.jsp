<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ include file="../includes/header.jsp"%>
<%
   String id = (String)session.getAttribute("id");   
%>

<title>관리자 페이지 - 전체 주문 내역</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" />
<link rel="stylesheet" type="text/css" href="/resources/css/admin/orderList.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>


<div id="container" align="center">
<div class="admin_content_subject"><h1>회원 주문 내역 조회</h1>
</div>
   <div class="author_table_wrap">
      <c:if test="${listCheck != 'empty'}">
               <table class="order_table">
               <colgroup>
                  <col width="21%">
                  <col width="20%">
                  <col width="20%">
                  <col width="20%">
               </colgroup>
                  <thead>
                     <tr>
                        <th class="orderNum">주문번호</th>
                        <th class="id">아이디</th>
                        <th class="orderDate">주문 날짜</th>
                        <th class="orderState">주문 상태</th>
                     </tr>
                  </thead>
                  <c:forEach items="${list}" var="list">
                  <tr>
                     <td><a class="detailBtn" href="/order/orderDetail" data-oper="${list.orderNum}"><c:out value="${list.orderNum}"/></a></td>
                     <td><c:out value="${list.id}"/> </td>
                     <td><fmt:formatDate value="${list.orderDate}" pattern="yyyy-MM-dd"/></td>
                     <td><c:out value="${list.orderState}"/>&nbsp;&nbsp;
                     
                        <c:if test="${list.orderState == '배송준비'}">
                           <button class="deleteBtn" data-oper="${list.orderNum}">주문 취소</button>
                        </c:if>
                     </td>
                  </tr>
                  </c:forEach>
               </table>                
      </c:if>
      <c:if test="${listCheck == 'empty'}">
           <div class="table_empty">
         등록된 주문이 없습니다.
         </div>
      </c:if>                   
    </div> 
<div id="listFooter">  
<!-- 페이징처리 시작 -->
<div class="pull-right" id="pageNumber">
   <ul class="pagination">
   <c:if test="${pageMaker.prev}">
      <li class="paginate_button previous"><a href="${pageMaker.startPage - 1}">이전</a></li>
   </c:if>
   <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
      <li id="pageNum2" class="paginate_button ${pageMaker.cri.pageNum == num ? "active" : ""}"><a href="${num}">${num}</a></li>
   </c:forEach>
   <c:if test="${pageMaker.next}">
      <li class="paginate_button next"><a href="${pageMaker.endPage + 1}">다음</a></li>
   </c:if>
   </ul>
</div>
<!-- 페이징처리 끝 -->       
    <!-- 검색 영역 -->
<div class='row' align="center">
	<div class="col-lg-12">
      <form id="searchForm" action="/admin/orderList" method="get">
         <div class="search_input">
            <input type="text" name="keyword" id="hsearch" value='<c:out value="${pageMaker.cri.keyword}"></c:out>'>
            <input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum}"></c:out>'>
            <input type="hidden" name="amount" value='${pageMaker.cri.amount}'>
            <button class="btn search_btn" id="searchBtn">검 색</button>
         </div>
      </form>
   </div>                 
</div>
</div>

</div>       
   <form id="moveForm" action="/admin/orderList" method="get">
      <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
      <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
      <input type="hidden" name="type" value="${pageMaker.cri.type}">
      <input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
   </form>   
   
   <!-- 주문 취소 form -->
   <form id="deleteForm" action="/order/adminOrderCancel" method="post">
      <input type="hidden" name="orderNum">
      <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
      <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
      <input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
      <input type="hidden" name="id" value="${member3.id}">
   </form>     
   <!-- 회원 주문 상세 -->
   <form id="detailForm" action="/order/orderDetail" method="get">
		<input type="hidden" name="orderNum" class="orderNum">
	</form>                            

<script>
   let sForm = $("#searchForm");
   
   /* 검색 기능 */
   $("#searchBtn").on("click", function(e){
      
      e.preventDefault();
      
      if(!sForm.find("input[name='keyword']").val()){
         alert("아이디를 입력해 주세요.");
         return false;
      }
      
      sForm.find("input[name='pageNum']").val("1");
      sForm.submit();
   });
   
   let moveForm = $('#moveForm');
   
   /* 페이지 이동 버튼 */
   $(".paginate_button a").on("click", function(e){
      
      e.preventDefault();
      console.log($(this).attr("href"));
      
      moveForm.attr("action", "/admin/orderList");
      moveForm.find("input[name='pageNum']").val($(this).attr("href"));
      
      moveForm.submit();
   });
   
   $(".deleteBtn").on("click", function(e){
      e.preventDefault();
      let id = $(this).data("oper");
      
      $("#deleteForm").find("input[name='orderNum']").val(id);
      $("#deleteForm").submit();
   });
   
   $(".detailBtn").on("click", function(e){
		e.preventDefault();
		let orderNum = $(this).data("oper");
		
		$("#detailForm").find("input[name='orderNum']").val(orderNum);
		$("#detailForm").submit();
		
	});
</script>
<%@ include file="../includes/footer.jsp"%>