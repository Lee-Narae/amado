<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
   String ctxPath = request.getContextPath();
%>  
    
<style type="text/css">
.verticalLine {
border-left: solid 1px grey;
height: 350px;
margin: 1.5% 1.5%;
}

.sport_miniDiv {
width: 95%;
background-color: #DCDCDC;
border-radius: 10px;
height: 50px;
margin-top: 5.5%;
color: black;
display: flex;
justify-content: space-between;
}

.name {
margin: 11% 0 0 12%;
}

.cnt {
margin: 11% 12% 0 0;
color: blue;
font-weight: bold;
}

.cnt:hover {
cursor: pointer;
text-decoration: underline;
}

.memberCnt {
background-color: #BCDBFF;
align-content: center;
text-align: center;
width: 75%;
margin-bottom: 7%;
padding: 5%;
border-radius: 15px;
}

.memberNum {
font-size: 20pt;
text-align: center;
margin-bottom: 15%;
font-weight: bolder;
color: blue;
}

.bottomMem {
width: 40%;
height: 75px;
display: flex;
}

#gym {
width: 95%; height: 50px; text-align: left; align-content: center; padding-left: 5%;
}

#gym:hover {
text-decoration: underline;
color: #0066ff;
font-weight: bold;
cursor: pointer;
}

.title {
background-color: #71da71;
color: white;
display: inline-block;
width: 20%;
height: 40px;
text-align: center;
align-content: center;
border-radius: 20px;
margin-right: 2%;
}

.spanWrap {
padding: 1% 0;
}

/* highChart */
.highcharts-data-table table {
    min-width: 360px;
    max-width: 800px;
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


</style>    
    
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>    
    
<script type="text/javascript">
$(document).ready(function(){

	$("div#dashboard").addClass("hover");
	
});
</script>

<script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/highcharts.js"></script>
<script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/modules/exporting.js"></script>
<script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/modules/export-data.js"></script>
<script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/modules/accessibility.js"></script>


<div id="wrap" style="min-height: 810px; padding-top: 2%;">

<div id="chart" style="width: 100%; height: auto; align-content: center;" align="center">
	    <div id="highChart" style="width: 70%;"></div>
</div>

<script type="text/javascript">
$(document).ready(function(){
	
	$("div#dashboard").addClass("hover");
	
	// 하이차트
	
	let categories = new Array();
	let data = new Array();
	
	$.ajax({
		url: "<%=ctxPath%>/admin/getMemberStatic",
		dataType: "json",
		success: function(json){
			
			$.each(json, function(index, item){
				categories.push(item.date);
				data.push(Number(item.cnt));
			});
			
			Highcharts.chart('highChart', {
			    chart: {
			        type: 'line'
			    },
			    title: {
			        text: 'AmaDo 2주간 방문 통계'
			    },
			    xAxis: {
			        categories: categories
			    },
			    yAxis: {
			        title: {
			            text: '방문 수(명)'
			        }
			    },
			    plotOptions: {
			        line: {
			            dataLabels: {
			                enabled: true
			            },
			            enableMouseTracking: false
			        }
			    },
			    series: [{
			        name: '방문자 수',
			        data: data
			    }]
			});
			
			
			
			
			
		},
		error: function(request, status, error){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
	});
	
	


}); // document.ready
</script>


<div id="bottom" style="width: 100%; height: 400px; display: flex;">

	<div id="club" style="width: 30%; height: 400px; margin-left: 2%; padding: 2%;">
		<div style="margin-bottom: 3%; font-weight: bold; color: #6B6B6B;">동호회 통계</div>
		<div style="display: flex;">
			<div style="width: 40%; height: 300px;" align="center">
				<div style="margin: 5% 0 25% 0; font-size: 11pt; font-weight: bold;">전체 동호회 수</div>
				<div style="background-color: #247AFB; width: 95%; height: 160px; border-radius: 100%; color: white; font-size: 20pt; font-weight: bold; align-content: center; box-shadow: 0px 0px 10px #9ac5db;">${requestScope.clubCount} 개</div>
			</div>
			<div style="width: 60%;" align="center">
				<div style="margin: 4% 0 0 7%; font-size: 11pt; font-weight: bold;">종목별 동호회 수</div>
				<div style="margin-left: 5%; width: 100%; height: 260px; display: flex;">
					<div style="width: 50%; height: 260px;">
						<div class="sport_miniDiv"><span class="name">${requestScope.clubCountList[3].sportname}</span><span class="cnt" onclick="location.href='<%=ctxPath%>/club/findClub.do?sportseq=1'">${requestScope.clubCountList[3].cnt}개</span></div>
						<div class="sport_miniDiv"><span class="name">${requestScope.clubCountList[1].sportname}</span><span class="cnt" onclick="location.href='<%=ctxPath%>/club/findClub.do?sportseq=2'">${requestScope.clubCountList[1].cnt}개</span></div>
						<div class="sport_miniDiv"><span class="name">${requestScope.clubCountList[2].sportname}</span><span class="cnt" onclick="location.href='<%=ctxPath%>/club/findClub.do?sportseq=3'">${requestScope.clubCountList[2].cnt}개</span></div>
						<div class="sport_miniDiv"><span class="name">${requestScope.clubCountList[4].sportname}</span><span class="cnt" onclick="location.href='<%=ctxPath%>/club/findClub.do?sportseq=4'">${requestScope.clubCountList[4].cnt}개</span></div>
					</div>
					<div style="width: 50%; height: 260px;">
						<div class="sport_miniDiv"><span class="name">${requestScope.clubCountList[5].sportname}</span><span class="cnt" onclick="location.href='<%=ctxPath%>/club/findClub.do?sportseq=5'">${requestScope.clubCountList[5].cnt}개</span></div>
						<div class="sport_miniDiv"><span class="name">${requestScope.clubCountList[6].sportname}</span><span class="cnt" onclick="location.href='<%=ctxPath%>/club/findClub.do?sportseq=6'">${requestScope.clubCountList[6].cnt}개</span></div>
						<div class="sport_miniDiv"><span class="name">${requestScope.clubCountList[0].sportname}</span><span class="cnt" onclick="location.href='<%=ctxPath%>/club/findClub.do?sportseq=7'">${requestScope.clubCountList[0].cnt}개</span></div>
						<div class="sport_miniDiv"><span class="name">${requestScope.clubCountList[7].sportname}</span><span class="cnt" onclick="location.href='<%=ctxPath%>/club/findClub.do?sportseq=8'">${requestScope.clubCountList[7].cnt}개</span></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="verticalLine"></div>
	<div id="member" style="width: 30%; height: 400px; padding: 2%;">
		<div style="margin-bottom: 1%; font-weight: bold; color: #6B6B6B;">회원 통계</div>
		<div style="width: 100%; height: 230px; display: flex;">
			<div style="width: 60%; height: 230px;" align="center">
				<div class="memberCnt" style="margin-top: 10%;">전체 회원 수</div>
				<div class="memberCnt">최근 일주일 가입자 수</div>
				<div class="memberCnt">탈퇴 회원 수</div>
			</div>
			<div style="width: 40%; height: 230px;">
				<div class="memberNum" style="margin-top: 18%;">${requestScope.allMemberCount}</div>
				<div class="memberNum">${requestScope.weekMemberCount}</div>
				<div class="memberNum">${requestScope.status1MemberCount}</div>
			</div>
		</div>
		<hr style="border-width: medium; margin-top: 0; margin-bottom: 2%;">
		<div style="width: 100%; height: 75px; display: flex;">
			<div class="bottomMem" style="margin-left: 10.5%;">
				<div style="font-size: 15pt; margin: 10% 10% 0 10%;">일반회원</div>
				<div style="border-radius: 100%; background-color: #247AFB; width: 30%; height: 50px; color: white; font-weight: bold; margin-top: 5%; text-align: center; align-content: center; box-shadow: 0px 0px 10px #9ac5db;">${requestScope.rank0MemberCount}</div>
			</div>
			<div class="bottomMem">
				<div style="font-size: 15pt; margin: 10% 10% 0 10%;">관리자</div>
				<div style="border-radius: 100%; background-color: #247AFB; width: 30%; height: 50px; color: white; font-weight: bold; margin-top: 5%; text-align: center; align-content: center; box-shadow: 0px 0px 10px #9ac5db;">${requestScope.adminMemberCount}</div>
			</div>
		</div>
	</div>
	<div class="verticalLine"></div>
	<div id="alert" style="width: 30%; height: 400px; padding: 2%;">
		<div style="margin-bottom: 5%; font-weight: bold; color: #6B6B6B;">알림&nbsp;<span style="display: inline-block; width: 25px; text-align: center; height: 25px; align-content: center; border-radius: 100%; color: white; background-color: #ffcc66;">${requestScope.gymCount}</span></div>
		<div style="background-color: white; width: 100%; height: 300px; border-radius: 20px; padding-top: 3%; overflow: auto;" align="center">
			<c:forEach var="gym" items="${requestScope.gymList}" varStatus="status">
				<c:if test="${status.index != (requestScope.gymCount-1)}">
					<div id="gym" data-toggle="modal" data-target="#gymPermitModal">💌 ${gym.fk_userid}님의 체육관 등록 신청</div><input type="hidden" id="gymseq" value="${gym.gymseq}"/>
					<hr style="margin: 0.5%;">
				</c:if>
				<c:if test="${status.index == (requestScope.gymCount-1)}">
					<div id="gym" data-toggle="modal" data-target="#gymPermitModal">💌 ${gym.fk_userid}님의 체육관 등록 신청</div><input type="hidden" id="gymseq" value="${gym.gymseq}"/>
				</c:if>
			</c:forEach>
		</div>
	</div>
	
</div>


<!-- 모달 -->
<div class="modal modalclass" id="gymPermitModal" style="margin-top: 5%;">
  <div class="modal-dialog modal-lg modal-dialog-scrollable">
    <div class="modal-content">
      
      <!-- Modal header -->
      <div class="modal-header" style="width: 100%; align-content: center;">
      <h3 style="width: 100%; font-weight: bold; text-align: center; margin: 0;">체육관 승인 요청</h3>
      </div>
      
      <!-- Modal body -->
      <div class="modal-body" style="width: 80%; margin-left: 10%; border: solid 1px red;">
		  <h5 style="width: 100%; font-weight: bold; text-align: center; margin: 0;">체육관 정보</h5>
		  <div align="left">
			  <div class="spanWrap">
			  	<span class="title">등록자 ID</span>
			  	<span class="gymContent" id="regId">이나래</span>
			  </div>
			  <div class="spanWrap">
			  	<span class="title">체육관 명</span>
			  	<span class="gymContent" id="regName">부산체육관</span>
			  </div>
			  <div class="spanWrap">
			  	<span class="title">주소</span>
			  	<span class="gymContent" id="regAddress">이나래</span>
			  </div>
			  <div class="spanWrap">
			  	<span class="title">공간정보</span>
			  	<span class="gymContent" id="regInfo">이나래</span>
			  </div>
			  <div class="spanWrap">
			  	<span class="title">대관 비용</span>
			  	<span class="gymContent" id="regCost">이나래</span>
			  </div>
			  <div class="spanWrap">
			  	<span class="title">수용 인원</span>
			  	<span class="gymContent" id="regMC">이나래</span>
			  </div>
			  <div class="spanWrap">
			  	<span class="title">대표 이미지</span>
			  	<span class="gymContent" id="regImg">이나래</span>
			  </div>
		  </div>
      </div>
      
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary" onclick="goPermit()">승인하기</button>
      </div>
    </div>
  </div>
</div>

</div>