<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../includes/header.jsp" %>
<%
	session.getAttribute("category");
%>

<title>BOOK45 도서</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" />
<link rel="stylesheet" type="text/css" href="/resources/css/book/category.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

	<div id="wrap" align="center">
		<h2><%= session.getAttribute("category") %> 조회 결과</h2>
		<c:if test="${member.lev == 'A'}">
			<input type="button" value="도서 등록" id="regibtn" onclick="location.href='/album/register'" style="float: right;">
		</c:if>
		<table class="list">
			<c:forEach var="book" items="${category}">
				<tr class="record">
					<td name="num">${book.num}<input type="hidden" name="num" value="${book.num}"></td>
					<td><a class="move" href='<c:out value="${book.isbn}"/>'><img alt="" src="${book.pictureUrl}" id="cover"></a><input type="hidden" name="pictureurl" value="${book.pictureUrl}"></td>
					<td>
					<b>카테고리</b> &nbsp; ${book.category}<input type="hidden" name="category" value="${book.category}">
					<br> <b>제목</b>
						&nbsp; <!-- <a href="/book/bookDetail"> --><a class="move" href='<c:out value="${book.isbn}"/>'>
							${book.title} </a> <%-- <input type="hidden" name="isbn" value="${book.isbn}"> --%>
							<br> <b>작가</b> &nbsp; ${book.author} <input type="hidden" name="author" value="${book.author}"><br>
						<b>출판사</b> &nbsp; ${book.pub} <input type="hidden" name="pub" value="${book.pub}"><br> <b>가격</b> &nbsp;
						<fmt:formatNumber value="${book.price}" pattern="#,### 원"></fmt:formatNumber> &nbsp;<input type="hidden" name="price" value="${book.price}"><br> <b>줄거리</b> <br>${book.summary}
					</td>
				</tr>
			</c:forEach>
		</table>
		<form id="actionForm" action="/book/categoryList" method="get">
              <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
              <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
              <input type="hidden" name="type" value="${pageMaker.cri.type}">
              <input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
        </form>
        
	<div id="listFooter">
		<!-- 검색 시작 -->     
		<div class='row' align="center">
			<div class="col-lg-12">
				<form id="searchForm" action="/book/categoryList" method="get">
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
</div>
	
<script>
$(document).ready(function() {
	$("#regBtn").on("click", function() {

		self.location = "/book/register";
	});
	
	var actionForm = $("#actionForm");
	
	$(".move").on("click",function(e){
		e.preventDefault();
		//추가
		actionForm.find("input[name='isbn']").remove(); 
		//
		actionForm.append("<input type='hidden' name='isbn' value='" + $(this).attr("href") + "' >");
		actionForm.attr("action", "/book/get");
		actionForm.submit();
	});
	
	var searchForm = $("#searchForm");
	$("#searchForm button").on("click", function(e){
		
		if(!searchForm.find("option:selected").val()){
			alert("검색종류를 선택하세요");
			return false;
		}
		if(!searchForm.find("input[name='keyword']").val()){
			alert("키워드를 입력하세요");
			return false;
		}
		searchForm.find("input[name='pageNum']").val("1");
		e.preventDefault();
		searchForm.submit();
	});
});
</script>
<%@ include file="../includes/footer.jsp" %>