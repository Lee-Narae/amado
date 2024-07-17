<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
   String ctxPath = request.getContextPath();
%>    


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
</style>




<script type="text/javascript">
	
$(document).ready(function(){
	
	//-----------------메뉴버튼-----------------//
	//-----회원정보 버튼----//
	$(document).on("click","button#myinfo", function(e){
		// alert($(e.target).text());
		let v_html=``;
		v_html=`<button id="infoEdit" class='btn2'>회원 정보 수정</button>
	            <button id="pwdEdit" class='btn2'>비밀번호 수정</button>
	            <button id="exit" class='btn2'>회원탈퇴</button>`;
		
		$("div#hrbtns").html(v_html);
		
		let v_html2=``;
		v_html2=`<div class="item1">&nbsp;회원 정보 수정</div>
	            <hr class="hr1">
	            <br>`;
		
		$("div#content").html(v_html2);
	});
	
	$(document).on("click","button#infoEdit", function(e){ //회원 정보 수정 눌렀을때
		let v_html2=``;
		v_html2=`<div class="item1">&nbsp;회원 정보 수정</div>
	            <hr class="hr1">
	            <br>`;
		
		$("div#content").html(v_html2);
	});
	
	$(document).on("click","button#pwdEdit", function(e){ //비밀번호 수정 눌렀을때
		let v_html2=``;
		v_html2=`<div class="item1">&nbsp;비밀번호 수정</div>
	            <hr class="hr1">
	            <br>`;
		
		$("div#content").html(v_html2);
	});
	
	$(document).on("click","button#exit", function(e){ //회원탈퇴 눌렀을때
		let v_html2=``;
		v_html2=`<div class="item1">&nbsp;회원탈퇴</div>
	            <hr class="hr1">
	            <br>`;
		
		$("div#content").html(v_html2);
	});
	//-----회원정보 버튼----//
	
	
	//-----동호회관리 버튼----//
	$(document).on("click","button#myclub", function(e){ 
		// alert($(e.target).text());
		let v_html=``;
		v_html=`<button id="clubShow" class='btn2'>가입동호회 조회</button>
	            <button id="clubManage" class='btn2'>내 동호회 관리</button>`;
		
		$("div#hrbtns").html(v_html);
		
		let v_html2=``;
		v_html2=`<div class="item1">&nbsp;가입동호회 조회</div>
	            <hr class="hr1">
	            <br>`;
		
		$("div#content").html(v_html2);
	});
	
	$(document).on("click","button#clubShow", function(e){ //가입동호회 조회 
		let v_html2=``;
		v_html2=`<div class="item1">&nbsp;가입동호회 조회 </div>
	            <hr class="hr1">
	            <br>`;
		
		$("div#content").html(v_html2);
		
	});
	$(document).on("click","button#clubManage", function(e){ //내 동호회 관리
		let v_html2=``;
		v_html2=`<div class="item1">&nbsp;내 동호회 관리 </div>
	            <hr class="hr1">
	            <br>`;
		
		$("div#content").html(v_html2);
		
	});
	//-----동호회관리 버튼----//
	
	
	//-----체육관관리 버튼----//
	$(document).on("click","button#mygym", function(e){
		// alert($(e.target).text());
		let v_html=``;
		v_html=`<button id='payList' class='btn2'>대관내역 조회</button>
	            <button id='gymManage' class='btn2'>내 체육관 관리</button>`;
		
		$("div#hrbtns").html(v_html);
		
		let v_html2=``;
		v_html2=`<div class="item1">&nbsp;대관내역 조회</div>
	            <hr class="hr1">
	            <br>`;
		
		$("div#content").html(v_html2);
	});
	
	$(document).on("click","button#payList", function(e){ //대관내역 조회
		let v_html2=``;
		v_html2=`<div class="item1">&nbsp;대관내역 조회 </div>
	            <hr class="hr1">
	            <br>`;
		
		$("div#content").html(v_html2);
		
	});
	$(document).on("click","button#gymManage", function(e){ //내 체육관 관리
		let v_html2=``;
		v_html2=`<div class="item1">&nbsp;내 체육관 관리</div>
	            <hr class="hr1">
	            <br>`;
		
		$("div#content").html(v_html2);
		
	});
	//-----체육관관리 버튼----//
	
	
	
	//-----기타 버튼----//
	$(document).on("click","button#etc", function(e){ 
		// alert($(e.target).text());
		let v_html=``;
		v_html=`<button class='btn2'>1:1 문의 내역</button>`;
		
		$("div#hrbtns").html(v_html);
		
		let v_html2=``;
		v_html2=`<div class="item1">&nbsp;1:1 문의 내역</div>
	            <hr class="hr1">
	            <br>`;
		
		$("div#content").html(v_html2);
		
	});
	//-----------------메뉴버튼-----------------//
	
	
});


</script>

<div id="container">
    <div style="border:solid 0px red;">
        <%-- 마이페이지 서브메뉴 --%>
        <div id="menu" style="border:solid 0px black; display: flex; margin-top: 3%; ">
            <div style="border:solid 0px blue; width: 50%; display: flex; margin: 0 auto;" >
                  <button id="myinfo" class='mbtn' style="border-bottom: solid 3px #05203c;"><div><img src="<%= ctxPath%>/resources/images/zee/person2.png"></div>회원정보</button>
                  <button id="myclub" class='mbtn' style="border-bottom: solid 3px #05203c;"><div><img src="<%= ctxPath%>/resources/images/zee/team.png"></div>동호회 관리</button>
                  <button id="mygym" class='mbtn' style="border-bottom: solid 3px #05203c;"><div><img style="height:65px;"src="<%= ctxPath%>/resources/images/zee/court.png"></div>체육관 관리</button>
                  <button id="etc" class='mbtn' style="border-bottom: solid 3px #05203c;"><div><img src="<%= ctxPath%>/resources/images/zee/etc.png"></div>기타</button>
            </div>
        </div>
         
        <br>
        
        <div>
	       <div id="hr2-container">
	            <div id="hrbtns">
	                <button id="infoEdit" class='btn2'>회원 정보 수정</button>
	                <button id="pwdEdit" class='btn2'>비밀번호 수정</button>
	                <button id="exit" class='btn2'>회원탈퇴</button>
	            </div>
	        </div>

	       
	        <div>
	            <div id='content' style="border:solid 0px black; width: 50%;  margin: 3% auto;" >
	                <div class="item1">&nbsp;회원 정보 수정</div>
	                <hr class="hr1">
	                <br>
	            </div>
	        </div>
    	</div> 
    	
    </div>
</div>
