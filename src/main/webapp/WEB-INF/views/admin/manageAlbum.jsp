<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ include file="../includes/header.jsp" %>

<title>관리자 페이지 - 앨범 관리</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" />
<link rel="stylesheet" type="text/css" href="/resources/css/admin/manageAlbum.css">
<link rel="stylesheet" type="text/css" href="/resources/css/common.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

<div id="container">
	<h1>앨범 관리</h1>
	<input type="button" value="앨범 등록" id="regibtn" onclick="location.href='/album/register'" style="float: right;">
	<table class="list">
		<tr>
			<th width="5%">NO</th> <th width="10%">상품번호</th> <th width="10%">카테고리</th> <th width="30%">앨범명</th> <th width="20%">아티스트</th> <th width="15%">제작사</th> <th width="10%">가격</th>
		</tr>
		<c:forEach items="${list}" var="album">
			<tr>
				<td>${album.num}</td>
				<td><a class="move" href='<c:out value="${album.productNum}"/>'>${album.productNum}</a></td>
				<td>${album.category}</td>
				<td><a class="move" href='<c:out value="${album.productNum}"/>'>${album.albumTitle}</a></td>
				<td>${album.singer}</td>
				<td>${album.ent}</td>
				<td><fmt:formatNumber value="${album.albumPrice}" pattern="#,### 원"></fmt:formatNumber></td>
			</tr>
		</c:forEach>
	</table>
</div>

<form id="actionForm" action="/admin/manageAlbum" method="get">
	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
	<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
	<input type="hidden" name="type" value="${pageMaker.cri.type}">
	<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
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
			<form id = "searchForm" action="/admin/manageAlbum" method="get">
				<select name="type"  id="hoption">
		     		<option value="" <c:out value="${pageMaker.cri.type==null? 'selected': ''}"/>>--</option>
		     		<option value="B" <c:out value="${pageMaker.cri.type eq 'B'? 'selected': ''}"/>>앨범명</option>
		     		<option value="S" <c:out value="${pageMaker.cri.type eq 'S'? 'selected': ''}"/>>아티스트</option>
		     		<option value="E" <c:out value="${pageMaker.cri.type eq 'E'? 'selected': ''}"/>>제작사</option>
		     		<option value="BS" <c:out value="${pageMaker.cri.type eq 'BS'? 'selected': ''}"/>>앨범명/아티스트</option>
		     		<option value="BE" <c:out value="${pageMaker.cri.type eq 'BE'? 'selected': ''}"/>>앨범명/제작사</option>
		     		<option value="BSE" <c:out value="${pageMaker.cri.type eq 'BSE'? 'selected': ''}"/>>앨범명/아티스트/제작사</option>     		
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
	
	$(".paginate_button a").on("click", function(e){
		e.preventDefault();
		//추가
		//actionForm.attr("action", "/admin/manageAlbum"); // 수정삭제메뉴에서 뒤로가기 한다음 page번호 클릭하면 상세페이지 빠지는 것 방지
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});
	
	$(".move").on("click",function(e){
		e.preventDefault();
		//추가
		actionForm.find("input[name='productNum']").remove();  //뒤로 간 후 리스트 클릭하면 productNum이 계속 쌓이는 문제
		actionForm.append("<input type='hidden' name='productNum' value='" + $(this).attr("href") + "' >");
		actionForm.attr("action", "/album/modify");
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
		
		e.preventDefault();
		searchForm.find("input[name='pageNum']").val("1");
		searchForm.submit();
	});
});
</script>
<%@ include file="../includes/footer.jsp" %>