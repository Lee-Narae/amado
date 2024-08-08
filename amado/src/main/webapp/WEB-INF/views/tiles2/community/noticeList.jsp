<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% String ctxPath = request.getContextPath(); %>


<style type="text/css">

th {
height: 50px;
font-size: 15pt;
text-align: center;
align-content: center;
background-color: #3366ff;
color: white;
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
border-top: solid 1px #e0e0e0;
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

#displayList {
text-align: left;
padding: 1%;
border-top: none;
width: 15.5%;
margin-left: 5%;
overflow: auto;
position: relative;
top: -55px;
right: -3px;
z-index: -5;
border-bottom-right-radius: 10px;
border-bottom-left-radius: 10px;
background-color: #e3e3e3;
}

</style>

<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" /> 
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	if(${not empty requestScope.searchType && not empty requestScope.searchWord}){
		$("select[name='searchType']").val('${requestScope.searchType}');
		$("input[name='searchWord']").val('${requestScope.searchWord}');
	}
	
	
	$("div#displayList").hide();
	
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

		let noticeseq = $(e.target).parent().find("input[name='noticeseq']").val();
		
		const frm = document.goViewFrm;
		frm.noticeseq.value = noticeseq;
		frm.goBackURL.value = "${requestScope.currentURL}";
		
		if(${not empty requestScope.paramap.searchType}){ // 검색을 했을 경우
			frm.searchType.value = '${requestScope.paramap.searchType}';
			frm.searchWord.value = '${requestScope.paramap.searchWord}';
		}
		
		frm.method = "post";
		frm.action = "<%=ctxPath%>/community/noticeDetail.do";
		frm.submit();
	
	});


	// 검색어 자동완성
	$("input[name='searchWord']").keyup(function(){
		
		const wordLength = $(this).val().trim().length;
		if(wordLength == 0){
			$("div#displayList").hide();
		}
		else{
			
			if($("select[name='searchType']").val() == 'title' ||
			   $("select[name='searchType']").val() == 'content'){
				
				$.ajax({
					url: "<%=ctxPath%>/community/wordSearch.do",
					type: "get",
					data: {"searchType": $("select[name='searchType']").val(),
						   "searchWord": $("input[name='searchWord']").val()},
					dataType: "json",
					success: function(json){
						
						if(json.length > 0){ // 검색 데이터가 있는 경우
							let v_html = ``;
						
							$.each(json, function(index, item){
								const word = item.word;
								
								const idx = word.toLowerCase().indexOf($("input[name='searchWord']").val().toLowerCase());
								
								if(idx != -1){
									const len = $("input[name='searchWord']").val().length;
									
									const result = word.substring(0, idx)
												  +"<span style='color: orange;'>"
												  +word.substring(idx, idx+len)+"</span>"+word.substring(idx+len);
									
									if(index < 10){
										v_html += `<span style='cursor: pointer;' class='result'>\${result}<br></span>`;
									}
								}
							}); // end of for
							
							const width = $("input[name='searchWord']").css("width");
							
							$("div#displayList").css({"width": width});
							
							$("div#displayList").html(v_html);
							$("div#displayList").show();
						
						}
					},
					error: function(request, status, error){
				          alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			        }
				});
				
			}
			
		}
		
	});



}); // document.ready

function goSearch(){
	
	if($("input:text[name='searchWord']").val().trim() == ""){
		swal('검색어를 입력하세요.');
		return;
	}
	
	
	
	const frm = document.searchFrm;
	frm.submit();
}
</script>

<div id="wrap" style="width: 100%; padding: 5% 0;" align="center">
	<div id="top" class="mb-5" style="font-size: 35pt; font-weight: bolder; text-align: center;">공지사항</div>

	<div id="bottom" style="width: 80%;">
		<table class="mb-5" style="width: 100%;">
			<thead>
				<tr>
					<th width="10">순번</th>
					<th width="65">제목</th>
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
							<td>${notice.title}&nbsp;
								<c:if test="${notice.commentcount != 0}"><span id="commentCount">[${notice.commentcount}]</span></c:if>
								<c:if test="${not empty notice.orgfilename}">&nbsp;&nbsp;<img width="15" height="15" src="https://img.icons8.com/external-others-bomsymbols-/91/external-disk-flat-02-digital-design-others-bomsymbols-.png" alt="external-disk-flat-02-digital-design-others-bomsymbols-"/></c:if>
								</td>
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
		
		<div id="displayList">
		
		</div>
		
		<c:if test="${not empty requestScope.noticeList}">
		<div id="pageBar" style="margin-left: 36%;">
	       <nav>
	          <ul class="pagination">${requestScope.pageBar}</ul>
	       </nav>
	    </div>
	    </c:if>
		
	</div>
	
	<form name="goViewFrm">
		<input type="hidden" name="noticeseq" />
		<input type="hidden" name="goBackURL" />
		<input type="hidden" name="searchType" />
		<input type="hidden" name="searchWord" />
	</form>

</div>
