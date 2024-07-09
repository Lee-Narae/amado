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
    
</style>

<script type="text/javascript">

$(document).ready(function(){
	
	$(document).on("click", function(e){
		 //alert($(e.target).text());
		
		const sportname = $(e.target).text();
		
		$.ajax({
	        url:"<%= ctxPath%>/sportname.do",
	        data:{"sportname":sportname},
	        dataType:"json",
	        success:function(json){
	        	//alert("성공!");
	        	
	        	let v_html=``;
	        	
	        	$.each(json, function(index, item) {
		            v_html = `<div class='col-md- col-lg-2 offset-lg-1' >
					 			   <div class="card mb-3">
									   <img src='<%= ctxPath%>/resources/images/"+item.imgfilename+"' class='card-img-top'/>
									   <div class='card-body' style='padding: 0; font-size: 9pt;'>
										  <ul class='list-unstyled mt-3 pl-3'> 
								             <li><label class='prodInfo' style="font-weight: bold;">글제목: <span style="font-weight: normal;">잔망루피</sapn></label></li>
								             <li><label class='prodInfo' style="font-weight: bold;">가격: <span style="font-weight: normal;">백만원</sapn></label></li> 
								             <li><label class='prodInfo' style="font-weight: bold;">장소: <span style="font-weight: normal;">홍대입구 3번 출구</sapn></label><span style="color: red;"></span></li> 
								             <li class='text-center'><a href='#' class='stretched-link btn btn-outline-dark btn-sm' role='button'>자세히보기</a></li> 
							            	         <%-- 카드 내부의 링크에 .stretched-link 클래스를 추가하면 전체 카드를 클릭할 수 있고 호버링할 수 있습니다(카드가 링크 역할을 함). --%>
								          </ul>
								       </div>
							      	</div>
						      	</div>`;
						      	
	        	});
	        	
				$("div#product").html(v_html);
			     
	        },
	        error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			} 
	    });
	                
	});
	
    

});// end of $(document).ready(function(){})-------------------
//해당하는 카테고리의 제품이 없을경우

</script>


<div id="container" style="border:solid 0px black; display:flex; margin: 12% auto; width: 80%;">

	<div id="item1" style="border:solid 0px red;">
	
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
			<div style="border:solid 0px black; padding-left:10%; width:73%; display: flex;" >
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
		<button type="button" class="btn btn-info btn-sm" onclick="goWrite()" style="margin-left: 85%;">판매 등록하기</button>
		
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
	<div id="item2" style="background-color: #f1f5f9; width: 20%; border-radius: 20px;">
		<div id="recentItem" style="text-align: center; padding-top: 15%;">
	      <div  style="color:gray;">최근 본 상품</div>
	      <br>
	      <div>
	      	<a id="rItem" href="#"><img style="width: 80px; height:75px;" src="<%= ctxPath%>/resources/images/zee/영학선생님.png" /><!-- 카드뒤집기해서 정보넣기 --></a>
	      </div>
	      <br>
	      <div>
	      	<a id="rItem" href="#"><img style="width: 80px; height:75px;" src="<%= ctxPath%>/resources/images/zee/웜벳.png" /></a>
	      </div>
	    </div>
	</div>
	
	
	
</div>
    