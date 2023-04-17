<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../includes/header.jsp" %>

<title>BOOK45 앨범</title>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<link rel="stylesheet" href="/resources/css/album/albumDetail.css">

<div id="wrap" align="center">
	<input type="hidden" name="num" value="${album.num}">
	<input type="hidden" name="isbn" value="${album.productNum}">
	<input type="hidden" name="stock" id="stock" value="${album.stock}">
	<div id="albumdetail">
		<div id="album1">
			<h2>앨범 상세보기</h2>
		</div>
		<div id="album2">
			<div id="album2img">
				<img alt="" src="${album.albumPictureUrl}" width="100%" height="100%">
			</div>
			<div id="album2text">
				<p><b>카테고리</b> &nbsp; ${album.category}</p><br>
				<h2>${album.albumTitle}</h2>
				<p><b>아티스트</b>&nbsp;${album.singer} &#124; <b>제작사</b>&nbsp;${album.ent}</p>
				<p><b>가격</b>&nbsp;<fmt:formatNumber value="${album.albumPrice}" pattern="#,### 원"></fmt:formatNumber> &#124; <b>평점</b>&nbsp;${album.ratingAvg}<c:if test="${member.lev == 'A'}"> &#124; <b>재고</b>&nbsp;${album.stock}</p></c:if>
				<br><br>
				<p><b>발매일</b><br>${album.releaseDate}</p><br>
				<div>
					<p><b>수량</b></p>
					<button type="button" class="minusBtn">-</button>
					<input type="text" value="1" id="amountBox">
					<button type="button" class="plusBtn">+</button>
				</div>
				<div class="cart_order">
					<button type="button" id="cart">장바구니</button>
					<button type="button" id="buyBtn">구매하기</button>
				</div>
			</div>
		</div>
	</div>
	<button type="button" id="listBtn" data-oper='list'>목록</button>
</div>

<!-- 수정 -->
<form id='operForm' method="get">
	<input type='hidden' id='productNum' name='productNum' value='${album.productNum}'>
	<input type='hidden' name='pageNum' value='${cri.pageNum}'>
	<input type='hidden' name='amount' value='${cri.amount}'>
	<input type='hidden' name='keyword' value='${cri.keyword}'>
	<input type='hidden' name='type' value='${cri.type}'>
</form>

<!-- 주문 -->
<form action="/order/orderPage/${member.id}" method="get" class="orderForm">
	<input type="hidden" name="orders[0].productNum" value="${album.productNum}">
	<input type="hidden" name="productNum" value="${album.productNum}">
	<input type="hidden" name="orders[0].isbn" value="${book.isbn}">
	<input type="hidden" name="orders[0].amount" value="">
</form>

<form id="cartForm" action="/cart/addAlbumCart" method="post">
	<input type="hidden" name="stock" class="stock">
</form>
	
<!-- 리뷰 시작 -->	

<div class="content_bottom">
	<div class="panel-heading">
		<div class="reply_subject">
			<i class="fa-solid fa-comment-dots"></i>&nbsp;&nbsp;앨범 리뷰
		</div>
		<c:if test="${member != null}">
			<div class="reply_button_wrap">
			<button id='addReplyBtn'>리뷰 작성</button>
			</div>
		</c:if>
	</div>
	<div class="reply_not_div"></div>
	<ul class="reply_content_ul"></ul>
	<div class="repy_pageInfo_div">
		<ul class="pageMaker"></ul>
	</div>
</div>
				
<!-- 리뷰 끝 -->

<script type="text/javascript" src="/resources/js/reply.js"></script>
<script type="text/javascript">
let amount = $("#amountBox").val();
let stock = $("#stock").val();

$(".plusBtn").on("click", function() {
	if (amount <= stock) {
		$("#amountBox").val(++amount);
	} else if (amount > stock) {
		alert("구매 가능한 최대 수량은 " + stock + "권입니다.");
		$("#amountBox").val(stock);
	}
});
$(".minusBtn").on("click", function() {
	if (amount > 1) {
		$("#amountBox").val(--amount);
	}
});

const form = {
	id: '${member.id}',
	productNum: '${album.productNum}'
}
	
$("#cart").on("click", function(e) {
	form.amount = $("#amountBox").val();
	$.ajax({
		url: "/cart/addAlbumCart",
		type: "POST",
		data: form,
		success: function(result) {
			cartAlert(result);
		}
	});
});

function cartAlert(result) {
	if (result == '0') {
		alert("장바구니 추가에 실패했습니다.");
	} else if (result == '1') {
		alert("장바구니에 추가되었습니다.");
	} else if (result == '2') {
		alert("이미 장바구니에 존재하는 상품입니다.");
	} else if (result == '5') {
		alert("로그인이 필요합니다.");
	}
}

$("#buyBtn").on("click", function() {
	let amount = $("#amountBox").val();
	$(".orderForm").find("input[name='orders[0].amount']").val(amount);
	$(".orderForm").submit();
});

$(document).ready(function() {
	
	/* 리뷰쓰기 */
	$(".reply_button_wrap").on("click", function(e){
	
		e.preventDefault();	
		
		const id = '${member.id}';
		const productNum = '${album.productNum}';
	
		
		$.ajax({
			data : {
				productNum : productNum,
				id : id
			},
			url : '/albumReview/check',
			type : 'POST',
			success : function(result){

				if(result === '1'){
					alert("이미 등록된 리뷰가 존재 합니다.");
				} else if(result === '0'){
					let popUrl = "/album/albumReviewEnroll/" + id + "?productNum=" + productNum;
					console.log(popUrl);
					let popOption = "width = 490px, height=490px, top=300px, left=300px, scrollbars=yes";
					
					window.open(popUrl,"리뷰 쓰기",popOption);							
				}	
			}
		});
	});
	

	/* 댓글 페이지 이동 버튼 동작 */
	$(document).on('click', '.pageMaker_btn a', function(e){
			
		e.preventDefault();
		
		let page = $(this).attr("href");	
		cri.pageNum = page;		
		
		albumReviewListInit();
		
	});
	
	const productNum = '${album.productNum}';  

	$.getJSON("/albumReview/list", {productNum : productNum}, function(obj){

		makeBookReviewContent(obj);

	});
	
	/* 댓글 페이지 정보 */
	const cri = {
	
	productNum : '${album.productNum}',
	pageNum : 1,
	amount : 10
	
	}
	
	/* 댓글 데이터 서버 요청 및 댓글 동적 생성 메서드 */
	let albumReviewListInit = function(){
		
		$.getJSON("/albumReview/list", cri , function(obj){
			
			makeBookReviewContent(obj);
			
		});		
	}
	
	/* 리뷰 수정 버튼 */
	 $(document).on('click', '.update_reply_btn', function(e){
			
		 	e.preventDefault();
		 	
		 	const id = '${member.id}';
			const productNum = '${album.productNum}';
			
			let num = $(this).attr("href");
			let popUrl = "/album/albumReviewUpdate?num=" + num + "&productNum=" + productNum + "&id=" + id;	
			let popOption = "width = 490px, height=490px, top=300px, left=300px, scrollbars=yes"
			
			window.open(popUrl,"앨범 리뷰 수정",popOption);
	 });
	
		/* 리뷰 삭제 버튼 */
	 $(document).on('click', '.delete_reply_btn', function(e){

		 	e.preventDefault();
			let num = $(this).attr("href");	
			
			$.ajax({
				data : {
				num : num,
				productNum : '${album.productNum}'
				},
				url : '/albumReview/delete',
				type : 'POST',
				success : function(result){
						albumReviewListInit();
						alert('삭제가 완료되었습니다.');
				}
			});	
			
	 });
		
	/* 댓글(리뷰) 동적 생성 메서드 */
	function makeBookReviewContent(obj){

		if(obj.list.length === 0){
			$(".reply_not_div").html('<span>리뷰가 없습니다.</span>');
			$(".reply_content_ul").html('');
			$(".pageMaker").html('');
					
		} else {
			
			$(".reply_not_div").html('');
			
			const list = obj.list;
			const pf = obj.pageInfo;
			const id = '${member.id}';
			const memberLev = '${member.lev}';
			
			/* list */
			
			let albumReview_list = '';
			
			$(list).each(function(i,obj){

				albumReview_list += '<li>';
				albumReview_list += '<div class="comment_wrap">';
				albumReview_list += '<div class="reply_top">';
				/* 아이디 */
				/* albumReview_list += '<span class="id_span">'+ obj.id+'</span>'; */
				/* 닉네임 */
				albumReview_list += '<span class="nickname_span">'+ obj.nickname+'</span>';
				/* 날짜 */
				albumReview_list += '<span class="date_span">'+ obj.writeDate +'</span>';
				/* 평점 */
				albumReview_list += '<span class="rating_span">평점 : <span class="rating_value_span">'+ obj.rating +'</span>점</span>';
				
				if(obj.id === id || memberLev === 'A'){
					albumReview_list += '<div id="updelBtn"><a class="update_reply_btn" href="'+ obj.num +'">수정</a><a class="delete_reply_btn" href="'+ obj.num +'">삭제</a></div>';
				}
				
				albumReview_list += '</div>'; //<div class="reply_top">
				albumReview_list += '<div class="reply_bottom">';
				albumReview_list += '<div class="reply_bottom_txt">'+ obj.content +'</div>';
				albumReview_list += '</div>';//<div class="reply_bottom">
				albumReview_list += '</div>';//<div class="comment_wrap">
				albumReview_list += '</li>';
				
			});	
			
			$(".reply_content_ul").html(albumReview_list);	
				
			/* 페이지 버튼 */
			
			let albumReview_pageMaker = '';
			
			/* prev */
			if(pf.prev){
				let prev_num = pf.startPage -1;
				albumReview_pageMaker += '<li class="pageMaker_btn prev">';
				albumReview_pageMaker += '<a href="'+ prev_num +'">이전</a>';
				albumReview_pageMaker += '</li>';	
			}

			/* numbre btn */
			for(let i = pf.startPage; i < pf.endPage+1; i++){
				albumReview_pageMaker += '<li class="pageMaker_btn ';
				if(pf.cri.pageNum === i){
					albumReview_pageMaker += 'active';
				}
				
				albumReview_pageMaker += '">';
				albumReview_pageMaker += '<a href="'+i+'">'+i+'</a>';
				albumReview_pageMaker += '</li>';
			}
				
			/* next */
			if(pf.next){
				let next_num = pf.endPage +1;
				albumReview_pageMaker += '<li class="pageMaker_btn next">';
				albumReview_pageMaker += '<a href="'+ next_num +'">다음</a>';
				albumReview_pageMaker += '</li>';	
			}
						
			$(".pageMaker").html(albumReview_pageMaker);	
		}		
	}
	 
}); //$(document).ready(function())

$(document).ready(function() {
	let operForm = $("#operForm");

	$("button[data-oper='modify']").on("click", function() {
		operForm.attr("action", "/album/modify").submit();
	});

	$("button[data-oper='list']").on("click", function() {
		operForm.find("#num").remove();
		operForm.attr("action", "/album/list");
		operForm.submit();
	});
});
</script>
<%@ include file="../includes/footer.jsp" %>