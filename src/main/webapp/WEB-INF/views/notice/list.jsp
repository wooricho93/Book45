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

<title>BOOK45 공지사항</title>

<link rel="stylesheet" href="/resources/css/notice/noticeList.css">    
<div id="container" align="center">
	<h2>공지사항</h2>
	<div id="wrap" align="center">
	   <c:if test="${member.lev == 'A'}">
	      <button id="regBtn" onclick="location.href='/notice/register'">공지글 등록</button>
	    </c:if>
	    <c:choose>
	       <c:when test="${empty list}">
	          <table>
	            <tr>
	               <th width="10%">NO</th> <th width="40%">제목</th> <th width="15%">작성자</th> <th width="25%">작성일</th> <th width="10%">조회</th>
	            </tr>
	             <tr><td colspan="5">등록된 게시글이 존재하지 않습니다.</td></tr>
	          </table>
	       </c:when>
	       <c:otherwise>
	          <table>
	            <thead>
	               <tr>
	                  <th width="10%">NO</th> <th width="40%">제목</th> <th width="15%">아이디</th> <th width="25%">작성일</th> <th width="10%">조회</th>
	               </tr>
	               </thead>
	               <tbody>
	               <c:forEach var="notice" items="${list}">
	                  <tr>
	                     <td width="10%">
	                        <a class="move" href='<c:out value="${notice.num}"/>'><c:out value ="${notice.num}"/></a>
	                     </td>
	                     <td width="40%">
	                        <a class="move" href='<c:out value="${notice.num}"/>'><c:out value= "${notice.title}"/></a>
	                     </td>
	                     <td width="15%"><c:out value ="${notice.id}"/></td>
	                     <td width="25%"><fmt:formatDate pattern="yyyy/MM/dd" value="${notice.updateDate}"/></td>
	                     <td width="10%"><c:out value ="${notice.readCount}"/></td>
	                  </tr>
	               </c:forEach>
	            </tbody>
	         </table>
	       </c:otherwise>
	    </c:choose>
	   <form id="actionForm" action="/notice/list" method="get">
	      <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
	      <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
	      <input type="hidden" name="type" value="${pageMaker.cri.type}">
	      <input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
	   </form>
   </div> 
</div>  
   <!-- 페이징 처리 시작 -->
<div id="listFooter">
<div class="pull-right" id="pageNumber">
   <ul class="pagination">
      <c:if test="${pageMaker.prev}">
         <li class="paginate_button previous" ><a href="${pageMaker.startPage-1 }">이전</a></li>
      </c:if>
        <c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
           <li id="pageNum2" class="paginate_button ${pageMaker.cri.pageNum == num? "active":"" }" ><a href="${num}">${num}</a></li>
      </c:forEach>
      <c:if test="${pageMaker.next}">
         <li class="paginate_button next" ><a href="${pageMaker.endPage+1 }">다음</a></li>
      </c:if>
   </ul>
</div>  
<!-- 페이징 처리 끝 -->  
   <!-- 검색 시작 -->     
<div class='row'>
   <div class="col-lg-12">
      <form id="searchForm" action="/notice/list" method="get">
         <select name="type" id="hoption">
         <option value="" <c:out value="${pageMaker.cri.type==null? 'selected': ''}"/>>--</option>
            <option value="T" <c:out value="${pageMaker.cri.type eq 'T'? 'selected': ''}"/>>제목</option>
            <option value="C" <c:out value="${pageMaker.cri.type eq 'C'? 'selected': ''}"/>>내용</option>
            <option value="W" <c:out value="${pageMaker.cri.type eq 'W'? 'selected': ''}"/>>작성자</option>
            <option value="TC" <c:out value="${pageMaker.cri.type eq 'TC'? 'selected': ''}"/>>제목/내용</option>
            <option value="TW" <c:out value="${pageMaker.cri.type eq 'TW'? 'selected': ''}"/>>제목/작성자</option>
            <option value="TCW" <c:out value="${pageMaker.cri.type eq 'TWC'? 'selected': ''}"/>>제목/내용/작성자</option>
         </select>
         <input type="text" name="keyword" id="keyword" placeholder="검색어를 입력해 주세요" value="${pageMaker.cri.keyword}" />
         <input type="hidden" name="pageNum" value='${pageMaker.cri.pageNum }'/>
         <input type="hidden" name="amount" value='${pageMaker.cri.amount }'/>
         <button class="btn btn-default" id="searchBtn">검색</button>
      </form>   
   </div>
</div>  
</div>                      
<!-- 검색 끝 -->      
      
<script>
$(document).ready(function(){

	var actionForm = $("#actionForm");
     
   $(".paginate_button a").on("click", function(e){
      e.preventDefault();
        //추가
        actionForm.attr("action", "/notice/list"); // 수정삭제메뉴에서 뒤로가기 한다음 page번호 클릭하면 상세페이지 빠지는 것 방지
        actionForm.find("input[name='pageNum']").val($(this).attr("href"));
        actionForm.submit();
   });
   
   //공지상세페이지로 이동
   $(".move").on("click",function(e){
      e.preventDefault();
        actionForm.find("input[name='num']").remove(); 
        actionForm.append("<input type='hidden' name='num' value='" + $(this).attr("href") + "' >");
        actionForm.attr("action", "/notice/get");
        actionForm.submit();
   });
     
   var searchForm = $("#searchForm");
   $("#searchForm button").on("click", function(e){
      if (!searchForm.find("option:selected").val()) {
         alert("검색종류를 선택하세요");
         return false;
        }
        
      if (!searchForm.find("input[name='keyword']").val()) {
         alert("키워드를 입력하세요");
         return false;
        }
      
        searchForm.find("input[name='pageNum']").val("1");
        e.preventDefault();
        searchForm.submit();
   });
});
</script> 
<%@ include file="../includes/footer.jsp" %>