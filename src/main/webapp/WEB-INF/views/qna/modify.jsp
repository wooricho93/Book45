<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../includes/header.jsp" %>

<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	session.setAttribute("id", id);
%>
<title>BOOK34 Q&A</title>	

<link rel="stylesheet" type="text/css" href="/resources/css/qna/qnaModify.css">

<div id="container">
	<div class="headline">
		<h2>Q&A 수정</h2>
	</div>
	
	<form action="/qna/modify" method="post" id="form">
		<input type="hidden" name="qnum" value="${qna.qnum}">
		<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
		<input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
		<input type="hidden" name="type" value='<c:out value="${cri.type}"/>'>
		<input type="hidden" name="keyword" value='<c:out value="${cri.keyword}"/>'>
		
		<div id="textModify">
			<c:if test="${member.id eq qna.id}">
				<table id="table1">
					<tr height="50px;">
						<th width="20%">작성자</th>
						<td>
							<c:out value="${qna.id}"/>
						</td>
					</tr>
					<tr height="50px;">
						<th width="20%">제목</th>
						<td>
							<input type="text" name="title" id="title" value='<c:out value="${qna.title}"/>'>
						</td>
					</tr>
					<tr height="200px;">
						<th width="20%">내용</th>
						<td>
							<textarea rows="10" cols="70" name="content" id="content"
							style="resize: none; outline: none;">${qna.content}</textarea>
							<p class="textCount"> byte</p>
						</td>
					</tr>
					<tr height="50px;">
						<th>공개 여부</th>
						<td>
						    <c:if test="${qna.secret=='Y'}">
		                         <input type="radio" name="secret" id="secret" value="N" class="secret" ><span class="ml_10">&nbsp;공개</span>&nbsp;
		                         <input type="radio" name="secret" id="secret" value="Y" class="secret" checked><span class="ml_10">&nbsp;비공개</span>
		                     </c:if>
		                     <c:if test="${qna.secret=='N'}">
		                        <input type="radio" name="secret" id="secret" value="N" class="secret" checked><span class="ml_10">&nbsp;공개</span>&nbsp;
		                        <input type="radio" name="secret" id="secret" value="Y" class="secret" ><span class="ml_10">&nbsp;비공개</span>
		                     </c:if>
						</td>
					</tr>
				</table>
			</c:if>
			<c:if test="${member.lev == 'A'}">
				<table id="table2">
					<tr height="50px;">
						<th width="20%">작성자</th>
						<td>
							<c:out value="${qna.id}"/>
						</td>
					</tr>
					<tr height="50px;">
						<th width="20%">제목</th>
						<td>
							<c:out value="${qna.title}"/>
						</td>
					</tr>
					<tr height="200px;">
						<th width="20%">내용</th>
						<td>
							${qna.content}
						</td>
					</tr>
					<tr height="50px;">
						<th>공개 여부</th>
						<td>
							<c:if test="${qna.secret == 'Y'}">비공개</c:if>
						    <c:if test="${qna.secret == 'N'}">공개</c:if>
						</td>
					</tr>
				</table>
			</c:if>
			<div class="btn">
				<c:if test="${member.id eq qna.id}">
					<button type="submit" data-oper="modify" id="modifyBtn" class="modiBtn">
						수정
					</button>
				</c:if>
				<button type="submit" data-oper="remove" id="removeBtn" class="modiBtn">
					삭제하기
				</button>
				<button type="button" data-oper="list" id="listBtn" class="modiBtn" onclick="location.href='/qna/list'">
					목록으로
				</button>
			</div>
		</div>
	</form>
</div>
	
<script>
$(document).ready(function() {
	
	var formObj = $("form");
	
	$("#removeBtn").click(function() {
		alert("문의글이 삭제되었습니다.");
		formObj.attr("action", "/qna/remove");
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
		
		alert("문의글이 수정되었습니다.");
	});
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
		alert("내용은 최대 500자까지만 작성 가능합니다.");
	}
});
</script>

<%@ include file="../includes/footer.jsp" %>
