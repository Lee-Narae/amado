<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
   String ctxPath = request.getContextPath();
%>

<style type="text/css">
.title {
width: 8%;
margin-left: 5%;
margin-right: 1%;
color: black;
height: 35px;
align-content: center;
font-weight: bold;
border-left: solid 3px #05203c;
}

.tr{
height: 50px;
padding-top: 0.4%;
}

.move:hover{
font-weight: bold;
color: #0066ff;
cursor: pointer;
}

.commentBtn {
font-size: 8pt;
color: gray;
}

.commentBtn:hover {
cursor: pointer;
opacity: 0.8;
}
</style>

<script type="text/javascript">
$(document).ready(function(){
	
	const frm = document.goViewFrm;
	frm.clubboardseq.value = '${requestScope.clubboardseq}';
	frm.goBackURL.value = '${requestScope.goBackURL}';
	if(${not empty requestScope.searchType}){ // 검색을 했을 경우
		frm.searchType.value = '${requestScope.searchType}';
		frm.searchWord.value = '${requestScope.searchWord}';
	}
	
	$("button.regComment").click(function(){
		viewComment();
	});
	
	$("input[name='comment_text']").keyup(function(e){
		if(e.keyCode == 13){
			viewComment();
		}
	});

	
	// 댓글 삭제
	$(document).on("click", "span#delComment", function(e){

		if(confirm('댓글을 삭제하시겠습니까?')){
			let clubboardcommentseq = $(e.target).parent().parent().find("input#commentseq").val();
			const clubboardseq = '${requestScope.cboard.clubboardseq}';
			
			//alert(clubboardcommentseq);
			
			$.ajax({
				url: "<%=ctxPath%>/club/delCBoardComment.do",
				type: "post",
				data: {"clubboardcommentseq": clubboardcommentseq, "clubboardseq":clubboardseq},
				dataType: "json",
				success: function(json){
					viewCommentOnly();
				},
				error: function(request, status, error){
		               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		        }
			});
		
		}

	});

	
	// 댓글 수정
	$(document).on("click", "span#editComment", function(e){
		
		const noticecommentseq = $(e.target).parent().parent().parent().find("input#commentseq").val();
		const org_comment_text = $(e.target).parent().parent().parent().find("div#comment_text").text();
		
		$("span#editOrDel").hide();
		$(e.target).parent().parent().parent().find("div#comment_text").html(`<input type="text" id="comment_text_edit" name="comment_text_edit" maxlength="200" style="width: 70%; height: 70px;" value="\${org_comment_text}"/>&nbsp;&nbsp;
																			  <button type="button" class="btn btn-primary btn-sm" onclick="commentEdit(\${noticecommentseq})">수정하기</button>&nbsp;&nbsp;
																			  <button type="button" class="btn btn-secondary btn-sm" onclick="cancelEditComment('\${org_comment_text}')">취소</button>`);
		
	});

	$(document).on("keyup", "input#comment_text_edit", function(e){
		if(e.keyCode == 13){
			commentEdit($(e.target).parent().parent().find("input#commentseq").val());
		}
	});

});


function commentEdit(clubboardcommentseq){

	const edit_comment_text = $(event.target).parent().find("input#comment_text_edit").val().trim();
	const commentseq = $(event.target).parent().parent().find("input#commentseq").val();

	$.ajax({
		url: "<%=ctxPath%>/club/editCBoardComment.do",
		data: {"edit_comment_text": edit_comment_text, "commentseq": commentseq},
		dataType: "json",
		type: "post",
		success: function(json){
			viewCommentOnly();
		},
		error: function(request, status, error){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
        }
	});

}


function goPrevOrNext(seq){
	
	let clubseq = '${requestScope.clubseq}';
	
	const frm2 = document.goViewFrm;
	frm2.clubboardseq.value = seq;
	frm2.clubseq.value = clubseq; //추가
	frm2.method = "post";
	frm2.submit();
}

function goback(){
	const gobackurl = $("input[name='goBackURL']").val();
	location.href="<%=ctxPath%>"+gobackurl;
}

function viewComment(){
	
	if($("input[name='comment_text']").val().trim() == ''){
		alert('내용을 입력하세요.');
	}
	
	else {
		
		const comment_text = $("input[name='comment_text']").val().trim();
		const clubboardseq = '${requestScope.cboard.clubboardseq}';
		
		$.ajax({
			url: "<%=ctxPath%>/club/regComment.do",
			data: {"comment_text": comment_text, "clubboardseq": clubboardseq},
			type: "post",
			dataType: "json",
			success: function(json){
				
				let v_html = ``;
				
				if(json.length > 0){
					
					$.each(json, function(index, item){
						v_html += `<div style="display: flex;">
										<div class="mr-3">`;
										
						if(item.memberimg != null){
							v_html += `<img width="50" height="50" style="border-radius: 50px;" src="<%=ctxPath%>/resources/images/\${item.memberimg}"/>`;
						}
						else {
							v_html += `<img width="50" height="50" style="border-radius: 50px;" src="<%=ctxPath%>/resources/images/기본이미지.png"/>`;
						}
						
						v_html += `</div>
									<div align="left" style="width: 80%;">
									<input id="commentseq" type="hidden" value="\${item.clubboardcommentseq}"/>
									<span style="font-size: 10pt; font-weight: bold;">\${item.fk_userid }</span>&nbsp;&nbsp;<span style="font-size: 10pt;">\${item.registerdate}</span>
										<span id="editOrDel">`;
										
						if(item.fk_userid == '${sessionScope.loginuser.userid}'){
							v_html += `<span id="editComment" class="commentBtn" style="margin-left: 3%;">수정</span>&nbsp;|&nbsp;<span id="delComment" class="commentBtn">삭제</span>`;
						}			
										
						v_html += `</span>
							<div style="text-align: left;">\${item.comment_text }</div>
							</div>
						</div>`;					
												
													
						if(index < json.length-1){
							v_html += `<hr>`;
						}
					
					});
				}
				
				$("div#comment").html(v_html);
				$("input[name='comment_text']").val('');
				
			},
			error: function(request, status, error){
	               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
		});
		
	}		
	
}


function viewCommentOnly(){
	
	const clubboardseq = '${requestScope.cboard.clubboardseq}';
	
	$.ajax({
		url: "<%=ctxPath%>/club/viewCommentOnly.do",
		data: {"clubboardseq": clubboardseq},
		type: "get",
		dataType: "json",
		success: function(json){
			
			let v_html = ``;
			
			if(json.length > 0){
				
				$.each(json, function(index, item){
					
					v_html += `<div style="display: flex;">
									<div class="mr-3">`;
									
					if(item.memberimg != null){
						v_html += `<img width="50" height="50" style="border-radius: 50px;" src="<%=ctxPath%>/resources/images/\${item.memberimg}"/>`;
					}
					else {
						v_html += `<img width="50" height="50" style="border-radius: 50px;" src="<%=ctxPath%>/resources/images/기본이미지.png"/>`;
					}
					
					v_html += `</div>
								<div align="left" style="width: 80%;">
								<input id="commentseq" type="hidden" value="\${item.noticecommentseq}"/>
								<span style="font-size: 10pt; font-weight: bold;">\${item.fk_userid }</span>&nbsp;&nbsp;<span style="font-size: 10pt;">\${item.registerdate}</span>
									<span id="editOrDel">`;
									
					if(item.fk_userid == '${sessionScope.loginuser.userid}'){
						v_html += `<span id="editComment" class="commentBtn" style="margin-left: 3%;">수정</span>&nbsp;|&nbsp;<span id="delComment" class="commentBtn">삭제</span>`;
					}			
									
					v_html += `</span>
						<div style="text-align: left;">\${item.comment_text }</div>
						</div>
					</div>`;					
											
												
					if(index < json.length-1){
						v_html += `<hr>`;
					}
				
				});
			}
			
			$("div#comment").html(v_html);
			
		},
		error: function(request, status, error){
               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
        }
	});
}


</script>



<div id="wrap" style="width: 100%; min-height: 830px; padding: 5% 0;" align="center">

<c:if test="${sessionScope.loginuser.userid == requestScope.cboard.fk_userid}">
<div align="right" class="mb-2" style="padding-right: 10%;">
<button type="button" class="btn btn-warning" onclick="editNotice(${requestScope.cboard.clubboardseq})">수정하기</button>&nbsp;&nbsp;
<button type="button" class="btn btn-light" onclick="delNotice(${requestScope.cboard.clubboardseq})">삭제하기</button>
</div>
</c:if>
<div id="line" class="py-5" style="width: 80%; border: solid 0.5px #e3e3e3; min-height: auto;">
	<div id="top">
		<div class="tr" style="align-content: center; margin-left: 8%; display: flex; margin-bottom: 0.5%;">
			<div class="title">제목</div>
			<div style="width: 70%; margin-top: 0.5%;" align="left">${requestScope.cboard.title}</div>
		</div>
		<div class="tr" style="align-content: center; margin-left: 8%; display: flex; margin-bottom: 0.5%;">
			<div class="title">첨부파일</div>
			<c:if test="${not empty requestScope.cboard.orgfilename}"><div style="width: 70%; margin-top: 0.5%;" align="left"><a href="noticeAttachDownload.do?noticeseq=${requestScope.cboard.noticeseq}">${requestScope.cboard.orgfilename}</a></div></c:if>
			<c:if test="${empty requestScope.cboard.orgfilename}"><div style="width: 70%; margin-top: 0.5%;" align="left">첨부파일이 없습니다.</div></c:if>
		</div>
		<div class="tr" style="align-content: center; margin-left: 8%; display: flex; margin-bottom: 0.5%;">
			<div class="title">조회수</div>
			<div style="width: 70%; margin-top: 0.5%;" align="left">${requestScope.cboard.viewcount}</div>
		</div> 
		<div class="tr" style="align-content: center; margin-left: 8%; display: flex; margin-bottom: 0.5%;">
			<div class="title">작성자</div>
			<div style="width: 70%; margin-top: 0.5%;" align="left">${requestScope.cboard.fk_userid}</div>
		</div>
		<div class="tr" style="align-content: center; margin-left: 8%; display: flex; margin-bottom: 0.5%;">
			<div class="title">작성일자</div>
			<div style="width: 70%; margin-top: 0.5%;" align="left">${requestScope.cboard.registerdate}</div>
		</div>
	</div>
	<hr style="width: 75%;">
	<div id="bottom" style="border: solid 0.5px #e3e3e3; width: 75%; padding: 5% 0;">
	${requestScope.cboard.content}
	</div>
	<hr style="width: 75%;">
	<div align="left" class="mb-1" style="margin-left: 12.5%; font-size: 11pt; font-weight: bold;">댓글
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
						<input id="commentseq" type="hidden" value="${comment.clubboardcommentseq}"/>
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
		<c:if test="${empty requestScope.commentList}">댓글이 없습니다.</c:if>
	</div>
	<div id="commentWrite" class="mt-3 p-3" style="border: solid 0.5px #e3e3e3; width: 75%" align="left">
		<input type="text" name="comment_text" maxlength="200" style="width: 87%; height: 70px;"/>
		<button type="button" class="btn btn-info btn-lg ml-3 regComment" style="font-size: 13pt;">등록하기</button>	
	</div>
	
	<div id="pre_next_notice" class="mt-3 p-3" style="width: 75%" align="left">
		<div id="prev">
		<span style="font-weight: bold;">이전 글</span>&nbsp;&nbsp;&nbsp;
		<c:if test="${not empty requestScope.cboard.previoustitle}"><span class="move" onclick="goPrevOrNext('${requestScope.cboard.previousseq}')">${requestScope.cboard.previoustitle}</span></c:if>
		<c:if test="${empty requestScope.cboard.previoustitle}"><span>다음 글이 없습니다.</span></c:if>
		</div>
		<div id="next">
		<span style="font-weight: bold;">다음 글</span>&nbsp;&nbsp;&nbsp;
		<c:if test="${not empty requestScope.cboard.nexttitle}"><span class="move" onclick="goPrevOrNext('${requestScope.cboard.nextseq}')">${requestScope.cboard.nexttitle}</span></c:if>
		<c:if test="${empty requestScope.cboard.nexttitle}"><span>이전 글이 없습니다.</span></c:if>
		</div>
	</div>
	
	<div align="right" style="margin-right: 12.5%;" onclick="goback()"><button type="button" class="btn btn-light">목록으로 돌아가기</button></div>
</div>

<form name="goViewFrm">
	<input type="hidden" name="clubseq" />
	<input type="hidden" name="clubboardseq" />
	<input type="hidden" name="goBackURL" />
	<input type="hidden" name="searchType" />
	<input type="hidden" name="searchWord" />
</form>
</div>
