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
            margin: 1.5% 2% 3% 5%
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
.gym-image {
      width: 330px; /* 원하는 너비 */
      height: 180px; /* 원하는 높이 */
      object-fit: cover; /* 이미지를 컨테이너에 맞추어 자르기 */
  }
/*지도 끝*/

.btn-disabled {
    background-color: #d3d3d3; /* 회색 배경색 */
    color: #a9a9a9; /* 연한 회색 텍스트 */
    border-color: #a9a9a9; /* 연한 회색 테두리 */
    cursor: not-allowed; /* 마우스 커서를 금지 아이콘으로 변경 */
}

.btn-disabled:disabled {
    opacity: 1; /* 비활성화된 버튼의 불투명도 조정 */
}
.btn-custom-disabled {
    background-color: gray;
    color: white;
    border: 1px solid gray;
}
.btn-outline-primary:disabled {
    background-color: gray;
    color: white;
    border: 1px solid gray;
}
        
        
        
.container {
    position: relative; /* 부모 요소는 상대적으로 위치를 지정 */
}

.rainy-image {
    position: absolute;
    top: 0;
    left: 0;
    z-index: -1; /* 높은 z-index 값 */
}

.container1 {
    position: relative;
    z-index: 5; /* 낮은 z-index 값 */
}

</style>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3e40c6a4e83259bd26e2771ad2db4e63"></script>
    <script>
    
    let totalPrice = 0;
    
    $(document).ready(function(){
    	
    	
    	// 지도를 담을 영역의 DOM 레퍼런스
    	var mapContainer = document.getElementById("map");
    	
    	// 지도를 생성할때 필요한 기본 옵션
    	var options = {
        	 	center: new kakao.maps.LatLng($("input.gymlat").val(), $("input.gymlng").val()), // 지도의 중심좌표. 반드시 존재해야함.
        	 	<%--
        		  	center 에 할당할 값은 kakao.maps.LatLng 클래스를 사용하여 생성한다.
        		  	kakao.maps.LatLng 클래스의 2개 인자값은 첫번째 파라미터는 위도(latitude)이고, 두번째 파라미터는 경도(longitude)이다.
        		 --%>
        	 	level: 4  // 지도의 레벨(확대, 축소 정도). 숫자가 클수록 축소된다. 4가 적당함.
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
    	
    	
    	// ============ 지도에 따릉이위치 마커 보여주기 시작 ============ //
    	// 따릉이 마커를 표시할 위치와 내용을 가지고 있는 객체 배열
    	var positionArr = [];
    	
    	$.ajax({
    		url:"<%= ctxPath%>/gym/gymPay_JSON.do",
    		async:false, // !!!!! 지도는 비동기 통신이 아닌 동기 통신으로 해야 한다.!!!!!!
    		dataType:"json",
    		success:function(json){
    			
    		    // console.log(JSON.stringify(json));
    			// JSON.stringify(json) 은 자바스크립트의 객체(배열)인 json 을 string 타입으로 변경시켜주는 것이다.
    			
    			$.each(json, function(index, item){
    				var position = {};
    				
    				position.content = item.gymseq;
    				                   
    				position.latlng = new kakao.maps.LatLng(item.lat, item.lng);
    				positionArr.push(position);
    				
    				//console.log(position)
    			});// end of $.each(json, function(index, item){})---------------
    			
    		},
    		error: function(request, status, error){
    			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
    	    }
    	});// end of $.ajax({})----------------------
    	
    	
    	// infowindowArr 은 인포윈도우를 가지고 있는 객체 배열의 용도이다. 
    	var infowindowArr = new Array();
    	
    	
	    
    	// === 객체 배열 만큼 마커 및 인포윈도우를 생성하여 지도위에 표시한다. === //
    	for(var i=0; i<positionArr.length; i++){
    		
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
		        position: positionArr[i].latlng, // locPosition 좌표에 마커를 생성 
		        image: markerImage     // 마커이미지 설정
			}); 
		    
			marker.setMap(mapobj); // 지도에 마커를 표시한다
    		
			
    		// == 인포윈도우를 생성하기 == 
    		var infowindow = new kakao.maps.InfoWindow({
    			content: positionArr[i].content,
    			removable: true,
    			zIndex : i+1
    		});
    		
    		// 인포윈도우를 가지고 있는 객체배열에 넣기 
    		infowindowArr.push(infowindow);
    		
    		// == 마커 위에 인포윈도우를 표시하기 == //
    		// infowindow.open(mapobj, marker);
    		
    		// == 마커 위에 인포윈도우를 표시하기 == //
    		// 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
    	    // 이벤트 리스너로는 클로저(closure => 함수 내에서 함수를 정의하고 사용하도록 만든것)를 만들어 등록합니다 
    	    // for문에서 클로저(closure => 함수 내에서 함수를 정의하고 사용하도록 만든것)를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
    	    kakao.maps.event.addListener(marker, 'click', makeOverListener(mapobj, marker, infowindow, infowindowArr)); 
    		
    		
    		
    		
    	}// end of for----------------
    	// ============ 지도에 매장위치 마커 보여주기 끝 ============ //
			
		    
		  // 이미지 클릭 시 모달에 이미지 경로 설정
		  $('.modal-link').on('click', function() {
		    var imageUrl = $(this).find('img').attr('src');
		    $('#modalImage').attr('src', imageUrl);
		  });
    	
    	
		  
		  
		  
		  $(document).on("change", "input[id='date']", function(e){
			    const selectedDate = new Date($(this).val());
			    const today = new Date();
			    
			    // 오늘 날짜의 시간 부분을 0으로 설정
			    today.setHours(0, 0, 0, 0);

			    // 선택된 날짜의 시간 부분을 0으로 설정
			    selectedDate.setHours(0, 0, 0, 0);

			    // 선택된 날짜가 현재 날짜보다 이전인지 확인
			    if (selectedDate < today) {
			        alert("이전 날짜는 선택할 수 없습니다.");
			        
			        // 날짜를 현재 날짜로 되돌림
			        const year = today.getFullYear();
			        const month = ("0" + (today.getMonth() + 1)).slice(-2); // 월은 0부터 시작하므로 1을 더함
			        const day = ("0" + today.getDate()).slice(-2);
			        $(this).val(`${year}-${month}-${day}`);

			        // 모든 버튼을 원래 색으로 바꾸고 활성화
			        $(".btn-container button").removeAttr("disabled").removeClass("btn-custom-disabled").addClass("btn-outline-primary").css("background-color", "");

			        return;
			    }
			    
			    const reservation_date = $("#date").val();
			    const gymseq = $("input.gymseq").val();
			    
			    $.ajax({
			        url:"<%= ctxPath %>/gym/gymPayDate.do",
			        data:{"reservation_date":reservation_date,
			              "gymseq":gymseq},
			        dataType:"json",
			        success:function(json){
			            v_html ="";
			            const currentTime = new Date();

			            if(json.length == 1){
			                totalPrice = 0;
			                v_html += "<div class='section'>";
			                v_html += "    <label for='time'>시간 선택:</label>";
			                v_html += "    <div class='btn-container'>";
			                for (let i = 0; i < 24; i++) {
			                    let time = ("0" + i).slice(-2) + ":00";
			                    let isDisabled = false;

			                    // 오늘 날짜의 지난 시간인지 확인하여 비활성화
			                    if (selectedDate.toDateString() === today.toDateString() && i < currentTime.getHours()) {
			                        isDisabled = true;
			                    }

			                    v_html += "<button class='btn btn-outline-primary btn-custom' data-cost='" + json[0].cost + "' onclick='toggleSelection(this)'" + (isDisabled ? " disabled class='btn-custom-disabled'" : "") + ">" + time + "</button>";
			                }
			                v_html += "   </div>";
			                v_html += "</div>";
			                v_html += "<div class='section'>";
			                v_html += "    <span class='price' id='totalPrice'>₩0원</span>";
			                v_html += "</div>";
			                $("div#time").html(v_html);
			            }

			            if(json.length > 1){
			                $.each(json, function(index, item) {
			                    if(index == 0){
			                        totalPrice = 0;
			                        v_html += "<div class='section'>";
			                        v_html += "    <label for='time'>시간 선택:</label>";
			                        v_html += "    <div class='btn-container'>";
			                        for (let i = 0; i < 24; i++) {
			                            let time = ("0" + i).slice(-2) + ":00";
			                            let isDisabled = false;
			                            let cost = json[0].cost;

			                            // 오늘 날짜의 지난 시간인지 확인하여 비활성화
			                            if (selectedDate.toDateString() === today.toDateString() && i < currentTime.getHours()) {
			                                isDisabled = true;
			                            }

			                            // 해당 시간에 해당하는 json 항목을 확인하여 버튼을 회색으로 만들지 결정
			                            $.each(json, function(index, item) {
			                                if (time == item.time) {
			                                    isDisabled = true;
			                                    cost = item.cost;
			                                    return false; // break out of the each loop
			                                }
			                            });

			                            if (isDisabled) {
			                                v_html += "<button class='btn btn-custom btn-custom-disabled' data-cost='" + cost + "' onclick='toggleSelection(this)' disabled>" + time + "</button>";
			                            } else {
			                                v_html += "<button class='btn btn-outline-primary btn-custom' data-cost='" + cost + "' onclick='toggleSelection(this)'>" + time + "</button>";
			                            }
			                        }
			                        v_html += "   </div>";
			                        v_html += "</div>";
			                        v_html += "<div class='section'>";
			                        v_html += "    <span class='price' id='totalPrice'>₩0원</span>";
			                        v_html += "</div>";
			                        $("div#time").html(v_html);
			                    }
			                });
			            }
			        },
			        error: function(request, status, error){
			            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			        }
			    });// end of ajax--------------------------------------
			    
			    
			    
			    
			    
			    
			    $.ajax({
					url:"<%= ctxPath%>/weather/weatherXML.do",
					type:"get",
					dataType:"xml",
					success:function(xml){
						const rootElement = $(xml).find(":root"); 
						console.log("확인용 : " + $(rootElement).prop("tagName") );
						// 확인용 : current
						
						const weather = rootElement.find("weather"); 
						const updateTime = $(weather).attr("year")+"년 "+$(weather).attr("month")+"월 "+$(weather).attr("day")+"일 "+$(weather).attr("hour")+"시"; 
						console.log(updateTime);
						// 2024년 07월 19일 12시
						
						const localArr = rootElement.find("local");
						console.log("지역개수 : " + localArr.length);
						// 지역개수 : 97
						
					    
					    // ====== XML 을 JSON 으로 변경하기  시작 ====== //
						var jsonObjArr = [];
						// ====== XML 을 JSON 으로 변경하기  끝 ====== //    
					        
					    for(let i=0; i<localArr.length; i++){
					    	
					    	let local = $(localArr).eq(i);
							/* .eq(index) 는 선택된 요소들을 인덱스 번호로 찾을 수 있는 선택자이다. 
							      마치 배열의 인덱스(index)로 값(value)를 찾는 것과 같은 효과를 낸다.
							*/
							
					      // console.log( $(local).text() + " stn_id:" + $(local).attr("stn_id") + " icon:" + $(local).attr("icon") + " desc:" + $(local).attr("desc") + " ta:" + $(local).attr("ta") ); 
					      //	속초 stn_id:90 icon:03 desc:구름많음 ta:29.0
					      //	
					    	
					        let icon = $(local).attr("icon");  
					        if(icon == "") {
					        	icon = "없음";
					        }
					      
							
							// ====== XML 을 JSON 으로 변경하기  시작 ====== //
						    var jsonObj = {"locationName":$(local).text(), "ta":$(local).attr("ta")};
							   
						    jsonObjArr.push(jsonObj);
							// ====== XML 을 JSON 으로 변경하기  끝 ====== //
							
					    }// end of for------------------------ 
					    
					    
					},// end of success: function(xml){ }------------------
					
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
			    });
			});
		  
		  
		  
    })// end of ready--------------------------------------
    
    
    
    
        

        function updatePrice(amount) {
            totalPrice += amount;
            $("#totalPrice").html('₩' + Number(totalPrice).toLocaleString() + '원');
        }

        function toggleSelection(button) {
        	
        	let cost = button.getAttribute('data-cost');
        	
            const isSelected = button.classList.contains('selected');
            var buttonValue = Number(cost);
            

            // Toggle button selection
            if (isSelected) {
                button.classList.remove('selected');
                updatePrice(-buttonValue);
            } else {
                button.classList.add('selected');
                updatePrice(buttonValue);
            }
        }
        
        
     // !! 인포윈도우를 표시하는 클로저(closure => 함수 내에서 함수를 정의하고 사용하도록 만든것)를 만드는 함수(카카오에서 제공해준것임)입니다 !! // 
        function makeOverListener(mapobj, marker, infowindow, infowindowArr) {
      	    return function() {
      	    	// alert("infowindow.getZIndex()-1:"+ (infowindow.getZIndex()-1));
      	    	//alert(infowindow.getContent())
      	    	let gymseq = infowindow.getContent();
      	    	const ctxPath = '<%= ctxPath%>';
      	    	
      	    	$.ajax({
		    		url:"<%= ctxPath%>/gym/gymPay_dtail.do",
		    		async:false, // !!!!! 지도는 비동기 통신이 아닌 동기 통신으로 해야 한다.!!!!!!
		    		data:{"gymseq":infowindow.getContent()},
		    		dataType:"json",
		    		success:function(json){
		    			totalPrice = 0;
		    		    console.log(JSON.stringify(json));
		    			// JSON.stringify(json) 은 자바스크립트의 객체(배열)인 json 을 string 타입으로 변경시켜주는 것이다.
		    			
		    			v_html ="";
		    			v_html += "<div class='container1'>";
		    			v_html += "<div class='section'>";
		    			v_html += "<img src='<%=ctxPath%>/resources/images/1/"+json.orgfilename+"' class='gym-image' alt='체육관 사진'>";
		    			v_html += "</div>";
		    			v_html += "<div id='gymname' style='text-align: center; margin-top: 3%; margin-bottom: 13%; font-size: 25px; font-weight: bold'>"
		    			v_html += json.gymname;
		    			v_html += "</div>";
				        
		    			v_html += "<div class='section' style='display: flex; margin-bottom: 11%;'>";
		    			v_html += "    <label style='padding-top:2%;' for='date'>날짜 선택:</label>";
		    			v_html += "    <input style='margin-left:5%; margin-bottom:1%; width: 70%;' type='date' id='date' class='form-control'>";
		    			v_html += "</div>";
				
				        v_html += "<div id='time'>"
		    			
		    			v_html += "<div class='section'>";
		    			v_html += "    <label for='time'>시간 선택:</label>";
		    			v_html += "    <div class='btn-container'>";
		    			for (let i = 0; i < 24; i++) {
		    	            let time = ("0" + i).slice(-2) + ":00";
		    	            v_html += "<button class='btn btn-outline-primary btn-custom' data-cost='" + json.cost + "' onclick='toggleSelection(this)'>" + time + "</button>";
		    	        }
				        v_html += "   </div>";
				            
				        v_html += "</div>";
				
				        <!-- 총 가격 -->
				        v_html += "<div class='section'>";
				        v_html += "    <span class='price' id='totalPrice'>₩0원</span>";
				        v_html += "</div>";
				        
				        v_html += "</div>";
				        v_html += "<div class='section'>";
				        v_html += 
				            '<button class="btn btn-primary btn-reserve" ' +
				            'onclick="goCoinPurchaseEnd(\'' + ctxPath + '\', \'' + $('input.fk_userid').val() + '\', \'' + json.gymname + '\')">' +
				            '예약하기' +
				            '</button>';
				        
				        v_html += "</div>";
				        v_html += "</div>";
				       
		    			$("input.gymseq").val(json.gymseq);
		    			$("div.container").html(v_html);
		    			
		    			let newUrl = window.location.protocol + "//" + window.location.host + window.location.pathname + "?gymseq=" + gymseq;
		                window.history.pushState({ path: newUrl }, '', newUrl);
		                
		                
		    			
		    		},
		    		error: function(request, status, error){
		    			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		    	    }
		    	});// end of $.ajax({})----------------------
      	    	
      	    	
      	   		//location.href = "<%=ctxPath%>/gym/gymPay.do?gymseq="+infowindow.getContent();
      	    };
      	}// end of function makeOverListener(mapobj, marker, infowindow, infowindowArr)--------
      	
      	

      	// === 포트원(구 아임포트) 결제를 해주는 함수 === //
		function goCoinPurchaseEnd(ctxPath, userid, gymname) {
			
      		if(userid == ''){
      			alert("로그인 후 결제해주세요!");
      			return;
      		}
      		else{
		    // 결제 금액을 가져옵니다.
		    var priceText = $("#totalPrice").text();
		            
		    // ₩, 원, , 문자를 제거하여 결제 금액을 숫자로 변환합니다.
		    var coinmoney = priceText.replace(/[₩,원,]/g, '').trim();
		
		    // 팝업창의 크기 설정
		    var width = 1000;
		    var height = 600;
		
		    // 화면 가운데에 팝업창 위치 설정
		    var left = Math.ceil((window.screen.width - width) / 2); // 정수로 만듬
		    var top = Math.ceil((window.screen.height - height) / 2); // 정수로 만듬
		
		    // 팝업창의 URL 설정
		    var url = ctxPath + "/gym/coinPurchaseEnd.do?coinmoney=" + coinmoney + "&userid=" + userid + "&gymname=" + gymname; 
		
		    // 팝업창 열기
		    window.open(url, "coinPurchaseEnd",
		                "left=" + left + ", top=" + top + ", width=" + width + ", height=" + height);
      		}
		}
      	
      	
     
      	
		function gymPayEndInsert(){
		    
		   	var priceText = $("#totalPrice").text();
            
		   	/////////////////////////////////////////////////////////
            // ₩, 원, , 문자를 제거합니다.
            var numericPrice = priceText.replace(/[₩,원]/g, '');
            const time = $("button.btn-custom.selected").text();
            const reservation_date = $("#date").val();
            const fk_gymseq = $("input.gymseq").val();
            const fk_userid = $("input.fk_userid").val();
		   	/////////////////////////////////////////////////////////

          //alert( $("input.gymseq").val() );
          //alert("gdgd");
		  //alert($("button.btn-custom.selected").text()+" ");
		  //alert(numericPrice);
          //alert( $("#date").val());
          
          	
          	$.ajax({
	    		url:"<%= ctxPath%>/gym/gymPay_end.do",
	    		type:"post",
	    		data:{"numericPrice":numericPrice,
	    			  "selected":time,
	    			  "reservation_date":reservation_date,
	    			  "fk_gymseq":fk_gymseq,
	    			  "fk_userid":fk_userid},
	    		dataType:"json",
	    		success:function(json){
	    			
	    			if(json.n == 1){
	    				alert("insert 완료");
	    				window.location.href = 'http://localhost:9099/amado/index.do';
	    			}
	    			else{
	    				
	    			}
	    			
	    		},
	    		error: function(request, status, error){
	    			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	    	    }
	    	});// end of $.ajax({})----------------------
		
		    
	  }
      	
    </script>
</head>
<body>
	<div style="display: flex">
		<%-- <img style="width: 70px; margin: 18.8% 0 0 10.5%;" src="<%=ctxPath%>/resources/images/rain.gif" class="rainy-image" alt="Rainy Image"> --%>
	    <div class="container">
	    	<div class="container1">
		        <!-- 체육관 사진 -->
		        <div class="section">
		            <img src="<%=ctxPath%>/resources/images/1/${requestScope.gymvo.orgfilename}" class="gym-image" alt="체육관 사진">
		        </div>
				<div id="gymname" style="text-align: center; margin-top: 3%; margin-bottom: 13%; font-size: 25px; font-weight: bold">
				 ${requestScope.gymvo.gymname}
				</div>
		        <!-- 날짜 선택 -->
		        <div class="section" style="display: flex; margin-bottom: 11%;">
		            <label style=padding-top:2%; for="date">날짜 선택: </label>
		            <input style="margin-left:5%; margin-bottom:1%; width: 70%;" type="date" id="date" class="form-control">
		        </div>
		
				<div id='time'>
			        <!-- 시간 선택 버튼들 -->
			        <div class="section" id="time">
					    <label for="time">시간 선택:</label>
					    <div class="btn-container">
					        <c:forEach var="i" begin="0" end="23">
					            <c:choose>
					                <c:when test="${i lt 10}">
					                    <c:set var="time" value="0${i}:00" />
					                </c:when>
					                <c:otherwise>
					                    <c:set var="time" value="${i}:00" />
					                </c:otherwise>
					            </c:choose>
					            <button class='btn btn-outline-primary btn-custom' data-cost='${requestScope.gymvo.cost}' onclick='toggleSelection(this)'>
					                ${time}
					            </button>
					        </c:forEach>
					    </div>
					</div>
			
			        <!-- 총 가격 -->
			        <div class="section">
			            <span class="price" id="totalPrice">₩0원</span>
			        </div>
		        </div>
			</div>
	        <!-- 예약하기 버튼 -->
	        <div class="section">
	            <button class="btn btn-primary btn-reserve" onclick="gymPayEndInsert()">예약하기</button>
	        </div>
	    </div>
	    <div>
	    	
				
			<div align="center">
				 <div id="map" style="margin-top:2%; width:1250px; height:1000px;"></div>
			</div>
		 	
	    </div>
    </div>
	
	<input class="gymlat" type="hidden" value="${requestScope.gymvo.lat}"></input>
	<input class="gymlng" type="hidden" value="${requestScope.gymvo.lng}"></input>
	<input class="gymcost" type="hidden" value="${requestScope.gymvo.cost}"></input>
	<input class='gymseq' type="hidden" value="${requestScope.gymseq}"></input>
	<input class='fk_userid' type="hidden" value="${sessionScope.loginuser.userid}"></input>
	
    <!-- Bootstrap JS and dependencies -->
    <script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.7.1.min.js"></script>
  	<script type="text/javascript" src="<%= ctxPath%>/resources/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script>
  	<script type="text/javascript" src="<%= ctxPath%>/resources/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script> 
</body>
</html>
