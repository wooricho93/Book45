<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../includes/header.jsp" %>
<title>BOOK45 자유게시판</title>
<link rel="stylesheet" href="/resources/css/board/boardGet.css">
<div id="container">
   <h1 class="page-header">게시글 조회</h1>
   
   <div class="row">
      <div class="col-lg-12">
         <div class="panel panel-default">
            <div id="getHead">
               <h1>${board.title}</h1>
               <div id="headBox">
                  <strong>${board.memberId}</strong>
                  <p>
                  	<fmt:formatDate value="${board.writeDate}" pattern="yyyy/MM/dd"/>
                  	조회수 ${board.readCount}
                  </p>
               </div>
            </div>
            <div class="panel-body">
               <div id="boardCon">
                     ${board.content}
               </div>
               <c:choose>
               
                  <c:when test="${empty member}">
                     <button data-oper="list" class="listBtn">목록으로</button>
                  </c:when>
                  <c:otherwise>
                     <c:if test="${board.memberId eq member.id && member.lev == 'B'}">
                        <button data-oper="modify" class="btn btn-default" id="updateBtn">수정</button>
                     </c:if>
                     <c:if test="${member.lev == 'A'}">
                        <button data-oper="aModify" class="btn btn-default" id="UpdateBtn">수정</button>
                     </c:if>
                     <button data-oper="list" class="listBtn">목록으로</button>
                  </c:otherwise>
               </c:choose>
               <form id="operForm" action="/board/boardModify" method="get">
                  <input type="hidden" id="num" name="num" value="<c:out value='${board.num}'/>">
                  <input type="hidden" name="pageNum" value="<c:out value='${cri.pageNum}'/>">
                  <input type="hidden" name="amount" value="<c:out value='${cri.amount}'/>">
                  <input type="hidden" name="type" value="<c:out value='${cri.type}'/>">
                  <input type="hidden" name="keyword" value="<c:out value='${cri.keyword}'/>">
               </form>
            </div>
         </div>
      </div>
   </div>

<!-- ----------------------댓글----------------------- -->
         	<div class="content_bottom">
            	<div class="panel-heading">
            		<div class="reply_subject">
            			<i class="fa-solid fa-comment-dots"></i>&nbsp;&nbsp;댓글 ${board.replyCnt}
            		</div>
               		<c:if test="${member != null}">
               			<div class="reply_button_wrap">
							<button id='addReplyBtn'>댓글 등록</button>
						</div>
               		</c:if>
            	</div>
            	<div class="reply_not_div"></div>
				<ul class="reply_content_ul"></ul>
				<div class="repy_pageInfo_div">
					<ul class="pageMaker"></ul>
				</div>
         	</div>
</div>
<!-- ----------------------댓글 끝----------------------- -->
<style>
   .chat > li:hover {
      cursor:pointer;
   }
</style>   
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script>
$(document).ready(function() {
	
	$("#addReplyBtn").on("click", function(e) {
		console.log("버튼 클릭");
			
		e.preventDefault();
	  	  
	  	const memberId = "${member.id}";
	  	const num = "${board.num}";
	  	  
	  	let popUrl = "/board/boardReplyEnroll/" + memberId + "?num=" + num;
	  	console.log(popUrl);
	  	let popOption = "width=490px, height=490px, top=300px, left=300px, scrollbars=yes";
	  	  
	  	window.open(popUrl, "댓글 등록", popOption);
	});
	
}); 
   
const boardNum = "${board.num}";

$.getJSON("/reply/list", {boardNum : boardNum}, function(obj){
	
	makeReplyContent(obj);
}); 

/* 댓글 페이지 정보 */
const cri = {
	boardNum : '${board.num}',
	pageNum : 1,
	amount : 10
}

/* 댓글 페이지 이동 버튼 동작 */
$(document).on('click', '.pageMaker_btn a', function(e){
		
	e.preventDefault();
	
	let page = $(this).attr("href");	
	cri.pageNum = page;		
	
	replyListInit();
});

/* 댓글 데이터 서버 요청 및 댓글 동적 생성 메서드 */
let replyListInit = function(){
	$.getJSON("/reply/list", cri , function(obj){
		
		makeReplyContent(obj);
		
	});		
}

/* 리뷰 수정 버튼 */
$(document).on('click', '.update_reply_btn', function(e){
	e.preventDefault();
	let replyNum = $(this).attr("href");		 
	let popUrl = "/board/boardReplyUpdate?replyNum=" + replyNum + "&boardNum=" + '${board.num}' + "&id=" + '${member.id}';	
	let popOption = "width = 490px, height=490px, top=300px, left=300px, scrollbars=yes"	
	
	window.open(popUrl,"댓글 수정", popOption);
});

/* 리뷰 삭제 버튼 */
$(document).on('click', '.delete_reply_btn', function(e){
	
	e.preventDefault();
	let replyNum = $(this).attr("href");	
	
	$.ajax({
		data : {
			replyNum : replyNum,
			boardNum : '${board.num}'
		},
		url : '/reply/delete',
		type : 'POST',
		success : function(result){
			replyListInit();
			alert('댓글 삭제가 완료되었습니다.');
		}
	});
});

/* 댓글 동적 생성 메서드 */
function makeReplyContent(obj) {
	
	if(obj.list.length === 0){
		$(".reply_not_div").html('<span>댓글이 없습니다.</span>');
		$(".reply_content_ul").html('');
		$(".pageMaker").html('');
	} else {
		$(".reply_not_div").html('');
		
		const list = obj.list;
		const pf = obj.pageInfo;
		
		const userId = '${member.id}';
		const boardWriter = '${board.memberId}';
		console.log('boardWriter: ' + boardWriter);
		const memberLev = '${member.lev}';
		
		let reply_list = '';			
		
		$(list).each(function(i,obj){
			if(obj.secret=== false){
				reply_list += '<li>';
				reply_list += '<div class="comment_wrap">';
				reply_list += '<div class="reply_top">';
				/* 닉네임 */
				reply_list += '<div id="textspan"><span class="nickname_span">'+ obj.nickname +'</span>';
				/* 날짜 */
				reply_list += '&nbsp;&#124;<span class="date_span">'+ obj.replyDate +'</span></div>';
				if(obj.memberId === userId || memberLev === 'A'){
					reply_list += '<div id="updelBtn"><a class="update_reply_btn" href="'+ obj.replyNum +'">수정</a><a class="delete_reply_btn" href="'+ obj.replyNum +'">삭제</a></div>';
				}
				reply_list += '</div>'; //<div class="reply_top">
				reply_list += '<div class="reply_bottom">';
				reply_list += '<div class="reply_bottom_txt">'+ obj.content +'</div>';
				reply_list += '</div>';//<div class="reply_bottom">
				reply_list += '</div>';//<div class="comment_wrap">
				reply_list += '</li>';
				}
			else if(obj.secret=== true){
				reply_list += '<li>';
				reply_list += '<div class="comment_wrap">';
				reply_list += '<div class="reply_top">';
				/* 아이디 */
				if(obj.memberId === userId || userId === boardWriter || memberLev === 'A'){
					reply_list += '<div id="textspan"><span class="nickname_span">'+ obj.nickname + '</span>';
				}else{
					reply_list += '<div id="textspan"><span class="nickname_span">익명</span>';
				}
				/* 날짜 */
				reply_list += '&nbsp;&#124;<span class="date_span">'+ obj.replyDate +'</span></div>';
				
				if(obj.memberId === userId || memberLev === 'A'){
					reply_list += '<div id="updelBtn"><a class="update_reply_btn" href="'+ obj.replyNum +'">수정</a><a class="delete_reply_btn" href="'+ obj.replyNum +'">삭제</a></div>';
				}
				reply_list += '</div>'; //<div class="reply_top">
				reply_list += '<div class="reply_bottom">';
				if(obj.memberId === userId || userId === boardWriter || memberLev === 'A'){
					reply_list += '<div class="reply_bottom_txt">'+ obj.content +'</div>';
				}else{
					reply_list += '<div class="reply_bottom_txt">비밀 댓글입니다.</div>';
				}
				reply_list += '</div>';//<div class="reply_bottom">
				reply_list += '</div>';//<div class="comment_wrap">
				reply_list += '</li>';
				}
				
			
		});
		
		$(".reply_content_ul").html(reply_list);
		
		/* 페이지 버튼 */
		let reply_pageMaker = "";
		
		/* prev */
		if(pf.prev){
			let prev_num = pf.startPage -1;
			reply_pageMaker += '<li class="pageMaker_btn prev">';
			reply_pageMaker += '<a href="'+ prev_num +'">이전</a>';
			reply_pageMaker += '</li>';	
		}
		/* number btn */
		for(let i = pf.startPage; i < pf.endPage+1; i++){
			reply_pageMaker += '<li class="pageMaker_btn ';
			if(pf.cri.pageNum === i){
				reply_pageMaker += 'active';
			}
			reply_pageMaker += '">';
			reply_pageMaker += '<a href="'+i+'">'+i+'</a>';
			reply_pageMaker += '</li>';
		}
		/* next */
		if(pf.next){
			let next_num = pf.endPage +1;
			reply_pageMaker += '<li class="pageMaker_btn next">';
			reply_pageMaker += '<a href="'+ next_num +'">다음</a>';
			reply_pageMaker += '</li>';	
		}
		
		$(".pageMaker").html(reply_pageMaker);
	}
}

$(document).ready(function() {
    var operForm = $("#operForm");
    
    $("button[data-oper='modify']").on("click", function(e) {
	   password = prompt("비밀번호를 입력해주세요.", "암호입력");
	   
	   if (password != ${board.pass}) {
		   alert("비밀번호가 일치하지 않습니다.");
		   return false;
	   } else {
		   alert("비밀번호가 일치합니다. 페이지를 이동합니다.");
		   operForm.attr("action", "/board/boardModify").submit();
	   }
	   
    });
    
  //관리자가 수정을 누를시 암호없이 수정페이지로 이동
    $("button[data-oper='aModify']").on("click", function(e){
 	   operForm.attr("action", "/board/boardModify").submit();
    });
   
    $("button[data-oper='list']").on("click", function(e) {
       operForm.find("#boardNum").remove();
       operForm.attr("action", "/board/boardList");
       operForm.submit();
    });
});
</script>

<%@ include file="../includes/footer.jsp" %>