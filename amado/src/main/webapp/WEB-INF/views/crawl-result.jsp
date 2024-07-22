<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>크롤링 결과</title>
</head>
<body>

<h1>크롤링 결과</h1>

<c:if test="${not empty error}">
    <p style="color: red;">${error}</p>
</c:if>

<h2>이미지 URL 목록</h2>
<c:forEach var="imageUrl" items="${imageUrls}">
    <p>${imageUrl}</p>
</c:forEach>

<h2>텍스트 내용 목록</h2>
<c:forEach var="textContent" items="${textContents}">
    <p>${textContent}</p>
</c:forEach>

</body>
</html>