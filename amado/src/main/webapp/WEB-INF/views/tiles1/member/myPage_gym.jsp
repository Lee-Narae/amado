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
    
body {
    font-family: Arial, sans-serif;
    background-color: #f0f4f7;
    color: #333;
    margin: 0;
    padding: 0;
}

.container {
    max-width: 800px;
    margin: 50px auto;
    background-color: #fff;
    padding: 20px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
}

.container h1 {
    text-align: center;
    color: #007BFF;
    margin-bottom: 20px;
}

.form-group {
    display: flex;
    align-items: center;
    margin-bottom: 15px;
}

.form-group label {
    width: 120px;
    font-weight: bold;
}

.form-group input[type="text"],
.form-group input[type="file"],
.form-group select,
.form-group textarea {
    flex: 1;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 16px;
}

.form-group textarea {
    resize: vertical;
}

button {
    display: block;
    width: 100%;
    padding: 10px;
    background-color: #007BFF;
    color: #fff;
    border: none;
    border-radius: 4px;
    font-size: 18px;
    cursor: pointer;
}

button:hover {
    background-color: #0056b3;
}

    
</style>


<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	
	// 첫화면 기본세팅
	$("button#mygym").addClass('hover');
	$("#payList").css({"font-weight": "bold"});
	
	
});

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
	                <button id="gymManage" class='btn2'>내 체육관 관리</button>
	            </div>
	        </div>

	       
	        <div>
<!-- 	            <div id="content1" style="border:solid 1px red; width: 50%;  margin: 3% auto;" >
	                <div class="item1">&nbsp;대관내역 조회</div>
	                <hr class="hr1">
	                <div id="memberInfo">
	                	
	                </div>
	                
	            </div> -->
	            
	            
	            
	            <div id="content2" style=" width: 50%;  margin: 3% auto;" >
	                <div class="item1">&nbsp;내 체육관 관리</div>
	                <hr class="hr1">
	                <div id="memberInfo">
	                	
	                </div>
	                
	            </div>
	            
	<div class="container">
        <h1>체육관 수정 페이지</h1>
        <form>
            <div class="form-group">
                <label for="gymName">체육관명</label>
                <input type="text" id="gymName" name="gymName" required>
            </div>
            <div class="form-group">
                <label for="managerId">담당자아이디</label>
                <input type="text" id="managerId" name="managerId" required>
            </div>
            <div class="form-group">
                <label for="address">주소</label>
                <div class="address-group">
                    <input type="text" id="address" name="address" required>
                    <button type="button" id="findAddress">주소찾기</button>
                </div>
            </div>
            <div class="form-group">
                <label for="zipCode">우편번호</label>
                <input type="text" id="zipCode" name="zipCode" required>
            </div>
            <div class="form-group">
                <label for="detailedAddress">상세주소</label>
                <input type="text" id="detailedAddress" name="detailedAddress" required>
            </div>
            <div class="form-group">
                <label for="indoorOutdoor">실내/실외</label>
                <select id="indoorOutdoor" name="indoorOutdoor" required>
                    <option value="indoor">실내</option>
                    <option value="outdoor">실외</option>
                </select>
            </div>
            <div class="form-group">
                <label for="cost">비용</label>
                <input type="text" id="cost" name="cost" required>
            </div>
            <div class="form-group">
                <label for="capacity">인원수</label>
                <input type="text" id="capacity" name="capacity" required>
            </div>
            <div class="form-group">
                <label for="image">이미지</label>
                <input type="file" id="image" name="image" required>
            </div>
            <div class="form-group">
                <label for="additionalImage">추가이미지</label>
                <input type="file" id="additionalImage" name="additionalImage">
            </div>
            <div class="form-group">
                <label for="spaceInfo">공간정보</label>
                <textarea id="spaceInfo" name="spaceInfo" rows="4" required></textarea>
            </div>
            <div class="form-group">
                <label for="caution">주의사항</label>
                <textarea id="caution" name="caution" rows="4" required></textarea>
            </div>
            <button type="submit">수정하기</button>
        </form>
    </div>
	            
	            
	        </div>
    	</div> 
    	
    </div>
</div>
