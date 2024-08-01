<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
   String ctxPath = request.getContextPath();
%>    
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>예약내역</title>
    <!-- 부트스트랩 CSS 링크 -->
    <link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/bootstrap-4.6.2-dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f0f4f8; /* 연한 배경색 */
            font-family: 'Arial', sans-serif;
        }
        .container {
            margin-top: 30px;
        }
        .table-container {
            background: #ffffff; /* 테이블 배경을 흰색으로 유지 */
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        .table thead th {
            background-color: #81d4fa; /* 하늘색 헤더 */
            color: #01579b; /* 어두운 하늘색 글자 */
            font-weight: bold;
            text-align: center;
            border-bottom: 2px solid #01579b; /* 헤더 밑에 테두리 */
        }
        .table tbody tr {
            transition: background-color 0.3s;
        }
        .table tbody tr:hover {
            background-color: #b3e5fc; /* 호버 시 배경 색상 */
        }
        .table tbody tr:nth-child(odd) {
            background-color: #ffffff; /* 홀수 행 배경 색상 */
        }
        .table tbody td {
            padding: 12px;
            border-top: 1px solid #e1f5fe; /* 행 사이에 테두리 추가 */
            color: #0277bd; /* 어두운 하늘색 글자 */
            background-color: #ffffff; /* 각 셀 배경 색상을 하얀색으로 유지 */
        }
        .table td {
            cursor: pointer;
        }
        .btn-cancel {
            background-color: #ff3d00; /* 빨간색 버튼 배경 */
            color: #ffffff; /* 버튼 글자 색상 */
            border: none;
            border-radius: 5px;
            padding: 8px 12px;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .btn-cancel:hover {
            background-color: #c62828; /* 호버 시 어두운 빨간색 */
        }

        /* 모달 스타일링 */
        .modal-header {
            background-color: #01579b; /* 타이틀 배경색 */
            color: #fff; /* 타이틀 글자색 */
            border-bottom: none;
            padding: 15px;
        }

        .modal-title {
            font-size: 24px;
            font-weight: bold;
        }

        .modal-body {
            padding: 20px;
            font-size: 16px;
            color: #333;
        }

        .modal-body p {
            margin-bottom: 10px;
        }

        .modal-footer {
            border-top: none;
            padding: 15px;
            justify-content: flex-end;
        }

        .btn-secondary {
            background-color: #0277bd; /* 닫기 버튼 배경색 */
            color: #fff;
            border-radius: 5px;
            padding: 8px 16px;
            font-size: 14px;
        }

        .btn-secondary:hover {
            background-color: #01579b; /* 닫기 버튼 호버 색상 */
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="table-container">
            <h1 class="text-center my-4">예약 관리</h1>
            <table class="table">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>예약장소</th>
                        <th>예약날짜</th>
                        <th>예약시간</th>
                        <th>예약금액</th>
                        <th>예약취소</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="reservation" items="${requestScope.resList}" varStatus="status">
                        <tr class="clickable">
                            <td style="text-align: center;"><c:out value="${status.index + 1}"/></td>
                            <td style="text-align: center;" data-content="<c:out value='${reservation.gymname}'/>"><c:out value="${reservation.gymname}"/></td>
                            <td style="text-align: center;" data-content="<c:out value='${reservation.reservation_date.substring(0, 10)}'/>">
							  <c:out value="${reservation.reservation_date.substring(0, 10)}"/>
							</td>
                            <td style="text-align: center;" data-content="<c:out value='${reservation.time_range}'/>"><c:out value="${reservation.time_range}"/></td>
                            <td style="text-align: center;" data-content="<fmt:formatNumber value='${reservation.coinmoney}' pattern='#,###'/>">
							  <fmt:formatNumber value="${reservation.coinmoney}" pattern="#,###"/>원
							  <input id="fk_gymseq" type="hidden" value="${reservation.fk_gymseq}" />
							</td>
                            <td style="text-align: center;"><button class="btn-cancel" onclick="res_cancel('${reservation.fk_gymseq}','${reservation.fk_userid}','${reservation.reservation_date.substring(0, 10)}','${reservation.time_range}')">예약취소</button></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

	<div align="center" style="border: solid 0px gray; width: 80%; margin: 30px auto;">  
	     ${requestScope.pageBar}
	</div>
	
    <!-- 모달 HTML -->
    <div class="modal fade" id="infoModal" tabindex="-1" role="dialog" aria-labelledby="infoModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="infoModalLabel">상세 정보</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p style="border-left: solid 3px #01579b; padding-left:2%;" id="modalGymname"></p>
                    <p style="border-left: solid 3px #01579b; padding-left:2%;" id="modalDate"></p>
                    <p style="border-left: solid 3px #01579b; padding-left:2%;" id="modalTime"></p>
                    <p style="border-left: solid 3px #01579b; padding-left:2%;" id="modalAmount"></p>
                    <br>
                    <input type="hidden" id="modalGymSeq" value="" />
                    <div style="border-left: solid 3px #01579b; padding-left:2%;" id="gymmap">찾아가는 길</div>
                    <div align="center">
						 <div id="map" style="margin-top:2%; width:500px; height:300px;"></div>
					</div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 사용자 정의 JS -->
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3e40c6a4e83259bd26e2771ad2db4e63"></script>
    <script>
    $(document).ready(function(){
		 
    });
    
    
    
    
        document.addEventListener('DOMContentLoaded', function () {
            var rows = document.querySelectorAll('.clickable');
            rows.forEach(function(row) {
                row.addEventListener('click', function() {
                    // 각 셀의 데이터를 가져옵니다.
                    var gymname = row.querySelector('td[data-content]').getAttribute('data-content');
                    var date = row.querySelectorAll('td[data-content]')[1].getAttribute('data-content');
                    var time = row.querySelectorAll('td[data-content]')[2].getAttribute('data-content');
                    var amount = row.querySelectorAll('td[data-content]')[3].getAttribute('data-content') + "원";
                    var fk_gymseq = row.querySelector('input#fk_gymseq').value; // 숨겨진 input 값 가져오기
                    
                    // 모달에 데이터를 설정합니다.
                    document.getElementById('modalGymname').innerText = "예약장소: " + gymname;
                    document.getElementById('modalDate').innerText = "예약날짜: " + date;
                    document.getElementById('modalTime').innerText = "예약시간: " + time;
                    document.getElementById('modalAmount').innerText = "예약금액: " + amount;
                    document.getElementById('modalGymSeq').value = fk_gymseq; // 추가된 정보

                    
                    $.ajax({
            			url:"<%= ctxPath%>/gym/latlng.do",
            			type:"get",
            			data:{"gymseq":fk_gymseq},
            			dataType:"json",
            			success:function(json){
            				//console.log(JSON.stringify(json));
            				let lat = json.lat; // 위도
            				let lng = json.lng; // 경도
            				
            				
            				
            				// 지도를 담을 영역의 DOM 레퍼런스
                			var mapContainer = document.getElementById("map");
                			console.log(lat)
        					console.log(lng)
                			// 지도를 생성할때 필요한 기본 옵션
                			var options = {
                		    	 	center: new kakao.maps.LatLng(lat, lng), // 지도의 중심좌표. 반드시 존재해야함.
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
                			var gymseq = $("input#modalGymSeq").val();
                			var position = {};
                			$.ajax({
                				url:"<%= ctxPath%>/gym/viewres_JSON.do",
                				async:false, // !!!!! 지도는 비동기 통신이 아닌 동기 통신으로 해야 한다.!!!!!!
                				data:{"gymseq":gymseq},
                				dataType:"json",
                				success:function(json){
                					
                				    console.log(JSON.stringify(json));
                					// JSON.stringify(json) 은 자바스크립트의 객체(배열)인 json 을 string 타입으로 변경시켜주는 것이다.
                					
                					position.content = json.gymseq;
                					                   
                					position.latlng = new kakao.maps.LatLng(json.lat, json.lng);
                						
                					
                				},
                				error: function(request, status, error){
                					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
                			    }
                			});// end of $.ajax({})----------------------
                			
                			
                			// infowindowArr 은 인포윈도우를 가지고 있는 객체 배열의 용도이다. 
                			var infowindowArr = new Array();
                			
                			
                		    
                			// === 객체 배열 만큼 마커 및 인포윈도우를 생성하여 지도위에 표시한다. === //
                				
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
               			        position: position.latlng, // locPosition 좌표에 마커를 생성 
               			        image: markerImage     // 마커이미지 설정
               				}); 
               			    
               				marker.setMap(mapobj); // 지도에 마커를 표시한다
               				
               				
               				// == 인포윈도우를 생성하기 == 
               				var infowindow = new kakao.maps.InfoWindow({
               					content: position.content,
               					removable: true,
               					zIndex : 1
               				});
               				
               				// 인포윈도우를 가지고 있는 객체배열에 넣기 
               				infowindowArr.push(infowindow);
                				
                				
                			// ============ 지도에 매장위치 마커 보여주기 끝 ============ //
            			},// end of success: function(xml){ }------------------
            			
            			error: function(request, status, error){
            				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            			}
            		});
                    
                    
                    
                 
                    
                    
                    
                    // 모달을 엽니다.
                    $('#infoModal').modal('show');
                });
            });
        });

        function res_cancel(gymseq, fk_userid, reservation_date, time_range){
            // confirm 대화상자를 통해 예약 취소 여부를 묻습니다.
            if (confirm("정말로 예약을 취소하시겠습니까?")) {
                $.ajax({
                    url: "<%= ctxPath %>/gym/res_cancel.do",
                    data: {
                        "gymseq": gymseq,
                        "fk_userid": fk_userid,
                        "reservation_date": reservation_date,
                        "time_range": time_range,
                    },
                    dataType: "json",
                    success: function(json) {
                        console.log(JSON.stringify(json));
                        if (json.n > 0) {
                            alert('예약취소가 완료됐습니다!');
                            window.location.reload();
                        }
                    },
                    error: function(request, status, error) {
                        alert("code: " + request.status + "\n" +
                              "message: " + request.responseText + "\n" +
                              "error: " + error);
                    }
                }); // end of ajax--------------------------------------
            } else {
                // 취소 버튼을 눌렀을 때 실행할 코드 (필요할 경우)
                console.log('예약 취소를 취소했습니다.');
            }
        }
    </script>

    <!-- 부트스트랩 JS 및 Popper.js 링크 (필요한 경우) -->
    <script src="<%= ctxPath%>/resources/bootstrap-4.6.2-dist/js/bootstrap.min.js"></script>

</body>