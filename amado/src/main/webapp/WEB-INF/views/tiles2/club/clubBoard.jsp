<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
   String ctxPath = request.getContextPath();
%>


<style type="text/css">


	span.subject {
	    display: inline-block;
	    max-width: 450px; /* 최대 너비를 적절히 설정 */
	    overflow: hidden;
	    text-overflow: ellipsis;
	    white-space: nowrap;
	}	


/* 	.subject:hover {
		background: red;
	} */
    
    th {
    	background-color: none;
    	
    }
    
    .subjectStyle {font-weight: bold;
                   color: navy;
                   cursor: pointer; }
                   
    a {text-decoration: none !important;} /* 페이지바의 a 태그에 밑줄 없애기 */
    
</style>

<script type="text/javascript">

$(document).ready(function() {
	
});

</script>

<div id="wrap" style="width: 100%; padding: 5% 0;" align="center">
	<div id="top" class="mb-5" style="font-size: 35pt; font-weight: bolder; text-align: center;">공지사항</div>

	<div id="bottom" style="width: 80%;">
		<table class="mb-5" style="width: 100%;">
			<thead>
				<tr>
					<th width="10">순번</th>
					<th width="45">제목</th>
					<th width="10">작성자</th>
					<th width="15">작성일자</th>
					<th width="10">조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${not empty requestScope.noticeList}">
					<c:forEach var="notice" items="${requestScope.noticeList}" varStatus="status">
						<tr>
							<fmt:parseNumber var="currentShowPageNo" value="${requestScope.currentShowPageNo}" />
	          				<fmt:parseNumber var="sizePerPage" value="${requestScope.sizePerPage}" />
	          				<td align="center">${requestScope.totalMemberCount - (currentShowPageNo-1)*sizePerPage - status.index}</td>
							<td>${notice.title}&nbsp;<c:if test="${notice.commentcount != 0}"><span id="commentCount">[${notice.commentcount}]</span></c:if></td>
							<td align="center">${notice.registerdate}<input id="noticeseq" type="hidden" name="noticeseq" value="${notice.noticeseq}" /></td>
							<td align="center">${notice.viewcount}</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty requestScope.noticeList}">
					<td align="center" colspan="4">검색 결과가 없습니다.</td>
				</c:if>
			</tbody>
		
		</table>
		
		<form name="searchFrm" class="mb-5">
			<select name="searchType" >
				<option value="title">글제목</option>
				<option value="content">글내용</option>
			</select>
			<input type="text" name="searchWord"/>
			<input type="text" style="display: none;" />
			<button type="button" class="btn btn-light" style="font-size: 20pt; padding: 0;">🔎</button>
		</form>
		
		
		<div id="pageBar" style="margin-left: 36%;">
	       <nav>
	          <ul class="pagination">${requestScope.pageBar}</ul>
	       </nav>
	    </div>
		
	</div>
	
	<form name="goViewFrm">
		<input type="hidden" name="noticeseq" />
		<input type="hidden" name="goBackURL" />
		<input type="hidden" name="searchType" />
		<input type="hidden" name="searchWord" />
	</form>

</div>
                     