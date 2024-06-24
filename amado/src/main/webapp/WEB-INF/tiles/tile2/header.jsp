<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- ===== #28. tile2 중 header 페이지 만들기 ===== --%> 
<%
	String ctxPath = request.getContextPath();
%>

<div id="header" style="border:solid 1px red; width: 100%; display: flex;">
	<div id="logo"><img src="" /></div>
	<div id="login" style="border: solid 1px red;">로그인</div>
	<div id="signup" style="border: solid 1px red;">회원가입</div>
</div>
	    