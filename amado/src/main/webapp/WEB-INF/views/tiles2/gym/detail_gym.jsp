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
</style>

<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/myshop/categoryListJSON.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3e40c6a4e83259bd26e2771ad2db4e63"></script>

<script type="text/javascript">


	$(document).ready(function(){
		
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
	    
	    
	    

    	// 지도를 담을 영역의 DOM 레퍼런스
    	var mapContainer = document.getElementById("map");
    	
    	// 지도를 생성할때 필요한 기본 옵션
    	var options = {
        	 	center: new kakao.maps.LatLng(37.556513150417395, 126.91951995383943), // 지도의 중심좌표. 반드시 존재해야함.
        	 	<%--
        		  	center 에 할당할 값은 kakao.maps.LatLng 클래스를 사용하여 생성한다.
        		  	kakao.maps.LatLng 클래스의 2개 인자값은 첫번째 파라미터는 위도(latitude)이고, 두번째 파라미터는 경도(longitude)이다.
        		 --%>
        	 	level: 7  // 지도의 레벨(확대, 축소 정도). 숫자가 클수록 축소된다. 4가 적당함.
         };
    	
    	// 지도 생성 및 생성된 지도객체 리턴
    	var mapobj = new kakao.maps.Map(mapContainer, options);
    	
    	// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성함. 	
    	var mapTypeControl = new kakao.maps.MapTypeControl();
    	
    	// 지도 타입 컨트롤을 지도에 표시함.
    	// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미함.	
    	mapobj.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT); 
    	
    	// 지도 확대 축소를 제어할 수 있는 줌 컨트롤을 생성함.	
    	var zoomControl = new kakao.maps.ZoomControl();
    	
    	// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 지도에 표시함.
    	// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 RIGHT는 오른쪽을 의미함.	 
    	mapobj.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
    	
    	if(navigator.geolocation) {
    		// HTML5의 geolocation으로 사용할 수 있는지 확인한다 
    		
    		// GeoLocation을 이용해서 웹페이지에 접속한 사용자의 현재 위치를 확인하여 그 위치(위도,경도)를 지도의 중앙에 오도록 한다.
    		navigator.geolocation.getCurrentPosition(function(position) {
    			var latitude = position.coords.latitude;   // 현위치의 위도
    			var longitude = position.coords.longitude; // 현위치의 경도
    		//	console.log("현위치의 위도: "+latitude+", 현위치의 경도: "+longitude);
    			// 현위치의 위도: 37.5499076, 현위치의 경도: 126.9218479
    			
    			// 마커가 표시될 위치를 geolocation으로 얻어온 현위치의 위.경도 좌표로 한다   
    			var locPosition = new kakao.maps.LatLng(latitude, longitude);
    			    			
    			// 마커이미지를 기본이미지를 사용하지 않고 다른 이미지로 사용할 경우의 이미지 주소 
    	        var imageSrc = 'http://localhost:9090/MyMVC/images/pointerPink.png';
    			
    	        // 마커이미지의 크기 
    		    var imageSize = new kakao.maps.Size(34, 39);
    	        
    		    // 마커이미지의 옵션. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정한다. 
    		    var imageOption = {offset: new kakao.maps.Point(15, 39)};

    		    // 마커의 이미지정보를 가지고 있는 마커이미지를 생성한다. 
    		    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);

    		    // == 마커 생성하기 == //
    			var marker = new kakao.maps.Marker({ 
    				map: mapobj, 
    		        position: locPosition, // locPosition 좌표에 마커를 생성 
    		        image: markerImage     // 마커이미지 설정
    			}); 
    		    
    			marker.setMap(mapobj); // 지도에 마커를 표시한다
    	     
    			
    			// === 인포윈도우(텍스트를 올릴 수 있는 말풍선 모양의 이미지) 생성하기 === //
    			
    			// 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능함.
    			var iwContent = "<div style='padding:5px; font-size:9pt;'>여기에 계신가요?<br/><a href='https://map.kakao.com/link/map/현위치(약간틀림),"+latitude+","+longitude+"' style='color:blue;' target='_blank'>큰지도</a> <a href='https://map.kakao.com/link/to/현위치(약간틀림),"+latitude+","+longitude+"' style='color:blue' target='_blank'>길찾기</a></div>";
    			
    			// 인포윈도우 표시 위치
    		    var iwPosition = locPosition;
    			
    		 // removeable 속성을 true 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됨
    		    var iwRemoveable = true; 

    		    // == 인포윈도우를 생성하기 == 
    			var infowindow = new kakao.maps.InfoWindow({
    			    position : iwPosition, 
    			    content : iwContent,
    			    removable : iwRemoveable
    			});

    			// == 마커 위에 인포윈도우를 표시하기 == //
    			infowindow.open(mapobj, marker);

    			// == 지도의 센터위치를 locPosition로 변경한다.(사이트에 접속한 클라이언트 컴퓨터의 현재의 위.경도로 변경한다.)
    		    mapobj.setCenter(locPosition);
    			
    	    });
    	}
    	else {
    		// HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정한다.
    		var locPosition = new kakao.maps.LatLng(37.556513150417395, 126.91951995383943);     
            
    		// 위의 
    		// 마커이미지를 기본이미지를 사용하지 않고 다른 이미지로 사용할 경우의 이미지 주소 
    		// 부터
    		// 마커 위에 인포윈도우를 표시하기 
    		// 까지 동일함.
    		
         // 지도의 센터위치를 위에서 정적으로 입력한 위.경도로 변경한다.
    	    mapobj.setCenter(locPosition);
    		
    	}// end of if~else------------------------------------------
    	
    	
    	// ============ 지도에 매장위치 마커 보여주기 시작 ============ //
   			 // == 마커 생성하기 == //
				var marker = new kakao.maps.Marker({ 
					map: mapobj, 
			        position: positionArr[i].latlng   
				}); 
	    		
				// 지도에 마커를 표시한다.
	    		marker.setMap(mapobj);
    	// ============ 지도에 매장위치 마커 보여주기 끝 ============ //
    	
    	
    	// ================== 지도에 클릭 이벤트를 등록하기 시작 ======================= //
       // 지도를 클릭하면 클릭한 위치에 마커를 표시하면서 위,경도를 보여주도록 한다.
       
       // == 마커 생성하기 == //
       // 1. 마커이미지 변경
       var imageSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png';       
           
      // 2. 마커이미지의 크기 
       var imageSize = new kakao.maps.Size(34, 39);   
               
       // 3. 마커이미지의 옵션. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정한다. 
       var imageOption = {offset: new kakao.maps.Point(15, 39)};   
         
       // 4. 이미지정보를 가지고 있는 마커이미지를 생성한다. 
       var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
             
       var movingMarker = new kakao.maps.Marker({ 
         map: mapobj, 
           image: markerImage  // 마커이미지 설정
      });
       
       // === 인포윈도우(텍스트를 올릴 수 있는 말풍선 모양의 이미지) 생성하기 === //
      var movingInfowindow = new kakao.maps.InfoWindow({
          removable : false
        //removable : true   // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됨
      });
      
       
      kakao.maps.event.addListener(mapobj, 'click', function(mouseEvent) {         
             
          // 클릭한 위도, 경도 정보를 가져옵니다 
          var latlng = mouseEvent.latLng;
          
          // 마커 위치를 클릭한 위치로 옮긴다.
          movingMarker.setPosition(latlng);
          
          // 인포윈도우의 내용물 변경하기 
          movingInfowindow.setContent("<div style='padding:5px; font-size:9pt;'>여기가 어디에요?<br/><a href='https://map.kakao.com/link/map/여기,"+latlng.getLat()+","+latlng.getLng()+"' style='color:blue;' target='_blank'>큰지도</a> <a href='https://map.kakao.com/link/to/여기,"+latlng.getLat()+","+latlng.getLng()+"' style='color:blue' target='_blank'>길찾기</a></div>");  
          
          // == 마커 위에 인포윈도우를 표시하기 == //
          movingInfowindow.open(mapobj, movingMarker);
          
          var htmlMessage = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, '; 
              htmlMessage += '경도는 ' + latlng.getLng() + ' 입니다';
             
          var resultDiv = document.getElementById("latlngResult"); 
          resultDiv.innerHTML = htmlMessage;
      });
       // ================== 지도에 클릭 이벤트를 등록하기 끝 ======================= //
    	
	    
      // 이미지 클릭 시 모달에 이미지 경로 설정
      $('.modal-link').on('click', function() {
        var imageUrl = $(this).find('img').attr('src');
        $('#modalImage').attr('src', imageUrl);
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

 	
</script>



<div style="display: flex;">
<div >홈  ></div>
<select name="" id="">
	 		    <option value="default">종목 선택하세요</option>
   			 	<option value="">축구</option>
    			<option value="">야구</option>
    			<option value="">배구</option>
   				<option value="">농구</option>
   				<option value="">테니스</option>
   				<option value="">볼링</option>
   				<option value="">족구</option>
   				<option value="">배드민턴</option>
</select>
</div>

<hr>


<div class="container mt-5">
  <div class="row">
    <div class="col-lg-8">
      <!-- 큰 사진 부분 -->
      <a href="#" data-toggle="modal" data-target="#myModal">
        <img src="<%=ctxPath%>/resources/images/체육관2.jpg"  class="img-fluid" alt="큰 사진">
      </a>
    </div>
    <div class="col-lg-4">
      <!-- 작은 사진 4개 부분 -->
      <div class="row">
        <div class="col-6 mb-3">
          <a href="#" data-toggle="modal" data-target="#myModal">
            <img src="<%=ctxPath%>/resources/images/체육관1.jpg"  class="img-fluid" alt="작은 사진 1">
          </a>
        </div>
        <div class="col-6 mb-3">
          <a href="#" data-toggle="modal" data-target="#myModal">
            <img src="<%=ctxPath%>/resources/images/체육관2.jpg"  class="img-fluid" alt="작은 사진 2">
          </a>
        </div>
        <div class="col-6 mb-3">
          <a href="#" data-toggle="modal" data-target="#myModal">
            <img src="<%=ctxPath%>/resources/images/체육관3.jpg"  class="img-fluid" alt="작은 사진 3">
          </a>
        </div>
        <div class="col-6 mb-3">
          <a href="#" data-toggle="modal" data-target="#myModal">
            <img src="<%=ctxPath%>/resources/images/체육관4.jpg"  class="img-fluid" alt="작은 사진 4">
          </a>
        </div>
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
              <img class="d-block w-100" src="<%=ctxPath%>/resources/images/체육관3.jpg" alt="첫 번째 사진">
            </div>
            <div class="carousel-item">
              <img class="d-block w-100" src="<%=ctxPath%>/resources/images/체육관2.jpg" alt="두 번째 사진">
            </div>
            <div class="carousel-item">
              <img class="d-block w-100" src="<%=ctxPath%>/resources/images/체육관3.jpg" alt="세 번째 사진">
            </div>
            <div class="carousel-item">
              <img class="d-block w-100" src="<%=ctxPath%>/resources/images/체육관2.jpg" alt="네 번째 사진">
            </div>
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
        <div> 📍서울 송파구 토성로 58 옥상층</div>
        <br>
        <li style="font-size: 20px; font-family: 'Volt110', sans-serif; font-weight: 700;">[송파/풋살]실외풋살장</li>
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
    
    <div class="col-md-6">
      <div class="info-box">
        <div class="payment-box">
          <div class="payment-options">
            <div class="form-group">
              <div class="custom-control custom-checkbox">
                <input type="checkbox" class="custom-control-input" id="checkbox-sports">
                <label class="custom-control-label" for="checkbox-sports">생활체육 - 25,000원 / 1시간 [2시간부터]</label>
              </div>
            </div>
            <hr>
            <div class="form-group">
              <div class="custom-control custom-checkbox">
                <input type="checkbox" class="custom-control-input" id="checkbox-unlimited">
                <label class="custom-control-label" for="checkbox-unlimited">하루무제한 - 100,000원 / 1시간 [1시간부터]</label>
              </div>
            </div>
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
	         <button class="btn btn-success" style="padding: 10px 200px;">예약하기</button>
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
			★운동장 사이즈: 30m*15m (가로*세로) <br>

			★가능 종목: 풋살 (5:5)<br>

			★접근성: 강동구청역 2분 거리 (자차 기준)<br>

			★주차: 건물 내 주차 시 출차할 때 2천원 정산 (2시간 30분 기준)<br>

			★시설 및 기자재: 대기실, 실내 화장실, 공/조끼 대여 가능, 물/음료수 및 풋살화 개인 지참<br>

			★출입 : 건물 내 1층 ′마포숯불갈비′ 옆문으로 출입.<br>
			(엘리베이터 사용 불가)<br>
			
			★기타: 코로나 방역수칙 준수<br>
			</div>
	
			<div style="width: 50%; margin: 5% auto;">
			<img src="<%=ctxPath%>/resources/images/체육관2.jpg" class="img-fluid"
				style="width: 100%;" /> 공차러 와~
				
			<img src="<%=ctxPath%>/resources/images/체육관3.jpg" class="img-fluid"
			style="width: 100%;" /> 하이
			</div>
	</div>
	<br>
	
	
	<div id="caution-section">
	<hr>
	<%-- === 주의사항  보여주기 === --%>
	<h3 style="margin-top: 50px;">주의사항</h3>
	<br>
- 대관 중 시설 훼손이 발생한 경우 손해액을 호스트에게 배상해야합니다.<br>
- 시간 초과시, 추가 요금은 현장 결제합니다. (1시간 마다 발생)<br>
- 사용자 인원수가 초과될 경우, 초과 결제를 요청합니다.<br>
- 대여 시간 보다 적게 사용 하시더라도 환불되지 않습니다.

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
	 	<div> 📍서울 송파구 토성로 58 옥상층</div>
 	</div>
	<br>
	

		<%-- === 문의 내용 보여주기 === --%>
	<div id="inquiry-section" class="text-left">
			<hr>
			<h3 style="margin-top: 50px;">문의</h3>
	 		 	<select name="" id="">
	 		    <option value="default">문의 유형을 선택하세요</option>
   			 	<option value="">가격문의</option>
    			<option value="">일정문의</option>
    			<option value="">공간정보문의</option>
   				<option value="">물품이용문의</option>
   				<option value="">기타	</option>
   			 </select>
   			 <br>
	<div class="row">
		<div class="col-lg-10">
			<form name="commentFrm">
				<textarea name="contents"
					style="font-size: 12pt; width: 100%; height: 150px;"></textarea>
				<input type="hidden" name="fk_userid"
					value="${sessionScope.loginuser.userid}" /> <input type="hidden"
					name="fk_pnum" value="${requestScope.pvo.pnum}" />
			</form>
		</div>
		<div class="col-lg-2" style="display: flex;">
			<button type="button" class="btn btn-outline-secondary w-100 h-100"
				id="btnCommentOK" style="margin: auto;">
				<span class="h5">등록</span>
			</button>
		</div>
	</div>

		<%-- === 댓글 내용 보여주기 === --%>
      <h3 style="margin-top: 50px;">문의내용</h3>
      <div>
	      <table class="table" style="font-size: 12px;">
	         <thead>
	         	<tr>
	         		<th style="twidth: 6%;">순번</th>
		            <th style="text-align: center;">내용</th>
		            <th style="width: 8%; text-align: center;">작성자</th>
		            <th style="width: 12%; text-align: center;">작성일자</th>
		            <th style="width: 12%; text-align: center;">수정/삭제</th>
	         	</tr>
	         </thead>
	         <tbody id="commentDisplay"></tbody>
	      </table>
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



	

	





