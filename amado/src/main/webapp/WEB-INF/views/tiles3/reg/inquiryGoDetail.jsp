<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String ctxPath = request.getContextPath();
%>

<style type="text/css">

</style>

<script type="text/javascript">

	$(document).ready(function() {
		
		$("input:text[name='comment_text']").bind("keyup", function(e){
			if(e.keyCode == 13){ // 엔터를 했을 경우
				regComment();
			}
		});
		
		
	}); // end of $(document).ready
	
	
	function regComment(inquiryseq) {
		   
//		alert("확인");

			const comment_text = $("input:text[name='comment_text']").val();
			
//			alert(comment_text);
			
			if(comment_text == null || comment_text == "") {
				alert("문의답글의 내용이 없습니다.");
			}
			
			if(comment_text != null && comment_text != "") {
		    
			   $.ajax({
			      url: "<%=ctxPath%>/admin/reg/addInquiryAD",
			      data: {"content": comment_text,
			    	     "inquiryseq": inquiryseq},
			      type: "post",     
			      dataType: "json",
			      success: function(json){
			         console.log(JSON.stringify(json));
			         
			        	 // goReadComment(); // 페이징 처리 안한 댓글 읽어오기
			        	 // 페이징 처리한 댓글 읽어오기
			         
			         $("input:text[name='comment_text']").val("");
			        	 
			      },
			      error: function(request, status, error){
			             alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			        }
			   });
			}
	}

</script>

	
<div id="wrap" style="width: 100%; min-height: 830px; padding: 5% 0;" align="center">


<div id="line" class="py-5" style="width: 80%; border: solid 0.5px #e3e3e3; min-height: auto;">
	<div id="top">
		<div class="tr row" style="align-content: center; margin-left: 12%; display: flex; margin-bottom: 0.5%;">
				<div class="title col-md-2" style="text-align: left;">내용</div>
				<div class="col-md-8" style="text-align: left; width: 70%; margin-top: 0.5%;" align="left">${requestScope.inquiryvo.content}</div>
		</div>
		<div class="tr row" style="align-content: center; margin-left: 12%; display: flex; margin-bottom: 0.5%;">
			<div class="title col-md-2" style="text-align: left;">첨부파일</div>
			<c:if test="${not empty requestScope.inquiryfileList}">
				<div class="col-md-10" style="text-align: left; width: 70%; margin-top: 0.5%;" align="left">
					<c:forEach var="inquiryFileVO" items="${requestScope.inquiryfileList}">
					<div class="row mt-1">
						<span class="col-md-4">파일명 : <a style="font-weight: bolder; cursor: pointer;" href="<%= ctxPath%>/inquirydownload.do?inquiryseq=${requestScope.inquiryvo.inquiryseq}&orgfilename=${inquiryFileVO.orgfilename}">${inquiryFileVO.orgfilename}</a>&nbsp;&nbsp;&nbsp;</span><span class="col-md-4">파일크기 : ${inquiryFileVO.filesize}byte<br></span>
					</div>
					</c:forEach>
				</div>
			</c:if>
			<c:if test="${empty requestScope.inquiryfileList}">
				<div class="col-md-10" style="text-align: left; width: 70%; margin-top: 0.5%;" align="left">
					첨부파일이 없습니다.
				</div>
			</c:if>
		</div>
		<div class="tr row" style="align-content: center; margin-left: 12%; display: flex; margin-bottom: 0.5%;">
			<div class="title col-md-2" style="text-align: left;">문의유형</div>
			<div class="col-md-10" style="text-align: left; width: 70%; margin-top: 0.5%;" align="left">
	       	   
	       	    <c:if test="${inquiryvo.searchtype_a == 1 && inquiryvo.searchtype_b == 1}">
		        	<span>동호회 : 대관문의</span>
		        </c:if>
		        <c:if test="${inquiryvo.searchtype_a == 1 && inquiryvo.searchtype_b == 2}">
		        	<span>동호회 : 환불문의</span>
		        </c:if>
		        <c:if test="${inquiryvo.searchtype_a == 1 && inquiryvo.searchtype_b == 3}">
		        	<span>동호회 : 기타문의</span>
		        </c:if>
		        
		        
		        <c:if test="${inquiryvo.searchtype_a == 2 && inquiryvo.searchtype_b == 1}">
		        	<span>체육관 : 시설문의</span>
		        </c:if>
		        <c:if test="${inquiryvo.searchtype_a == 2 && inquiryvo.searchtype_b == 2}">
		        	<span>체육관 : 예약문의</span>
		        </c:if>
		        <c:if test="${inquiryvo.searchtype_a == 2 && inquiryvo.searchtype_b == 3}">
		        	<span>체육관 : 기타문의</span>
		        </c:if>
		        
		        
		        <c:if test="${inquiryvo.searchtype_a == 3 && inquiryvo.searchtype_b == 1}">
		        	<span>플리마켓 : 참가문의</span>
		        </c:if>
		        <c:if test="${inquiryvo.searchtype_a == 3 && inquiryvo.searchtype_b == 2}">
		        	<span>플리마켓 : 환불문의</span>
		        </c:if>
		        <c:if test="${inquiryvo.searchtype_a == 3 && inquiryvo.searchtype_b == 3}">
		        	<span>플리마켓 : 기타문의</span>
		        </c:if>
		        
		        
		        <c:if test="${inquiryvo.searchtype_a == 4 && inquiryvo.searchtype_b == 1}">
		        	<span>기타 : 일반문의</span>
		        </c:if>
		        <c:if test="${inquiryvo.searchtype_a == 4 && inquiryvo.searchtype_b == 2}">
		        	<span>기타 : 환불문의</span>
		        </c:if>
		        <c:if test="${inquiryvo.searchtype_a == 4 && inquiryvo.searchtype_b == 3}">
		        	<span>기타 : 기타문의</span>
		        </c:if>
		        
			</div>
		</div>
		<div class="tr row" style="align-content: center; margin-left: 12%; display: flex; margin-bottom: 0.5%;">
			<div class="title col-md-2" style="text-align: left;">작성일자</div>
			<div class="col-md-10" style="text-align: left; width: 70%; margin-top: 0.5%;" align="left">${requestScope.inquiryvo.registerdate}</div>
		</div>
	</div>
	<hr style="width: 75%;">
	<div id="bottom" style="border: solid 0.5px #e3e3e3; width: 75%; padding: 5% 0;">
	${requestScope.notice.content}
	</div>
	<hr style="width: 75%;">
	
	
	<div align="left" class="mb-1" style="margin-left: 12.5%; font-size: 11pt; font-weight: bold;">답변
	<c:if test="${not empty requestScope.commentList}">[${requestScope.commentCount}]</c:if>
	<c:if test="${empty requestScope.commentList}">[0]</c:if>
	</div>
	<div id="comment" style="border: solid 0.5px #e3e3e3; padding: 2%; width: 75%;">
		<c:if test="${not empty requestScope.commentList}">
			<c:forEach var="comment" items="${requestScope.commentList}" varStatus="status">
				<div style="display: flex;">
					<div class="mr-3">
						<c:if test="${comment.memberimg != null}"><img width="50" height="50" style="border-radius: 50px;" src="<%=ctxPath%>/resources/images/${comment.memberimg}"/></c:if>
						<c:if test="${comment.memberimg == null}"><img width="50" height="50" style="border-radius: 50px;" src="<%=ctxPath%>/resources/images/기본이미지.png"/></c:if>
					</div>
					<div align="left" style="width: 100%;">
						<input id="commentseq" type="hidden" value="${comment.noticecommentseq}"/>
						<span style="font-size: 10pt; font-weight: bold;">${comment.fk_userid }</span>&nbsp;&nbsp;<span style="font-size: 10pt;">${comment.registerdate}</span>
							<span id="editOrDel">
								<c:if test="${comment.fk_userid == sessionScope.loginuser.userid}">
									<span id="editComment" class="commentBtn" style="margin-left: 3%;">수정</span>&nbsp;|&nbsp;<span id="delComment" class="commentBtn">삭제</span>
								</c:if>
							</span>
						<div id="comment_text" style="text-align: left; width: 100%;">${comment.comment_text }</div>
					</div>
				</div>
				<c:if test="${status.index < requestScope.commentList.size()-1}"><hr></c:if>
			</c:forEach>
		</c:if>
		<c:if test="${empty requestScope.commentList}">답변이 없습니다.</c:if>
	</div>
	
	<div id="commentWrite" class="mt-3 p-3" style="border: solid 0.5px #e3e3e3; width: 75%" align="left">
		<input type="text" name="comment_text" maxlength="200" style="width: 87%; height: 70px;"/>
		<button type="button" class="btn btn-primary btn-lg ml-3 regComment" style="font-size: 13pt;" onclick="regComment('${inquiryvo.inquiryseq}')">등록하기</button>	
	</div>
	
	<div id="pre_next_notice" class="mt-3 p-3" style="width: 75%" align="left">
		<div id="prev">
		<span style="font-weight: bold;">이전 글</span>&nbsp;&nbsp;&nbsp;
		<c:if test="${not empty requestScope.notice.previoustitle}"><span class="move" onclick="goPrevOrNext('${requestScope.notice.previousseq}')">${requestScope.notice.previoustitle}</span></c:if>
		<c:if test="${empty requestScope.notice.previoustitle}"><span>다음 글이 없습니다.</span></c:if>
		</div>
		<div id="next">
		<span style="font-weight: bold;">다음 글</span>&nbsp;&nbsp;&nbsp;
		<c:if test="${not empty requestScope.notice.nexttitle}"><span class="move" onclick="goPrevOrNext('${requestScope.notice.nextseq}')">${requestScope.notice.nexttitle}</span></c:if>
		<c:if test="${empty requestScope.notice.nexttitle}"><span>이전 글이 없습니다.</span></c:if>
		</div>
	</div>
	
	<div align="right" style="margin-right: 12.5%;" onclick="goback()"><button type="button" class="btn btn-light">목록으로 돌아가기</button></div>
</div>	

</div>