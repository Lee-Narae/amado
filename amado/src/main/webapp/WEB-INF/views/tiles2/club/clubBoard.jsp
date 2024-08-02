<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
   String ctxPath = request.getContextPath();
%>


<style type="text/css">


th {
height: 50px;
font-size: 15pt;
text-align: center;
align-content: center;
color: black;
border-bottom: solid 3px #1f7bb5;
}

th:nth-child(1) {
border-top-left-radius: 20px;
}

th:last-child {
border-top-right-radius: 20px;

}

td {
height: 55px;
align-content: center;
border-top: solid 1px #7dc1f3;
}

tbody > tr:hover {
background-color: #e4edfb;
opacity: 0.8;
cursor: pointer;
}

select {
width: 8%;
height: 40px;
text-align: center;
border-radius: 10px;
}

input[name='searchWord'] {
height: 40px;
padding-left: 1%;
border-radius: 10px;
align-content: center;
border: solid 1px gray;
}

</style>

<script type="text/javascript">

$(document).ready(function(){
	
	// 검색 버튼 눌렀을 때
	$("button.btn-light").click(function(){
		goSearch();
	});
	
	// 검색에서 엔터
	$("input:text[name='searchWord']").keyup(function(e){
		if(e.keyCode == 13){
			goSearch();
		}
	});
	
	// 글을 눌렀을 때
	$("tbody > tr *").click(function(e){

		let clubseq = '${requestScope.clubseq}';
		let clubboardseq = $(e.target).parent().find("input[name='clubboardseq']").val();
		
		const frm = document.goViewFrm;
		frm.clubboardseq.value = clubboardseq;
		frm.clubseq.value = clubseq;
		frm.goBackURL.value = "${requestScope.currentURL}";
		
		if(${not empty requestScope.paramap.searchType}){ // 검색을 했을 경우
			frm.searchType.value = '${requestScope.paramap.searchType}';
			frm.searchWord.value = '${requestScope.paramap.searchWord}';
			frm.clubseq.value = '${requestScope.paramap.clubseq}';
		}
		
		frm.method = "post";
		frm.action = "<%=ctxPath%>/club/clubboardDetail.do";
		frm.submit();
	
	});
});

function goSearch(){
	
	if($("input:text[name='searchWord']").val().trim() == ""){
		alert('검색어를 입력하세요.');
		return;
	}
	
	const frm = document.searchFrm;
	frm.submit();
}


function goWrite(clubseq){
	location.href = "<%= ctxPath%>/club/addClubBoard.do?clubseq="+clubseq;
}
	

</script>

<div id="wrap" style="width: 100%; padding: 5% 0;" align="center">
	<div id="top" class="mb-5" style="font-size: 35pt; font-weight: bolder; text-align: center;">[${requestScope.clubname}]<br><span style='color: #00588f;'>${requestScope.sportname}</span>&nbsp;동호회 게시판</div>
	<button style='margin-left: 70%; margin-bottom: 4%;'   type="button" class="btn btn-info btn-sm" onclick="goWrite('${requestScope.clubseq}')">작성하기</button>
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
				<c:if test="${not empty requestScope.clubboardList}">
					<c:forEach var="cboard" items="${requestScope.clubboardList}" varStatus="status">
						<tr>
							<fmt:parseNumber var="currentShowPageNo" value="${requestScope.currentShowPageNo}" />
	          				<fmt:parseNumber var="sizePerPage" value="${requestScope.sizePerPage}" />
	          				<td align="center">${requestScope.totalCount - (currentShowPageNo-1)*sizePerPage - status.index}</td>
							<td>${cboard.title}&nbsp;
								<c:if test="${cboard.commentcount != 0}"><span id="commentCount">[${cboard.commentcount}]</span></c:if>
								<c:if test="${not empty cboard.orgfilename}">&nbsp;&nbsp;<img width="15" height="15" src="<%=ctxPath %>/resources/images/zee/folder.png"/></c:if>
							</td>
							<td align="center">${cboard.fk_userid}</td>
							<td align="center">${cboard.registerdate}<input id="clubboardseq" type="hidden" name="clubboardseq" value="${cboard.clubboardseq}" /></td>
							<td align="center">${cboard.viewcount}</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty requestScope.clubboardList}">
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
		<input type="hidden" name="clubseq" />
		<input type="hidden" name="clubboardseq" />
		<input type="hidden" name="goBackURL" />
		<input type="hidden" name="searchType" />
		<input type="hidden" name="searchWord" />
	</form>

</div>
                     