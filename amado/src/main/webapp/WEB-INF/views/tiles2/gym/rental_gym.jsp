<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String ctxPath = request.getContextPath();
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">

<style type="text/css">

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
   #mycontent > div.search-box > form {
			         
      	margin-left: 80px;
        }

#mycontent > nav {
margin-right: 80px;
margin-top: 100px;
}

.container {
    padding: 0 30px; /* 컨테이너의 좌우 여백을 설정하여 전체 레이아웃의 여백을 추가 */
}

.row {
    margin: 0; /* 행의 외부 여백 제거 */
}

.col-md-3 {
    padding: 0 15px; /* 열의 좌우 여백을 추가하여 카드 간격 조정 */
}

.card {
    width: 100%; /* 카드가 부모 요소의 너비를 기준으로 설정됨 */
    max-width: 300px; /* 카드의 최대 너비를 설정 (원하는 가로폭으로 조정) */
    margin: 0 auto; /* 카드 중앙 정렬 */
}

.card-img-top {
    width: 100%; /* 이미지가 카드 너비에 맞게 조정 */
    height: auto; /* 높이는 자동으로 조정 */
    max-height: 200px; /* 이미지의 최대 높이 설정 */
    object-fit: cover; /* 이미지 비율 유지하며 잘라내기 */
}

.card-body {
    padding:   px; /* 카드 본문 내부의 패딩 설정 (필요에 따라 조정) */
}

</style>
<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.7.1.min.js"></script>
  <script type="text/javascript" src="<%= ctxPath%>/resources/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script>
  <script type="text/javascript" src="<%= ctxPath%>/resources/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>

<%-- <script type="text/javascript" src="<%= ctxPath%>/resources/js/myshop/categoryListJSON.js"></script> 
<script type="text/javascript" src="<%= ctxPath%>/resources/js/myshop/moreHomeScroll.js"></script> --%>
<script type="text/javascript">
$(document).ready(function(){
/*     const indoorBtn = document.getElementById('indoorBtn');
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
    indoorSection.classList.add('active'); */
    
    
    if("${requestScope.searchWord}" != ""){
		$("input:text[name='searchWord']").val("${requestScope.searchWord}");
	}
	
	
    $("button#indoorBtn").click(function(e){

    	const frm = document.gymSearchFrm;
    	frm.insidestatus.value = "0";
        frm.submit();

    });
    

    $("button#outdoorBtn").click(function(e){
    	const frm = document.gymSearchFrm;
    	frm.insidestatus.value = "1";
        frm.submit();
    	
    });

});
// 검색 버튼 클릭 시 검증 후 폼 제출
function goSearch() {
    if ($("input:text[name='searchWord']").val() == "") {
        alert("검색어를 입력하세요.");
        return;
    }
    
 
    const frm = document.gymSearchFrm;
    frm.submit();
}


</script>
	<body>
	      <h1 class="text-center py-3">체육관 대관하기</h1>
	        <nav class="d-flex justify-content-end">
	            <button id="indoorBtn" class="btn btn-primary mx-2" style="margin-left: -30px;">실내</button>
				<button id="outdoorBtn" class="btn btn-secondary mx-2" style="margin-left: -30px;">실외</button>
	        </nav>
	 <div class="search-box">
            <form name="gymSearchFrm">
	            <input type="text"  name="searchWord" id="searchWord" placeholder="검색">	
	            <input type="hidden" name="insidestatus" />
	            <button class="btn btn-primary btn-circle" onclick="goSearch()">
	  			<i class="fa-solid fa-magnifying-glass"></i>
	 				 </button>
			 </form>
        </div>
	   
	    <br><br>
	    
	    
	   <!--  <section id="indoor" class="product-section container mt-4"> -->
	        <div class="row">
				<c:forEach var="gym" items="${requestScope.gymList}">
	            	<c:if test="${gym.status =='1'}">
	                <div class="col-md-3 mb-4">
                    	<div class="card" onclick="javascript:location.href='<%= ctxPath%>/gym/detail_gym.do?gymseq=${gym.gymseq}'">
	                        <img src="<%=ctxPath%>/resources/images/1/${gym.filename}" class="card-img-top" alt="실내 상품 1" style="width: 100%; height: 200px;">
		                    <div class="card-body">
		                    	<h5 class="card-title" style="width: 170px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${gym.gymname}</h5>
		                        <p class="card-text">${gym.cost}/1시간</p>
		                    </div>
	               	    </div>
	                 </div>
	              </c:if>
               </c:forEach>
	           <%--  <c:forEach var="gym" items="${requestScope.gymList} ">
		            <c:if test="${gym.insidestatus == '0'}">
			            <div class="col-md-3 mb-4">
			                <div class="card" onclick="javascript:location.href='<%= ctxPath%>/gym/detail_gym.do'">
			                    <img src="<%=ctxPath%>/resources/images/1/${gym.orgfilename}" class="card-img-top" alt="실내 상품 1">
			                    <div class="card-body">
			                        <h5 class="card-title">${gym.gymname}</h5>
			                        <p class="card-text">${gym.cost}/1시간</p>
			                    </div>
			                </div>
			            </div>
		            </c:if>
	            </c:forEach> --%>
	             </div>
	  <!--   </section> -->
	    
<%-- 	    
	    <section id="outdoor" class="product-section container mt-4 hidden">
	        <div class="row">
	          <c:forEach var="gym" items="${requestScope.gymList}">
		            <c:if test="${gym.insidestatus == '1' && gym.status =='1'}">
			            <div class="col-md-3 mb-4">
			                <div class="card" onclick="javascript:location.href='<%= ctxPath%>/gym/detail_gym.do?gymseq=${gym.gymseq}'">
			                    <img src="<%=ctxPath%>/resources/images/1/${gym.filename}" class="card-img-top" alt="실내 상품 1" style="width: 100%; height: 200px;">
			                    <div class="card-body">
			                        <h5 class="card-title" style="width: 170px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${gym.gymname}</h5>
			                        <p class="card-text">${gym.cost}/1시간</p>
			                    </div>
			                </div>
			            </div>
		            </c:if>
	            </c:forEach> 
	        </div>
	        
	        
	 
	    </section> --%>
	    
	    <div id="pageBar" style="display: flex; justify-content: center;">
    <nav>
        <ul class="pagination">${requestScope.pageBar}</ul>
    </nav>
</div>
	    <form name="goViewFrm">
	<input type="hidden" name="gymseq" /> 
	<input type="hidden" name="goBackURL" value="${requestScope.currentURL}"/> 
</form>
	    
</body>
</html>
	
	

	
	 
    