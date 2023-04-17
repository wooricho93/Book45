<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp"%>

	<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	session.setAttribute("id", id);
	%>
	
<link rel="stylesheet" href="/resources/css/qna/qnaList.css">

<title>BOOK45 Q&A</title>

<div id="container" align="center">
	<h2>Q&A</h2>
	<c:choose>
		<c:when test="${empty member}">
			<button style="float: right;" id="loginBtn">문의글 등록</button>
		</c:when>
		<c:otherwise>
			<button id="regBtn" type="button" style="float: right;" onclick="location.href='/qna/register'">문의글 등록</button>
		</c:otherwise>
	</c:choose>
	<table>
		<thead>
			<tr>
				<th width="10%">NO</th>
				<th width="40%">제목</th>
				<th width="15%">작성자</th>
				<th width="25%">작성일</th>
				<th width="10%">상태</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="qna" items="${list}">
				<c:if test="${qna.secret == 'Y'}">
					<c:if test="${member.id eq qna.id || member.lev == 'A'}">
						<tr>
							<td width="10%"><c:out value="${qna.qnum}"/></td>
							<td width="40%"><a class="move" href='<c:out value="${qna.qnum}"/>'><c:out value="${qna.title}"/></a></td>
							<td width="15%"><c:out value="${qna.id}" /></td>
							<td width="25%"><fmt:formatDate pattern="yyyy/MM/dd" value="${qna.writeDate}"/></td>
							<td width="10%">
								<c:choose>
									<c:when test="${qna.replyCnt == '0'}">
										처리중
									</c:when>
									<c:otherwise>
										답변완료
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</c:if>
					<c:if test="${member.id ne qna.id && member.lev == 'B'}">
						<tr>
							<td><c:out value="${qna.qnum}"/></td>
							<td colspan="4">비밀글은 작성자와 관리자만 볼 수 있습니다.</td>
						</tr>
					</c:if>
				</c:if>
				<c:if test="${not empty member && qna.secret == 'N'}">
					<tr>
						<td width="10%"><c:out value="${qna.qnum}"/></td>
						<td width="40%"><a class="move" href='<c:out value="${qna.qnum}"/>'><c:out value="${qna.title}"/></a></td>
						<td width="15%"><c:out value="${qna.id}" /></td>
						<td width="25%"><fmt:formatDate pattern="yyyy/MM/dd" value="${qna.writeDate}"/></td>
						<td width="10%">
							<c:choose>
								<c:when test="${qna.replyCnt == '0'}">
									처리중
								</c:when>
								<c:otherwise>
									답변완료
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</c:if>
			</c:forEach>
			<c:if test="${empty member}">
				<td colspan="5">Q&A 게시판은 회원만 이용할 수 있습니다.</td>
			</c:if>
		</tbody>
	</table>
</div>
	
	<form id="actionForm" action="/qna/list" method="get">
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
		<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
		<input type="hidden" name="type" value="${pageMaker.cri.type}">
		<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
	</form>
		
	<div id="listFooter">
		<!-- 페이징 처리 시작 -->
		<div class='pull-right' id="pageNumber">
			<ul class="pagination">
				<c:if test="${pageMaker.prev}">
					<li class="paginate_button previous">
					<a href="${pageMaker.startPage -1}">이전</a></li>
				</c:if>
				<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
					<li id="pageNum2" class="paginate_button ${pageMaker.cri.pageNum == num ? "active":""} ">
						<a href="${num}">${num}</a>
					</li>
				</c:forEach>
				<c:if test="${pageMaker.next}">
					<li class="paginate_button next"><a href="${pageMaker.endPage +1}">다음</a></li>
				</c:if>
			</ul>
		</div>	
		<!-- 페이징 처리 끝 -->
		<!-- 검색 시작 -->
		<div class='row'>
  			 <div class="col-lg-12">
				<form id="searchForm" action="/qna/list" method="get">
					<select name="type" id="hoption">
		     			<option value="" <c:out value="${pageMaker.cri.type==null? 'selected': ''}"/>>--</option>
		     			<option value="T" <c:out value="${pageMaker.cri.type eq 'T'? 'selected': ''}"/>>제목</option>
		     			<option value="I" <c:out value="${pageMaker.cri.type eq 'I'? 'selected': ''}"/>>작성자</option>
		     			<option value="TI" <c:out value="${pageMaker.cri.type eq 'TI'? 'selected': ''}"/>>제목 or 작성자</option>	
		     		</select> 
			     		
						<input type='text' name='keyword' id="keyword" placeholder="검색어를 입력해 주세요" value='<c:out value="${pageMaker.cri.keyword}"/>' /> 
						<input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>' /> 
						<input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}"/>' />
						<button class='btn btn-default' id="searchBtn">검색</button>
				</form>
				</div>
		</div> 
		<!-- 검색 끝 -->
	</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script>
	$(document).ready(function() {
		
		// 문의글 작성
		$("#regBtn").on("click", function(){
            self.location = "/qna/register";
        });
		
		//상세페이지로 이동
		$(".move").on("click",function(e) {
			e.preventDefault();
			
			actionForm.append("<input type='hidden' name='qnum' value='"+$(this).attr("href")+"'>");
			actionForm.attr("action", "/qna/get");
			actionForm.submit();
		});
		
		
		//페이징
		var actionForm = $("#actionForm");
		
		$(".paginate_button a").on("click", function(e) {
            e.preventDefault();
            
            actionForm.find("input[name='pageNum']").val($(this).attr("href"));
            actionForm.submit();
        });
		
		//검색
		var searchForm = $("#searchForm");
		
		$("#searchForm button").on("click",function(e) {
			if (!searchForm.find("option:selected").val()) {
					alert("검색종류를 선택해 주세요.");
					return false;
			}
			if (!searchForm.find("input[name='keyword']").val()) {
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