<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%
	String ctxPath = request.getContextPath();
%>

<style type="text/css">
span.move {
	cursor: pointer;
	color: navy;
}

.moveColor {
	color: #660029;
	font-weight: bold;
	background-color: #ffffe6;
}

th.comment,
td.comment {text-align: center;}

a {
	text-decoration: none !important;
}

    /* 버튼 스타일 */
    .float-right {
        float: right;
        margin-left: 10px; /* 버튼 사이 간격 조정 */
    }

    /* 완료 버튼의 기본 및 마우스 오버 배경색 */
    #btnComplete, #btnComplete2 {
        background-color: transparent; /* 기본 배경색 투명 */
        border: 1px solid lightgray; /* 테두리 추가 */
        border-radius: 5px; /* 둥근 테두리 설정 */
        padding: 8px 16px; /* 내부 여백 설정 */
        color: black;
        cursor: pointer;
        transition: background-color 0.3s ease; /* 배경색 변경에 애니메이션 효과 적용 */
    }

    #btnComplete:hover {
        background-color: lightblue; /* 마우스 오버 시 배경색 변경 */
    }

    /* 취소 버튼 스타일 */
    #btnCancel {
        background-color: transparent; /* 기본 배경색 투명 */
        border: 1px solid lightgray; /* 테두리 추가 */
        border-radius: 5px; /* 둥근 테두리 설정 */
        padding: 8px 16px; /* 내부 여백 설정 */
        color: black;
        cursor: pointer;
    }

    #btnCancel:hover {
        background-color: lightgray; /* 마우스 오버 시 배경색 변경 */
    }
    
    .hidden {
        display: none;
    }    

.profile-img {
      width: 35px; /* 원하는 너비 */
      height: 35px; /* 원하는 높이 */
      border-radius: 50%; /* 원형으로 만들기 */
      object-fit: cover; /* 이미지를 컨테이너에 맞추어 자르기 */
  }

</style>

<script type="text/javascript">
	
	$(document).ready(function (){
		
		goReadComment(); // 페이징 처리 안한 댓글 읽어오기
		
		
		$(document).bind("keydown", function(e){
		    if(e.keyCode == 13){
		        e.preventDefault(); // 기본 동작 방지 (계속 댓글쓰기 엔터 누르면 뒤로가기 눌려 기본 동작 방지 작성)
		    }
		});
		
		$("input:text[name='comment_text']").bind("keyup", function(e){
			if(e.keyCode == 13){
				goAddWrite();
			}
		});		
		
		
// 요기 !! //
		// ===== 답글쓰기 ===== //
		$(document).on("click", "button.btnReply", function(e){
			
			   // alert("답글쓰기");
			  
			   const boardcommentseq = $(e.target).parent().children("input").val();
			   // alert(boardcommentseq);
			   let v_html = "";
			   
			   if($(e.target).parent().children(".input_reply").html() == ""){
				   $(".input_reply").html("");
				   v_html += "<div>";
				   v_html += "<form name='recommentFrm'>";
    			   v_html += "<textarea name='commentreply_text' style='font-size: 12pt; width: 100%; height: 60px;'></textarea>";
    			   v_html += "<div style='text-align: right; font-size: 12pt;'>";
    			   v_html += "<button type='button' class='btn btn-outline-secondary' id='btnCommentOK' style='margin: auto; padding: 0.5% 1.5%;' onclick='goAddWritere("+boardcommentseq+")'>";
			       v_html += "<span style='font-size: 8pt;'>등록</span>";
			       v_html += "</button>";
			       v_html += "</div>";
			       v_html += "</form>";
			       v_html += "</div>";
			   }
			   else{
				   $(e.target).parent().children(".input_reply").html("");
			   }
			   $(e.target).parent().children(".input_reply").html(v_html); 
			   
		}); 
		
		
		
		
		
		// ===== 답글 수정 ===== //
		let origin_recomment_content = "";
		
		$(document).on("click", "button.btnUpdateReComment", function(e){
		    
			const $btn = $(e.target);
			
			if($(e.target).text() == "수정"){
			 // alert("답글수정");
			 //	alert($(e.target).parent().parent().children('div#commentreply_text').text()); // 수정전 답글내용
			    const $content = $(e.target).parent().parent().children('div#commentreply_text');
			    origin_recomment_content = $(e.target).parent().parent().children('div#commentreply_text').text();
			    $content.html(`<input id='recomment_update' type='text' value='\${origin_recomment_content}' size='30' />`); // 댓글내용을 수정할 수 있도록 input 태그를 만들어 준다.
			    
			    
			    $(e.target).text("완료");
			    $(e.target).next().text("취소"); 
			    
			    $(document).on("keyup", "input#recomment_update", function(e){
			    	if(e.keyCode == 13){
			    	  // alert("엔터했어요~~");
			    	  // alert($btn.text()); // "완료"
			    		 $btn.click();
			    	}
			    });
			}
			
			else if($(e.target).text() == "완료"){
			  // alert("답글수정완료");
			  // alert($(e.target).parent().parent().parent().parent().children("form").children("input").val()); // 수정해야할 댓글시퀀스 번호 
			  // alert($(e.target).parent().parent().children("div:nth-child(2)").children("input").val()); // 수정후 댓글내용
			     const boardcommentseq = $(e.target).parent().parent().parent().parent().children("form").children("input").val()
			     const content = $(e.target).parent().parent().children("div:nth-child(2)").children("input").val(); 
			  
			     $.ajax({
			    	 url:"${pageContext.request.contextPath}/updateReComment.do",
			    	 type:"post",
			    	 data:{"fleamarketcommentreplyseq":$(e.target).parent().children("input").val(),
			    		   "content":content},
			    	 dataType:"json",
			    	 success:function(json){
			    	   $(e.target).parent().parent().children('#commentreply_text').html(content);

			    	   readcommentreply(fleamarketcommentseq)  // 페이징 처리 안한 댓글 읽어오기
			    		
			          ////////////////////////////////////////////////////
			          // goViewComment(1); // 페이징 처리 한 댓글 읽어오기   
			             
			          // const currentShowPageNo = $(e.target).parent().parent().find("input.currentShowPageNo").val(); 
	                  // alert("currentShowPageNo : "+currentShowPageNo);		          
	                  // goViewComment(currentShowPageNo); // 페이징 처리 한 댓글 읽어오기
			    	  ////////////////////////////////////////////////////
			    	  
			    	     $(e.target).text("수정");
			    		 $(e.target).next().text("삭제");
			    		 
			    		 
			    	 },
			    	 error: function(request, status, error){
					    alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					 }
			     });
			}
			
		}); 
		
		
		// ===== 답글수정취소 / 댓글삭제 ===== //
		$(document).on("click", "button.btnDeleteReComment", function(e){
			if($(e.target).text() == "취소"){
			 // alert("댓글수정취소");
			 //	alert($(e.target).parent().parent().children("div:nth-child(2)").html());
			    const $content = $(e.target).parent().parent().children("div:nth-child(2)"); 
			    $content.html(`\${origin_comment_content}`);
			 
			    $(e.target).text("삭제");
		    	$(e.target).prev().text("수정"); 
			}
			
			else if($(e.target).text() == "삭제"){
			  // alert("댓글삭제");
			  // alert($(e.target).next().val()); // 삭제해야할 답글시퀀스 번호 
			  // alert($(e.target).parent().parent().parent().parent().children("form").children("input").val()); // 삭제해야할 댓글시퀀스 번호
			  
			  const fleamarketcommentseq = $(e.target).parent().parent().parent().parent().children("form").children("input").val();
			  
			     if(confirm("정말로 삭제하시겠습니까?")){
				     $.ajax({
				    	 url:"${pageContext.request.contextPath}/deleteReComment.do",
				    	 type:"post",
				    	 data:{"fleamarketcommentreplyseq":$(e.target).next().val(),
				    		   "fleamarketcommentseq":$(e.target).parent().parent().parent().parent().children("form").children("input").val()},
				    	 dataType:"json",
				    	 success:function(json){
				    		 readcommentreply(fleamarketcommentseq);  // 페이징 처리 안한 댓글 읽어오기
				    	 //  goViewComment(1); // 페이징 처리 한 댓글 읽어오기
				    	 },
				    	 error: function(request, status, error){
						    alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
						 }
				     });
			     }
			}
		}); 
		
		
});// end of $(document).ready(function(){})-----------------

// 요기 답글수정 끝!! //
		
		
<%-- 		// === 답글 수정/삭제 === //
$(document).on("click", "button.btnUpdateReply", function(e) {
    const $btn = $(e.target);
    const $dropdownMenu = $btn.closest('.dropdown-menu');
    const boardcommentseq = $dropdownMenu.find('input[type=hidden]').val();
    
    const fullText = $btn.closest('tr').children("td:nth-child(2)").text();
    const $content = $btn.closest('tr').children("td:nth-child(2)");
    
    var beforeEdit;
    
	const lastgoodIndex = fullText.indexOf("(2024-");
	
	if(lastgoodIndex != -1) {
		beforeEdit = fullText.substring(0, lastgoodIndex);
	}
	
	const lastIndex20 = fullText.lastIndexOf("(20"); // "(20"이 마지막으로 등장하는 위치를 찾습니다.
	const lastIndexModify = fullText.lastIndexOf("수정"); // "(수정)"이 마지막으로 등장하는 위치를 찾습니다.

	if (lastIndex20 == -1) {
	    // "(20"이 문자열에 없는 경우
	    beforeEdit = fullText.substring(0, lastIndexModify); // "(수정)" 이전까지의 부분을 가져옵니다.
	} else {
	    // "(20"이 문자열에 있는 경우
	    beforeEdit = fullText.substring(0, lastIndex20); // "(20" 이전까지의 부분을 가져옵니다.
	}

	 const origin_comment_content2 = htmlEscape(beforeEdit.trim());
	
	 $content.html(`
	   <input id='comment_update2' type='text' value='${origin_comment_content2}' size='80' /><br>
	   <button class='float-right' id='btnCancel' type='button'>취소</button>
	   <input type='hidden' value='${boardcommentseq}' />
	   <button class='btnUpdateComment float-right' id='btnComplete2' type='button'>완료</button>
	 `);
	 
	 
    document.getElementById('btnCancel').addEventListener('click', function() {
    	goReadComment();
    });

    $(document).on("keyup", "input#comment_update2", function(e) {
        if (e.keyCode == 13) {
            $("button#btnComplete2").trigger("click");
        }
    });

    // 완료 버튼 클릭 시
    $(document).on("click", "button#btnComplete2", function() {
        const content = $("#comment_update2").val();
        
        $.ajax({
            url: "<%=ctxPath%>/updateCommentSJ.do",
            type: "post",
            data: { "boardcommentseq": boardcommentseq, "content": content },
            dataType: "json",
            success: function(json) {
            	readReplyDisplay(boardcommentseq);
            },
            error: function(request, status, error) {
                alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
            }
        });
    });
});		 --%>
		

// ===== 여기! 댓글 수정 ===== //
let origin_comment_content = "";

$(document).on("click", "button.btnUpdateComment", function(e){
    const $btn = $(e.target);
    
    if($(e.target).text() == "수정"){
        const $content = $(e.target).parent().parent().children().children('#comment_text');
        origin_comment_content = $(e.target).parent().parent().children().children('#comment_text').text();
        
        alert(origin_comment_content);
        $content.html(`<input id='comment_update' type='text' value='${origin_comment_content}' size='40' />`); // 댓글내용을 수정할 수 있도록 input 태그를 만들어 준다.
        
        $(e.target).text("완료");
        $(e.target).next().text("취소"); 
        
        $(document).on("keyup", "input#comment_update", function(e){
            if(e.keyCode == 13){
                $btn.click();
            }
        });
    }
    else if($(e.target).text() == "완료"){
        const content = $(e.target).parent().parent().children("div:nth-child(2)").children().children("input").val(); 
        
        $.ajax({
            url: "<%=ctxPath%>/updateComment.do",
            type: "post",
            data: {
                "boardcommentseq": $(e.target).parent().children("input").val(),
                "content": content
            },
            dataType: "json",
            success: function(json){
                $(e.target).parent().parent().children().children('#comment_text').html(content);
                goReadComment();  // 페이징 처리 안한 댓글 읽어오기
                $(e.target).text("수정");
                $(e.target).next().text("삭제");
            },
            error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
        });
    }
}); 

// ===== 댓글수정취소 / 댓글삭제 ===== //
$(document).on("click", "button.btnDeleteComment", function(e){
    if($(e.target).text() == "취소"){
        const $content = $(e.target).parent().parent().children("div:nth-child(2)").children(); 
        $content.html(origin_comment_content);
     
        $(e.target).text("삭제");
        $(e.target).prev().text("수정"); 
    }
    else if($(e.target).text() == "삭제"){
    	
    	alert("${sessionScope.loginuser.userid}");
        if(confirm("정말로 삭제하시겠습니까?")){
            $.ajax({
                url: "<%=ctxPath%>/deleteComment.do",
                type: "post",
                data: {
                    "boardcommentseq": $(e.target).next().val(),
                    "parentseq": "${requestScope.boardvo.boardseq}",
                    "userid": "${sessionScope.loginuser.userid}"
                },
                dataType: "json",
                success: function(json){
                    goReadComment();  // 페이징 처리 안한 댓글 읽어오기
                },
                error: function(request, status, error){
                    alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
                }
            });
        }
    }
}); 

		
//===== 여기 끝! 댓글 수정 ===== //



		
		// ==== 댓글 수정/완료 ==== //
<%-- 		
		
		$(document).on("click", "button.btnUpdateComment", function(e){
			const $btn = $(e.target);
			if($(e.target).text() == "수정") {
				
				const $dropdownMenu = $btn.closest('.dropdown-menu');
				const boardcommentseq = $dropdownMenu.find('input[type=hidden]').val();
				
				// 수정 전 댓글 내용(btnUpdateComment 버튼(button) (tr) 의 부모 (td) 의 (tr)첫번째 자식에 있다.)
//				alert($(e.target).parent().parent().children("td:nth-child(2)").text());
				
				var fullText = $(e.target).parent().parent().parent().text();
				var beforeEdit;
				
				alert(fullText);
				
				const lastIndex20 = fullText.lastIndexOf("(20"); // "(20"이 마지막으로 등장하는 위치를 찾습니다.
				const lastIndexModify = fullText.lastIndexOf("수정"); // "(수정)"이 마지막으로 등장하는 위치를 찾습니다.

				if (lastIndex20 == -1) {
				    // "(20"이 문자열에 없는 경우
				    beforeEdit = fullText.substring(0, lastIndexModify); // "(수정)" 이전까지의 부분을 가져옵니다.
				} else {
				    // "(20"이 문자열에 있는 경우
				    beforeEdit = fullText.substring(0, lastIndex20); // "(20" 이전까지의 부분을 가져옵니다.
				}
				
				const lastgoodIndex = fullText.indexOf("(2024-");
				if(lastgoodIndex != -1) {
					beforeEdit = fullText.substring(0, lastgoodIndex);
				}
				
				const $content = $(e.target).parent().parent().parent();
				origin_comment_content = htmlEscape(beforeEdit.trim());
				
				$content.html(`<input id='comment_update' type='text' value='\${origin_comment_content}' size='80' /><br>
						<button class='float-right' id='btnCancel' type='button'>취소</button>
						<input type='hidden' value='\${boardcommentseq}' />
						<button class='btnUpdateComment float-right' id='btnComplete' type='button'>완료</button>`); // 댓글 내용을 수정할 수 있도록 input 태그를 만들어준다.
				
				document.getElementById('btnCancel').addEventListener('click', function() {
					goReadComment();
				});					    
					    
				$(document).on("keyup", "input#comment_update", function(e){
				    if(e.keyCode == 13) {
				    	//alert("엔터했어요");
				    	//alert($btn.text()); // "완료"
				    	$("button#btnComplete").trigger("click");
				    }
				});
				
			}
			
			else if($(e.target).text() == "완료") {
				
//				alert("댓글 수정 완료");
//				alert($(e.target).next().val()); // 수정해야할 댓글 시퀀스 번호
//				alert($(e.target).parent().parent().children("td:nth-child(2)").children("input").val()); // 수정 후 댓글내용

				const content = $("#comment_update").val();
				const boardcommentseq = $("#commentDisplay > tr > td.newcomment > input[type=hidden]:nth-child(4)").val();
				
				$.ajax({
					url:"<%=ctxPath%>/updateComment.do",
					type:"post",
					data:{"boardcommentseq":boardcommentseq,
						  "content":content},
					dataType:"json",
				    success: function(json){
				    	 goReadComment(); // (이 방식을 사용하면 DB 에서 모든 댓글 데이터를 읽어야 하기 때문에 시간이 더 걸린다.) (작성일자 변경시켜서 다시 복구시킴.)
				    	// goViewComment(1); // 페이징처리 (무조건 1페이지로 가서 댓글 수정 3페이지를 수정해도 1페이지로 이동하게된다.)
//				    	const PageNo = $(e.target).parent().parent().find("input.currentShowPageNo").val();
//				    	alert("PageNo : " + PageNo);
//				    	currentShowPageNo(PageNo);
				    	 
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
				});
			}
			
		}); // 댓글 수정/확인
		$(document).on("click", "div.rpyDp", function(e){
			
		});
		
		// ==== 댓글 삭제/취소 ==== //
		$(document).on("click", "button.btnDeleteComment", function(e){
			
			if($(e.target).text() == "취소") {
//				alert("댓글 수정 취소");
				// 수정 전 댓글 내용(btnDeleteComment 버튼(button) (tr) 의 부모 (td) 의 (tr)첫번째 자식에 있다.)
//				alert($(e.target).parent().parent().children("td:nth-child(1)").html());

	 			const $content = $(e.target).parent().parent().children("td:nth-child(2)");
				$content.html(`\${origin_comment_content}`); // 댓글 내용을 수정할 수 있도록 input 태그를 만들어준다.
				
			}
			
			else if($(e.target).text() == "삭제") {
				
//				alert($(e.target).prev().val()); // 삭제해야할 댓글 시퀀스 번호

				if(confirm("정말로 삭제하시겠습니까?")) {
				
					$.ajax({
						url:"<%=ctxPath%>/deleteComment.do",
						type:"post",
						data:{"boardcommentseq":$(e.target).prev().val(),
							  "parentseq":"${requestScope.boardvo.boardseq}",
							  "userid":"${sessionScope.loginuser.userid}"},
						dataType:"json",
					    success: function(json){
					    	 goReadComment();
					    	//goViewComment(1); // 페이징처리
						},
						error: function(request, status, error){
							alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
						}
					});
				}

			}
			
		}); // 댓글 삭제/취소
		
		
		
		
	}); // end of document
	 --%>
	
	function htmlEscape(text) {
		  return text.replace(/&/g, '&amp;')
		             .replace(/</g, '&lt;')
		             .replace(/>/g, '&gt;')
		             .replace(/"/g, '&quot;')
		             .replace(/'/g, '&#039;');
	}
	
	
	// == 댓글쓰기 == //
	function goAddWrite(){
	   
		const comment_content = $("textarea[name='comment_text']").val().trim();
		
		alert(comment_content);
		
		if(comment_content == ""){
			alert("댓글 내용을 입력하세요!!");
			return; // 종료
		}
		if( $("input[name='fk_userid']").val() == ''){
			alert("댓글은 로그인 후 작성 가능합니다");
			return; // 종료
		}
		
		
		goAddWrite_noAttach();
		
		
	}// end of fucntion goAddWrite(){}------------------
	
	   function goAddWrite_noAttach(){
	   
		    const fk_userid = "${sessionScope.loginuser.userid}";
		    
			const comment_text = $("textarea[name='comment_text']").val().trim();
			
			if(comment_text == null || comment_text == "") {
				alert("댓글 내용이 없습니다.");
			}
			
			if(comment_text != null && comment_text != "") {
		
			    const queryString = $("form[name='commentFrm']").serialize();
			   	console.log(queryString);
			   	
				$.ajax({
					url:"<%= ctxPath%>/board/addCommentSJ",
				/*
					data:{"fk_userid":$("input:hidden[name='fk_userid']").val() 
			             ,"name":$("input:text[name='name']").val() 
			             ,"content":$("input:text[name='content']").val()
			             ,"parentSeq":$("input:hidden[name='parentSeq']").val()
			             ,"fleamarketseq":fleamarketseq},
			    */
			    	// 또는
			    	data:queryString,
			    	type:"post",
		            dataType:"json",
		            success:function(json){
		           		//console.log(JSON.stringify(json));
	
		           		goReadComment(); 
			           	
		           		$("textarea[name='comment_text']").val("");
		           },
		           error: function(request, status, error){
		               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		           }
				});
			}
		}// end of function goAddWrite_noAttach(){}--------------------------
	
	
	
<%-- 	function goAddWrite(){
		    
		    const fk_userid = "${sessionScope.loginuser.userid}";
		    
			const comment_text = $("input:text[name='comment_text']").val();
			
			if(comment_text == null || comment_text == "") {
				alert("댓글 내용이 없습니다.");
			}
			
			if(comment_text != null && comment_text != "") {
		    
		    const queryString = $("form[name='addWriteFrm']").serialize();
		   
			   $.ajax({
			      
			      url: "<%=ctxPath%>/board/addCommentSJ",
			      data: queryString,
			      type: "post",     
			      dataType: "json",
			      success: function(json){
			         console.log(JSON.stringify(json));
			        	 goReadComment(); // 페이징 처리 안한 댓글 읽어오기
			        	 // 페이징 처리한 댓글 읽어오기
			         
			         $("input:text[name='comment_text']").val("");
			        	 
			      },
			      error: function(request, status, error){
			             alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			        }
			   });
			}
		} // end of goAddWrite --%>
		
		
		
		function goReadComment(){
			
			$.ajax({
				url:"<%= ctxPath%>/readComment.do",
				data:{"parentseq": "${requestScope.boardvo.boardseq}"},
				dataType:"json",
				success:function(json){
					// console.log(JSON.stringify(json));
				    // [{"name":"서영학","regdate":"2024-06-18 16:09:06","fk_userid":"seoyh","seq":"6","content":"여섯번째로 쓰는 댓글입니다."},{"name":"서영학","regdate":"2024-06-18 16:08:56","fk_userid":"seoyh","seq":"5","content":"다섯번째로 쓰는 댓글입니다."},{"name":"서영학","regdate":"2024-06-18 16:08:49","fk_userid":"seoyh","seq":"4","content":"네번째로 쓰는 댓글입니다."},{"name":"서영학","regdate":"2024-06-18 16:08:43","fk_userid":"seoyh","seq":"3","content":"세번째로 쓰는 댓글입니다."},{"name":"서영학","regdate":"2024-06-18 16:05:51","fk_userid":"seoyh","seq":"2","content":"두번째로 쓰는 댓글입니다."},{"name":"서영학","regdate":"2024-06-18 15:36:31","fk_userid":"seoyh","seq":"1","content":"첫번째 댓글입니다. ㅎㅎㅎ"}]
				    // 또는
				    // []
				    
				    let v_html = "";
				    if(json.length > 0){
				    	$.each(json, function(index, item) {
				    		v_html += "<div style='border-bottom:solid 1px #f2f2f2;'>";
				    	    v_html += "<div style='display: flex; margin: 5% 0 3% 0;' >";
				    	    if (item.memberimg == null) {
				    	        v_html += "<div style='width: 6%;'><img class='profile-img' src='<%=ctxPath%>/resources/images/기본이미지.png'></div>";
				    	    }
				    	    if (item.memberimg != null) {
				    	        v_html += "<div style='width: 6%;'><img class='profile-img' src='<%=ctxPath%>/resources/images/uploadImg/" + item.memberimg + "'></div>";
				    	    }
				    	    v_html += "<div style='width: 85%;'>";
				    	    v_html += "<div style='font-size:12pt; font-weight: bold; margin-bottom: 2.3%;'>" + item.fk_userid + "</div>";
				    	    v_html += "<div style='width: 100%;'>";
				    	    v_html += "<div id='comment_text'>" + item.comment_text + "</div>";
				    	    v_html += "</div>";
				    	    v_html += "<div class='comment' style='color:#999999; font-size:10pt; margin-top: 2%;'>" + item.registerdate; 
/* 				    	    if(item.changestatus > 0){
				    	    	v_html += " (수정됨)";
				    	    } */
				    	    v_html += " &nbsp;&nbsp;<button class='btnReply' style='background: none; border: none; color: inherit; font: inherit; cursor: pointer; padding: 0;'>답글쓰기</button>";
				    	    if (${sessionScope.loginuser != null} && "${sessionScope.loginuser.userid}" == item.fk_userid) {
				    	        v_html += "<br><button class='btnUpdateComment' style='background: none; border: none; color: inherit; font: inherit; cursor: pointer; padding: 0;'>수정</button>&nbsp;&nbsp;<button class='btnDeleteComment' style='background: none; border: none; color: inherit; font: inherit; cursor: pointer; padding: 0;'>삭제</button>";
				    	    }
				    	    v_html += "<input type='hidden' value='"+item.boardcommentseq+"' />"
				    	    v_html += "<div class='input_reply' style='width: 100%;'>";
				    	    v_html += "</div>";
				    	    
				    	    
				    	    
				    	    v_html += "</div>";
				    	    v_html += "</div>";
				    	    v_html += "</div>";
				    	    
				    	    v_html += "<form name='commentreFrm'>";
				    	    v_html += "<input type='hidden' id='bdcmtseq' name='boardcommentseq' value='"+item.boardcommentseq+"' />";
				    	    v_html += "</form>";

				    	    
				    	    
				    	    v_html += "<div class='comment_reply"+item.boardcommentseq+"'>";
				    	    v_html += "</div>";
				    	    v_html += "</div>";
				    	    
				    	    readcommentreply(item.boardcommentseq);
				    	});
				    }
				    
				    
				    else {
				    	v_html += "<div colspan='4'>댓글이 없습니다</td>";
				    }
				    
				    $("div#commentView").html(v_html);
				    
				    
				},
				error: function(request, status, error){
				   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});
			
		}// end of function goReadComment()----------------- 
		
		
		<%--
		function goReadComment() { // 페이징 처리 안한 댓글 읽어오기
		    $.ajax({
		        url: "<%=ctxPath%>/readComment.do",
		        data: {"parentseq": "${requestScope.boardvo.boardseq}"},
		        dataType: "json",
		        success: function(json){
		            let v_html = "";

		            if(json.length > 0) {
		                $.each(json, function(index, item){
		                	
		                	// 댓글
		                	if(item.depthno == 0) {
			                    v_html += "<tr>";
			                    v_html += "    <td>" + item.fk_userid + "</td>";
			                    
			                    v_html += "    <td class='newcomment'>" + item.comment_text;
	
			                    v_html += "<input type='hidden' name='boardcommentseq' value='" + item.boardcommentseq + "' />"; // 숨겨진 입력 필드
			                    
			                    // 수정 삭제 버튼 추가
			                    if("${sessionScope.loginuser != null}" && "${sessionScope.loginuser.userid}" == item.fk_userid) {
			                        v_html += "        <div class='dropdown float-right'>";
			                        v_html += "            <button class='btn dropdown-toggle' type='button' id='dropdownMenuButton' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false'>";
			                        v_html += "            </button>";
			                        v_html += "            <div class='dropdown-menu' aria-labelledby='dropdownMenuButton'>";
			                        v_html += "                <button class='dropdown-item btnUpdateComment' type='button'>수정</button>"; // 수정 버튼
			                        v_html += "                <input type='hidden' value='" + item.boardcommentseq + "' />"; // 숨겨진 입력 필드
			                        v_html += "                <button class='dropdown-item btnDeleteComment' type='button'>삭제</button>"; // 삭제 버튼
			                        v_html += "            </div>";
			                        v_html += "        </div>";
			                    } // 로그인한 아이디와 댓글의 아이디가 같을 경우 수정 삭제 버튼 추가
	
			                    v_html += "        <br>";
			                    
			                    let fk_userid = $("#userid").val();
//			                    alert(fk_userid); // 값 확인용
			                    
			                    
		                        if($("input:hidden[name='fk_userid']").val() != null) {
			                        v_html += "        <div class='float-left'>";
			                        v_html += "        	   <button style='background-color: white;' type='button' onclick='showAddReply("+item.boardcommentseq+")'>답글쓰기</button>"; 
			                        v_html += "        	   <div class='hidden mt-3' id='"+item.boardcommentseq+"reply_comment'> ";
			                        v_html += "        	   	<input type='text' size='70' maxlength='1000' class='"+item.boardcommentseq+"replyComment' />";
			                        v_html += "			   	<br>";	
			                        v_html += "    <button type='button' class='float-right mt-3 mb-3' onclick='addReply(" 
					                            + item.boardcommentseq + "," 
					                            + item.groupno + "," 
					                            + item.depthno + "," 
					                            + item.parentseq + "," 
					                            + "\"" + fk_userid + "\")'>답글</button>";
			                        v_html += "        	   </div>";
			                        v_html += "        </div>";
			                        v_html += "        <br>";
			                        v_html += "        </div>";
		                        } // 로그인 했을 경우 좋아요, 싫어요, 답글 버튼 보여주기
		                        v_html += "        <div class='float-left' id='"+item.boardcommentseq+"readReplyDisplay'></div>";
			                    v_html += "    </td>";
			                    v_html += "    <td class='comment'>" + item.registerdate + "</td>";
			                    v_html += "</tr>";
			                    
			                    readReplyDisplay(item.boardcommentseq);
		                	}
		                });
		                
		            } else {
		                v_html += "<tr>";
		                v_html += "    <td colspan='3'>댓글이 없습니다.</td>";
		                v_html += "</tr>";
		            }
		            
		            let v_html2 = "";
		            v_html2 += "<tr>";
		            v_html2 += "    <th>작성자</th>";
		            v_html2 += "    <th>내용</th>";
		            v_html2 += "    <th class='comment'>작성일자</th>";
		            v_html2 += "</tr>";
		            
		            
		            $("thead#commentTheadDisplay").html(v_html2);
		            $("tbody#commentDisplay").html(v_html);

		        },
		        error: function(request, status, error){
		            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
		        }
		    });
		} // end of goReadComment
		
		--%>
		
		
		
		function showAddReply(boardcommentseq) {
            const content = $("#"+boardcommentseq+"reply_comment");
            if (content.hasClass("hidden")) {
                content.removeClass("hidden");
            } else {
                content.addClass("hidden");
            }
		} // end of showAddReply()


		// 답글 쓰기
		function addReply(boardcommentseq, groupno, depthno, parentseq, fk_userid) {

//			alert($("input."+boardcommentseq+"replyComment").val());
			
			const comment_text = $("input."+boardcommentseq+"replyComment").val();
			
//			alert(comment_text);
			
			if(comment_text == null || comment_text == "") {
				alert("답글 내용이 없습니다.");
			}
			
			if(comment_text != null && comment_text != "") {
			    $.ajax({
			        url: "<%=ctxPath%>/addReply.do",
			        data: {"boardcommentseq":boardcommentseq,
			        	   "groupno":groupno,
			        	   "parentseq":parentseq,
			        	   "depthno":depthno,
			        	   "fk_userid":fk_userid,
			        	   "comment_text":comment_text},
			       	type: "post",		        	   
			        dataType: "json",
			        success: function(json){
			        	if(json.n == 1) {
			        		goReadComment();
			        	}
			        },
			        error: function(request, status, error){
			            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
			        }
			    });		
			}
		} // end of addReply(boardcommentseq)
		
	
		
		function readcommentreply(boardcommentseq){
			
			  //alert(boardcommentseq);
			  
			  $.ajax({
					url:"<%= ctxPath%>/readReplyCommentSJ.do",
			    	data:{"boardcommentseq": boardcommentseq},
			    	type:"post",
		            dataType:"json",
		            success:function(json){
		           	//console.log(JSON.stringify(json));
		           	
		            	let v_html = "";
					    if(json.length > 0){
					    	$.each(json, function(index, item) {
					    	    v_html += "<div style='display: flex; margin: 4% 0 4% 5%;'>";
					    	    v_html += "<div style='width: 6%;'><img class='profile-img' style='width: 50%; height: 50%;' src='<%=ctxPath%>/resources/images/reply.png'></div>";
					    	    if (item.memberimg == null) {
					    	        v_html += "<div style='width: 6%;'><img class='profile-img' src='<%=ctxPath%>/resources/images/기본이미지.png'></div>";
					    	    }
					    	    if (item.memberimg != null) {
					    	        v_html += "<div style='width: 6%;'><img class='profile-img' src='<%=ctxPath%>/resources/images/uploadImg/" + item.memberimg + "'></div>";
					    	    }
					    	    v_html += "<div style='display: flex; margin-top:0.7%; margin-left: 2%; width: 120%'>";
					    	    v_html += "<div style='font-size:12pt; font-weight: bold; margin-bottom: 1.5%;'>" + item.fk_userid + "</div>";
					    	    v_html += "<div id='commentreply_text' style='margin-left: 2%;'>" + item.comment_text + "</div>";
					    	    v_html += "<div class='comment' style='color:#999999; font-size:10pt; margin-top: 0.4%; margin-left: 1.5%; display: flex; width: 50%;'>" + item.registerdate; 
/* 					    	    if(item.changestatus > 0){
					    	    	v_html += " (수정됨)";
					    	    } */
					    	    
					    	    if (${sessionScope.loginuser != null} && "${sessionScope.loginuser.userid}" == item.fk_userid) {
					    	        v_html += "<button class='btnUpdateReComment' style='margin-left: 3%; margin-bottom: 4.5%; background: none; border: none; color: inherit; font: inherit; cursor: pointer; padding: 0;'>수정</button>&nbsp;&nbsp;<button class='btnDeleteReComment' style='margin-bottom: 4.5%; background: none; border: none; color: inherit; font: inherit; cursor: pointer; padding: 0;'>삭제</button>";
					    	    }
					    	    v_html += "<input type='hidden' value='"+item.boardcommentseq+"' />"
					    	    v_html += "</div>";
					    	    v_html += "</div>";
					    	    v_html += "</div>";
					    	    
					    	    v_html += "<form name='commentreFrm'>";
					    	    v_html += "<input type='hidden' name='boardcommentseq' value='"+boardcommentseq+"' />";
					    	    v_html += "</form>";
					    	    
					    	    v_html += "<div class='comment_reply'>";
					    	    v_html += "</div>";
					    	});
					    }
					    
					    $("div.comment_reply"+boardcommentseq+"").html(v_html);
					},
					error: function(request, status, error){
					   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
				})
		}
		
		
<%-- 		// 답글 읽기
		function readReplyDisplay(boardcommentseq) {
		    $.ajax({
		        url: "<%= ctxPath %>/readReplyCommentSJ.do",
		        data: { "boardcommentseq": boardcommentseq },
		        type: "post",
		        dataType: "json",
		        success: function (json) {
		            let replyCount = json.length;
		            let v_html = "<div class='mt-3 mb-2 rpyDp' style='font-weight: bold; cursor: pointer; color: #06A1E7;'>답글 " + replyCount + " 개 <span class='arrow'>▼</span></div>";
		            v_html += "<table class='reply-table hidden'><tbody>";

		            if (replyCount > 0) {
		                $.each(json, function (index, item) {
		                    v_html += "<tr>";
		                    v_html += "    <td>" + item.fk_userid + "</td>";
		                    v_html += "    <td>" + item.comment_text + "</td>";
		                    v_html += "    <td>" + item.registerdate + "</td>";
		                    
	
		                    
		                    // 수정 삭제 버튼 추가
		                    if ("${sessionScope.loginuser != null}" && "${sessionScope.loginuser.userid}" == item.fk_userid) {
		                        v_html += "    <td>";
		                        v_html += "        <div class='dropdown float-right'>";
		                        v_html += "            <button class='btn dropdown-toggle' type='button' id='dropdownMenuButton' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false'>";
		                        v_html += "                ⋮";
		                        v_html += "            </button>";
		                        v_html += "            <div class='dropdown-menu' aria-labelledby='dropdownMenuButton'>";
		                        v_html += "                <button class='dropdown-item btnUpdateReply' type='button'>답글수정</button>"; // 수정 버튼
		                        v_html += "                <input type='hidden' value='" + item.boardcommentseq + "' />"; // 숨겨진 입력 필드
		                        v_html += "                <button class='dropdown-item btnDeleteComment' type='button'>삭제</button>"; // 삭제 버튼
		                        v_html += "            </div>";
		                        v_html += "        </div>";
		                        v_html += "    </td>";
		                    } // 로그인한 아이디와 댓글의 아이디가 같을 경우 수정 삭제 버튼 추가
		                    v_html += "</tr>";
		                });

		                v_html += "</tbody></table>";
		                $("div#" + boardcommentseq + "readReplyDisplay").html(v_html);

		                // rpyDp 클래스를 가진 div에 클릭 이벤트 추가
		                $("div#" + boardcommentseq + "readReplyDisplay .rpyDp").on("click", function () {
		                    $(this).next(".reply-table").toggleClass("hidden");
		                    let arrow = $(this).find(".arrow");
		                    if ($(this).next(".reply-table").hasClass("hidden")) {
		                        arrow.text("▼");
		                    } else {
		                        arrow.text("▲");
		                    }
		                });
		            }
		        },
		        error: function (request, status, error) {
		            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
		        }
		    });
		} // end of readReplyDisplay
 --%>
		
		
		// === #139. 이전글제목, 다음글제목 보기 === //
		function goView(boardseq){
			
			const goBackURL = "${requestScope.goBackURL}";
		//	      goBackURL = "/list.action?searchType=subject&searchWord=정화&currentShowPageNo=3"; 
		<%--	
		         아래처럼 get 방식으로 보내면 안된다. 왜냐하면 get방식에서 &는 전송될 데이터의 구분자로 사용되기 때문이다. 
			location.href=`<%= ctxPath%>/view.action?seq=\${seq}&goBackURL=\${goBackURL}`;        
		--%>
		
		<%-- 그러므로 & 를 글자 그대로 인식하는 post 방식으로 보내야 한다.
		           아래에 #132 에 표기된 form 태그를 먼저 만든다. --%>  
		     const frm = document.goViewFrm; 
		     frm.boardseq.value = boardseq;
		     frm.goBackURL.value = goBackURL;
		     
		     if(${not empty requestScope.paraMap}){ // 검색조건이 있을 경우 
		    	 frm.searchType.value = "${requestScope.paraMap.searchType}";
		    	 frm.searchWord.value = "${requestScope.paraMap.searchWord}";
		     }
		     
		     frm.method = "post";
		     frm.action = "<%= ctxPath%>/board/boardview_2.do";
		     frm.submit();
		     
		}// end of function goView(seq)--------------	


</script>



<div style="display: flex;">
	<div style="margin: auto; padding-left: 3%;">
		<h2 style="margin-bottom: 30px;">글내용보기</h2>

		<c:if test="${not empty requestScope.boardvo}">

			<table class="table table-bordered" style="width: 1024px; word-wrap: break-word; table-layout: fixed;">
				<tr>
					<th style="width: 15%">글번호</th>
					<td>${requestScope.boardvo.boardseq}</td>
				</tr>

				<tr>
					<th>성명</th>
					<td>${requestScope.boardvo.fk_userid}</td>
				</tr>

				<tr>
					<th>제목</th>
					<td>
						<p style="word-break: break-all;">${requestScope.boardvo.title}</p>
				<%-- 
	                style="word-break: break-all; 은 공백없는 긴영문일 경우 width 크기를 뚫고 나오는 것을 막는 것임. 
			                    그런데 style="word-break: break-all; 나 style="word-wrap: break-word; 은
			                    테이블태그의 <td>태그에는 안되고 <p> 나 <div> 태그안에서 적용되어지므로 <td>태그에서 적용하려면
	                <table>태그속에 style="word-wrap: break-word; table-layout: fixed;" 을 주면 된다.
	            --%>
					</td>
				</tr>

				<tr>
					<th>글내용</th>
					<td>${requestScope.boardvo.content}</td>
				</tr>

				<tr>
					<th>조회수</th>
					<td>${requestScope.boardvo.viewcount}</td>
				</tr>

				<tr>
					<th>작성일자</th>
					<td>${requestScope.boardvo.registerdate}</td>
				</tr>
			
		   	    <tr>
		   		    <th>첨부파일</th>
		   	        <td>
		   	          <c:if test="${sessionScope.loginuser != null && requestScope.boardvo.orgfilename != null}">
		   	             <a href="<%= ctxPath%>/download.do?boardseq=${requestScope.boardvo.boardseq}">${requestScope.boardvo.orgfilename}</a>  
		   	          </c:if>
		   	          <c:if test="${sessionScope.loginuser == null && requestScope.boardvo.orgfilename != null}">
		   	             ${requestScope.boardvo.orgfilename}
		   	          </c:if>
		   	          <c:if test="${requestScope.boardvo.orgfilename == null}">
		   	          </c:if>
		   	        </td>
		   	    </tr>
		   	    <tr>
		   	    	<c:if test="${requestScope.boardvo.orgfilename != null}">
		   		    	<th>파일크기(bytes)</th>
		   	      	  <td><fmt:formatNumber value="${requestScope.boardvo.filesize}" pattern="#,###" /></td>
		   	        </c:if>
		   	    	<c:if test="${requestScope.boardvo.orgfilename == null}">
		   		    	<th>파일크기(bytes)</th>
		   	        </c:if>
		   	    </tr>				
				
			</table>

		</c:if>

		<c:if test="${empty requestScope.boardvo}">
			<div style="padding: 20px 0; font-size: 16pt; color: red;">존재하지 않습니다</div>
		</c:if>

		<div class="mt-5">
			<%-- 글조회수 1 증가를 위해서  view.do 대신에 view_2.do 으로 바꾼다. --%>
		    <div style="margin-bottom: 1%;">이전글제목&nbsp;&nbsp;<span class="move" onclick="goView('${requestScope.boardvo.previousseq}')">${requestScope.boardvo.previoussubject}</span></div>
		 	<div style="margin-bottom: 1%;">다음글제목&nbsp;&nbsp;<span class="move" onclick="goView('${requestScope.boardvo.nextseq}')">${requestScope.boardvo.nextsubject}</span></div>
		    <%-- >>> 글목록에서 검색되어진 글내용일 경우 이전글제목, 다음글제목은 검색되어진 결과물내의 이전글과 다음글이 나오도록 하기 위한 것이다.  끝  <<< --%>   
		    	
		 	<br>



			<button type="button" class="btn btn-secondary btn-sm mr-3" onclick="javascript:location.href='<%=ctxPath%>/community/list.do'">전체목록보기</button>

			<c:if test="${not empty sessionScope.loginuser && sessionScope.loginuser.userid == requestScope.boardvo.fk_userid}">
				<button type="button" class="btn btn-secondary btn-sm mr-3" onclick="javascript:location.href='<%= ctxPath%>/board/edit.do?boardseq=${requestScope.boardvo.boardseq}&sportseq=${requestScope.boardvo.fk_sportseq}'">글수정하기</button>
				<button type="button" class="btn btn-secondary btn-sm mr-3" onclick="javascript:location.href='<%= ctxPath%>/board/del.do?boardseq=${requestScope.boardvo.boardseq}'">글삭제하기</button>
			</c:if>
			
			<%-- 댓글쓰기 폼 추가 --%>
			<c:if test="${not empty sessionScope.loginuser}">
			<div style="font-size: 11pt;" class="mt-4">
				<img style="width: 3%; margin-bottom: 0.2%;" src="<%=ctxPath%>/resources/images/댓글.png">
				댓글
			</div>

				<form name="addWriteFrm" id="addWriteFrm" style="margin-top: 20px;">
					<table class="table" style="width: 1080px">
						<tr style="height: 30px;">
							<th>댓글내용</th>
							<td>
								<!-- <input type="text" id="comment_text" name="comment_text" size="100" maxlength="1000" />  -->
	  							<input type="hidden" name="parentseq" value="${requestScope.boardvo.boardseq}" />  
	  							<input type="hidden" id="userid" name="fk_userid" value="${sessionScope.loginuser.userid}">  
							</td>
						</tr>

						<tr>
							<th colspan="2">
								<button type="reset" class="btn btn-success btn-sm float-right">댓글쓰기 취소</button>
								<!--  <button type="button" class="btn btn-success btn-sm mr-3 float-right" onclick="goAddWrite()">댓글쓰기 확인</button> -->
							</th>
						</tr>
					</table>
				</form>
			</c:if>
			
			
			<%-- === 댓글 내용 보여주기 === 
	       <h3 style="margin-top: 50px;">댓글내용</h3>
	       <table class="table" style="width: 1024px; margin-top: 2%; margin-bottom: 3%;">
	          <thead id="commentTheadDisplay"></thead>
	          <tbody id="commentDisplay"></tbody>
	        </table>
	        
		 	<div style="display: flex; margin-bottom: 50px;">
	    	   <div id="pageBar" style="margin: auto; text-align: center;"></div>
	    	</div>
			--%>
			
			
				<div style="font-size: 11pt;">
		<img style="width: 3%; margin-bottom: 0.2%;" src="<%=ctxPath%>/resources/images/댓글.png">
		댓글
	</div>
	
	<hr>
	
	
	<div class="text-left">
	
	<%-- === #94. 댓글 내용 보여주기 === --%>
     
     <div>
		<form name="commentFrm">
			<div>
				<textarea name="comment_text" style="font-size: 12pt; width: 100%; height: 100px;"></textarea>
				<input type="hidden" name="parentseq" value="${requestScope.boardvo.boardseq}" />  
				<input type="hidden" id="userid" name="fk_userid" value="${sessionScope.loginuser.userid}"> 
			</div>
			<div style="text-align: right; font-size: 12pt;">
				<button type="button" class="btn btn-outline-secondary"
					id="btnCommentOK" style="margin: auto;" onclick="goAddWrite()">
					<span style="font-size: 10pt;">등록</span>
				</button>
			</div>
		</form>
	</div>
     
     <div id="commentView" >
    
	</div>
	
	

	<%-- === #155. 댓글페이지바가 보여지는 곳 === --%> 
 	<div style="display: flex; margin-bottom: 50px;">
   	   <div id="pageBar" style="margin: auto; text-align: center;"></div>
   	</div>
      
      <%-- #155. 댓글페이지바가 보여지는 곳 === --%>
      <div style="display: flex; margin-bottom: 50px;">
          <div id="pageBar" style="margin: auto; text-align: center;"></div>
       </div>
			
			
			
			
			
		</div>
	</div>
</div>





<%-- === 이전글제목, 다음글제목 보기 === --%>
<form name="goViewFrm">
	<input type="hidden" name="boardseq" /> 
	<input type="hidden" name="goBackURL" /> 
	<input type="hidden" name="searchType" /> 
	<input type="hidden" name="searchWord" /> 
</form>