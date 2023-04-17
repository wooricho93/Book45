<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../includes/header.jsp" %>

<title>BOOK45 공지사항</title>

<link rel="stylesheet" href="/resources/css/notice/noticeModify.css">

<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	session.setAttribute("id", id);
%>

<div id="container">
	<div class="headline">
		<h2 style="text-align: center;">공지사항 수정</h2><br><br><br>
	</div>
	
	<div id="wrap">
		<form name="noticeForm" role="form" action="/notice/modify" method="post">
			<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
			<input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
			<input type="hidden" name="type" value='<c:out value="${cri.type}"/>'>
			<input type="hidden" name="keyword" value='<c:out value="${cri.keyword}"/>'>
			<input type="hidden" name="num" value="${notice.num}">
			<table width="100%">
				<tr height="50px">
					<th width="40%">작성자</th>
					<td>
						${member.id}
						<input type="hidden" name="id" id="memberId" value="${member.id}">
					</td>
				</tr>
				<tr height="50px">
					<th width="40%">제목</th>
					<td><input type="text" name="title" id="title" value='<c:out value="${notice.title}"/>'></td>
				</tr>
				<tr height="200px">
					<th width="40%">내용</th>
					<td>
						<textarea cols="70" rows="10" name="content" id="content" style="resize: none;">${notice.content}</textarea>
						<p class="textCount">0 byte</p>
					</td>
				</tr>
			</table>
			<div class="noticeBtn">
				<button id="modityBtn" type="submit" class="btn btn-default">수정</button>
				<button type="submit" id="removeBtn" class="btn btn-danger">삭제</button>
				<button type="submit" onclick="location.href='/notice/list'" class="btn">목록으로</button>
			</div>
		</form>
	</div>
</div>

<script>



$(document).ready(function() {
	
	let formObj = $("form");
	
	$("#removeBtn").click(function(){
		alert("공지사항이 삭제되었습니다.");
		
		formObj.attr("action", "/notice/remove");
	});
	
	$("#modityBtn").click(function(){
		let container = $("#wrap");
		
		if (!container.find("#title").val()) {
			alert("제목을 입력해주세요.");
			return false;
		} else if (!container.find("#content").val()) {
			alert("내용을 입력해주세요.");
			return false;
		}
		
		alert("공지사항이 수정되었습니다.");
	});

});

$("#content").keyup(function(e){
	
	let textBox = $(this).val();
	
	if (textBox.length == 0 || content == '') {
    	$('.textCount').text('0 byte');
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
<!-- /#wrapper -->
<%@ include file="../includes/footer.jsp" %>
    