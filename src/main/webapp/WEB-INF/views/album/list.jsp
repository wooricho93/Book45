<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../includes/header.jsp" %>

<title>BOOK45 앨범</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" />
<link rel="stylesheet" type="text/css" href="/resources/css/album/albumList.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

<div id="wrap" align="center">
	<h2>앨범 목록</h2>
	<table class="list">
		<c:forEach var="album" items="${list}">
			<tr class="record">
				<td name="num">${album.num}<input type="hidden" name="num" value="${album.num}"></td>
				<td><a class="move" href='<c:out value="${album.productNum}"/>'><img alt="" src="${album.albumPictureUrl}" id="cover"></a><input type="hidden" name="albumPictureUrl" value="${album.albumPictureUrl}"></td>
				<td>
					<b>카테고리</b> &nbsp; ${album.category}<input type="hidden" name="category" value="${album.category}"><br>
					<b>제목</b>&nbsp;<a class="move" href='<c:out value="${album.productNum}"/>'>${album.albumTitle}</a><br>
					<b>아티스트</b> &nbsp; ${album.singer} <input type="hidden" name="singer" value="${album.singer}"><br>
					<b>제작사</b> &nbsp; ${album.ent} <input type="hidden" name="ent" value="${album.ent}"><br>
					<b>가격</b> &nbsp;<fmt:formatNumber value="${album.albumPrice}" pattern="#,### 원"></fmt:formatNumber> &nbsp;<input type="hidden" name="albumPrice" value="${album.albumPrice}"><br>
					<b>발매일</b> ${album.releaseDate}
				</td>
			</tr>
		</c:forEach>
	</table>
</div>

<form id="actionForm" action="/album/list" method="get">
	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
	<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
	<input type="hidden" name="type" value="${pageMaker.cri.type}">
	<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
</form>

<!-- 장바구니 기능 -->
<form id="cartForm" method="post">
	<input type="hidden" name="id" value="${member.id}">
	<input type="hidden" name="productNum" value="">
	<input type="hidden" name="amount" value="">
</form>
        
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
 <!-- 검색 시작 -->
<div class='row' align="center">
	<div class="col-lg-12">
		<form id = "searchForm" action="/album/list" method="get">
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
		actionForm.attr("action", "/album/list"); // 수정삭제메뉴에서 뒤로가기 한다음 page번호 클릭하면 상세페이지 빠지는 것 방지
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});
	
	$(".move").on("click",function(e){
		e.preventDefault();
		//추가
		actionForm.find("input[name='productNum']").remove();  //뒤로 간 후 리스트 클릭하면 productNum이 계속 쌓이는 문제
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
		
		e.preventDefault();
		searchForm.find("input[name='pageNum']").val("1");
		searchForm.submit();
	});
});
</script>
<%@ include file="../includes/footer.jsp" %>