<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<style type="text/css">
.highcharts-figure,
.highcharts-data-table table {
    min-width: 310px;
    max-width: 800px;
    margin: 1em auto;
}

#container {
    height: 400px;
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

</style>



<script src="<%=ctxPath%>/resources/Highcharts-10.3.1/code/highcharts.js"></script>
<script src="<%=ctxPath%>/resources/Highcharts-10.3.1/code/modules/data.js"></script>
<script src="<%=ctxPath%>/resources/Highcharts-10.3.1/code/modules/drilldown.js"></script>
<script src="<%=ctxPath%>/resources/Highcharts-10.3.1/code/modules/exporting.js"></script>
<script src="<%=ctxPath%>/resources/Highcharts-10.3.1/code/modules/export-data.js"></script>
<script src="<%=ctxPath%>/resources/Highcharts-10.3.1/code/modules/accessibility.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	let cityFacList = [];
	
	$.ajax({
		url: "<%=ctxPath%>/community/searchFacByLocal.do",
		dataType: "json",
		success: function(json){
			console.log(JSON.stringify(json));
			// [{"city":"경기도","cnt":"1","local":"가평군"}, {"city":"경기도","cnt":"1","local":"가평군"}, ...]
			
			$.each(json, function(index, item){
				let cityObj = {};
				cityObj.name = item.city;
				
				
				
			});
			
		},
		error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}
	});
	
	
	Highcharts.chart('container', {
	 chart: {
	     type: 'column'
	 },
	 title: {
	     align: 'left',
	     text: '지역별 전국 체육시설 분포 현황'
	 },
	 subtitle: {
	     align: 'left',
	     text: '출처: <a href="https://www.data.go.kr/tcs/dss/selectApiDataDetailView.do?publicDataPk=15113986" target="_blank">공공데이터포털 data.go.kr</a>'
	 },
	 accessibility: {
	     announceNewData: {
	         enabled: true
	     }
	 },
	 xAxis: {
	     type: 'category'
	 },
	 yAxis: {
	     title: {
	         text: 'Total percent market share'
	     }
	
	 },
	 legend: {
	     enabled: false
	 },
	 plotOptions: {
	     series: {
	         borderWidth: 0,
	         dataLabels: {
	             enabled: true,
	             format: '{point.y:.1f}%'
	         }
	     }
	 },
	
	 tooltip: {
	     headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
	     pointFormat: '<span style="color:{point.color}">{point.name}</span>: ' +
	         '<b>{point.y:.2f}%</b> of total<br/>'
	 },
	
	 series: [
	     {
	         name: '시/도',
	         colorByPoint: true,
	         data: [
	             {
	                 name: 'chrome',
	                 y: 63.06,
	                 drilldown: '크롬'
	             },
	             {
	                 name: 'Safari',
	                 y: 19.84,
	                 drilldown: 'Safari'
	             },
	             {
	                 name: 'Firefox',
	                 y: 4.18,
	                 drilldown: 'Firefox'
	             },
	             {
	                 name: 'Edge',
	                 y: 4.12,
	                 drilldown: 'Edge'
	             },
	             {
	                 name: 'Opera',
	                 y: 2.33,
	                 drilldown: 'Opera'
	             },
	             {
	                 name: 'Internet Explorer',
	                 y: 0.45,
	                 drilldown: 'Internet Explorer'
	             },
	             {
	                 name: 'Other',
	                 y: 1.582,
	                 drilldown: null
	             }
	         ]
	     }
	 ],
	 drilldown: {
	     breadcrumbs: {
	         position: {
	             align: 'right'
	         }
	     },
	     series: [
	         {
	             name: 'Chrome',
	             id: '크롬',
	             data: [
	                 [
	                     'v65.0',
	                     0.1
	                 ],
	                 [
	                     'v64.0',
	                     1.3
	                 ],
	                 [
	                     'v63.0',
	                     53.02
	                 ],
	                 [
	                     'v62.0',
	                     1.4
	                 ],
	                 [
	                     'v61.0',
	                     0.88
	                 ],
	                 [
	                     'v60.0',
	                     0.56
	                 ],
	                 [
	                     'v59.0',
	                     0.45
	                 ],
	                 [
	                     'v58.0',
	                     0.49
	                 ],
	                 [
	                     'v57.0',
	                     0.32
	                 ],
	                 [
	                     'v56.0',
	                     0.29
	                 ],
	                 [
	                     'v55.0',
	                     0.79
	                 ],
	                 [
	                     'v54.0',
	                     0.18
	                 ],
	                 [
	                     'v51.0',
	                     0.13
	                 ],
	                 [
	                     'v49.0',
	                     2.16
	                 ],
	                 [
	                     'v48.0',
	                     0.13
	                 ],
	                 [
	                     'v47.0',
	                     0.11
	                 ],
	                 [
	                     'v43.0',
	                     0.17
	                 ],
	                 [
	                     'v29.0',
	                     0.26
	                 ]
	             ]
	         },
	         {
	             name: 'Firefox',
	             id: 'Firefox',
	             data: [
	                 [
	                     'v58.0',
	                     1.02
	                 ],
	                 [
	                     'v57.0',
	                     7.36
	                 ],
	                 [
	                     'v56.0',
	                     0.35
	                 ],
	                 [
	                     'v55.0',
	                     0.11
	                 ],
	                 [
	                     'v54.0',
	                     0.1
	                 ],
	                 [
	                     'v52.0',
	                     0.95
	                 ],
	                 [
	                     'v51.0',
	                     0.15
	                 ],
	                 [
	                     'v50.0',
	                     0.1
	                 ],
	                 [
	                     'v48.0',
	                     0.31
	                 ],
	                 [
	                     'v47.0',
	                     0.12
	                 ]
	             ]
	         },
	         {
	             name: 'Internet Explorer',
	             id: 'Internet Explorer',
	             data: [
	                 [
	                     'v11.0',
	                     6.2
	                 ],
	                 [
	                     'v10.0',
	                     0.29
	                 ],
	                 [
	                     'v9.0',
	                     0.27
	                 ],
	                 [
	                     'v8.0',
	                     0.47
	                 ]
	             ]
	         },
	         {
	             name: 'Safari',
	             id: 'Safari',
	             data: [
	                 [
	                     'v11.0',
	                     3.39
	                 ],
	                 [
	                     'v10.1',
	                     0.96
	                 ],
	                 [
	                     'v10.0',
	                     0.36
	                 ],
	                 [
	                     'v9.1',
	                     0.54
	                 ],
	                 [
	                     'v9.0',
	                     0.13
	                 ],
	                 [
	                     'v5.1',
	                     0.2
	                 ]
	             ]
	         },
	         {
	             name: 'Edge',
	             id: 'Edge',
	             data: [
	                 [
	                     'v16',
	                     2.6
	                 ],
	                 [
	                     'v15',
	                     0.92
	                 ],
	                 [
	                     'v14',
	                     0.4
	                 ],
	                 [
	                     'v13',
	                     0.1
	                 ]
	             ]
	         },
	         {
	             name: 'Opera',
	             id: 'Opera',
	             data: [
	                 [
	                     'v50.0',
	                     0.96
	                 ],
	                 [
	                     'v49.0',
	                     0.82
	                 ],
	                 [
	                     'v12.1',
	                     0.14
	                 ]
	             ]
	         }
	     ]
	 }
	});
});
</script>


<div style="width: 100%; padding-top: 5%;" align="center">

<div style="font-size: 30pt; font-weight: bold;">전국체육시설 정보</div>
<hr style="border: solid 2px black; width:80%; border-style: groove;">

<div id="selectDiv">
	<select id="select">
		<option value="type">지역별</option>
		<option value="city">업종별</option>
	</select>
</div>

<div id="chartDiv" style="border: solid 1px red; width: 80%; margin-top: 1.5%;">

<figure class="highcharts-figure">
    <div id="container"></div>
</figure>


</div>
</div>