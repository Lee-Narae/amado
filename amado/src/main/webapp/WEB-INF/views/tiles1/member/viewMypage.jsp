<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
   String ctxPath = request.getContextPath();
%>    


     
<style type="text/css">

    img.oldproduct {
		width: 60%;  
		margin: 0 auto;
	}
	
		
	.pagination a {
	  color: black;
	  float: left;
	  padding: 8px 16px;
	  text-decoration: none;
	  transition: background-color .3s;
	}
	
	.pagination a.active {
	  background-color: #8585b6;
	  color: white;
	}
	
	.pagination a:hover:not(.active) {
		background-color: #ddd;
	}


	.recentItem {
		border: solid 0px red;
		margin-top: 10%;
		width: 20%;
	}
    
    	
	#rItem img{
		border-radius: 20px;
	}
	div#notready{
		font-size: 15pt;
		padding-left: 38%;
	}    
	div#notready span{
		font-size: 30pt;
	}  
	a#itemRegister{
		color: black;
		margin-left: 80%;
		margin-top: 5%;
		
	}
	
	
	
	
	
	
	

	.mbtn{
		font-weight: bold;
    	height: 100px;
    	margin-inline-end: .25rem;
//    	background-color: #98b6d5; 
    	background-color: white; 
    	border: none; 
    	color: gray;
    	width: 40%;
    	cursor: pointer;
		transition: box-shadow 0.3s ease; /* 호버 시 부드러운 전환 효과 */
	}

	.mbtn:hover {
		color: #05203c; 
	}
	
	.hr1{
		border-style:none; 
		height: 2px; 
		background-color : lightgray;
	}
	.item1{
		border-left: solid 3px #05203c;
	}

	

</style>


<script type="text/javascript">


</script>

<div id="container">
	<div style="border:solid 1px red;">
		<%-- 마이페이지 서브메뉴 --%>
		<div id="submenu" style="border:solid 0px black; display: flex; margin-top: 3%; ">
			<div style="border:solid 0px blue; width: 50%; display: flex; margin: 0 auto;" >
    			  <button id="myinfo" class='mbtn' style="border-bottom: solid 3px #05203c; " >회원정보</button>
                  <button id="myclub" class='mbtn' style="border-bottom: solid 3px #05203c;">동호회 관리</button>
                  <button id="mygym" class='mbtn' style="border-bottom: solid 3px #05203c;"><div><img src="<%= ctxPath%>/resources/images/zee/court.png"></div>체육관 관리</button>
                  <button id="acc" class='mbtn' style="border-bottom: solid 3px #05203c;">기타</button>
            </div>
		</div>
		<hr style="height: 40px; background-color : #98b6d5;">
	
		<!-- 회원정보 -->
		<div>
			<div style="border:solid 0px black; width: 50%;  margin: 3% auto;" >
				<div class="item1">회원 정보 수정</div>
				<hr class="hr1">
				<br>
				
				<div class="item1">비밀번호 수정</div>
				<hr class="hr1">
				<br>
				
				<div class="item1">회원탈퇴</div>
				<hr class="hr1">
				<br>
			</div>
		</div>
	</div>
	
	

</div>