<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<link rel="stylesheet" href="<%=ctxPath%>/resources/bootstrap-4.6.2-dist/css/bootstrap.min.css" type="text/css">
<style type="text/css">

.title {
display: inline-block;
background-color: #b3daff;
border-radius: 50px;
width: 25%;
height: 30px;
font-weight: bold;
text-align: center;
padding-top: 0.5%;
margin-left: 3%;
margin-right: 3%;
color: #1a263d;
}

#more:hover {
cursor: pointer;
text-decoration: underline;
}

#bossname:hover {
cursor: pointer;
font-weight: bold;
}

#forhover {
display: inline-block;
width: 25%;
background-color: #c6f0a3;
border-radius: 10px;
font-size: 10pt;
text-align: center;
margin-left: 2%;
}

table{
  width:100%;
  table-layout: fixed;
}
.tbl-header{
  background-color: rgba(255,255,255,0.3);
  font-weight: bold;
 }
.tbl-content{
  background-color: white;
  overflow-x:auto;
  margin-top: 0px;
  border: 1px solid rgba(255,255,255,0.3);
}
th{
  padding: 20px 15px !important;
  text-align: center;
  font-weight: 500;
  font-size: 13px;
  text-transform: uppercase;
}
td{
  padding: 15px;
  text-align: center;
  vertical-align:middle;
  font-weight: 300;
  font-size: 13px;
  border-bottom: solid 1px rgba(255,255,255,0.1);
}

#help {
font-size: 18pt;
}

#forhover2 {
display: inline-block;
background-color: #c6f0a3;
border-radius: 10px;
font-size: 10pt;
text-align: center;
margin-left: 2%;
}

.uniform-size {
    width: 90px;
    height: 100px;
    object-fit: cover; /* 이미지 비율을 유지하면서 크기를 맞춤 */
}
.uniform-size1{
	width: 280px;
    height: 300px;
    object-fit: cover; /* 이미지 비율을 유지하면서 크기를 맞춤 */
}
.highcharts-figure,
.highcharts-data-table table {
    min-width: 320px;
    max-width: 700px;
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

<div id="container">
<div  style="background-color: #4040bf">
<div class="board_header"  style="display: flex; margin-left: 15.5%; color: white; padding: 3%;">
    <div class="tit">
        <h1>${requestScope.clubvo.clubname}</h1>
        <div class="desc">${requestScope.clubvo.fk_userid}가 속한 동호회 입니다.</div>
    </div>
    

    <div class="coach_area" >
        <div class="wrap">
            <div class="coach_info" style="display: flex; margin-left: 220%;">
            	<div style="display: inline;">
	                <div class="name">
		                <div style="font-size: 12pt; width: 230%;">
		                	동호회장
		                </div>
		                <div>
		                    
		                        <span class="coach" style="font-size: 15pt;">${requestScope.clubvo.fk_userid}</span>
		                        <span class="ico ico_profile_link"></span>
		                    
		                </div>
	                </div>
	                <div class="info" style="margin-top: 15%;">
	                    <div class="visit" style="width: 230%;">
	                        <span class="txt">방문자 수</span>
	                        <span class="num" style="font-weight: bold;">${requestScope.clubvo.viewcount}</span>
	                    </div>
	                </div>
                </div>
                <div class="rank">
                    <div class="img">
                    	<c:if test="${requestScope.clubvo.clubscore < 100}">
                    		<img style="margin-left: 70%; margin-top: 15%;" src="<%=ctxPath%>/resources/images/rank17.png" />
                    	</c:if>
                    	<c:if test="${requestScope.clubvo.clubscore >= 100 && requestScope.clubvo.clubscore < 200}">
                    		<img style="margin-left: 70%; margin-top: 15%;" src="<%=ctxPath%>/resources/images/rank16.png" />
                    	</c:if>
                    	<c:if test="${requestScope.clubvo.clubscore >= 200 && requestScope.clubvo.clubscore < 300}">
                    		<img style="margin-left: 70%; margin-top: 15%;" src="<%=ctxPath%>/resources/images/rank15.png" />
                    	</c:if>
                    	<c:if test="${requestScope.clubvo.clubscore >= 300 && requestScope.clubvo.clubscore < 400}">
                    		<img style="margin-left: 70%; margin-top: 15%;" src="<%=ctxPath%>/resources/images/rank14.png" />
                    	</c:if>
                    	<c:if test="${requestScope.clubvo.clubscore >= 400 && requestScope.clubvo.clubscore < 500}">
                    		<img style="margin-left: 70%; margin-top: 15%;" src="<%=ctxPath%>/resources/images/rank13.png" />
                    	</c:if>
                    	<c:if test="${requestScope.clubvo.clubscore >= 500 && requestScope.clubvo.clubscore < 600}">
                    		<img style="margin-left: 70%; margin-top: 15%;" src="<%=ctxPath%>/resources/images/rank12.png" />
                    	</c:if>
                    	<c:if test="${requestScope.clubvo.clubscore >= 600 && requestScope.clubvo.clubscore < 700}">
                    		<img style="margin-left: 70%; margin-top: 15%;" src="<%=ctxPath%>/resources/images/rank11.png" />
                    	</c:if>
                    	<c:if test="${requestScope.clubvo.clubscore >= 700 && requestScope.clubvo.clubscore < 800}">
                    		<img style="margin-left: 70%; margin-top: 15%;" src="<%=ctxPath%>/resources/images/rank10.png" />
                    	</c:if>
                    	<c:if test="${requestScope.clubvo.clubscore >= 800 && requestScope.clubvo.clubscore < 900}">
                    		<img style="margin-left: 70%; margin-top: 15%;" src="<%=ctxPath%>/resources/images/rank9.png" />
                    	</c:if>
                    	<c:if test="${requestScope.clubvo.clubscore >= 900 && requestScope.clubvo.clubscore < 1000}">
                    		<img style="margin-left: 70%; margin-top: 15%;" src="<%=ctxPath%>/resources/images/rank8.png" />
                    	</c:if>
                    	<c:if test="${requestScope.clubvo.clubscore >= 1000 && requestScope.clubvo.clubscore < 1100}">
                    		<img style="margin-left: 70%; margin-top: 15%;" src="<%=ctxPath%>/resources/images/rank7.png" />
                    	</c:if>
                    	<c:if test="${requestScope.clubvo.clubscore >= 1100 && requestScope.clubvo.clubscore < 1200}">
                    		<img style="margin-left: 70%; margin-top: 15%;" src="<%=ctxPath%>/resources/images/rank6.png" />
                    	</c:if>
                    	<c:if test="${requestScope.clubvo.clubscore >= 1200 && requestScope.clubvo.clubscore < 1300}">
                    		<img style="margin-left: 70%; margin-top: 15%;" src="<%=ctxPath%>/resources/images/rank5.png" />
                    	</c:if>
                    	<c:if test="${requestScope.clubvo.clubscore >= 1300 && requestScope.clubvo.clubscore < 1400}">
                    		<img style="margin-left: 70%; margin-top: 15%;" src="<%=ctxPath%>/resources/images/rank4.png" />
                    	</c:if>
                    	<c:if test="${requestScope.clubvo.clubscore >= 1400 && requestScope.clubvo.clubscore < 1500}">
                    		<img style="margin-left: 70%; margin-top: 15%;" src="<%=ctxPath%>/resources/images/rank3.png" />
                    	</c:if>
                    	<c:if test="${requestScope.clubvo.clubscore >= 1500 && requestScope.clubvo.clubscore < 1600}">
                    		<img style="margin-left: 70%; margin-top: 15%;" src="<%=ctxPath%>/resources/images/rank2.png" />
                    	</c:if>
                    	<c:if test="${requestScope.clubvo.clubscore >= 1600 && requestScope.clubvo.clubscore < 1700}">
                    		<img style="margin-left: 70%; margin-top: 15%;" src="<%=ctxPath%>/resources/images/rank1.png" />
                    	</c:if>
                    	<c:if test="${requestScope.clubvo.clubscore > 1700}">
                    		<img style="margin-left: 70%; margin-top: 15%;" src="<%=ctxPath%>/resources/images/rank0.png" />
                    	</c:if>
                    </div>
                </div>
                <div class="crest">
                    <div class="img">
                        <img class='uniform-size' style="margin-left: 102%;" src="<%=ctxPath%>/resources/images/uploadImg/${requestScope.clubvo.wasfileName}">
                    </div>
                </div>
            </div>


        </div>
    </div>
</div>
</div>
	<div id="top2" style="display: flex; height: 500px; margin-top: 5%;">
		<!-- 동호회 여러개 가입시 캐러셀 적용 -->
		<div id="myclub" style="width: 38%; margin: 5% 0 0 5%;">
			<div style="text-align: center;">
				<img class='uniform-size1' src="<%=ctxPath%>/resources/images/uploadImg/${requestScope.clubvo.wasfileName}">
			</div>
			<div style="text-align: center; margin-top: 5%; font-size: 25px; font-weight: bold;">${requestScope.clubvo.clubname}</div>
		</div>
		
		
		<div id="clubmatch" style="width: 43%; margin: 2% 0 0 0; border-radius: 20px; box-shadow: 0px 11px 22px #9e9e9e6b;">
			<div id="clubTitle" style="text-align: center; margin: 3% 0 3% 0; font-size: 30pt; font-weight: bolder;">${requestScope.clubvo.clubname} 스탯</div>
			<div style="width: 100%; display: flex; margin-left: 13%;" >
				<div>
					<figure class="highcharts-figure">
					    <div id="stat" style="width: 75%; height: 257px;"></div>
					    <p class="highcharts-description">
					    </p>
					</figure>
				</div>
				
				<%-- 클럽 전화번호를 변수에 할당 --%>
				<c:set var="clubTel" value="${requestScope.clubvo.clubtel}" />
				
				<%-- 전화번호를 010-1234-1234 형식으로 포맷 --%>
				<c:set var="formattedTel" value="${clubTel.substring(0, 3)}-${clubTel.substring(3, 7)}-${clubTel.substring(7)}" />
				
				
				<ul style="list-style: none; width: 50%; margin: 4% 10% 0 0; font-family: 'Roboto', sans-serif;">
					<li><span style="font-weight: bolder;">대표 연락처:  </span>${formattedTel}</li>
					<li style="margin-top: 4%;"><span style="font-weight: bolder;">지역:  </span>${requestScope.clubvo.city} ${requestScope.clubvo.local}</li>
					<li style="margin-top: 4%;"><span style="font-weight: bolder;">활동구장:  </span>${requestScope.clubvo.clubgym}</li>
					<li style="margin-top: 4%;"><span style="font-weight: bolder;">운영시간:  </span>${requestScope.clubvo.clubtime}</li>
					<li style="margin-top: 4%;"><span style="font-weight: bolder;">정원:  </span>${requestScope.clubvo.membercount}</li>
					<li style="margin-top: 4%;"><span style="font-weight: bolder;">회비:  </span><fmt:formatNumber value="${requestScope.clubvo.clubpay}" type="number" pattern="#,###" />원</li>
					<li style="margin-top: 4%;"><span style="font-weight: bolder;">랭크 점수:  </span>${requestScope.clubvo.clubscore}</li>
				</ul>
			</div>
		</div>
	</div>



<div id="clubTitle" style="text-align: center; margin: 8% 0 0 0; font-size: 30pt; font-weight: bolder;">최근 전적</div>
	<div id="clubboard" style="width: 88%; padding: 4% 3% 5% 3%; margin: 2% auto 5% auto; border-radius: 20px; box-shadow: 0px 11px 22px #9e9e9e6b;">
		
		<div style="display: flex;">
		
			<div style="display: flex; margin-left: 3%; width: 56%;">
				<div>
					<img class='uniform-size' style="margin-left: 90%;" src="<%=ctxPath%>/resources/images/uploadImg/${requestScope.clubvo.wasfileName}">
				</div>
				<div style="font-family: 'Roboto', sans-serif; font-weight: bold; font-size: 45px; margin-top: 2%; margin-left:15%; color: #2929a3;">${requestScope.clubvo.clubname}</div>
			</div>
			
			<div style="display: inline; margin-top: 0%; margin-left: 16%;">
				<div style="margin: 1% 0 5% 7%; font-size: 17pt; font-weight: bold; width: 100%;">최근 5게임 전적</div>
				<div style="display: flex; color: white; margin-left: 5%;">
					<c:set var="count" value="0" />
						<c:forEach var='matchingvo' items="${requestScope.matchingList}">
						    <c:if test="${count < 5}">
					            <c:if test="${requestScope.clubvo.clubseq == matchingvo.clubseq1 && matchingvo.result1 == 1}">
					                <div style="border: solid 1px #4d4dff; padding: 4% 8%; background-color: #4d4dff;">승</div>
					            </c:if>
					            <c:if test="${requestScope.clubvo.clubseq == matchingvo.clubseq1 && matchingvo.result1 == 2}">
					                <div style="border: solid 1px #ff3333; padding: 4% 8%; background-color: #ff3333;">패</div>
					            </c:if>
					            <c:if test="${requestScope.clubvo.clubseq == matchingvo.clubseq1 && matchingvo.result1 == 3}">
					                <div style="border: solid 1px #999999; padding: 4% 8%; background-color: #999999;">무</div>
					            </c:if>
					            <c:if test="${requestScope.clubvo.clubseq == matchingvo.clubseq2 && matchingvo.result2 == 1}">
					                <div style="border: solid 1px #4d4dff; padding: 4% 8%; background-color: #4d4dff;">승</div>
					            </c:if>
					            <c:if test="${requestScope.clubvo.clubseq == matchingvo.clubseq2 && matchingvo.result2 == 2}">
					                <div style="border: solid 1px #ff3333; padding: 4% 8%; background-color: #ff3333;">패</div>
					            </c:if>
					            <c:if test="${requestScope.clubvo.clubseq == matchingvo.clubseq2 && matchingvo.result2 == 3}">
					                <div style="border: solid 1px #999999; padding: 4% 8%; background-color: #999999;">무</div>
					            </c:if>
					        	<c:set var="count" value="${count + 1}" />
					    	</c:if>
						</c:forEach>
				</div>
			</div>
		
		</div>
		<div id="table" style="width: 90%; margin-left: 5%; margin-top: 3.5%;">
			
			<div class="tbl-header">
			  <table cellpadding="0" cellspacing="0" border="0">
			    <thead>
			      <tr style="border-bottom: solid 3px #1264b970;">
			        <th style="width: 9%;">경기날짜</th>
					<th style="width: 13%;">상대팀</th>
					<th style="width: 17%;">경기장</th>
					<th style="width: 24%;">스코어</th>
					<th style="width: 6%;">경기결과 </th>
			      </tr>
			    </thead>
			  </table>
			</div>
			
			<div class="tbl-content">
			  <table cellpadding="0" cellspacing="0" border="0">
			    <tbody>
			    	<c:set var="count" value="0" />
						<c:forEach var='matchingvo' items="${requestScope.matchingList}">
						    <c:if test="${count < 5}">
						        <tr>
						            <td style="width: 11%;">${matchingvo.matchdate}</td>
						            <c:if test="${requestScope.clubvo.clubseq == matchingvo.clubseq2}">
						                <td style="width: 20%;"><a style="text-decoration: none; color: black;" href="<%=ctxPath%>/club/myClub_plus.do?clubseq=${matchingvo.clubseq1}">${matchingvo.clubname1}</a></td>
						            </c:if>
						            <c:if test="${requestScope.clubvo.clubseq == matchingvo.clubseq1}">
						                <td style="width: 20%;"><a style="text-decoration: none; color: black;" href="<%=ctxPath%>/club/myClub_plus.do?clubseq=${matchingvo.clubseq2}">${matchingvo.clubname2}</a></td>
						            </c:if>
						            <td style="width: 20%;">${matchingvo.area}</td>
						            <td style="width: 35%;">${matchingvo.clubname1} ${matchingvo.score1}:${matchingvo.score2} ${matchingvo.clubname2}</td>
						            <c:if test="${requestScope.clubvo.clubseq == matchingvo.clubseq1 && matchingvo.result1 == 1}">
						                <td style="width: 7%;">승</td>
						            </c:if>
						            <c:if test="${requestScope.clubvo.clubseq == matchingvo.clubseq1 && matchingvo.result1 == 2}">
						                <td style="width: 7%;">패</td>
						            </c:if>
						            <c:if test="${requestScope.clubvo.clubseq == matchingvo.clubseq1 && matchingvo.result1 == 3}">
						                <td style="width: 7%;">무</td>
						            </c:if>
						            <c:if test="${requestScope.clubvo.clubseq == matchingvo.clubseq2 && matchingvo.result1 == 2}">
						                <td style="width: 7%;">승</td>
						            </c:if>
						            <c:if test="${requestScope.clubvo.clubseq == matchingvo.clubseq2 && matchingvo.result1 == 1}">
						                <td style="width: 7%;">패</td>
						            </c:if>
						            <c:if test="${requestScope.clubvo.clubseq == matchingvo.clubseq2 && matchingvo.result2 == 3}">
						                <td style="width: 7%;">무</td>
						            </c:if>
						        </tr>
						        <c:set var="count" value="${count + 1}" />
						    </c:if>
						</c:forEach>
			    </tbody>
			  </table>
			</div>
		</div>
	</div>
	



	<div id="clubTitle" style="text-align: center; margin: 8% 0 0 0; font-size: 30pt; font-weight: bolder;">팀 커뮤니티 최신글</div>
	<div id="clubboard" style="width: 88%; padding: 4% 3% 2% 3%; margin: 2% auto 5% auto; border-radius: 20px; box-shadow: 0px 11px 22px #9e9e9e6b;">
		<div style="margin: 1% 0 1% 5%; font-size: 10pt;">※ 팀 커뮤니티 최신글은 최근 일주일간 작성된 팀 커뮤니티의 게시글만 노출됩니다.</div>
		<div id="table" style="width: 90%; margin-left: 5%;">
			<div class="tbl-header">
			  <table cellpadding="0" cellspacing="0" border="0">
			    <thead>
			      <tr style="border-bottom: solid 3px #1264b970;">
			        <th style="width: 7%;">글번호</th>
					<th style="width: 41%;">제목</th>
					<th style="width: 20%;">작성자</th>
					<th style="width: 25%;">작성일자</th>
					<th style="width: 7%;">조회수</th>
			      </tr>
			    </thead>
			  </table>
			</div>
			<div class="tbl-content">
			  <table cellpadding="0" cellspacing="0" border="0">
			    <tbody>
			       <c:forEach var="clubboardList" items="${requestScope.clubboardList}" varStatus="index">
		                <c:if test="${index.index < 5}"> <!-- 인덱스가 5보다 작은 경우만 반복 -->
		                    <tr>
		                        <td style="width: 7%">${index.index + 1}</td>
		                        <td style="width: 41%">${clubboardList.title}</td>
		                        <td style="width: 20%">${clubboardList.fk_userid}</td>
		                        <td style="width: 25%">${clubboardList.registerdate}</td>
		                        <td style="width: 7%">${clubboardList.viewcount} <input id="clubboardseq" type="hidden" name="clubboardseq" value="${clubboardList.clubboardseq}" /></td>
		                        
		                    </tr>
		                </c:if>
		            </c:forEach>
			    </tbody>
			  </table>
			</div>
		</div>
		<div id="more" style="text-align: right; margin: 3% 5% 2% 0; color: #8a8a8a;" onclick="goBoard('${requestScope.clubvo.clubseq}', '${requestScope.clubvo.clubname}', '${requestScope.clubvo.sportname}')">게시판 바로가기 ▶</div>
	</div>

	
		
	
<form name="goViewFrm">
		<input type="hidden" name="clubseq" />
		<input type="hidden" name="clubboardseq" />
		<input type="hidden" name="goBackURL" />
		<input type="hidden" name="searchType" />
		<input type="hidden" name="searchWord" />
</form>

</div>

<input id="speed" type="hidden" value="${requestScope.statList.speed}"></input>
<input id="quick" type="hidden" value="${requestScope.statList.quick}"></input>
<input id="power" type="hidden" value="${requestScope.statList.power}"></input>
<input id='earth' type="hidden" value="${requestScope.statList.earth}"></input>
<input id='stretch' type="hidden" value="${requestScope.statList.stretch}"></input>

<script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/highcharts.js"></script>
<script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/highcharts-more.js"></script>
<script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/modules/exporting.js"></script>
<script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/modules/export-data.js"></script>
<script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/modules/accessibility.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	
	$("span#forhover").hide();
	
	$("span#bossname").hover(function(){
		$("span#forhover").fadeIn(100);
	}, function(){
		$("span#forhover").hide();
	});
	
	
	$("tbody > tr *").click(function(e){

		let clubseq = '${requestScope.clubvo.clubseq}';
		let clubboardseq = $(e.target).parent().find("input[name='clubboardseq']").val();
		
		const frm = document.goViewFrm;
		frm.clubboardseq.value = clubboardseq;
		frm.clubseq.value = clubseq;
		frm.goBackURL.value = "${requestScope.currentURL}";
		
		frm.method = "post";
		frm.action = "<%=ctxPath%>/club/clubboardDetail.do";
		frm.submit();
	
	});
	
});

function goBoard(clubseq, clubname, sportname){
	location.href = "<%= ctxPath%>/club/clubBoard.do?clubname="+clubname+"&clubseq="+clubseq+"&sportname="+sportname;
}


Highcharts.chart('stat', {

    chart: {
        polar: true,
        type: 'line'
    },

    accessibility: {
        description: ''
    },

    title: {
        text: '',
        x: -55
    },

    pane: {
        size: '80%'
    },

    xAxis: {
        categories: ['속력', '순발력', '근력', '지구력',
            '유연성'],
        tickmarkPlacement: 'on',
        lineWidth: 0,
        labels: {
            style: {
                fontSize: '14px' // 글자 크기를 14px로 설정
            }
        }
    },

    yAxis: {
        gridLineInterpolation: 'polygon',
        lineWidth: 0,
        min: 0,
        max: 5 // 최대치를 5로 설정
    },

    tooltip: {
        shared: true,
        pointFormat: '<span style="color:{series.color}">{series.name}: <b>\{point.y:,.0f}</b><br/>'
    },

    legend: {
        align: 'right',
        verticalAlign: 'middle',
        layout: 'vertical'
    },

    series: [{
        name: '스탯 평균',
        data: [parseFloat($("input#speed").val()), parseFloat($("input#quick").val()), parseFloat($("input#power").val()), parseFloat($("input#earth").val()), parseFloat($("input#stretch").val())],
        pointPlacement: 'off'
    }],

    responsive: {
        rules: [{
            condition: {
                maxWidth: 500
            },
            chartOptions: {
                legend: {
                    align: 'center',
                    verticalAlign: 'bottom',
                    layout: 'horizontal'
                },
                pane: {
                    size: '70%'
                }
            }
        }]
    }

});

</script>


    
