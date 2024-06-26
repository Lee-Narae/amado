<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>

<style type="text/css">

#topImg {
background-image: url('<%=ctxPath%>/resources/images/narae/Ice-and-Fire-showdown_2560x1600.jpg');
background-size: cover;
width: 80%;
height: 600px;
opacity: 0.5;
}

#matching > div {
border: solid 1px red;
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
margin-top: 27%;
}

</style>

<div id="container" align="center">
	<div id="topImg"></div>
	<div style="font-size: 40pt; font-weight: bolder; position: relative; top: -500px;">매치 등록하기</div>
	<div id="matching" style="width: 60%; display: flex; height: 150px; background-color: white; position: relative; top: -400px; border-radius: 30px;">
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
		<div style="width: 35%; display: flex;">
			<div style="border: solid 1px blue; width: 50%;">
				<div align="left" style="margin: 11% 0 3% 15%; font-weight: bold;">지역</div>
				<div>
					<select name="area1" id="area1">
			    		<option value="1">지역1</option>
				        <option value="2">지역2</option>
				        <option value="3">지역3</option>
				        <option value="4">지역4</option>
			      	</select>
				</div>
			</div>
			<div style="border: solid 1px blue; width: 50%;">
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
		<div></div>
		<div><button type="button" class="btn btn-success btn-lg" style="margin-top: 25%;">등록하기</button></div>
	</div>


</div>