<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- ===== #28. tile2 중 header 페이지 만들기 ===== --%> 
<%
	String ctxPath = request.getContextPath();
	String serverIP = "192.168.0.204";
	int portnumber = request.getServerPort();
	String serverName = "http://"+serverIP+":"+portnumber;
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

#login:hover {
background-color: #f0f8ff;
font-weight: bold;
cursor: pointer;
}

#logo{
width: 22%;
padding-left: 2%;
cursor: pointer;
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

#signup:hover {
background-color: #30549c;
font-weight: bold;
cursor: pointer;
}
.nav{
font-size: 15pt;
margin-right: 20%;
color: #254179;
margin-top: 6.5%;
cursor: pointer;
}

.tabs {
color: white;
width: 7%;
padding-top: 3%;
}

.tabs > div {
font-size: 11pt;
margin-bottom: 10%;
}

.tabs > div:hover {
cursor: pointer;
font-weight: bold;
}

#logout {
background-color: #d6d6d6;
height: 40px;
width: 110px;
text-align: center;
margin-left: 1%;
border-radius: 50px;
padding-top: 2.5%;
}

#username {
font-weight: bold;
}

#username:hover {
color: blue;
text-decoration: underline;
cursor: pointer;
}

#logout:hover {
background-color: #bfbfbf;
cursor: pointer;
font-weight: bold;
}

#cld:hover {
cursor: pointer;
opacity: 0.8;
}

</style>

<script type="text/javascript">
$(document).ready(function(){
	
	$("div#tab").hide();
	
	$("div.nav").hover(function(){
		$("div#tab").slideDown();
	}, function(){
		$("div#tab").hide();
	});
	
	$("div#tab").hover(function(){
		$("div#tab").show();
	}, function(){
		$("div#tab").hide();
	});
	
	function goSignup() {
		location.href = "<%=ctxPath%>/member/memberRegister.do";
	}	
	
});
</script>

<div id="header" style="width: 100%; display: flex; background-color: white;">
	<div id="logo" onclick="location.href='<%=ctxPath%>/index.do'"><img src="<%=ctxPath %>/resources/images/logo.png" style="width: 100%;"/></div>
	<div style="margin-left: 3%; display: flex; width: 50%;">
		<div class="nav" style=" margin-left: 10%;">Home</div>
		<div class="nav">Club&nbsp;&nbsp;∨</div>
		<div class="nav">Gym&nbsp;&nbsp;∨</div>
		<div class="nav">Community&nbsp;&nbsp;∨</div>
	</div>
	<div style="display: flex; margin-left: 45%; width: 30%; margin-top: 1.4%;">
		<c:if test="${empty sessionScope.loginuser }">
			<div id="login" onclick="location.href='<%=ctxPath%>/member/login.do'">로그인</div>
			<div id="signup" onclick="location.href='<%=ctxPath%>/member/memberRegister.do'">회원가입</div>
		</c:if>
		<c:if test="${not empty sessionScope.loginuser }">
			<div style="margin-top: 3%; margin-right: 3%;"><span id="username" onclick="location.href='<%=ctxPath%>/member/myPage.do'">${sessionScope.loginuser.name }</span> 님</div>
			<img id="cld" style="margin-right: 5%;" width="40" height="40" src="https://img.icons8.com/cotton/64/calendar--v1.png" onclick="location.href='<%=ctxPath %>/schedule/scheduleManagement.do'" alt="calendar--v1"/>
			<div id="logout" onclick="location.href='<%=ctxPath%>/member/logout.do'">로그아웃</div>
		</c:if>		
	</div>
</div>
<div id="tab" style="display: flex; width: 100%; height: 300px; background-color: #254179;">
	<div style="display: flex; width: 100%;">
		<div class="tabs" style="margin-right: 1%; margin-left: 17%;">
			<div onclick="location.href='<%=ctxPath%>/index.do'">Home</div>
		</div>
		<div class="tabs" style="margin-right: 2%;">
			<div onclick="location.href='<%=ctxPath%>/club/viewclub.do'">동호회 찾기</div>
			<div onclick="location.href='<%=ctxPath%>/club/myClub.do?sportseq=1'">My 동호회</div>
			<div onclick="location.href='<%=ctxPath%>/club/clubRegister.do'">동호회 등록하기</div>
			<div onclick="location.href='<%=ctxPath%>/club/matchRegister.do'">매치 등록하기</div>
			<div onclick="location.href='<%=ctxPath%>/club/fleamarket.do'">플리마켓</div>
		</div>
		<div class="tabs" style="margin-right: 2%;">
			<div onclick="location.href='<%=ctxPath%>/gym/rental_gym.do'">체육관 찾기</div>
			<div onclick="location.href='<%=ctxPath%>/gym/registerGym.do'">체육관 등록하기</div>
			<div onclick="location.href='#'">My 예약 조회</div>
		</div>
		<div class="tabs">
			<div onclick="location.href='<%=ctxPath%>/community/noticeList.do'">공지사항</div>
			<div onclick="location.href='<%=ctxPath%>/community/list.do'">게시판</div>
			<div onclick="location.href='<%=ctxPath%>/community/inquiry.do'">1:1 문의하기</div>
			<div onclick="location.href='<%=ctxPath%>/community/SportsFacilitiesInfo.do'">전국체육시설 정보</div>
		</div>
	</div>
</div>
	    