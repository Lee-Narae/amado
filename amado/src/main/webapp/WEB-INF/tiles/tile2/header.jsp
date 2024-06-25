<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- ===== #28. tile2 중 header 페이지 만들기 ===== --%> 
<%
	String ctxPath = request.getContextPath();
%>


<style type="text/css">

#login {
border: solid 1.5px #254179;
height: 40px;
width: 100px;
text-align: center;
border-radius: 50px;
padding-top: 2.5%;
margin-right: 7%;
}

#logo{
width: 22%;
padding-left: 2%;
}

#signup {
background-color: #254179;
color: white;
height: 40px;
width: 110px;
text-align: center;
margin-left: 1%;
border-radius: 50px;
padding-top: 2.5%;
}

.nav{
font-size: 15pt;
margin-right: 20%;
color: #254179;
margin-top: 6.5%;
}

/*.tabs {
border: solid 1px white;
width: 15%;
}*/
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
	});
	
	function goSignup() {
		location.href = "<%=ctxPath%>/member/memberRegister.do";
	}

	function goHome() {
		location.href = "<%=ctxPath%>/index.do";
	}
	
</script>

<div id="header" style="width: 100%; display: flex; background-color: white;">
	<div id="logo"><a class="navbar-brand" href="<%= ctxPath %>/index.do" style="margin-right: 10%;"><img src="<%=ctxPath %>/resources/images/logo.png" style="width: 100%;"/></a></div>
	<div style="margin-left: 3%; display: flex; width: 50%;">
		<div class="nav" style=" margin-left: 10%;" onclick="goHome()">Home</div>
		<div class="nav">Club&nbsp;&nbsp;∨</div>
        <a class="nav" href="#" id="navbarDropdown" data-toggle="dropdown">board&nbsp;&nbsp;∨</a>  
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
           <a class="dropdown-item" href="<%=ctxPath%>/list.do">게시판목록</a>
        </div>
		<div class="nav">Gym&nbsp;&nbsp;∨</div>
		<div class="nav">Notice</div>
	</div>
	<div style="display: flex; margin-left: 45%; width: 30%; margin-top: 1.4%;">
		<div id="login">로그인</div>
		<div id="signup" onclick="goSignup()">회원가입</a></div>
	</div>
</div>
<%-- <div id="tab" style="display: flex; width: 100%; height: 300px; background-color: #254179;">
	<div id="random" style="width: 8%; margin: 4% 0 0 3%;"><img src="<%= ctxPath %>/resources/images/casual-life-3d-pink-basketball.png" style="width: 100%;"/></div>
	<div style="display: flex; border: solid 1px red; width: 50%; margin-left: 5%;">
		<div class="tabs" style="margin-right: 1%;">
			<div>Home</div>
		</div>
		<div class="tabs" style="margin-right: 2%;">
			
		</div>
		<div class="tabs" style="margin-right: 2%;"></div>
		<div class="tabs"></div>
	</div>
</div> --%>
	    