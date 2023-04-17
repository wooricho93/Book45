<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>답변 작성</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.3/jquery.min.js" integrity="sha512-STof4xm1wgkfm7heWqFJVn58Hm3EtS31XFaagaa8VMReCXAkQnJZ+jEy8PCC/iT18dFy95WcExNHFTqLyp72eQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" type="text/css" href="/resources/css/reply/reply.css">

<style type="text/css">
  	/* 창 여분 없애기 */
  	body{
  		margin : 0;
  	}
  	/* 전체 배경화면 색상 */
  	.wrapper_div{
		background-color: #f9f9f9;
	    height: 100%;  	
  	}
 	/* 팝업창 제목 */
  	.subject_div{
	    background-color: #8c8ce8;
	    color: white;
	    padding: 10px;
	    font-weight: bold;
  	}
  	
  	/* 컨텐츠, 버튼 영역 padding */
  	.input_wrap{
  		padding: 30px;
  	}
  	.btn_wrap{
  		padding: 5px 30px 30px 30px;
  		text-align: center;
  	}
  	
  	/* 버튼 영역 */
  	.cancel_btn{
  		margin-right:5px;
  	    display: inline-block;
	    width: 130px;
	    background-color: white;
	    border: 1px solid #d9d9d9;
	    padding-top: 10px;
	    height: 27px;
	    font-size: 14px;
	    line-height: 18px;  
	    cursor: pointer;
  	}
  	
  	.cancel_btn:hover {
  		background-color: #8c8ce8;
  		color: white;
  	}
  	
  	.enroll_btn{
   	    margin-right:5px;
  	    display: inline-block;
	    width: 130px;
	    background-color: white;
	    border: 1px solid #d9d9d9;
	    padding-top: 10px;
	    height: 27px;
	    font-size: 14px;
	    line-height: 18px;  
	    cursor: pointer;	
  	}
  	
  	.enroll_btn:hover {
  		background-color: #8c8ce8;
  		color: white;
  	}

	/* QnA 제목 영역 */
	.qnaName_div {
		margin-bottom: 10px;
	}
	
	.qnaName_div h2{
		margin : 0;
	}

  	/* 답변 작성 영역 */
  	.content_div{
  		padding-top: 10px;
  	}
  	.content_div h4{
  		margin : 0;
  	}
  	textarea{
		width: 100%;
	    height: 150px;
	    border: 1px solid #dadada;
	    font-size: 15px;
	    color: #a9a9a9;
	    resize: none;
	    margin-top: 10px;  	
  	}
  	
  	textarea:focus {
 	 	outline: 2px solid #8c8ce8;
  	}
</style>
</head>
<body>
<div class="wrapper_div">
	<div class="subject_div">
		답변 등록
	</div>
	<br>
	<div class="input_wrap">			
			<div class="qnaName_div">
				<h3>제목 &#124; ${qnaInfo.title}</h3>
			</div>
			<div class="id_div">
				<h3>작성자 &#124; ${member.id}</h3>
			</div>
			<br><br>
			<div class="content_div">
				<h4>답변</h4>
				<textarea name="content"></textarea>
			</div>
		</div>
			<div class="btn_wrap">
			<a class="enroll_btn">등록</a>
			<a class="cancel_btn">취소</a>
		</div>
		</div>
<!-- ---------------------------------------------------------------------------------------------- -->
<script type="text/javascript">
	/* 취소 버튼 */
	$(".cancel_btn").on("click", function(e){
		window.close();
	});	

	/* 등록 버튼 */
	$(".enroll_btn").on("click", function(e){

		const qnum = '${qnaInfo.qnum}';
		const id = '${member.id}';
		const content = $("textarea").val();

		const data = {
				qnum : qnum,
				id : id,
				content : content
		}	
		$.ajax({
			data : data,
			type : 'POST',
			url : '/qnareply/enroll',
			success : function(result){
				alert("답변이 등록되었습니다.");
			
				$(opener.location).attr("href", "javascript:replyListInit();");	
				
				window.close();
			}
		});	
	});
	</script>
</body>
</html>