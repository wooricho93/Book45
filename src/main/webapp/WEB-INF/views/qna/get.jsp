<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../includes/header.jsp" %>

	<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	session.setAttribute("id", id);
	%>

<title>BOOK45 Q&A</title>

<link rel="stylesheet" href="/resources/css/qna/qnaGet.css">

<%-- -----------------------------------  문의 상세내용 ----------------------------------------  --%>

<div id="container">
   <h1 class="page-header">Q&A 상세보기</h1>
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div id="getHead">
					<h1>${qna.title}</h1>
					<div id="headBox">
						<strong>${qna.id}</strong>
						<p><fmt:formatDate value="${qna.updateDate}" pattern="yyyy/MM/dd"/></p>
                  	<%-- 조회수 ${qna.readCount} --%>
					</div>
				</div>
				<div class="panel-body">
					<div id="boardCon">${qna.content}</div>
					<c:if test="${qna.id eq member.id || member.lev eq 'A'}">
						<button data-oper="modify" id="updateBtn" class="btn btn-default">수정</button>
					</c:if>
					<button data-oper="list" class="listBtn">목록으로</button>

					<form id="operForm" action="/qna/modify" method="get">
						<input type="hidden" id="qnum" name="qnum" value="<c:out value='${qna.qnum}'/>"> 
						<input type="hidden" name="pageNum" value="<c:out value='${cri.pageNum}'/>"> 
						<input type="hidden" name="amount" value="<c:out value='${cri.amount}'/>">
						<input type="hidden" name="type" value="<c:out value='${cri.type}'/>">
						<input type="hidden" name="keyword" value="<c:out value='${cri.keyword}'/>">
					</form>
				</div>
			</div>
		</div>
	</div>
					


<%-- -----------------------------------  문의 내용 END ----------------------------------------  --%>
<br>

<%-- -----------------------------------  답변 내용 START ----------------------------------------  --%>

		<div class="content_bottom">
            <div class="panel-heading" style="background-color: white;">
            		<div class="reply_subject">
            			<i class="fa-solid fa-comment-dots"></i>&nbsp;&nbsp; 답변
            		</div>
               		<c:if test="${member.lev eq 'A'}">	<!-- '관리자'만 답변을 달수있음 -->
               			<div class="reply_button_wrap">
							<button id='addReplyBtn'>답변 등록</button>
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
<%-- -----------------------------------  답변 내용 END script 시작 ----------------------------------------  --%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script>
$(document).ready(function() {
	
	$("#addReplyBtn").on("click", function(e) {
		console.log("버튼 클릭");
			
		e.preventDefault();
	  	  
	  	const id = "${member.id}";
	  	const qnum = "${qna.qnum}";
	  	  
	  	let popUrl = "/qna/qnaReplyEnroll/" + id + "?qnum=" + qnum;
	  	console.log(popUrl);
	  	let popOption = "width=490px, height=490px, top=300px, left=300px, scrollbars=yes";
	  	  
	  	window.open(popUrl, "답변 쓰기", popOption);
	});
	
}); 

/* 답글 리스트 출력 */
const qnum = '${qna.qnum}';
console.log("번호: " + qnum);
$.getJSON("/qnareply/list", {qnum : qnum}, function(obj){
	
	makeReplyContent(obj);
});  

			
/* 답글 페이지 정보 */
const cri = {
    qnum : '${qna.qnum}',
    pageNum : 1,
    amount : 10
}	
        
/* 답글 페이지 이동 버튼 동작 */
$(document).on('click', '.pageMaker_btn a', function(e){
     console.log("댓글 페이지 이동 버튼 동작 실행");
     e.preventDefault();
            
     let page = $(this).attr("href");	
     cri.pageNum = page;		
            
     replyListInit();         
});

/* 답글 데이터 서버 요청 및 답변 동적 생성 메서드 */
let replyListInit = function(){
	$.getJSON("/qnareply/list", cri , function(obj){
		makeReplyContent(obj);
		
	});		
}

/* 답변 수정 버튼 */
$(document).on('click', '.update_reply_btn', function(e){
    e.preventDefault();
    console.log("답변 수정 버튼 실행");
    
    let renum = $(this).attr("href");		 
    let popUrl = "/qna/qnaReplyUpdate?renum=" + renum + "&qnum=" + '${qna.qnum}' + "&id=" + '${member.id}';	
    let popOption = "width = 490px, height=490px, top=300px, left=300px, scrollbars=yes"	
                
    window.open(popUrl,"답글 수정",popOption);			
             
});	
        
/*삭제 버튼 */
$(document).on('click', '.delete_reply_btn', function(e){
	console.log("답변 삭제 버튼 실행");
    e.preventDefault();
    
    let renum = $(this).attr("href");	
            
    $.ajax({
         data : {
        	 renum : renum,
          	 qnum : '${qna.qnum}'
         },
          url : '/qnareply/delete',
          type : 'POST',
          success : function(result){
                    replyListInit();
                    alert('삭제가 완료되었습니다.');
          }
    });		            
});	
         
/* 답변 동적 생성 메서드*/
function makeReplyContent(obj) {
	
	 console.log("makeReplyContent 동작 실행")
	 
	if(obj.list.length === 0){
		$(".reply_not_div").html('<span>답변 처리 중입니다.</span>');
		$(".reply_content_ul").html('');
		$(".pageMaker").html('');
	} else {
		$(".reply_not_div").html('');
		
		const list = obj.list;
		const pf = obj.pageInfo;
		
		const userId = '${member.id}';
		
		let reply_list = '';			
		
		$(list).each(function(i,obj){
			
			reply_list += '<li>';
			reply_list += '<div class="comment_wrap">';
			reply_list += '<div class="reply_top">';
			/* 아이디 */
			reply_list += '<span class="id_span">'+ obj.id +'</span>';
			/* 날짜 */
			reply_list += '&nbsp;&#124;<span class="date_span">'+ obj.writeDate +'</span>';
			if(obj.id === userId){
				reply_list += '<div id="updelBtn"><a class="update_reply_btn" href="'+ obj.renum +'">수정</a><a class="delete_reply_btn" href="'+ obj.renum +'">삭제</a></div>';
			}
			reply_list += '</div>'; //<div class="reply_top">
			reply_list += '<div class="reply_bottom">';
			reply_list += '<div class="reply_bottom_txt">'+ obj.content +'</div>';
			reply_list += '</div>';//<div class="reply_bottom">
			reply_list += '</div>';//<div class="comment_wrap">
			reply_list += '</li>';
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
</script>
<script>
	$(document).ready(function() {
		var operForm = $("#operForm");

		$("button[data-oper='modify']").on("click", function(e) {
			operForm.attr("action", "/qna/modify").submit();
		});

		$("button[data-oper='list']").on("click", function(e) {
			operForm.find("#qnum").remove();
			operForm.attr("action", "/qna/list");
			operForm.submit();
		});
	});
</script>

<%@ include file="../includes/footer.jsp"%>