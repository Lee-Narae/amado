<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
	
	
});


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
	 	<div style="width: 100%; height: 200px; margin-bottom: 3%;" align="center">
			<div style="background-color: #f2f2f2; width: 80%; height: 200px; border-radius: 15px; display: flex; justify-content: space-between; padding: 1.3%;">
<div class="cards" id="1" onclick="location.href='<%=ctxPath %>/club/mainClubRank.do?sportseq=1'" style="width: 10%; height: 150px; background-color: white; border-radius: 15px; padding-top: 1%;">
    <img width="70%" height="70%" src="https://img.icons8.com/emoji/96/soccer-ball-emoji.png" alt="soccer-ball-emoji"/>
    <div style="font-weight: bold;">축구</div>
</div>
<div class="cards" id="2" onclick="location.href='<%=ctxPath %>/club/mainClubRank.do?sportseq=2'" style="width: 10%; height: 150px; background-color: white; border-radius: 15px; padding-top: 1%;">
    <img width="70%" height="70%" src="https://img.icons8.com/emoji/96/baseball-emoji.png" alt="baseball-emoji"/>
    <div style="font-weight: bold;">야구</div>
</div>
<div class="cards" id="3" onclick="location.href='<%=ctxPath %>/club/mainClubRank.do?sportseq=3'" style="width: 10%; height: 150px; background-color: white; border-radius: 15px; padding-top: 1%;">
    <img width="70%" height="70%" src="https://img.icons8.com/emoji/96/volleyball-emoji.png" alt="volleyball-emoji"/>
    <div style="font-weight: bold;">배구</div>
</div>
<div class="cards" id="4" onclick="location.href='<%=ctxPath %>/club/mainClubRank.do?sportseq=4'" style="width: 10%; height: 150px; background-color: white; border-radius: 15px; padding-top: 1%;">
    <img width="70%" height="70%" src="https://img.icons8.com/emoji/96/basketball-emoji.png" alt="basketball-emoji"/>
    <div style="font-weight: bold;">농구</div>
</div>
<div class="cards" id="5" onclick="location.href='<%=ctxPath %>/club/mainClubRank.do?sportseq=5'" style="width: 10%; height: 150px; background-color: white; border-radius: 15px; padding-top: 1%;">
    <img width="70%" height="70%" src="https://img.icons8.com/office/96/beach-ball.png" alt="beach-ball"/>
    <div style="font-weight: bold;">족구</div>
</div>
<div class="cards" id="6" onclick="location.href='<%=ctxPath %>/club/mainClubRank.do?sportseq=6'" style="width: 10%; height: 150px; background-color: white; border-radius: 15px; padding-top: 1%;">
    <img width="70%" height="70%" src="https://img.icons8.com/emoji/96/tennis-emoji.png" alt="tennis-emoji"/>
    <div style="font-weight: bold;">테니스</div>
</div>
<div class="cards" id="7" onclick="location.href='<%=ctxPath %>/club/mainClubRank.do?sportseq=7'" style="width: 10%; height: 150px; background-color: white; border-radius: 15px; padding-top: 1%;">
    <img style="margin: 6% 0;" width="57%" height="57%" src="https://img.icons8.com/external-smashingstocks-flat-smashing-stocks/96/external-Bowling-casino-smashingstocks-flat-smashing-stocks-3.png" alt="external-Bowling-casino-smashingstocks-flat-smashing-stocks-3"/>
    <div style="font-weight: bold;">볼링</div>
</div>
<div class="cards" id="8" onclick="location.href='<%=ctxPath %>/club/mainClubRank.do?sportseq=8'" style="width: 10%; height: 150px; background-color: white; border-radius: 15px; padding-top: 1%;">
    <img style="margin: 5% 0;" width="55%" height="55%" src="https://img.icons8.com/3d-fluency/96/shuttercock.png" alt="shuttercock"/>
    <div style="font-weight: bold;">배드민턴</div>
</div>
			</div>
		</div>
		
		
	<div class="podium" style="margin-top: 120px;">
	
		<%-- 2등 시작 --%>
	    <c:if test="${not empty requestScope.clubList && requestScope.clubList.size() >= 2}">
	        <c:forEach var="clubvo" items="${requestScope.clubList}">
	            <c:choose>
	                <c:when test="${clubvo.rank == '2'}">
	                    <div class="podium-item podium-2nd">
	                        <div class="podium-rank">2등</div>
	                        <img onclick="goView(${clubvo.clubseq}, ${clubvo.fk_sportseq})" src="<%=ctxPath %>/resources/images/zee/${clubvo.clubimg}" class="podium-img" onerror="javascript:this.src='<%=ctxPath %>/resources/images/noimg.jpg'" />
	                        <div>${clubvo.clubname}</div>
	                    </div>
	                </c:when>
	            </c:choose>
	        </c:forEach>
	    </c:if>
	    <c:if test="${not empty requestScope.clubList && requestScope.clubList.size() < 2}">
	        <div class="podium-item podium-2nd">
	            <div class="podium-rank">2등</div>
	            <img src="<%=ctxPath %>/resources/images/noimg.jpg" class="podium-img" onerror="javascript:this.src='<%=ctxPath %>/resources/images/noimg.jpg'" />
	            <div>2등이 없습니다.</div>
	        </div>
	    </c:if>
	    <%-- 2등 끝 --%>
	    	
	    <%-- 1등 시작 --%>	    	
	    <c:if test="${not empty requestScope.clubList}">
	        <c:forEach var="clubvo" items="${requestScope.clubList}">
	            <c:choose>
	            	<c:when test="${clubvo.rank == '1'}">
	                    <div class="podium-item podium-1st">
	                        <div class="podium-rank">1등</div>
	                        <img onclick="goView(${clubvo.clubseq}, ${clubvo.fk_sportseq})" src="<%=ctxPath %>/resources/images/zee/${clubvo.clubimg}" class="podium-img" onerror="javascript:this.src='<%=ctxPath %>/resources/images/noimg.jpg'" />
	                        <div>${clubvo.clubname}</div>
	                    </div>
	                </c:when>
	            </c:choose>
	        </c:forEach>
	    </c:if>	   

	    <%-- 1등 끝 --%>
	    
	    <%-- 3등 시작 --%>
	    <c:if test="${not empty requestScope.clubList && requestScope.clubList.size() >= 3}">
	        <c:forEach var="clubvo" items="${requestScope.clubList}">
	            <c:choose>
	                <c:when test="${clubvo.rank == '3'}">
	                    <div class="podium-item podium-3rd">
	                        <div class="podium-rank">3등</div>
	                        <img onclick="goView(${clubvo.clubseq}, ${clubvo.fk_sportseq})" src="<%=ctxPath %>/resources/images/zee/${clubvo.clubimg}" class="podium-img" onerror="javascript:this.src='<%=ctxPath %>/resources/images/noimg.jpg'" />
	                        <div>${clubvo.clubname}</div>
	                    </div>
	                </c:when>
	            </c:choose>
	        </c:forEach>
	    </c:if>		    
	    <c:if test="${not empty requestScope.clubList && requestScope.clubList.size() < 3}">
	        <div class="podium-item podium-3rd">
	            <div class="podium-rank">3등</div>
	            <img src="<%=ctxPath %>/resources/images/noimg.jpg" class="podium-img" onerror="javascript:this.src='<%=ctxPath %>/resources/images/noimg.jpg'" />
	            <div>3등이 없습니다.</div>
	        </div>
	    </c:if>		
		<%-- 3등 끝 --%>
		
		
		<%-- 만약 동호회가 없을 경우 --%>
		<c:if test="${empty requestScope.clubList}">
	        <div class="podium-item podium-2nd">
	            <div class="podium-rank">2등</div>
	            <img src="<%=ctxPath %>/resources/images/noimg.jpg" class="podium-img" onerror="javascript:this.src='<%=ctxPath %>/resources/images/noimg.jpg'" />
	            <div>2등이 없습니다.</div>
	        </div>
	        <div class="podium-item podium-1st">
	            <div class="podium-rank">1등</div>
	            <img src="<%=ctxPath %>/resources/images/noimg.jpg" class="podium-img" onerror="javascript:this.src='<%=ctxPath %>/resources/images/noimg.jpg'" />
	            <div>1등이 없습니다.</div>
	        </div>
	        <div class="podium-item podium-3rd">
	            <div class="podium-rank">3등</div>
	            <img src="<%=ctxPath %>/resources/images/noimg.jpg" class="podium-img" onerror="javascript:this.src='<%=ctxPath %>/resources/images/noimg.jpg'" />
	            <div>3등이 없습니다.</div>
	        </div>
	    </c:if>	
		
	</div>		
    </div>
    
  </body>
</html>