<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
   String ctxPath = request.getContextPath();
%>    


<style type="text/css">
    
    img {
		width: 60%;  
		margin: 0 auto;
	}
	
	
    
</style>

<script type="text/javascript">
/*
$(document).ready(function(){

    $.ajax({
        url:"/MyMVC/shop/categoryListJSON.up",
        dataType:"json",
        success:function(json){
            let v_html = ``;
		    
		    if(json.length == 0) {
				v_html = `현재 카테고리 준비중 입니다...`;
				$("div#categoryList").html(v_html);
			}
			
			else if(json.length > 0) {
				// 데이터가 존재하는 경우
            /*	
				// 자바스크립트 사용하는 경우
				json.forEach(function(item, index, array){
					
				});
				
				// jQuery 를 사용하는 경우
				$.each(json, function(index, item){
					
				});
			*/	 
		    //	console.log("~~~ 확인용 json => ", JSON.stringify(json));
			/*
			   ~~~ 확인용 json => [{"code":"100000","cname":"전자제품","cnum":1}
			                     ,{"code":"200000","cname":"의류","cnum":2}
			                     ,{"code":"300000","cname":"도서","cnum":3}] 	
			*/
                v_html = `<div style="width: 80%; margin: 0 auto;">
                                <div style="border: solid 1px gray;
                                            padding-top: 5px;
                                            padding-bottom: 5px;
                                            text-align: center;
                                            color: navy;
                                            font-size: 14pt;
                                            font-weight: bold;">
                                    CATEGORY LIST
                                </div>
                                <div style="border: solid 1px gray;
                                            border-top: hidden;
                                            padding-top: 5px;
                                            padding-bottom: 5px;
                                            text-align: center;">
                                    <a href="mallHomeMore.up">전체</a>&nbsp;&nbsp;`;
                
                $.each(json, function(index, item){
                    
                    v_html += `<a href="/MyMVC/shop/mallByCategory.up?cnum=${item.cnum}">${item.cname}</a>&nbsp;&nbsp;`;  
                            
                });// end of $.each(json, function(index, item)-----

                v_html += ` </div>
                        </div>`;

                // 카테고리 출력하기 $("div#categoryList") 은 header1.jsp 파일속에 들어있다.
                $("div#categoryList").html(v_html); 

            }// end of else if(json.length > 0)----------   
        },
        error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		} 
    });

});// end of $(document).ready(function(){})-------------------

*/
</script>


<div class="container" style="border:solid 0px black; margin-top: 12%;">
	
	<%-- 머릿말, 검색 --%>
	<div style="text-align: center; ">
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
	    
	<div  style="border:solid 0px black; display: flex; margin-top: 5%; margin-left:10%;">
		<%-- 종목 카테고리 --%>
		<ul class="nav nav-tabs">
		  <li class="nav-item" >
		    <a class="nav-link active" aria-current="page" href="#">전체보기</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" href="#"> 농구 </a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" href="#"> 배구 </a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" href="#"> 축구 </a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" href="#"> 야구 </a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" href="#"> 족구 </a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" href="#"> 배드민턴 </a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" href="#">  테니스  </a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" href="#">  볼링  </a>
		  </li>
		</ul>
	</div>
	
	<br>
	<button type="button" class="btn btn-info btn-sm" onclick="goWrite()" style="margin-left: 87%;">판매 등록하기</button>
	    
		
	<div style="display: flex; margin-top: 5%;">
		<div class='col-md-3 col-lg-2 offset-lg-1' style="border:solid 0px red; ">
		   <div class="card mb-3" >
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
	
	
</div>
    