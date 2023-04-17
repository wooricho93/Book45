<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../includes/header.jsp" %>
<title>BOOK45 자유게시판</title>
<link rel="stylesheet" href="/resources/css/board/boardModify.css">
	<div id="container">
		<div class="headline">
			<h2>게시글 수정</h2><br><br><br>
		</div>
		<form action="/board/boardModify" method="post" id="form">
			<input type="hidden" name="num" value="${board.num}">
			<input type="hidden" name="memberId" value="${board.memberId}">
			<div id="textModify">
				<div style="float: right;">
					<c:if test="${member.lev == 'A'}">
						<input type="checkbox" name="blind" id="blind"> 블라인드 처리
					</c:if>	
				</div>
				
				<table width="100%">
					<tr height="50px;">
						<th width="20%">작성자</th>
						<td>${board.memberId}</td>
					</tr>
					<tr height="50px;">
						<th width="20%">제목</th>
						<td>
							<input name="title" id="title" value="${board.title}">
						</td>
					</tr>
					<tr height="200px;">
						<th width="20%">내용</th>
						<td>
							<textarea rows="10" cols="70" name="content" id="content" style="resize: none; outline: none;">${board.content}</textarea>
							<p class="textCount"> byte</p>
						</td>
					</tr>
				</table>
				<div class="boardBtn">
					<button type="submit" id="modifyBtn" class="modiBtn">수정</button>
					<button type="submit" id="removeBtn" class="modiBtn">삭제하기</button>
					<button type="button" id="listBtn" class="modiBtn" onclick="location.href='/board/boardList'">목록으로</button>
				</div>
			</div>
		</form>
	</div>
<script type="text/javascript">
	$(document).ready(function(){
		
		var formObj = $("#form");
		
		$("#removeBtn").click(function(){
			
			alert("게시글이 삭제되었습니다.");
			
			formObj.attr("action", "/board/boardRemove");
			
		});
		
		$("#content").keyup(function(e){
			
			let textBox = $(this).val();
			
			if (textBox.length == 0 || content == '') {
		    	$('.textCount').text(' byte');
		    } else {
		    	$('.textCount').text(textBox.length + ' byte');
		    }
			
			if (textBox.length > 500) {
				//500자 이상은 타이핑이 안되게 설정함
				$(this).val($(this).val().substring(0, 500));
				//500자가 넝어가면 알림창이 나옴
				alert("내용은 최대 500자 까지만 작성가능합니다");
			}
		});
		
		$("#modifyBtn").click(function(){
			
			const modifyText = $("#textModify");
			
			if (!modifyText.find("#title").val()) {
				alert("제목을 입력해 주세요.");
				return false;
			} else if (!modifyText.find("#content").val()) {
				alert("내용을 입력해 주세요.");
				return false;
			}
			
			alert("게시글이 수정되었습니다.");
		});
		
	});
</script>
<%@ include file="../includes/footer.jsp" %>