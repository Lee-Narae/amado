<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
   String ctxPath = request.getContextPath();
%>    

    
<style type="text/css">
    
	.round-card {
	border: solid 1px red;
    border-radius: 50%;
    width: 300px;
    height: 300px;
    overflow: hidden;
    display: flex;
    align-items: center;
    justify-content: center;
    text-align: center;
}
.round-card img {
    border-radius: 50%;
    width: 60%;
    height: auto;
    border: solid 1px gray;
}


div#scategory{
	
}
div.card{
	position: relative;
	border: solid 1px gray;
	border-radius: 100%;
	width: 270px;
	height: 270px;
	text-align: center;
	padding-top: 25px; 
	overflow: hidden;
}

div.sports{
	padding-bottom: 20px;
}
div.hoverborder{
	border: solid 0px red;
	margin-top: 20px;
	height: 500px;
	background-color: #254179;
	transition: all 0.5s ease;
	padding-bottom: 100%;
	
}

.hoverborder:hover {/*------호버------*/
	transform: translateY(-80px);
	transition-property: all;
	transition-duration: 0.5s;
	transition-delay: 0s;
	position: relative;
	cursor: pointer;
}



.hoverborder:hover div:first-child {
    display: none;
}
.hoverborder div.atag{
	
    display: none;
}
.hoverborder:hover div.atag {
    display:block;
}


.sportsimage {
    position: absolute;
    z-index: 1;
    padding-right: 40px;
    padding-bottom: 60px;
    margin-top: -20px; /* Adjust this value as needed */
}
.sportsimg{
	width: 100px;
}
div.hoverborder div{
	margin-top: 18%;
}
.sbtn{
	color: white;
}
</style>
    
    
    
    
<div id="container" style="border:solid 0px black; margin-top: 7%; margin-bottom: 5%;">
	
	<%-- 머릿말  --%>
	<div style="text-align: center; ">
		<h3 style="font-weight: bold;">동호회 찾기👥</h3>
		<br>
	</div>
	    
	<div style="display: flex;  margin-top: 5%;  width: 80%;margin-left:5%;">
		<div id="scategory" class="col-md-3 col-lg-2 offset-lg-1">
			<div class="sportsimage">
				<img class="sportsimg" src="<%= ctxPath%>/resources/images/zee/icons8-soccer-48.png"/>
			</div>
			<div class="card">
				<div class="sports">축구</div>
				
				<div class="recommend">🔥많이 찾는 동호회</div>
				<c:if test="${requestScope.soccerNameSeq.clubname != null}">
					<div class="rcmName">${requestScope.soccerNameSeq.clubname}</div>
				</c:if>
				<c:if test="${requestScope.soccerNameSeq.clubname == null}">
					<div class="noName">개설된 동호회가 없습니다.</div>
				</c:if>
				
				<div class="hoverborder">
					
					<div>동호회찾기 시작</div>
					<div class="atag">
						<c:if test="${requestScope.soccerNameSeq.clubname != null}">
							<a href='<%= ctxPath%>/club/myClub_plus.do?sportseq=1&clubseq=${requestScope.soccerNameSeq.clubseq}' class='sbtn'>${requestScope.soccerNameSeq.clubname} 바로가기 <img src="<%= ctxPath%>/resources/images/zee/arrow2.png"/></a>
							<br><br>
							<hr>
							<br>
							<a href='<%= ctxPath%>/club/findClub.do?sportseq=1' class='sbtn'>전체동호회 <img src="<%= ctxPath%>/resources/images/zee/arrow2.png"/></a>
						</c:if>
						
						<c:if test="${requestScope.soccerNameSeq.clubname == null}">
							<br><br>
							<a href='<%= ctxPath%>/club/findClub.do?sportseq=1' class='sbtn'>전체동호회 <img src="<%= ctxPath%>/resources/images/zee/arrow2.png"/></a>
						</c:if>
					</div>
					
				</div>
				
			</div>
		</div>
		<div id="scategory" class="col-md-3 col-lg-2 offset-lg-1">
			<div class="sportsimage">
				<img class="sportsimg" src="<%= ctxPath%>/resources/images/zee/icons8-baseball-48.png"/>
			</div>
			<div class="card">
				<div class="sports">야구</div>
				
				<div class="recommend">🔥많이 찾는 동호회</div>
				<c:if test="${requestScope.baseballNameSeq.clubname != null}">
					<div class="rcmName">${requestScope.baseballNameSeq.clubname}</div>
				</c:if>
				<c:if test="${requestScope.baseballNameSeq.clubname == null}">
					<div class="recommend">개설된 동호회가 없습니다.</div>
				</c:if>
				<div class="hoverborder">
					
					<div>동호회찾기 시작</div>
					<div class="atag">
						<c:if test="${requestScope.baseballNameSeq.clubname != null}">
							<a href='<%= ctxPath%>/club/myClub_plus.do?sportseq=2&clubseq=${requestScope.baseballNameSeq.clubseq}' class='sbtn'>${requestScope.baseballNameSeq.clubname} 바로가기 <img src="<%= ctxPath%>/resources/images/zee/arrow2.png"/></a>
							<br><br>
							<hr>
							<br>
							<a href='<%= ctxPath%>/club/findClub.do?sportseq=2' class='sbtn'>전체동호회 <img src="<%= ctxPath%>/resources/images/zee/arrow2.png"/></a>
						</c:if>
						
						<c:if test="${requestScope.baseballNameSeq.clubname == null}">
							<br><br>
							<a href='<%= ctxPath%>/club/findClub.do?sportseq=2' class='sbtn'>전체동호회 <img src="<%= ctxPath%>/resources/images/zee/arrow2.png"/></a>
						</c:if>
					</div>
					
				</div>
			</div>
		</div>
		<div id="scategory" class="col-md-3 col-lg-2 offset-lg-1">
			<div class="sportsimage">
				<img class="sportsimg" src="<%= ctxPath%>/resources/images/zee/icons8-volleyball-48.png"/>
			</div>
			<div class="card">
				<div class="sports">배구</div>
				
				<div class="recommend">🔥많이 찾는 동호회</div>
				<c:if test="${requestScope.vollyballNameSeq.clubname != null}">
					<div class="rcmName">${requestScope.vollyballNameSeq.clubname}</div>
				</c:if>
				<c:if test="${requestScope.vollyballNameSeq.clubname == null}">
					<div class="recommend">개설된 동호회가 없습니다.</div>
				</c:if>
				<div class="hoverborder">
					
					<div>동호회찾기 시작</div>
					<div class="atag">
						<c:if test="${requestScope.vollyballNameSeq.clubname != null}">
							<a href='<%= ctxPath%>/club/myClub_plus.do?sportseq=3&clubseq=${requestScope.vollyballNameSeq.clubseq}' class='sbtn'>${requestScope.vollyballNameSeq.clubname} 바로가기 <img src="<%= ctxPath%>/resources/images/zee/arrow2.png"/></a>
							<br><br>
							<hr>
							<br>
							<a href='<%= ctxPath%>/club/findClub.do?sportseq=3' class='sbtn'>전체동호회 <img src="<%= ctxPath%>/resources/images/zee/arrow2.png"/></a>
						</c:if>
						
						<c:if test="${requestScope.vollyballNameSeq.clubname == null}">
							<br><br>
							<a href='<%= ctxPath%>/club/findClub.do?sportseq=3' class='sbtn'>전체동호회 <img src="<%= ctxPath%>/resources/images/zee/arrow2.png"/></a>
						</c:if>
					</div>
					
				</div>
			</div>
		</div>
		<div id="scategory" class="col-md-3 col-lg-2 offset-lg-1">
			<div class="sportsimage">
				<img class="sportsimg" src="<%= ctxPath%>/resources/images/zee/icons8-basketball-48.png"/>
			</div>
			<div class="card">
				<div class="sports">농구</div>
				
				<div class="recommend">🔥많이 찾는 동호회</div>
				<c:if test="${requestScope.basketballNameSeq.clubname != null}">
					<div class="rcmName">${requestScope.basketballNameSeq.clubname}</div>
				</c:if>
				<c:if test="${requestScope.basketballNameSeq.clubname == null}">
					<div class="recommend">개설된 동호회가 없습니다.</div>
				</c:if>
				<div class="hoverborder">
					
					<div>동호회찾기 시작</div>
					<div class="atag">
						<c:if test="${requestScope.basketballNameSeq.clubname != null}">
							<a href='<%= ctxPath%>/club/myClub_plus.do?sportseq=4&clubseq=${requestScope.basketballNameSeq.clubseq}' class='sbtn'>${requestScope.basketballNameSeq.clubname} 바로가기 <img src="<%= ctxPath%>/resources/images/zee/arrow2.png"/></a>
							<br><br>
							<hr>
							<br>
							<a href='<%= ctxPath%>/club/findClub.do?sportseq=4' class='sbtn'>전체동호회 <img src="<%= ctxPath%>/resources/images/zee/arrow2.png"/></a>
						</c:if>
						
						<c:if test="${requestScope.basketballNameSeq.clubname == null}">
							<br><br>
							<a href='<%= ctxPath%>/club/findClub.do?sportseq=4' class='sbtn'>전체동호회 <img src="<%= ctxPath%>/resources/images/zee/arrow2.png"/></a>
						</c:if>
					</div>
					
				</div>
			</div>
		</div>
		
	
	<!-- <div class='col-md-3 col-lg-2 offset-lg-1' style="border:solid 0px red; ">
		   <div class="round-card mb-3" >
			   <img src='<%= ctxPath%>/resources/images/zee/icons8-badminton-64.png' class='oldproduct card-img-top' />
			   <div class='card-body' style='padding: 0; font-size: 9pt;'>
				  <ul class='list-unstyled mt-3 pl-3'> 
             	     <li class='text-center'><a href='#' class='stretched-link btn btn-outline-dark btn-sm' role='button'>자세히보기</a></li>
             	         <%-- 카드 내부의 링크에 .stretched-link 클래스를 추가하면 전체 카드를 클릭할 수 있고 호버링할 수 있습니다(카드가 링크 역할을 함). --%>
		          </ul>
		       </div>
	       </div>
        </div> -->
	</div>
	
	
	<div style="display: flex;  margin-top: 5%;  width: 80%; margin-left:5%;">
		<div id="scategory" class="col-md-3 col-lg-2 offset-lg-1">
			<div class="sportsimage">
				<img class="sportsimg" src="<%= ctxPath%>/resources/images/zee/icons8-tennis-player-48.png"/>
			</div>
			<div class="card">
				<div class="sports">테니스</div>
				
				<div class="recommend">🔥많이 찾는 동호회</div>
				<c:if test="${requestScope.tenisNameSeq.clubname != null}">
					<div class="rcmName">${requestScope.tenisNameSeq.clubname}</div>
				</c:if>
				<c:if test="${requestScope.tenisNameSeq.clubname == null}">
					<div class="recommend">개설된 동호회가 없습니다.</div>
				</c:if>
				<div class="hoverborder">
					
					<div>동호회찾기 시작</div>
					<div class="atag">
						<c:if test="${requestScope.tenisNameSeq.clubname != null}">
							<a href='<%= ctxPath%>/club/myClub_plus.do?sportseq=6&clubseq=${requestScope.tenisNameSeq.clubseq}' class='sbtn'>${requestScope.tenisNameSeq.clubname} 바로가기 <img src="<%= ctxPath%>/resources/images/zee/arrow2.png"/></a>
							<br><br>
							<hr>
							<br>
							<a href='<%= ctxPath%>/club/findClub.do?sportseq=6' class='sbtn'>전체동호회 <img src="<%= ctxPath%>/resources/images/zee/arrow2.png"/></a>
						</c:if>
						
						<c:if test="${requestScope.tenisNameSeq.clubname == null}">
							<br><br>
							<a href='<%= ctxPath%>/club/findClub.do?sportseq=6' class='sbtn'>전체동호회 <img src="<%= ctxPath%>/resources/images/zee/arrow2.png"/></a>
						</c:if>
					</div>
					
				</div>
			</div>
		</div>
		<div id="scategory" class="col-md-3 col-lg-2 offset-lg-1">
			<div class="sportsimage">
				<img class="sportsimg" src="<%= ctxPath%>/resources/images/zee/icons8-bowling-48.png"/>
			</div>
			<div class="card">
				<div class="sports">볼링</div>
				
				<div class="recommend">🔥많이 찾는 동호회</div>
				<c:if test="${requestScope.vowlingNameSeq.clubname != null}">
					<div class="rcmName">${requestScope.vowlingNameSeq.clubname}</div>
				</c:if>
				<c:if test="${requestScope.vowlingNameSeq.clubname == null}">
					<div class="recommend">개설된 동호회가 없습니다.</div>
				</c:if>
				<div class="hoverborder">
					
					<div>동호회찾기 시작</div>
					<div class="atag">
						<c:if test="${requestScope.vowlingNameSeq.clubname != null}">
							<a href='<%= ctxPath%>/club/myClub_plus.do?sportseq=7&clubseq=${requestScope.vowlingNameSeq.clubseq}' class='sbtn'>${requestScope.vowlingNameSeq.clubname} 바로가기 <img src="<%= ctxPath%>/resources/images/zee/arrow2.png"/></a>
							<br><br>
							<hr>
							<br>
							<a href='<%= ctxPath%>/club/findClub.do?sportseq=7' class='sbtn'>전체동호회 <img src="<%= ctxPath%>/resources/images/zee/arrow2.png"/></a>
						</c:if>
						
						<c:if test="${requestScope.vowlingNameSeq.clubname == null}">
							<br><br>
							<a href='<%= ctxPath%>/club/findClub.do?sportseq=7' class='sbtn'>전체동호회 <img src="<%= ctxPath%>/resources/images/zee/arrow2.png"/></a>
						</c:if>	
					</div>
					
				</div>
			</div>
		</div>
		<div id="scategory" class="col-md-3 col-lg-2 offset-lg-1">
			<div class="sportsimage">
				<img class="sportsimg" src="<%= ctxPath%>/resources/images/zee/icons8-soccer-48 (1).png"/>
			</div>
			<div class="card">
				<div class="sports">족구</div>
				
				<div class="recommend">🔥많이 찾는 동호회</div>
				<c:if test="${requestScope.footballNameSeq.clubname != null}">
					<div class="rcmName">${requestScope.footballNameSeq.clubname}</div>
				</c:if>
				<c:if test="${requestScope.footballNameSeq.clubname == null}">
					<div class="recommend">개설된 동호회가 없습니다.</div>
				</c:if>
				<div class="hoverborder">
					
					<div>동호회찾기 시작</div>
					<div class="atag">
						<c:if test="${requestScope.footballNameSeq.clubname != null}">
							<a href='<%= ctxPath%>/club/myClub_plus.do?sportseq=5&clubseq=${requestScope.footballNameSeq.clubseq}' class='sbtn'>${requestScope.footballNameSeq.clubname} 바로가기 <img src="<%= ctxPath%>/resources/images/zee/arrow2.png"/></a>
							<br><br>
							<hr>
							<br>
							<a href='<%= ctxPath%>/club/findClub.do?sportseq=5' class='sbtn'>전체동호회 <img src="<%= ctxPath%>/resources/images/zee/arrow2.png"/></a>
						</c:if>
						
						<c:if test="${requestScope.footballNameSeq.clubname == null}">
							<br><br>
							<a href='<%= ctxPath%>/club/findClub.do?sportseq=5' class='sbtn'>전체동호회 <img src="<%= ctxPath%>/resources/images/zee/arrow2.png"/></a>
						</c:if>
					</div>
					
				</div>
			</div>
		</div>
		<div id="scategory" class="col-md-3 col-lg-2 offset-lg-1">
			<div class="sportsimage">
				<img class="sportsimg" src="<%= ctxPath%>/resources/images/zee/icons8-badminton-player-48.png"/>
			</div>
			<div class="card">
				<div class="sports">배드민턴</div>
				
				<div class="recommend">🔥많이 찾는 동호회</div>
				<c:if test="${requestScope.badmintonNameSeq.clubname != null}">
					<div class="rcmName">${requestScope.badmintonNameSeq.clubname}</div>
				</c:if>
				<c:if test="${requestScope.badmintonNameSeq.clubname == null}">
					<div class="recommend">개설된 동호회가 없습니다.</div>
				</c:if>
				<div class="hoverborder">
					
					<div>동호회찾기 시작</div>
					<div class="atag">
						<c:if test="${requestScope.badmintonNameSeq.clubname != null}">
							<a href='<%= ctxPath%>/club/myClub_plus.do?sportseq=8&clubseq=${requestScope.badmintonNameSeq.clubseq}' class='sbtn'>${requestScope.badmintonNameSeq.clubname} 바로가기 <img src="<%= ctxPath%>/resources/images/zee/arrow2.png"/></a>
							<br><br>
							<hr>
							<br>
							<a href='<%= ctxPath%>/club/findClub.do?sportseq=8' class='sbtn'>전체동호회 <img src="<%= ctxPath%>/resources/images/zee/arrow2.png"/></a>
						</c:if>
						
						<c:if test="${requestScope.badmintonNameSeq.clubname == null}">
							<br><br>
							<a href='<%= ctxPath%>/club/findClub.do?sportseq=8' class='sbtn'>전체동호회 <img src="<%= ctxPath%>/resources/images/zee/arrow2.png"/></a>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	
	</div>
	
	
</div>
    