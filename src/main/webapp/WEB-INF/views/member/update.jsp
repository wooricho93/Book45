<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../includes/header.jsp" %>
<title>BOOK45 회원 정보</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" />
<link rel="stylesheet" type="text/css" href="/resources/css/member/update.css">
<link rel="stylesheet" href="/resources/css/common.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

<div id="container">
		<div id="wrap" align="center">
			<h2>회원 정보 수정</h2>
		<form id="updateForm" method="post" name="frm">
			<input type="hidden" name="lev" value="${member.lev}">
		     <div id="mypagebox">
				<p style="margin: 10px 0;">아이디</p>
				<input type="text" name="id" id="textbox" value="${member.id}" readonly>
				<p style="margin: 20px 0 10px 0;">비밀번호</p>
				<input type="password" class="pass" name="pass" id="textbox" value="${member.pass}">
				<span class="finalPassCheck">비밀번호는 필수 입력 사항입니다.</span>
				<p style="margin: 20px 0 10px 0;">비밀번호 재확인</p>
				<input type="password" class="pass2" name="pass_check" id="textbox">
				<span class="finalPassDoubleCheck">비밀번호를 한 번 더 입력해 주세요.</span>
	   			<span class="passCheck1">비밀번호가 일치합니다.</span>
	   			<span class="passCheck2">비밀번호가 일치하지 않습니다.</span>
				<p style="margin: 20px 0 10px 0;">이름</p>
				<input type="text" name="name" class="name" id="textbox" value="${member.name}" readonly>
				<span class="finalNameCheck">이름은 필수 입력 사항입니다.</span>
				<p style="margin: 20px 0 10px 0;">닉네임</p>
				<input type="text" name="nickname" class="nickname" id="textbox" value="${member.nickname}">
				<span class="finalNicknameCheck">닉네임은 필수 입력 사항입니다.</span>
				<span class="nicknameCheck1">사용 가능한 닉네임입니다.</span>
	   			<span class="nicknameCheck2">이미 사용 중인 닉네임입니다.</span>
				<p style="margin: 20px 0 10px 0;">전화번호</p>
				<input type="text" name="phone" class="phone" value="${member.phone}" id="textbox">
				<span class="finalPhoneCheck">전화번호는 필수 입력 사항입니다.</span>
			    <p style="margin: 20px 0 10px 0;">이메일</p>
				<input type="text" name="email" class="email" id="textbox" value="${member.email}">
				<span class="finalEmailCheck">이메일은 필수 입력 사항입니다.</span>
			    <p style="margin: 20px 0 10px 0;">우편번호</p>
	            <div class="addressBox">
	   			<input type="text" name="zipCode" class="zipCode" id="textbox" value="${member.zipCode}" placeholder="우편번호를 입력해 주세요" readonly>
	   			<input type="button" value="주소 찾기" onclick="executionDaumAddress()" id="overlap">
	   			</div>
	   			<br>
	            <p style="margin: 20px 0 10px 0;">주소</p>
	   			<input type="text" name="addressRoad" class="addressRoad" id="textbox" value="${member.addressRoad}" placeholder="주소를 입력해 주세요" readonly>
	   			<br>
	            <p style="margin: 20px 0 10px 0;">상세 주소</p>
	   			<input type="text" name="addressDetail" class="addressDetail" id="textbox" value="${member.addressDetail}" placeholder="상세 주소를 입력해 주세요" readonly>
	   			<span class="finalAddressCheck">상세 주소는 필수 입력 사항입니다.</span>
	   			<br>
				<button type="button" id="btn1">확인</button>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" id="btn2" value="취소" onclick="location.href='/member/myPage'"> 
   			</div>
		</form>
		</div>
	</div>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
let pwCheck = false; // 비밀번호 입력 여부
let pwDoubleCheck = false; // 비밀번호 확인
let pwFinalCheck = false; // 비밀번호 일치 여부
let nicknameCheck = false; // 닉네임 입력 여부
/* let nicknameDoubleCheck = false; // 닉네임 중복 체크 */
let phoneCheck = false; // 전화번호 입력 여부
let emailCheck = false; // 이메일 입력 여부
let addressCheck = false; // 주소 입력 여부

/* 수정 확인 버튼 클릭 */
$(document).ready(function() {
   $("#btn1").click(function() {
	  confirm("수정하시겠습니까?");
      let pw = $(".pass").val();
      let pw2 = $(".pass2").val();
      let nickname = $(".nickname").val();
      let phone = $(".phone").val();
      let email = $(".email").val();
      let address = $(".addressDetail").val();
      
      /* 비밀번호 유효성 검사 */
      if (pw == "") {
         $(".finalPassCheck").css("display", "block");
         pwCheck = false;
      } else {
         $(".finalPassCheck").css("display", "none");
         pwCheck = true;
      }
      
      /* 비밀번호 확인 유효성 검사 */
      if (pw2 == "") {
         $(".finalPassDoubleCheck").css("display", "block");
         pwDoubleCheck = false;
      } else {
         $(".finalPassDoubleCheck").css("display", "none");
         pwDoubleCheck = true;
      }
      
      /* 닉네임 유효성 검사 */
      if (nickname == "") {
         $(".finalNicknameCheck").css("display", "block");
         nicknameCheck = false;
      } else {
         $(".finalNicknameCheck").css("display", "none");
         nicknameCheck = true;
      }
      
      /* 전화번호 유효성 검사 */
      if (phone == "") {
         $(".finalPhoneCheck").css("display", "block");
         phoneCheck = false;
      } else {
         $(".finalPhoneCheck").css("display", "none");
         phoneCheck = true;
      }
      
      /* 이메일 유효성 검사 */
      if (email == "") {
         $(".finalEmailCheck").css("display", "block");
         emailCheck = false;
      } else {
         $(".finalEmailCheck").css("display", "none");
         emailCheck = true;
      }
      
      /* 주소 유효성 검사 */
      if (address == "") {
         $(".finalAddressCheck").css("display", "block");
         addressCheck = false;
      } else {
         $(".finalAddressCheck").css("display", "none");
         addressCheck = true;
      }
      
      
      if (pwCheck && pwDoubleCheck && pwFinalCheck && nicknameCheck && phoneCheck && emailCheck && addressCheck) {
         alert("회원 정보가 수정되었습니다.");
         $("#updateForm").attr("action", "/member/update");
         $("#updateForm").submit();
         
      }
      return false;
   });
});

/* 비밀번호 일치 확인 유효성 검사 */
$(".pass2").on("propertychange change keyup paste input", function() {
   let pw = $(".pass").val();
   let pw2 = $(".pass2").val();
   $(".finalPassDoubleCheck").css("display", "none");
   
   if (pw == pw2) {
      $(".passCheck1").css("display", "block");
      $(".passCheck2").css("display", "none");
      pwFinalCheck = true;
   } else {
      $(".passCheck2").css("display", "block");
      $(".passCheck1").css("display", "none");
      pwFinalCheck = false;
   }
});

/*비밀번호 유효성 검사*/
$(".pass").on("propertychange change keyup paste input", function(){
   $(".finalPassCheck").css("display", "none");
});

/* 닉네임 유효성 검사 */
$(".nickname").on("propertychange change keyup paste input", function(){
   $(".finalNicknameCheck").css("display", "none");
});

/* 전화번호 유효성 검사 */
$(".phone").on("propertychange change keyup paste input", function(){
   $(".finalPhoneCheck").css("display", "none");
});

/* 이메일 유효성 검사 */
$(".email").on("propertychange change keyup paste input",function(){
   $(".finalEmailCheck").css("display", "none");
});

/* 주소 유효성 검사 */
$(".addressDetail").on("propertychange change keyup paste input",function(){
   $(".finalAddressCheck").css("display", "none");
});

function executionDaumAddress() {
	 new daum.Postcode({
       oncomplete: function(data) {
    	  // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

           // 각 주소의 노출 규칙에 따라 주소를 조합한다.
           // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
           var addr = ''; // 주소 변수
           var extraAddr = ''; // 참고항목 변수

           //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
           if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
               addr = data.roadAddress;
           } else { // 사용자가 지번 주소를 선택했을 경우(J)
               addr = data.jibunAddress;
           }

           // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
           if(data.userSelectedType === 'R'){
               // 법정동명이 있을 경우 추가한다. (법정리는 제외)
               // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
               if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                   extraAddr += data.bname;
               }
               // 건물명이 있고, 공동주택일 경우 추가한다.
               if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
               }
               // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
               if(extraAddr !== ''){
                   extraAddr = ' (' + extraAddr + ')';
               }
               // 주소 변수 문자열과 참고항목의 문자열을 합친다.
               addr += extraAddr;
           
           } else {
               addr += ' ';
           }

           // 우편번호와 주소 정보를 해당 필드에 넣는다.
           $(".zipCode").val(data.zonecode);
           $(".addressRoad").val(addr);
           // 커서를 상세주소 필드로 이동한다.
           $(".addressDetail").attr("readonly", false);
           $(".addressDetail").focus();
       }
   }).open();
}
</script>
<%@ include file="../includes/footer.jsp" %>