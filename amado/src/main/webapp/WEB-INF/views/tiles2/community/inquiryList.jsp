<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String ctxPath = request.getContextPath();
%>

<style type="text/css">
    
    th {background-color: #ddd}
    
    .subjectStyle {font-weight: bold;
                   color: navy;
                   cursor: pointer; }
                   
    a {text-decoration: none !important;} /* 페이지바의 a 태그에 밑줄 없애기 */
    
</style>

<script type="text/javascript">

	$(document).ready(function(){

		$("input:text[name='searchWord']").bind("keyup", function(e){
			if(e.keyCode == 13){ // 엔터를 했을 경우
				goSearch();
			}
		});
		
		// 검색시 검색조건 및 검색어 값 유지시키기
		if(${not empty requestScope.paraMap}) {
			$("select[name='searchtype_a']").val("${requestScope.paraMap.searchtype_a}");
			$("select[name='searchtype_b']").val("${requestScope.paraMap.searchtype_b}");
			$("input[name='searchWord']").val("${requestScope.paraMap.searchWord}");
		}
		
	}); // end of $(document).ready 
	
	function goSearch() {
		 const frm = document.searchFrm;
	 	 frm.method = "get";
	  	 frm.action = "<%= ctxPath%>/community/inquiryList.do";
	     frm.submit(); 
	}// end of function goSearch()-------------------	

</script>

<div style="display: flex;">
<div style="margin: auto; padding-left: 3%;">

	<h2 style="margin-bottom: 30px;">글목록</h2>
	
	<form name="searchFrm" style="margin-top: 20px; margin-bottom: 20px;">
		<select id="searchtype_a" name="searchtype_a">
			<option value="0">선택해주세요</option>
			<option value="1">동호회</option>
			<option value="2">체육관</option>
			<option value="3">플리마켓</option>
			<option value="4">기타</option>
		</select> 
		<select class="ml-2" id="searchtype_b" name="searchtype_b">
			<option value="0">선택해주세요</option>
			<option value="1">대관문의</option>
			<option value="2">환불문의</option>
			<option value="3">기타문의</option>
		</select>
		<input class="ml-2" type="text" name="searchWord" size="40" autocomplete="off" /> 
		<input type="hidden" name="userid" value="${requestScope.fk_userid}" /> 
		<input type="text" style="display: none;"/> <%-- form 태그내에 input 태그가 오로지 1개 뿐일경우에는 엔터를 했을 경우 검색이 되어지므로 이것을 방지하고자 만든것이다. --%> 
		<button type="button" class="btn btn-secondary btn-sm" onclick="goSearch()">검색</button> 
	</form>	
	
	<table style="width: 1024px" class="table table-bordered">
		<thead>
		    <tr>
		    	<th style="width: 70px;  text-align: center;">글번호</th>
				<th style="width: 300px; text-align: center;">내용</th>
				<th style="width: 70px;  text-align: center;">아이디</th>
				<th style="width: 150px; text-align: center;">날짜</th>
		    </tr>
		</thead>
		
		<tbody>
			<c:if test="${not empty requestScope.inquiryPagingList}">
			   <c:forEach var="inquiryvo" items="${requestScope.inquiryPagingList}" varStatus="status">
			     <tr>
			        <td align="center">${inquiryvo.inquiryseq}</td>
			        <td align="center">${inquiryvo.content}</td>
			        <td align="center">${inquiryvo.fk_userid}</td>
			        <td align="center">${inquiryvo.registerdate}</td>
			     </tr>
			   </c:forEach>
			</c:if>
			
			<c:if test="${empty requestScope.inquiryPagingList}">
			    <tr>
			       <td colspan="5">데이터가 없습니다</td>
			    </tr>
			</c:if>
		</tbody>
	</table>
	
	<div align="center" style="border: solid 0px gray; width: 80%; margin: 30px auto;">  
	     ${requestScope.pageBar}
	</div>
	
</div>
</div>		

<form name="goViewFrm">
   <input type="hidden" name="inquiryseq" />
   <input type="hidden" name="goBackURL" />
   <input type="hidden" name="searchtype_a" />
   <input type="hidden" name="searchtype_b" />
   <input type="hidden" name="searchWord" />
</form>	     
