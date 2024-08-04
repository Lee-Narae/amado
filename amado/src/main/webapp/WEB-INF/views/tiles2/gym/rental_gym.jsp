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
<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.7.1.min.js"></script>
  <script type="text/javascript" src="<%= ctxPath%>/resources/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script>
  <script type="text/javascript" src="<%= ctxPath%>/resources/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>

<%-- <script type="text/javascript" src="<%= ctxPath%>/resources/js/myshop/categoryListJSON.js"></script> 
<script type="text/javascript" src="<%= ctxPath%>/resources/js/myshop/moreHomeScroll.js"></script> --%>
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
    
    
    if("${requestScope.searchWord}" != "" && "${requestScope.searchType}" != ""){
		$("input:text[name='searchWord']").val("${requestScope.searchWord}");
		$("select[name='searchType']").val("${requestScope.searchType}");
	}
	
	$("select[name='sizePerPage']").val("${requestScope.sizePerPage}");
	
	
    
});

$("select[name='sizePerPage']").bind('change', function(){
	const frm = document.member_search_frm;
	frm.submit();
});
    

// 검색 버튼 클릭 시 검증 후 폼 제출
function goSearch() {
    if ($("input:text[name='searchWord']").val() == "") {
        alert("검색어를 입력하세요.");
        return;
    }
    
 
    const frm = document.member_search_frm;
    frm.submit();
}


</script>
	<body>
	      <h1 class="text-center py-3">체육관 대관하기</h1>
	        <nav class="d-flex justify-content-end">
	            <button id="indoorBtn" class="btn btn-primary mx-2">실내 </button>
	            <button id="outdoorBtn" class="btn btn-secondary mx-2">실외 </button>
	        </nav>
	 <div class="search-box">
            <input type="text"  name="searchWord" id="searchWord" class="form-control" onclick="goSearch()" placeholder="검색">	
            <button class="btn btn-primary btn-circle">
  			<i class="fa-solid fa-magnifying-glass"></i>
 				 </button>
        </div>
	   
	    <br><br>
	    
	    
	    <section id="indoor" class="product-section container mt-4">
	        <div class="row">
				<c:forEach var="gym" items="${requestScope.allGymList}">
	            	<c:if test="${gym.insidestatus == '0' && gym.status =='1'}">
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
	           <%--  <c:forEach var="gym" items="${requestScope.allGymList} ">
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
	    </section>
	    
	    
	    <section id="outdoor" class="product-section container mt-4 hidden">
	        <div class="row">
	          <c:forEach var="gym" items="${requestScope.allGymList}">
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
	        
	        
	 
	    </section>
	    
	      <div id="pageBar" style="margin-left: 37%;">
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
	
	

	
	 
    