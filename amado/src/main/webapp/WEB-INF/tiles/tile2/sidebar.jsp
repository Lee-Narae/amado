<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
%>

<style type="text/css">
.sport {
height: 102px;
padding-top: 15%;
text-align: center;
background-color: #f7fbfd;
}

.sport:hover {
background-color: #d9d9d9;
cursor: pointer;
}

.name {
font-size: 11pt;
font-weight: bold;
margin-top: 2%;
}

</style>

<div class="sport" onclick="location.href='?sportseq=1'">
	<img width="55%" height="55%" src="https://img.icons8.com/emoji/96/soccer-ball-emoji.png" alt="soccer-ball-emoji"/>
	<div class="name">축구</div>
</div>
<div class="sport" onclick="location.href='?sportseq=2'">
	<img width="55%" height="55%" src="https://img.icons8.com/emoji/96/baseball-emoji.png" alt="baseball-emoji"/>
	<div class="name">야구</div>
</div>
<div class="sport" onclick="location.href='?sportseq=3'">
	<img width="55%" height="55%" src="https://img.icons8.com/emoji/96/volleyball-emoji.png" alt="volleyball-emoji"/>
	<div class="name">배구</div>
</div>
<div class="sport" onclick="location.href='?sportseq=4'">
	<img width="55%" height="55%" src="https://img.icons8.com/emoji/96/basketball-emoji.png" alt="basketball-emoji"/>
	<div class="name">농구</div>
</div>
<div class="sport" onclick="location.href='?sportseq=6'">
	<img width="55%" height="55%" src="https://img.icons8.com/emoji/96/tennis-emoji.png" alt="tennis-emoji"/>
	<div class="name">테니스</div>
</div>
<div class="sport" onclick="location.href='?sportseq=7'">
	<img width="47%" height="47%" src="https://img.icons8.com/external-smashingstocks-flat-smashing-stocks/96/external-Bowling-casino-smashingstocks-flat-smashing-stocks-3.png" alt="external-Bowling-casino-smashingstocks-flat-smashing-stocks-3"/>
	<div class="name">볼링</div>
</div>
<div class="sport" onclick="location.href='?sportseq=5'">
	<img style="margin-top: 5%;" width="45%" height="45%" src="https://img.icons8.com/office/96/beach-ball.png" alt="beach-ball"/>
	<div class="name">족구</div>
</div>
<div class="sport" onclick="location.href='?sportseq=8'">
	<img width="50%" height="50%" src="https://img.icons8.com/3d-fluency/96/shuttercock.png" alt="shuttercock"/>
	<div class="name">배드민턴</div>
</div>