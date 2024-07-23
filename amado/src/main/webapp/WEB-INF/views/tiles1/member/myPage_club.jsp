<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<% String ctxPath = request.getContextPath(); %> 

<style type="text/css">

    .mbtn{
        font-weight: bold;
        height: 100px;
        margin-inline-end: .25rem;
        background-color: white; 
        border: none; 
        color: gray;
        width: 40%;
        cursor: pointer;
        transition: box-shadow 0.3s ease; /* 호버 시 부드러운 전환 효과 */
    }

    .mbtn:hover {
        color: #05203c; 
    }

    .hr1{
        border-style:none; 
        height: 2px; 
        background-color : lightgray;
    }
    .item1{
        border-left: solid 3px #05203c;
    }

    #hr2-container {
        position: relative;
        height: 40px;
        background-color : #98b6d5;
        display: flex;
        justify-content: center;
        align-items: center;
    }
    #hrbtns{
    border: solid 0px red;
    margin-right:1.5%;
        display: flex;
        gap: 70px; /* Adjust the gap between buttons */
        position: absolute;
        z-index: 1;
    }
    .btn2{
    font-size: 14px;
        cursor: pointer;
        border: none;
        background-color: inherit;
    }
    
    .hover {
    color: #05203c; 
    font-weight: bold;
    }
    
    .title {
     width: 15%;
     background-color: #4db8ff; 
     color: white; 
     font-weight: bold; 
     align-content: center; 
     text-align: center; 
     height: 40px; 
     border-radius: 15px;
     margin-right: 3%;
    }
    
    .tr{
    align-content: center;
    margin-bottom: 1%;
    }
    
    .select {
    width: 20%;
    }
    
    select {
    width: 30%;
    height: 40px;
    text-align: center;
    border-radius: 10px;
    }
    
    .btnInfoChange {
    font-size: 8pt;
    margin-left: 3%;
    }
    
    .input {
    width: 70%;
    }
    
    #memberInfo input {
    height: 40px;
    border-radius: 10px;
    align-content: center;
    padding-left: 1%;
    border: solid 1px gray;
    }
    
    .sportCard {
    width: 100%;
    height: 350px;
    border-radius: 20px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
  	transition: all 0.3s cubic-bezier(.25,.8,.25,1);
  	position: relative;
  	z-index: 1;
    }
    
    .sportCard:hover {
  	box-shadow: 0 14px 28px rgba(0,0,0,0.25), 0 10px 10px rgba(0,0,0,0.22);
	}
    
    #top, #bottom {
    width: 80%;
    justify-content: space-between;
    }
    
    .card {
    width: 23%;
    height: 350px;
    cursor: pointer;
    border: none;
	}
    
	.back {
	border-radius: 20px;
	background-color: #fefeec;
	text-align: center;
	width: 100%;
	height: 350px;
	position: absolute;
	z-index: 0;
	top: 0px;
	align-content: center;
	}
	
	.shadow {
	box-shadow: 0 14px 28px rgba(0,0,0,0.25), 0 10px 10px rgba(0,0,0,0.22);
	}
	
	.sportname {
	font-size: 20pt;
	font-weight: bold;
	}
	
	.back div {
	margin-bottom: 1%;
	}
</style>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script type="text/javascript">

$(document).ready(function(){
	
	// 첫화면 기본세팅
	$("button#myclub").addClass('hover');
	$("#clubShow").css({"font-weight": "bold"});
	$("#content2").hide();
	
	// 가입 동호회 조회
	$("#clubShow").click(function(){
		
		$("#clubManage").css({"font-weight": ""});
		$("#clubShow").css({"font-weight": "bold"});
		$("#content1").show();
		$("#content2").hide();
		
	});
	
	
	
	// 내 동호회 조회
	$("#clubManage").click(function(){
		
		$("#clubShow").css({"font-weight": ""});
		$("#clubManage").css({"font-weight": "bold"});
		$("#content2").show();
		$("#content1").hide();
		
	});
	
	
	
	// 클릭이벤트
	$(".sportCard").click(function(e){
		$(e.target).fadeOut();
	});
	
	$(".back").click(function(e){
		$(e.target).prev().fadeIn();
		$(e.target).prev().children().fadeIn();
	});
	
	$(".sportCard > img").click(function(e){
		$(e.target).parent().fadeOut();
	});
	
	$(".sportname").click(function(e){
		$(e.target).parent().fadeOut();
	});
	
	$(".back > div").click(function(e){
		$(e.target).parent().prev().fadeIn();
		$(e.target).parent().prev().children().fadeIn();
	});	
	
	$(".back > div > img").click(function(e){
		$(e.target).parent().parent().prev().fadeIn();
		$(e.target).parent().parent().prev().children().fadeIn();
	});	
	
});


function quitClub(clubseq, userid){
	Swal.fire({
		  title: "정말 탈퇴하시겠습니까?",
		  icon: "warning",
		  showCancelButton: true,
		  confirmButtonColor: "#3085d6",
		  cancelButtonColor: "#d33",
		  confirmButtonText: "네, 탈퇴합니다.",
		  cancelButtonText: "취소"		  
		}).then((result) => {
		  if (result.isConfirmed) {
		    
			  
			  $.ajax({
				  url: "<%=ctxPath%>/member/quitClub.do",
				  data: {"clubseq": clubseq, "userid": userid},
				  type: "post",
				  dataType: "json",
				  success: function(json){
					  
					  if(json.n == 1){
						  Swal.fire({
						      title: "탈퇴 완료!",
						      icon: "success"
						    }).then(okay => {
								  if (okay) {
									  location.reload(true);
									  }
							  });;
					  }
					  
				  },
				  error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				  }
			  });
			  
			  
		  Swal.fire({
		      title: "Deleted!",
		      text: "Your file has been deleted.",
		      icon: "success"
		    });
		  
		  
		  
		  
		  
		  
		  }
		});
}
</script>




<div id="container">
    <div style="border:solid 0px red;">
        <%-- 마이페이지 서브메뉴 --%>
        <div id="menu" style="border:solid 0px black; display: flex; margin-top: 3%; ">
            <div style="border:solid 0px blue; width: 50%; display: flex; margin: 0 auto;" >
                  <button id="myinfo" class='mbtn' style="border-bottom: solid 3px #05203c;" onclick="location.href='<%=ctxPath%>/member/myPage.do'"><div><img src="<%= ctxPath%>/resources/images/zee/person2.png"></div>회원정보</button>
                  <button id="myclub" class='mbtn' style="border-bottom: solid 3px #05203c;" onclick="location.href='<%=ctxPath%>/member/myPage_club.do'"><div><img src="<%= ctxPath%>/resources/images/zee/team.png"></div>동호회 관리</button>
                  <button id="mygym" class='mbtn' style="border-bottom: solid 3px #05203c;" onclick="location.href='<%=ctxPath%>/member/myPage_gym.do'"><div><img style="height:65px;"src="<%= ctxPath%>/resources/images/zee/court.png"></div>체육관 관리</button>
                  <button id="etc" class='mbtn' style="border-bottom: solid 3px #05203c;" onclick="location.href='<%=ctxPath%>/member/myPage_etc.do'"><div><img src="<%= ctxPath%>/resources/images/zee/etc.png"></div>기타</button>
            </div>
        </div>
         
        <br>
        
        <div>
	       <div id="hr2-container">
	            <div id="hrbtns">
	                <button id="clubShow" class='btn2'>가입 동호회 조회</button>
	                <button id="clubManage" class='btn2'>내 동호회 관리</button>
	            </div>
	        </div>

	       
	        <div>
	           	<div id="content1" style="width: 80%; margin: 3% auto;" >
	                <div class="item1" style="margin-left: 10%;">&nbsp;가입 동호회 조회</div>
	                <hr class="hr1" style="width: 80%;">
	                <div id="memberInfo" align="center">
	                	<div id="top" style="display: flex; margin-bottom: 3%;">
	                		<div class="card">
	                			<div class="sportCard" style="background-color: #ffb3b3;">
	                				<img width="190" height="190" style="margin-top: 15%;" src="https://img.icons8.com/emoji/190/soccer-ball-emoji.png" alt="soccer-ball-emoji"/>
	                				<div class="sportname">축구</div>
	                			</div>
	                			<div class="back" align="center" style="padding: 10% 0;">
	                				<c:if test="${not empty requestScope.soccer}">
		                				<div id="clubname" style="font-size: 15pt; font-weight: bold; margin-bottom: 5%;">${requestScope.soccer.clubname }</div>
										<div style="width: 100%;" align="center"><img style="width: 50%;" src="<%=ctxPath%>/resources/images/zee/${requestScope.soccer.clubimg}"/></div>
										<div style="font-size: 10pt;">${requestScope.soccer.city}&nbsp;${requestScope.soccer.local}</div>
										<div style="font-size: 13pt;">${requestScope.soccer.clubgym}</div>
										<div style="font-size: 11pt;">${requestScope.soccer.clubtel}</div>
										<button type="button" class="btn btn-info" onclick="quitClub('${requestScope.soccer.clubseq}', '${sessionScope.loginuser.userid}')">탈퇴하기</button>
									</c:if>
									<c:if test="${empty requestScope.soccer}">가입된 동호회가 없습니다!</c:if>
	                			</div>
	                		</div>
	                		<div class="card">
	                			<div class="sportCard" style="background-color: #ffccb3;">
	                				<img width="190" height="190" style="margin-top: 15%;" src="https://img.icons8.com/emoji/190/baseball-emoji.png" alt="baseball-emoji"/>
	                				<div class="sportname">야구</div>
	                			</div>
	                			<div class="back">
									<c:if test="${not empty requestScope.baseball}">
		                				<div style="font-size: 15pt; font-weight: bold; margin-bottom: 5%;">${requestScope.baseball.clubname }</div>
										<div style="width: 100%;" align="center"><img style="width: 50%;" src="<%=ctxPath%>/resources/images/zee/${requestScope.baseball.clubimg}"/></div>
										<div style="font-size: 10pt;">${requestScope.baseball.city}&nbsp;${requestScope.baseball.local}</div>
										<div style="font-size: 13pt;">${requestScope.baseball.clubgym}</div>
										<div style="font-size: 11pt;">${requestScope.baseball.clubtel}</div>
										<button type="button" class="btn btn-info" onclick="quitClub('${requestScope.baseball.clubseq}', '${sessionScope.loginuser.userid}')">탈퇴하기</button>
									</c:if>
									<c:if test="${empty requestScope.baseball}">가입된 동호회가 없습니다!</c:if>
								</div>
	                		</div>
	                		<div class="card">
	                			<div class="sportCard" style="background-color: #ffe6b3;">
	                				<img width="190" height="190" style="margin-top: 15%;" src="https://img.icons8.com/emoji/190/volleyball-emoji.png" alt="volleyball-emoji"/>
									<div class="sportname">배구</div>
	                			</div>
	                			<div class="back">
	                				<c:if test="${not empty requestScope.volley}">
		                				<div style="font-size: 15pt; font-weight: bold; margin-bottom: 5%;">${requestScope.volley.clubname }</div>
										<div style="width: 100%;" align="center"><img style="width: 50%;" src="<%=ctxPath%>/resources/images/zee/${requestScope.volley.clubimg}"/></div>
										<div style="font-size: 10pt;">${requestScope.volley.city}&nbsp;${requestScope.volley.local}</div>
										<div style="font-size: 13pt;">${requestScope.volley.clubgym}</div>
										<div style="font-size: 11pt;">${requestScope.volley.clubtel}</div>
										<button type="button" class="btn btn-info" onclick="quitClub('${requestScope.volley.clubseq}', '${sessionScope.loginuser.userid}')">탈퇴하기</button>
									</c:if>
									<c:if test="${empty requestScope.volley}">가입된 동호회가 없습니다!</c:if>
	                			</div>
	                		</div>
	                		<div class="card">
	                			<div class="sportCard" style="background-color: #e0f2bf;">
	                				<img width="190" height="190" style="margin-top: 15%;" src="https://img.icons8.com/emoji/190/basketball-emoji.png" alt="basketball-emoji"/>
									<div class="sportname">농구</div>
	                			</div>
	                			<div class="back">
	                				<c:if test="${not empty requestScope.basket}">
		                				<div style="font-size: 15pt; font-weight: bold; margin-bottom: 5%;">${requestScope.basket.clubname }</div>
										<div style="width: 100%;" align="center"><img style="width: 50%;" src="<%=ctxPath%>/resources/images/zee/${requestScope.basket.clubimg}"/></div>
										<div style="font-size: 10pt;">${requestScope.basket.city}&nbsp;${requestScope.basket.local}</div>
										<div style="font-size: 13pt;">${requestScope.basket.clubgym}</div>
										<div style="font-size: 11pt;">${requestScope.basket.clubtel}</div>
										<button type="button" class="btn btn-info" onclick="quitClub('${requestScope.basket.clubseq}', '${sessionScope.loginuser.userid}')">탈퇴하기</button>
									</c:if>
									<c:if test="${empty requestScope.basket}">가입된 동호회가 없습니다!</c:if>
	                			</div>
	                		</div>
	                	</div>
	                	<div id="bottom" style="display: flex;">
							<div class="card">
								<div class="sportCard" style="background-color: #d6eeaa;">
									<img width="190" height="190" style="margin-top: 15%;" src="https://img.icons8.com/emoji/190/tennis-emoji.png" alt="tennis-emoji"/>
									<div class="sportname">테니스</div>
								</div>
								<div class="back">
									<c:if test="${not empty requestScope.tennis}">
		                				<div style="font-size: 15pt; font-weight: bold; margin-bottom: 5%;">${requestScope.tennis.clubname }</div>
										<div style="width: 100%;" align="center"><img style="width: 50%;" src="<%=ctxPath%>/resources/images/zee/${requestScope.tennis.clubimg}"/></div>
										<div style="font-size: 10pt;">${requestScope.tennis.city}&nbsp;${requestScope.tennis.local}</div>
										<div style="font-size: 13pt;">${requestScope.tennis.clubgym}</div>
										<div style="font-size: 11pt;">${requestScope.tennis.clubtel}</div>
										<button type="button" class="btn btn-info" onclick="quitClub('${requestScope.tennis.clubseq}', '${sessionScope.loginuser.userid}')">탈퇴하기</button>
									</c:if>
									<c:if test="${empty requestScope.tennis}">가입된 동호회가 없습니다!</c:if>
								</div>
							</div>
							<div class="card">
								<div class="sportCard" style="background-color: #cce6ff;">
									<img width="160" height="160" style="margin: 21% 0 5% 0;" src="https://img.icons8.com/external-smashingstocks-flat-smashing-stocks/180/external-Bowling-casino-smashingstocks-flat-smashing-stocks-3.png" alt="external-Bowling-casino-smashingstocks-flat-smashing-stocks-3"/>
									<div class="sportname">볼링</div>
								</div>
								<div class="back">
									<c:if test="${not empty requestScope.bowling}">
		                				<div style="font-size: 15pt; font-weight: bold; margin-bottom: 5%;">${requestScope.bowling.clubname }</div>
										<div style="width: 100%;" align="center"><img style="width: 50%;" src="<%=ctxPath%>/resources/images/zee/${requestScope.bowling.clubimg}"/></div>
										<div style="font-size: 10pt;">${requestScope.bowling.city}&nbsp;${requestScope.bowling.local}</div>
										<div style="font-size: 13pt;">${requestScope.bowling.clubgym}</div>
										<div style="font-size: 11pt;">${requestScope.bowling.clubtel}</div>
										<button type="button" class="btn btn-info" onclick="quitClub('${requestScope.bowling.clubseq}', '${sessionScope.loginuser.userid}')">탈퇴하기</button>
									</c:if>
									<c:if test="${empty requestScope.bowling}">가입된 동호회가 없습니다!</c:if>
								</div>
							</div>
							<div class="card">
								<div class="sportCard" style="background-color: #b3ccff;">
									<img width="160" height="160" style="margin: 21% 0 5% 0;" src="https://img.icons8.com/3d-fluency/160/beach-ball.png" alt="beach-ball"/>
									<div class="sportname">족구</div>
								</div>
								<div class="back">
									<c:if test="${not empty requestScope.jokgu}">
		                				<div style="font-size: 15pt; font-weight: bold; margin-bottom: 5%;">${requestScope.jokgu.clubname }</div>
										<div style="width: 100%;" align="center"><img style="width: 50%;" src="<%=ctxPath%>/resources/images/zee/${requestScope.jokgu.clubimg}"/></div>
										<div style="font-size: 10pt;">${requestScope.jokgu.city}&nbsp;${requestScope.jokgu.local}</div>
										<div style="font-size: 13pt;">${requestScope.jokgu.clubgym}</div>
										<div style="font-size: 11pt;">${requestScope.jokgu.clubtel}</div>
										<button type="button" class="btn btn-info" onclick="quitClub('${requestScope.jokgu.clubseq}', '${sessionScope.loginuser.userid}')">탈퇴하기</button>
									</c:if>
									<c:if test="${empty requestScope.jokgu}">가입된 동호회가 없습니다!</c:if>
								</div>
							</div>
							<div class="card">
								<div class="sportCard" style="background-color: #dbc6eb;">
									<img width="160" height="160" style="margin: 21% 0 5% 0;" src="https://img.icons8.com/3d-fluency/190/shuttercock.png" alt="shuttercock"/>
									<div class="sportname">배드민턴</div>
								</div>
								<div class="back">
									<c:if test="${not empty requestScope.minton}">
		                				<div style="font-size: 15pt; font-weight: bold; margin-bottom: 5%;">${requestScope.minton.clubname }</div>
										<div style="width: 100%;" align="center"><img style="width: 50%;" src="<%=ctxPath%>/resources/images/zee/${requestScope.minton.clubimg}"/></div>
										<div style="font-size: 10pt;">${requestScope.minton.city}&nbsp;${requestScope.minton.local}</div>
										<div style="font-size: 13pt;">${requestScope.minton.clubgym}</div>
										<div style="font-size: 11pt;">${requestScope.minton.clubtel}</div>
										<button type="button" class="btn btn-info" onclick="quitClub('${requestScope.minton.clubseq}', '${sessionScope.loginuser.userid}')">탈퇴하기</button>
									</c:if>
									<c:if test="${empty requestScope.minton}">가입된 동호회가 없습니다!</c:if>
								</div>
							</div>
	                	</div>
	                </div>
	                
	            </div>
	            
	            
	            
	            <div id="content2" style="border:solid 1px red; width: 50%;  margin: 3% auto;" >
	                <div class="item1">&nbsp;내 동호회 관리</div>
	                <hr class="hr1">
	                <div id="memberInfo">
	                	
	                </div>
	                
	            </div>
		            
	        </div>
    	</div> 
    	
    </div>
</div>
