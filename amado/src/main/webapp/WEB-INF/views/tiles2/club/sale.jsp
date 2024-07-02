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

.carousel-inner .carousel-item.active,
		.carousel-inner .carousel-item-next,
		.carousel-inner .carousel-item-prev {
		  display: flex;
		}
		
		.carousel-inner .carousel-item-right.active,
		.carousel-inner .carousel-item-next {
		  transform: translateX(25%);
		}
		
		.carousel-inner .carousel-item-left.active, 
		.carousel-inner .carousel-item-prev {
		  transform: translateX(-25%);
		}
		  
		.carousel-inner .carousel-item-right,
		.carousel-inner .carousel-item-left{ 
		  transform: translateX(0);
		}
</style>

<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/myshop/categoryListJSON.js"></script>

<script type="text/javascript">


	$(document).ready(function(){
	
		
		// ======= 추가이미지 캐러젤로 보여주기(Bootstrap Carousel 4개 표시 하되 1번에 1개 진행) 시작 ======= //
	 	   $('div#recipeCarousel').carousel({
	        	interval : 2000  <%-- 2000 밀리초(== 2초) 마다 자동으로 넘어가도록 함(2초마다 캐러젤을 클릭한다는 말이다.) --%>
	       });

	       $('div.carousel div.carousel-item').each(function(index, elmt){
	    	   <%--
	    	        console.log($(elmt).html());
	    	   --%>    
	    	   <%--      
	    	       <img class="d-block col-3 img-fluid" src="/MyMVC/images/berkelekle단가라포인트033.jpg">
	    	       <img class="d-block col-3 img-fluid" src="/MyMVC/images/berkelekle덩크043.jpg">
	    	       <img class="d-block col-3 img-fluid" src="/MyMVC/images/berkelekle트랜디053.jpg">
	    	       <img class="d-block col-3 img-fluid" src="/MyMVC/images/berkelekle디스트리뷰트063.jpg">
	    	   --%>
	    	   
	    	    let next = $(elmt).next();      <%--  다음엘리먼트    --%>
	       <%-- console.log(next.length); --%>  <%--  다음엘리먼트개수 --%>
	       <%--  1  1  1  0   --%>
	       
	       <%-- console.log("다음엘리먼트 내용 : " + next.html()); --%>
	       <%--     
		        다음엘리먼트 내용 : <img class="d-block col-3 img-fluid" src="/MyMVC/images/berkelekle덩크043.jpg">
		        다음엘리먼트 내용 : <img class="d-block col-3 img-fluid" src="/MyMVC/images/berkelekle트랜디053.jpg">
		        다음엘리먼트 내용 : <img class="d-block col-3 img-fluid" src="/MyMVC/images/berkelekle디스트리뷰트063.jpg">
		        다음엘리먼트 내용 : undefined
	       --%>    
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
	    
	    
	    $('#recipeCarousel').carousel({
        	  interval :2000
        	});

        	$('.carousel .carousel-item').each(function(){
        	    var next = $(this).next();
        	    if (!next.length) {
        	        next = $(this).siblings(':first');
        	    }
        	    next.children(':first-child').clone().appendTo($(this));
        	    
        	    for (var i=0;i<2;i++) {
        	        next=next.next();
        	        if (!next.length) {
        	        	next = $(this).siblings(':first');
        	      	}
        	        
        	        next.children(':first-child').clone().appendTo($(this));
        	      }
        	});
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
	    const left = Math.ceil((window.screen.width - width)/2);  // 정수로 만듬 
	    const top = Math.ceil((window.screen.height - height)/2); // 정수로 만듬
		
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
   
   
   
   
	// == 댓글쓰기 == //
	function goAddWrite(){
	   
		const comment_content = $("textarea[name='content']").val().trim();
		if(comment_content == ""){
			alert("댓글 내용을 입력하세요!!");
			return; // 종료
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
			url:"<%= ctxPath%>/addComment.action",
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
           	//{"name":"최준혁","n":1}
           	//또는
           	//{"name":"최준혁","n":0}
           	
           	if(json.n == 0){
           		alert(json.name + "님의 포인트는 300점을 초과할 수 없으므로 댓글쓰기가 불가합니다.");
           	}
           	else{
           		//goReadComment(); 					// 페이징 처리 안한 댓글 읽어오기
           		//goViewComment(1)	// 페이징 처리한 댓글 읽어오기
           	}
           	
           	$("textarea[name='content']").val("");
           },
           error: function(request, status, error){
               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
           }
		})
	}// end of function goAddWrite_noAttach(){}--------------------------
   
   
</script>

<div style="font-weight: bolder; font-size: 10pt;">
	<img style="width: 1.2%; margin-bottom: 0.2%;" src="<%=ctxPath%>/resources/images/홈.png">
	<a style="text-decoration: none; color: black;" href="<%=ctxPath%>/club/oldshop.do">&nbsp;플리마켓 홈</a>
</div>
<hr>
<div style="width: 70%; margin: 0 auto;">

	<div class="row my-5 text-left">
		
	
		<div class="col-md-6">
			<div>
				<div>
					<div style="width: 400%;">
						<%-- <img src="<%=ctxPath%>/resources/images/다운로드.jpg" style="width: 100%;" /> --%>
						<img class="d-block col-3 img-fluid" src="<%=ctxPath%>/resources/images/다운로드.jpg" style="cursor: pointer;" onclick="openPopup()" />
					</div>
				</div>
			</div>
		</div>

		<div class="col-md-6 pl-5">
			<ul class="list-unstyled">
				<li style="font-size: 25px; font-family: 'Roboto', sans-serif; font-weight: 700;">호날두가 신었던 축구화 팝니다!!</li>
				<li style="font-size: 32px; font-family: 'Roboto', sans-serif; font-weight: 1000;">50,000,000 원</li>
				<hr>
				<li style="color: #bfbfbf; ">👀 조회수  |  🕓 올린시간</li>
				<br>
				<li>
					<span style="font-size: 14px; color: #8c8c8c;" >거래방법</span>
					<span style="font-size: 14px; margin-left: 4%; font-family: 'Volt220', sans-serif; font-weight: 700; ">직거래</span>
				</li>
				<li>
					<span style="font-size: 14px; color: #8c8c8c;" >직거래 지역</span>
					<span style="font-size: 14px; margin-left: 4%; font-family: 'Volt220', sans-serif; font-weight: 700; ">우리집 앞까지 오셔요</span>
				</li>
			</ul>

		</div>
		
		
	</div>
	<hr>
	<div style="font-weight: bold">
		연관상품
		<img style="width: 3%;" src="<%=ctxPath%>/resources/images/추천.png">
	</div>
	
	<div class="container text-center my-4">
	    <div class="row mx-auto my-auto">
	        <div id="recipeCarousel" class="carousel slide w-100" data-ride="carousel">
	            <div class="carousel-inner w-100" role="listbox">
	                <div class="carousel-item active">
	                    <img class="d-block col-3 img-fluid" src="<%=ctxPath%>/resources/images/다운로드.jpg">
	                </div>
	                <div class="carousel-item">
	                    <img class="d-block col-3 img-fluid" src="<%=ctxPath%>/resources/images/다운로드.jpg">
	                </div>
	                <div class="carousel-item">
	                    <img class="d-block col-3 img-fluid" src="<%=ctxPath%>/resources/images/다운로드.jpg">
	                </div>
	                <div class="carousel-item">
	                    <img class="d-block col-3 img-fluid" src="<%=ctxPath%>/resources/images/다운로드.jpg">
	                </div>
	                <div class="carousel-item">
	                    <img class="d-block col-3 img-fluid" src="<%=ctxPath%>/resources/images/다운로드.jpg">
	                </div>
	                <div class="carousel-item">
	                    <img class="d-block col-3 img-fluid" src="<%=ctxPath%>/resources/images/다운로드.jpg">
	                </div>
	                <div class="carousel-item">
	                    <img class="d-block col-3 img-fluid" src="<%=ctxPath%>/resources/images/다운로드.jpg">
	                </div>
	                <div class="carousel-item">
	                    <img class="d-block col-3 img-fluid" src="<%=ctxPath%>/resources/images/다운로드.jpg">
	                </div>
	            </div>
	            <a class="carousel-control-prev" href="#recipeCarousel" role="button" data-slide="prev">
	                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
	                <span class="sr-only">Previous</span>
	            </a>
	            <a class="carousel-control-next" href="#recipeCarousel" role="button" data-slide="next">
	                <span class="carousel-control-next-icon" aria-hidden="true"></span>
	                <span class="sr-only">Next</span>
	            </a>
	        </div>
	    </div>
	</div>
		
	
	<hr>
	
	<div style="width: 50%; margin: 10% auto 15% auto;">
			<img src="<%=ctxPath%>/resources/images/다운로드1.jpg" class="img-fluid"
				style="width: 100%;" /> 제가 직접 신었답니다ㅎㅎ
				
			<img src="<%=ctxPath%>/resources/images/다운로드2.jpg" class="img-fluid"
			style="width: 100%;" /> 내가 바로 크리스티아누 호우~
	</div>
	
	<div style="font-size: 11pt;">
		<img style="width: 3%; margin-bottom: 0.2%;" src="<%=ctxPath%>/resources/images/댓글.png">
		댓글
	</div>
	
	<hr>
	
	
	<div class="text-left">
	
	<%-- === #94. 댓글 내용 보여주기 === --%>
     
    <div style="display: flex; margin: 5% 0;">
    	
		  <img style="width: 8%; height: 3%;" src="<%=ctxPath%>/resources/images/real_madrid.png">
		
		  <div>
     		 <div style="font-size:12pt; font-weight: bold; margin-bottom: 3%;">호우마드리드</div>
     		 <div>안녕하세요! 혹시 발냄새는 안나나요?</div>
     		 <div style="color:#999999; font-size:10pt; margin-top: 3%;">2024.07.01. 14:57 &nbsp;&nbsp;<a>답글쓰기</a></div>
     	  </div>
    </div>

	<div>
		<form name="commentFrm">
			<div>
				<textarea name="content" style="font-size: 12pt; width: 100%; height: 100px;"></textarea>
				<input type="text" name="fk_userid" value="${sessionScope.loginuser.userid}" /> 
				<input type="text" name="name" value="${sessionScope.loginuser.name}" />
				<input type="text" name="fleamarketseq" value="${requestScope.pvo.pnum}" />
			</div>
			<div style="text-align: right; font-size: 12pt;">
				<button type="button" class="btn btn-outline-secondary"
					id="btnCommentOK" style="margin: auto;" onclick="goAddWrite()">
					<span style="font-size: 10pt;">등록</span>
				</button>
			</div>
		</form>
	</div>

	
      
      <%-- #155. 댓글페이지바가 보여지는 곳 === --%>
      <div style="display: flex; margin-bottom: 50px;">
          <div id="pageBar" style="margin: auto; text-align: center;"></div>
       </div>
	</div>
	
	
	<%-- CSS 로딩화면 구현한것--%>
	<div
		style="display: flex; position: absolute; top: 30%; left: 37%; border: solid 0px blue;">
		<div class="loader" style="margin: auto"></div>
	</div>

	<%-- === 추가이미지 보여주기 시작 === --%>
	<c:if test="${not empty requestScope.imgList}">
		<%-- === 그냥 이미지로 보여주는 것 시작 === --%>
		<%-- 
	   <div class="row">
		  <c:forEach var="imgfilename" items="${requestScope.imgList}">
			 <div class="col-md-6 my-3">
			    <img src="${pageContext.request.contextPath}/images/${imgfilename}" class="img-fluid" style="width:100%;" />
			 </div>
		  </c:forEach>
	   </div>
	   --%>
		<%-- === 그냥 이미지로 보여주는 것 끝 === --%>

		<%-- /////// 추가이미지 캐러젤로 보여주는 것 시작 //////// --%>
		<div class="row mx-auto my-auto" style="width: 100%;">
			<div id="recipeCarousel" class="carousel slide w-100"
				data-ride="carousel">
				<div class="carousel-inner w-100" role="listbox">
					<c:forEach var="imgfilename" items="${requestScope.imgList}"
						varStatus="status">
						<c:if test="${status.index == 0}">
							<div class="carousel-item active">
								<%--   <img class="d-block col-3 img-fluid" src="<%= ctxPath%>/images/${imgfilename}" style="cursor: pointer;" onclick="openPopup('<%= ctxPath%>/images/${imgfilename}')" />  --%>
								<img class="d-block col-3 img-fluid"
									src="<%= ctxPath%>/images/${imgfilename}"
									style="cursor: pointer;" data-toggle="modal"
									data-target="#add_image_modal_view" data-dismiss="modal"
									onclick="modal_content(this)" />
							</div>
						</c:if>
						<c:if test="${status.index > 0}">
							<div class="carousel-item">
								<%--   <img class="d-block col-3 img-fluid" src="<%= ctxPath%>/images/${imgfilename}" style="cursor: pointer;" onclick="openPopup('<%= ctxPath%>/images/${imgfilename}')" />  --%>
								<img class="d-block col-3 img-fluid"
									src="<%= ctxPath%>/images/${imgfilename}"
									style="cursor: pointer;" data-toggle="modal"
									data-target="#add_image_modal_view" data-dismiss="modal"
									onclick="modal_content(this)" />
							</div>
						</c:if>
					</c:forEach>
				</div>
				<a class="carousel-control-prev" href="#recipeCarousel"
					role="button" data-slide="prev"> <span
					class="carousel-control-prev-icon" aria-hidden="true"></span> <span
					class="sr-only">Previous</span>
				</a> <a class="carousel-control-next" href="#recipeCarousel"
					role="button" data-slide="next"> <span
					class="carousel-control-next-icon" aria-hidden="true"></span> <span
					class="sr-only">Next</span>
				</a>
			</div>



		</div>


		<%-- /////// 추가이미지 캐러젤로 보여주는 것 끝 //////// --%>
	</c:if>
	<%-- === 추가이미지 보여주기 끝 === --%>

	<div>
		<p id="order_error_msg"
			class="text-center text-danger font-weight-bold h4"></p>
	</div>



	

	

</div>


<%-- ****** 추가이미지 보여주기 Modal 시작 ****** --%>
<div class="modal fade" id="add_image_modal_view">
	<%-- 만약에 모달이 안보이거나 뒤로 가버릴 경우에는 모달의 class 에서 fade 를 뺀 class="modal" 로 하고서 해당 모달의 css 에서 zindex 값을 1050; 으로 주면 된다. --%>
	<div class="modal-dialog modal-lg">
		<div class="modal-content">

			<!-- Modal header -->
			<div class="modal-header">
				<h4 class="modal-title">추가 이미지 원래크기 보기</h4>
				<button type="button" class="close idFindClose" data-dismiss="modal">&times;</button>
			</div>

			<!-- Modal body -->
			<div class="modal-body" id="add_image_modal-body"></div>

			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-danger idFindClose"
					data-dismiss="modal">Close</button>
			</div>
		</div>

	</div>
</div>
<%-- ****** 추가이미지 보여주기 Modal 끝 ****** --%>


