<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
   String ctxPath = request.getContextPath();
%>    

    
<style type="text/css">
    
	.round-card {
    border-radius: 50%;
    width: 300px;
    height: 300px;
    overflow: hidden;
    display: flex;
    align-items: center;
    justify-content: center;
    text-align: center;
}
.round-card img {
    border-radius: 50%;
    width: 60%;
    height: auto;
    border: solid 1px gray;
}

li{
	opacity: 0;
}
   
</style>
    
    
    
    
<div class="container" style="border:solid 0px black; margin-top: 12%;">
	
	<%-- 머릿말  --%>
	<div style="text-align: center; ">
		<h3 style="font-weight: bold;">동호회 찾기👥</h3>
		<br>
	</div>
	    
	<div style="display: flex; margin-top: 5%;">
		<div class='col-md-3 col-lg-2 offset-lg-1' style="border:solid 0px red; ">
		   <div class="round-card mb-3" >
			   <img src='<%= ctxPath%>/resources/images/zee/icons8-badminton-64.png' class='oldproduct card-img-top' />
			   <div class='card-body' style='padding: 0; font-size: 9pt;'>
				  <ul class='list-unstyled mt-3 pl-3'> 
             	     <li class='text-center'><a href='#' class='stretched-link btn btn-outline-dark btn-sm' role='button'>자세히보기</a></li>
             	         <%-- 카드 내부의 링크에 .stretched-link 클래스를 추가하면 전체 카드를 클릭할 수 있고 호버링할 수 있습니다(카드가 링크 역할을 함). --%>
		          </ul>
		       </div>
	       </div>
        </div>
		<div class='col-md- col-lg-2 offset-lg-1' style="border:solid 0px red; ">
		   <div class="card mb-3">
			   <img src='<%= ctxPath%>/resources/images/스크린샷 2024-02-15 151204.png' class='card-img-top'/>
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
        </div>
		<div class='col-md-3 col-lg-2 offset-lg-1' style="border:solid 0px red; ">
		   <div class="card mb-3">
			   <img src='<%= ctxPath%>/resources/images/스크린샷 2024-02-15 151204.png' class='card-img-top' />
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
        </div>
		<div class='col-md-3 col-lg-2 offset-lg-1' style="border:solid 0px red; ">
		   <div class="card mb-3">
			   <img src='<%= ctxPath%>/resources/images/스크린샷 2024-02-15 151204.png' class='card-img-top'/>
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
        </div>
	</div>
	
	
	<div style="display: flex; ">
		<div class='col-md-6 col-lg-2 offset-lg-1' style="border:solid 0px red; ">
		   <div class="card mb-3">
			   <img src='<%= ctxPath%>/resources/images/스크린샷 2024-02-15 151204.png' class='card-img-top' />
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
        </div>
		<div class='col-md-6 col-lg-2 offset-lg-1' style="border:solid 0px red; ">
		   <div class="card mb-3">
			   <img src='<%= ctxPath%>/resources/images/스크린샷 2024-02-15 151204.png' class='card-img-top'/>
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
        </div>
		<div class='col-md-6 col-lg-2 offset-lg-1' style="border:solid 0px red; ">
		   <div class="card mb-3">
			   <img src='<%= ctxPath%>/resources/images/스크린샷 2024-02-15 151204.png' class='card-img-top' />
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
        </div>
		<div class='col-md-6 col-lg-2 offset-lg-1' style="border:solid 0px red; ">
		   <div class="card mb-3">
			   <img src='<%= ctxPath%>/resources/images/스크린샷 2024-02-15 151204.png' class='card-img-top' />
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
        </div>
        
	</div>
	

	
	
</div>
    