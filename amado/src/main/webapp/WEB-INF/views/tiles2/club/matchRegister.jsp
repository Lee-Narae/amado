<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>

<style type="text/css">

#topImg {
background-color: #f9f7f1;
width: 80%;
height: 550px;
}

#matching > div {
width: 20%;
margin-right: 2%;
}

#sport {
width: 80%;
height: 50px;
border-radius: 10px;
text-align: center;
padding: 3%;
}

#area1, #area2 {
width: 80%;
height: 50px;
border-radius: 10px;
text-align: center;
padding: 3%;
}

#area2 {
margin-top: 28.5%;
}

#datepicker {
width: 100%;
height: 50px;
border-radius: 10px;
text-align: center;
padding: 3%;
border: solid 1px gray;
}

#matching {
width: 60%;
display: flex;
height: 150px;
background-color: white;
position: relative;
top: -350px;
border-radius: 30px;
box-shadow: 0px 0px 10px #dedede;
}

.tbl-content{
  background-color: white;
  overflow-x:auto;
  margin-top: 0px;
  border: 1px solid rgba(255,255,255,0.3);
}

.matchingTable th{
  padding: 20px 15px !important;
  text-align: center;
  font-weight: bold;
  font-size: 18px;
  color: white;
  text-transform: uppercase;
  background-color: #004d99;
  opacity: 0.4;
}

.matchingTable th:nth-child(1){
  border-top-left-radius: 10px;
}

.matchingTable th:nth-child(4){
border-top-right-radius: 10px;
}

.matchingTable td{
  padding: 15px;
  text-align: center;
  vertical-align:middle;
  font-size: 18px;
  border-top: solid 1px gray;
  border-bottom: solid 1px gray;
  height: 80px;
  
}

</style>

<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/i18n/jquery-ui-i18n.min.js"></script>
<script type="text/javascript">
$( function() {
	$.datepicker.setDefaults($.datepicker.regional['ko']);
    $( "#datepicker" ).datepicker({dateFormat: 'yy-mm-dd', minDate: 0});
    
  } );
</script>

<div id="container" align="center">
	<div id="topImg" align="right">
		<img src="<%=ctxPath %>/resources/images/narae/main_visual_img_new01.png" style="width: 50%;"/>
	</div>
	<div style="font-size: 40pt; font-weight: bolder; position: relative; top: -400px; left: -320px;">매치 등록하기</div>
	<div id="matching" style="padding-left: 3%; padding-top: 1%;">
		<div id="sportdiv">
			<div align="left" style="margin: 10% 0 3% 15%; font-weight: bold;">종목</div>
			<div>
				<select name="sport" id="sport">
		    		<option value="1">축구</option>
			        <option value="2">야구</option>
			        <option value="3">배구</option>
			        <option value="4">농구</option>
			        <option value="5">테니스</option>
			        <option value="6">볼링</option>
			        <option value="7">족구</option>
			        <option value="8">배드민턴</option>
		      	</select>
			</div>
		</div>
		<div id="areadiv" style="width: 35%; display: flex;">
			<div style="width: 50%;">
				<div align="left" style="margin: 11% 0 4% 15%; font-weight: bold;">지역</div>
				<div>
					<select name="area1" id="area1">
			    		<option value="1">지역1</option>
				        <option value="2">지역2</option>
				        <option value="3">지역3</option>
				        <option value="4">지역4</option>
			      	</select>
				</div>
			</div>
			<div style="width: 50%;">
				<div>
					<select name="area2" id="area2">
			    		<option value="1">지역1</option>
				        <option value="2">지역2</option>
				        <option value="3">지역3</option>
				        <option value="4">지역4</option>
			      	</select>
				</div>
			</div>
		</div>
		<div id="timediv">
			<div align="left" style="margin: 10% 0 3% 15%; font-weight: bold;">날짜</div>
			<input type="text" id="datepicker" placeholder="선택하세요">
		</div>
		<div><button type="button" class="btn btn-success btn-lg" style="margin-top: 25%;">등록하기</button></div>
	</div>

	<div id="bottom" style="width: 80%; min-height: 700px; margin-top: -10%; margin-bottom: 5%;">
		<div style="text-align: left; font-weight: bold; font-size: 20pt; margin: 0 0 1% 12%;">2024 - 08 - 09</div>
		<div class="tbl-header">
		  <table class="matchingTable" cellpadding="0" cellspacing="0" border="0" style="width: 80%;">
		    <thead>
		      <tr>
		        <th style="width: 10%;">매치 시간</th>
				<th style="width: 35%;">상대팀</th>
				<th style="width: 30%;">장소</th>
				<th style="width: 25%;">매칭 여부</th>
		      </tr>
		    </thead>
		  </table>
		</div>
		<div class="tbl-content">
		<table class="matchingTable" cellpadding="0" cellspacing="0" border="0" style="width: 80%;">
		    <tbody>
		      <tr>
				<td style="width: 10%;">14:30</td>
				<td style="width: 35%;">마산쌍칼</td>
				<td style="width: 30%;">동작구 체육관</td>
				<td style="width: 25%;"><button type="button" class="btn btn-primary" style="width: 60%;">매치 신청하기</button></td>
			  </tr>
			  <tr>
			    <td style="width: 10%;">15:00</td>
				<td style="width: 35%;">마포 이지윤과 아이들</td>
				<td style="width: 30%;">쌍용교육센터 체육관</td>
				<td style="width: 25%;"><button type="button" class="btn btn-light" style="width: 60%;">수락 대기 중</button></td>
			  </tr>
			  <tr>
			    <td style="width: 10%;">17:00</td>
				<td style="width: 35%;">공릉 불꽃 스파이크</td>
				<td style="width: 30%;">동해 해수욕장</td>
				<td style="width: 25%;"><button type="button" class="btn btn-secondary" style="width: 30%;">마감</button></td>
			  </tr>
		    </tbody>
		</table>
		</div>
	</div>

</div>