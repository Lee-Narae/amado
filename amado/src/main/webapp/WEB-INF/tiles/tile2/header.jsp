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
width: 80px;
text-align: center;
border-radius: 50px;
padding-top: 0.45%;
position: relative;
left: 77%;
top: 22%;
}

#logo{
width: 10%;
padding-left: 2%;
}

#signup {
background-color: #254179;
color: white;
height: 40px;
width: 100px;
text-align: center;
margin-left: 1%;
border-radius: 50px;
padding-top: 0.45%;
position: relative;
left: 77%;
top: 22%;
}

.nav{
font-size: 15pt;
margin-right: 5%;
width: 50% !important;
color: #254179;
padding-top: 1.5%;
}
</style>

<div id="header" style="border:solid 1px red; width: 100%; display: flex;">

	<div id="logo"><img src="<%=ctxPath %>/resources/images/logo.png" style="width: 100%;"/></div>
	<div style="margin-left: 3%; display: flex; width: 50%; border: solid 1px red;">
		<div class="nav" style="border: solid 1px red; margin-left: 15%;">Home</div>
		<div class="nav" style="border: solid 1px red;">Club ∨</div>
		<div class="nav" style="border: solid 1px red;">Gym ∨</div>
		<div class="nav" style="border: solid 1px red;">Notice</div>
	</div>
	<div id="login">로그인</div>
	<div id="signup">회원가입</div>
</div>
	    