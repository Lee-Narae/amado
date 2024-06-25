<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String ctxPath = request.getContextPath();
%>    

<style type="text/css">

#footer {
background-color: #254179;}

div#sns > div {
	margin-left: auto;
	cursor: pointer;
}

div#info {
	background-color: white;
	opacity: 0.6;
	border-radius: 15px;
	width: 65%;
	margin: 1% 0% 0% 10%;
	padding: 1%;
	height: 120px;
}

div#wrap {
	width: 60%;
}

div#info > span {
	font-family: 'ChosunGu';
	display: block;
}


div#info > span > span{
	font-family: 'ChosunGu';
	display: inline-block;
	width: 30%;
	text-align: center;
}

div#sns {
	width: 12%;
	margin-left: 20%;
}

div#sns > div {
	margin-right: 10%;
}

</style>

<script type="text/javascript">
function goInsta(){
	window.open("https://www.instagram.com/");
}

function goKakao(){
	window.open("https://pf.kakao.com/");
}

function goYoutube(){
	window.open("https://www.youtube.com/");
}
</script>

<footer>
	<div id="footer" style="height: 350px; display: flex; width: 95%; margin-left: 5%;">
		<div id="wrap">
			<div id="logo" style="height: 150px;"><img style="width: 90%; margin: 13% 0% 0% 40%;" src="<%=ctxPath%>/resources/images/logo.png"/></div>
			<div id="info">
			<span><span>사&nbsp;업&nbsp;자&nbsp;&nbsp;등&nbsp;록&nbsp;&nbsp;번&nbsp;호</span> │ 303-81-09535</span>
			<span><span>정&nbsp;&nbsp;&nbsp;&nbsp;보</span> │ ㈜아마두 AMADO 대표이사 서영학</span>
			<span><span>주&nbsp;&nbsp;&nbsp;&nbsp;소</span> │ 서울 마포구 월드컵북로 21 풍성빌딩 2, 3, 4층</span>
			<span><span>T&nbsp;&nbsp;e&nbsp;&nbsp;l</span> │ 02-336-8546</span>
			<br>
			<span style="color: white; opacity: 0.7; margin-top: 1.5%;">Copyright &copy; 2024 AMADO Company. All Rights Reserved.</span>
			</div>
		</div>
		<div id="sns" style="display: flex; padding-top: 0.7%; align-items: center; ">
				<div id="insta" onclick="goInsta()"><img width="70" height="70" src="https://img.icons8.com/3d-fluency/94/instagram-new.png" alt="instagram-new"/></div>
				<div id="kakao" onclick="goKakao()"><img width="70" height="70" src="https://img.icons8.com/fluency/48/kakaotalk.png" alt="kakaotalk"/></div>
				<div id="youtube" onclick="goYoutube()"><img width="70" height="70" src="https://img.icons8.com/3d-fluency/94/youtube-play.png" alt="youtube-play"/></div>
			</div>
	</div>
	
</footer>