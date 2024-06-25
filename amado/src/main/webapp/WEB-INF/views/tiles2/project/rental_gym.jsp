<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String ctxPath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">

<style type="text/css">
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
}

header {
    padding: 10px 0;
    text-align: center;
}

nav ul {
    list-style: none;
    padding: 0;
    display: flex;
    justify-content: flex-end;
    margin: 0 20px;
}

nav ul li {
    margin-left: 20px;
}

nav ul li button {
    background-color: #333;
    color: white;
    border: none;
    padding: 10px 20px;
    cursor: pointer;
}

.product-section {
    display: none;
    padding: 20px;
}

.product-section.active {
    display: block;
}

.product-card {
    border: 1px solid #ccc;
    padding: 20px;
    margin: 20px 0;
}

.product-card img {
    max-width: 100%;
}

.hidden {
    display: none;
}
    .search-box {
            position: absolute;
            top: 250px; /* 검색창을 헤더 안으로 넣기 위한 조정 */
            right: 15px;
            width: 250px; /* 가로 폭 조절 */
            display: flex;
        }
.search-box input {
    flex: 1;
}
</style>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/myshop/moreHomeScroll.js"></script>
<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function() {
    const indoorBtn = document.getElementById('indoorBtn');
    const outdoorBtn = document.getElementById('outdoorBtn');
    const indoorSection = document.getElementById('indoor');
    const outdoorSection = document.getElementById('outdoor');

    indoorBtn.addEventListener('click', function() {
        indoorSection.classList.add('active');
        outdoorSection.classList.remove('active');
    });

    outdoorBtn.addEventListener('click', function() {
        outdoorSection.classList.add('active');
        indoorSection.classList.remove('active');
    });

    // 기본적으로 실내 상품을 보이게 설정
    indoorSection.classList.add('active');
});





</script>
	<body>
	      <h1 class="text-center py-3">체육관 대관하기</h1>
	        <nav class="d-flex justify-content-end">
	            <button id="indoorBtn" class="btn btn-primary mx-2">실내 </button>
	            <button id="outdoorBtn" class="btn btn-secondary mx-2">실외 </button>
	        </nav>
	 <div class="search-box">
            <input type="text" class="form-control" placeholder="검색">
            <button class="btn btn-primary ml-2">검색</button>
        </div>
	   
	    <br><br>
	    
	    <section id="indoor" class="product-section container mt-4">
	        <div class="row">
	            <!-- 실내 상품 카드들 -->
	            <div class="col-md-3 mb-4">
	                <div class="card">
	                    <img src="<%=ctxPath%>/resources/images/1/체육관.jpg" class="card-img-top" alt="실내 상품 1">
	                    <div class="card-body">
	                        <h5 class="card-title">광주</h5>
	                        <p class="card-text">2만원/2시간</p>
	                
	                    </div>
	                </div>
	            </div>
	             <div class="col-md-3 mb-4">
	                <div class="card">
	                    <img src="<%=ctxPath%>/resources/images/1/체육관2.jpg" class="card-img-top" alt="실내 상품 2">
	                    <div class="card-body">
	                        <h5 class="card-title">부산</h5>
	                        <p class="card-text">1.5만원/2시간</p>
	                     
	                    </div>
	                </div>
	            </div>
	             <div class="col-md-3 mb-4">
	                <div class="card">
	                    <img src="<%=ctxPath%>/resources/images/1/체육관3.jpg" class="card-img-top" alt="실내 상품 3">
	                    <div class="card-body">
	                        <h5 class="card-title">서울 강남</h5>
	                        <p class="card-text">2.3만원/2시간</p>
	                
	                    </div>
	                </div>
	            </div>
	             <div class="col-md-3 mb-4">
	                <div class="card">
	                    <img src="<%=ctxPath%>/resources/images/1/체육관4.jpg" class="card-img-top" alt="실내 상품 4">
	                    <div class="card-body">
	                        <h5 class="card-title">서울 목동</h5>
	                        <p class="card-text">2.4만원/2시간</p>
	                 
	                    </div>
	                </div>
	            </div>
	             <div class="col-md-3 mb-4">
	                <div class="card">
	                    <img src="<%=ctxPath%>/resources/images/1/체육관5.jpg" class="card-img-top" alt="실내 상품 5">
	                    <div class="card-body">
	                        <h5 class="card-title">서울 강서</h5>
	                        <p class="card-text">2.1만원/2시간</p>
	                     
	                    </div>
	                </div>
	            </div>
	             <div class="col-md-3 mb-4">
	                <div class="card" onclick="javascript:location.href='<%= ctxPath%>/list.action'">
	                    <img src="<%=ctxPath%>/resources/images/1/체육관6.jpg" class="card-img-top" alt="실내 상품 6">
	                    <div class="card-body">
	                        <h5 class="card-title">인천</h5>
	                        <p class="card-text">1.9만원/2시간</p>
	                    
	                    </div>
	                </div>
	            </div>
	             <div class="col-md-3 mb-4">
	                <div class="card">
	                    <img src="<%=ctxPath%>/resources/images/1/체육관7.jpg" class="card-img-top" alt="실내 상품 7">
	                    <div class="card-body">
	                        <h5 class="card-title">대구</h5>
	                        <p class="card-text">1.6만원/2시간</p>
	                   
	                    </div>
	                </div>
	            </div>
	               <div class="col-md-3 mb-4">
	                <div class="card">
	                    <img src="<%=ctxPath%>/resources/images/1/체육관8.jpg" class="card-img-top" alt="실내 상품8">
	                    <div class="card-body">
	                        <h5 class="card-title">대전</h5>
	                        <p class="card-text">1.5만원/2시간</p>
	                      
	                    </div>
	                </div>
	            </div>
	            
	            <!-- 15개 더 추가 -->
	        </div>
	    </section>
	    
	    <section id="outdoor" class="product-section container mt-4 hidden">
	        <div class="row">
	            <!-- 실외 상품 카드들 -->
	            <div class="col-md-3 mb-4">
	                <div class="card">
	                    <img src="outdoor_product1.jpg" class="card-img-top" alt="실외 상품 1">
	                    <div class="card-body">
	                        <h5 class="card-title">체육관  1</h5>
	                        <p class="card-text">체육관 설명...</p>
	                   
	                    </div>
	                </div>
	            </div>
	              <div class="col-md-3 mb-4">
	                <div class="card">
	                    <img src="outdoor_product1.jpg" class="card-img-top" alt="실외 상품 1">
	                    <div class="card-body">
	                        <h5 class="card-title">체육관  2</h5>
	                        <p class="card-text">체육관 설명...</p>
	                   
	                    </div>
	                </div>
	            </div>
	              <div class="col-md-3 mb-4">
	                <div class="card">
	                    <img src="outdoor_product1.jpg" class="card-img-top" alt="실외 상품 1">
	                    <div class="card-body">
	                        <h5 class="card-title">체육관  3</h5>
	                        <p class="card-text">체육관 설명...</p>
	                   
	                    </div>
	                </div>
	            </div>
	              <div class="col-md-3 mb-4">
	                <div class="card">
	                    <img src="outdoor_product1.jpg" class="card-img-top" alt="실외 상품 1">
	                    <div class="card-body">
	                        <h5 class="card-title">체육관 4</h5>
	                        <p class="card-text">체육관 설명...</p>
	                   
	                    </div>
	                </div>
	            </div>
	              <div class="col-md-3 mb-4">
	                <div class="card">
	                    <img src="outdoor_product1.jpg" class="card-img-top" alt="실외 상품 1">
	                    <div class="card-body">
	                        <h5 class="card-title">체육관 5</h5>
	                        <p class="card-text">체육관 설명...</p>
	                   
	                    </div>
	                </div>
	            </div>
	              <div class="col-md-3 mb-4">
	                <div class="card">
	                    <img src="outdoor_product1.jpg" class="card-img-top" alt="실외 상품 1">
	                    <div class="card-body">
	                        <h5 class="card-title">체육관  6</h5>
	                        <p class="card-text">체육관 설명...</p>
	                   
	                    </div>
	                </div>
	            </div>
	              <div class="col-md-3 mb-4">
	                <div class="card">
	                    <img src="outdoor_product1.jpg" class="card-img-top" alt="실외 상품 1">
	                    <div class="card-body">
	                        <h5 class="card-title">체육관  7</h5>
	                        <p class="card-text">체육관 설명...</p>
	                   
	                    </div>
	                </div>
	            </div>
	              <div class="col-md-3 mb-4">
	                <div class="card">
	                    <img src="outdoor_product1.jpg" class="card-img-top" alt="실외 상품 1">
	                    <div class="card-body">
	                        <h5 class="card-title">체육관  8</h5>
	                        <p class="card-text">체육관 설명...</p>
	                   
	                    </div>
	                </div>
	            </div>
	            <!-- 15개 더 추가 -->
	        </div>
	        
	        
	        <%-- === HIT 상품을 모두 가져와서 디스플레이(더보기 방식으로 페이징 처리한 것) === --%>
	   <div>
	      <p class="h3 my-3 text-center">- HIT 상품(스크롤) -</p>
		
		<div class="row" id="displayHIT" style="text-align: left;"></div> <%--더보기할때 들어오는곳 --%>
	      
	      <div>
	         <p class="text-center">
	              <span id="end" style="display:block; margin:20px; font-size: 14pt; font-weight: bold; color: red;"></span>  <%-- 글씨가 들어오는곳 --%>
	          	  <span id="totalHITCount">${requestScope.totalHITCount}</span>   
	           	  <span id="countHIT">0</span>
	         </p>
	      </div>
		
		  <div style="display: flex;">
	         <div style="margin: 20px 0 20px auto;">
	            <button class="btn btn-info" onclick="goTop()">맨위로가기(scrollTop 1로 설정함)</button>
	         </div>
	      </div>	
	
	
	
	   </div>
	        
	        
	    </section>
	    
	    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
	    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	    <script src="script.js"></script>
	</body>
	</html>
	
	 
	</body>
	</html>
    