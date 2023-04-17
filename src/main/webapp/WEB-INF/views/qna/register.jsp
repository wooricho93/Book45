<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../includes/header.jsp"%>


<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	session.setAttribute("id", id);
%>
<title>BOOK45 Q&A</title>

<link rel="stylesheet" type="text/css" href="/resources/css/qna/qnaRegister.css">
<div id="container">
	<div class="headline">
		<h2 style="text-align: center;">문의글 작성</h2><br><br><br>
	</div>
	
	<div id="register">
		<form method="post" action="/qna/register" name="frm">
			<table width="100%">
				<tr height="50px">
					<th width="40%">작성자</th>
					<td>
						${member.id}
						<input type='hidden' name='id' value='${member.id}'>
					</td>
				</tr>
				<tr height="50px">
					<th width="40%">제목</th>
					<td>
						<input type="text" name="title" id="title">
					</td>
				</tr>
				<tr height="50px">
					<th width="40%">공개 여부</th>
					<td>
					    <input type="radio" name="secret" id="secret" value='N' class="secret"/>&nbsp;공개&nbsp;
					    <input type="radio" name="secret" id="secret" value='Y' class="secret"/>&nbsp;비공개
					</td>
				</tr>
				<tr height="50px">
					<th width="40%">내용</th>
					<td>
						<textarea id="content" name="content" style="resize: none; outline: none;" cols="70" rows="10"></textarea>
						<p class="textCount">0 byte</p>
					</td>
				</tr>
			</table>
			<div class="qnaBtn">
				<button id="regBtn" type="submit" class="btn">문의 등록</button>
				<button id="resetBtn" class="btn" type="reset">다시 작성</button>
				<button type="button" class="btn" id="listBtn" onclick="location.href='/qna/list'">목록으로</button>
			</div>
		</form>
	</div>
</div>

<script>
$("#regBtn").click(function() {
	let container = $("#container");
	
	if (!container.find("#title").val()) {
		alert("제목을 입력해 주세요.");
		return false;
	} else if ((frm.secret[0].checked == false) && (frm.secret[1].checked == false)) {
		alert("비밀글 여부를 선택해 주세요.");
		return false;
	} else if (!container.find("#content").val()) {
		alert("문의 내용을 입력해 주세요.");
		return false;
	}
	alert("문의글이 정상적으로 등록되었습니다.");
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
<%@ include file="../includes/footer.jsp" %>