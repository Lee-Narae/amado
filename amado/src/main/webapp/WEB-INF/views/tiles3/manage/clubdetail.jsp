<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% String ctxPath = request.getContextPath(); %>

<style type="text/css">

  table.table-bordered > tbody > tr > td:nth-child(1) {
      width: 25%;
      font-weight: bold;
      text-align: right;
  }

</style>

<script type="text/javascript">
$(document).ready(function(){
	$("div#clubM").addClass("hover");
});
</script>


<div class="container pt-5 pb-5" style="min-height: 810px;">

	<c:if test="${empty requestScope.club }">
		존재하지 않는 동호회입니다.<br>
	</c:if>
	
	<c:if test="${not empty requestScope.club }">
		
		<p class="h3 text-center mb-4" style="font-weight: bold;">${requestScope.club.clubname}의 상세정보 </p>
		<table class="table table-bordered" style="width: 60%; margin: 0 auto;">
			<tr>
			    <td>동호회명</td>
			    <td>${requestScope.club.clubname}</td>
			</tr>
			<tr>
			    <td>회장아이디</td>
			    <td>${requestScope.club.fk_userid}</td>
			</tr>
			<tr>
			    <td>번호</td>
			    <td>${requestScope.club.clubtel}</td>
			</tr>
			<tr>
			    <td>체육관</td>
			    <td>${requestScope.club.clubgym}</td>
			</tr>
			<tr>
				<td>운영시간</td>
				<td>${requestScope.club.clubtime}</td>
			</tr>
			<tr>
			    <td>인원</td>
				<td>${requestScope.club.membercount}</td>
			</tr>
			<tr>
			    <td>비용</td>
				<td>${requestScope.club.clubpay}</td>
			</tr>
		
        </table>

	</c:if>

	<div class="text-center mt-5">
		<button type="button" class="btn btn-primary" onclick="javascript:location.href='${pageContext.request.contextPath}${requestScope.goBackURL}'">회원목록</button>
	</div>
</div>