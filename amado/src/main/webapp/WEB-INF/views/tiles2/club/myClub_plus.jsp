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


</style>

<div id="container">
<div  style="background-color: #4040bf">
<div class="board_header"  style="display: flex; margin-left: 15%; color: white; padding: 3%;">
    <div class="tit">
        <h1>프로필</h1>
        <div class="desc">호날두가 속한 동호회 입니다.</div>
    </div>
    

    <div class="coach_area" >
        <div class="wrap">
            <div class="coach_info" style="display: flex; margin-left: 200%;">
            	<div style="display: inline;">
	                <div class="name">
	                	<span style="font-size: 12pt;">동호회장</span>
	                    <a href="#" class="btn_profile_link">
	                        <span class="coach">HYEOKKKK</span>
	                        <span class="ico ico_profile_link"></span>
	                    </a>
	                </div>
	                <div class="info" style="margin-top: 15%;">
	                    <div class="visit">
	                        <span class="txt">방문자 수</span>
	                        <span class="num">1(오늘 0)</span>
	                    </div>
	                </div>
                </div>
                <div class="rank">
                    <div class="img">
                    	<img style="margin-left: 37%;" src="https://ssl.nexon.com/s2/game/fo4/obt/rank/large/update_2009/ico_rank9.png" />
                    </div>
                </div>
                <div class="crest">
                    <div class="img">
                        <img style="margin-left: 22%;" src="https://fco.dn.nexoncdn.co.kr/live/externalAssets/common/crests/light/medium/l18.png" alt="">
                    </div>
                </div>
            </div>


        </div>
    </div>
</div>
</div>
	<div id="top2" style="display: flex; height: 500px; margin-top: 5%;">
		<!-- 동호회 여러개 가입시 캐러셀 적용 -->
		<div id="myclub" style="width: 38%; margin: 1% 0 0 8%;">
			<img src="<%=ctxPath%>/resources/images/real_madrid.png" />
			<div style="text-align: center; margin: 5% 13% 0 0; font-size: 25px; font-weight: bold;">호우마드리드</div>
		</div>
		
		
		<div id="clubmatch" style="width: 43%; margin: 2% 0 0 0; border-radius: 70px; background-color: #e6f7ff; box-shadow: 0px 0px 10px #9ac5db;">
			<div id="clubTitle" style="text-align: center; margin: 3% 0 3% 0; font-size: 30pt; font-weight: bolder;">호날두 스탯</div>
			<div style="width: 100%; display: flex;" >
				<div>
					<img style="width: 70%; margin: 5% 20%;" src="<%=ctxPath%>/resources/images/스탯.png">
				</div>
				<ul style="list-style: none; width: 50%; margin: 4% 10% 0 0; font-family: 'Roboto', sans-serif;">
					<li><span style="font-weight: bolder;">대표 연락처:  </span>010-1234-5678</li>
					<li style="margin-top: 4%;"><span style="font-weight: bolder;">지역:  </span>미국 뉴욕주</li>
					<li style="margin-top: 4%;"><span style="font-weight: bolder;">활동구장:  </span>토트넘 스타디움</li>
					<li style="margin-top: 4%;"><span style="font-weight: bolder;">운영시간:  </span>24시간 연중무휴</li>
					<li style="margin-top: 4%;"><span style="font-weight: bolder;">정원:  </span>5명</li>
					<li style="margin-top: 4%;"><span style="font-weight: bolder;">회비:  </span>500원</li>
					<li style="margin-top: 4%;"><span style="font-weight: bolder;">랭크 점수:  </span>1000점</li>
				</ul>
			</div>
			<div id="more" style="text-align: right; margin: 1% 7% 0 0; color: #8a8a8a;">우리 팀 매치 일정 더보기 ▶</div>
		</div>
	</div>



<div id="clubTitle" style="text-align: center; margin: 8% 0 0 0; font-size: 30pt; font-weight: bolder;">최근 전적</div>
	<div id="clubboard" style="width: 88%; padding: 4% 3% 1% 3%; margin: 2% auto 5% auto; border-radius: 70px; background-color: #e6f7ff; box-shadow: 0px 0px 10px #9ac5db;">
		
		<div style="display: flex;">
		
			<div style="display: flex; margin-left: 4%;">
				<img style="width: 20%;" src="<%=ctxPath%>/resources/images/real_madrid.png">
				<div style="font-family: 'Roboto', sans-serif; font-weight: bold; font-size: 45px; margin-top: 4.5%; color: #2929a3;">호우마드리드</div>
			</div>
			
			<div style="display: inline; margin-top: 2%; margin-left: 15%;">
				<div style="margin: 1% 0 5% 7%; font-size: 17pt; font-weight: bold; width: 100%;">최근 5게임 전적</div>
				<div style="display: flex; color: white; margin-left: 5%;">
					<div style="border: solid 1px #ff3333; padding: 4% 8%; background-color: #ff3333;">패</div>
					<div style="border: solid 1px #ff3333; padding: 4% 8%; background-color: #ff3333;">패</div>
					<div style="border: solid 1px #4d4dff; padding: 4% 8%; background-color: #4d4dff;">승</div>
					<div style="border: solid 1px #4d4dff; padding: 4% 8%; background-color: #4d4dff;">승</div>
					<div style="border: solid 1px #ff3333; padding: 4% 8%; background-color: #ff3333;">패</div>
				</div>
			</div>
		
		</div>
		<div id="table" style="width: 90%; margin-left: 5%; margin-top: 4%;">
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
				<tr>
					<td style="width: 7%;">4</td>
					<td style="width: 41%;">제목</td>
					<td style="width: 20%;">작성자</td>
					<td style="width: 25%;">작성일자</td>
					<td style="width: 7%;">조회수</td>
				</tr>
				<tr>
					<td style="width: 7%;">5</td>
					<td style="width: 41%;">제목</td>
					<td style="width: 20%;">작성자</td>
					<td style="width: 25%;">작성일자</td>
					<td style="width: 7%;">조회수</td>
				</tr>
			    </tbody>
			  </table>
			</div>
		</div>
		<div id="more" style="text-align: right; margin: 5% 5% 2% 0; color: #8a8a8a;">최근 전적 더보기 ▶</div>
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


    
