<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../includes/header.jsp" %>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" />
<link rel="stylesheet" type="text/css" href="/resources/css/book/bookList.css">
<link rel="stylesheet" href="/resources/css/common.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

<title>BOOK45 도서</title>

<div id="wrap" align="center">
	<h2>도서 목록</h2>
	<table class="list">
		<c:forEach var="book" items="${list}">
			<tr class="record">
				<input type="hidden" name="isbn" id="isbn" value="${book.isbn}">
				<input type="hidden" name="stock" id="stock" value="${book.stock}">
				<td name="num">${book.num}<input type="hidden" name="num" value="${book.num}"></td>
				<td><a class="move" href='<c:out value="${book.isbn}"/>'><img alt="" src="${book.pictureUrl}" id="cover"></a><input type="hidden" name="pictureurl" value="${book.pictureUrl}"></td>
				<td>
					<b>카테고리</b> &nbsp; ${book.category}<input type="hidden" name="category" value="${book.category}"><br>
					<b>제목</b>&nbsp;<a class="move" href='<c:out value="${book.isbn}"/>'>${book.title}</a><br> 
					<b>작가</b> &nbsp; ${book.author} <input type="hidden" name="author" value="${book.author}"><br>
					<b>출판사</b> &nbsp; ${book.pub} <input type="hidden" name="pub" value="${book.pub}"><br>
					<b>가격</b> &nbsp;<fmt:formatNumber value="${book.price}" pattern="#,### 원"></fmt:formatNumber> &nbsp;<input type="hidden" name="price" value="${book.price}"><br>
					<b>줄거리</b> <br>${book.summary}
				</td>
			</tr>
		</c:forEach>
	</table>
</div>

<form id="actionForm" action="/book/list" method="get">
	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
	<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
	<input type="hidden" name="type" value="${pageMaker.cri.type}">
	<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
</form>

<!-- 장바구니 기능 -->
<form id="cartForm" method="post">
	<input type="hidden" name="id" value="${member.id}">
	<input type="hidden" name="isbn" value="">
	<input type="hidden" name="amount" value="">
</form>

<div id="listFooter">
<!-- 페이징 처리 시작 -->
<div class="pull-right" id="pageNumber">
	<ul class="pagination">
	<c:if test="${pageMaker.prev}">
		<li class="paginate_button previous"><a href="${pageMaker.startPage - 1}">이전</a></li>
	</c:if>
	<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
		<li id="pageNum2" class="paginate_button ${pageMaker.cri.pageNum == num ? "active" : ""}" ><a href="${num}">${num}</a></li>
	</c:forEach>
	<c:if test="${pageMaker.next}">
		<li class="paginate_button next"><a href="${pageMaker.endPage + 1}">다음</a></li>
	</c:if>
	</ul>
</div>
<!-- 페이징 처리 끝 -->  
<!-- 검색 시작 -->     
<div class='row' align="center">
	<div class="col-lg-12">
		<form id="searchForm" action="/book/list" method="get">
			<select name="type" id="hoption">
				<option value="" <c:out value="${pageMaker.cri.type==null? 'selected': ''}"/>>--</option>
				<option value="T" <c:out value="${pageMaker.cri.type eq 'T'? 'selected': ''}"/>>제목</option>
				<option value="A" <c:out value="${pageMaker.cri.type eq 'A'? 'selected': ''}"/>>작가</option>
				<option value="P" <c:out value="${pageMaker.cri.type eq 'P'? 'selected': ''}"/>>출판사</option>
				<option value="TA" <c:out value="${pageMaker.cri.type eq 'TA'? 'selected': ''}"/>>제목/작가</option>
				<option value="TP" <c:out value="${pageMaker.cri.type eq 'TP'? 'selected': ''}"/>>제목/출판사</option>
				<option value="TAP" <c:out value="${pageMaker.cri.type eq 'TAP'? 'selected': ''}"/>>제목/작가/출판사</option>
			</select>
			<input type="text" name="keyword" value='${pageMaker.cri.keyword}' id="hsearch" placeholder="검색할 내용을 입력해 주세요"/>
			<input type="hidden" name="pageNum" value='${pageMaker.cri.pageNum}'/>
			<input type="hidden" name="amount" value='${pageMaker.cri.amount}'/>
			<button class="btn btn-default" id="searchBtn">검색</button>
		</form>	
	</div>
</div>                       
<!-- 검색 끝 -->  
</div>

<script>
$(document).ready(function() {
	$("#regBtn").on("click", function(){
		self.location ="/book/register"; //도서 등록 버튼을 누르면 페이지 이동
	});
          
	let actionForm = $("#actionForm");
  		
	$(".paginate_button a").on("click", function(e){
		e.preventDefault();
  			actionForm.attr("action", "/book/list"); //수정삭제메뉴에서 뒤로가기 한다음 page번호 클릭하면 상세페이지 빠지는것 방지
  			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
  			actionForm.submit();
	});
          
	$(".move").on("click",function(e){
		e.preventDefault();
		//추가
		actionForm.find("input[name='isbn']").remove();  //뒤로 간 후 리스트 클릭하면 isbn이 계속 쌓이는 문제
		actionForm.append("<input type='hidden' name='isbn' value='" + $(this).attr("href") + "' >");
		actionForm.attr("action", "/book/get");
		actionForm.submit();
	});
  			
	let searchForm = $("#searchForm");
  			
	$("#searchForm button").on("click", function(e) {
  				
		if (!searchForm.find("option:selected").val()) {
			alert("검색 종류를 선택해 주세요.");
			return false;
		}
   				
		if (!searchForm.find("input[name='keyword']").val()) {
			alert("키워드를 입력해 주세요.");
			return false;
		}
		
		e.preventDefault();
		searchForm.find("input[name='pageNum']").val("1");
		searchForm.submit();
	});
});
</script>
<%@ include file="../includes/footer.jsp" %>