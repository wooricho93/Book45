<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BOOK45 앨범 리뷰</title>
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
	    height: 110%;  	
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

	/* 앨범 타이틀 영역 */
	.albumName_div {
		margin-bottom: 10px;
	}
	
	.albumName_div h2{
		margin : 0;
	}
  	/* 평점 영역 */
  	.rating_div{
  		padding-top: 10px;
  		display: flex;
  		flex-direction: row;
  		align-items: center;
  	}
  	.rating_div h4{
  		margin : 0;
  	}
  	select{
  	margin: 15px;
    width: 80px;
    height: 30px;
    text-align: center;
    font-size: 16px;
    font-weight: 600;  	
  	}
  	
  	select:focus {
	  	outline: 2px solid #8c8ce8;
  	}
  	/* 리뷰 작성 영역 */
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
				리뷰 등록
			</div>
			
			<div class="input_wrap">			
			<div class="albumName_div">
				<h2>${album.albumTitle}</h2>
			</div>
			<div>
				<h4>작성자 &#124; ${member.nickname}</h4>
			</div>
			<div class="rating_div">
				<h4>평점</h4>
				<select name="rating">
					<option value="1.0">1.0</option>
					<option value="2.0">2.0</option>
					<option value="3.0">3.0</option>
					<option value="4.0">4.0</option>
					<option value="5.0">5.0</option>
					<option value="6.0">6.0</option>
					<option value="7.0">7.0</option>
					<option value="8.0">8.0</option>
					<option value="9.0">9.0</option>
					<option value="10.0">10.0</option>
				</select>
			</div>
			<div class="content_div">
				<h4>리뷰</h4>
				<textarea name="content"></textarea>
			</div>
		</div>
			<div class="btn_wrap">
				<a class="enroll_btn">등록</a>&nbsp;<a class="cancel_btn">취소</a>
			</div>
		</div>

<script>
	/* 취소 버튼 */
	$(".cancel_btn").on("click", function(e){
		window.close();
	});	

	/* 등록 버튼 */
	$(".enroll_btn").on("click", function(e){

		const productNum = '${album.productNum}';
		const id = '${member.id}';
		const nickname = '${member.nickname}';
		const rating = $("select").val();
		const content = $("textarea").val();

		const data = {
				productNum : productNum,
				id : id,
				nickname : nickname,
				rating : rating,
				content : content
		}		
		
		$.ajax({
			data : data,
			type : 'POST',
			url : '/albumReview/enroll',
			success : function(result){
				
				/* 댓글 초기화 */
				$(opener.location).attr("href", "javascript:albumReviewListInit();");
				
				window.close();
			}
			
		});
	});
</script>
</body>
</html>