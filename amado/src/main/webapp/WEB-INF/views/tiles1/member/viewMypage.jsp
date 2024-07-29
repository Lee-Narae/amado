<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
</style>



<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	
$(document).ready(function(){
	
	$("button#myinfo").addClass('hover');
	$("#infoEdit").css({"font-weight": "bold"});

	
	// 첫화면 기본세팅
	$("select[name='speed']").val(${sessionScope.loginuser.speed});
	$("select[name='quick']").val(${sessionScope.loginuser.quick});
	$("select[name='power']").val(${sessionScope.loginuser.power});
	$("select[name='earth']").val(${sessionScope.loginuser.earth});
	$("select[name='stretch']").val(${sessionScope.loginuser.stretch});
	
	
	
	
	
	
	//-----------------메뉴버튼-----------------//
	//-----회원정보 버튼----//
	$(document).on("click","button#myinfo", function(e){
		
		$("button.mbtn").removeClass('hover');
		$(e.target).addClass('hover');
		
		// alert($(e.target).text());
		let v_html=``;
		v_html=`<button id="infoEdit" class='btn2'>회원 정보 수정</button>
	            <button id="pwdEdit" class='btn2'>비밀번호 수정</button>
	            <button id="exit" class='btn2'>회원탈퇴</button>`;
		   
		$("div#hrbtns").html(v_html);
		
		$("#infoEdit").css({"font-weight": "bold"});
		
		let v_html2=`<div class="item1">&nbsp;회원 정보 수정</div>
            <hr class="hr1">
            <div id="memberInfo">
            	<div class="tr" style="display: flex;">
            		<div class="title">아이디</div>
            		<div class="input">\${sessionScope.loginuser.userid}</div>
            	</div>
            	<div class="tr" style="display: flex;">
            		<div class="title">이름</div>
            		<div class="input">\${sessionScope.loginuser.name}</div>
            	</div>
            	<div class="tr" style="display: flex;">
            		<div class="title">이메일</div>
            		<div class="input"><input type="text" name="email" value="\${sessionScope.loginuser.email}"/><button type="button" class="btn btn-light btnInfoChange">이메일 중복확인</button></div>
            	</div>
            	<div class="tr" style="display: flex;">
            		<div class="title">주소</div>
            		<div class="input"><input type="text" id="postcode" name="postcode" value="\${sessionScope.loginuser.postcode }" readonly/><button type="button" class="btn btn-info btnInfoChange" onclick="searchAddress()">주소 검색</button></div>
            	</div>
            		<div style="margin-left: 18%; margin-bottom: 1%;"><input type="text" name="address" id="address" value="\${sessionScope.loginuser.address }" readonly/>&nbsp;<input type="text" name="detailaddress" id="detailaddress" placeholder="상세주소" value="\${sessionScope.loginuser.detailaddress}"/>&nbsp;<input type="text" name="extraaddress" id="extraaddress" value="\${sessionScope.loginuser.extraaddress }"/></div>
            	<div class="tr" style="display: flex;">
            		<div class="title">연락처</div>
            		<div class="input"><input type="text" name="phone1" value="\${sessionScope.loginuser}.substring(0, 3)" style="width: 10%; text-align: center;"/> - <input type="text" name="phone2" value="\${sessionScope.loginuser}.substring(0, 3)" style="width: 10%; text-align: center;"/> - <input type="text" name="phone3" value="\${sessionScope.loginuser}.substring(0, 3)" style="width: 10%; text-align: center;"/></div>
            	</div>
            	<div class="tr" style="display: flex;">
            		<div class="title">운동스킬</div>
            		<div class="input" style="width: 70%; height: 40px; display: flex;">
            			<div class="select">
            				<span>속력</span>
            				<select name="speed">
            					<option value="1">1</option>
            					<option value="2">2</option>
            					<option value="3">3</option>
            					<option value="4">4</option>
            					<option value="5">5</option>
            				</select>
            			</div>
            			<div class="select">
            				<span>순발력</span>
            				<select name="quick">
            					<option value="1">1</option>
            					<option value="2">2</option>
            					<option value="3">3</option>
            					<option value="4">4</option>
            					<option value="5">5</option>
            				</select>
            			</div>
            			<div class="select">
            				<span>근력</span>
            				<select name="power">
            					<option value="1">1</option>
            					<option value="2">2</option>
            					<option value="3">3</option>
            					<option value="4">4</option>
            					<option value="5">5</option>
            				</select>
            			</div>
            			<div class="select">
            				<span>지구력</span>
            				<select name="earth">
            					<option value="1">1</option>
            					<option value="2">2</option>
            					<option value="3">3</option>
            					<option value="4">4</option>
            					<option value="5">5</option>
            				</select>
            			</div>
            			<div class="select">
            				<span>유연성</span>
            				<select name="stretch">
            					<option value="1">1</option>
            					<option value="2">2</option>
            					<option value="3">3</option>
            					<option value="4">4</option>
            					<option value="5">5</option>
            				</select>
            			</div>
            		</div>
            	</div>
            	<div class="tr" style="display: flex;">
            		<div class="title">내 이미지</div>
            		<div class="input"><input type="file" name="memberImg" style="border: none;"/></div>
            	</div>
            	<div style="width: 100%; text-align: center; margin: 5% 0;">
            		<button type="button" class="btn btn-primary" onclick="infoEdit()">수정하기</button>
            		<button type="button" class="btn btn-secondary" onclick="javascript:history.back()">취소</button>
            	</div>
            </div>`;
		
		$("div#content").html(v_html2);
	});
	
	$(document).on("click","button#infoEdit", function(e){ //회원 정보 수정 눌렀을때
		
		$("button.btn2").css({"font-weight": "normal"});
		$(e.target).css({"font-weight": "bold"});
		
		let v_html2=``;
		v_html2=`<div class="item1">&nbsp;회원 정보 수정</div>
	            <hr class="hr1">
	            <br>`;
		
		$("div#content").html(v_html2);
	});
	
	$(document).on("click","button#pwdEdit", function(e){ //비밀번호 수정 눌렀을때
		
		$("button.btn2").css({"font-weight": "normal"});
		$(e.target).css({"font-weight": "bold"});
		
		let v_html2=``;
		v_html2=`<div class="item1">&nbsp;비밀번호 수정</div>
	            <hr class="hr1">
	            <br>`;
		
		$("div#content").html(v_html2);
	});
	
	$(document).on("click","button#exit", function(e){ //회원탈퇴 눌렀을때
		
		$("button.btn2").css({"font-weight": "normal"});
		$(e.target).css({"font-weight": "bold"});
		
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
		
		$("button.mbtn").removeClass('hover');
		$(e.target).addClass('hover');
		
		let v_html=``;
		v_html=`<button id="clubShow" class='btn2'>가입동호회 조회</button>
	            <button id="clubManage" class='btn2'>내 동호회 관리</button>`;
		
		$("div#hrbtns").html(v_html);
		
		$("#clubShow").css({"font-weight": "bold"});
		
		let v_html2=``;
		v_html2=`<div class="item1">&nbsp;가입동호회 조회</div>
	            <hr class="hr1">
	            <br>`;
		
		$("div#content").html(v_html2);
	});
	
	$(document).on("click","button#clubShow", function(e){ //가입동호회 조회 
		
		$("button.btn2").css({"font-weight": "normal"});
		$(e.target).css({"font-weight": "bold"});
		
		let v_html2=``;
		v_html2=`<div class="item1">&nbsp;가입동호회 조회 </div>
	            <hr class="hr1">
	            <br>`;
		
		$("div#content").html(v_html2);
		
	});
	$(document).on("click","button#clubManage", function(e){ //내 동호회 관리
		
		$("button.btn2").css({"font-weight": "normal"});
		$(e.target).css({"font-weight": "bold"});
		
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
		
		$("button.mbtn").removeClass('hover');
		$(e.target).addClass('hover');
		
		let v_html=``;
		v_html=`<button id='payList' class='btn2'>대관내역 조회</button>
	            <button id='gymManage' class='btn2'>내 체육관 관리</button>`;
		
		$("div#hrbtns").html(v_html);
		
		$("#payList").css({"font-weight": "bold"});
		
		let v_html2=``;
		v_html2=`<div class="item1">&nbsp;대관내역 조회</div>
	            <hr class="hr1">
	            <br>`;
		
		$("div#content").html(v_html2);
	});
	
	$(document).on("click","button#payList", function(e){ //대관내역 조회
		
		$("button.btn2").css({"font-weight": "normal"});
		$(e.target).css({"font-weight": "bold"});
		
		let v_html2=``;
		v_html2=`<div class="item1">&nbsp;대관내역 조회 </div>
	            <hr class="hr1">
	            <br>`;
		
		$("div#content").html(v_html2);
		
	});
	$(document).on("click","button#gymManage", function(e){ //내 체육관 관리
		
		$("button.btn2").css({"font-weight": "normal"});
		$(e.target).css({"font-weight": "bold"});
		
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
		
		$("button.mbtn").removeClass('hover');
		$(e.target).addClass('hover');
		
		let v_html=``;
		v_html=`<button id="inquiry" class='btn2'>1:1 문의 내역</button>`;
		
		$("div#hrbtns").html(v_html);
		
		$("#inquiry").css({"font-weight": "bold"});
		
		
		let v_html2=``;
		v_html2=`<div class="item1">&nbsp;1:1 문의 내역</div>
	            <hr class="hr1">
	            <br>`;
		
		$("div#content").html(v_html2);
		
	});
	//-----------------메뉴버튼-----------------//
	
	
});

function searchAddress() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("extraaddress").value = extraAddr;
            
            } else {
                document.getElementById("extraaddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('postcode').value = data.zonecode;
            document.getElementById("address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("detailaddress").focus();
        }
    }).open();
}
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
	            <div id='content' style="border:solid 1px red; width: 50%;  margin: 3% auto;" >
	                <div class="item1">&nbsp;회원 정보 수정</div>
	                <hr class="hr1">
	                <div id="memberInfo">
	                	<div class="tr" style="display: flex;">
	                		<div class="title">아이디</div>
	                		<div class="input">${sessionScope.loginuser.userid}</div>
	                	</div>
	                	<div class="tr" style="display: flex;">
	                		<div class="title">이름</div>
	                		<div class="input">${sessionScope.loginuser.name}</div>
	                	</div>
	                	<div class="tr" style="display: flex;">
	                		<div class="title">이메일</div>
	                		<div class="input"><input type="text" name="email" value="${sessionScope.loginuser.email}"/><button type="button" class="btn btn-light btnInfoChange">이메일 중복확인</button></div>
	                	</div>
	                	<div class="tr" style="display: flex;">
	                		<div class="title">주소</div>
	                		<div class="input"><input type="text" id="postcode" name="postcode" value="${sessionScope.loginuser.postcode }" readonly/><button type="button" class="btn btn-info btnInfoChange" onclick="searchAddress()">주소 검색</button></div>
	                	</div>
	                		<div style="margin-left: 18%; margin-bottom: 1%;"><input type="text" name="address" id="address" value="${sessionScope.loginuser.address }" readonly/>&nbsp;<input type="text" name="detailaddress" id="detailaddress" placeholder="상세주소" value="${sessionScope.loginuser.detailaddress}"/>&nbsp;<input type="text" name="extraaddress" id="extraaddress" value="${sessionScope.loginuser.extraaddress }"/></div>
	                	<div class="tr" style="display: flex;">
	                		<div class="title">연락처</div>
	                		<div class="input"><input type="text" name="phone1" value="${fn:substring(sessionScope.loginuser.mobile, 0, 3)}" style="width: 10%; text-align: center;"/> - <input type="text" name="phone2" value="${fn:substring(sessionScope.loginuser.mobile, 3, 7)}" style="width: 10%; text-align: center;"/> - <input type="text" name="phone3" value="${fn:substring(sessionScope.loginuser.mobile, 7, 11)}" style="width: 10%; text-align: center;"/></div>
	                	</div>
	                	<div class="tr" style="display: flex;">
	                		<div class="title">운동스킬</div>
	                		<div class="input" style="width: 70%; height: 40px; display: flex;">
	                			<div class="select">
	                				<span>속력</span>
	                				<select name="speed">
	                					<option value="1">1</option>
	                					<option value="2">2</option>
	                					<option value="3">3</option>
	                					<option value="4">4</option>
	                					<option value="5">5</option>
	                				</select>
	                			</div>
	                			<div class="select">
	                				<span>순발력</span>
	                				<select name="quick">
	                					<option value="1">1</option>
	                					<option value="2">2</option>
	                					<option value="3">3</option>
	                					<option value="4">4</option>
	                					<option value="5">5</option>
	                				</select>
	                			</div>
	                			<div class="select">
	                				<span>근력</span>
	                				<select name="power">
	                					<option value="1">1</option>
	                					<option value="2">2</option>
	                					<option value="3">3</option>
	                					<option value="4">4</option>
	                					<option value="5">5</option>
	                				</select>
	                			</div>
	                			<div class="select">
	                				<span>지구력</span>
	                				<select name="earth">
	                					<option value="1">1</option>
	                					<option value="2">2</option>
	                					<option value="3">3</option>
	                					<option value="4">4</option>
	                					<option value="5">5</option>
	                				</select>
	                			</div>
	                			<div class="select">
	                				<span>유연성</span>
	                				<select name="stretch">
	                					<option value="1">1</option>
	                					<option value="2">2</option>
	                					<option value="3">3</option>
	                					<option value="4">4</option>
	                					<option value="5">5</option>
	                				</select>
	                			</div>
	                		</div>
	                	</div>
	                	<div class="tr" style="display: flex;">
	                		<div class="title">내 이미지</div>
	                		<div class="input"><input type="file" name="memberImg" style="border: none;"/></div>
	                	</div>
	                	<div style="width: 100%; text-align: center; margin: 5% 0;">
	                		<button type="button" class="btn btn-primary" onclick="infoEdit()">수정하기</button>
	                		<button type="button" class="btn btn-secondary" onclick="javascript:history.back()">취소</button>
	                	</div>
	                </div>
	                
	            </div>
	        </div>
    	</div> 
    	
    </div>
</div>
