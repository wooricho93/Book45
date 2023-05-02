<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../includes/header.jsp" %>

<title>BOOK45 앨범</title>

<link rel="stylesheet" type="text/css" href="/resources/css/album/albumModify.css">

<div id="wrap" align="center">
	<h2>앨범 수정</h2>	
	<form id="modifyForm" role="form" action="/album/modify" method="post"> 
		<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}"/>'>
		<input type="hidden" name="amount" value='<c:out value="${cri.amount}"/>'>
		<input type="hidden" name="type" value='<c:out value="${cri.type}"/>'>
		<input type="hidden" name="keyword" value='<c:out value="${cri.keyword}"/>'>
		<input type="hidden" name="productNum" value="${album.productNum}">
		<table>
			<tr>
				<th>상품번호</th>
				<td>
					<input type="text" name="productNum" id="productNum" value="${album.productNum}">
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
					<input type="text" id="albumTitle" name="albumTitle" value="${album.albumTitle}">
					<span class="finalTitleCheck">앨범명을 입력해 주세요.</span>
				</td>
			</tr>
			<tr>
				<th>아티스트</th>
				<td>
					<input type="text" id="singer" name="singer" value="${album.singer}">
					<span class="finalSingerCheck">가수명을 입력해 주세요.</span>
				</td>
			</tr>
			<tr>
				<th>제작사</th>
				<td>
					<input type="text" id="ent" name="ent" value="${album.ent}">
					<span class="finalEntCheck">제작사명을 입력해 주세요.</span>
				</td>
			</tr>
			<tr>
				<th>가격</th>
				<td>
					<input type="text" id="albumPrice" name="albumPrice" value="${album.albumPrice}">
					<span class="finalPriceCheck">앨범 가격을 입력해 주세요.</span>
				</td>
			</tr>
			<tr>
				<th>발매일</th>
				<td>
					<input type="text" id="releaseDate" name="releaseDate" value="${album.releaseDate}">
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
					<input type="text" id="stock" name="stock" value="${album.stock}">
					<span class="finalStockCheck">재고를 입력해 주세요.</span>
				</td>
			</tr>
		</table>
		<button type="submit" id="modBtn" class="Btn">앨범 수정</button>
		<button type="submit" data-oper="remove" class="Btn" id="button">앨범 삭제</button>
		<button type="button" class="Btn" id="button" onclick="history.back()">목록</button>
	</form> 
</div>
	
<script type="text/javascript">
$(document).ready(function(){
	let formObj = $("form");
	
	$('#button').on("click", function(e){
		e.preventDefault();
		let operation = $(this).data("oper");
		
		console.log(operation);
		
		if(operation === 'remove'){
			formObj.attr("action", "/album/remove");
		} else if(operation === 'list'){
			formObj.attr("action", "/album/list").attr("method","get");
			
			let pageNumTag = $("input[name='pageNum']").clone();
			let amountTag = $("input[name='amount']").clone();
			let keywordTag = $("input[name='keyword']").clone();
			let typeTag = $("input[name='type']").clone();
			
			formObj.empty();
			formObj.append(pageNumTag);
			formObj.append(amountTag);
			formObj.append(keywordTag);
			formObj.append(typeTag);
		}
		
		formObj.submit();
	});
});

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
	$("#modBtn").click(function() {
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
	 		alert("앨범이 정상적으로 수정되었습니다.");
			$("#modifyForm").attr("action", "/album/modify");
			$("#modifyForm").submit();
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
