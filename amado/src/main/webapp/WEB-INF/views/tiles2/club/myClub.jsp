<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="<%=ctxPath%>/resources/bootstrap-4.6.2-dist/css/bootstrap.min.css" type="text/css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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

.cards:hover {
box-shadow: 0px 0px 15px #cccccc;
cursor: pointer;
}

.cardsclick {
box-shadow: 0px 0px 15px #cccccc;
cursor: pointer;
}

.cardsunclick {
opacity: 0.5;
}

#notice:hover{
cursor: pointer;
opacity: 0.8;
}

#alarmPopup{
width: 400px;
height: auto;
position: relative;
top: 10%;
left: 68%;
z-index: 500;
border-radius: 20px;
background-color: rgba(230, 245, 255, 0.5);
padding: 1.5%;
}

.alarmDiv:hover {
cursor: pointer;
font-weight: bold;
color: #0099ff !important;
}

table#matchInfo > tbody > tr > td:nth-child(1),
table#VsInfo > tbody > tr > td:nth-child(1) {
background-color: #ccebff;
color: #001633;
font-weight: bold;
font-size: 13pt;
}

table#matchInfo > tbody > tr > td:nth-child(2),
table#VsInfo > tbody > tr > td:nth-child(2) {
font-size: 12pt;
}

table#matchInfo > tbody > tr:nth-child(1) > td:nth-child(1),
table#VsInfo > tbody > tr:nth-child(1) > td:nth-child(1) {
border-top-left-radius: 20px; 
}

table#matchInfo > tbody > tr:nth-child(3) > td:nth-child(1),
table#VsInfo > tbody > tr:nth-child(3) > td:nth-child(1) {
border-bottom-left-radius: 20px; 
}
</style>

<script type="text/javascript">
$(document).ready(function(){
	
	$("span#forhover").hide();
	
	$("span#bossname").hover(function(){
		$("span#forhover").fadeIn(100);
	}, function(){
		$("span#forhover").hide();
	});
	
	
	const page_url = window.location.href;

	const url = new URL(page_url);
	const urlParams = url.searchParams;
	const seq = urlParams.get('sportseq');
	// console.log("seq: "+seq); 확인 완료

	
	for(let i=1; i<9; i++){
		if(seq == i){
			$("div.cards").addClass("cardsunclick");
			$(`div#\${seq}`).removeClass("cardsunclick");
			$(`div#\${seq}`).addClass("cardsclick");
		}
	}
	
	$("div#alarmPopup").hide();
	
	$("div#notice").hover(function(){ // mouseover
		$("div#alarmPopup").show();	
	}, function(){ // mouseout
	});
	
	$("div#alarmPopup").hover(function(){
		$("div#alarmPopup").show();
	}, function(){
		$("div#alarmPopup").hide();
	});
	
}); // document.ready

function openModal(){
	
	const sportname = $(event.target).parent().parent().find("input#sportname").val();
	const matchdate = $(event.target).parent().parent().find("input#matchdate").val();
	const city = $(event.target).parent().parent().find("input#city").val();
	const local = $(event.target).parent().parent().find("input#local").val();
	const area = $(event.target).parent().parent().find("input#area").val();
	const B_name = $(event.target).parent().parent().find("input#B_name").val();
	const message = $(event.target).parent().parent().find("input#message").val();
	const membercount = $(event.target).parent().parent().find("input#membercount").val();
	const matchingapplyseq = $(event.target).parent().parent().find("input#matchingapplyseq").val();
	const matchingregseq = $(event.target).parent().parent().find("input#matchingregseq").val();
	
	const Aseq = $(event.target).parent().parent().find("input#Aseq").val();
	const Bseq = $(event.target).parent().parent().find("input#Bseq").val();
	
	let modal_html = `
		<div class="modal-header" align="center">
        <h5 class="modal-title" style="font-weight: bold; width: 100%; display: inline-block;">매치 승인하기</h5>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
	<div class="modal-body" style="height: auto;">
	<div style="margin-left: 15%; font-weight: bold; color: #001633;">매치 정보</div>
      	<div style="border: solid 2px #99d6ff; border-radius: 20px; width: 70%; margin-left: 15%;">
        <table id="matchInfo">
        	<tbody>
        		<tr>
        			<td width="30">종목</td>
        			<td width="70">\${sportname}</td>
        		</tr>
        		<tr>
        			<td>날짜</td>
        			<td>\${matchdate.substring(0, 16)}</td>
        		</tr>
        		<tr>
        			<td>장소</td>
        			<td>\${city}&nbsp;\${local}&nbsp;\${area}</td>
        		</tr>
        	</tbody>
        </table>
  	</div>
  	<div style="margin: 5% 0 0 15%; font-weight: bold; color: #001633;">상대팀 정보</div>
  	<div style="border: solid 2px #99d6ff; border-radius: 20px; width: 70%; margin-left: 15%;">
        <table id="VsInfo">
        	<tbody>
        		<tr>
        			<td width="30">팀명</td>
        			<td width="70"><a>\${B_name}</a></td>
        		</tr>
        		<tr>
        			<td>전달 메세지</td>
        			<td>\${message}</td>
        		</tr>
        		<tr>
        			<td>인원</td>
        			<td>\${membercount}명</td>
        		</tr>
        	</tbody>
        </table>
    </div>
    </div>
    <div class="modal-footer">
    <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
    <button type="button" class="btn btn-primary" onclick="goPermit(\${matchingapplyseq}, \${matchingregseq}, \${Aseq}, \${Bseq})">승인하기</button>
  </div>
    `;
    
    $("div.modal-content").html(modal_html);
}

function goPermit(matchingapplyseq, matchingregseq, Aseq, Bseq){
	
	// 선택된 동호회의 tbl_matchingapplyseq 행 status는 1로, 선택받지 못한 동호회는 2로, tbl_matchingreg의  matchingregseq 행 status는 1로
	$.ajax({
		url: "<%=ctxPath%>/club/matching.do",
		data: {"matchingapplyseq": matchingapplyseq, "matchingregseq": matchingregseq,
			   "Aseq": Aseq, "Bseq": Bseq},
		dataType: "json",
		type: "post",
		success: function(json){
			
			// console.log(JSON.stringify(json));
			
			if(json.n == 1){
				  
				alert('승인 완료!');
				
				$('#matchPermitModal').modal('hide');
				location.reload(true);
			}
			
			else {
				alert('내부 오류로 인해 승인이 실패하였습니다. 다시 시도해주세요.');

				$('#matchPermitModal').modal('hide');
				location.reload(true);
			}
			
		},
		error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}
	});
	
}

</script>

<div id="container">

<!-- 모달 -->
<div class="modal modalclass" id="matchPermitModal" style="margin-top: 5%; height: auto;">
  <div class="modal-dialog modal-lg" style="height: auto;">
    <div class="modal-content">
    </div>
  </div>
</div>

	<c:if test="${sessionScope.loginuser.memberrank == '1'}">
		<div style="height: 60px;">
			<div id="notice" align="right" style="margin-right: 10%;">
				<span style="background-color: #0099ff; color: white; font-weight: bold; font-size: 20pt; display: inline-block; width: 40px; height: 40px; text-align: center; align-content: center; border-radius: 20px;">${requestScope.alarmList.size()}</span>
				<img width="70" height="70" src="https://img.icons8.com/3d-fluency/94/bell.png" alt="bell"/>
			</div>
			
			<c:if test="${not empty requestScope.alarmList}">
			<div id="alarmPopup">
				<c:forEach var="alarm" items="${requestScope.alarmList}" varStatus="status">
					<c:if test="${status.index != requestScope.alarmList.size()-1}">
						<div>
							<div class="alarmDiv" data-toggle="modal" data-target="#matchPermitModal" onclick="openModal()">[${alarm.sportname}]&nbsp;<span style="font-weight: bold; color: red;">${alarm.B_name}</span>&nbsp;팀의 매치 요청</div>
							<input type="hidden" id="matchingapplyseq" value="${alarm.matchingapplyseq}" />
							<input type="hidden" id="matchingregseq" value="${alarm.matchingregseq}" />
							<input type="hidden" id="sportname" value="${alarm.sportname}" />
							<input type="hidden" id="Aseq" value="${alarm.Aseq}" />
							<input type="hidden" id="Bseq" value="${alarm.Bseq}" />
							<input type="hidden" id="B_name" value="${alarm.B_name}" />
							<input type="hidden" id="message" value="${alarm.message}" />
							<input type="hidden" id="membercount" value="${alarm.membercount}" />
							<input type="hidden" id="matchdate" value="${alarm.matchdate}" />
							<input type="hidden" id="city" value="${alarm.city}" />
							<input type="hidden" id="local" value="${alarm.local}" />
							<input type="hidden" id="area" value="${alarm.area}" />
							<input type="hidden" id="status" value="${alarm.status}" />
						</div>
						<hr>
					</c:if>
					<c:if test="${status.index == requestScope.alarmList.size()-1}">
						<div>
							<div class="alarmDiv" data-toggle="modal" data-target="#matchPermitModal" onclick="openModal()">[${alarm.sportname}]&nbsp;<span style="font-weight: bold; color: red;">${alarm.B_name}</span>&nbsp;팀의 매치 요청</div>
							<input type="hidden" id="matchingapplyseq" value="${alarm.matchingapplyseq}" />
							<input type="hidden" id="matchingregseq" value="${alarm.matchingregseq}" />
							<input type="hidden" id="sportname" value="${alarm.sportname}" />
							<input type="hidden" id="Aseq" value="${alarm.Aseq}" />
							<input type="hidden" id="Bseq" value="${alarm.Bseq}" />
							<input type="hidden" id="B_name" value="${alarm.B_name}" />
							<input type="hidden" id="message" value="${alarm.message}" />
							<input type="hidden" id="membercount" value="${alarm.membercount}" />
							<input type="hidden" id="matchdate" value="${alarm.matchdate}" />
							<input type="hidden" id="city" value="${alarm.city}" />
							<input type="hidden" id="local" value="${alarm.local}" />
							<input type="hidden" id="area" value="${alarm.area}" />
							<input type="hidden" id="status" value="${alarm.status}" />
						</div>
					</c:if>
				</c:forEach>
			</div>
			</c:if>
			
		</div>
	</c:if>
	<div id="clubTitle" style="text-align: center; margin: 2% 0 2% 0; font-size: 30pt; font-weight: bolder;">💌 My 동호회 💌</div>

	<div style="width: 100%; height: 200px; margin-bottom: 3%;" align="center">
		<div style="background-color: #f2f2f2; width: 80%; height: 200px; border-radius: 15px; display: flex; justify-content: space-between; padding: 1.3%;">
			<div class="cards" id="1" onclick="location.href='<%=ctxPath %>/club/myClub.do?sportseq=1'" style="width: 10%; height: 150px; background-color: white; border-radius: 15px; padding-top: 1%;">
				<img width="70%" height="70%" src="https://img.icons8.com/emoji/96/soccer-ball-emoji.png" alt="soccer-ball-emoji"/>
				<div style="font-weight: bold;">축구</div>
			</div>
			<div class="cards" id="2" onclick="location.href='<%=ctxPath %>/club/myClub.do?sportseq=2'" style="width: 10%; height: 150px; background-color: white; border-radius: 15px; padding-top: 1%;">
				<img width="70%" height="70%" src="https://img.icons8.com/emoji/96/baseball-emoji.png" alt="baseball-emoji"/>
				<div style="font-weight: bold;">야구</div>
			</div>
			<div class="cards" id="3" onclick="location.href='<%=ctxPath %>/club/myClub.do?sportseq=3'" style="width: 10%; height: 150px; background-color: white; border-radius: 15px; padding-top: 1%;">
				<img width="70%" height="70%" src="https://img.icons8.com/emoji/96/volleyball-emoji.png" alt="volleyball-emoji"/>
				<div style="font-weight: bold;">배구</div>
			</div>
			<div class="cards" id="4" onclick="location.href='<%=ctxPath %>/club/myClub.do?sportseq=4'" style="width: 10%; height: 150px; background-color: white; border-radius: 15px; padding-top: 1%;">
				<img width="70%" height="70%" src="https://img.icons8.com/emoji/96/basketball-emoji.png" alt="basketball-emoji"/>
				<div style="font-weight: bold;">농구</div>
			</div>
			<div class="cards" id="6" onclick="location.href='<%=ctxPath %>/club/myClub.do?sportseq=6'" style="width: 10%; height: 150px; background-color: white; border-radius: 15px; padding-top: 1%;">
				<img width="70%" height="70%" src="https://img.icons8.com/emoji/96/tennis-emoji.png" alt="tennis-emoji"/>
				<div style="font-weight: bold;">테니스</div>
			</div>
			<div class="cards" id="7" onclick="location.href='<%=ctxPath %>/club/myClub.do?sportseq=7'" style="width: 10%; height: 150px; background-color: white; border-radius: 15px; padding-top: 1%;">
				<img style="margin: 6% 0;" width="57%" height="57%" src="https://img.icons8.com/external-smashingstocks-flat-smashing-stocks/96/external-Bowling-casino-smashingstocks-flat-smashing-stocks-3.png" alt="external-Bowling-casino-smashingstocks-flat-smashing-stocks-3"/>
				<div style="font-weight: bold;">볼링</div>
			</div>
			<div class="cards" id="5" onclick="location.href='<%=ctxPath %>/club/myClub.do?sportseq=5'" style="width: 10%; height: 150px; background-color: white; border-radius: 15px; padding-top: 1%;">
				<img style="margin: 7% 0;" width="53%" height="53%" src="https://img.icons8.com/office/96/beach-ball.png" alt="beach-ball"/>
				<div style="font-weight: bold;">족구</div>
			</div>
			<div class="cards" id="8" onclick="location.href='<%=ctxPath %>/club/myClub.do?sportseq=8'" style="width: 10%; height: 150px; background-color: white; border-radius: 15px; padding-top: 1%;">
				<img style="margin: 5% 0;" width="55%" height="55%" src="https://img.icons8.com/3d-fluency/96/shuttercock.png" alt="shuttercock"/>
				<div style="font-weight: bold;">배드민턴</div>
			</div>
		</div>
	</div>

<c:if test="${not empty requestScope.club}">
<div style="margin-left: 2.2%;">
	<div id="top2" style="display: flex; height: 500px;">
		<div id="myclub" style="width: 43%; margin: 2% 0 0 5%; border-radius: 70px; background-color: #e6f7ff; box-shadow: 0px 0px 10px #9ac5db;">
			<div id="clubTitle" style="text-align: center; margin-top: 5%; font-size: 30pt; font-weight: bolder;">${requestScope.club.clubname}</div>
			<div id="sport" style="text-align: center;">${requestScope.club.sportname}</div>
			<div id="info" style="background-color: transparent; display: flex; margin: 5% 0 0 0; width: 100%; opacity: 1; height: auto;">
				<div id="clubimg" style="border: solid 1px grey; width: 25%; height: 200px; margin-left: 5%; overflow: hidden;">
					<img width="100%" src="<%=ctxPath %>/resources/images/zee/${requestScope.club.wasfilename}" />
				</div>
				<div style="width: 75%;">
					<div id="clubboss" style="width: 100%; margin-bottom: 2%;">
						<span class="title">동호회 회장</span>
						<span class="detail" id="bossname">${requestScope.club.name}</span><span id="forhover">◁ 클릭하여 정보보기</span>
					</div>
					<div id="tel" style="width: 100%; margin-bottom: 2%;">
						<span class="title">연락처</span>
						<span class="detail">${requestScope.club.clubtel}</span>
					</div>
					<div id="area" style="width: 100%; margin-bottom: 2%;">
						<span class="title">지역</span>
						<span class="detail">${requestScope.club.city} > ${requestScope.club.local}</span>
					</div>
					<div id="gym" style="width: 100%; margin-bottom: 2%;">
						<span class="title">활동구장</span>
						<span class="detail">${requestScope.club.clubgym}</span>
					</div>
					<div id="time" style="width: 100%; margin-bottom: 2%;">
						<span class="title">운영시간</span>
						<span class="detail">${requestScope.club.clubtime}</span>
					</div>
				</div>
			</div>
			<div id="more" style="text-align: right; margin: 3% 8% 0 0; color: #8a8a8a;"><a href="<%= ctxPath%>/club/myClub_plus.do">동호회 정보 더보기 ▶</a></div>
		</div>
		
		
		<div id="clubmatch" style="width: 43%; margin: 2% 0 0 2%; border-radius: 70px; background-color: #e6f7ff; box-shadow: 0px 0px 10px #9ac5db;">
			<div id="clubTitle" style="text-align: center; margin-top: 5%; font-size: 30pt; font-weight: bolder;">우리 팀 매치 일정</div>
			<div style="margin: 5% 0 1% 5%; font-size: 10pt;">※ 팀 매치 일정은 상위 3개까지 노출됩니다.</div>
			<div id="table" style="width: 90%; margin-left: 5%;">
				<div class="tbl-header">
				  <table cellpadding="0" cellspacing="0" border="0">
				    <thead>
				      <tr>
				        <th style="width: 10%;">순번</th>
						<th style="width: 20%;">날짜</th>
						<th style="width: 35%;">상대팀</th>
						<th style="width: 35%;">장소</th>
				      </tr>
				    </thead>
				  </table>
				</div>
				<div class="tbl-content">
				  <table cellpadding="0" cellspacing="0" border="0">
				    <tbody>
				      <tr>
						<td style="width: 10%;">1</td>
						<td style="width: 20%;">2024-08-09 14:30</td>
						<td style="width: 35%;">마산쌍칼</td>
						<td style="width: 35%;">동작구 체육관</td>
					</tr>
					<tr>
						<td style="width: 10%;">2</td>
						<td style="width: 20%;">2024-08-20 13:00</td>
						<td style="width: 35%;">공릉동 불꽃 스파이크</td>
						<td style="width: 35%;">동해 해수욕장</td>
					</tr>
					<tr>
						<td style="width: 10%;">-</td>
						<td style="width: 20%;">-</td>
						<td style="width: 35%;">-</td>
						<td style="width: 35%;">-</td>
					</tr>
				    </tbody>
				  </table>
				</div>
			</div>
			<div id="more" style="text-align: right; margin: 3.5% 8% 0 0; color: #8a8a8a;">우리 팀 매치 일정 더보기 ▶</div>
		</div>
	</div>

	<div id="clubTitle" style="text-align: center; margin: 5% 0 0 0; font-size: 30pt; font-weight: bolder;">팀 커뮤니티 최신글</div>
	<div id="clubboard" style="width: 88%; padding: 5% 3% 1% 3%; margin: 2% 0 5% 5%; border-radius: 70px; background-color: #e6f7ff; box-shadow: 0px 0px 10px #9ac5db;">
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
</c:if>

<c:if test="${empty requestScope.club}">
<div style="margin-left: 2.2%;">
	<div id="top2" style="display: flex; height: 500px; margin-bottom: 5%; filter: blur(7px);">
		<div id="myclub" style="width: 43%; margin: 2% 0 0 5%; border-radius: 70px; background-color: #e6f7ff; box-shadow: 0px 0px 10px #9ac5db;">
			<div id="clubTitle" style="text-align: center; margin-top: 5%; font-size: 30pt; font-weight: bolder;">동호회 이름</div>
			<div id="sport" style="text-align: center;">종목</div>
			<div id="info" style="background-color: transparent; display: flex; margin: 5% 0 0 0; width: 100%; opacity: 1; height: auto;">
				<div id="clubimg" style="border: solid 1px grey; width: 25%; height: 200px; margin-left: 5%; overflow: hidden;">
					<img width="100%" src="<%=ctxPath %>/resources/images/logo.png" />
				</div>
				<div style="width: 75%;">
					<div id="clubboss" style="width: 100%; margin-bottom: 2%;">
						<span class="title">동호회 회장</span>
						<span class="detail" id="bossname">아마두</span><span id="forhover">◁ 클릭하여 정보보기</span>
					</div>
					<div id="tel" style="width: 100%; margin-bottom: 2%;">
						<span class="title">연락처</span>
						<span class="detail">010-1234-1234</span>
					</div>
					<div id="area" style="width: 100%; margin-bottom: 2%;">
						<span class="title">지역</span>
						<span class="detail">서울시 > 쌍용구</span>
					</div>
					<div id="gym" style="width: 100%; margin-bottom: 2%;">
						<span class="title">활동구장</span>
						<span class="detail">쌍용강북체육센터</span>
					</div>
					<div id="time" style="width: 100%; margin-bottom: 2%;">
						<span class="title">운영시간</span>
						<span class="detail">평일 09:00 ~ 18:00</span>
					</div>
				</div>
			</div>
			<div id="more" style="text-align: right; margin: 3% 8% 0 0; color: #8a8a8a;"><a href="<%= ctxPath%>/club/myClub_plus.do">동호회 정보 더보기 ▶</a></div>
		</div>
		
		
		<div id="clubmatch" style="width: 43%; margin: 2% 0 0 2%; border-radius: 70px; background-color: #e6f7ff; box-shadow: 0px 0px 10px #9ac5db;">
			<div id="clubTitle" style="text-align: center; margin-top: 5%; font-size: 30pt; font-weight: bolder;">우리 팀 매치 일정</div>
			<div style="margin: 5% 0 1% 5%; font-size: 10pt;">※ 팀 매치 일정은 상위 3개까지 노출됩니다.</div>
			<div id="table" style="width: 90%; margin-left: 5%;">
				<div class="tbl-header">
				  <table cellpadding="0" cellspacing="0" border="0">
				    <thead>
				      <tr>
				        <th style="width: 10%;">순번</th>
						<th style="width: 20%;">날짜</th>
						<th style="width: 35%;">상대팀</th>
						<th style="width: 35%;">장소</th>
				      </tr>
				    </thead>
				  </table>
				</div>
				<div class="tbl-content">
				  <table cellpadding="0" cellspacing="0" border="0">
				    <tbody>
				      <tr>
						<td style="width: 10%;">-</td>
						<td style="width: 20%;">-</td>
						<td style="width: 35%;">-</td>
						<td style="width: 35%;">-</td>
					</tr>
					<tr>
						<td style="width: 10%;">-</td>
						<td style="width: 20%;">-</td>
						<td style="width: 35%;">-</td>
						<td style="width: 35%;">-</td>
					</tr>
					<tr>
						<td style="width: 10%;">-</td>
						<td style="width: 20%;">-</td>
						<td style="width: 35%;">-</td>
						<td style="width: 35%;">-</td>
					</tr>
				    </tbody>
				  </table>
				</div>
			</div>
			<div id="more" style="text-align: right; margin: 3.5% 8% 0 0; color: #8a8a8a;">우리 팀 매치 일정 더보기 ▶</div>
		</div>
	</div>
	
	<div align="center" style="position: absolute; top: 72%; left: 3%; width: 100%;">
		<div style="z-index: 100; width: 50%; height: 300px; align-content: center;">
			<div style="font-size: 25pt; line-height: 200%; font-weight: bold;">아직 가입된 동호회가 없습니다.<br>동호회 찾기 버튼을 눌러 마음에 드는 동호회에 가입하세요!</div>
			<div class="btn btn-primary btn-lg" style="margin-top: 3%;" onclick="location.href='<%=ctxPath%>/club/findClub.do'">동호회 찾기</div>
		</div>
	</div>
	
</div>	
</c:if>

</div>