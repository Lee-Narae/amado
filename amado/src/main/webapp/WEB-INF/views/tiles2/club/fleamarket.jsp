<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
   String ctxPath = request.getContextPath();
%>    


<style type="text/css">
    
    img.oldproduct {
		width: 60%;  
		margin: 0 auto;
	}
	
		
	.pagination a {
	  color: black;
	  float: left;
	  padding: 8px 16px;
	  text-decoration: none;
	  transition: background-color .3s;
	}
	
	.pagination a.active {
	  background-color: #8585b6;
	  color: white;
	}
	
	.pagination a:hover:not(.active) {
		background-color: #ddd;
	}


	.recentItem {
		border: solid 0px red;
		margin-top: 10%;
		width: 20%;
	}
    
    .cbtn{
    	border-radius: 6.25rem;
    	height: 2.25rem;
    	margin-inline-end: .25rem;
    	background-color: #98b6d5; 
    	border: none; 
    	color: white;
    	width: 40%;
    	cursor: pointer;
    	box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.3); /* 그림자 설정 */
		transition: box-shadow 0.3s ease; /* 호버 시 부드러운 전환 효과 */
	}

	.cbtn:hover {
		box-shadow: 0px 8px 12px rgba(0, 0, 0, 0.6); /* 호버 시 그림자 크기 변경 */
		background-color: #05203c; 
	}
	
	#rItem img{
		border-radius: 20px;
	}
	div#notready{
		font-size: 15pt;
		padding-left: 38%;
	}    
	div#notready span{
		font-size: 30pt;
	}  
	a#itemRegister{
		color: black;
		margin-left: 80%;
		margin-top: 5%;
		
	}
</style>

<script type="text/javascript">

$(document).ready(function(){
	
	$.ajax({ // 첫화면 전체 상품 보여주기 ajax
        url:"<%= ctxPath%>/allview.do",
        dataType:"json",
        success:function(json){
        	//alert("전체보여주기 성공하나요~~~???")
        	
        	let v_html=``;
        	
        	$.each(json, function(index, item) {
        		
        		if((index+1)%4==1){
        			v_html += `<div style='display:flex;' >`;
        			
        		}
	            v_html += `<div class='col-md-6 col-lg-2 offset-lg-1'>
				 			   <div class="card mb-3" >
								   <img style="height: 140px;" src='<%= ctxPath%>/resources/images/zee/\${item.imgfilename}' class='card-img-top'/>
								   <div class='card-body' style='padding: 0; font-size: 9pt;'>
									  <ul class='list-unstyled mt-3 pl-3'> 
							             <li><label class='prodInfo' style="font-weight: bold;">글제목: <span style="font-weight: normal;">\${item.title}</sapn></label></li>
							             <li><label class='prodInfo' style="font-weight: bold;">가격: <span style="font-weight: normal;">\${Number(item.cost).toLocaleString('en')}원</sapn></label></li> 
							             <li><label class='prodInfo' style="font-weight: bold;">장소: <span style="font-weight: normal;">\${item.city}&nbsp;\${item.local}</sapn></label><span style="color: red;"></span></li> 
							             <li class='text-center'><a href='/amado/club/prodView.do?fleamarketseq=\${item.fleamarketseq}' class='stretched-link btn btn-outline-dark btn-sm' role='button'>자세히보기</a></li> 
						            	         <%-- 카드 내부의 링크에 .stretched-link 클래스를 추가하면 전체 카드를 클릭할 수 있고 호버링할 수 있습니다(카드가 링크 역할을 함). --%>
							          </ul>
							       </div>
						      	</div>
					      	</div>`;
        			      	
	            if((index+1)%4==0 || (json.length-1)==index){ //json.length는 전체 개수, item은 json 안의 하나하나
        			v_html += `</div>`;
        		}
        	});
    	
			$("div#product").html(v_html);
        	
        
		},
        error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		} 
    });
	

	$("input:text[name='searchWord']").bind("keyup", function(e){ // 키뗄때 자동검색
		if(e.keyCode == 13){
			goSearch();
		}
	});
	
	// 검색시 검색조건 및 검색어 값 유지시키기
	if(${not empty requestScope.paraMap}) {
		$("select[name='searchType']").val("${requestScope.paraMap.searchType}");
		$("input[name='searchWord']").val("${requestScope.paraMap.searchWord}");
	}
	
	
	<%-- === #115. 검색어 입력시 자동글 완성하기 2 === --%>
	$("div#displayList").hide();
	
	$("input[name='searchWord']").keyup(function() {
		
		const wordLength = $(this).val().trim().length;
		// 검색어에서 공백을 제거한 길이를 알아온다.
		
		if(wordLength == 0) {
			$("div#displayList").hide();
			// 검색어가 공백이거나 검색어 입력후 백스페이스키를 눌러서 검색어를 모두 지우면 검색된 내용이 안 나오도록 해야 한다.
		}
		else {
			if( $("select[name='searchType']").val() == "subject" || 
				$("select[name='searchType']").val() == "name" ) {
				
				$.ajax({
					url:"<%= ctxPath%>/wordSearchShow.action",
					type:"get",
					data:{"searchType":$("select[name='searchType']").val(),
						  "searchWord":$("input[name='searchWord']").val()},
					dataType:"json",
					success:function(json) {
						console.log(JSON.stringify(json));

						<%-- === #120. 검색어 입력시 자동글 완성하기 7 === --%>
						if(json.length > 0) {
							// 검색된 데이터가 있는 경우임.
							
							let v_html = ``;
							
							$.each(json, function(index, item) {
								const word = item.word;
								
								const idx = word.toLowerCase().indexOf($("input[name='searchWord']").val().toLowerCase());
								//word.toLowerCase() 은 word 를 모두 소문자로 변경하는 것이다.
								// 만약에 검색어가 JavA 이라면
								/*
									Java 에 관한 질문입니다. 은 idx 가 0 이다.
									웹 만들 때 jaVaScript 효과주는 다른 언어는 없나요? 은 idx 가  7 이다.
								*/
								
								const len = $("input[name='searchWord']").val().length;
								// 검색어(JavA) 의 길이 len 은 4가 된다.
/*									
								console.log("~~~~ 시작 ~~~~");
								console.log(word.substring(0, idx)); 	    // 검색어(JavA) 앞까지의 글자 ==> 웹 만들 때 
								console.log(word.substring(idx, idx+len));  // 검색어(JavA) 글자 ==> jaVa
								console.log(word.substring(idx+len));       // 검색어(JavA) 이후의 글자 ==> Script 효과주는 다른 언어는 없나요?
								console.log("~~~~ 끝 ~~~~");
*/
								const result = word.substring(0, idx) + "<span style='color:purple;'>" + word.substring(idx, idx+len) + "</span>" + word.substring(idx+len);
								
								v_html += `<span style='cursor:pointer;' class='result'>\${result}</span><br>`;
							}); // end of $.each
							
							const input_width = $("input[name='searchWord']").css("width"); 
							// 검색어 input 태그 width 값 알아오기(현재 연관검색어 창이 너무 커서)
							
							$("div#displayList").css({"width":input_width});
							// 검색결과 div 의 width 크기를 검색어 입력 input 태그의 width 와 일치시키기 
							
							$("div#displayList").html(v_html);
							$("div#displayList").show();
							
						}
					}, // end of success:function(json)
				    error: function(request, status, error){
				    	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}						
				}); // end of $.ajax
			}
		}
	}); // end of $("input[name='searchWord']").keyup
	
	<%-- === #121. 검색어 입력시 자동글 완성하기 8 === --%>
	$(document).on("click", "span.result", function(e){
		const word = $(e.target).text();
		$("input[name='searchWord']").val(word); // 텍스트박스에 검색된 결과의 문자열을 입력해준다.
		$("div#displayList").hide();
		goSearch();
	});
	

	
	
	
	$(document).on("click","button#all", function(e){
		 
		$.ajax({
	        url:"<%= ctxPath%>/allview.do",
	        dataType:"json",
	        success:function(json){
	        	//alert("전체보여주기 성공하나요~~~???")
	        	
	        	let v_html=``;
	        	
	        	$.each(json, function(index, item) {
	        		
	        		if((index+1)%4==1){
	        			v_html += `<div style='display:flex;' >`;
	        			
	        		}
		            v_html += `<div class='col-md-6 col-lg-2 offset-lg-1'>
					 			   <div class="card mb-3" >
									   <img style="height: 140px;" src='<%= ctxPath%>/resources/images/zee/\${item.imgfilename}' class='card-img-top'/>
									   <div class='card-body' style='padding: 0; font-size: 9pt;'>
										  <ul class='list-unstyled mt-3 pl-3'> 
								             <li><label class='prodInfo' style="font-weight: bold;">글제목: <span style="font-weight: normal;">\${item.title}</sapn></label></li>
								             <li><label class='prodInfo' style="font-weight: bold;">가격: <span style="font-weight: normal;">\${Number(item.cost).toLocaleString('en')}원</sapn></label></li> 
								             <li><label class='prodInfo' style="font-weight: bold;">장소: <span style="font-weight: normal;">\${item.city}&nbsp;\${item.local}</sapn></label><span style="color: red;"></span></li> 
								             <li class='text-center'><a href='/amado/club/prodView.do?fleamarketseq=\${item.fleamarketseq}' class='stretched-link btn btn-outline-dark btn-sm' role='button'>자세히보기</a></li> 
							            	         <%-- 카드 내부의 링크에 .stretched-link 클래스를 추가하면 전체 카드를 클릭할 수 있고 호버링할 수 있습니다(카드가 링크 역할을 함). --%>
								          </ul>
								       </div>
							      	</div>
						      	</div>`;
	        			      	
		            if((index+1)%4==0 || (json.length-1)==index){ //json.length는 전체 개수, item은 json 안의 하나하나
	        			v_html += `</div>`;
	        		}
	        	});
        	
				$("div#product").html(v_html);
	        	
	        
			},
	        error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			} 
	    });
	});
	
	$(document).on("click","button.cbtn", function(e){
		//alert($(e.target).text());
		
		$("button.cbtn").css("background-color", "");   // 원래 색상 css 전체 적용
		$(e.target).css("background-color", "#05203c"); // 클릭된 버튼 색상 변경
		
		
		const sportname = $(e.target).text();
		
		$.ajax({
	        url:"<%= ctxPath%>/sportname.do",
	        data:{"sportname":sportname},
	        dataType:"json",
	        success:function(json){
	        	//alert("성공!");
	        	
	        	let v_html=``;
	        	
	        	
	        	
	        	
	        	if(json.length == 0) {
	        		if(sportname == "배드민턴"){
	        			v_html = `<div id="notready">현재 상품 준비중 입니다...<span>🏸</span></div>`;
	        		}
	        		else if(sportname == "족구"){
	        			v_html = `<div id="notready">현재 상품 준비중 입니다...<span>⚽</span></div>`;
	        		}
	        		else if(sportname == "볼링"){
	        			v_html = `<div id="notready">현재 상품 준비중 입니다...<span>🎳</span></div>`;
	        		}
	        		else if(sportname == "테니스"){
	        			v_html = `<div id="notready">현재 상품 준비중 입니다...<span>🎾</span></div>`;
	        		}
	        		else if(sportname == "농구"){
	        			v_html = `<div id="notready">현재 상품 준비중 입니다...<span>🏀</span></div>`;
	        		}
	        		else if(sportname == "배구"){
	        			v_html = `<div id="notready">현재 상품 준비중 입니다...<span>🏐</span></div>`;
	        		}
	        		else if(sportname == "야구"){
	        			v_html = `<div id="notready">현재 상품 준비중 입니다...<span>⚾</span></div>`;
	        		}
	        		else if(sportname == "축구"){
	        			v_html = `<div id="notready">현재 상품 준비중 입니다...<span>⚽</span></div>`;
	        		}
	        		
					$("div#product").html(v_html);
	        	}
	        	
	        	else if(json.length > 0) {
	        		
		        	$.each(json, function(index, item) {
		        		
		        		if((index+1)%4==1){
		        			v_html += `<div style='display:flex;' >`;
		        			
		        		}
			            v_html += `<div class='col-md-6 col-lg-2 offset-lg-1'>
						 			   <div class="card mb-3" >
										   <img style="height: 140px;" src='<%= ctxPath%>/resources/images/zee/\${item.imgfilename}' class='card-img-top'/>
										   <div class='card-body' style='padding: 0; font-size: 9pt;'>
											  <ul class='list-unstyled mt-3 pl-3'> 
									             <li><label class='prodInfo' style="font-weight: bold;">글제목: <span style="font-weight: normal;">\${item.title}</sapn></label></li>
									             <li><label class='prodInfo' style="font-weight: bold;">가격: <span style="font-weight: normal;">\${Number(item.cost).toLocaleString('en')}원</sapn></label></li> 
									             <li><label class='prodInfo' style="font-weight: bold;">장소: <span style="font-weight: normal;">\${item.city}&nbsp;\${item.local}</sapn></label><span style="color: red;"></span></li> 
									             <li class='text-center'><a href='/amado/club/prodView.do?fleamarketseq=\${item.fleamarketseq}' class='stretched-link btn btn-outline-dark btn-sm' role='button'>자세히보기</a></li> 
								            	         <%-- 카드 내부의 링크에 .stretched-link 클래스를 추가하면 전체 카드를 클릭할 수 있고 호버링할 수 있습니다(카드가 링크 역할을 함). --%>
									          </ul>
									       </div>
								      	</div>
							      	</div>`;
		        			      	
			            if((index+1)%4==0 || (json.length-1)==index){
		        			v_html += `</div>`;
		        		}
						
			            
			            
		        	});
	        	
					$("div#product").html(v_html);
	        	}
			     
	        },
	        error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			} 
	    });
	});
	
	
	$("a#register").click(function(){

		if(${sessionScope.loginuser == null}){ //form으로 아이디 보내서 하는 것보다 어차피 session에 있으니까 이 방식으로 하는게 더 간편
			alert('상품판매등록은 로그인 후에 가능합니다.');
			return; 
		}
	 	  
	});
	
});// end of $(document).ready(function(){})-------------------


//Function Declaration
function goView(seq) {
	
	const goBackURL = "${requestScope.goBackURL}";
  //	  goBackURL = "/list.action?searchType=subject&searchWord=엄정화&currentShowPageNo=4"
  // /list.action?searchType=subject 여기까지만 나온다
  // & 가 종결자이기 때문에 GET 방식으로는 보낼 수 없다!! (매우중요!!!)
  // 그렇기 때문에 POST 방식으로 보내야한다!!
  // 아래처럼 get 방식으로 보내면 안된다. 왜냐하면 get방식에서 &는 전송될 데이터의 구분자로 사용되기 때문이다. 
//	location.href = "<%= ctxPath%>/view.action?seq="+seq; // 쌍따움표일 경우 	
//	location.href = `<%= ctxPath%>/view.action?seq=\${seq}&goBackURL=\${goBackURL}`; //백틱 `` 이기 때문에 \${}

//그러므로 & 를 글자 그대로 인식하는 post 방식으로 보내야 한다.
//아래에 #132. 에 표기된 from 태그를 먼저 만든다.

	const frm = document.goViewFrm;
		frm.seq.value = seq;
	frm.goBackURL.value = goBackURL; 
	
	if(${not empty requestScope.paraMap}) { // 검색조건이 있을 경우
		frm.searchType.value = "${requestScope.paraMap.searchType}";
		frm.searchWord.value = "${requestScope.paraMap.searchWord}";
	}
	frm.action = "<%= ctxPath %>/view.action";
	frm.method = "post";
	frm.submit();

} // end of function goView(seq) -------------------- 	 	


function goSearch() {
	//alert("눌렀다");

	if($("input:text[name='searchWord']").val() == ""){
		alert("검색어를 입력하세요.");
		return;
	}
	
	if($("select[name='searchType']").val() == ""){ // select태그의 option 중 value 값을 넣어야 한다.
		alert("검색 대상을 선택하세요.");
		return;
	}
	const frm = document.item_searchFrm;
<%--	frm.method = "get";	
	frm.action = "<%= ctxPath%>/fleamarket.action";
--%>		
	frm.submit();
	
} // end of goSearch


</script>
  

<div id="container" style="border:solid 0px black; display:flex; margin: 12% auto; width: 80%;">

	<div id="item1" style="border:solid 0px red; width:100%;">
	
		<%-- 머릿말, 검색 --%>
		<div style="border:solid 0px black; text-align: center; ">
			<h3 style="font-weight: bold;">아마두 플리마켓🧺</h3>
			<br>
			
			<form name="item_searchFrm" style="margin-top: 20px;">
		      <select name="searchType" style="height: 26px;">
		         <option value="subject">글제목</option>
		         <option value="location">지역</option>
		      </select>
		   	  <input type="text" name="searchWord" size="40" autocomplete="off" /> 
		      <input type="text" style="display: none;"/> <%-- form 태그내에 input 태그가 오로지 1개 뿐일경우에는 엔터를 했을 경우 검색이 되어지므로 이것을 방지하고자 만든것이다. --%> 
		      <button type="button" class="btn btn-secondary btn-sm" onclick="goSearch()">검색</button>
		    </form>
		    
			<%-- === #114. 검색어 입력시 자동글 완성하기 1 === --%>
			<div id="disp  layList" style="border:solid 1px gray; border-top:0px; height:100px; margin-left:13.2%; margin-top:-1px; margin-bottom:30px; overflow:auto;">
				
			</div>
		
		</div>
		
		<%-- 종목 카테고리 --%>
		<div id="categoryList" style="border:solid 0px black; display: flex; margin-top: 5%; margin-left:10%; ">
			<div style="border:solid 0px black; padding-left:10%; width:75%; display: flex;" >
    			  <button id="all" class='cbtn' style="margin-right: 3%;">전체</button>
                  <button id="soccor" class='cbtn'>축구</button>
                  <button id="baseball" class='cbtn'>야구</button>
                  <button id="volyball" class='cbtn'>배구</button>
                  <button id="basketball" class='cbtn'>농구</button>
                  <button id="tenis" class='cbtn'>테니스</button>
                  <button id="bowling" class='cbtn'>볼링</button>
                  <button id="jockgu" class='cbtn'>족구</button>
                  <button id="badminton" class='cbtn'>배드민턴</button>
            </div>
		</div>
		
		<br>
		<div><a id="itemRegister" href='/amado/club/itemRegister.do'>판매 등록하기</a></div>
		
		<!-- 상품  -->
		<div id="product" style="margin-top: 5%; margin-right: 8%; border:solid 0px red; "></div>
	    
		<%-- 페이지 바 --%>
		<div aria-label="Page navigation" class="pn" style="border:solid 0px red; padding: 10% 35%;">
			   <nav>
		          <ul class="pagination">${requestScope.pageBar}</ul>
		       </nav>
		       <!--  
			  <a href="#">&laquo;</a>
			  <a href="#">1</a>
			  <a class="active" href="#">2</a>
			  <a href="#">3</a>
			  <a href="#">4</a>
			  <a href="#">5</a>
			  <a href="#">6</a>
			  <a href="#">&raquo;</a>-->
			</div>
	     
	</div>
	
	
	<%-- 최근 본 상품 
	<div id="item2" style="border-left:solid 1px lightgray ; width: 20%; height: 400px; ">
		<div style="background-color: #f1f5f9; width: 60%; height: 40px; border-radius: 20px; margin-left: 3%;" ><!-- 스크롤할때 같이 움직이기 -->
			<div id="recentItem" style="text-align: center; padding-top: 3%;">
		      <div  style="color:gray; padding-top: 3%;">최근 본 상품</div>
		      <hr>
		      <br>
		      <div>
		      	<a id="rItem" href="#"><img style="width: 90px; height:85px;" src="<%= ctxPath%>/resources/images/zee/영학선생님.png" /><!-- 카드뒤집기해서 정보넣기 --></a>
		      </div>
		      <br>
		      <div>
		      	<a id="rItem" href="#"><img style="width: 90px; height:85px;" src="<%= ctxPath%>/resources/images/zee/웜벳.png" /></a>
		      </div>
		      <br><br><br>
		      <div>더보기 ></div>
		    </div>
	    </div>
	</div>
	--%>
<form name="goViewFrm">
	<input type="text" name="seq" /> 
	<input type="text" name="goBackURL" /> 
</form>
	
	
</div>
    