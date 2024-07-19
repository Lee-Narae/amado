<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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

#searchType {
height: 35px;
width: 10%;
border-radius: 10px;
text-align: center;
}

#sizePerPage {
height: 35px;
width: 5%;
border-radius: 10px;
text-align: center;
}

#searchWord {
height: 35px;
border-radius: 10px;
border: solid 1px gray;
padding-left: 1%;
}

table#memberTbl th {
text-align: center;
font-size: 14pt;
}

table#memberTbl tr.memberInfo:hover {
background-color: #e6ffe6;
cursor: pointer;
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
	
	$("input:text[name='searchWord']").bind("keyup", function(e){
        if(e.keyCode == 13){
        	goSearch();
        }
    });
	
	if("${requestScope.searchWord}" != "" && "${requestScope.searchType}" != ""){
		$("input:text[name='searchWord']").val("${requestScope.searchWord}");
		$("select[name='searchType']").val("${requestScope.searchType}");
	}
	
	let cityFacList = [];
	
	// ------------------------ 지역별 구별 통계차트 ------------------------- //
	
	// 1. 지역별 통계 가져오기
	$.ajax({
		url: "<%=ctxPath%>/community/searchFacByCity.do",
		dataType: "json",
		success: function(json){
			// [{"city":"경기도","cnt":"322"},{"city":"경상남도","cnt":"58"}, ...]
			
			let city_arr = [];
			
			$.each(json, function(index, item){
				city_arr.push({name: item.city,
			                   y: Number(item.cnt),
			                   drilldown: item.city});
			});
			
			let local_arr = [];
			
			$.each(json, function(index, item){
				
				// 2. 구별 통계 가져오기
				$.ajax({
					url: "<%=ctxPath%>/community/searchFacByLocal.do",
					data: {"city": item.city},
					dataType: "json",
					success: function(json2){
						// {"cnt":"3","local":"경산시"}
						
						let subArr = [];
	    				
	    				$.each(json2, function(index2, item2){
	    					subArr.push([item2.local, Number(item2.cnt)]);
	    				});
	    				
	    				local_arr.push({name: item.city, id: item.city, data: subArr});
						
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
				});
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
				         text: '시설 수(개)'
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
				             format: '{point.y:f}개'
				         }
				     }
				 },
				
				 tooltip: {
				     headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
				     pointFormat: '<span style="color:{point.color}">{point.name}</span>: ' +
				         '<b>{point.y:f}개</b> of total<br/>'
				 },
				
				 series: [
				     {
				         name: '시/도',
				         colorByPoint: true,
				         data: city_arr
				     }
				 ],
				 drilldown: {
				     breadcrumbs: {
				         position: {
				             align: 'right'
				         }
				     },
				     series: local_arr
				 }
				});
			
			
			
		},
		error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}
	});
	
	
	
});

function goSearch() {
	if($("input:text[name='searchWord']").val() == ""){
		alert("검색어를 입력하세요.");
		return;
	}
	
	if($("select[name='searchType']").val() == ""){ // select태그의 option 중 value 값을 넣어야 한다.
		alert("검색 대상을 선택하세요.");
		return;
	}
	
	const frm = document.fac_search_frm;
	frm.submit();
	
}
</script>


<div style="width: 100%; padding: 5% 0;" align="center">

<div style="font-size: 30pt; font-weight: bold;">전국체육시설 정보</div>
<hr style="border: solid 2px black; width:80%; border-style: groove;">

<div id="chartDiv" style="width: 80%; margin-top: 1.5%;">
	<figure class="highcharts-figure">
	    <div id="container"></div>
	</figure>
</div>

<div id="tableDiv">
<div id="memberTable" class="mt-5" style="width: 80%;">

	
	<table class="table table-bordered" id="memberTbl" style="text-align: center;">
      <thead>
          <tr style="background-color: #ccf3ff;">
             <th width="10%">번호</th>
             <th width="10%">지역</th>
             <th width="15%">업종</th>
             <th width="20%">시설명</th>
             <th width="35%">주소</th>
             <th width="10%">운영여부</th>
          </tr>
      </thead>
      
      <tbody>
          <c:if test="${not empty requestScope.facList}">
          	<c:forEach var="fac" items="${requestScope.facList}" varStatus="status">
          		<tr style="font-size: 11pt;">
          			<fmt:parseNumber var="currentShowPageNo" value="${requestScope.currentShowPageNo}" />
       				<td>${requestScope.totalMemberCount - (currentShowPageNo-1)*10 - status.index}</td>
          			<td>${fac.city}</td>
          			<td>${fac.type}</td>
          			<td>${fac.name}</td>
          			<td>${fac.newadd}</td>
          			<td>${fac.status}</td>
          		</tr>
          	</c:forEach>
          
          </c:if>
          
          <c:if test="${empty requestScope.facList}">
          	<td colspan="6">데이터가 존재하지 않습니다.</td>
          </c:if>
      </tbody>
    </table>
    
   	<div class="mt-5 mb-5">
		<form name="fac_search_frm">
		     <select name="searchType" id="searchType">
		        <option value="">검색대상</option>
		        <option value="name">시설명</option>
		        <option value="type">업종</option>
		        <option value="newadd">주소</option>
		     </select>
		     &nbsp;
		     <input type="text" name="searchWord" id="searchWord" />
		     <input type="text" style="display: none;" /> 
		    
		    <span onclick="goSearch()" style="cursor: pointer;">🔎</span>
		 </form>
	</div>
    

	<div id="pageBar" align="center" style="margin-left: 30%;">
       <nav>
          <ul class="pagination">${requestScope.pageBar}</ul>
       </nav>
    </div>
</div>
</div>

</div>