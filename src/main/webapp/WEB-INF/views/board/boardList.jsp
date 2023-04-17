<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../includes/header.jsp" %>
<title>BOOK45 자유게시판</title>
<link rel="stylesheet" href="/resources/css/board/boardList.css">
	
<div id="container">
	<h2 class="page-header">자유게시판</h2>
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">
					<c:choose>
						<c:when test="${empty member}">
							<button style="float: right;" id="loginBtn">게시글 등록</button>
						</c:when>
						<c:otherwise>
							<button id="regBtn" type="button" class="" style="float: right;" onclick="location.href='/board/boardRegister'">
								게시글 등록
							</button>
						</c:otherwise>
					</c:choose>
				</div>
				<!-- /.panel-heading -->
				<div class="panel-body">
					<table width="100%" class="table table-striped table-bordered table-hover">
						<thead>
							<tr>
								<th width="10%">NO</th> <th width="40%">제목</th> <th width="15%">작성자</th> <th width="25%">작성일</th> <th width="10%">조회</th>
							</tr>
						</thead>
						<c:forEach items="${list}" var="board">
							<tr class="odd gradeX">
								<c:choose>
									<c:when test="${board.blind eq false}">
										<td width="10%"><c:out value="${board.num}"/></td>
										<td width="40%">
											<a class='move' href='<c:out value="${board.num}"/>'>
											<c:out value="${board.title}"/> 
											<b id="replyCount"> [${board.replyCnt}]</b>
											</a>
										</td>
										<td width="15%"><c:out value="${board.memberId}"/></td>
										<td width="25%"><fmt:formatDate pattern="yyyy-MM-dd" value="${board.writeDate}"/></td>
										<td width="10%">${board.readCount}</td>
									</c:when>
									<c:otherwise>
										<td><c:out value="${board.num}"/></td>
										<td colspan="4">
											<c:choose>
												<c:when test="${member.lev eq 'A'}">
													<a class='move' href='<c:out value="${board.num}"/>'>
														이 게시글은 블라인드 처리되었습니다.
													</a>
												</c:when>
												<c:otherwise>
													이 게시글은 블라인드 처리되었습니다.
												</c:otherwise>
											</c:choose>
										</td>
										<td></td>
										<td></td>
										<td></td>
									</c:otherwise>
								</c:choose>
							</tr>
						</c:forEach>                
					</table>
                         
              <!-- /.panel-body -->
          </div>
          <!-- /.panel -->
      </div>
      <!-- /.col-lg-12 -->
  </div>
  <!-- /.row -->
   </div>
   </div>    
   <!-- /.table-responsive -->
        <div id="listFooter">
        	<div class='pull-right' id="pageNumber">
         	<ul class="pagination">
         		<c:if test="${pageMaker.prev}">
         			<li class="paginate_button previous"><a href="${pageMaker.startPage - 1}">이전</a></li>
         		</c:if>
         		<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
         			<li id="pageNum2" class="paginate_button ${pageMaker.cri.pageNum == num ? "active":""} ">
         				<a href="${num}">${num}</a>
         			</li>
         		</c:forEach>
         		<c:if test="${pageMaker.next}">
         			<li class="paginate_button next"><a href="${pageMaker.endPage + 1}">다음</a>
         			</li>
         		</c:if>
         	</ul>
         </div>
         <div class='row' align="center">
			<div class="col-lg-12">
         <form id="searchForm" action="/board/boardList" method="get">
         	<select name="type" id="hoption">
         		<option value="" <c:out value="${pageNum.cri.type == null?'selected':''}"/>>--</option>
         		<option value="T" <c:out value="${pageNum.cri.type eq 'T'?'selected':''}"/>>제목</option>
         		<option value="T" <c:out value="${pageNum.cri.type eq 'C'?'selected':''}"/>>내용</option>
         		<option value="T" <c:out value="${pageNum.cri.type eq 'W'?'selected':''}"/>>작성자</option>
         		<option value="T" <c:out value="${pageNum.cri.type eq 'TC'?'selected':''}"/>>제목/내용</option>
         		<option value="T" <c:out value="${pageNum.cri.type eq 'TW'?'selected':''}"/>>제목/작성자</option>
         		<option value="T" <c:out value="${pageNum.cri.type eq 'TWC'?'selected':''}"/>>제목/내용/작성자</option>
         	</select>
         	<input type='text' name='keyword' id="hsearch" placeholder="검색어를 입력해 주세요" value='<c:out value="${pageMaker.cri.keyword}"/>'/>
         	<input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>'/>
         	<input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}"/>'/>
         	<button class='btn btn-default' id="searchBtn">검색</button>
         </form>
        </div>
        
        <form id="actionForm" action="/board/boardList" method="get">
        	<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
        	<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
        	<input type='hidden' name='type' value='<c:out value="${pageMaker.cri.type}" />'>
        	<input type='hidden' name='keyword' value='<c:out value="${pageMaker.cri.keyword}" />'>
        </form>
                         
				</div>
              </div>     
<script>
$(document).ready(function(){
	
	$("#regBtn").on("click", function(){
		
		self.location = "/board/boardRegister";
	});
	
	var actionForm = $("#actionForm");
		
	$(".paginate_button a").on("click", function(e) {
		e.preventDefault();
		
		console.log('click');
		
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});
	
	$(".move").on("click", function(e){
		e.preventDefault();
		
		actionForm.append("<input type='hidden' name='num' value='"+
				$(this).attr("href")+"'>");
		actionForm.attr("action", "/board/boardGet");
		actionForm.submit();
	});
	
	var searchForm = $("#searchForm");
	
	$("#searchForm button").on("click", function(e){
		if (!searchForm.find("option:selected").val()){
			alert("검색종류를 선택해 주세요.");
			return false;
		}
		
		if (!searchForm.find("input[name='keyword']").val()){
			alert("키워드를 입력해 주세요.");
			return false;
		}
		
		searchForm.find("input[name='pageNum']").val("1");
		e.preventDefault();
		
		searchForm.submit();
	});
	
	$("#loginBtn").on("click", function(){
		
		alert("로그인 후 이용가능합니다.");
		self.location = "/member/login";
	});
});
</script>
            
<%@ include file="../includes/footer.jsp" %>