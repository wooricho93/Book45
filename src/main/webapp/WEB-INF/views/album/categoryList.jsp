<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../includes/header.jsp" %>
<%
	session.getAttribute("category");
%>

<title>BOOK45 앨범</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" />
<link rel="stylesheet" type="text/css" href="/resources/css/album/category.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

<div id="wrap" align="center">
	<h2><%= session.getAttribute("category") %> 조회 결과</h2>
	<c:if test="${member.lev == 'A'}">
		<input type="button" value="앨범 등록" id="regibtn" onclick="location.href='/album/register'" style="float: right;">
	</c:if>
	<table class="list">
		<c:forEach var="album" items="${category}">
			<tr class="record">
				<td name="num">${album.num}<input type="hidden" name="num" value="${album.num}"></td>
				<td><a class="move" href='<c:out value="${album.productNum}"/>'><img alt="" src="${album.albumPictureUrl}" id="cover"></a><input type="hidden" name="albumPictureUrl" value="${album.albumPictureUrl}"></td>
				<td>
					<b>카테고리</b> &nbsp; ${album.category}<input type="hidden" name="category" value="${album.category}"><br>
					<b>제목</b> &nbsp; <a class="move" href='<c:out value="${album.productNum}"/>'>${album.albumTitle}</a><br>
					<b>아티스트</b> &nbsp; ${album.singer} <input type="hidden" name="author" value="${album.singer}"><br>
					<b>제작사</b> &nbsp; ${album.ent} <input type="hidden" name="pub" value="${album.ent}"><br>
					<b>가격</b> &nbsp; <fmt:formatNumber value="${album.albumPrice}" pattern="#,### 원"></fmt:formatNumber> &nbsp; <input type="hidden" name="price" value="${album.albumPrice}"><br>
					<b>발매일</b> ${album.releaseDate}
				</td>
			</tr>
		</c:forEach>
	</table>
	
	<form id="actionForm" action="/album/list" method="get">
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
		<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
		<input type="hidden" name="type" value="${pageMaker.cri.type}">
		<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
	</form>
        
    <!-- 검색 시작 -->
    <div class='row' align="center">
		<div class="col-lg-12">
			<form id = "searchForm" action="/album/list" method="get">
				<select name="type"  id="hoption">
		     		<option value="" <c:out value="${pageMaker.cri.type==null? 'selected': ''}"/>>--</option>
		     		<option value="C" <c:out value="${pageMaker.cri.type eq 'C'? 'selected': ''}"/>>카테고리</option>
		     		<option value="T" <c:out value="${pageMaker.cri.type eq 'T'? 'selected': ''}"/>>제목</option>
		     		<option value="S" <c:out value="${pageMaker.cri.type eq 'S'? 'selected': ''}"/>>아티스트</option>
		     		<option value="CT" <c:out value="${pageMaker.cri.type eq 'CT'? 'selected': ''}"/>>카테고리 or 제목</option>
		     		<option value="TS" <c:out value="${pageMaker.cri.type eq 'TS'? 'selected': ''}"/>>제목 or 아티스트</option>
		     		<option value="CTS" <c:out value="${pageMaker.cri.type eq 'CTS'? 'selected': ''}"/>>카테고리 or 제목 or 아티스트</option>     		
		    		</select> 
		    		<input type="text" name="keyword" value="${pageMaker.cri.keyword}" id="hsearch" placeholder="검색할 내용을 입력해 주세요"/>
		     	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}"/>
		     	<input type="hidden" name="amount" value="${pageMaker.cri.amount}" />
		     	<button class="btn btn-default" id="searchBtn">검색</button>
			</form>
		</div>
	</div>
	<!-- 검색 끝 -->
</div>

<script>
$(document).ready(function() {
	$("#regBtn").on("click", function() {
		self.location = "/album/register";
	});
	
	var actionForm = $("#actionForm");
	
	$(".move").on("click",function(e){
		e.preventDefault();
		//추가
		actionForm.find("input[name='productNum']").remove();
		actionForm.append("<input type='hidden' name='productNum' value='" + $(this).attr("href") + "' >");
		actionForm.attr("action", "/album/get");
		actionForm.submit();
	});
	
	var searchForm = $("#searchForm");
	
	$("#searchForm button").on("click", function(e){
		if(!searchForm.find("option:selected").val()){
			alert("검색 종류를 선택해 주세요.");
			return false;
		}
		
		if(!searchForm.find("input[name='keyword']").val()){
			alert("키워드를 입력해 주세요.");
			return false;
		}
		
		searchForm.find("input[name='pageNum']").val("1");
		e.preventDefault();
		searchForm.submit();
	});
});
</script>
<%@ include file="../includes/footer.jsp" %>