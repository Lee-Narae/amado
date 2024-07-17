<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
   String ctxPath = request.getContextPath();
%>


<style type="text/css">


	span.subject {
	    display: inline-block;
	    max-width: 450px; /* 최대 너비를 적절히 설정 */
	    overflow: hidden;
	    text-overflow: ellipsis;
	    white-space: nowrap;
	}	


/* 	.subject:hover {
		background: red;
	} */
    
    th {
    	background-color: none;
    	
    }
    
    .subjectStyle {font-weight: bold;
                   color: navy;
                   cursor: pointer; }
                   
    a {text-decoration: none !important;} /* 페이지바의 a 태그에 밑줄 없애기 */
    
</style>

<script type="text/javascript">

$(document).ready(function() {
	
});

</script>



<div id='container'>
	<div>00동호회 게시판</div>
	<div style="display: flex;">
		<table class="table table-bordered">
			<thead>
				<tr>
					<th style="width: 70px; text-align: center;">글번호</th>
					<th style="width: 300px; text-align: center;">제목</th>
					<th style="width: 70px; text-align: center;">작성자아이디</th>
					<th style="width: 150px; text-align: center;">작성일자</th>
					<th style="width: 60px; text-align: center;">조회수</th>
				</tr>
			</thead>

			<tbody>
			
				<c:if test="${not empty requestScope.boardPagingList}">
					<c:forEach var="boardvo" items="${requestScope.boardPagingList}">
						<c:if test="${boardvo.fk_sportseq == 1}">
							<c:if test="${empty boardvo.filename}">
							<tr>
								<td align="center">${boardvo.boardseq}</td>
								<td>
									<c:if test="${boardvo.commentcount > 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}<span class="badge badge-light">[${boardvo.commentcount}]</span></span>
									</c:if>
									<c:if test="${boardvo.commentcount == 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}</span>
									</c:if>
								</td>
								<td align="center">${boardvo.fk_userid}</td>
								<td align="center">축구</td>
								<td align="center">${boardvo.registerdate}</td>
								<td align="center">${boardvo.viewcount}</td>
							</tr>
							</c:if>
						</c:if>		
						<c:if test="${boardvo.fk_sportseq == 1}">
							<c:if test="${not empty boardvo.filename}">
							<tr>
								<td align="center">${boardvo.boardseq}</td>
								<td>
									<c:if test="${boardvo.commentcount > 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}<span class="badge badge-light">[${boardvo.commentcount}]</span></span>&nbsp;<img src="<%= ctxPath%>/resources/images/disk.gif" />
									</c:if>
									<c:if test="${boardvo.commentcount == 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}</span>&nbsp;<img src="<%= ctxPath%>/resources/images/disk.gif" />
									</c:if>
								</td>
								<td align="center">${boardvo.fk_userid}</td>
								<td align="center">축구</td>
								<td align="center">${boardvo.registerdate}</td>
								<td align="center">${boardvo.viewcount}</td>
							</tr>
							</c:if>
						</c:if>		
									
						<c:if test="${boardvo.fk_sportseq == 2}">
							<c:if test="${empty boardvo.filename}">
							<tr>
								<td align="center">${boardvo.boardseq}</td>
								<td>
									<c:if test="${boardvo.commentcount > 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}<span class="badge badge-light">[${boardvo.commentcount}]</span></span>
									</c:if>
									<c:if test="${boardvo.commentcount == 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}</span>
									</c:if>
								</td>
								<td align="center">${boardvo.fk_userid}</td>
								<td align="center">야구</td>
								<td align="center">${boardvo.registerdate}</td>
								<td align="center">${boardvo.viewcount}</td>
							</tr>
							</c:if>
							<c:if test="${not empty boardvo.filename}">
							<tr>
								<td align="center">${boardvo.boardseq}</td>
								<td>
									<c:if test="${boardvo.commentcount > 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}<span class="badge badge-light">[${boardvo.commentcount}]</span></span>&nbsp;<img src="<%= ctxPath%>/resources/images/disk.gif" />
									</c:if>
									<c:if test="${boardvo.commentcount == 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}</span>&nbsp;<img src="<%= ctxPath%>/resources/images/disk.gif" />
									</c:if>
								</td>
								<td align="center">${boardvo.fk_userid}</td>
								<td align="center">야구</td>
								<td align="center">${boardvo.registerdate}</td>
								<td align="center">${boardvo.viewcount}</td>
							</tr>
							</c:if>
						</c:if>
						
						<c:if test="${boardvo.fk_sportseq == 3}">
							<c:if test="${empty boardvo.filename}">
							<tr>
								<td align="center">${boardvo.boardseq}</td>
								<td>
									<c:if test="${boardvo.commentcount > 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}<span class="badge badge-light">[${boardvo.commentcount}]</span></span>
									</c:if>
									<c:if test="${boardvo.commentcount == 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}</span>
									</c:if>
								</td>
								<td align="center">${boardvo.fk_userid}</td>
								<td align="center">배구</td>
								<td align="center">${boardvo.registerdate}</td>
								<td align="center">${boardvo.viewcount}</td>
							</tr>
							</c:if>
							<c:if test="${not empty boardvo.filename}">
							<tr>
								<td align="center">${boardvo.boardseq}</td>
								<td>
									<c:if test="${boardvo.commentcount > 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}<span class="badge badge-light">[${boardvo.commentcount}]</span></span>&nbsp;<img src="<%= ctxPath%>/resources/images/disk.gif" />
									</c:if>
									<c:if test="${boardvo.commentcount == 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}</span>&nbsp;<img src="<%= ctxPath%>/resources/images/disk.gif" />
									</c:if>
								</td>
								<td align="center">${boardvo.fk_userid}</td>
								<td align="center">배구</td>
								<td align="center">${boardvo.registerdate}</td>
								<td align="center">${boardvo.viewcount}</td>
							</tr>
							</c:if>
						</c:if>
						
						<c:if test="${boardvo.fk_sportseq == 4}">
							<c:if test="${empty boardvo.filename}">
							<tr>
								<td align="center">${boardvo.boardseq}</td>
								<td>
									<c:if test="${boardvo.commentcount > 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}<span class="badge badge-light">[${boardvo.commentcount}]</span></span>
									</c:if>
									<c:if test="${boardvo.commentcount == 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}</span>
									</c:if>
								</td>
								<td align="center">${boardvo.fk_userid}</td>
								<td align="center">농구</td>
								<td align="center">${boardvo.registerdate}</td>
								<td align="center">${boardvo.viewcount}</td>
							</tr>
							</c:if>
							<c:if test="${not empty boardvo.filename}">
							<tr>
								<td align="center">${boardvo.boardseq}</td>
								<td>
									<c:if test="${boardvo.commentcount > 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}<span class="badge badge-light">[${boardvo.commentcount}]</span></span>&nbsp;<img src="<%= ctxPath%>/resources/images/disk.gif" />
									</c:if>
									<c:if test="${boardvo.commentcount == 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}</span>&nbsp;<img src="<%= ctxPath%>/resources/images/disk.gif" />
									</c:if>
								</td>
								<td align="center">${boardvo.fk_userid}</td>
								<td align="center">농구</td>
								<td align="center">${boardvo.registerdate}</td>
								<td align="center">${boardvo.viewcount}</td>
							</tr>
							</c:if>
						</c:if>
						
						<c:if test="${boardvo.fk_sportseq == 6}">
							<c:if test="${empty boardvo.filename}">
							<tr>
								<td align="center">${boardvo.boardseq}</td>
								<td>
									<c:if test="${boardvo.commentcount > 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}<span class="badge badge-light">[${boardvo.commentcount}]</span></span>
									</c:if>
									<c:if test="${boardvo.commentcount == 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}</span>
									</c:if>
								</td>
								<td align="center">${boardvo.fk_userid}</td>
								<td align="center">테니스</td>
								<td align="center">${boardvo.registerdate}</td>
								<td align="center">${boardvo.viewcount}</td>
							</tr>
							</c:if>
							<c:if test="${not empty boardvo.filename}">
							<tr>
								<td align="center">${boardvo.boardseq}</td>
								<td>
									<c:if test="${boardvo.commentcount > 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}<span class="badge badge-light">[${boardvo.commentcount}]</span></span>&nbsp;<img src="<%= ctxPath%>/resources/images/disk.gif" />
									</c:if>
									<c:if test="${boardvo.commentcount == 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}</span>&nbsp;<img src="<%= ctxPath%>/resources/images/disk.gif" />
									</c:if>
								</td>
								<td align="center">${boardvo.fk_userid}</td>
								<td align="center">테니스</td>
								<td align="center">${boardvo.registerdate}</td>
								<td align="center">${boardvo.viewcount}</td>
							</tr>
							</c:if>
						</c:if>
						
						<c:if test="${boardvo.fk_sportseq == 7}">
							<c:if test="${empty boardvo.filename}">
							<tr>
								<td align="center">${boardvo.boardseq}</td>
								<td>
									<c:if test="${boardvo.commentcount > 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}<span class="badge badge-light">[${boardvo.commentcount}]</span></span>
									</c:if>
									<c:if test="${boardvo.commentcount == 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}</span>
									</c:if>
								</td>
								<td align="center">${boardvo.fk_userid}</td>
								<td align="center">볼링</td>
								<td align="center">${boardvo.registerdate}</td>
								<td align="center">${boardvo.viewcount}</td>
							</tr>
							</c:if>
							<c:if test="${not empty boardvo.filename}">
							<tr>
								<td align="center">${boardvo.boardseq}</td>
								<td>
									<c:if test="${boardvo.commentcount > 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}<span class="badge badge-light">[${boardvo.commentcount}]</span></span>&nbsp;<img src="<%= ctxPath%>/resources/images/disk.gif" />
									</c:if>
									<c:if test="${boardvo.commentcount == 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}</span>&nbsp;<img src="<%= ctxPath%>/resources/images/disk.gif" />
									</c:if>
								</td>
								<td align="center">${boardvo.fk_userid}</td>
								<td align="center">볼링</td>
								<td align="center">${boardvo.registerdate}</td>
								<td align="center">${boardvo.viewcount}</td>
							</tr>
							</c:if>
						</c:if>
						
						<c:if test="${boardvo.fk_sportseq == 5}">
							<c:if test="${empty boardvo.filename}">
							<tr>
								<td align="center">${boardvo.boardseq}</td>
								<td>
									<c:if test="${boardvo.commentcount > 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}<span class="badge badge-light">[${boardvo.commentcount}]</span></span>
									</c:if>
									<c:if test="${boardvo.commentcount == 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}</span>
									</c:if>
								</td>
								<td align="center">${boardvo.fk_userid}</td>
								<td align="center">족구</td>
								<td align="center">${boardvo.registerdate}</td>
								<td align="center">${boardvo.viewcount}</td>
							</tr>
							</c:if>
							<c:if test="${not empty boardvo.filename}">
							<tr>
								<td align="center">${boardvo.boardseq}</td>
								<td>
									<c:if test="${boardvo.commentcount > 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}<span class="badge badge-light">[${boardvo.commentcount}]</span></span>&nbsp;<img src="<%= ctxPath%>/resources/images/disk.gif" />
									</c:if>
									<c:if test="${boardvo.commentcount == 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}</span>&nbsp;<img src="<%= ctxPath%>/resources/images/disk.gif" />
									</c:if>
								</td>
								<td align="center">${boardvo.fk_userid}</td>
								<td align="center">족구</td>
								<td align="center">${boardvo.registerdate}</td>
								<td align="center">${boardvo.viewcount}</td>
							</tr>
							</c:if>
						</c:if>
						
						<c:if test="${boardvo.fk_sportseq == 8}">
							<c:if test="${empty boardvo.filename}">
							<tr>
								<td align="center">${boardvo.boardseq}</td>
								<td>
									<c:if test="${boardvo.commentcount > 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}<span class="badge badge-light">[${boardvo.commentcount}]</span></span>
									</c:if>
									<c:if test="${boardvo.commentcount == 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}</span>
									</c:if>
								</td>
								<td align="center">${boardvo.fk_userid}</td>
								<td align="center">배드민턴</td>
								<td align="center">${boardvo.registerdate}</td>
								<td align="center">${boardvo.viewcount}</td>
							</tr>
							</c:if>
							<c:if test="${not empty boardvo.filename}">
							<tr>
								<td align="center">${boardvo.boardseq}</td>
								<td>
									<c:if test="${boardvo.commentcount > 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}<span class="badge badge-light">[${boardvo.commentcount}]</span></span>&nbsp;<img src="<%= ctxPath%>/resources/images/disk.gif" />
									</c:if>
									<c:if test="${boardvo.commentcount == 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}</span>&nbsp;<img src="<%= ctxPath%>/resources/images/disk.gif" />
									</c:if>
								</td>
								<td align="center">${boardvo.fk_userid}</td>
								<td align="center">배드민턴</td>
								<td align="center">${boardvo.registerdate}</td>
								<td align="center">${boardvo.viewcount}</td>
							</tr>
							</c:if>
						</c:if>
						
					</c:forEach>
				</c:if>

				<c:if test="${empty requestScope.boardPagingList}">
					<tr>
						<td colspan="6">데이터가 없습니다.</td>
					</tr>
				</c:if>

			</tbody>
		</table>
		
		<div style="display: flex;"  class="float-right">
			<button type="button" class="btn btn-secondary btn-sm" style="margin: auto 0 auto auto;" onclick="goAdd()">글쓰기</button>
		</div>
		
		<nav aria-label="Page navigation example">
			<ul class="pagination justify-content-center">${requestScope.pageBar}</ul>
	    </nav>  			
	</div>
	
</div>
<%-- #132. 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후
     //    사용자가 "검색된결과목록보기" 버튼을 클릭했을때 돌아갈 페이지를 알려주기 위해
     //    현재 페이지 주소를 뷰단으로 넘겨준다. 
--%>
<form name="goViewFrm">
	<input type="hidden" name="boardseq" /> 
	<input type="hidden" name="goBackURL" /> 
</form>






