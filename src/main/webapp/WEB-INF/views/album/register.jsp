<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../includes/header.jsp" %>

<title>BOOK45 앨범</title>

<link rel="stylesheet" type="text/css" href="/resources/css/album/albumRegister.css">

<div id="wrap" align="center">
	<h2>앨범 등록</h2>	
	<form class="regForm" role="form" action="/album/register" method="post">
		<table>
			<tr>
				<th>상품번호</th>
				<td>
					<input type="text" name="productNum" id="productNum">
					<span class="finalProductNumCheck">상품번호를 입력해 주세요.</span>
				</td>
			</tr>
			<tr>
				<th>카테고리</th>
				<td>
					<select id="category" name="category" size="1">
						<option value="" disabled selected>카테고리</option>
						<option value="Blu-ray">Blu-ray</option>
						<option value="J-POP">J-POP</option>
						<option value="LP(Vinyl) 전문관">LP(Vinyl) 전문관</option>
						<option value="OST">OST</option>
						<option value="POP">POP</option>
						<option value="가요">가요</option>
						<option value="뮤직 DVD">뮤직 DVD</option>
						<option value="스타샵">스타샵</option>
						<option value="스페셜샵">스페셜샵</option>
						<option value="예약CD/LP">예약CD/LP</option>
						<option value="재즈">재즈</option>
						<option value="클래식">클래식</option>
					</select>
					<span class="finalCategoryCheck">카테고리를 선택해 주세요.</span>
				</td>
			</tr>
			<tr>
				<th>앨범명</th>
				<td>
					<input type="text" id="albumTitle" name="albumTitle">
					<span class="finalTitleCheck">앨범명을 입력해 주세요.</span>
				</td>
			</tr>
			<tr>
				<th>아티스트</th>
				<td>
					<input type="text" id="singer" name="singer">
					<span class="finalSingerCheck">가수명을 입력해 주세요.</span>
				</td>
			</tr>
			<tr>
				<th>제작사</th>
				<td>
					<input type="text" id="ent" name="ent">
					<span class="finalEntCheck">제작사명을 입력해 주세요.</span>
				</td>
			</tr>
			<tr>
				<th>가격</th>
				<td>
					<input type="text" id="albumPrice" name="albumPrice">
					<span class="finalPriceCheck">앨범 가격을 입력해 주세요.</span>
				</td>
			</tr>
			<tr>
				<th>발매일</th>
				<td>
					<input type="text" id="releaseDate" name="releaseDate">
					<span class="finalReleaseDateCheck">발매일을 입력해 주세요.</span>
				</td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td>
					<label for="file"><div id="upload">파일 업로드</div></label>
					<input type="file" id="file" name="albumPictureUrl">
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
		<input type="submit" value="등록" id="RegBtn" class="Btn"> 
		<input type="reset" value="다시 작성" class="Btn"> 
		<input type="button" value="목록" class="Btn" onclick="location.href='/admin/manageAlbum'">
	</form>
</div>

<script>
/* 앨범 등록 유효성 검사 */
let productNumCheck = false;
let categoryCheck = false;
let titleCheck = false;
let singerCheck = false;
let entCheck = false;
let priceCheck = false;
let releaseDateCheck = false;
let stockcheck = false;

$(document).ready(function() {
	$("#RegBtn").click(function() {
		let productNum = $("#productNum").val();
		let category = $("select[name='category']").val();
		let albumTitle = $("#albumTitle").val();
		let singer = $("#singer").val();
		let ent = $("#ent").val();
		let albumPrice = $("#albumPrice").val();
		let releaseDate = $("#releaseDate").val();
		let stock = $("#stock").val();
		
		/* 상품번호 유효성 검사 */
		if (productNum == "") {
			$(".finalProductNumCheck").css("display", "block");
			productNumCheck = false;
		} else {
			$(".finalProductNumCheck").css("display", "none");
			productNumCheck = true;
		}
		
		/* 카테고리 유효성 검사 */
		if (category == null) {
	 		$(".finalCategoryCheck").css("display", "block");
	 		categoryCheck = false;
	 	} else {
	 		$(".finalCategoryCheck").css("display", "none");
	 		categoryCheck = true;
	 	}
		
		/* 앨범명 유효성 검사 */
	 	if (albumTitle == "") {
	 		$(".finalTitleCheck").css("display", "block");
	 		titleCheck = false;
	 	} else {
	 		$(".finalTitleCheck").css("display", "none");
	 		titleCheck = true;
	 	}
		
	 	/* 가수명 유효성 검사 */
	 	if (singer == "") {
	 		$(".finalSingerCheck").css("display", "block");
	 		singerCheck = false;
	 	} else {
	 		$(".finalSingerCheck").css("display", "none");
	 		singerCheck = true;
	 	}
	 	
	 	/* 제작사 유효성 검사 */
	 	if (ent == "") {
	 		$(".finalEntCheck").css("display", "block");
	 		entCheck = false;
	 	} else {
	 		$(".finalEntCheck").css("display", "none");
	 		entCheck = true;
	 	}
	 	
	 	/* 가격 유효성 검사 */
	 	if (albumPrice == "") {
	 		$(".finalPriceCheck").css("display", "block");
			priceCheck = false;
	 	} else {
	 		$(".finalPriceCheck").css("display", "none");
	 		priceCheck = true;	
	 	}
	 	
	 	/* 발매일 유효성 검사 */
	 	if (releaseDate == "") {
	 		$(".finalReleaseDateCheck").css("display", "block");
	 		releaseDateCheck = false;
	 	} else {
	 		$(".finalReleaseDateCheck").css("display", "none");
	 		releaseDateCheck = true;
	 	}
	 	
	 	/* 재고 유효성 검사 */
	 	if (stock == "") {
	 		$(".finalStockCheck").css("display", "block");
	 		stockCheck = false;
	 	} else {
	 		$(".finalStockCheck").css("display", "none");
	 		stockCheck = true;	
	 	}
	 	
	 	if (productNumCheck && categoryCheck && titleCheck && singerCheck && entCheck && priceCheck && releaseDateCheck && stockCheck) {
	 		alert("앨범이 정상적으로 등록되었습니다.");
			$(".regForm").attr("action", "/album/register");
			$(".regForm").submit();
	 	}
	 	return false;
	});
});

/* 상품번호 유효성 해결 시 문구 삭제 */
$("#productNum").on("propertychange change keyup paste input",function(){
   $(".finalProductNumCheck").css("display", "none");
});

/* 카테고리 유효성 해결 시 문구 삭제 */
$("select[name='category']").on("propertychange change keyup paste input",function(){
   $(".finalCategoryCheck").css("display", "none");
});

/* 앨범명 유효성 해결 시 문구 삭제 */
$("#albumTitle").on("propertychange change keyup paste input",function(){
   $(".finalTitleCheck").css("display", "none");
});

/* 가수명 유효성 해결 시 문구 삭제 */
$("#singer").on("propertychange change keyup paste input",function(){
   $(".finalSingerCheck").css("display", "none");
});

/* 제작사 유효성 해결 시 문구 삭제 */
$("#ent").on("propertychange change keyup paste input",function(){
   $(".finalEntCheck").css("display", "none");
});

/* 가격 유효성 해결 시 문구 삭제 */
$("#albumPrice").on("propertychange change keyup paste input",function(){
   $(".finalPriceCheck").css("display", "none");
});

/* 발매일 유효성 해결 시 문구 삭제 */
$("#releaseDate").on("propertychange change keyup paste input",function(){
   $(".finalReleaseDateCheck").css("display", "none");
});

/* 재고 유효성 해결 시 문구 삭제 */
$("#stock").on("propertychange change keyup paste input",function(){
   $(".finalStockCheck").css("display", "none");
});
</script>
<%@ include file="../includes/footer.jsp" %>