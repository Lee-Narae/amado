<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String ctxPath = request.getContextPath();
%>

<div style="display: flex;">
    <h1>Inquiry List</h1>
    <table>
        <thead>
            <tr>
                <th>Inquiry ID</th>
                <th>Content</th>
                <th>User ID</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Date</th>
                <th>Status</th>
                <th>File</th>
            </tr>
        </thead>
        <tbody>
        	<c:if test="${not empty inquiryList}">
	            <c:forEach var="inquiry" items="${inquiryList}">
	                <tr>
	                    <td>${inquiry.inquiryseq}</td>
	                    <td>${inquiry.content}</td>
	                    <td>${inquiry.fk_userid}</td>
	                    <td>${inquiry.email}</td>
	                    <td>${inquiry.phone}</td>
	                    <td>${inquiry.registerdate}</td>
	                    <td>${inquiry.status}</td>
	                    <td>
	                        <c:choose>
	                            <c:when test="${not empty inquiry.inquiryfilevo.filename}">
	                                <a href="${pageContext.request.contextPath}/files/${inquiry.inquiryfilevo.filename}" target="_blank">Download</a>
	                            </c:when>
	                            <c:otherwise>No file</c:otherwise>
	                        </c:choose>
	                    </td>
	                </tr>
	            </c:forEach>
			</c:if>
			<c:if test="${empty inquiryList}">
				<tr>
					<td colspan="8">파일없다</td>
				</tr>
			</c:if>
        </tbody>
    </table>
</div>
