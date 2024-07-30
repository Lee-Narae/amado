<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String ctxPath = request.getContextPath();
%>

<style type="text/css">

.title {
width: 10%;
background-color: #0076d1;
color: white;
height: 40px;
align-content: center;
font-weight: bold;
border-radius: 20px;
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

	$(document).ready(function() {
		
		goReadInquiryAW();
		
		$("input:text[name='comment_text']").bind("keyup", function(e){
			if(e.keyCode == 13){ // 엔터를 했을 경우
				regComment();
			}
		});
		
		
		// 댓글 삭제
		$(document).on("click", "span#delComment", function(e){

			if(confirm('댓글을 삭제하시겠습니까?')){
		        const inquiryanswerseq = $(e.target).parent().parent().children("input#inquiryanswerseq").val();
		        const inquiryseq = "${requestScope.inquiryvo.inquiryseq}";
		        
//		        alert(inquiryanswerseq);
//		        alert(inquiryseq);
				
				$.ajax({
					url: "<%=ctxPath%>/admin/reg/delInquiryAW",
					type: "post",
					data: {"inquiryanswerseq": inquiryanswerseq, "inquiryseq":inquiryseq},
					dataType: "json",
					success: function(json){
						if(json.n == 1){
							goReadInquiryAW();
						}
					},
					error: function(request, status, error){
			               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			        }
				});
			
			}

		});
		
		// 댓글 수정
		$(document).on("click", "span#editComment", function(e){
			
			const inquiryanswerseq = $(e.target).parent().parent().children("input#inquiryanswerseq").val();
			const org_comment_text = $(e.target).parent().parent().children("span#comment_text").text();
//			alert(org_comment_text);

			$("span#editOrDel").hide();

			$(e.target).parent().parent().children("span#comment_text").html(`
			    <input type="text" id="comment_text_edit" name="comment_text_edit" maxlength="200" style="width: 70%; height: 70px;" value="\${org_comment_text}"/>&nbsp;&nbsp;
			    <button type="button" class="btn btn-primary btn-sm" onclick="commentEdit('\${inquiryanswerseq}')">수정하기</button>&nbsp;&nbsp;
			    <button type="button" class="btn btn-secondary btn-sm" onclick="cancelEditComment('\${org_comment_text}')">취소</button>
			`);


		});
		
		
		$(document).on("keyup", "input#comment_text_edit", function(e){
			if(e.keyCode == 13){
//				alert($(e.target).parent().parent().find("input#inquiryanswerseq").val());
				commentEdit($(e.target).parent().parent().find("input#inquiryanswerseq").val());
			}
		});
		
		
		
	}); // end of $(document).ready
	
	
	function commentEdit(inquiryanswerseq){

//		alert(inquiryanswerseq);
		
		const edit_comment_text = $("input#comment_text_edit").val().trim();

//		alert(edit_comment_text);
		
		$.ajax({ 
			url: "<%=ctxPath%>/admin/reg/editInquiryAW",
			data: {"edit_comment_text": edit_comment_text, "inquiryanswerseq": inquiryanswerseq},
			dataType: "json",
			type: "post",
			success: function(json){
				goReadInquiryAW();
			},
			error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
		});

	}

	function cancelEditComment(org_comment_text){
		$("span#editOrDel").show();
		$(event.target).parent().html(org_comment_text);
	}
	
	
	function regComment() {
		   
//		alert("확인");

			const comment_text = $("input:text[name='comment_text']").val();
			const inquiryseq = ${requestScope.inquiryvo.inquiryseq};
			
//			alert(inquiryseq);
			
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
			         
			         	emailWrite(comment_text, inquiryseq);
			         	
			        	 // 페이징 처리한 댓글 읽어오기
			         
			         $("input:text[name='comment_text']").val("");
			        	 
			      },
			      error: function(request, status, error){
			             alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			        }
			   });
			}
	}
	
	
	function emailWrite(comment_text, inquiryseq) {
		
		   const title = "${requestScope.inquiryvo.title}";
		   const searchtype_a = "${requestScope.inquiryvo.searchtype_a}";
		   const searchtype_b = "${requestScope.inquiryvo.searchtype_b}";
		   const email = "${requestScope.inquiryvo.email}";
		   const registerdate = "${requestScope.inquiryvo.registerdate}";
		   
		   const searchType = "${inquiryvo.searchtype_a == 1 && inquiryvo.searchtype_b == 1 ? '동호회 : 대관문의' : 
					            inquiryvo.searchtype_a == 1 && inquiryvo.searchtype_b == 2 ? '동호회 : 환불문의' :
					            inquiryvo.searchtype_a == 1 && inquiryvo.searchtype_b == 3 ? '동호회 : 기타문의' :
					            inquiryvo.searchtype_a == 2 && inquiryvo.searchtype_b == 1 ? '체육관 : 시설문의' :
					            inquiryvo.searchtype_a == 2 && inquiryvo.searchtype_b == 2 ? '체육관 : 예약문의' :
					            inquiryvo.searchtype_a == 2 && inquiryvo.searchtype_b == 3 ? '체육관 : 기타문의' :
					            inquiryvo.searchtype_a == 3 && inquiryvo.searchtype_b == 1 ? '플리마켓 : 결제문의' :
					            inquiryvo.searchtype_a == 3 && inquiryvo.searchtype_b == 2 ? '플리마켓 : 환불문의' :
					            inquiryvo.searchtype_a == 3 && inquiryvo.searchtype_b == 3 ? '플리마켓 : 기타문의' :
					            inquiryvo.searchtype_a == 4 && inquiryvo.searchtype_b == 1 ? '기타 : 일반문의' :
					            inquiryvo.searchtype_a == 4 && inquiryvo.searchtype_b == 2 ? '기타 : 환불문의' :
					            inquiryvo.searchtype_a == 4 && inquiryvo.searchtype_b == 3 ? '기타 : 기타문의' :
					            ''}";

			// alert(searchType);
		   // 메일 보내기
          $.ajax({
              url : "<%= ctxPath%>/admin/reg/emailWrite",
		      data: {"title": title,
		    	  	 "content": comment_text,
		    	     "inquiryseq": inquiryseq,
		    	     "email": email,
		    	     "registerdate": registerdate,
		    	     "searchType": searchType},
              type : "post",
              dataType:"json",
              success:function(json){
            	  // console.log("~~~ 확인용 : " + JSON.stringify(json));
                  // ~~~ 확인용 : {"result":1}
            	  
            	  goReadInquiryAW(); // 페이징 처리 안한 댓글 읽어오기
            	  
                  if(json.result == 1) {
                	  alert("메일보내기가 성공했습니다.");
                  }
                  else {
                	  alert("메일보내기가 실패했습니다.");
                  }
              },
              error: function(request, status, error){
  				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
  		      }
          });
		
	}
	
	

	function goReadInquiryAW() { // 페이징 처리 안한 댓글 읽어오기
	    $.ajax({
	        url: "<%=ctxPath%>/admin/reg/readInquiryAW",
	        data: {"inquiryseq": "${requestScope.inquiryvo.inquiryseq}"},
	        dataType: "json",
	        success: function(json){
	            let v_html = "";
	            
	            if(json.length > 0) {
	                $.each(json, function(index, item){
	                	v_html += "<div style='text-align: left; border: solid 0.5px #e3e3e3; height: 150px; padding: 10px;' class='mb-2'>";
	                	v_html += "<input id='inquiryanswerseq' type='hidden' value='" +item.inquiryanswerseq + "'/>";
	                	v_html += "<span style='font-size: 14pt; font-weight: bold;'>" +item.fk_userid +"&nbsp[관리자]</span>&nbsp;&nbsp;";
	                	v_html += "<span style='font-size: 14pt;'>" +item.registerdate+ "</span>";
	                	v_html += "<span id='comment_text' class='ml-3' style='font-size: 14pt; width: 100%; border: solid 0px red;'>" +item.content+ "</span>";
	                	v_html += "<span id='editOrDel' style='border: solid 0px red;' class='float-right'>";
	                	v_html += "<span id='editComment' class='commentBtn''>수정</span>&nbsp;|&nbsp;<span id='delComment' class='commentBtn'>삭제</span>";
	                	v_html += "</span>";
	                	v_html += "</div>";

	                });
	                
	            }
	            else {
	            	v_html += "답변이 없습니다.";
	            }
	            
	            $("div#comment").html(v_html);
	            
	            v_html = "";
	            v_html = "답변["+json.length+"]";
	            
	            $("div.awcnt").html(v_html);

	        },
	        error: function(request, status, error){
	            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
	        }
	    });
	} // end of goReadComment
	
	function goback(){
		const gobackurl = $("input[name='goBackURL']").val();
		location.href="<%=ctxPath%>"+gobackurl;
	}

</script>

	
<div id="wrap" style="width: 100%; min-height: 830px; padding: 5% 0;" align="center">


<div id="line" class="py-5" style="width: 80%; border: solid 0.5px #e3e3e3; min-height: auto;">
	<div id="top">
		<div class="tr row" style="align-content: center; margin-left: 12%; display: flex; margin-bottom: 0.5%;">
				<div class="title col-md-2" style="text-align: left;">제목</div>
				<div class="col-md-8" style="text-align: left; width: 70%; margin-top: 0.5%;" align="left">${requestScope.inquiryvo.title}</div>
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
		        	<span class="searchtype">동호회 : 대관문의</span>
		        </c:if>
		        <c:if test="${inquiryvo.searchtype_a == 1 && inquiryvo.searchtype_b == 2}">
		        	<span class="searchtype">동호회 : 환불문의</span>
		        </c:if>
		        <c:if test="${inquiryvo.searchtype_a == 1 && inquiryvo.searchtype_b == 3}">
		        	<span class="searchtype">동호회 : 기타문의</span>
		        </c:if>
		        
		        
		        <c:if test="${inquiryvo.searchtype_a == 2 && inquiryvo.searchtype_b == 1}">
		        	<span class="searchtype">체육관 : 시설문의</span>
		        </c:if>
		        <c:if test="${inquiryvo.searchtype_a == 2 && inquiryvo.searchtype_b == 2}">
		        	<span class="searchtype">체육관 : 예약문의</span>
		        </c:if>
		        <c:if test="${inquiryvo.searchtype_a == 2 && inquiryvo.searchtype_b == 3}">
		        	<span class="searchtype">체육관 : 기타문의</span>
		        </c:if>
		        
		        
		        <c:if test="${inquiryvo.searchtype_a == 3 && inquiryvo.searchtype_b == 1}">
		        	<span class="searchtype">플리마켓 : 결제문의</span>
		        </c:if>
		        <c:if test="${inquiryvo.searchtype_a == 3 && inquiryvo.searchtype_b == 2}">
		        	<span class="searchtype">플리마켓 : 환불문의</span>
		        </c:if>
		        <c:if test="${inquiryvo.searchtype_a == 3 && inquiryvo.searchtype_b == 3}">
		        	<span class="searchtype">플리마켓 : 기타문의</span>
		        </c:if>
		        
		        
		        <c:if test="${inquiryvo.searchtype_a == 4 && inquiryvo.searchtype_b == 1}">
		        	<span class="searchtype">기타 : 일반문의</span>
		        </c:if>
		        <c:if test="${inquiryvo.searchtype_a == 4 && inquiryvo.searchtype_b == 2}">
		        	<span class="searchtype">기타 : 환불문의</span>
		        </c:if>
		        <c:if test="${inquiryvo.searchtype_a == 4 && inquiryvo.searchtype_b == 3}">
		        	<span class="searchtype">기타 : 기타문의</span>
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
	${requestScope.inquiryvo.content}
	</div>
	<hr style="width: 75%;">
	
	
	<div align="left" class="awcnt" class="mb-1" style="margin-left: 12.5%; font-size: 11pt; font-weight: bold;">
	</div>
	<div id="comment" style="border: solid 0.5px #e3e3e3; padding: 2%; width: 75%;">

	</div>
	
	<div id="commentWrite" class="mt-3 p-3" style="border: solid 0.5px #e3e3e3; width: 75%" align="left">
		<input type="text" class="col-md-11" name="comment_text" maxlength="200" style="width: 87%; height: 70px;"/>
		<button type="button" class="btn btn-primary btn-lg float-right regComment" style="height: 70px; font-size: 16pt;" onclick="regComment()">등록하기</button>	
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

<input type="hidden" name="goBackURL" value="${requestScope.goBackURL}" />

</div>

