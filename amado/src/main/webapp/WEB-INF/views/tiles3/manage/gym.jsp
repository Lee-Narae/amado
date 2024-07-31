<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
   String ctxPath = request.getContextPath();
%>



<style type="text/css">
	
	div#bar_chart_container {
		height: 400px;
	}
	
	.highcharts-figure,	
	.highcharts-data-table table {
	    min-width: 320px;
	 /* max-width: 800px; */
	    margin: 1em auto;
	}
	
	.highcharts-data-table table {
	    font-family: Verdana, sans-serif;
	    border-collapse: collapse;
	    border: 1px solid #ebebeb;
	    margin: 10px auto;
	    text-align: center;
	    width: 100%;
	    max-width: 500px;
	}
	
	.highcharts-data-table caption {
	    padding: 1em 0;
	    font-size: 1.2em;
	    color: #555;
	}
	
	.highcharts-data-table th {
	    font-weight: 600;
	    padding: 0.5em;
	}
	
	.highcharts-data-table td,
	.highcharts-data-table th,
	.highcharts-data-table caption {
	    padding: 0.5em;
	}
	
	.highcharts-data-table thead tr,
	.highcharts-data-table tr:nth-child(even) {
	    background: #f8f8f8;
	}
	
	.highcharts-data-table tr:hover {
	    background: #f1f7ff;
	}
	
	input[type="number"] {
	    min-width: 50px;
	}
</style>

<script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/highcharts.js"></script>
<script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/modules/exporting.js"></script>
<script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/modules/export-data.js"></script>
<script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/modules/accessibility.js"></script>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("div#gymM").addClass("hover");
		
		const gymname = $("select#selectgym option:first").text();
		//alert(gymname);
		
		$.ajax({
			url:"<%= ctxPath%>/admin/manage/gym.do",
    		async:false, 
    		data: {"gymname": gymname},
    		dataType:"json",
    		success:function(json){
    			
    			//console.log(JSON.stringify(json));
    			
    			if(json.length == 0){
    				is_no_data = true;
    			}
    			
    			else { // 오라클 테이블에 데이터가 입력이 되어진 경우 
    			
    				// console.log(JSON.stringify(json));
    				const bar_data_arr = [];
    				
    
			    	  //bar_data.push(item.time);
			    	  // 빈 배열을 생성합니다. (시간별 데이터 저장)

					// 0부터 23까지 반복합니다. (하루 24시간 기준)
					for (let i = 0; i <= 23; i++) {
					    const bar_data = [];
					    
					    // 시간 문자열을 생성합니다. (예: 07:00, 14:00 등)
					    let timeStr = (i < 10 ? "0" + i : i) + ":00";
					    
					    // 현재 시간에 해당하는 데이터를 찾습니다.
					    let reservationCount = 0;
					    for (let item of json) {
					    	//console.log(item.time);
					        if (item.time === timeStr) {
					            reservationCount = Number(item.reservation_count);
					            break; // 일치하는 데이터를 찾으면 더 이상 검색할 필요 없음
					        }
					    }
					    
					    
					    // 시간과 예약 수를 bar_data에 추가합니다.
					    bar_data.push("<span class='gu' style='font-weight:bold; cursor:pointer;'>" + timeStr + "</span>");
					    bar_data.push(reservationCount);
					    
					    // bar_data를 bar_data_arr에 추가합니다.
					    bar_data_arr.push(bar_data);
					}
			    	  
			    	 
		    	    
    			
				     <%-- ==== 막대차트 시작 ==== --%>
				     Highcharts.chart('bar_chart_container', {
				            chart: {
				                type: 'column'
				            },
				            title: {
				                text: '체육관 시간대별 예약통계 막대차트 그래프'
				            },
				            xAxis: {
				                type: 'category',
				                labels: {
				                    rotation: -45,
				                    style: {
				                        fontSize: '13px',
				                        fontFamily: 'Verdana, sans-serif'
				                    }
				                }
				            },
				            yAxis: {
				                min: 0,
				                title: {
				                    text: '예약 통계'
				                }
				            },
				            legend: {
				                enabled: false
				            },
				            tooltip: {
				                pointFormat: '2024년 예약수: <b>{point.y} 개</b>'
				            },
				            series: [{
				                name: '예약수',
				                data: bar_data_arr,
				                color: '#CAF4FF', // 막대기 색상을 분홍색으로 설정합니다.
				                dataLabels: {
				                    enabled: true,
				                    rotation: -50,
				                    color: '#133863',
				                    align: 'right',
				                    y: 10, // 10 픽셀 아래
				                    style: {
				                        fontSize: '13px',
				                        fontFamily: 'Verdana, sans-serif'
				    	            }
				    	        }
				    	    }]
				    	});
				     <%-- ==== 막대차트 끝   ==== --%>
				     ///////////////////////////////////////////////////
				     
				     // ==== 막대차트에서 시간을 클릭했을 경우 이벤트 발생시키기 ==== //
				     $(document).on("click", "tspan.time", function(e){
				    	   alert("헤헤헤");
				    	   const text = $(e.target).text();
				    	   alert(`seoul_bicycle_rental 테이블에서 "\${text}"에 속한 주소지 정보를 Ajax 로 알아와서 뿌려주자.`);  
				     });
				     
    			}
    			
    			
    			
    		},
    		error: function(request, status, error){
    			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
    	    }
		});
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		$("select[name='selectgym']").change(function(e){
		
			let is_no_data = false;
			
			const gymname = $(e.target).val();
			//alert(gymname);
			
			$.ajax({
				url:"<%= ctxPath%>/admin/manage/gym.do",
	    		async:false, 
	    		data: {"gymname": gymname},
	    		dataType:"json",
	    		success:function(json){
	    			
	    			//console.log(JSON.stringify(json));
	    			
	    			if(json.length == 0){
	    				is_no_data = true;
	    			}
	    			
	    			else { // 오라클 테이블에 데이터가 입력이 되어진 경우 
	    			
	    				// console.log(JSON.stringify(json));
	    				const bar_data_arr = [];
	    				
	    
				    	  //bar_data.push(item.time);
				    	  // 빈 배열을 생성합니다. (시간별 데이터 저장)
	
						// 0부터 23까지 반복합니다. (하루 24시간 기준)
						for (let i = 0; i <= 23; i++) {
						    const bar_data = [];
						    
						    // 시간 문자열을 생성합니다. (예: 07:00, 14:00 등)
						    let timeStr = (i < 10 ? "0" + i : i) + ":00";
						    
						    // 현재 시간에 해당하는 데이터를 찾습니다.
						    let reservationCount = 0;
						    for (let item of json) {
						    	//console.log(item.time);
						        if (item.time === timeStr) {
						            reservationCount = Number(item.reservation_count);
						            break; // 일치하는 데이터를 찾으면 더 이상 검색할 필요 없음
						        }
						    }
						    
						    
						    // 시간과 예약 수를 bar_data에 추가합니다.
						    bar_data.push("<span class='gu' style='font-weight:bold; cursor:pointer;'>" + timeStr + "</span>");
						    bar_data.push(reservationCount);
						    
						    // bar_data를 bar_data_arr에 추가합니다.
						    bar_data_arr.push(bar_data);
						}
				    	  
				    	 
			    	    
	    			
					     <%-- ==== 막대차트 시작 ==== --%>
					     Highcharts.chart('bar_chart_container', {
					            chart: {
					                type: 'column'
					            },
					            title: {
					                text: '체육관 시간대별 예약통계 막대차트 그래프'
					            },
					            xAxis: {
					                type: 'category',
					                labels: {
					                    rotation: -45,
					                    style: {
					                        fontSize: '13px',
					                        fontFamily: 'Verdana, sans-serif'
					                    }
					                }
					            },
					            yAxis: {
					                min: 0,
					                title: {
					                    text: '예약 통계'
					                }
					            },
					            legend: {
					                enabled: false
					            },
					            tooltip: {
					                pointFormat: '2024년 예약수: <b>{point.y} 개</b>'
					            },
					            series: [{
					                name: '예약수',
					                data: bar_data_arr,
					                color: '#CAF4FF', // 막대기 색상을 분홍색으로 설정합니다.
					                dataLabels: {
					                    enabled: true,
					                    rotation: -50,
					                    color: '#133863',
					                    align: 'right',
					                    y: 10, // 10 픽셀 아래
					                    style: {
					                        fontSize: '13px',
					                        fontFamily: 'Verdana, sans-serif'
					    	            }
					    	        }
					    	    }]
					    	});
					     <%-- ==== 막대차트 끝   ==== --%>
					     ///////////////////////////////////////////////////
					     
					     // ==== 막대차트에서 시간을 클릭했을 경우 이벤트 발생시키기 ==== //
					     $(document).on("click", "tspan.time", function(e){
					    	   alert("헤헤헤");
					    	   const text = $(e.target).text();
					    	   alert(`seoul_bicycle_rental 테이블에서 "\${text}"에 속한 주소지 정보를 Ajax 로 알아와서 뿌려주자.`);  
					     });
					     
	    			}
	    			
	    			
	    			
	    		},
	    		error: function(request, status, error){
	    			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	    	    }
			});
		});
		
	});// end of $(document).ready(function(){})--------

</script>

<div style="width: 90%; margin: 0 auto; padding: 1% 0;">
    <div class="row">
    	<div class="col-md-6 offset-md-3">
    	  <p class="text-center h3 text-success pb-3"> 체육관 시간대별 예약통계 막대차트 그래프</p>
    	</div>
    </div>
    
    <select name="selectgym" id="selectgym"  class="form-select form-select-lg mb-3" aria-label="Large select example">
	  <option value="${requestScope.gymList[0].gymname}">${requestScope.gymList[0].gymname}</option>
	  <c:forEach var="gym" items="${requestScope.gymList}">
	  	  <c:if test="${gym.gymname != requestScope.gymList[0].gymname}">
		  	<option value="${gym.gymname}">${gym.gymname}</option>
		  </c:if>	
	  </c:forEach>
   </select>
	   
    <div class="row" style='width:80%;'>
    

		   
 	   <div class="col-md-3" id="tbl"></div>
 	   <div class="col-md-9" >
 	       
 	       
 	       <%-- 막대차트 시작 --%>
 	       <div class="border">
				<figure class="highcharts-figure">
				    <div id="bar_chart_container"></div>
				    <p class="text-center">
				        체육관 시간대별 예약통계 막대차트 그래프
				    </p>
				</figure>	    
 	       </div>
 	       <%-- 막대차트 끝 --%>
 	       
 	       
 	   </div>
    </div>
 </div>













 
    

