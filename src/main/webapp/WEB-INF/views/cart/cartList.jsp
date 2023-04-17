<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ include file="../includes/header.jsp" %>
<%
   String id = (String)session.getAttribute("id");   
%>

<title>BOOK45 장바구니</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" />
<link rel="stylesheet" type="text/css" href="/resources/css/cart/cartList.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

   <div id="down">
   <div id="wrap" align="center">
      <h2 align="center"> ${member.name}님의 장바구니 리스트 </h2>
      <c:if test="${listCheck != 'empty'}">
      <table class="list" align="center">
          <tr>
         <td colspan="7" style="border: white; text-align: right">
         	<input type="submit" value="선택 삭제" class="selectDeleteBtn" id="deleteBtn">
            <input type="button" value="전체 삭제" class="deleteAllBtn" id="deleteAllBtn" onclick="location.href='/cart/deleteAll'">
         </td>
      	 </tr>
         <tr>
            <th><input type="checkbox" class="allCheck" checked="checked"></th> <th>이미지</th> <th>제목</th> <th>수량</th> <th>개당 가격</th> <th>총 가격</th> <th>삭제</th><!-- <th>이메일</th> <th>등급</th> <th>수정</th> <th>삭제</th> -->
         </tr>
         <c:forEach var="cart" items="${cartList}">
            <tr class="record">
            	<td class="cartInfoId">
            		<input type="checkbox" class="checkBox" checked="checked" data-oper="${cart.cartNum}">
            		<input type="hidden" class="bookPriceInput" value="${cart.bookPrice}">
            		<input type="hidden" class="bookTotalPrice" value="${cart.bookPrice * cart.amount}">
            		<input type="hidden" class="albumPriceInput" value="${cart.albumPrice}">
            		<input type="hidden" class="albumTotalPrice" value="${cart.albumPrice * cart.amount}">
            		<input type="hidden" class="amountInput" value="${cart.amount}">
            		<input type="hidden" class="totalPriceInput" value="${cart.bookPrice * cart.amount + cart.albumPrice * cart.amount}">
            		<input type="hidden" name="isbn" class="isbnInput" value="${cart.isbn}">
            		<input type="hidden" name="productNum" class="productNumInput" value="${cart.productNum}">
            		<input type="hidden" name="id" class="id" value="${member.id}">
				    <input type="hidden" name="stock" id="stock" class="bookStock" value="${bookStock}">
				    <input type="hidden" name="albumStock" id="stock" class="albumStock" value="${albumStock}">
            	</td>
            <c:choose>
               <c:when test="${cart.productNum == null}">
                  <td><a href="/book/bookDetail"><img alt="" src="${cart.bookPictureUrl}" id="cover"></a></td>
                  <td> ${cart.bookTitle}</td>
                  <td>
	                  <div class="amountModifyBox">
	                  <button type="button" class="minusBtn">-</button>
	                  <input type="text" value="${cart.amount}" name="amount" id="amountBox">
	                  <button type="button" class="plusBtn">+</button>
	                  <br>
	                  <button type="button" class="amountModifyBtn" name="cartNum" data-oper="${cart.cartNum}">변경</button>
	                  </div>
                  </td>
                  <td><fmt:formatNumber value="${cart.bookPrice}" pattern="#,### 원"></fmt:formatNumber></td>
                  <td><fmt:formatNumber value="${cart.bookPrice * cart.amount}" pattern="#,### 원"></fmt:formatNumber></td>
                  <td><a class="deleteBtn" data-oper="${cart.cartNum}"><i class="fa-regular fa-trash-can"></i></a></td>
               </c:when>
               <c:when test="${cart.isbn == null}">
                     <td><a href="/album/albumDetail"><img alt="" src="${cart.albumPictureUrl}" id="cover2"></a></td>
                  <td> ${cart.albumTitle} </td>
                  <td>
	                  <div class="amountModifyBox">
	                  <button type="button" class="minusBtn">-</button>
	                  <input type="text" value="${cart.amount}" name="amount" id="amountBox">
	                  <button type="button" class="plusBtn">+</button>
	                  <br>
	                  <button type="button" class="amountModifyBtn" name="cartNum" data-oper="${cart.cartNum}">변경</button>
	                  </div>
                  </td>
                  <td><fmt:formatNumber value="${cart.albumPrice}" pattern="#,### 원"></fmt:formatNumber></td>
                  <td><fmt:formatNumber value="${cart.albumPrice * cart.amount}" pattern="#,### 원"></fmt:formatNumber></td>
                  <td><a class="deleteBtn" data-oper="${cart.cartNum}"><i class="fa-regular fa-trash-can"></i></a></td>
               </c:when>
               <c:otherwise>
                     <td><a href="/book/bookDetail"><img alt="" src="${cart.bookPictureUrl}" id="cover"></a></td>
                  <td> ${cart.bookTitle} </td>
                  <td>
	                  <div class="amountModifyBox">
	                  <button type="button" class="minusBtn">-</button>
	                  <input type="text" value="${cart.amount}" name="amount" id="amountBox">
	                  <button type="button" class="plusBtn">+</button>
	                  <br>
	                  <button type="button" class="amountModifyBtn" name="cartNum" data-oper="${cart.cartNum}">변경</button>
	                  </div>
                  </td>
                  <td><fmt:formatNumber value="${cart.bookPrice}" pattern="#,### 원"></fmt:formatNumber></td>
                  <td><fmt:formatNumber value="${cart.bookPrice * cart.amount}" pattern="#,### 원"></fmt:formatNumber></td>
                  <td><a class="deleteBtn" data-oper="${cart.cartNum}"><i class="fa-regular fa-trash-can"></i></a></td>
                  <td><input type="checkbox"></td>
                  <td><a href="/album/albumDetail"><img alt="" src="${cart.albumPictureUrl}" id="cover2"></a></td>
                  <td> ${cart.albumTitle} </td>
                  <td>
	                  <div class="amountModifyBox">
	                  <button type="button" class="minusBtn">-</button>
	                  <input type="text" value="${cart.amount}" name="amount" id="amountBox">
	                  <button type="button" class="plusBtn">+</button>
	                  <br>
	                  <button type="button" class="amountModifyBtn" name="cartNum" data-oper="${cart.cartNum}">변경</button>
	                  </div>
                  </td>
                  <td><fmt:formatNumber value="${cart.albumPrice}" pattern="#,### 원"></fmt:formatNumber></td>
                  <td><fmt:formatNumber value="${cart.albumPrice * cart.amount}" pattern="#,### 원"></fmt:formatNumber></td>
				  <td><a class="deleteBtn" data-oper="${cart.cartNum}"><i class="fa-regular fa-trash-can"></i></a></td>
               </c:otherwise>
           </c:choose>
            </tr>
         </c:forEach>
      </table>
      </c:if>
      <c:if test="${listCheck == 'empty'}">
       	<table class="list">
       	<tr>
       		<th><input type="checkbox" class="allCheck" checked="checked"></th> <th>이미지</th> <th>제목</th> <th>수량</th> <th>개당 가격</th> <th>총 가격</th> <th>삭제</th>
       	</tr>
       	<tr>
       	<td id="line" colspan="7">장바구니가 비어 있습니다.</td>
       	</tr>
       	</table>
     </c:if> 	
      <div class="priceInfoBox">
      <table class="priceBox">
      	<tbody>
	      	<tr>
	      		<td>합계</td>
	      		<td><span class="totalPriceSpan"></span>원</td>
	      	</tr>
	      	<tr>
	      		<td>배송비</td>
	      		<td><span class="deliverySpan"></span>원</td>
	      	</tr>
	      	<tr>
	      		<td>총 주문 상품 수</td>
	      		<td><span class="totalCountSpan"></span>건</td>
	      	</tr>
	      </table>
	      <table class="finalPriceBox">
	      	<tr>
	      		<td><strong>결제 예상 금액</strong></td>
	      		<td><span class="finalTotalPriceSpan"></span>원</td>
	      	</tr>
      	</tbody>
      </table>
      <button type="button" class="buyBtn">주문하기</button>
      </div>
      
   </div>
			<!-- 수량 조정 form -->
			<form action="/cart/modify" method="post" class="amount_update_form">
				<input type="hidden" name="cartNum" class="update_cartNum">
				<input type="hidden" name="amount" class="update_amount">
				<input type="hidden" name="id" value="${member.id}">
				<input type="hidden" name="stock" class="stock" value="${book.stock}">
   				<input type="hidden" name="stock" class="stock" value="${album.stock}">
			</form>
			<!-- 삭제 form -->
			<form action="/cart/delete" method="post" class="amount_delete_form">
				<input type="hidden" name="cartNum" class="delete_cartNum">
				<input type="hidden" name="id" value="${member.id}">
			</form>
			<!-- 주문 form -->
			<form action="/order/orderPage/${member.id}" method="get" class="orderForm">
				<input type="hidden" name="isbn" value="${cart.isbn}">
				<input type="hidden" name="productNum" value="${cart.productNum}">
			</form>
    </div>
<script type="text/javascript">
let stock = $(".bookStock").val();
console.log("재고: " + stock);

$(".plusBtn").on("click", function() {
	let amount = $(this).parent("div").find("input").val();
  	$(this).parent("div").find("input").val(++amount); 
});
   
$(".minusBtn").click(function() {
 	let amount = $(this).parent("div").find("input").val();
 	if(amount > 1) {
 		$(this).parent("div").find("input").val(--amount);		
 	}
}); 
   
 /* 수량 수정 버튼 */
  $(".amountModifyBtn").click(function() {
  	let cartNum = $(this).data("oper");
  	let amount = $(this).parent("div").find("input").val();
  	
  	$(".update_cartNum").val(cartNum);
  	$(".update_amount").val(amount);
  	$(".amount_update_form").submit();
  	alert("수량이 변경되었습니다.");
 }); 
 
  /* 장바구니 삭제 버튼 */
$(".deleteBtn").click(function(e) {
  	e.preventDefault();
  	const cartNum = $(this).data("oper");
  	$(".delete_cartNum").val(cartNum);
  	$(".amount_delete_form").submit();
  	alert("해당 상품이 삭제되었습니다.");
  });
    
/* 장바구니 모두 선택 */
$(".allCheck").click(function() {
   let check = $(".allCheck").prop("checked");
   if(check) {
      $(".checkBox").prop("checked", true);
   } else {
      $(".checkBox").prop("checked", false);
   }
});

$(".checkBox").click(function() {
   $(".allCheck").prop("checked", false);
});
    
/* 장바구니 전체 삭제 버튼 클릭 시 알림창 */
$(".deleteAllBtn").click(function() {
	alert("전체 상품이 삭제되었습니다.");
});

/* 장바구니 선택 삭제 */
$(".selectDeleteBtn").click(function() {
	let confirmMsg = confirm("정말 삭제하시겠습니까?");
	let id = $(".id").val();
	if (confirmMsg) {
		let checkBoxArr = new Array();
		
		$("input[class='checkBox']:checked").each(function() {
			checkBoxArr.push($(this).attr("data-oper"));
		});
		
		$.ajax({
			url: "/cart/selectDelete",
			type: "post",
			data: {checkBox : checkBoxArr},
			success: function() {
				location.href = "/cart/cartList/" + id;
				alert("선택한 상품이 삭제되었습니다.");
			}
		});
	}
});
    
$(document).ready(function() {
	let totalPrice = 0; // 총 가격
	let totalCount = 0; // 총 개수
	let delivery = 0; // 배송비
	let finalTotalPrice = 0; // 총 가격 + (배송비 - 20,000원 이상 구매 시)
	
	$(".cartInfoId").each(function(index, element) {
		if ($(element).find(".checkBox").is(":checked") === true) {
			totalPrice += parseInt($(element).find(".bookTotalPrice").val());
			totalPrice += parseInt($(element).find(".albumTotalPrice").val());
			totalCount += parseInt($(element).find(".amountInput").val());
		} else if ($(element).find(".checkBox").is(":checked") === false) {
			totalPrice -= parseInt($(element).find(".bookTotalPrice").val());
			totalPrice -= parseInt($(element).find(".albumTotalPrice").val());
			totalCount -= parseInt($(element).find(".amountInput").val());
		}
	});
	
	if (totalPrice >= 20000) {
		delivery = 0;
	} else if (totalPrice == 0) {
		delivery = 0;
	} else if (totalPrice < 20000) {
		delivery = 3000;
	}
	
	finalTotalPrice = totalPrice + delivery;
	
	$(".totalPriceSpan").text(totalPrice.toLocaleString());
	$(".totalCountSpan").text(totalCount);
	$(".deliverySpan").text(delivery.toLocaleString());
	$(".finalTotalPriceSpan").text(finalTotalPrice.toLocaleString());
});

$(".buyBtn").click(function() {
	let formContents = '';
	let orderNum = 0;
	$(".cartInfoId").each(function(index, element) {
		if ($(element).find(".checkBox").is(":checked") === true) {
			let isbn = $(element).find(".isbnInput").val();
			let productNum = $(element).find(".productNumInput").val();
			let amount = $(element).find(".amountInput").val();
			
			let isbnInput = "<input type='hidden' name='orders[" + orderNum + "].isbn' value='" + isbn + "'>";
			formContents += isbnInput;
			let productNumInput = "<input type='hidden' name='orders[" + orderNum + "].productNum' value='" + productNum + "'>";
			formContents += productNumInput;
			let amountInput = "<input type='hidden' name='orders[" + orderNum + "].amount' value='" + amount + "'>";
			formContents += amountInput;
			let isbnInput2 = "<input type='hidden' name='isbn' value='" + isbn + "'>";
			formContents += isbnInput2;
			let productNumInput2 = "<input type='hidden' name='productNum' value='" + productNum + "'>";
			formContents += productNumInput2;
			
			orderNum += 1;
		}
	});
	$(".orderForm").html(formContents);
	$(".orderForm").submit();
});
</script>
<%@ include file="../includes/footer.jsp" %>