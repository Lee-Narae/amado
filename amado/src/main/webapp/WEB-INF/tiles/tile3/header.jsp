<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>

<style type="text/css">
#adminId:hover {
text-decoration: underline;
font-weight: bold;
cursor: pointer;
}
</style>

<div style="background-color: #247AFB; width: 100%; height: 100px; align-content: center;" align="right">
	<div style="width: 20%; height: 70px; display: flex;">
		<div style="width: 25%; height: 70px;" align="center"><img style="width: 80%;" src="<%=ctxPath %>/resources/images/narae/adminlogo.png"/></div>
		<div style="width: 65%; height: 70px; align-content: center; color: white;" align="center"><span id="adminId">${sessionScope.admin.userid} [${sessionScope.admin.name}]</span> 님 로그인 중</div>
	</div>

</div>

