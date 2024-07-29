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
		
		let is_no_data = false;
		
		$.ajax({
			url:"<%= ctxPath%>/admin/manage/gym.do",
    		async:false, 
    		dataType:"json",
    		success:function(json){
    			
    			if(json.length == 0){
    				is_no_data = true;
    			}
    			
    			else { // 오라클 테이블에 데이터가 입력이 되어진 경우 
    			
    				// console.log(JSON.stringify(json));
    				// [{"CNT":"245","PERCNTAGE":"   7.6","GU":"송파구"},{"CNT":"223","PERCNTAGE":"   6.9","GU":"강서구"},{"CNT":"195","PERCNTAGE":"   6.0","GU":"강남구"},{"CNT":"186","PERCNTAGE":"   5.7","GU":"영등포구"},{"CNT":"175","PERCNTAGE":"   5.4","GU":"노원구"},{"CNT":"162","PERCNTAGE":"   5.0","GU":"서초구"},{"CNT":"142","PERCNTAGE":"   4.4","GU":"마포구"},{"CNT":"134","PERCNTAGE":"   4.1","GU":"구로구"},{"CNT":"132","PERCNTAGE":"   4.1","GU":"강동구"},{"CNT":"131","PERCNTAGE":"   4.0","GU":"양천구"},{"CNT":"124","PERCNTAGE":"   3.8","GU":"종로구"},{"CNT":"115","PERCNTAGE":"   3.5","GU":"성동구"},{"CNT":"112","PERCNTAGE":"   3.5","GU":"중구"},{"CNT":"110","PERCNTAGE":"   3.4","GU":"은평구"},{"CNT":"106","PERCNTAGE":"   3.3","GU":"성북구"},{"CNT":"104","PERCNTAGE":"   3.2","GU":"중랑구"},{"CNT":"103","PERCNTAGE":"   3.2","GU":"도봉구"},{"CNT":"103","PERCNTAGE":"   3.2","GU":"관악구"},{"CNT":"102","PERCNTAGE":"   3.1","GU":"용산구"},{"CNT":"102","PERCNTAGE":"   3.1","GU":"광진구"},{"CNT":"101","PERCNTAGE":"   3.1","GU":"동대문구"},{"CNT":"94","PERCNTAGE":"   2.9","GU":"서대문구"},{"CNT":"88","PERCNTAGE":"   2.7","GU":"동작구"},{"CNT":"81","PERCNTAGE":"   2.5","GU":"금천구"},{"CNT":"70","PERCNTAGE":"   2.2","GU":"강북구"}] 
    				
    				const pie_data_arr = [];
    				const bar_data_arr = [];
    				
    				
				     $.each(json, function(index, item){
				    	 v_html += `<tr>
				    	              <td>\${item.gymname}</td>
				    	              <td align='right'>\${item.reservation_count}</td>
				    	              <td align='right'>\${item.time}</td>
				    	           </tr>`;
				    	 
				    	  ///////////////////////////////////         
				    	 
				    	 
				    	  const bar_data = [];
				    	  bar_data.push(item.gymname);
				    	  bar_data.push("<span class='gu' style='font-weight:bold; cursor:pointer;'>"+item.gymname+"</span>");
				    	  bar_data.push(Number(item.reservation_count));
				    	 
				    	  bar_data_arr.push(bar_data);
				    	  
				     });// end of $.each(json, function(index, item){})------------   
				     
				     
				     ///////////////////////////////////////////////////
				     <%-- ==== 막대차트 시작 ==== --%>
				     Highcharts.chart('bar_chart_container', {
				    	    chart: {
				    	        type: 'column'
				    	    },
				    	    title: {
				    	        text: '체육관 시간대별 예약통계 막대차트 그래프(시간을 클릭해보세요: 주소나오기)'
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
				    	      // pointFormat: 'Population in 2021: <b>{point.y:.1f} millions</b>' 
				    	         pointFormat: '2024년 예약수: <b>{point.y} 개</b>'
				    	    },
				    	    series: [{
				    	        name: 'Population',
				    	        data: bar_data_arr,  // <=== 만들어야 하는 것 
				    	        dataLabels: {
				    	            enabled: true,
				    	            rotation: -90,
				    	            color: '#FFFFFF',
				    	            align: 'right',
				    	         // format: '{point.y:.1f}', // one decimal
				    	            y: 10, // 10 pixels down from the top
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
				     $(document).on("click", "tspan.gymname", function(e){
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
		
		
	});// end of $(document).ready(function(){})--------

</script>

<div style="width: 90%; margin: 0 auto; padding: 1% 0;">
    <div class="row">
    	<div class="col-md-6 offset-md-3">
    	  <p class="text-center h3 text-success pb-3">종목별 인기 체육관 현황</p>
    	</div>
    </div>
    <div class="row">
 	   <div class="col-md-3" id="tbl"></div>
 	   <div class="col-md-9">
 	       <%-- 파이차트 시작 --%>
 	       <div class="border">
				 <figure class="highcharts-figure">
				    <div id="pie_chart_container"></div>
				    <p class="text-center">
				        종목별 인기 체육관 현황 파이차트 그래프xxxxx
				    </p>
				</figure>
 	       </div>
 	       <%-- 파이차트 끝 --%>
 	       
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













 
    

