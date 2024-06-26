<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
   String ctxPath = request.getContextPath();
%>


<style type="text/css">



    
</style>

<script type="text/javascript">

$(document).ready(function() {
	
	
}); // end of $(document).ready

</script>

<div style="width: 1024px; margin: auto; padding-left: 3%;">

	<h2 style="text-align: center; margin-bottom: 30px;">동호회 찾기</h2>


	<div style="display: flex;">
		<div style="width: 1024px; margin: auto; padding-left: 3%;">
			
			<ul>
				<li class="imgList" style="position: relative; margin-bottom: 50px;">
					<img class="img" src="<%=ctxPath %>/resources/images/podium.png" style="width: 60%; z-index: 1; position:absolute;"class="img-fluid mx-auto d-block" alt="center" />
		
					<img class="A" src="<%=ctxPath %>/resources/images/podium.png" style="width: 20px; height: 20px; z-index: 2; position:absolute; margin-left: 100px;" alt="center" />
					<img class="B" src="<%=ctxPath %>/resources/images/podium.png" style="width: 20px; height: 20px; z-index: 2; position:absolute; margin-left: 120px;" alt="center" />
					<img class="C" src="<%=ctxPath %>/resources/images/podium.png" style="width: 20px; height: 20px; z-index: 2; position:absolute; margin-left: 140px;" alt="center" />
				</li>
			</ul>
		<br><br><br>

			<form name="searchFrm" style="margin-bottom: 40px; margin-top: 20px;">
				<div class="float-left">
					<select name="searchType" style="height: 26px;">
						<option value="Ranking">랭킹순</option>
						<option value="name">이름순</option>
						<option value="Member">회원순</option>
					</select>
					 
					<select name="searchType" style="height: 26px;">
						<option value="gyeonggi-do">경기도</option>
						<option value="gangwon-do">강원도</option>
						<option value="Chungcheong">충청도</option>
						<option value="gyeongsang">경상도</option>
						<option value="jeolla">전라도</option>
					</select> 
				</div>
				<div class="float-right" style="margin-bottom: 20px;">
					<input type="text" name="searchWord" size="30" placeholder="동호회명을 검색하세요" style="text-align: center;" autocomplete="off" />
					<input type="text" style="display: none;" />
					<%-- form 태그내에 input 태그가 오로지 1개 뿐일경우에는 엔터를 했을 경우 검색이 되어지므로 이것을 방지하고자 만든것이다. --%>
					<button type="button" class="btn btn-secondary btn-sm" onclick="goSearch()">검색</button>
				</div>
			</form>
			<!-- 		<div id="displayList" style="border:solid 1px gray; border-top:0px; height:100px; margin-left:13.2%; margin-top:-1px; margin-bottom:30px; overflow:auto;">
			
		</div> -->

			<table class="table table-bordered">
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
							<td align="center" onclick="goView()">글번호</td>
							<td><span class="subject" onclick="goView()">${paraMap.content}</span>
							</td>
							<td align="center">${paraMap.name}</td>
							<td align="center">날짜</td>
							<td align="center">조회수</td>
						</tr>
<!-- 						<tr>
							<td colspan="5">데이터가 없습니다.</td>
						</tr> -->

				</tbody>
			</table>

		</div>
	</div>
</div>