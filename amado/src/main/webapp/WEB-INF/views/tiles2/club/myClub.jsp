<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
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
	
	
});

</script>

<div id="container">
	<div id="clubTitle" style="text-align: center; margin: 5% 0 2% 0; font-size: 30pt; font-weight: bolder;">💌 My 동호회 💌</div>

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

	<div id="top2" style="display: flex; height: 500px;">
		<div id="myclub" style="width: 43%; margin: 2% 0 0 5%; border-radius: 70px; background-color: #e6f7ff; box-shadow: 0px 0px 10px #9ac5db;">
			<div id="clubTitle" style="text-align: center; margin-top: 5%; font-size: 30pt; font-weight: bolder;">${requestScope.club.clubname }</div>
			<div id="info" style="background-color: transparent; display: flex; margin: 5% 0 0 0; width: 100%; opacity: 1; height: auto;">
				<div id="clubimg" style="border: solid 1px grey; width: 25%; height: 200px; margin-left: 5%; overflow: hidden;">
					<img src="" />
				</div>
				<div style="width: 75%;">
					<div id="clubboss" style="width: 100%; margin-bottom: 2%;">
						<span class="title">동호회 회장</span>
						<span class="detail" id="bossname">이나래</span><span id="forhover">◁ 클릭하여 정보보기</span>
					</div>
					<div id="tel" style="width: 100%; margin-bottom: 2%;">
						<span class="title">연락처</span>
						<span class="detail">010-1234-1234</span>
					</div>
					<div id="area" style="width: 100%; margin-bottom: 2%;">
						<span class="title">지역</span>
						<span class="detail">서울시 중랑구</span>
					</div>
					<div id="gym" style="width: 100%; margin-bottom: 2%;">
						<span class="title">활동구장</span>
						<span class="detail">쌍용초등학교 체육관</span>
					</div>
					<div id="time" style="width: 100%; margin-bottom: 2%;">
						<span class="title">운영시간</span>
						<span class="detail">매주 일요일 오후 1시~6시</span>
					</div>
				</div>
			</div>
			<div id="more" style="text-align: right; margin: 6% 8% 0 0; color: #8a8a8a;"><a href="<%= ctxPath%>/club/myClub_plus.do">동호회 정보 더보기 ▶</a></div>
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