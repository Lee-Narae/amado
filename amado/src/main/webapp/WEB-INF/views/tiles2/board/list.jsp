<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


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
		
		$("div#displayList").hide();
	
}); // end of $(document).ready(function() -------
			
</script>



<div style="display: flex;">
	<div style="margin: auto; padding-left: 3%;">

		<h2 style="text-align:center; margin-bottom: 30px;">글목록</h2>
		
		<form name="searchFrm" class="float-right" style="text-align:right; margin-top: 20px;">
	    	<select name="searchType" style="height: 26px;">
	    		<option value="subject">글제목</option>
		        <option value="content">글내용</option>
		        <option value="subject_content">글제목+글내용</option>
		        <option value="name">글쓴이</option>
	      	</select>
	    	<input type="text" name="searchWord" size="40" autocomplete="off" /> 
	        <input type="text" style="display: none;"/> <%-- form 태그내에 input 태그가 오로지 1개 뿐일경우에는 엔터를 했을 경우 검색이 되어지므로 이것을 방지하고자 만든것이다. --%> 
	        <button type="button" class="btn btn-secondary btn-sm" onclick="goSearch()">검색</button>
		</form>	
<!-- 		<div id="displayList" style="border:solid 1px gray; border-top:0px; height:100px; margin-left:13.2%; margin-top:-1px; margin-bottom:30px; overflow:auto;">
			
		</div> -->

		<table style="width: 1024px" class="table table-bordered">
			<thead>
				<tr>
					<th style="width: 70px; text-align: center;">글번호</th>
					<th style="width: 300px; text-align: center;">제목</th>
					<th style="width: 70px; text-align: center;">작성자</th>
					<th style="width: 150px; text-align: center;">작성일자</th>
					<th style="width: 60px; text-align: center;">조회수</th>
				</tr>
			</thead>

			<tbody>

						<tr>
							<td align="center">글번호</td>
							<td>
								<span class="subject" onclick="goView()">번호</span>
							</td>
							<td align="center">이름</td>
							<td align="center">날짜</td>
							<td align="center">조회수</td>
						</tr>
					<tr>
						<td colspan="5">데이터가 없습니다.</td>
					</tr>
			</tbody>
		</table>
		
		<div style="display: flex;"  class="float-right">
			<button type="button" class="btn btn-secondary btn-sm" style="margin: auto 0 auto auto;" onclick="goSearch()">글쓰기</button>
		</div>
	</div>
</div>

<%-- #132. 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후
     //    사용자가 "검색된결과목록보기" 버튼을 클릭했을때 돌아갈 페이지를 알려주기 위해
     //    현재 페이지 주소를 뷰단으로 넘겨준다. 
--%>
<form name="goViewFrm">
	<input type="hidden" name="seq" /> 
	<input type="hidden" name="goBackURL" /> 
	<input type="hidden" name="searchType" /> 
	<input type="hidden" name="searchWord" /> 
</form>






