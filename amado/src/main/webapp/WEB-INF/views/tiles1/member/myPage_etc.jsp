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
    
    .profileName {
    font-size: 20pt;
    font-weight: bold;
    margin-top: 1%;
    }
</style>


<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	
	// 첫화면 기본세팅
	$("button#etc").addClass('hover');
	$("#inquiry").css({"font-weight": "bold"});
	
	
	
});

</script>




<div id="container">
    <div style="border:solid 0px red;">
        <%-- 마이페이지 서브메뉴 --%>
        <div id="menu" style="border:solid 0px black; display: flex; margin-top: 3%; ">
            <div style="border:solid 0px blue; width: 50%; display: flex; margin: 0 auto;" >
                  <button id="myinfo" class='mbtn' style="border-bottom: solid 3px #05203c;" onclick="location.href='<%=ctxPath%>/member/myPage.do'"><div><img src="<%= ctxPath%>/resources/images/zee/person2.png"></div>회원정보</button>
                  <button id="myclub" class='mbtn' style="border-bottom: solid 3px #05203c;" onclick="location.href='<%=ctxPath%>/member/myPage_club.do'"><div><img src="<%= ctxPath%>/resources/images/zee/team.png"></div>동호회 관리</button>
                  <button id="mygym" class='mbtn' style="border-bottom: solid 3px #05203c;" onclick="location.href='<%=ctxPath%>/member/myPage_gymview.do'"><div><img style="height:65px;"src="<%= ctxPath%>/resources/images/zee/court.png"></div>체육관 관리</button>
                  <button id="etc" class='mbtn' style="border-bottom: solid 3px #05203c;" onclick="location.href='<%=ctxPath%>/member/myPage_etc.do'"><div><img src="<%= ctxPath%>/resources/images/zee/etc.png"></div>기타</button>
            </div>
        </div>
         
        <br>
        
        <div>
	       <div id="hr2-container">
	            <div id="hrbtns">
	                <button id="inquiry" class='btn2'>팀원 소개</button>
	            </div>
	        </div>

	       
	        <div>
	            <div id="content1" style=" width: 50%;  margin: 3% auto;" >
	                <div class="item1">&nbsp;팀원 소개</div>
	                <hr class="hr1">
	            </div>
	            
          		<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel" style="width: 50%; margin: 3% auto;">
				  <ol class="carousel-indicators">
				    <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
				    <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
				    <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
				    <li data-target="#carouselExampleIndicators" data-slide-to="3"></li>
				    <li data-target="#carouselExampleIndicators" data-slide-to="4"></li>
				  </ol>
				  <div class="carousel-inner">
				    <div class="carousel-item active">
				        <div id="nr" style="background-color: #fef0d7; height: 500px; padding: 3% 0; border-radius: 30px;" align="center">
							<div style="background-color: white; width: 15%; hieght: 80px; border-radius: 100%;"><img style="width: 100%;" src="<%=ctxPath%>/resources/images/narae/sweets_purin_taberu_woman.png"/></div>
							<div class="profileName">이나래</div>
							<div style="background-color: #e0edf0; border-radius: 10px; padding: 0.5%; width: 7%;">팀장</div>
							<div style="background-color: white; border-radius: 20px; width: 70%; height: 150px; margin-top: 2%; color: black; align-content: center; text-align: center; padding: 2%;">
							배운 내용을 스스로 활용해보면서 저의 부족한 부분을 확인해볼 수 있는<br>소중한 시간이었습니다. 이번 경험을 초석으로 삼아 조금 더 발전된 프로젝트를<br>준비해보고 싶습니다. 아쉬움도, 후회도 많이 남지만 그만큼 배운 것이 많은 프로젝트라<br>뿌듯함이 큽니다. 팀장으로서 부족했음에도 믿고 응원해준 팀원들에게 감사드립니다.
							</div>
						</div>
				    </div>
				    <div class="carousel-item">
				        <div id="sj" style="background-color: #66ccff; height: 500px; padding: 3% 0; border-radius: 30px;" align="center">
							<div style="background-color: white; width: 15%; hieght: 80px; border-radius: 100%;"><img style="width: 100%;" src="<%=ctxPath%>/resources/images/narae/flower_tsutsuji_mitsu.png"/></div>
							<div class="profileName">김승진</div>
							<div style="background-color: #e0edf0; border-radius: 10px; padding: 0.5%; width: 7%;">팀원</div>
							<div style="background-color: white; border-radius: 20px; width: 70%; height: 150px; margin-top: 2%; color: black; align-content: center; text-align: center; padding: 2%;">
							이번 프로젝트를 마무리하면서 많은 것을 배웠습니다.<br>Java 프로그래밍과 팀워크의 중요성을 깊게 이해할 수 있었고, 실무 경험을 통해<br>성장할 수 있었습니다. 함께 해준 팀원들에게 감사드리고,<br>팀장님 정말 고생이 많으셨습니다.
							</div>
						</div>      
				    </div>
				    <div class="carousel-item">
				        <div id="hs" style="background-color: #ccffcc; height: 500px; padding: 3% 0; border-radius: 30px;" align="center">
							<div style="background-color: white; width: 15%; hieght: 80px; border-radius: 100%;"><img style="width: 100%;" src="<%=ctxPath%>/resources/images/narae/toy_norimono_car_boy.png"/></div>
							<div class="profileName">서한솔</div>
							<div style="background-color: #e0edf0; border-radius: 10px; padding: 0.5%; width: 7%;">팀원</div>
							<div style="background-color: white; border-radius: 20px; width: 70%; height: 150px; margin-top: 2%; color: black; align-content: center; text-align: center; padding: 2%;">
							팀 프로젝트를 하면서 협업의 중요성을 깊게 느꼈습니다.<br>기술적인 도전과 문제 해결을 통해 많은 것을 배웠고, 팀원들과의 협력 덕분에<br>성공적으로 프로젝트를 완료할 수 있었습니다. 특히 많은 노력을 기울이신 팀장님께<br>깊은 감사의 마음을 전합니다.<br>팀장님의 헌신과 리더십 덕분에 잘 마무리 할 수  있었습니다.
							</div>
						</div>	      
				    </div>
				    <div class="carousel-item">
				        <div id="jy" style="background-color: #e0e0d1; height: 500px; padding: 3% 0; border-radius: 30px;" align="center">
							<div style="background-color: white; width: 15%; hieght: 80px; border-radius: 100%;"><img style="width: 100%;" src="<%=ctxPath%>/resources/images/narae/sweets_peropero_candy_girl.png"/></div>
							<div class="profileName">이지윤</div>
							<div style="background-color: #e0edf0; border-radius: 10px; padding: 0.5%; width: 7%;">팀원</div>
							<div style="background-color: white; border-radius: 20px; width: 70%; height: 150px; margin-top: 2%; color: black; align-content: center; text-align: center; padding: 2%;">
							실제 프로젝트를 통해 개발 과정에서 구상한 결과물을 직접 구현하는 경험을<br>쌓을 수 있었고, 주어진 자원과 시간을 고려하며 프로젝트를 진행하는 법도 배웠습니다.<br>특히, 혼자가 아닌 팀으로 일하는 것이 얼마나 중요한지 다시 한번 느꼈으며,<br>함께 프로젝트를 완수한 팀원들에게 진심으로 감사의 마음을 전합니다.
							</div>
						</div>	      
				    </div>
				    <div class="carousel-item">
				        <div id="jh" style="background-color: #cccccc; height: 500px; padding: 3% 0; border-radius: 30px;" align="center">
							<div style="background-color: white; width: 15%; hieght: 80px; border-radius: 100%;"><img style="width: 100%;" src="<%=ctxPath%>/resources/images/narae/taiiku_boushi_tate.png"/></div>
							<div class="profileName">최준혁</div>
							<div style="background-color: #e0edf0; border-radius: 10px; padding: 0.5%; width: 7%;">팀원</div>
							<div style="background-color: white; border-radius: 20px; width: 70%; height: 150px; margin-top: 2%; color: black; align-content: center; text-align: center; padding: 2%;">
							프로젝트를 통해 팀원들과의 의사소통이 중요하다는 것을 깨닫는 계기가 되었고,<br>처음 DB설계를 할 때 확실히 해야 한다는 것을 알게 됐습니다. 또한 프로젝트를<br>진행하면서 전체적인 로직에 대해 이해할 수 있었고 열심히 해준 팀원들 덕분에<br>좋은 결과물이 나올 수 있었던 것 같습니다. 감사합니다.
							</div>
						</div>      
				    </div>
				  </div>
				  <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
				    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
				    <span class="sr-only">Previous</span>
				  </a>
				  <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
				    <span class="carousel-control-next-icon" aria-hidden="true"></span>
				    <span class="sr-only">Next</span>
				  </a>
				</div>
	            
	        </div>
    	</div> 
    	
    </div>
</div>
