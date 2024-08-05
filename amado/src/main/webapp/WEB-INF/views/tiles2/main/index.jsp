<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
   String ctxPath = request.getContextPath();
%>

<style type="text/css">
    .podium {
        display: flex;
        justify-content: space-around;
        align-items: flex-end;
        margin: 20px 0;
    }
    .podium-item {
        text-align: center;
        position: relative;
    }
    .podium-rank {
        position: absolute;
        width: 100%;
        top: -50px;
        font-size: 20px;
        font-weight: bold;
    }
    .podium-img {
        width: 150px;
        height: 150px;
        border-radius: 50%;
    }
    .podium-1st {
        height: 200px;
    }
    .podium-2nd,
    .podium-3rd {
        height: 150px;
    }
</style>

<script type="text/javascript">

$(document).ready(function(){
	
    var urlParams = new URLSearchParams(window.location.search);
    var scrollTo = urlParams.get('scrollTo');
    
    if (scrollTo) {
        scrollToSection(scrollTo);
    }
    if (${empty requestScope.params}) {
    	mainClubRankF(1);    
    }
});

function scrollToSection(sectionId) {
    var section = document.getElementById(sectionId);
    if (section) {
        section.scrollIntoView({ behavior: 'auto' });
    }
}

function mainClubRank(sportseq) {
	location.href = '<%=ctxPath %>/club/mainClubRank.do?sportseq=' + sportseq + '&scrollTo=rankSection';
}

function mainClubRankF(sportseq) {
	location.href='<%=ctxPath %>/club/mainClubRank.do?sportseq='+sportseq;
}

function goView(clubseq, fk_sportseq) {
	location.href = "<%=ctxPath%>/club/myClub_plus.do?clubseq="+clubseq+"&sportseq="+fk_sportseq;
}

</script>

<!doctype html>
<html lang="ko">
  <head>
  <meta charset="utf-8">
    <title>CSS</title>
    <style>
      body { padding: 0px; margin: 0px; }
      .jb-box { width: 100%; height: 1000px; overflow: hidden;margin: 0px auto; position: relative; }
      video { width: 100%; }
      .jb-text { position: absolute; top: 50%; width: 100%; }
      .jb-text p { margin-top: -24px; text-align: center; font-size: 48px; color: #ffffff; }
    </style>
  </head>
  <body>
    <div class="jb-box">
      <video muted autoplay loop>
        <source src="<%=ctxPath%>/resources/videos/nike.mp4" type="video/mp4">
        <strong>Your browser does not support the video tag.</strong>
      </video>
      <div class="jb-text">
        <p></p>
      </div>
    </div>
    
    
    <div id="ksjMain">
    
    <c:if test="${empty requestScope.params || requestScope.params == '1'}">
       <div style="text-align: center; margin: 5% 0 4% 0; font-size: 30pt; font-weight: bolder;">축구 동호회 랭킹</div>
    </c:if>
    <c:if test="${requestScope.params == '2'}">
       <div style="text-align: center; margin: 5% 0 4% 0; font-size: 30pt; font-weight: bolder;">야구 동호회 랭킹</div>
    </c:if>
    <c:if test="${requestScope.params == '3'}">
       <div style="text-align: center; margin: 5% 0 4% 0; font-size: 30pt; font-weight: bolder;">배구 동호회 랭킹</div>
    </c:if>
    <c:if test="${requestScope.params == '4'}">
       <div style="text-align: center; margin: 5% 0 4% 0; font-size: 30pt; font-weight: bolder;">농구 동호회 랭킹</div>
    </c:if>
    <c:if test="${requestScope.params == '6'}">
       <div style="text-align: center; margin: 5% 0 4% 0; font-size: 30pt; font-weight: bolder;">테니스 동호회 랭킹</div>
    </c:if>
    <c:if test="${requestScope.params == '7'}">
       <div style="text-align: center; margin: 5% 0 4% 0; font-size: 30pt; font-weight: bolder;">볼링 동호회 랭킹</div>
    </c:if>
    <c:if test="${requestScope.params == '5'}">
       <div style="text-align: center; margin: 5% 0 4% 0; font-size: 30pt; font-weight: bolder;">족구 동호회 랭킹</div>
    </c:if>
    <c:if test="${requestScope.params == '8'}">
       <div style="text-align: center; margin: 5% 0 4% 0; font-size: 30pt; font-weight: bolder;">배드민턴 동호회 랭킹</div>
    </c:if>
    
	 	<div style="width: 100%; height: 200px; margin-bottom: 3%;" align="center">
			<div style="background-color: #f2f2f2; width: 80%; height: 200px; border-radius: 15px; display: flex; justify-content: space-between; padding: 1.3%;">
				<div class="cards" id="1" onclick="mainClubRank('1')" style="width: 10%; height: 150px; background-color: white; border-radius: 15px; padding-top: 1%;">
				    <img width="70%" height="70%" src="https://img.icons8.com/emoji/96/soccer-ball-emoji.png" alt="soccer-ball-emoji"/>
				    <div style="font-weight: bold;">축구</div>
				</div>
				<div class="cards" id="2" onclick="mainClubRank('2')" style="width: 10%; height: 150px; background-color: white; border-radius: 15px; padding-top: 1%;">
				    <img width="70%" height="70%" src="https://img.icons8.com/emoji/96/baseball-emoji.png" alt="baseball-emoji"/>
				    <div style="font-weight: bold;">야구</div>
				</div>
				<div class="cards" id="3" onclick="mainClubRank('3')" style="width: 10%; height: 150px; background-color: white; border-radius: 15px; padding-top: 1%;">
				    <img width="70%" height="70%" src="https://img.icons8.com/emoji/96/volleyball-emoji.png" alt="volleyball-emoji"/>
				    <div style="font-weight: bold;">배구</div>
				</div>
				<div class="cards" id="4" onclick="mainClubRank('4')" style="width: 10%; height: 150px; background-color: white; border-radius: 15px; padding-top: 1%;">
				    <img width="70%" height="70%" src="https://img.icons8.com/emoji/96/basketball-emoji.png" alt="basketball-emoji"/>
				    <div style="font-weight: bold;">농구</div>
				</div>
				<div class="cards" id="5" onclick="mainClubRank('5')" style="width: 10%; height: 150px; background-color: white; border-radius: 15px; padding-top: 1%;">
				    <img width="70%" height="70%" src="https://img.icons8.com/office/96/beach-ball.png" alt="beach-ball"/>
				    <div style="font-weight: bold;">족구</div>
				</div>
				<div class="cards" id="6" onclick="mainClubRank('6')" style="width: 10%; height: 150px; background-color: white; border-radius: 15px; padding-top: 1%;">
				    <img width="70%" height="70%" src="https://img.icons8.com/emoji/96/tennis-emoji.png" alt="tennis-emoji"/>
				    <div style="font-weight: bold;">테니스</div>
				</div>
				<div class="cards" id="7" onclick="mainClubRank('7')" style="width: 10%; height: 150px; background-color: white; border-radius: 15px; padding-top: 1%;">
				    <img style="margin: 6% 0;" width="57%" height="57%" src="https://img.icons8.com/external-smashingstocks-flat-smashing-stocks/96/external-Bowling-casino-smashingstocks-flat-smashing-stocks-3.png" alt="external-Bowling-casino-smashingstocks-flat-smashing-stocks-3"/>
				    <div style="font-weight: bold;">볼링</div>
				</div>
				<div class="cards" id="8" onclick="mainClubRank('8')" style="width: 10%; height: 150px; background-color: white; border-radius: 15px; padding-top: 1%;">
				    <img style="margin: 5% 0;" width="55%" height="55%" src="https://img.icons8.com/3d-fluency/96/shuttercock.png" alt="shuttercock"/>
				    <div style="font-weight: bold;">배드민턴</div>
				</div>
			</div>
		</div>
		
		<div id="rankSection">
			<div class="podium" style="margin-top: 120px;">
			
				<%-- 2등 시작 --%>
		        <c:choose>
		            <c:when test="${not empty rankS}">
		                <div class="podium-item podium-2nd">
		                    <div class="podium-rank">2등</div>
		                    <img onclick="goView(${rankS.clubseq}, ${rankS.fk_sportseq})" src="<%=ctxPath %>/resources/images/zee/${rankS.clubimg}" class="podium-img" onerror="javascript:this.src='<%=ctxPath %>/resources/images/noimg.jpg'" />
		                    <div>${rankS.clubname}</div>
		                </div>
		            </c:when>
		            <c:when test="${empty rankS}">
				        <div class="podium-item podium-2nd">
				            <div class="podium-rank">2등</div>
				            <img src="<%=ctxPath %>/resources/images/noimg.jpg" class="podium-img" onerror="javascript:this.src='<%=ctxPath %>/resources/images/noimg.jpg'" />
				            <div>2등이 없습니다.</div>
				        </div>
		            </c:when>
		        </c:choose>
			    <%-- 2등 끝 --%>
			    	
			    <%-- 1등 시작 --%>	    	
		        <c:choose>
		            <c:when test="${not empty rankF}">
		                <div class="podium-item podium-1st">
		                    <div class="podium-rank">1등</div>
		                    <img onclick="goView(${rankF.clubseq}, ${rankF.fk_sportseq})" src="<%=ctxPath %>/resources/images/zee/${rankF.clubimg}" class="podium-img" onerror="javascript:this.src='<%=ctxPath %>/resources/images/noimg.jpg'" />
		                    <div>${rankF.clubname}</div>
		                </div>
		            </c:when>
		            <c:when test="${empty rankF}">
				        <div class="podium-item podium-1st">
				            <div class="podium-rank">1등</div>
				            <img src="<%=ctxPath %>/resources/images/noimg.jpg" class="podium-img" onerror="javascript:this.src='<%=ctxPath %>/resources/images/noimg.jpg'" />
				            <div>1등이 없습니다.</div>
				        </div>
		            </c:when>
		        </c:choose>
			    <%-- 1등 끝 --%>
			    
			    <%-- 3등 시작 --%>
		        <c:choose>
		            <c:when test="${not empty rankT}">
		                <div class="podium-item podium-3rd">
		                    <div class="podium-rank">3등</div>
		                    <img onclick="goView(${rankT.clubseq}, ${rankT.fk_sportseq})" src="<%=ctxPath %>/resources/images/zee/${rankT.clubimg}" class="podium-img" onerror="javascript:this.src='<%=ctxPath %>/resources/images/noimg.jpg'" />
		                    <div>${rankT.clubname}</div>
		                </div>
		            </c:when>
		            <c:when test="${empty rankT}">
				        <div class="podium-item podium-3rd">
				            <div class="podium-rank">3등</div>
				            <img src="<%=ctxPath %>/resources/images/noimg.jpg" class="podium-img" onerror="javascript:this.src='<%=ctxPath %>/resources/images/noimg.jpg'" />
				            <div>3등이 없습니다.</div>
				        </div>
		            </c:when>
		        </c:choose>
				<%-- 3등 끝 --%>
			
			</div>		
		</div>
		
    </div>
    
  </body>
</html>