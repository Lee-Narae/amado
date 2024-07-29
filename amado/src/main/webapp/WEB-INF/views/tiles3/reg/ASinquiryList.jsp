<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String ctxPath = request.getContextPath();
%>

<style type="text/css">
    
   	td.title{
	    width: 600px; /* 최대 너비를 적절히 설정 */
	    max-width: 600px; /* 최대 너비를 적절히 설정 */
	    overflow: hidden;
	    text-overflow: ellipsis;
	    white-space: nowrap;
	}
	
	td.title:hover{
	font-weight: bold;
	color: #0066ff;
	cursor: pointer;
	}
    
    .subjectStyle {font-weight: bold;
                   color: fff;
                   cursor: pointer; }
                   
    a {text-decoration: none !important;} /* 페이지바의 a 태그에 밑줄 없애기 */
    
    table#memberTbl th {
	text-align: center;
	font-size: 14pt;
	}
    
</style>

<script type="text/javascript">

 	$(document).ready(function(){
		
		$("input:text[name='searchWord']").bind("keyup", function(e){
			if(e.keyCode == 13){ // 엔터를 했을 경우
				goSearch();
			}
		});
		
		 $("select[name='searchtype_a'], select[name='searchtype_b'], select[name='searchtype_answer'], select[name='searchtype_fk_userid']").on("change", function(){
			 goSearch();
		 });// end of searchType
		
		// 검색시 검색조건 및 검색어 값 유지시키기
		if(${not empty requestScope.paraMap}) {
			$("select[name='searchtype_a']").val("${requestScope.paraMap.searchtype_a}");
			updateSearchTypeB();
			$("select[name='searchtype_b']").val("${requestScope.paraMap.searchtype_b}");
			$("select[name='searchtype_fk_userid']").val("${requestScope.paraMap.searchtype_fk_userid}");
			$("select[name='searchtype_answer']").val("${requestScope.paraMap.searchtype_answer}");
			$("input[name='searchWord']").val("${requestScope.paraMap.searchWord}");
		}
	}); // end of $(document).ready 
	
	function goSearch() {
		 const frm = document.searchFrm;
	 	 frm.method = "get";
	  	 frm.action = "<%= ctxPath%>/admin/reg/ASinquiryList";
	     frm.submit(); 
	}// end of function goSearch()-------------------	

    function updateSearchTypeB() {
        var searchTypeA = document.getElementById("searchtype_a").value;
        var searchTypeB = document.getElementById("searchtype_b");
        var previousValue = searchTypeB.value;
        searchTypeB.innerHTML = "";

        var options = {
            "0": [{"text": "선택해주세요", "value": "0"}],
            "1": [{"text": "전체", "value": "0"}, {"text": "대관문의", "value": "1"}, {"text": "환불문의", "value": "2"}, {"text": "기타문의", "value": "3"}],
            "2": [{"text": "전체", "value": "0"}, {"text": "시설문의", "value": "1"}, {"text": "예약문의", "value": "2"}, {"text": "기타문의", "value": "3"}],
            "3": [{"text": "전체", "value": "0"}, {"text": "참가문의", "value": "1"}, {"text": "환불문의", "value": "2"}, {"text": "기타문의", "value": "3"}],
            "4": [{"text": "전체", "value": "0"}, {"text": "일반문의", "value": "1"}, {"text": "환불문의", "value": "2"}, {"text": "기타문의", "value": "3"}]
        };

        options[searchTypeA].forEach(function(optionObject) {
            var option = document.createElement("option");
            option.text = optionObject.text;
            option.value = optionObject.value;
            if (option.value === previousValue) {
                option.selected = true;
            }
            searchTypeB.add(option);
        });
    } // end of updateSearchTypeB
    
    
    function goDetail(inquiryseq) {
    	
		const goBackURL = "${requestScope.goBackURL}";
		
		const frm = document.goViewFrm;
 		frm.inquiryseq.value = inquiryseq;
		frm.goBackURL.value = goBackURL; 
		
		if(${not empty requestScope.paraMap}) { // 검색조건이 있을 경우
			frm.searchtype_a.value = "${requestScope.paraMap.searchtype_a}";
			frm.searchtype_b.value = "${requestScope.paraMap.searchtype_b}";
			frm.searchtype_answer.value = "${requestScope.paraMap.searchtype_answer}";
			frm.searchtype_fk_userid.value = "${requestScope.paraMap.searchtype_fk_userid}";
			frm.searchWord.value = "${requestScope.paraMap.searchWord}";
		}
		frm.action = "<%=ctxPath%>/admin/reg/inquiryGoDetail";
		frm.method = "post";
		frm.submit();
    	
    } // end of goDetail(inquiryseq) 
	
</script>

<div style="display: flex;">
<div class="mt-5" style="margin: auto; padding-left: 3%;">

	<h2 style="margin-bottom: 30px;">문의내역</h2>
	<div style="cursor: pointer; text-decoration: underline;" onclick="location.href='<%=ctxPath%>/admin/reg/ASinquiryList'" >처음으로</div>
	
	<form name="searchFrm" style="margin-top: 20px; margin-bottom: 20px;">
		<select id="searchtype_a" name="searchtype_a" onchange="updateSearchTypeB()">
			<option value="0">선택해주세요</option>
			<option value="1">동호회</option>
			<option value="2">체육관</option>
			<option value="3">플리마켓</option>
			<option value="4">기타</option>
		</select> 
		<select class="ml-2" id="searchtype_b" name="searchtype_b">
			<option value="0">선택해주세요</option>
		</select>
		<select class="ml-2" id="searchtype_answer" name="searchtype_answer">
			<option value="99">답변여부검색시</option>
			<option value="0">답변대기</option>
			<option value="1">답변완료</option>
		</select>
		<select class="ml-2" id="searchtype_fk_userid" name="searchtype_fk_userid">
			<option value="0">아이디검색시(관리자)</option>
			<option value="1">아이디검색</option>
		</select>
		<button type="button" class="float-right btn btn-secondary btn-sm" onclick="goSearch()">검색</button>
		<input class="mr-2 ml-2 float-right" type="text" name="searchWord" size="40" autocomplete="off" /> 
		<input type="hidden" name="userid" value="${requestScope.fk_userid}" /> 
		<input type="text" style="display: none;"/> <%-- form 태그내에 input 태그가 오로지 1개 뿐일경우에는 엔터를 했을 경우 검색이 되어지므로 이것을 방지하고자 만든것이다. --%> 
		 
	</form>	
	
	<table style="width: 1280px" class="table table-bordered">
		<thead>
		    <tr style="background-color: #ccf3ff;">
		    	<th style="width: 80px;  text-align: center;">글번호</th>
				<th style="width: 220px; text-align: center;">제목</th>
				<th style="width: 120px; text-align: center;">답변여부</th>
				<th style="width: 120px;  text-align: center;">아이디</th>
				<th style="width: 200px;  text-align: center;">타입</th>
				<th style="width: 200px; text-align: center;">날짜</th>
		    </tr>
		</thead>
		
		<tbody>
			<c:if test="${not empty requestScope.inquiryPagingList}">
			   <c:forEach var="inquiryvo" items="${requestScope.inquiryPagingList}" varStatus="status">
			     <tr onclick="goDetail('${inquiryvo.inquiryseq}')">
			        <td align="center">${inquiryvo.inquiryseq}</td>
			        <td align="center" class="title">${inquiryvo.title}</td>
				    
				    <c:choose>
				        <c:when test="${inquiryvo.answer == 0}">
				            <td align="center">답변대기</td>
				        </c:when>
				        <c:otherwise>
				            <td align="center">답변완료</td>
				        </c:otherwise>
				    </c:choose>			        

			        <td align="center">${inquiryvo.fk_userid}</td>
			        
			        <c:if test="${inquiryvo.searchtype_a == 1 && inquiryvo.searchtype_b == 1}">
			        	<td align="center">동호회 : 대관문의</td>
			        </c:if>
			        <c:if test="${inquiryvo.searchtype_a == 1 && inquiryvo.searchtype_b == 2}">
			        	<td align="center">동호회 : 환불문의</td>
			        </c:if>
			        <c:if test="${inquiryvo.searchtype_a == 1 && inquiryvo.searchtype_b == 3}">
			        	<td align="center">동호회 : 기타문의</td>
			        </c:if>
			        
			        
			        <c:if test="${inquiryvo.searchtype_a == 2 && inquiryvo.searchtype_b == 1}">
			        	<td align="center">체육관 : 시설문의</td>
			        </c:if>
			        <c:if test="${inquiryvo.searchtype_a == 2 && inquiryvo.searchtype_b == 2}">
			        	<td align="center">체육관 : 예약문의</td>
			        </c:if>
			        <c:if test="${inquiryvo.searchtype_a == 2 && inquiryvo.searchtype_b == 3}">
			        	<td align="center">체육관 : 기타문의</td>
			        </c:if>
			        
			        
			        <c:if test="${inquiryvo.searchtype_a == 3 && inquiryvo.searchtype_b == 1}">
			        	<td align="center">플리마켓 : 참가문의</td>
			        </c:if>
			        <c:if test="${inquiryvo.searchtype_a == 3 && inquiryvo.searchtype_b == 2}">
			        	<td align="center">플리마켓 : 환불문의</td>
			        </c:if>
			        <c:if test="${inquiryvo.searchtype_a == 3 && inquiryvo.searchtype_b == 3}">
			        	<td align="center">플리마켓 : 기타문의</td>
			        </c:if>
			        
			        
			        <c:if test="${inquiryvo.searchtype_a == 4 && inquiryvo.searchtype_b == 1}">
			        	<td align="center">기타 : 일반문의</td>
			        </c:if>
			        <c:if test="${inquiryvo.searchtype_a == 4 && inquiryvo.searchtype_b == 2}">
			        	<td align="center">기타 : 환불문의</td>
			        </c:if>
			        <c:if test="${inquiryvo.searchtype_a == 4 && inquiryvo.searchtype_b == 3}">
			        	<td align="center">기타 : 기타문의</td>
			        </c:if>
			        
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
   <input type="hidden" name="searchtype_fk_userid" />
   <input type="hidden" name="searchtype_answer" />
   <input type="hidden" name="searchWord" />
   <input type="hidden" name="fk_userid" />
</form>	     
