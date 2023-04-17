<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글 수정</title>
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
  	
  	.update_btn{
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
     
     .update_btn:hover {
  		background-color: #8c8ce8;
  		color: white;
  	}

     .secret_div {
     	padding-top: 10px;
  		display: flex;
  		flex-direction: row;
  		justify-content: space-between;
     }
    
     textarea{
      width: 100%;
       height: 150px;
       border: 1px solid #dadada;
       /* padding: 10px; */
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
         댓글 수정
      </div>
      <br>
      <div class="input_wrap">         
         <div class="nickname_div">
            <h3>작성자&nbsp;&#124;&nbsp;${member.nickname}</h3>
         </div>
         <br><br>
         <div class="secret_div">
         	<b>댓글</b>
         	<span>
            <c:choose>
               <c:when test="${replyInfo.secret eq true}">
                  <input type="checkbox" name="secret" id="secret" checked> 비밀댓글
               </c:when>
                <c:otherwise>
                   <input type="checkbox" name="secret" id="secret"> 비밀댓글
                </c:otherwise>
             </c:choose>
             </span>
         </div>
         <div class="content_div">
            
            <textarea name="content">${replyInfo.content}</textarea>
         </div>
      </div>
      <div class="btn_wrap">
         <a class="update_btn">수정</a>&nbsp;<a class="cancel_btn">취소</a>
      </div>
   </div>
   <script>
   $(document).ready(function(){
      /* 취소 버튼 */
      $(".cancel_btn").on("click", function(e){
         window.close();
      });
      
      /* 등록 버튼 */
      $(".update_btn").on("click", function(e){
         if ($("#secret").is(":checked") ) {
            var secret=true;
         } else {
         var secret = false;
         }
         const replyNum = '${replyInfo.replyNum}';
         const boardNum = '${replyInfo.boardNum}';
         const memberId = '${member.id}';
      
         const content = $("textarea").val();      
         
         console.log("secret: "+secret);
         const data = {
               replyNum : replyNum, 
               boardNum : boardNum,
               memberId : memberId,
               secret : secret,
               content : content
         }   
         
         $.ajax({
            data : data,
            type : 'POST',
            url : '/reply/update',
            success : function(result){
               
               $(opener.location).attr("href", "javascript:replyListInit();");
               alert("댓글이 수정되었습니다.");
               window.close();
            }         
         });      
      });
   });
   </script>
</body>
</html>