<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>

<style type="text/css">
.title {
width: 10%;
margin-left: 5%;
background-color: #0076d1;
color: white;
height: 40px;
align-content: center;
font-weight: bold;
border-radius: 20px;
}

.tr{
height: 50px;
padding-top: 0.4%;
}
</style>

<div id="wrap" style="min-height: 810px;" align="center">
<img width="260" class="mt-5" src="<%=ctxPath%>/resources/images/narae/공지사항 등록.png"/>

<div id="noticeContent" style="width: 90%; border: solid 1px red;">
	<div class="tr" style="align-content: center; display: flex;">
		<div class="title">제목</div>
		<div style="border: solid 1px red; width: 70%;"><input type="text" size="100"/></div>
	</div>
</div>

</div>