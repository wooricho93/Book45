<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ include file="../includes/header.jsp"%>
<%
	String id = (String)session.getAttribute("id"); 
%>

<title>BOOK45 주문</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" />
<link rel="stylesheet" type="text/css" href="/resources/css/order/orderPage.css">
<link rel="stylesheet" type="text/css" href="/resources/css/common.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<div id="content_area" align="center">
   <h2 align="center"> ${member.name}님의 주문 상품 정보 </h2>
   <div class="content_main">
      <!-- 회원 정보 -->
      <div class="memberInfo_div">
         <table class="tableMemberInfo">
            <tbody>
               <tr>
                  <th>주문자</th>
                  <td style="border-top: 1px solid #dddddd;">${member.name} | ${member.email}</td>
               </tr>
            </tbody>
         </table>
      </div>
      <!-- 배송지 정보 -->
      <div class="adressInfo_div">
         <div class="addressInfo_button_div">
            <button class="address_btn address_btn_1" onclick="showAddress('1')">사용자 정보 주소록</button>
            <button class="address_btn address_btn_2" onclick="showAddress('2')">직접 입력</button>
         </div>
         <div class="addressInfo_input_div_wrap">
            <div class="addressInfo_input_div addressInfo_input_div_1" style="display:block">
               <table>
                  <colgroup>
                     <col width="25%">
                     <col width="*">
                  </colgroup>
                  <tbody>
                     <tr>
                        <th>이름</th>
                           <td style="border-top: 1px solid #dddddd;">${member.name}</td>
                        </tr>
                        <tr>
                           <th>주소</th>
                           <td>(${member.zipCode}) ${member.addressRoad}, ${member.addressDetail}
                              <input type="hidden" name="selectAddress" class="selectAddress" value="T">
                              <input type="hidden" name="id" class="idInput" value="${member.id}">
                              <input type="hidden" name="nameInput" class="nameInput" value="${member.name}">
                              <input type="hidden" name="zipCodeInput" class="zipCodeInput" value="${member.zipCode}">
                              <input type="hidden" name="addressRoadInput" class="addressRoadInput" value="${member.addressRoad}">
                              <input type="hidden" name="addressDetailInput" class="addressDetailInput" value="${member.addressDetail}">
                              <input type="hidden" name="phoneInput" class="phoneInput" value="${member.phone}">
                              
                           </td>
                        </tr>
                        <tr>
                           <th>전화번호</th>
                           <td>${member.phone}</td>
                        </tr>
                     </tbody>
                  </table>
               </div>
               <div class="addressInfo_input_div addressInfo_input_div_2" style="display: none;">
                  <table>
                     <colgroup>
                        <col width="25%">
                        <col width="*">
                     </colgroup>
                     <tbody>
                        <tr>
                           <th>이름</th>
                           <td style="border-top: 1px solid #dddddd;"><input class="address_input"></td>
                        </tr>
                        <tr>
                           <th>주소</th>
                           <td>
                              <input type="hidden" class="selectAddress" value="F">
                              <input type="hidden" name="id" class="id_input" value="${member.id}">
                              <input class="address1_input" readonly="readonly">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button class="address_search_btn" onclick="execution_daum_address()">주소 찾기</button><br>
                              <input class="address2_input" readonly="readonly"><br>
                              <input class="address3_input" readonly="readonly">
                           </td>
                      </tr>
                      <tr>
                         <th>전화번호</th>
                            <td><input class="phone_input"></td>
                      </tr>
                     </tbody>
                  </table>
               </div>
            </div>
         </div>
         <!-- 상품 정보 -->
         <div class="orderGoods_div">
            <!-- 상품 종류 -->
            <div class="goodsKind_div">주문상품 총&nbsp;<span class="goodKind_div_count"></span>개</div>
            <!-- 상품 테이블 -->
            <table class="goods_subject">
               <colgroup>
                  <col width="15%">
                  <col width="45%">
                  <col width="40%">
               </colgroup>
               <tbody>
                  <tr>
                     <th>이미지</th>
                     <th>상품 정보</th>
                     <th>판매가</th>
                  </tr>
                  <c:choose>
                     <c:when test="${empty orderAlbumList}">
                        <c:forEach items="${orderBookList}" var="order">
                           <tr>
                              <td>
                                 <!-- 이미지 -->
                                 <img alt="" src="${order.pictureUrl}" id="cover">
                              </td>
                              <td>${order.title}</td>
                              <td class="goods_table_price_td">
                                 <fmt:formatNumber value="${order.price}" pattern="#,### 원"/> | 수량 ${order.amount}개
                                 <br><fmt:formatNumber value="${order.totalPrice}" pattern="#,### 원"/>
                                 <input type="hidden" class="priceInput" value="${order.price}">
                                 <input type="hidden" class="albumPriceInput" value="${order.albumPrice}">
                                 <input type="hidden" class="totalAlbumPriceInput" value="${order.albumPrice*order.amount}">
                                 <input type="hidden" class="amountInput" value="${order.amount}">
                                 <input type="hidden" class="totalPriceInput" value="${order.price*order.amount}">
                                 <input type="hidden" class="isbnInput" value="${order.isbn}">
                              </td>
                           </tr>
                        </c:forEach>
                     </c:when>
                     <c:when test="${empty orderBookList}">
                        <c:forEach items="${orderAlbumList}" var="order">
                           <tr>
                              <td>
                                 <!-- 이미지 -->
                                 <img alt="" src="${order.albumPictureUrl}" id="cover">
                              </td>
                              <td>${order.albumTitle}</td>
                              <td class="goods_table_price_td">
                                 <fmt:formatNumber value="${order.albumPrice}" pattern="#,### 원"/> | 수량 ${order.amount}개
                                 <br><fmt:formatNumber value="${order.totalPrice}" pattern="#,### 원"/>
                                 <input type="hidden" class="totalPriceInput" value="${order.price*order.amount}">
                                 <input type="hidden" class="albumPriceInput" value="${order.albumPrice}">                              
                                 <input type="hidden" class="priceInput" value="${order.price}">                              
                                 <input type="hidden" class="amountInput" value="${order.amount}">
                                 <input type="hidden" class="totalAlbumPriceInput" value="${order.albumPrice*order.amount}">
                                 <input type="hidden" class="productNumInput" value="${order.productNum}">
                              </td>
                           </tr>
                        </c:forEach>
                     </c:when>
                     <c:otherwise>
                        <c:forEach items="${orderBookList}" var="order">
                           <tr>
                              <td>
                                 <!-- 이미지 -->
                                 <img alt="" src="${order.pictureUrl}" id="cover">
                              </td>
                              <td>${order.title}</td>
                              <td class="goods_table_price_td">
                                 <fmt:formatNumber value="${order.price}" pattern="#,### 원"/> | 수량 ${order.amount}개
                                 <br><fmt:formatNumber value="${order.totalPrice}" pattern="#,### 원"/>
                                 <input type="hidden" class="albumPriceInput" value="${order.albumPrice}">                              
                                 <input type="hidden" class="priceInput" value="${order.price}">
                                 <input type="hidden" class="amountInput" value="${order.amount}">
                                 <input type="hidden" class="totalPriceInput" value="${order.price*order.amount}">
                                 <input type="hidden" class="totalAlbumPriceInput" value="${order.albumPrice*order.amount}">
                                 <input type="hidden" class="isbnInput" value="${order.isbn}">
                              </td>
                           </tr>
                        </c:forEach>
                        <c:forEach items="${orderAlbumList}" var="order">
                           <tr>
                              <td>
                                 <!-- 이미지 -->
                                 <img alt="" src="${order.albumPictureUrl}" id="cover">
                              </td>
                              <td>${order.albumTitle}</td>
                              <td class="goods_table_price_td">
                                 <fmt:formatNumber value="${order.albumPrice}" pattern="#,### 원"/> | 수량 ${order.amount}개
                                 <br><fmt:formatNumber value="${order.totalPrice}" pattern="#,### 원"/>
                                 <input type="hidden" class="priceInput" value="${order.price}">
                                 <input type="hidden" class="albumPriceInput" value="${order.albumPrice}">                              
                                 <input type="hidden" class="amountInput" value="${order.amount}">
                                 <input type="hidden" class="totalAlbumPriceInput" value="${order.albumPrice*order.amount}">
                                 <input type="hidden" class="totalPriceInput" value="${order.price*order.amount}">
                                 <input type="hidden" class="productNumInput" value="${order.productNum}">
                              </td>
                           </tr>
                        </c:forEach>
                     </c:otherwise>
                  </c:choose>
               </tbody>
            </table>
         </div>
         <!-- 포인트 정보 -->
         <div class="point_div">
            <div class="point_div_subject">
               <table class="pointTable">
                  <colgroup>
                     <col width="25%">
                     <col width="*">
                  </colgroup>
                  <tbody>
                     <tr>
                        <th>포인트 사용</th>
                        <td style="border-top: 1px solid #dddddd;">
                           <fmt:formatNumber value="${member.point}" pattern="#,###"></fmt:formatNumber>&nbsp;point &nbsp;&#124;&nbsp; 
                           <input class="order_point_input" value='<fmt:formatNumber pattern="#,###" value="0"></fmt:formatNumber>'>&nbsp;원&nbsp;&nbsp;
                           <button class="order_point_input_btn order_point_input_btn_N" data-state="N">모두 사용</button> 
                           <button class="order_point_input_btn order_point_input_btn_Y" data-state="Y">취소</button>
                        </td>
                     </tr>
                  </tbody>
               </table>
            </div>
            <!-- 주문 종합 정보 -->
            <div class="totalInfo">
               <!-- 가격 종합 정보 -->
               <div class="totalInfoPrice">
                  <ul>
                     <li>
                        <span class="price_span">상품 금액</span>
                        <span class="totalAllPrice_span"></span> 원
                     </li>
                     <li>
                        <span class="price_span">배송비</span>
                        <span class="delivery_span"></span> 원
                     </li>
                     <li>
                        <span class="price_span">사용 포인트</span>
                        <span class="usePoint_span"></span> point
                     </li>
                     <li class="priceTotal">
                        <strong class="price_span totalPriceLabel">최종 결제 금액</strong>
                        <strong class="strong_red">
                           <span class="totalPrice_red finalTotalPrice_span" id="finalPrice"></span> 원
                        </strong>
                     </li>
                  </ul>
               </div>
               <!-- 버튼 영역 -->
				<div class="totalInfoBtn">
					<button class="orderBtn">결제하기</button>
				</div>
            </div>
         </div>
         <!-- 주문 요청 form -->
         <form class="order_form" action="/order/order" method="post">
            <!--  주문자 회원번호 -->
            <input type="hidden" name="id" value="${member.id}">
            <!-- 주소록 & 받는이 -->
            <input type="hidden" name="name">
            <input type="hidden" name="zipCode">
            <input type="hidden" name="addressRoad">
            <input type="hidden" name="addressDetail">
            <input type="hidden" name="phone">
            <!-- 사용 포인트 -->
            <input type="hidden" name="usePoint">
            <input type="hidden" id="totalPriceHidden">
            <!-- 상품 정보 -->
         </form>
   </div>
</div>
<!-- 다음 주소api 주소 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">
$(document).ready(function(){
   /* 주문 종합정보란 최신화 */
   setTotalInfo();
});
/* 주소 입력란 버튼 동작(숨김,등장) */
  function showAddress(className){
   /* 컨텐츠 동작 */
   /* 모두 숨기기 */
      $(".addressInfo_input_div").css('display','none');
   /* 컨텐츠 보이기 */
      $(".addressInfo_input_div_" + className).css('display','block');
   
   /* selectAddresss T/F 동작 */
      /* 모든 selectAddress F 만들기 */
   $(".addressInfo_input_div").each(function(i,obj){
      $(obj).find(".selectAddress").val("F");
      });
      /* 선택한 selectAddress T만들기 */
      $(".addressInfo_input_div_" + className).find(".selectAddress").val("T");
}
/* 다음 주소 연동 */
function execution_daum_address(){
       console.log("동작");
      new daum.Postcode({
           oncomplete: function(data) {
               // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
               
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
                    // 추가해야할 코드
                    // 주소변수 문자열과 참고항목 문자열 합치기
                      addr += extraAddr;
                
                } else {
                   addr += ' ';
                }
 
                // 제거해야할 코드
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                $(".address1_input").val(data.zonecode);
                $(".address2_input").val(addr);            
                // 커서를 상세주소 필드로 이동한다.
                $(".address3_input").attr("readonly", false);
                $(".address3_input").focus();    
               
           }
       }).open();     
} 
  /* 포인트 입력 (0이상 & 최대 포인트 수 이하)*/
$(".order_point_input").on("propertychange change keyup paste input", function(){
	let maxPoint = parseInt('${member.point}');
	let inputValue = parseInt($(this).val());
	let price = $(".finalTotalPrice_span");
	
	if(inputValue < 0){
	   $(this).val(0);
	}else if(inputValue > maxPoint){
	   $(this).val(maxPoint);
	}else if(inputValue > price){
	   $(this).val(price);
	}
	/* 주문 종합정보란 최신화 */
	setTotalInfo();
});
  
  /* 포인트 모두 사용 & 사용 취소 버튼 
  Y: 모두사용 상태, N: 모두 취소 상태*/
  $(".order_point_input_btn").on("click",function(){
     let maxPoint = parseInt('${member.point}');
     let state = $(this).data("state");
     
     if(state == 'N'){
        console.log("n동작");
        /*모두 사용*/
        //값 변경
        $(".order_point_input").val(maxPoint);
     } else if (state == 'Y') {
        console.log("y동작");
        /*모두 사용 취소*/
        //값 변경
        $(".order_point_input").val(0);
     }
     /* 주문 종합정보란 최신화 */
        setTotalInfo();
  });
  
  /* 총 주문 정보 세팅(배송비, 총 가격, 마일리지, 물품 수, 종류)*/
  function setTotalInfo(){
     let totalBookPrice = 0; //도서 총 가격
     let totalAlbumPrice = 0 ; //앨범 총 가격
     let totalAllPrice = 0; //도서 + 앨범 총 가격
     let totalAmount = 0; //총 갯수
     
     let delivery = 0; //배송비
     let finalPrice = 0; // totalAllPrice(도서 + 앨범 총 가격) + delivery 가격 
     let usePoint = 0; //사용 포인트(할인 가격)
     let finalTotalPrice = 0; //최종 가격(totalAllPrice + 배송비)
   
     $(".goods_table_price_td").each(function(index,element){
      //총 가격
      totalBookPrice += parseInt($(element).find(".totalPriceInput").val());
      
      totalAlbumPrice += parseInt($(element).find(".totalAlbumPriceInput").val());
      
      totalAllPrice = totalBookPrice + totalAlbumPrice;
      //총 갯수
      totalAmount += parseInt($(element).find(".amountInput").val());
      
      console.log("책 가격: " +totalBookPrice);
      console.log("앨범 가격: " +totalAlbumPrice);
      console.log("총 가격: " +totalAllPrice);
      
     });
     
     /* 배송비 결정 */
     if(totalAllPrice >= 20000){
        delivery = 0;
     }else if(totalAllPrice == 0){
        delivery = 0;
     }else{
        delivery = 3000;
     }
     finalPrice = totalAllPrice + delivery;
     console.log("finalPrice: "+ finalPrice);
     
     /* 사용 포인트 */
     usePoint = $(".order_point_input").val();
     
     console.log("usePoint: " + usePoint);
     
     if(usePoint > finalPrice){
         usePoint = finalPrice;
         $(".order_point_input").val(usePoint);
         
     }else{
          finalTotalPrice = totalAllPrice + delivery - usePoint;  
     }
     
     /* 값 삽입 */
      // 총 가격
      $(".totalAllPrice_span").text(totalAllPrice.toLocaleString());
      // 총 갯수
      $(".goodKind_div_count").text(totalAmount);
      
      // 배송비
      $(".delivery_span").text(delivery.toLocaleString());   
      // 최종 가격(총 가격 + 배송비)
      $(".finalTotalPrice_span").text(finalTotalPrice.toLocaleString());      
      // 할인가(사용 포인트)
      $(".usePoint_span").text(usePoint.toLocaleString());
  }
/* 주문 요청 */
  $(".orderBtn").on("click", function(){
     /* 주소 정보 & 받는 이 */
     $(".adressInfo_div").each(function(i,obj){
       if($(obj).find(".selectAddress").val() === 'T'){
          $("input[name='id']").val($(obj).find(".idInput").val());
          $("input[name='name']").val($(obj).find(".nameInput").val());
          $("input[name='zipCode']").val($(obj).find(".zipCodeInput").val());
          $("input[name='addressRoad']").val($(obj).find(".addressRoadInput").val());
          $("input[name='addressDetail']").val($(obj).find(".addressDetailInput").val());
          $("input[name='phone']").val($(obj).find(".phoneInput").val());
       } else if ($(obj).find(".selectAddress").val() === 'F') {
    	   $("input[name='id']").val($(obj).find(".id_input").val());
           $("input[name='name']").val($(obj).find(".address_input").val());
           $("input[name='zipCode']").val($(obj).find(".address1_input").val());
           $("input[name='addressRoad']").val($(obj).find(".address2_input").val());
           $("input[name='addressDetail']").val($(obj).find(".address3_input").val());
           $("input[name='phone']").val($(obj).find(".phone_input").val());
       }
     });
     
     /* 사용 포인트 */
     $("input[name='usePoint']").val($(".order_point_input").val());
     
     /* 상품 정보 */
     let form_contents = '';
        $(".goods_table_price_td").each(function(index,element){
        
          let isbn = $(element).find(".isbnInput").val();
          let productNum = $(element).find(".productNumInput").val();
          let amount = $(element).find(".amountInput").val();
          
          if(productNum == null){
             
             let isbn_input = "<input name='orders["+ index +"].isbn' type='hidden' value='" + isbn + "'>";
             form_contents += isbn_input;
             let amount_input = "<input name='orders["+ index +"].amount' type='hidden' value='" + amount + "'>";
             form_contents += amount_input;
             
          }else if(isbn == null){
             
             let productNum_input = "<input name='orders["+ index +"].productNum' type='hidden' value='" + productNum + "'>";
             form_contents += productNum_input;
             let amount_input = "<input name='orders["+ index +"].amount' type='hidden' value='" + amount + "'>";
             form_contents += amount_input;
             
          }else{
             
             let isbn_input = "<input name='orders["+ index +"].isbn' type='hidden' value='" + isbn + "'>";
             form_contents += isbn_input;
             let productNum_input = "<input name='orders["+ index +"].productNum' type='hidden' value='" + productNum + "'>";
             form_contents += productNum_input;
             let amount_input = "<input name='orders["+ index +"].amount' type='hidden' value='" + amount + "'>";
             form_contents += amount_input;
          }
       
      }); 
        let totalBookPrice = 0; //도서 총 가격
        let totalAlbumPrice = 0 ; //앨범 총 가격
        let totalAllPrice = 0; //도서 + 앨범 총 가격
        let totalAmount = 0; //총 갯수
        
        let delivery = 0; //배송비
        let finalPrice = 0; // totalAllPrice(도서 + 앨범 총 가격) + delivery 가격 
        let usePoint = 0; //사용 포인트(할인 가격)
        let finalTotalPrice = 0; //최종 가격(totalAllPrice + 배송비)
      
        $(".goods_table_price_td").each(function(index,element){
         //총 가격
         totalBookPrice += parseInt($(element).find(".totalPriceInput").val());
         
         totalAlbumPrice += parseInt($(element).find(".totalAlbumPriceInput").val());
         
         totalAllPrice = totalBookPrice + totalAlbumPrice;
         //총 갯수
         totalAmount += parseInt($(element).find(".amountInput").val());
         
         console.log("책 가격: " +totalBookPrice);
         console.log("앨범 가격: " +totalAlbumPrice);
         console.log("총 가격: " +totalAllPrice);
         
        });
        
        /* 배송비 결정 */
        if(totalAllPrice >= 20000){
           delivery = 0;
        }else if(totalAllPrice == 0){
           delivery = 0;
        }else{
           delivery = 3000;
        }
        finalPrice = totalAllPrice + delivery;
        console.log("finalPrice: "+ finalPrice);
        
        /* 사용 포인트 */
        usePoint = $(".order_point_input").val();
        
        console.log("usePoint: " + usePoint);
        
        if(usePoint > finalPrice){
            usePoint = finalPrice;
            $(".order_point_input").val(usePoint);
            
        }else{
             finalTotalPrice = totalAllPrice + delivery - usePoint;  
        }
        
        if (finalTotalPrice > usePoint) {
      	  alert("결제할 포인트를 적용해 주세요.");
      	  return false;
        }
     
     $(".order_form").append(form_contents);
	 alert("주문이 완료되었습니다.");
     /* 서버 전송 */
     $(".order_form").submit();
});
 
let totalPrice = $(".finalTotalPrice_span").val();
</script>
<%@ include file="../includes/footer.jsp" %>