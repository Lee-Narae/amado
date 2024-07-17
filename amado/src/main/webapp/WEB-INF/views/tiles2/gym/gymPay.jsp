<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
   String ctxPath = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>체육관 예약</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/bootstrap-4.6.2-dist/css/bootstrap.min.css" >
    <style>
        .container {
            max-width: 800px;
            width: 20%;
            margin: 1.5% 2% 8% 5%
        }
        .section {
            margin-bottom: 20px;
        }
        .btn-custom {
            flex: 1 1 23%; /* 버튼들이 4개의 열을 가진 그리드로 배치됨 */
            height: 50px;
            margin: 5px; /* 버튼 사이의 간격 */
        }
        .btn-container {
            display: flex;
            flex-wrap: wrap; /* 버튼들을 여러 줄로 감싸서 표시 */
            justify-content: space-between; /* 버튼 사이의 간격을 균등하게 배치 */
        }
        .btn-custom.selected {
            background-color: #007bff;
            color: white;
        }
        .price {
            font-size: 24px;
            font-weight: bold;
        }
        .btn-reserve {
            width: 100%; /* 예약 버튼을 전체 폭으로 설정 */
            height: 50px;
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
    </style>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3e40c6a4e83259bd26e2771ad2db4e63"></script>
    <script>
    
    
    
    $(document).ready(function(){
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
			        var imageSrc = '<%=ctxPath%>/resources/images/marker.png';
					
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
    })
    
    
    
    
        let totalPrice = 0;

        function updatePrice(amount) {
            totalPrice += amount;
            document.getElementById("totalPrice").innerText = '₩' + totalPrice.toLocaleString();
        }

        function toggleSelection(button) {
            const isSelected = button.classList.contains('selected');
            const buttonValue = 10000;

            // Toggle button selection
            if (isSelected) {
                button.classList.remove('selected');
                updatePrice(-buttonValue);
            } else {
                button.classList.add('selected');
                updatePrice(buttonValue);
            }
        }
    </script>
</head>
<body>
	<div style="display: flex">
	    <div class="container">
	        <!-- 체육관 사진 -->
	        <div class="section">
	            <img src="<%=ctxPath%>/resources/images/gym.jpg" class="img-fluid" alt="체육관 사진">
	        </div>
	
	        <!-- 날짜 선택 -->
	        <div class="section">
	            <label for="date">날짜 선택:</label>
	            <input type="date" id="date" class="form-control">
	        </div>
	
	        <!-- 시간 선택 버튼들 -->
	        <div class="section">
	            <label for="time">시간 선택:</label>
	            <div class="btn-container">
	                <% 
	                    for (int i = 0; i < 24; i++) {
	                        String time = String.format("%02d:00", i);
	                        out.print("<button class='btn btn-outline-primary btn-custom' onclick=\"toggleSelection(this)\">" + time + "</button>");
	                    }
	                %>
	            </div>
	            
	        </div>
	
	        <!-- 총 가격 -->
	        <div class="section">
	            <span class="price" id="totalPrice">₩0</span>
	        </div>
	
	        <!-- 예약하기 버튼 -->
	        <div class="section">
	            <button class="btn btn-primary btn-reserve">예약하기</button>
	        </div>
	    </div>
	    <div>
	    	<div id="additional-info-section">
					<%-- === 추가정보  보여주기 === --%>
				
				<div id="title"></div>
			 	<div id="map" style="width:550%; height:900px;"></div>
			 	<div id="latlngResult"></div> 
			 	<div> 📍서울 송파구 토성로 58 옥상층</div>
		 	</div>
	    </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.7.1.min.js"></script>
  	<script type="text/javascript" src="<%= ctxPath%>/resources/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script>
  	<script type="text/javascript" src="<%= ctxPath%>/resources/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script> 
</body>
</html>
