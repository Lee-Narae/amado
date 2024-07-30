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
	$("div#memberM").addClass("hover");
});
</script>


<div class="container pt-5 pb-5" style="min-height: 810px;">

	<c:if test="${empty requestScope.member }">
		존재하지 않는 회원입니다.<br>
	</c:if>
	
	<c:if test="${not empty requestScope.member }">
		<c:set var="mobile" value="${requestScope.member.mobile}" /> <%-- 변수 처리하기 --%>
		<p class="h3 text-center mb-4" style="font-weight: bold;">${requestScope.member.name}님의 회원 상세정보 </p>
		<table class="table table-bordered" style="width: 60%; margin: 0 auto;">
			<tr>
			    <td>아이디</td>
			    <td>${requestScope.member.userid}</td>
			</tr>
			<tr>
			    <td>회원명</td>
			    <td>${requestScope.member.name}</td>
			</tr>
			<tr>
			    <td>이메일</td>
			    <td>${requestScope.member.email}</td>
			</tr>
			<tr>
			    <td>휴대폰</td>
			    <td>${fn:substring(mobile, 0, 3)}-${fn:substring(mobile, 3, 7)}-${fn:substring(mobile, 7, 11)}</td>
			</tr>
			<tr>
				<td>우편번호</td>
				<td>${requestScope.member.postcode}</td>
			</tr>
			<tr>
			    <td>주소</td>
			    <td>${requestScope.member.address}&nbsp;
			   	    ${requestScope.member.detailaddress}&nbsp;
				    ${requestScope.member.extraaddress}
			    </td>
			</tr>
			<tr>
				<td>성별</td>
				<td>
					<c:choose>
						<c:when test="${requestScope.member.gender == '1'}">남</c:when>
						<c:otherwise>여</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
            <td>생년월일</td>
            <td>${requestScope.member.birthday}</td>
         </tr>
         <tr>
            <td>가입일자</td>
            <td>${requestScope.member.registerday}</td>
         </tr>
        </table>

	</c:if>

	<div class="text-center mt-5">
		<button type="button" class="btn btn-primary" onclick="javascript:location.href='${pageContext.request.contextPath}${requestScope.goBackURL}'">회원목록</button>
	</div>
</div>