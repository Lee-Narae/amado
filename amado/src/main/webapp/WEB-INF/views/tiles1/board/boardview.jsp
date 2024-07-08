<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%
	String ctxPath = request.getContextPath();
%>

<style type="text/css">
span.move {
	cursor: pointer;
	color: navy;
}

.moveColor {
	color: #660029;
	font-weight: bold;
	background-color: #ffffe6;
}

td.comment {text-align: center;}

a {
	text-decoration: none !important;
}
</style>



<div style="display: flex;">
	<div style="margin: auto; padding-left: 3%;">
		<h2 style="margin-bottom: 30px;">글내용보기</h2>

		<c:if test="${not empty requestScope.boardvo}">

			<table class="table table-bordered table-dark" style="width: 1024px; word-wrap: break-word; table-layout: fixed;">
				<tr>
					<th style="width: 15%">글번호</th>
					<td>${requestScope.boardvo.boardseq}</td>
				</tr>

				<tr>
					<th>성명</th>
					<td>${requestScope.boardvo.fk_userid}</td>
				</tr>

				<tr>
					<th>제목</th>
					<td>
						<p style="word-break: break-all;">${requestScope.boardvo.title}</p>
				<%-- 
	                style="word-break: break-all; 은 공백없는 긴영문일 경우 width 크기를 뚫고 나오는 것을 막는 것임. 
			                    그런데 style="word-break: break-all; 나 style="word-wrap: break-word; 은
			                    테이블태그의 <td>태그에는 안되고 <p> 나 <div> 태그안에서 적용되어지므로 <td>태그에서 적용하려면
	                <table>태그속에 style="word-wrap: break-word; table-layout: fixed;" 을 주면 된다.
	            --%>
					</td>
				</tr>

				<tr>
					<th>글내용</th>
					<td>${requestScope.boardvo.content}</td>
				</tr>

				<tr>
					<th>조회수</th>
					<td>${requestScope.boardvo.viewcount}</td>
				</tr>

				<tr>
					<th>작성일자</th>
					<td>${requestScope.boardvo.registerdate}</td>
				</tr>
			</table>

		</c:if>

		<c:if test="${empty requestScope.boardvo}">
			<div style="padding: 20px 0; font-size: 16pt; color: red;">존재하지 않습니다</div>
		</c:if>

		<div class="mt-5">
			<%-- 글조회수 1 증가를 위해서  view.do 대신에 view_2.do 으로 바꾼다. --%>
			<div style="margin-bottom: 1%;">이전글제목&nbsp;&nbsp;<span class="move" onclick="javascript:location.href='view_2.do?seq=${requestScope.boardvo.previousseq}'">${requestScope.boardvo.previoussubject}</span>
			</div>
			<div style="margin-bottom: 1%;"> 다음글제목&nbsp;&nbsp;<span class="move" onclick="javascript:location.href='view_2.do?seq=${requestScope.boardvo.nextseq}'">${requestScope.boardvo.nextsubject}</span>
			</div>
			<br>

			<button type="button" class="btn btn-secondary btn-sm mr-3" onclick="javascript:location.href='<%=ctxPath%>/community/list.do'">전체목록보기</button>

			<c:if test="${not empty sessionScope.loginuser && sessionScope.loginuser.userid == requestScope.boardvo.fk_userid}">
				<button type="button" class="btn btn-secondary btn-sm mr-3" onclick="javascript:location.href='<%= ctxPath%>/edit.do?seq=${requestScope.boardvo.boardseq}'">글수정하기</button>
				<button type="button" class="btn btn-secondary btn-sm mr-3" onclick="javascript:location.href='<%= ctxPath%>/del.do?seq=${requestScope.boardvo.boardseq}'">글삭제하기</button>
			</c:if>

			<%-- === #83. 댓글쓰기 폼 추가 --%>
			<c:if test="${not empty sessionScope.loginuser}">
				<h3 style="margin-top: 50px;">댓글쓰기</h3>

				<form name="addWriteFrm" id="addWriteFrm" style="margin-top: 20px;">
					<table class="table" style="width: 1024px">
						<tr style="height: 30px;">
							<th width="10%">성명</th>
							<td>
								<input type="hidden" name="fk_userid" value="${sessionScope.loginuser.userid}" readonly /> 
								<input type="text" name="name" value="${sessionScope.loginuser.userid}" readonly />
							</td>
						<tr>
						<tr style="height: 30px;">
							<th>댓글내용</th>
							<td>
								<input type="text" name="content" size="100" maxlength="1000" /> <%-- 댓글에 달리는 원게시물 글번호(즉, 댓글의 부모글 글번호) --%>
	  							<input type="hidden" name="parentSeq" value="${requestScope.boardvo.boardseq}" />  
							</td>
						</tr>

						<tr>
							<th colspan="2">
								<button type="button" class="btn btn-success btn-sm mr-3" onclick="goAddWrite()">댓글쓰기 확인</button>
								<button type="reset" class="btn btn-success btn-sm">댓글쓰기 취소</button>
							</th>
						</tr>
					</table>
				</form>
			</c:if>
			
			
			<%-- === #94. 댓글 내용 보여주기 === --%>
	       <h3 style="margin-top: 50px;">댓글내용</h3>
	       <table class="table" style="width: 1024px; margin-top: 2%; margin-bottom: 3%;">
	          <thead>
		          <tr>
		              <th style="text-align: center;">내용</th>
		              <th style="width: 8%; text-align: center;">작성자</th>
		              <th style="width: 12%; text-align: center;">작성일자</th>
		              <th style="width: 12%; text-align: center;">수정/삭제</th>
		          </tr>
	          </thead>
	          <tbody id="commentDisplay"></tbody>
	        </table>
			
			
		</div>
	</div>
</div>





<%-- === #138. 이전글제목, 다음글제목 보기 === --%>
<form name="goViewFrm">
	<input type="hidden" name="boardseq" /> 
	<input type="hidden" name="goBackURL" /> 
	<input type="hidden" name="searchType" /> 
	<input type="hidden" name="searchWord" /> 
</form>