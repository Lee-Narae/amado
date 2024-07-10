<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
	
	
	
	$(document).on("click","button.cbtn", function(e){
		//alert($(e.target).text());
		
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
			            v_html = `<div class='col-md- col-lg-2 offset-lg-1' >
						 			   <div class="card mb-3">
										   <img src='<%= ctxPath%>/resources/images/zee/\${item.imgfilename}' class='card-img-top'/>
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



</script>


<div id="container" style="border:solid 0px black; display:flex; margin: 12% auto; width: 80%;">

	<div id="item1" style="border:solid 0px red; width:100%;">
	
		<%-- 머릿말, 검색 --%>
		<div style="border:solid 0px black; text-align: center; ">
			<h3 style="font-weight: bold;">아마두 플리마켓🧺</h3>
			<br>
			
			<form name="searchFrm" style="margin-top: 20px;">
		      <select name="searchType" style="height: 26px;">
		         <option value="subject">글제목</option>
		         <option value="location">지역</option>
		      </select>
		   	  <input type="text" name="searchWord" size="40" autocomplete="off" /> 
		      <input type="text" style="display: none;"/> <%-- form 태그내에 input 태그가 오로지 1개 뿐일경우에는 엔터를 했을 경우 검색이 되어지므로 이것을 방지하고자 만든것이다. --%> 
		      <button type="button" class="btn btn-secondary btn-sm" onclick="goSearch()">검색</button>
		    </form>
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
		<div id="product" style="display: flex; margin-top: 5%; border:solid 0px red; "></div>
	    
		<%-- 페이지 바 --%>
		<div aria-label="Page navigation" class="pn" style="border:solid 0px red; padding: 10% 35%;">
		   <div class="pagination" >
			  <a href="#">&laquo;</a>
			  <a href="#">1</a>
			  <a class="active" href="#">2</a>
			  <a href="#">3</a>
			  <a href="#">4</a>
			  <a href="#">5</a>
			  <a href="#">6</a>
			  <a href="#">&raquo;</a>
			</div>
	    </div> 
	    
	</div>
	
	
	<!-- 최근 본 상품 -->
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
	

	
	
</div>
    