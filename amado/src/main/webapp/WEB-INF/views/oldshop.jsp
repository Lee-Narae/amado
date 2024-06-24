<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
   String ctxPath = request.getContextPath();
%>    
    
    <%-- Required meta tags --%>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<%-- Bootstrap CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.2-dist/css/bootstrap.min.css" > 

<%-- Font Awesome 6 Icons --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/template/template.css" />

<%-- Optional JavaScript --%>
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script> 

<%-- jQueryUI CSS 및 JS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script> 
    



<div class="text-left">
	
	    
		<div class="row" style="display:inline-flex;">
		
		<div class="sc-cHSUfg kWCYtJ">전체보기 ></div>
				
					
		<div class='col-md-6 col-lg-2 offset-lg-1'>
		   <div class="card mb-3">
			   <img src='<%= ctxPath%>/resources/images/스크린샷 2024-02-15 151204.png' class='card-img-top' style='width: 20%'/>
			   <div class='card-body' style='padding: 0; font-size: 9pt;'>
				  <ul class='list-unstyled mt-2'> 
		             <li><label class='prodInfo'>글제목</label></li>
		             <li><label class='prodInfo'>가격</label></li> 
		             <li><label class='prodInfo'>지역</label><span style="color: red;"></span></li> 
		             <li class='text-center'><a href='#' class='stretched-link btn btn-outline-dark btn-sm' role='button'>자세히보기</a></li> 
             	         <%-- 카드 내부의 링크에 .stretched-link 클래스를 추가하면 전체 카드를 클릭할 수 있고 호버링할 수 있습니다(카드가 링크 역할을 함). --%>
		          </ul>
		       </div>
	       </div>
        </div>
  
</div>
</div>
    