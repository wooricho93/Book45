<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
<title>BOOK45 자유게시판 등록</title>
<link rel="stylesheet" href="/resources/css/board/boardRegister.css">
	
<div id="container">
	<div class="headline">
		<h2 style="text-align: center;">게시글 작성</h2><br><br><br>
	</div>
	<div id="register">
		<form method="post" action="/board/boardRegister" name="frm">
			<input type="hidden" name="memberId" id="memberId" value="${member.id}">
			<table width="100%">
				<tr height="50px">
					<th width="20%">작성자</th>
					<td>${member.id}</td>
				</tr>
				<tr height="50px">
					<th width="20%">제목</th>
					<td>
						<input type="text" name="title" id="title"/>
					</td>
				</tr>
				<tr height="50px">
					<th width="20%">비밀번호</th>
					<td>
						<input type="password" name="pass" id="pass">
						<span>&nbsp; * 게시글 수정/삭제 시 필요합니다.</span>
					</td>
				</tr>
				<tr height="50px">
					<th width="20%">내용</th>
					<td>
						<textarea type="text" id="content" name="content" style="resize: none; outline: none;" cols="70" rows="10"></textarea>
						<p class="textCount">0 byte</p>
					</td>
				</tr>
			</table>
			<div class="boardBtn">
				<button id="RegiBtn" type="submit">게시글 등록</button>
				<button id="resetBtn" type="reset">다시 작성</button>
				<button type="button" class="Btn" id="listBtn" onclick="location.href='/board/boardList'">목록으로</button>
			</div>
		</form>
	</div>
</div>
	
<script>
$(document).ready(function() {
	$("#RegiBtn").click(function(){
		
		const container = $("#container");
		
		const regMemberId = $("#memberId").val();
		const regTitle = $("#title").val();
		const regPass = $("#pass").val();
		const regContent = $("#content").val();
		
		console.log(regMemberId);
		console.log(regTitle);
		console.log(regPass);
		console.log(regContent);
		
		if (!container.find("#title").val()) {
			alert("제목을 입력하세요.");
			return false;
		} else if (!container.find("#pass").val()) {
			alert("암호는 반드시 입력하세요.");
			return false;
		} else if (!container.find("#content").val()) {
			alert("내용을 입력하세요.");
			return false;
		}
		
		alert("게시글이 작성되었습니다.");
		
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
			alert("내용은 최대 500자 까지만 작성가능합니다");
		}
	});
	
	$("#pass").keyup(function(e){
		
		let passBox = $(this).val();
		
		if (passBox.length > 4) {
			//4글자가 넘어가면 타이핑 안되도록 설정
			$(this).val($(this).val().substring(0, 4));
			//4글자 넘거가면 알림창이 나오도록 설정
			alert("암호는 최대 4글자만 입력가능합니다");
		}
	});
});
</script>
<%@ include file="../includes/footer.jsp" %>