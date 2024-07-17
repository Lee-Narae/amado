<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
	width: 320px;
    height: 300px;
    object-fit: cover; /* 이미지 비율을 유지하면서 크기를 맞춤 */
}
</style>

<div id="container">
<div  style="background-color: #4040bf">
<div class="board_header"  style="display: flex; margin-left: 16.5%; color: white; padding: 3%;">
    <div class="tit">
        <h1>${requestScope.clubvo.clubname}</h1>
        <div class="desc">호날두가 속한 동호회 입니다.</div>
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
		                    <a href="#" class="btn_profile_link">
		                        <span class="coach" style="font-size: 15pt;">${requestScope.clubvo.fk_userid}</span>
		                        <span class="ico ico_profile_link"></span>
		                    </a>
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
                    		<img style="margin-left: 80%; margin-top: 15%;" src="<%=ctxPath%>/resources/images/rank17.png" />
                    	</c:if>
                    	<c:if test="${requestScope.clubvo.clubscore >= 100 && requestScope.clubvo.clubscore < 200}">
                    		<img style="margin-left: 80%; margin-top: 15%;" src="<%=ctxPath%>/resources/images/rank16.png" />
                    	</c:if>
                    	<c:if test="${requestScope.clubvo.clubscore >= 200 && requestScope.clubvo.clubscore < 300}">
                    		<img style="margin-left: 80%; margin-top: 15%;" src="<%=ctxPath%>/resources/images/rank15.png" />
                    	</c:if>
                    	<c:if test="${requestScope.clubvo.clubscore >= 300 && requestScope.clubvo.clubscore < 400}">
                    		<img style="margin-left: 80%; margin-top: 15%;" src="<%=ctxPath%>/resources/images/rank14.png" />
                    	</c:if>
                    	<c:if test="${requestScope.clubvo.clubscore >= 400 && requestScope.clubvo.clubscore < 500}">
                    		<img style="margin-left: 80%; margin-top: 15%;" src="<%=ctxPath%>/resources/images/rank13.png" />
                    	</c:if>
                    	<c:if test="${requestScope.clubvo.clubscore >= 500 && requestScope.clubvo.clubscore < 600}">
                    		<img style="margin-left: 80%; margin-top: 15%;" src="<%=ctxPath%>/resources/images/rank12.png" />
                    	</c:if>
                    	<c:if test="${requestScope.clubvo.clubscore >= 600 && requestScope.clubvo.clubscore < 700}">
                    		<img style="margin-left: 80%; margin-top: 15%;" src="<%=ctxPath%>/resources/images/rank11.png" />
                    	</c:if>
                    	<c:if test="${requestScope.clubvo.clubscore >= 700 && requestScope.clubvo.clubscore < 800}">
                    		<img style="margin-left: 80%; margin-top: 15%;" src="<%=ctxPath%>/resources/images/rank10.png" />
                    	</c:if>
                    	<c:if test="${requestScope.clubvo.clubscore >= 800 && requestScope.clubvo.clubscore < 900}">
                    		<img style="margin-left: 80%; margin-top: 15%;" src="<%=ctxPath%>/resources/images/rank9.png" />
                    	</c:if>
                    	<c:if test="${requestScope.clubvo.clubscore >= 900 && requestScope.clubvo.clubscore < 1000}">
                    		<img style="margin-left: 80%; margin-top: 15%;" src="<%=ctxPath%>/resources/images/rank8.png" />
                    	</c:if>
                    	<c:if test="${requestScope.clubvo.clubscore >= 1000 && requestScope.clubvo.clubscore < 1100}">
                    		<img style="margin-left: 80%; margin-top: 15%;" src="<%=ctxPath%>/resources/images/rank7.png" />
                    	</c:if>
                    	<c:if test="${requestScope.clubvo.clubscore >= 1100 && requestScope.clubvo.clubscore < 1200}">
                    		<img style="margin-left: 80%; margin-top: 15%;" src="<%=ctxPath%>/resources/images/rank6.png" />
                    	</c:if>
                    	<c:if test="${requestScope.clubvo.clubscore >= 1200 && requestScope.clubvo.clubscore < 1300}">
                    		<img style="margin-left: 80%; margin-top: 15%;" src="<%=ctxPath%>/resources/images/rank5.png" />
                    	</c:if>
                    	<c:if test="${requestScope.clubvo.clubscore >= 1300 && requestScope.clubvo.clubscore < 1400}">
                    		<img style="margin-left: 80%; margin-top: 15%;" src="<%=ctxPath%>/resources/images/rank4.png" />
                    	</c:if>
                    	<c:if test="${requestScope.clubvo.clubscore >= 1400 && requestScope.clubvo.clubscore < 1500}">
                    		<img style="margin-left: 80%; margin-top: 15%;" src="<%=ctxPath%>/resources/images/rank3.png" />
                    	</c:if>
                    	<c:if test="${requestScope.clubvo.clubscore >= 1500 && requestScope.clubvo.clubscore < 1600}">
                    		<img style="margin-left: 80%; margin-top: 15%;" src="<%=ctxPath%>/resources/images/rank2.png" />
                    	</c:if>
                    	<c:if test="${requestScope.clubvo.clubscore >= 1600 && requestScope.clubvo.clubscore < 1700}">
                    		<img style="margin-left: 80%; margin-top: 15%;" src="<%=ctxPath%>/resources/images/rank1.png" />
                    	</c:if>
                    	<c:if test="${requestScope.clubvo.clubscore > 1700}">
                    		<img style="margin-left: 80%; margin-top: 15%;" src="<%=ctxPath%>/resources/images/rank0.png" />
                    	</c:if>
                    </div>
                </div>
                <div class="crest">
                    <div class="img">
                        <img class='uniform-size' style="margin-left: 120%;" src="<%=ctxPath%>/resources/images/zee/${requestScope.clubvo.clubimg}">
                    </div>
                </div>
            </div>


        </div>
    </div>
</div>
</div>
	<div id="top2" style="display: flex; height: 500px; margin-top: 5%;">
		<!-- 동호회 여러개 가입시 캐러셀 적용 -->
		<div id="myclub" style="width: 38%; margin: 5% 0 0 8%;">
			<div style="text-align: center;">
				<img class='uniform-size1' src="<%=ctxPath%>/resources/images/zee/${requestScope.clubvo.clubimg}">
			</div>
			<div style="text-align: center; margin-top: 5%; font-size: 25px; font-weight: bold;">${requestScope.clubvo.clubname}</div>
		</div>
		
		
		<div id="clubmatch" style="width: 43%; margin: 2% 0 0 0; border-radius: 20px; box-shadow: 0px 11px 22px #9e9e9e6b;">
			<div id="clubTitle" style="text-align: center; margin: 3% 0 3% 0; font-size: 30pt; font-weight: bolder;">${requestScope.clubvo.clubname} 스탯</div>
			<div style="width: 100%; display: flex;" >
				<div>
					<img style="width: 70%; margin: 5% 20%;" src="<%=ctxPath%>/resources/images/스탯.png">
				</div>
				<ul style="list-style: none; width: 50%; margin: 4% 10% 0 0; font-family: 'Roboto', sans-serif;">
					<li><span style="font-weight: bolder;">대표 연락처:  </span>${requestScope.clubvo.clubtel}</li>
					<li style="margin-top: 4%;"><span style="font-weight: bolder;">지역:  </span>${requestScope.clubvo.city} ${requestScope.clubvo.local}</li>
					<li style="margin-top: 4%;"><span style="font-weight: bolder;">활동구장:  </span>${requestScope.clubvo.clubgym}</li>
					<li style="margin-top: 4%;"><span style="font-weight: bolder;">운영시간:  </span>${requestScope.clubvo.clubtime}</li>
					<li style="margin-top: 4%;"><span style="font-weight: bolder;">정원:  </span>${requestScope.clubvo.membercount}</li>
					<li style="margin-top: 4%;"><span style="font-weight: bolder;">회비:  </span>${requestScope.clubvo.clubpay}원</li>
					<li style="margin-top: 4%;"><span style="font-weight: bolder;">랭크 점수:  </span>${requestScope.clubvo.clubscore}</li>
				</ul>
			</div>
			<div id="more" style="text-align: right; margin: 1% 7% 0 0; color: #8a8a8a;">우리 팀 매치 일정 더보기 ▶</div>
		</div>
	</div>



<div id="clubTitle" style="text-align: center; margin: 8% 0 0 0; font-size: 30pt; font-weight: bolder;">최근 전적</div>
	<div id="clubboard" style="width: 88%; padding: 4% 3% 1% 3%; margin: 2% auto 5% auto; border-radius: 20px; box-shadow: 0px 11px 22px #9e9e9e6b;">
		
		<div style="display: flex;">
		
			<div style="display: flex; margin-left: 3%; width: 56%;">
				<div>
					<img class='uniform-size' style="margin-left: 90%;" src="<%=ctxPath%>/resources/images/zee/${requestScope.clubvo.clubimg}">
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
		<div id="more" style="text-align: right; margin: 4% 5% 2% 0; color: #8a8a8a;">최근 전적 더보기 ▶</div>
	</div>
	



	<div id="clubTitle" style="text-align: center; margin: 8% 0 0 0; font-size: 30pt; font-weight: bolder;">팀 커뮤니티 최신글</div>
	<div id="clubboard" style="width: 88%; padding: 5% 3% 1% 3%; margin: 2% auto 5% auto; border-radius: 70px; background-color: #e6f7ff; box-shadow: 0px 0px 10px #9ac5db;">
		<div style="margin: 1% 0 1% 5%; font-size: 10pt;">※ 팀 커뮤니티 최신글은 최근 일주일간 작성된 팀 커뮤니티의 게시글만 노출됩니다.</div>
		<div id="table" style="width: 90%; margin-left: 5%;">
			<div class="tbl-header">
			  <table cellpadding="0" cellspacing="0" border="0">
			    <thead>
			      <tr>
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
			      <tr>
					<td style="width: 7%;">1</td>
					<td style="width: 41%;">제목</td>
					<td style="width: 20%;">작성자</td>
					<td style="width: 25%;">작성일자</td>
					<td style="width: 7%;">조회수</td>
				</tr>
				<tr>
					<td style="width: 7%;">2</td>
					<td style="width: 41%;">제목</td>
					<td style="width: 20%;">작성자</td>
					<td style="width: 25%;">작성일자</td>
					<td style="width: 7%;">조회수</td>
				</tr>
				<tr>
					<td style="width: 7%;">3</td>
					<td style="width: 41%;">제목</td>
					<td style="width: 20%;">작성자</td>
					<td style="width: 25%;">작성일자</td>
					<td style="width: 7%;">조회수</td>
				</tr>
			    </tbody>
			  </table>
			</div>
		</div>
		<div id="more" style="text-align: right; margin: 5% 5% 2% 0; color: #8a8a8a;">게시판 바로가기 ▶</div>
	</div>
	


</div>


<script type="text/javascript">
$(document).ready(function(){
	
	$("span#forhover").hide();
	
	$("span#bossname").hover(function(){
		$("span#forhover").fadeIn(100);
	}, function(){
		$("span#forhover").hide();
	});
	
	
});

</script>


    
