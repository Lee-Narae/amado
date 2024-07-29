<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
%>

<style type="text/css">
.text {
width: 90%;
height: 50px;
text-align: left;
font-size: 13pt;
align-content: center;
margin: 1% 0 1% 0;
padding-left: 20%;
}

.minitext {
font-size: 10pt;
font-weight: bold;
text-align: left;
margin: 0 0 5% 10%;
color: #969696;
}

hr {
width: 85%;
}

.text:hover {
background-color: #247AFB; border-radius: 10px; font-weight: bold; color: white; cursor: pointer;
}

.hover {
background-color: #247AFB; border-radius: 10px; font-weight: bold; color: white; cursor: pointer;
}

</style>

<div>

<div id="logo" style="height: 100px;" align="center">
<img src="<%=ctxPath %>/resources/images/logo.png" style="width: 70%;"/>
</div>
<div id="top" style="height: 50px;" align="center">
	<div class="text" onclick="location.href='<%=ctxPath%>/admin/main'" id="dashboard" style="margin-top: 15%;">대시보드</div>
</div>
<hr>
<div id="middle" style="height: 200px;" align="center">
	<div class="minitext">관리</div>
	<div class="text" onclick="location.href='<%=ctxPath%>/admin/manage/member'" id="memberM">회원 관리</div>
	<div class="text" onclick="location.href='<%=ctxPath%>/admin/manage/club'" id="clubM">동호회 관리</div>
	<div class="text" onclick="location.href='<%=ctxPath%>/admin/manage/...'" id="gymM">대관 관리</div>
</div>
<hr>
<div id="middle2" style="height: 200px;" align="center">
<div class="minitext">등록</div>
	<div class="text" onclick="location.href='<%=ctxPath%>/admin/reg/notice'" id="noticeR">공지사항 등록</div>
	<div class="text" onclick="location.href='<%=ctxPath%>/admin/reg/gym'" id="gymR">체육관 등록</div>
	<div class="text" onclick="location.href='<%=ctxPath%>/admin/reg/ASinquiryList'" id="inquiryA">문의답변 등록</div>
</div>
<hr>
<div id="bottom" style="height: 100px;" align="center">
	<div class="text" onclick="location.href='<%=ctxPath%>/admin/logout'" id="logout">로그아웃</div>
</div>

</div>