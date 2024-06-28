<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<%
   String ctxPath = request.getContextPath();
%>    

    
<style type="text/css">
    
#profile{
	display: flex;
}
#pimg{
	border: solid 1px gray;
	width: 170px;
	height: 190px;
	text-align: center;
	
}
#infoo{
	border: solid 1px gray;
}
select{
	width: 10%;
    height: 35px;
}
   
</style>



<div class="container" style="border:solid 1px black; margin: 12%;">

	<h3 style="font-weight: bolder;">기본정보</h3>
	<hr>
	
	<div id="profile">
		<div id="pimg">
			<div>사진</div>
		</div>
		<div id="infoo">
			<select id="sports" name="sports">
				<option value="category" selected>종목</option>
				<option value="soccer">축구</option>
				<option value="baseball">야구</option>
				<option value="category">배구</option>
				<option value="category">농구</option>
				<option value="category">테니스</option>
				<option value="category">볼링</option>
				<option value="category">족구</option>
				<option value="category">배드민턴</option>
			</select>
			
			<div>동호회장 명</div> <!-- 자동 -->
			<div>동호회장 아이디</div> <!-- 자동 -->
			<div>연락처</div> <!-- 자동 -->
			<div>이메일</div> <!-- 자동 -->
		</div>
	</div>
	
	<br><br><br><br>
	
	<!-- 동호회명 -->
	<h3 style="font-weight: bolder;">동호회명<span style="color: red;">*</span></h3>
	<hr>
	<input class="form-control form-control-lg" type="text" placeholder="동호회 이름을 입력하세요. " aria-label="">

	<br><br><br><br>
	
	<!-- 지역 -->
	<h3 style="font-weight: bolder;">지역<span style="color: red;">*</span></h3>
	<hr>
	<select class="form-select form-select-lg mb-3" aria-label="Large select example">
	  <option selected>시</option>
	  <option value="1">One</option>
	  <option value="2">Two</option>
	  <option value="3">Three</option>
	</select>
	
	<select class="form-select form-select-lg mb-3" aria-label="Large select example">
	  <option selected>구</option>
	  <option value="1">One</option>
	  <option value="2">Two</option>
	  <option value="3">Three</option>
	</select>

	
	



</div>