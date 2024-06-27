<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
   String ctxPath = request.getContextPath();
%>    

    
<style type="text/css">
    
	.round-card {
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
	width: 200px;
	height: 200px;
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

.hoverborder:hover a{
	opacity: 0;
}

.sportsimage {
    position: absolute;
    z-index: 1;
    padding-right: 40px;
    padding-bottom: 60px;
    margin-top: -20px; /* Adjust this value as needed */
}
.sportsimg{
	width: 80px;
}
   
</style>
    
    
    
    
<div class="container" style="border:solid 0px black; margin-top: 12%;">
	
	<%-- 머릿말  --%>
	<div style="text-align: center; ">
		<h3 style="font-weight: bold;">동호회 찾기👥</h3>
		<br>
	</div>
	    
	<div style="display: flex;  margin-top: 5%; padding-right: 15%; ">
		<div id="scategory" class="col-md-3 col-lg-2 offset-lg-1">
			<div class="sportsimage">
				<img class="sportsimg" src="<%= ctxPath%>/resources/images/zee/icons8-soccer-48.png"/>
			</div>
			<div class="card">
				<div class="sports">축구</div>
				
				<div class="recommend">🔥많이 찾는 동호회</div>
				<div class="recommend">ooo</div>
				<div class="hoverborder">
					<a href='#' class='sbtn'>자세히보기</a>
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
				<div class="recommend">ooo</div>
				<div class="hoverborder">
					<a href='#' class='sbtn'></a>
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
				<div class="recommend">ooo</div>
				<div class="hoverborder">
					<a href='#' class='sbtn'></a>
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
				<div class="recommend">ooo</div>
				<div class="hoverborder">
					<a href='#' class='sbtn'></a>
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
	
	
	<div style="display: flex;  margin-top: 5%;  padding-right: 15%">
		<div id="scategory" class="col-md-3 col-lg-2 offset-lg-1">
			<div class="sportsimage">
				<img class="sportsimg" src="<%= ctxPath%>/resources/images/zee/icons8-tennis-player-48.png"/>
			</div>
			<div class="card">
				<div class="sports">테니스</div>
				
				<div class="recommend">🔥많이 찾는 동호회</div>
				<div class="recommend">ooo</div>
				<div class="hoverborder">
					<a href='#' class='sbtn'></a>
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
				<div class="recommend">ooo</div>
				<div class="hoverborder">
					<a href='#' class='sbtn'></a>
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
				<div class="recommend">ooo</div>
				<div class="hoverborder">
					<a href='#' class='sbtn'></a>
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
				<div class="recommend">ooo</div>
				<div class="hoverborder">
					<a href='#' class='sbtn'></a>
				</div>
			</div>
		</div>
	
	</div>
	
	
</div>
    