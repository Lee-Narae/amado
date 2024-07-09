<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
   String ctxPath = request.getContextPath();
%>


<style type="text/css">


/* 	.subject:hover {
		background: red;
	} */
    
    th {background-color: #ddd}
    
    .subjectStyle {font-weight: bold;
                   color: navy;
                   cursor: pointer; }
                   
    a {text-decoration: none !important;} /* 페이지바의 a 태그에 밑줄 없애기 */
    
</style>

<script type="text/javascript">

$(document).ready(function() {
		
	$("span.subject").hover(function(e){
		$(e.target).addClass("subjectStyle");
	}, function(e) {
		$(e.target).removeClass("subjectStyle");
	});
	
	$("input:text[name='searchWord']").bind("keyup", function(e){
		if(e.keyCode == 13){
			goSearch();
		}
	});
	
	// 검색시 검색조건 및 검색어 값 유지시키기
	if(${not empty requestScope.paraMap}) {
		$("select[name='searchType']").val("${requestScope.paraMap.searchType}");
		$("input[name='searchWord']").val("${requestScope.paraMap.searchWord}");
	}
	
	
}); // end of $(document).ready(function() -------
			
		
	function goAdd() {
		if("${requestScope.params}" == "/community/list.do") {
			location.href = "<%=ctxPath%>/community/add.do?sportseq="+"1";
		}
		else {
			location.href = "<%=ctxPath%>/community/add.do?sportseq="+"${requestScope.params}";	
		}
	
		
	} // end of goAdd
	
	function goSearch(){
//		alert("눌렀다");

		const frm = document.searchFrm;
		frm.submit();
	} // end of goSearch
	
	
	
	function goView(boardseq) {
		
/* 		alert("~~ 확인용 boardseq : " + boardseq); */
		
		const goBackURL = "${requestScope.goBackURL}";

 
//	그러므로 & 를 글자 그대로 인식하는 post 방식으로 보내야 한다.
//	아래에 #132. 에 표기된 from 태그를 먼저 만든다.

		const frm = document.goViewFrm;
 		frm.boardseq.value = boardseq;
		frm.goBackURL.value = goBackURL; 
		
		if(${not empty requestScope.paraMap}) { // 검색조건이 있을 경우
			frm.searchType.value = "${requestScope.paraMap.searchType}";
			frm.searchWord.value = "${requestScope.paraMap.searchWord}";
		}
		frm.action = "<%= ctxPath %>/board/boardview.do";
		frm.method = "post";
		frm.submit();

	} // end of function goView(seq) -------------------- 		
	
</script>




<div style="display: flex;">
	<div style="width: 80%; margin: auto; padding-left: 3%;">
	<c:if test="${requestScope.params == '/community/list.do'}">
		<h2 style="text-align:center; margin-bottom: 30px;">전체 게시판</h2>
	</c:if>
	<c:if test="${requestScope.params == '1'}">
		<h2 style="text-align:center; margin-bottom: 30px;">축구 게시판</h2>
	</c:if>		
	<c:if test="${requestScope.params == '2'}">
		<h2 style="text-align:center; margin-bottom: 30px;">야구 게시판</h2>
	</c:if>		
	<c:if test="${requestScope.params == '3'}">
		<h2 style="text-align:center; margin-bottom: 30px;">배구 게시판</h2>
	</c:if>		
	<c:if test="${requestScope.params == '4'}">
		<h2 style="text-align:center; margin-bottom: 30px;">농구 게시판</h2>
	</c:if>		
	<c:if test="${requestScope.params == '5'}">
		<h2 style="text-align:center; margin-bottom: 30px;">테니스 게시판</h2>
	</c:if>		
	<c:if test="${requestScope.params == '6'}">
		<h2 style="text-align:center; margin-bottom: 30px;">볼링 게시판</h2>
	</c:if>		
	<c:if test="${requestScope.params == '7'}">
		<h2 style="text-align:center; margin-bottom: 30px;">족구 게시판</h2>
	</c:if>		
	<c:if test="${requestScope.params == '8'}">
		<h2 style="text-align:center; margin-bottom: 30px;">배드민턴 게시판</h2>
	</c:if>		
	
		<form name="searchFrm" class="float-right" style="text-align:right; margin-bottom: 20px; margin-top: 20px;">
	    	<select name="searchType" style="height: 26px;">
	    		<option value="title">글제목</option>
		        <option value="content">글내용</option>
		        <option value="title_content">글제목+글내용</option>
		        <option value="fk_userid">작성자아이디</option>
	      	</select>
	    	<input type="text" name="searchWord" size="40" autocomplete="off" /> 
	        <input type="text" style="display: none;"/> <%-- form 태그내에 input 태그가 오로지 1개 뿐일경우에는 엔터를 했을 경우 검색이 되어지므로 이것을 방지하고자 만든것이다. --%> 
	        <button type="button" class="btn btn-secondary btn-sm" onclick="goSearch()">검색</button>
	        <input type="hidden" name="sportseq" value="${requestScope.params}" />
		</form>	

		<table class="table table-bordered">
			<thead>
				<tr>
					<th style="width: 70px; text-align: center;">글번호</th>
					<th style="width: 300px; text-align: center;">제목</th>
					<th style="width: 70px; text-align: center;">작성자아이디</th>
					<th style="width: 150px; text-align: center;">카테고리</th>
					<th style="width: 150px; text-align: center;">작성일자</th>
					<th style="width: 60px; text-align: center;">조회수</th>
				</tr>
			</thead>

			<tbody>
			
				
				<c:if test="${not empty requestScope.boardPagingList}">
					<c:forEach var="boardvo" items="${requestScope.boardPagingList}">
						<c:if test="${boardvo.fk_sportseq == 1}">
							<tr>
								<td align="center">${boardvo.boardseq}</td>
								<td>
									<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}</span>
								</td>
								<td align="center">${boardvo.fk_userid}</td>
								<td align="center">축구</td>
								<td align="center">${boardvo.registerdate}</td>
								<td align="center">${boardvo.viewcount}</td>
							</tr>
						</c:if>					
						<c:if test="${boardvo.fk_sportseq == 2}">
							<tr>
								<td align="center">${boardvo.boardseq}</td>
								<td>
									<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}</span>
								</td>
								<td align="center">${boardvo.fk_userid}</td>
								<td align="center">야구</td>
								<td align="center">${boardvo.registerdate}</td>
								<td align="center">${boardvo.viewcount}</td>
							</tr>
						</c:if>
						<c:if test="${boardvo.fk_sportseq == 3}">
							<tr>
								<td align="center">${boardvo.boardseq}</td>
								<td>
									<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}</span>
								</td>
								<td align="center">${boardvo.fk_userid}</td>
								<td align="center">배구</td>
								<td align="center">${boardvo.registerdate}</td>
								<td align="center">${boardvo.viewcount}</td>
							</tr>
						</c:if>
						<c:if test="${boardvo.fk_sportseq == 4}">
							<tr>
								<td align="center">${boardvo.boardseq}</td>
								<td>
									<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}</span>
								</td>
								<td align="center">${boardvo.fk_userid}</td>
								<td align="center">농구</td>
								<td align="center">${boardvo.registerdate}</td>
								<td align="center">${boardvo.viewcount}</td>
							</tr>
						</c:if>
						<c:if test="${boardvo.fk_sportseq == 5}">
							<tr>
								<td align="center">${boardvo.boardseq}</td>
								<td>
									<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}</span>
								</td>
								<td align="center">${boardvo.fk_userid}</td>
								<td align="center">테니스</td>
								<td align="center">${boardvo.registerdate}</td>
								<td align="center">${boardvo.viewcount}</td>
							</tr>
						</c:if>
						<c:if test="${boardvo.fk_sportseq == 6}">
							<tr>
								<td align="center">${boardvo.boardseq}</td>
								<td>
									<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}</span>
								</td>
								<td align="center">${boardvo.fk_userid}</td>
								<td align="center">볼링</td>
								<td align="center">${boardvo.registerdate}</td>
								<td align="center">${boardvo.viewcount}</td>
							</tr>
						</c:if>
						<c:if test="${boardvo.fk_sportseq == 7}">
							<tr>
								<td align="center">${boardvo.boardseq}</td>
								<td>
									<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}</span>
								</td>
								<td align="center">${boardvo.fk_userid}</td>
								<td align="center">족구</td>
								<td align="center">${boardvo.registerdate}</td>
								<td align="center">${boardvo.viewcount}</td>
							</tr>
						</c:if>
						<c:if test="${boardvo.fk_sportseq == 8}">
							<tr>
								<td align="center">${boardvo.boardseq}</td>
								<td>
									<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}</span>
								</td>
								<td align="center">${boardvo.fk_userid}</td>
								<td align="center">배드민턴</td>
								<td align="center">${boardvo.registerdate}</td>
								<td align="center">${boardvo.viewcount}</td>
							</tr>
						</c:if>
					</c:forEach>
				</c:if>

				<c:if test="${empty requestScope.boardPagingList}">
					<tr>
						<td colspan="6">데이터가 없습니다.</td>
					</tr>
				</c:if>

			</tbody>
		</table>
		
		<div style="display: flex;"  class="float-right">
			<button type="button" class="btn btn-secondary btn-sm" style="margin: auto 0 auto auto;" onclick="goAdd()">글쓰기</button>
		</div>
		
		<nav aria-label="Page navigation example">
			<ul class="pagination justify-content-center">${requestScope.pageBar}</ul>
	    </nav>  			
	</div>
	
</div>

<%-- #132. 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후
     //    사용자가 "검색된결과목록보기" 버튼을 클릭했을때 돌아갈 페이지를 알려주기 위해
     //    현재 페이지 주소를 뷰단으로 넘겨준다. 
--%>
<form name="goViewFrm">
	<input type="hidden" name="boardseq" /> 
	<input type="hidden" name="goBackURL" /> 
	<input type="hidden" name="searchType" /> 
	<input type="hidden" name="searchWord" /> 
</form>






