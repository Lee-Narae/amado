<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
	String ctxPath = request.getContextPath();
%>


<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>

<style type="text/css">

@font-face {
    font-family: 'Volt110';
    src: url('path/to/volt110.woff2') format('woff2'),
         url('path/to/volt110.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}

@font-face {
    font-family: 'Volt220';
    src: url('path/to/volt220.woff2') format('woff2'),
         url('path/to/volt220.woff') format('woff');
    font-weight: bold;
    font-style: normal;
}

li {
	margin-bottom: 10px;
}

div#viewComments {
	width: 80%;
	margin: 1% 0 0 0;
	text-align: left;
	max-height: 300px;
	overflow: auto;
	/* border: solid 1px red; */
}

span.markColor {
	color: #ff0000;
}

div.customDisplay {
	display: inline-block;
	margin: 1% 3% 0 0;
}

div.spacediv {
	margin-bottom: 5%;
}

div.commentDel {
	font-size: 8pt;
	font-style: italic;
	cursor: pointer;
}

div.commentDel:hover {
	background-color: navy;
	color: white;
}



/* ==== 추가이미지 캐러젤로 보여주기 시작 ==== */
.carousel-inner .carousel-item.active, .carousel-inner .carousel-item-next,
	.carousel-inner .carousel-item-prev {
	display: flex;
}

.carousel-inner .carousel-item-right.active, .carousel-inner .carousel-item-next
	{
	/* transform: translate(25%, 0); */
	/* 또는 */
	transform: translateX(25%);

	/* transform: translate(0, 25%);
		   또는
		   transform: translateY(25%); */
}

.carousel-inner .carousel-item-left.active, .carousel-inner .carousel-item-prev
	{
	transform: translateX(-25%);
}

.carousel-inner .carousel-item-right, .carousel-inner .carousel-item-left
	{
	transform: translateX(0);
}
/* ==== 추가이미지 캐러젤로 보여주기 끝 ==== */

/* -- CSS 로딩화면 구현 시작(bootstrap 에서 가져옴) 시작 -- */
div.loader {
	/* border: 16px solid #f3f3f3; */
	border: 12px solid #f3f3f3;
	border-radius: 50%;
	/* border-top: 16px solid #3498db; */
	border-top: 12px dotted blue;
	border-right: 12px dotted green;
	border-bottom: 12px dotted red;
	border-left: 12px dotted pink;
	width: 120px;
	height: 120px;
	-webkit-animation: spin 2s linear infinite; /* Safari */
	animation: spin 2s linear infinite;
}

/* Safari */
@
-webkit-keyframes spin { 0% {
	-webkit-transform: rotate(0deg);
}

100
%
{
-webkit-transform
:
rotate(
360deg
);
}
}
@
keyframes spin { 0% {
	transform: rotate(0deg);
}
100
%
{
transform
:
rotate(
360deg
);
}
}


#mycontent{
	width: 60%;
	margin: 5% auto;
}
/* -- CSS 로딩화면 구현 끝(bootstrap 에서 가져옴) 끝 -- */



/* 공통 버튼 스타일 */
.button {
 /* border: 2px solid #000;  검정색 테두리 */
  background-color: #fff; /* 흰색 배경 */
  color: #000; /* 검정색 글자 */
  padding: 15px 20px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  cursor: pointer;
  border-radius: 8px;
  transition: background-color 0.3s, color 0.3s, transform 0.3s;
  flex: 1; /* 버튼들이 같은 비율로 공간을 차지하도록 설정 */
  margin: 0 10px; /* 버튼 사이 간격 */
}

.button:hover {
  background-color: #000; /* 마우스 오버 시 배경색 변경 */
  color: #fff; /* 마우스 오버 시 글자색 변경 */
  transform: scale(1.05);
}

.button:active {
  transform: scale(0.95);
}

/* 버튼 컨테이너 스타일 */
.button-container {
  display: flex;
  justify-content: space-between; /* 버튼들 사이의 여백 균등 분배 */
  align-items: center; /* 버튼들의 세로 정렬 */
  padding: 10px; /* 컨테이너 패딩 */
}

/* 반응형 디자인을 위한 미디어 쿼리 */
@media (max-width: 600px) {
  .button-container {
    flex-direction: column; /* 작은 화면에서는 버튼들이 세로로 배치 */
  }

  .button {
    margin: 10px 0; /* 세로 배치일 때 버튼 간격 */
  }
}


/*지도 */

	div#title {
		font-size: 20pt;
	 /* border: solid 1px red; */
		padding: 12px 0;
	}
	
	div.mycontent {
  		width: 300px;
  		padding: 5px 3px;
  	}
  	
  	div.mycontent>.title {
  		font-size: 12pt;
  		font-weight: bold;
  		background-color: #d95050;
  		color: #fff;
  	}
  	
  	div.mycontent>.title>a {
  		text-decoration: none;
  		color: #fff;
  	}
  	  	
  	div.mycontent>.desc {
  	 /* border: solid 1px red; */
  		padding: 10px 0 0 0;
  		color: #000;
  		font-weight: normal;
  		font-size: 9pt;
  	}
  	
  	div.mycontent>.desc>img {
  		width: 50px;
  		height: 50px;
  	}

/*지도 끝*/
        .big-image {
            width: 100%;
            height: auto;
            margin-bottom: 20px; /* 큰 사진과 작은 사진 간의 간격 조정 */
        }

        /* 작은 사진 영역 스타일링 */
        .small-image {
            width: 100%;
            height: auto;
            margin-bottom: 10px; /* 작은 사진들 간의 간격 조정 */
        }

        /* 작은 사진 영역 내부 각 사진의 스타일링 */
        .small-image-wrapper .col-6 {
            margin-bottom: 10px; /* 작은 사진 영역 내부 각 사진의 간격 조정 */
        }
    /* 추가적인 스타일링이 필요하다면 여기에 추가하세요 */
    .img-fluid {
        width: 100%;
        height: auto;
    }
    .col-lg-4, .col-6 {
        padding-bottom: 10px;
    }
    .container {
      margin-top: 50px;
    }
    .info-box {
      border: 1px solid #ccc;
      padding: 15px;
      margin-bottom: 20px;
    }
    .payment-box {

      padding: 15px;
      margin-top: 20px;
    }
    .payment-options label {
      display: block;
      cursor: pointer;
    }
    .payment-options label:hover {
      text-decoration: underline;
    }
    .footer {
      text-align: center;
      padding: 10px 0;
      background-color: #f8f9fa;
      position: fixed;
      bottom: 0;
      width: 100%;
    }
    .action-buttons {
      text-align: center;
      margin-top: 20px;
    }
    .action-buttons button {
      margin-right: 10px;
    }
    
    /*좋아요 버튼 */
    
    a{
  text-decoration:none; color:inherit; cursor: pointer;
	}
	 .right_area .icon{
	    display: flex;
	    align-items: center;
	    justify-content: center;
	    width: calc(100vw * (45 / 1920));
	    height: calc(100vw * (45 / 1920));
	
	    border-radius: 50%;
	    border: solid 2px #eaeaea;
	    background-color: #fff;
	}
	
	.icon.heart img{
	    width: calc(100vw * (24 / 1920));
	    height: calc(100vw * (24 / 1920));
	}
	
	.icon.heart.fas{
	  color:red
	}
	.heart{
	    transform-origin: center;
	}
	.heart.active img{
	    animation: animateHeart .3s linear forwards;
	}
	
	@keyframes animateHeart{
	    0%{transform:scale(.2);}
	    40%{transform:scale(1.2);}
	    100%{transform:scale(1);}
	  }
/*좋아요 버튼 끝 */

	#video {
    	position: absolute;
        top: 0px;
        left: 0px;
        min-width: 100%;
        min-height: 100%;
        width: auto;
        height: auto;
        z-index: -1;
        overflow: hidden;}
		
.profile-img {
      width: 35px; /* 원하는 너비 */
      height: 35px; /* 원하는 높이 */
      border-radius: 50%; /* 원형으로 만들기 */
      object-fit: cover; /* 이미지를 컨테이너에 맞추어 자르기 */
  }

.action-buttons {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-top: 20px;
  }

  .action-buttons .right_area {
    margin-right: 10px;
  }

  .action-buttons .btn {
    flex-grow: 1;
    padding: 10px 20px; /* Padding을 조정하여 버튼 크기 조정 */
    font-size: 16px; /* 폰트 크기 조정 */
  }


 @media (max-width: 768px) {
    .action-buttons .btn {
      padding: 10px 50px; /* 모바일 장치에서 버튼 패딩 조정 */
    }
  }

  @media (min-width: 769px) {
    .action-buttons .btn {
      padding: 10px 100px; /* 데스크탑 장치에서 버튼 패딩 조정 */
    }
  }

</style>

<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/myshop/categoryListJSON.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3e40c6a4e83259bd26e2771ad2db4e63"></script>

<script type="text/javascript">


	$(document).ready(function(){
		goReadComment();
		
		
		// ======= 추가이미지 캐러젤로 보여주기(Bootstrap Carousel 4개 표시 하되 1번에 1개 진행) 시작 ======= //
	 	   $('div#recipeCarousel').carousel({
	        	interval : 2000  <%-- 2000 밀리초(== 2초) 마다 자동으로 넘어가도록 함(2초마다 캐러젤을 클릭한다는 말이다.) --%>
	       });

	       $('div.carousel div.carousel-item').each(function(index, elmt){
	    	 
	    	    let next = $(elmt).next();      <%--  다음엘리먼트    --%>
	      
	      	    if (next.length == 0) { <%-- 다음엘리먼트가 없다라면 --%>
	               <%--    	    
	      	        console.log("다음엘리먼트가 없는 엘리먼트 내용 : " + $(elmt).html());
	      	       --%>  
	      	       <%-- 
	      	            다음엘리먼트가 없는 엘리먼트 내용 : <img class="d-block col-3 img-fluid" src="/MyMVC/images/berkelekle디스트리뷰트063.jpg">
	      	       --%>
	      	    
	      	    //  next = $('div.carousel div.carousel-item').eq(0);
	      	    //  또는   
	      	    //	next = $(elmt).siblings(':first'); <%-- 해당엘리먼트의 형제요소중 해당엘리먼트를 제외한 모든 형제엘리먼트중 제일 첫번째 엘리먼트 --%>
	      	    //  또는 
	      	        next = $(elmt).siblings().first(); <%-- 해당엘리먼트의 형제요소중 해당엘리먼트를 제외한 모든 형제엘리먼트중 제일 첫번째 엘리먼트 --%>
	      	        <%-- 
	      	             선택자.siblings() 는 선택자의 형제요소(형제태그)중 선택자(자기자신)을 제외한 나머지 모든 형제요소(형제태그)를 가리키는 것이다.
	      	             :first	는 선택된 요소 중 첫번째 요소를 가리키는 것이다.
	      	             :last	는 선택된 요소 중 마지막 요소를 가리키는 것이다. 
	      	             참조사이트 : https://stalker5217.netlify.app/javascript/jquery/
	      	             
	      	             .first()	선택한 요소 중에서 첫 번째 요소를 선택함.
	      	             .last()	선택한 요소 중에서 마지막 요소를 선택함.
	      	             참조사이트 : https://www.devkuma.com/docs/jquery/%ED%95%84%ED%84%B0%EB%A7%81-%EB%A9%94%EC%86%8C%EB%93%9C-first--last--eq--filter--not--is-/ 
	      	        --%> 
	      	    }
	      	    
	      	    $(elmt).append(next.children(':first-child').clone());
	      	    <%-- next.children(':first-child') 은 결국엔 img 태그가 되어진다. --%>
	      	    <%-- 선택자.clone() 은 선택자 엘리먼트를 복사본을 만드는 것이다 --%>
	      	    <%-- 즉, 다음번 클래스가 carousel-item 인 div 의 자식태그인 img 태그를 복사한 img 태그를 만들어서 
	      	         $(elmt) 태그속에 있는 기존 img 태그 뒤에 붙여준다. --%>
	      	    
	      	    for(let i=0; i<2; i++) { // 남은 나머지 2개를 위처럼 동일하게 만든다.
	      	        next = next.next(); 
	      	        
	      	        if (next.length == 0) {
	      	        //	next = $(elmt).siblings(':first');
	      	        //  또는
	      	        	next = $(elmt).siblings().first();
	      	      	}
	      	        
	      	        $(elmt).append(next.children(':first-child').clone());
	      	    }// end of for--------------------------
	      	  
		        console.log(index+" => "+$(elmt).html()); 
		      
	      	}); // end of $('div.carousel div.carousel-item').each(function(index, elmt)----
	        // ======= 추가이미지 캐러젤로 보여주기(Bootstrap Carousel 4개 표시 하되 1번에 1개 진행) 끝 ======= //		
		
	        
	       ////////////////////////////////////////////////////////////
	        
		   $("input#spinner").spinner( {
			   spin: function(event, ui) {
				   if(ui.value > 100) {
					   $(this).spinner("value", 100);
					   return false;
				   }
				   else if(ui.value < 1) {
					   $(this).spinner("value", 1);
					   return false;
				   }
			   }
		   } );// end of $("input#spinner").spinner({});----------------
	        
	       
	    
	    $("div.loader").hide(); // CSS 로딩화면 감추기 
	    
    	
    	
    	// ===== 댓글 수정 ===== //
		let origin_comment_content = "";
		
		$(document).on("click", "button.btnUpdateComment", function(e){
		    
			const $btn = $(e.target);
			
			if($(e.target).text() == "수정"){
			 // alert("댓글수정");
			 //	alert($(e.target).parent().parent().children().children('#comment_text').text()); // 수정전 댓글내용
			    const $content = $(e.target).parent().parent().children().children('#content');
			    origin_comment_content = $(e.target).parent().parent().children().children('#content').text();
			    $content.html(`<input id='comment_update' type='text' value='\${origin_comment_content}' size='40' />`); // 댓글내용을 수정할 수 있도록 input 태그를 만들어 준다.
			    
			    $(e.target).text("완료");
			    $(e.target).next().text("취소"); 
			    
			    $(document).on("keyup", "input#comment_update", function(e){
			    	if(e.keyCode == 13){
			    	  // alert("엔터했어요~~");
			    	  // alert($btn.text()); // "완료"
			    		 $btn.click();
			    	}
			    });
			}
			
			else if($(e.target).text() == "완료"){
			  // alert("댓글수정완료");
			  // alert($(e.target).parent().children("input").val()); // 수정해야할 댓글시퀀스 번호 
			  // alert($(e.target).parent().parent().children("div:nth-child(2)").children().children("input").val()); // 수정후 댓글내용
			     const content = $(e.target).parent().parent().children("div:nth-child(2)").children().children("input").val(); 
			  
			     $.ajax({
			    	 url:"${pageContext.request.contextPath}/updateComment2.action",
			    	 type:"post",
			    	 data:{"gymquestionseq":$(e.target).parent().children("input").val(),
			    		   "content":content},
			    	 dataType:"json",
			    	 success:function(json){
			    	   $(e.target).parent().parent().children().children('#comment_text').html(content);

			           goReadComment();  // 페이징 처리 안한 댓글 읽어오기
			    		
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
		
		
		// ===== 댓글수정취소 / 댓글삭제 ===== //
		$(document).on("click", "button.btnDeleteComment", function(e){
			if($(e.target).text() == "취소"){
			 // alert("댓글수정취소");
			 //	alert($(e.target).parent().parent().children("div:nth-child(2)").children().html());
			    const $content = $(e.target).parent().parent().children("div:nth-child(2)").children(); 
			    $content.html(`\${origin_comment_content}`);
			 
			    $(e.target).text("삭제");
		    	$(e.target).prev().text("수정"); 
			}
			
			else if($(e.target).text() == "삭제"){
			  // alert("댓글삭제");
			  // alert($(e.target).next().val()); // 삭제해야할 댓글시퀀스 번호 
				
			     if(confirm("정말로 삭제하시겠습니까?")){
				     $.ajax({
				    	 url:"${pageContext.request.contextPath}/deleteComment2.action",
				    	 type:"post",
				    	 data:{"gymquestionseq":$(e.target).next().val(),
				    		   "parentSeq":"1"},
				    	 dataType:"json",
				    	 success:function(json){
				    	 	 goReadComment();  // 페이징 처리 안한 댓글 읽어오기
				    	 //  goViewComment(1); // 페이징 처리 한 댓글 읽어오기
				    	 },
				    	 error: function(request, status, error){
						    alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
						 }
				     });
			     }
			}
		}); 
		
		
		
		
		
		// ===== 답글쓰기 ===== //
		$(document).on("click", "button.btnReply", function(e){
			
			   // alert("답글쓰기");
			  
			   const gymquestionseq = $(e.target).parent().children("input").val();
			   //alert(gymquestionseq);
			   let v_html = "";
			   
			   if($(e.target).parent().children(".input_reply").html() == ""){
				   $(".input_reply").html("");
				   v_html += "<div>";
				   v_html += "<form name='recommentFrm'>";
    			   v_html += "<textarea name='content_reply' style='font-size: 12pt; width: 100%; height: 60px;'></textarea>";
    			   v_html += "<div style='text-align: right; font-size: 12pt;'>";
    			   v_html += "<button type='button' class='btn btn-outline-secondary' id='btnCommentOK' style='margin: auto; padding: 0.5% 1.5%;' onclick='goAddWritere("+gymquestionseq+")'>";
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
			    const $content = $(e.target).parent().parent().children('div#content_reply');
			    origin_recomment_content = $(e.target).parent().parent().children('div#content_reply').text();
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
			   alert($(e.target).parent().children("input").val()); // 수정해야할 댓글시퀀스 번호 
			   alert($(e.target).parent().parent().children("div:nth-child(2)").children("input").val()); // 수정후 댓글내용
			   	 const gymquestionseq = $(e.target).parent().parent().parent().parent().children("form").children("input").val()
			     const gymanswerseq = $(e.target).parent().children("input").val()
			     const content_reply = $(e.target).parent().parent().children("div:nth-child(2)").children("input").val(); 
			  
			  //alert($(e.target).parent().children("input").val());
			  
			     $.ajax({
			    	 url:"${pageContext.request.contextPath}/updateReComment2.do",
			    	 type:"post",
			    	 data:{"gymanswerseq":gymanswerseq,
			    		   "content_reply":content_reply},
			    	 dataType:"json",
			    	 success:function(json){
			    	   $(e.target).parent().parent().children('#content_reply').html(content_reply);

			    	   readcommentreply(gymquestionseq);  // 페이징 처리 안한 댓글 읽어오기
			    		
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
			  
			  const gymquestionseq = $(e.target).parent().parent().parent().parent().children("form").children("input").val();
			  
			     if(confirm("정말로 삭제하시겠습니까?")){
				     $.ajax({
				    	 url:"${pageContext.request.contextPath}/deleteReComment2.do",
				    	 type:"post",
				    	 data:{"gymanswerseq":$(e.target).next().val(),
				    		   "gymquestionseq":$(e.target).parent().parent().parent().parent().children("form").children("input").val()},
				    	 dataType:"json",
				    	 success:function(json){
				    		 readcommentreply(gymquestionseq);  // 페이징 처리 안한 댓글 읽어오기
				    	 //  goViewComment(1); // 페이징 처리 한 댓글 읽어오기
				    	 },
				    	 error: function(request, status, error){
						    alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
						 }
				     });
			     }
			}
		}); 
		
		

		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new kakao.maps.LatLng(${gym.lat}, ${gym.lng}), // 지도의 중심좌표
	        level: 4 // 지도의 확대 레벨
	    };

	var map = new kakao.maps.Map(mapContainer, mapOption);

	// 마커가 표시될 위치입니다 
	var markerPosition  = new kakao.maps.LatLng(${gym.lat}, ${gym.lng}); 

	// 마커를 생성합니다
	var marker = new kakao.maps.Marker({
	    position: markerPosition
	});

	// 마커가 지도 위에 표시되도록 설정합니다
	marker.setMap(map);

	var iwContent = '<div style="padding:5px;">${gym.gymname} <br><a href="https://map.kakao.com/link/map/Hello World!,33.450701,126.570667" style="color:blue" target="_blank">큰지도보기</a> <a href="https://map.kakao.com/link/to/Hello World!,33.450701,126.570667" style="color:blue" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
	    iwPosition = new kakao.maps.LatLng(${gym.lat}, ${gym.lng}); //인포윈도우 표시 위치입니다

	// 인포윈도우를 생성합니다
	var infowindow = new kakao.maps.InfoWindow({
	    position : iwPosition, 
	    content : iwContent 
	});
	  
	// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
	infowindow.open(map, marker); 
       
	});// end of $(document).ready(function(){})-----------------

	
	
	
	
   let popup; // 추가이미지 파일을 클릭했을때 기존에 띄어진 팝업창에 추가이미지가 또 추가되지 않도록 하기 위해 밖으로 뺌.   
	   
   function openPopup() {
	   
	 // alert(src);
	 
 	 if(popup != undefined) { // 기존에 띄어진 팝업창이 있을 경우 
 		 popup.close(); // 팝업창을 먼저 닫도록 한다.
 	 }
	    
	 // 너비 800, 높이 480 인 팝업창을 화면 가운데 위치시키기
		const width = 800;
		const height = 480;
	    const left = Math.ceil((window.screen.width - width) /2);  // 정수로 만듬 
	    const top = Math.ceil((window.screen.height - height )/2); // 정수로 만듬
		
	    popup = window.open("", "imgInfo", 
		                    `left=\${left}, top=\${top}, width=\${width}, height=\${height}`);
	    
	    popup.document.writeln("<html>");
	    popup.document.writeln("<head><title>제품이미지 확대보기</title></head>");
	    popup.document.writeln("<body align='center'>");
	    popup.document.writeln("<img src='<%=ctxPath%>/resources/images/다운로드.jpg' />");
	    popup.document.writeln("<br><br><br>");
	    popup.document.writeln("<button type='button' onclick='window.close()'>팝업창닫기</button>");
	    popup.document.writeln("</body>");
	    popup.document.writeln("</html>");
	    
   }// end of function openPopup(src)-------------------

   
   function modal_content(){
	 // alert("모달창속에 이미지를 넣어주어야 합니다.ㅎㅎㅎ");
	 // alert(img.src);
	 $("div#add_image_modal-body").html("<img class='d-block img-fluid' src='<%=ctxPath%>/resources/images/다운로드.jpg' />"); 
   }// end of function modal_content(img)------
   
   
   
   
   // !! 인포윈도우를 표시하는 클로저(closure => 함수 내에서 함수를 정의하고 사용하도록 만든것)를 만드는 함수(카카오에서 제공해준것임)입니다 !! // 
   function makeOverListener(mapobj, marker, infowindow, infowindowArr) {           
 	    return function() {
 	    	// alert("infowindow.getZIndex()-1:"+ (infowindow.getZIndex()-1));
 	    	
 	    	for(var i=0; i<infowindowArr.length; i++) {
 	    		if(i == infowindow.getZIndex()-1) {
 	    			infowindowArr[i].open(mapobj, marker);
 	    		}
 	    		else{
 	    			infowindowArr[i].close();
 	    		}
 	    	}
 	    };
 	}// end of function makeOverListener(mapobj, marker, infowindow, infowindowArr)--------
   
   
 	
 	document.addEventListener('DOMContentLoaded', function() {
 	    // 공간정보 버튼 클릭 시
 	    document.querySelector('.space-info').addEventListener('click', function() {
 	        scrollToSection('space-info-section');
 	    });

 	    // 주의사항 버튼 클릭 시
 	    document.querySelector('.caution').addEventListener('click', function() {
 	        scrollToSection('caution-section');
 	    });

 	    // 추가정보 버튼 클릭 시
 	    document.querySelector('.additional-info').addEventListener('click', function() {
 	        scrollToSection('additional-info-section');
 	    });

 	    // 문의 버튼 클릭 시
 	    document.querySelector('.inquiry').addEventListener('click', function() {
 	        scrollToSection('inquiry-section');
 	    });

 	    // 스크롤 함수 정의
 	    function scrollToSection(sectionId) {
 	        var section = document.getElementById(sectionId);
 	        if (section) {
 	            // 해당 섹션의 위치로 스크롤
 	            section.scrollIntoView({ behavior: 'smooth' });
 	        }
 	    }
 	  });
 	//좋아요 버튼 
//heart 좋아요 클릭시! 하트 뿅
$(function(){
    var $likeBtn =$('.icon.heart');

        $likeBtn.click(function(){
        $likeBtn.toggleClass('active');

        if($likeBtn.hasClass('active')){          
           $(this).find('img').attr({
              'src': 'https://cdn-icons-png.flaticon.com/512/803/803087.png',
               alt:'찜하기 완료'
                });
          
          
         }else{
            $(this).find('i').removeClass('fas').addClass('far')
           $(this).find('img').attr({
              'src': 'https://cdn-icons-png.flaticon.com/512/812/812327.png',
              alt:"찜하기"
           })
         }
     })
})

 	
//== 댓글쓰기 == //
function goAddWrite(){
   
	const comment_content = $("textarea[name='content']").val().trim();
	if(comment_content == ""){
		alert("댓글 내용을 입력하세요!!");
		return; // 종료
	}
	
	if($("input:hidden[name='fk_userid']").val()==""){
		alert("로그인을 먼저 하셔야합니다!");
		return;
	}
	
	goAddWrite_noAttach();
	
	
}// end of fucntion goAddWrite(){}------------------




function goAddWrite_noAttach(){
	
	<%--
        // 보내야할 데이터를 선정하는 또 다른 방법
        // jQuery에서 사용하는 것으로써,
        // form태그의 선택자.serialize(); 을 해주면 form 태그내의 모든 값들을 name값을 키값으로 만들어서 보내준다. 
        const queryString = $("form[name='addWriteFrm']").serialize();
    --%>

    const queryString = $("form[name='commentFrm']").serialize();
    
	$.ajax({
		url:"<%= ctxPath%>/addComment2.do",
	/*
		data:{"fk_userid":$("input:hidden[name='fk_userid']").val() 
             ,"name":$("input:text[name='name']").val() 
             ,"content":$("input:text[name='content']").val()
             ,"parentSeq":$("input:hidden[name='parentSeq']").val()},
    */
    	// 또는
    	data:queryString,
    	type:"post",
        dataType:"json",
        success:function(json){
       		console.log(JSON.stringify(json));
          
           	
           	if(json.n == 0){
           		alert(json.name + "님의 포인트는 300점을 초과할 수 없으므로 댓글쓰기가 불가합니다.");
           	}
           	else{
           		goReadComment(); 					// 페이징 처리 안한 댓글 읽어오기
           		//goViewComment(1)	// 페이징 처리한 댓글 읽어오기
           	}
           	
           	$("textarea[name='comment_text']").val("");
       },
       error: function(request, status, error){
           alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
       }
	})
}// end of function goAddWrite_noAttach(){}--------------------------






function goReadComment(){	
	$.ajax({
		url:"<%= ctxPath%>/readComment2.action",
		data:{"parentSeq":"${gym.gymseq}"},
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
		    	        v_html += "<div style='width: 6%;'><img class='profile-img' src='<%=ctxPath%>/resources/images/" + item.memberimg + "'></div>";
		    	    }
		    	    v_html += "<div style='width: 85%;'>";
		    	    v_html += "<div style='font-size:12pt; font-weight: bold; margin-bottom: 2.3%;'>" + item.fk_userid + "</div>";
		    	    v_html += "<div style='width: 100%;'>";
		    	    v_html += "<div id='content'>" + item.content + "</div>";
		    	    v_html += "</div>";
		    	    v_html += "<div class='comment' style='color:#999999; font-size:10pt; margin-top: 2%;'>" + item.registerdate; 
		    	    if(item.changestatus > 0){
		    	    	v_html += " (수정됨)";
		    	    }
		    	    v_html += " &nbsp;&nbsp;<button class='btnReply' style='background: none; border: none; color: inherit; font: inherit; cursor: pointer; padding: 0;'>답글쓰기</button>";
		    	    if (${sessionScope.loginuser != null} && "${sessionScope.loginuser.userid}" == item.fk_userid) {
		    	        v_html += "<br><button class='btnUpdateComment' style='background: none; border: none; color: inherit; font: inherit; cursor: pointer; padding: 0;'>수정</button>&nbsp;&nbsp;<button class='btnDeleteComment' style='background: none; border: none; color: inherit; font: inherit; cursor: pointer; padding: 0;'>삭제</button>";
		    	    }
		    	    v_html += "<input type='hidden' value='"+item.gymquestionseq+"' />"
		    	    v_html += "<div class='input_reply' style='width: 100%;'>";
		    	    v_html += "</div>";
		    	    
		    	    
		    	    
		    	    v_html += "</div>";
		    	    v_html += "</div>";
		    	    v_html += "</div>";
		    	    
		    	    v_html += "<form name='commentreFrm'>";
		    	    v_html += "<input type='hidden' id='flmkcmseq' name='gymquestionseq' value='"+item.gymquestionseq+"' />";
		    	    v_html += "</form>";

		    	    
		    	    
		    	    v_html += "<div class='content_reply"+item.gymquestionseq+"'>";
		    	    v_html += "</div>";
		    	    v_html += "</div>";
		    	    
		    	    readcommentreply(item.gymquestionseq);
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


function readcommentreply(gymquestionseq){
	
	  
	  $.ajax({
			url:"<%= ctxPath%>/addReplyComment2.action",
		
			//data:{"fk_userid":$("input:hidden[name='fk_userid']").val()},
	    
	    	// 또는
	    	data:{"gymquestionseq":gymquestionseq},
	    	type:"post",
            dataType:"json",
            success:function(json){
           	console.log(JSON.stringify(json));
      
           	
            	let v_html = "";
			    if(json.length > 0){
			    	$.each(json, function(index, item) {
			    	    v_html += "<div style='display: flex; margin: 4% 0 4% 5%; background-color: #d3d3d3;'>";
			    	    v_html += "<div style='width: 6%;'><img class='profile-img' style='width: 50%; height: 50%;' src='<%=ctxPath%>/resources/images/reply.png'></div>";
			    	    if (item.memberimg == null) {
			    	        v_html += "<div style='width: 6%;'><img class='profile-img' src='<%=ctxPath%>/resources/images/기본이미지.png'></div>";
			    	    }
			    	    if (item.memberimg != null) {
			    	        v_html += "<div style='width: 6%;'><img class='profile-img' src='<%=ctxPath%>/resources/images/" + item.memberimg + "'></div>";
			    	    }
			    	    v_html += "<div style='display: flex; margin-top:0.7%; margin-left: 2%; width: 120% '>";
			    	    v_html += "<div style='font-size:12pt; font-weight: bold; margin-bottom: 1.5%;'>" + item.fk_userid + "</div>";
			    	    v_html += "<div id='content_reply' style='margin-left: 2%; text-align: left;'>" + item.content_reply + "</div>";
			    	    v_html += "<div class='comment' style='color:#999999; font-size:10pt; margin-top: 0.4%; margin-left: 1.5%; display: flex; width: 50%;'>" + item.registerdate; 
			    	    if(item.changestatus > 0){
			    	    	v_html += " (수정됨)";
			    	    }
			    	    
			    	    if (${sessionScope.loginuser != null} && "${sessionScope.loginuser.userid}" == item.fk_userid) {
			    	        v_html += "<button class='btnUpdateReComment' style='margin-left: 3%; margin-bottom: 4.5%; background: none; border: none; color: inherit; font: inherit; cursor: pointer; padding: 0;'>수정</button>&nbsp;&nbsp;<button class='btnDeleteReComment' style='margin-bottom: 4.5%; background: none; border: none; color: inherit; font: inherit; cursor: pointer; padding: 0;'>삭제</button>";
			    	    }
			    	    v_html += "<input type='hidden' value='"+item.gymanswerseq+"' />"
			    	    v_html += "</div>";
			    	    v_html += "</div>";
			    	    v_html += "</div>";
			    	    
			    	    v_html += "<form name='commentreFrm'>";
			    	    v_html += "<input type='hidden' name='gymquestionseq' value='"+gymquestionseq+"' />";
			    	    v_html += "</form>";
			    	    
			    	    v_html += "<div class='content_reply'>";
			    	    v_html += "</div>";
			    	});
			    }
			    
			    $("div.content_reply"+gymquestionseq+"").html(v_html);
			},
			error: function(request, status, error){
			   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		})
}



// == 딥글쓰기 == //
function goAddWritere(gymquestionseq){
   
	// alert($("input[name='fleamarketcommentseq']").val());
	// const fleamarketcommentseq = $("input[name='fleamarketcommentseq']").val();
	const content_reply = $("textarea[name='content_reply']").val().trim();
	if(content_reply == ""){
		alert("댓글 내용을 입력하세요!!");
		return; // 종료
	}
	if($("input:hidden[name='fk_userid']").val()==""){
		alert("로그인을 먼저 하셔야합니다!");
		return;
	}
	
	
	goAddWrite_reply(gymquestionseq);
	
	
}// end of fucntion goAddWrite(){}------------------


function goAddWrite_reply(gymquestionseq){
	
	const queryString = $("form[name='recommentFrm']").serialize();
    //console.log(fleamarketcommentseq);
	$.ajax({
		url:"<%= ctxPath%>/addReComment2.do",
	
		data:{"fk_userid":$("input:hidden[name='fk_userid']").val() 
             ,"content_reply":$("textarea[name='content_reply']").val() 
             ,"gymquestionseq":gymquestionseq},
    
    	type:"post",
        dataType:"json",
        success:function(json){
       	//console.log(JSON.stringify(json));
       	//
       	//또는
       	//
       	
       	if(json.n == 0){
       		alert(json.name + "오류가 발생했습니다.");
       	}
       	else{
       		readcommentreply(gymquestionseq);
       		$(".input_reply").html("");
       	}
       	
       	$("textarea[name='content_reply']").val("");
       },
       error: function(request, status, error){
           alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
       }
	})
}
 	
</script>





<hr>



<div class="container mt-5">
  <div class="row">
    <div class="col-lg-8">
      <!-- 큰 사진 부분 -->
      <a href="#" data-toggle="modal" data-target="#myModal">
        <img src="<%=ctxPath%>/resources/images/1/${gym.filename}" class="img-fluid" alt="큰 사진" style="width: 100%; height: 500px;">
      </a>
    </div>
    <div class="col-lg-4">
      <!-- 작은 사진 4개 부분 -->
      <div class="row">
        <c:forEach items="${requestScope.gymImgList}" var="img">
        <div class="col-6 mb-3">
          <a href="#" data-toggle="modal" data-target="#myModal">
            <img src="<%=ctxPath%>/resources/images/1/${img.filename}" class="img-fluid" alt="작은 사진 1" style="width: 100%; height: 225px;">>
          </a>
        </div>
     </c:forEach>
      </div>
    </div>
  </div>
</div>


<!-- 모달 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="myModalLabel">사진 보기</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <!-- 카루젤 시작 -->
        <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
          <ol class="carousel-indicators">
            <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
            <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
            <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
            <li data-target="#carouselExampleIndicators" data-slide-to="3"></li>
          </ol>
          <div class="carousel-inner">
            <div class="carousel-item active">
              <img class="d-block w-100" src="<%=ctxPath%>/resources/images/1/${gym.filename}" alt="첫 번째 사진" style="width: 100%; height: 700px;">
            </div>
            <c:forEach items="${requestScope.gymImgList}" var="img">
            <div class="carousel-item">
              <img class="d-block w-100" src="<%=ctxPath%>/resources/images/1/${img.filename}" alt="두 번째 사진" style="width: 100%; height: 700px;">
            </div>
            </c:forEach>

          </div>
          <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">이전</span>
          </a>
          <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">다음</span>
          </a>
        </div>
        <!-- 카루젤 끝 -->
      </div>
    </div>
  </div>
</div>

<div class="container">
  <div class="row">
   	
    <div class="col-md-6 pl-3 pr-3">
      <ul class="list-unstyled">
        <div> 📍${gym.address}</div>
        <br>
        <li style="font-size: 20px; font-family: 'Volt110', sans-serif; font-weight: 700;">${gym.gymname}</li>
        <hr>
        <li style="color: #bfbfbf; ">👀 조회수  |  🕓 올린시간</li>
        <br>
        <li>
          <span style="font-size: 14px; color: #8c8c8c;" >담장자 아이디</span>
          <span style="font-size: 14px; margin-left: 4%; font-family: 'Volt220', sans-serif; font-weight: 700; ">${gym.fk_userid}</span>
        </li>
        <li>
          <span style="font-size: 14px; color: #8c8c8c;" >인원</span>
          <span style="font-size: 14px; margin-left: 4%; font-family: 'Volt220', sans-serif; font-weight: 700; ">${gym.membercount}</span>
        </li>
      </ul>
    </div>

    <div class="col-md-6">
      <div class="info-box">
        <div class="payment-box">
          <div class="payment-options">
            <div class="form-group">
              <div class="custom-control custom-checkbox">
                <input type="checkbox" class="custom-control-input" id="checkbox-sports">
                <label class="custom-control-label" for="checkbox-sports">생활체육 - ${gym.cost}원 / 1시간 [2시간부터]</label>
              </div>
            </div>
            <hr>
          </div>
        </div>
      </div>

      <!-- 예약하기 버튼과 하트 표시 버튼 -->
      
      <div class="action-buttons" style="display:flex;">
	      <div class="right_area">
	        <a href="javascript:;" class="icon heart">
	        <img src="https://cdn-icons-png.flaticon.com/512/812/812327.png" alt="찜하기"> 
	        </a>
	      </div>
	         <button class="btn btn-success" style="padding: 10px 200px;" onclick="javascript:location.href='<%= ctxPath%>/gym/gymPay.do?gymseq=${gym.gymseq}'">예약하기</button>
      </div>
    
  </div>
</div>
</div>


	<hr>

    <div class="button-container">
        <button class="button space-info">공간정보</button>
        <button class="button caution">주의사항</button>
        <button class="button additional-info">추가정보</button>
        <button class="button inquiry">문의</button>
    </div>

	
	<hr>
	
	<div id="space-info-section">
	 	<h3 style="margin-top: 50px;">공간정보</h3>
		<br>
			<div>
			${gym.info}
		
			</div>
	
			<div style="width: 50%; margin: 5% auto;">
			
			 <c:forEach items="${requestScope.gymImgList}" var="img">	
			<img src="<%=ctxPath%>/resources/images/1/${img.filename}" class="img-fluid"style="width: 100%;" /> 하이
			</c:forEach>
				
			</div>
	</div>
	<br>
	
	
	<div id="caution-section">
	<hr>
	<%-- === 주의사항  보여주기 === --%>
	<h3 style="margin-top: 50px;">주의사항</h3>
	<br>
	${gym.caution}
	</div>
	
<br>
	
	
	<hr>
    <div id="additional-info-section">
			<%-- === 추가정보  보여주기 === --%>
		<h3 style="margin-top: 50px;">추가정보</h3>
		<br>
	
		<div id="title">위치</div>
	 	<div id="map" style="width:90%; height:600px;"></div>
	 	<div id="latlngResult"></div> 
	 	<br>
	 	<div> 📍${gym.address}</div>
 	</div>
 	
 	
 	
	<br>


		<%-- === 문의 내용 보여주기 === --%>
	<div id="inquiry-section" class="text-left">
			<hr>
			<h3 style="margin-top: 50px;">문의</h3>
	 		 	<select name="" id="">
	 		    <option value="default">문의 유형을 선택하세요</option>
   			 	<option value="0">가격문의</option>
    			<option value="1">일정문의</option>
    			<option value="2">공간정보문의</option>
   				<option value="3">물품이용문의</option>
   				<option value="4">기타</option>
   			 </select>
   			 <br>
		
	<%-- === #94. 댓글 내용 보여주기 === --%>
     
     <div>
		<form name="commentFrm">
			<div>
				<textarea name="content" style="font-size: 12pt; width: 100%; height: 100px;"></textarea>
				<input class="userid" type="hidden" name="fk_userid" value="${sessionScope.loginuser.userid}" />
				<input type="hidden" name="name" value="${sessionScope.loginuser.name}" />
				<input type="hidden" name="gymseq" value="${requestScope.gym.gymseq}" />
				
			</div>
			<div style="text-align: right; font-size: 12pt;">
				<button type="button" class="btn btn-outline-secondary"
					id="btnCommentOK" style="margin: auto;" onclick="goAddWrite()">
					<span style="font-size: 10pt;">등록</span>
				</button>
			</div>
		</form>
	</div>

		<%-- === 댓글 내용 보여주기 === --%>
   	     <div id="commentView" >
    
		</div>
	
   
   
   
   
    <%--  <h3 style="margin-top: 50px;">문의내용</h3>
      <div>
	      <table class="table" style="font-size: 12px;">
	         <thead>
	         	<tr>
	         		<th style="twidth: 1%;">순번</th>
		            <th style="width: 1%; text-align: center;">작성유형</th>
		            <th style="text-align: center;">내용</th>
		            <th style="width: 8%; text-align: center;">작성자</th>
		            <th style="width: 12%; text-align: center;">작성일자</th>
		            <th style="width: 12%; text-align: center;">수정/삭제</th>
	         	</tr>
	         </thead>
	         <tbody id="commentDisplay"></tbody>
	      </table>
      </div> --%> 
      
      <%-- #155. 댓글페이지바가 보여지는 곳 === --%>
      <div style="display: flex; margin-bottom: 50px;">
          <div id="pageBar" style="margin: auto; text-align: center;"></div>
       </div>
	</div>
	
	<div>
	 <br>
	${gym.lng}
	</div>
	<%-- CSS 로딩화면 구현한것--%>
	<div
		style="display: flex; position: absolute; top: 30%; left: 37%; border: solid 0px blue;">
		<div class="loader" style="margin: auto"></div>
	</div>


	<div>
		<p id="order_error_msg"
		class="text-center text-danger font-weight-bold h4"></p>
	</div>



	

	





