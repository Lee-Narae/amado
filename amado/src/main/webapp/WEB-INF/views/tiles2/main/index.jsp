<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
   String ctxPath = request.getContextPath();
%>

<style>
  body { padding: 0px; margin: 0px; }
  .jb-box {position: relative; width: 100%; height: 1000px; overflow: hidden;margin: 0px auto; position: relative; }
  video { width: 100%; }
  .jb-text { position: absolute; top: 50%; width: 100%; }
  .jb-text p { margin-top: -24px; text-align: center; font-size: 48px; color: #ffffff; }

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

    #slider {
        padding: 50px 0;
      }
      #slider .title h3 {
        font-size: 36px;
        margin-bottom: 30px;
      }
      .carousel-item img {
        display: block;
        width: 95%;
        height: auto;
        max-height: 200px; /* 이미지 최대 높이 조정 */
       object-fit: cover; /* 이미지 잘림 방지 */
       border-radius: 5px; /* 선택적: 이미지에 둥근 모서리 추가 */
       
       
      }
      .carousel-inner .row {
        display: flex;
        justify-content: center;
        align-items: center;
      }
      .carousel-inner .col-md-3 {
        padding: 0;
        margin: 0 5px; /* 이미지 사이 여백 */
          flex: 0 0 23%; /* 각 이미지의 너비 조정 */
          max-width: 23%; /* 각 이미지의 최대 너비 조정 */
      }
      
       
        .carousel-inner img {
            cursor: pointer;
        }
.overlay {
      position: absolute;
      top: 0;
      right: 0;
      height: 100px;
      width: 15%;
      z-index: 1;
       background: rgba(255, 255, 255, 0);  /* Optional: semi-transparent background */
    }
    .overlay-content {
      height: 100%;
      overflow: hidden;
      padding: 10px;
      box-sizing: border-box;
    }
    .overlay .highcharts-figure {
      margin: 20px 0;
    }

#chatIcon:hover {
cursor: pointer;
opacity: 0.7;
}

</style>

<script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/highcharts.js"></script>
<script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/modules/exporting.js"></script>
<script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/modules/export-data.js"></script>
<script src="<%= ctxPath%>/resources/Highcharts-10.3.1/code/modules/accessibility.js"></script>


 <script type="text/javascript">

   $(document).ready(function(){
      
	    var urlParams = new URLSearchParams(window.location.search);
	    var scrollTo = urlParams.get('scrollTo');
	    
	    if (scrollTo) {
	        scrollToSection(scrollTo);
	    }

	    if (${empty requestScope.params}) {
	        mainClubRank(1);    
	    }

	   
	   
	   
	   
	   
	   
	   
      loopshowNowTime();
      
      showWeather();
      
   });// end of $(document).ready(function(){});------------
   
   
   // Function Declaration
   
   function showNowTime() {
      
      const now = new Date();
   
      let month = now.getMonth() + 1;
      if(month < 10) {
         month = "0"+month;
      }
      
      let date = now.getDate();
      if(date < 10) {
         date = "0"+date;
      }
      
      let strNow = now.getFullYear() + "-" + month + "-" + date;
      
      let hour = "";
       if(now.getHours() < 10) {
           hour = "0"+now.getHours();
       } 
       else {
          hour = now.getHours();
       }
      
       
      let minute = "";
      if(now.getMinutes() < 10) {
         minute = "0"+now.getMinutes();
      } else {
         minute = now.getMinutes();
      }
      
      let second = "";
      if(now.getSeconds() < 10) {
         second = "0"+now.getSeconds();
      } else {
         second = now.getSeconds();
      }
      
      strNow += " "+hour + ":" + minute + ":" + second;
      
      $("span#clock").html(strNow);
   
   }// end of function showNowTime() -----------------------------
   
   
   function loopshowNowTime() {
      showNowTime();
      
      const timejugi = 1000;  // 시간을 1초 마다 자동 갱신하려고.
      
      setTimeout(function() {
                  loopshowNowTime();   
               }, timejugi);
      
   } // end of loopshowNowTime() --------------------------

   
   // ------ 기상청 날씨정보 공공API XML 데이터 호출하기 ------ //
   function showWeather(){
      
      $.ajax({
         url:"<%= ctxPath%>/weather/weatherXML.do",
         type:"get",
         dataType:"xml",
         success:function(xml){
            const rootElement = $(xml).find(":root"); 
         //   console.log("확인용 : " + $(rootElement).prop("tagName") );
            // 확인용 : current
            
            const weather = rootElement.find("weather"); 
            
            const localArr = rootElement.find("local");
         
            let v_html = "";
            
            for(let i=0; i<localArr.length; i++){
            	let local = $(localArr).eq(i);
            	
            	if($(local).text() == '서울') {
            		
            		let icon = $(local).attr("icon");  
                    if(icon == "") {
                       icon = "없음";
                    }
                  
                    v_html += "<div style='border: solid 0px black; display: inline-block; background-color:lightgray; border-radius: 15px; padding:0 4%;'>";
                    v_html += "<span>"+$(local).text()+"</span><span><img src='<%= ctxPath%>/resources/images/weather/"+icon+".png' />"+$(local).attr("desc")+"</span>&nbsp;<span style='font-weight:bolder;'>"+$(local).attr("ta")+"</span>"; 
                    v_html += "</div>";
            		
            		break;
            	}
            }
             
            $("div#displayWeather").html(v_html);
            
         },// end of success: function(xml){ }------------------
         
         error: function(request, status, error){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
         }
      });
      
   }// end of function showWeather()--------------------
   
   function showImage(src) {
       document.getElementById('modalImage').src = src;
   }
   
function openChat(){
	window.open('http://192.168.0.204:9099/amado/chatting/multichat.do','_blank','width=450, height=700, top=50, left=50');	
}

function scrollToSection(sectionId) {
    var section = document.getElementById(sectionId);
    if (section) {
        // 해당 섹션의 위치로 스크롤
        section.scrollIntoView({ behavior: 'smooth' });
    }
}

function mainClubRank(sportseq) {
	location.href='<%=ctxPath %>/index.do?sportseq='+sportseq;
	location.href = '<%=ctxPath %>/index.do?sportseq=' + sportseq + '&scrollTo=ksjMain';
}
function mainClubRankF(sportseq) {
	location.href = '<%=ctxPath %>/index.do?sportseq=' + sportseq + '&scrollTo=ksjMain';
}

function goView(clubseq, fk_sportseq) {
   location.href = "<%=ctxPath%>/club/myClub_plus.do?clubseq="+clubseq+"&sportseq="+fk_sportseq;
}



</script>



<!-- 준혁 시작 -->
<div class="jb-box">
  <video muted autoplay loop>
    <source src="<%=ctxPath%>/resources/videos/nike.mp4" type="video/mp4">
  </video>
  
  <!-- 지윤 시작 -->
  <div class="overlay">
      <div class="overlay-content">
        <div id="displayWeather" style="min-width: 90%; margin-top: 40px; margin-bottom: 70px;"></div>
        <div class="highcharts-figure">
          <div id="weather_chart_container"></div>
        </div>
      </div>
    </div>
  <!-- 지윤 끝 -->
  
</div>
<!-- 준혁 끝 -->



<!-- 승진 시작 -->
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
                          <img onclick="goView(${rankS.clubseq}, ${rankS.fk_sportseq})" src="<%=ctxPath %>/resources/images/uploadImg/${rankS.wasfileName}" class="podium-img" onerror="javascript:this.src='<%=ctxPath %>/resources/images/noimg.jpg'" />
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
                          <img onclick="goView(${rankF.clubseq}, ${rankF.fk_sportseq})" src="<%=ctxPath %>/resources/images/uploadImg/${rankF.wasfileName}" class="podium-img" onerror="javascript:this.src='<%=ctxPath %>/resources/images/noimg.jpg'" />
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
                          <img onclick="goView(${rankT.clubseq}, ${rankT.fk_sportseq})" src="<%=ctxPath %>/resources/images/uploadImg/${rankT.wasfileName}" class="podium-img" onerror="javascript:this.src='<%=ctxPath %>/resources/images/noimg.jpg'" />
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
<!-- 승진 끝  -->

<!-- 한솔 시작 -->
     <section id="slider">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="block wow fadeInUp" data-wow-duration="500ms" data-wow-delay="300ms">
                        <div class="title">
                            <span style="font-size: 20px; font-family: 'Arial', sans-serif; display: inline-block; margin-bottom: 20px;">
                                체육관 <span style="color: blue; font-size: 20px;">추천</span>
                            </span>
                        </div>
                        <div id="featuredWorksCarousel" class="carousel slide" data-ride="carousel">
                            <div class="carousel-inner">
                                <div class="carousel-item active">
                                    <div class="row">
                                        <div class="col-md-3">
                                            <img class="img-responsive" src="<%=ctxPath%>/resources/images/1/영등포 SKY 풋살파크.jpg" alt="Slider Image 1" data-toggle="modal" data-target="#imageModal" onclick="showImage('<%=ctxPath%>/resources/images/1/영등포 SKY 풋살파크.jpg')">
                                        </div>
                                        <div class="col-md-3">
                                            <img class="img-responsive" src="<%=ctxPath%>/resources/images/1/유앤아이스포츠 명지대점.jpg" alt="Slider Image 2" data-toggle="modal" data-target="#imageModal" onclick="showImage('<%=ctxPath%>/resources/images/1/유앤아이스포츠 명지대점.jpg')">
                                        </div>
                                        <div class="col-md-3">
                                            <img class="img-responsive" src="<%=ctxPath%>/resources/images/1/SJ 풋볼 아카데미.jpg" alt="Slider Image 3" data-toggle="modal" data-target="#imageModal" onclick="showImage('<%=ctxPath%>/resources/images/1/SJ 풋볼 아카데미.jpg')">
                                        </div>
                                        <div class="col-md-3">
                                            <img class="img-responsive" src="<%=ctxPath%>/resources/images/1/유앤아이스포츠 명지대점.jpg" alt="Slider Image 4" data-toggle="modal" data-target="#imageModal" onclick="showImage('<%=ctxPath%>/resources/images/1/유앤아이스포츠 명지대점.jpg')">
                                        </div>
                                    </div>
                                </div>
                                <div class="carousel-item">
                                    <div class="row">
                                        <div class="col-md-3">
                                            <img class="img-responsive" src="<%=ctxPath%>/resources/images/1/영등포 SKY 풋살파크.jpg" alt="Slider Image 5" data-toggle="modal" data-target="#imageModal" onclick="showImage('<%=ctxPath%>/resources/images/1/영등포 SKY 풋살파크.jpg')">
                                        </div>
                                        <div class="col-md-3">
                                            <img class="img-responsive" src="<%=ctxPath%>/resources/images/1/유앤아이스포츠 명지대점.jpg" alt="Slider Image 6" data-toggle="modal" data-target="#imageModal" onclick="showImage('<%=ctxPath%>/resources/images/1/유앤아이스포츠 명지대점.jpg')">
                                        </div>
                                        <div class="col-md-3">
                                            <img class="img-responsive" src="<%=ctxPath%>/resources/images/1/영등포 SKY 풋살파크.jpg" alt="Slider Image 7" data-toggle="modal" data-target="#imageModal" onclick="showImage('<%=ctxPath%>/resources/images/1/영등포 SKY 풋살파크.jpg')">
                                        </div>
                                        <div class="col-md-3">
                                            <img class="img-responsive" src="<%=ctxPath%>/resources/images/1/SJ 풋볼 아카데미.jpg" alt="Slider Image 8" data-toggle="modal" data-target="#imageModal" onclick="showImage('<%=ctxPath%>/resources/images/1/SJ 풋볼 아카데미.jpg')">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <a class="carousel-control-prev" href="#featuredWorksCarousel" role="button" data-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="sr-only">Previous</span>
                            </a>
                            <a class="carousel-control-next" href="#featuredWorksCarousel" role="button" data-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="sr-only">Next</span>
                            </a>
                        </div>
                    </div>
                </div><!-- .col-md-12 close -->
            </div><!-- .row close -->
        </div><!-- .container close -->
    </section><!-- slider close -->

 <!-- Modal -->
    <div class="modal fade" id="imageModal" tabindex="-1" role="dialog" aria-labelledby="imageModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="imageModalLabel">이미지 보기</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <img id="modalImage" src="" alt="Large Image" style="width: 100%; height: auto;">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>

<!-- 한솔 끝 -->

<!-- 나래 시작 -->
<div id="chatIcon" style="position: fixed; bottom: 80px; right: 80px; background-color: rgb(255, 255, 255, 0.5); border-radius: 100%; width: 160px; height: 160px; align-content: center;" align="center" onclick="openChat()">
<img width="120" height="120" src="https://img.icons8.com/fluency/200/chat--v1.png" alt="chat--v1"/>
</div>
<!-- 나래 끝 -->
