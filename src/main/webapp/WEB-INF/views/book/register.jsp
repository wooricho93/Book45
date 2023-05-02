<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../includes/header.jsp" %>

<title>BOOK45 도서</title>

<link rel="stylesheet" type="text/css" href="/resources/css/book/bookRegister.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

<div id="wrap" align="center">
	<h2>도서 등록</h2>	
	<form class="regForm" action="/book/register" method="post">
		<table>
			<tr>
				<th>일련번호</th>
				<td>
					<input type="text" name="isbn" id="isbn">
					<span class="finalIsbnCheck">도서 일련번호를 입력해 주세요.</span>
				</td>
			</tr>
			<tr>
				<th>카테고리</th>
				<td>
					<select id="category" name="category" size="1">
						<option value="none" disabled selected>카테고리</option>
						<option value="IT 모바일">IT 모바일</option>
						<option value="가정 살림">가정 살림</option>
						<option value="경제 경영">경제 경영</option>
						<option value="국어 외국어 사전">국어 외국어 사전</option>
						<option value="만화/라이트노벨">만화/라이트노벨</option>
						<option value="사회 정치">사회 정치</option>
						<option value="소설/시/희곡">소설/시/희곡</option>
						<option value="수험서 자격증">수험서 자격증</option>
						<option value="어린이">어린이</option>
						<option value="에세이">에세이</option>
						<option value="예술">예술</option>
						<option value="유아">유아</option>
						<option value="인문">인문</option>
						<option value="자기계발">자기계발</option>
						<option value="자연과학">자연과학</option>
						<option value="종교">종교</option>
						<option value="청소년">청소년</option>
					</select>
					<span class="finalCategoryCheck">카테고리를 선택해 주세요.</span>
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>
					<input type="text" id="title" name="title">
					<span class="finalTitleCheck">도서 제목을 입력해 주세요.</span>
				</td>
			</tr>
			<tr>
				<th>저자</th>
				<td>
					<input type="text" id="author" name="author">
					<span class="finalAuthorCheck">작가명을 입력해 주세요.</span>
				</td>
			</tr>
			<tr>
				<th>출판사</th>
				<td>
					<input type="text" id="pub" name="pub">
					<span class="finalPubCheck">출판사명을 입력해 주세요.</span>
				</td>
			</tr>
			<tr>
				<th>가격</th>
				<td>
					<input type="text" id="price" name="price">
					<span class="finalPriceCheck">도서 가격을 입력해 주세요.</span>
				</td>
			</tr>
			<tr>
				<th>줄거리</th>
				<td>
					<textarea cols="110" rows="10" id="summary" name="summary"></textarea>
					<span class="finalSummaryCheck">줄거리를 입력해 주세요.</span>
				</td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td>
					<label for="file"><div id="upload">파일 업로드</div></label>
					<input type="file" id="file" name="pictureUrl">
					<div id="uploadResult">
					</div>
				</td>
			</tr>
			<tr>
				<th>재고</th>
				<td>
					<input type="text" id="stock" name="stock">
					<span class="finalStockCheck">재고를 입력해 주세요.</span>
				</td>
			</tr>
		</table>
		<input type="submit" value="도서 등록" id="RegBtn" class="Btn"> 
		<input type="reset" value="다시 작성" class="Btn"> 
		<input type="button" value="목록" class="Btn" onclick="history.back()">
	</form>
</div>
	
<script>
/* 도서 등록 유효성 검사 */
let isbnCheck = false; // 일련번호 입력 여부
let categoryCheck = false; // 카테고리 입력 여부
let titleCheck = false; // 제목 입력 여부
let authorCheck = false; // 저자 입력 여부
let pubCheck = false; // 출판사 입력 여부
let priceCheck = false; // 가격 입력 여부
let summaryCheck = false; // 줄거리 입력 여부
/* let grade = false; // 평점 입력 여부 */
let stockCheck = false; // 재고 입력 여부

$(document).ready(function() {
	$("#RegBtn").click(function() {
		let isbn = $("#isbn").val();
		let category = $("select[name='category']").val();
	    let title = $("#title").val();
	    let price = $("#price").val();
	    let summary = $("#summary").val();
	    let author = $("#author").val();
	    let pub = $("#pub").val();
	    let stock = $("#stock").val();
		
	    console.log("카테고리: " + category);
	    /* 일련번호 유효성 검사 */
	 	if (isbn == "") {
	 		$(".finalIsbnCheck").css("display", "block");
			isbnCheck = false;
	 	} else {
	 		$(".finalIsbnCheck").css("display", "none");
			isbnCheck = true;	
	 	}
	 	
	 	/* 카테고리 유효성 검사 */
	 	if (category == null) {
	 		$(".finalCategoryCheck").css("display", "block");
	 		categoryCheck = false;
	 	} else {
	 		$(".finalCategoryCheck").css("display", "none");
	 		categoryCheck = true;
	 	}
	 	
	 	/* 도서 제목 유효성 검사 */
	 	if (title == "") {
	 		$(".finalTitleCheck").css("display", "block");
	 		titleCheck = false;
	 	} else {
	 		$(".finalTitleCheck").css("display", "none");
	 		titleCheck = true;
	 	}
	 	
	 	/* 작가명 유효성 검사 */
	 	if (author == "") {
	 		$(".finalAuthorCheck").css("display", "block");
	 		authorCheck = false;
	 	} else {
	 		$(".finalAuthorCheck").css("display", "none");
	 		authorCheck = true;
	 	}
	 	
	 	/* 출판사 유효성 검사 */
	 	if (pub == "") {
	 		$(".finalPubCheck").css("display", "block");
	 		pubCheck = false;
	 	} else {
	 		$(".finalPubCheck").css("display", "none");
	 		pubCheck = true;
	 	}
	 	
	 	/* 가격 유효성 검사 */
	 	if (price == "") {
	 		$(".finalPriceCheck").css("display", "block");
			priceCheck = false;
	 	} else {
	 		$(".finalPriceCheck").css("display", "none");
	 		priceCheck = true;	
	 	}
	 	
	 	/* 줄거리 유효성 검사 */
	 	if (summary == "") {
	 		$(".finalSummaryCheck").css("display", "block");
	 		summaryCheck = false;
	 	} else {
	 		$(".finalSummaryCheck").css("display", "none");
	 		summaryCheck = true;
	 	}
	 	
	 	/* 재고 유효성 검사 */
	 	if (stock == "") {
	 		$(".finalStockCheck").css("display", "block");
	 		stockCheck = false;
	 	} else {
	 		$(".finalStockCheck").css("display", "none");
	 		stockCheck = true;	
	 	}
	 	
	 	if (isbnCheck && categoryCheck && titleCheck && priceCheck && summaryCheck && authorCheck && pubCheck && stockCheck) {
	 		alert("도서가 정상적으로 등록되었습니다.");
			$(".regForm").attr("action", "/book/register");
			$(".regForm").submit();
	 	}
	 	return false;
	});
});
	
/* 일련번호 유효성 해결 시 문구 삭제 */
$("#isbn").on("propertychange change keyup paste input",function(){
   $(".finalIsbnCheck").css("display", "none");
});

/* 카테고리 유효성 해결 시 문구 삭제 */
$("select[name='category']").on("propertychange change keyup paste input",function(){
   $(".finalCategoryCheck").css("display", "none");
});

/* 도서 제목 유효성 해결 시 문구 삭제 */
$("#title").on("propertychange change keyup paste input",function(){
   $(".finalTitleCheck").css("display", "none");
});

/* 작가명 유효성 해결 시 문구 삭제 */
$("#author").on("propertychange change keyup paste input",function(){
   $(".finalAuthorCheck").css("display", "none");
});

/* 출판사 유효성 해결 시 문구 삭제 */
$("#pub").on("propertychange change keyup paste input",function(){
   $(".finalPubCheck").css("display", "none");
});

/* 가격 유효성 해결 시 문구 삭제 */
$("#price").on("propertychange change keyup paste input",function(){
   $(".finalPriceCheck").css("display", "none");
});

/* 줄거리 유효성 해결 시 문구 삭제 */
$("#summary").on("propertychange change keyup paste input",function(){
   $(".finalSummaryCheck").css("display", "none");
});

/* 재고 유효성 해결 시 문구 삭제 */
$("#stock").on("propertychange change keyup paste input",function(){
   $(".finalStockCheck").css("display", "none");
});
</script>
<%@ include file="../includes/footer.jsp" %>
