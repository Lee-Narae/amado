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
    
    #pwdReg, #pwdCheck {
font-size: 10pt;
color: red;
margin-top: 1%;
}
</style>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">

let emailDuplicate = false;

$(document).ready(function(){
	
	// 첫화면 기본세팅
	$("button#myinfo").addClass('hover');
	$("#infoEdit").css({"font-weight": "bold"});
	$("select[name='speed']").val(${sessionScope.loginuser.speed});
	$("select[name='quick']").val(${sessionScope.loginuser.quick});
	$("select[name='power']").val(${sessionScope.loginuser.power});
	$("select[name='earth']").val(${sessionScope.loginuser.earth});
	$("select[name='stretch']").val(${sessionScope.loginuser.stretch});
	$("#content2").hide();
	$("#content3").hide();
	$("div#pwdCheck").hide();
	
	
	// 회원정보 탭
	$(document).on("click","button#myinfo", function(e){
		
		$("button.btn2").removeClass('hover');
		$(e.target).addClass('hover');
		
		$("#content2").hide();
		$("#content3").hide();
		$("#content1").show();
	
	});
	
	
	// 회원정보 수정
	$(document).on("click","button#infoEdit", function(e){
		
		$("button.btn2").removeClass('hover');
		$(e.target).addClass('hover');
		
		$("#content3").hide();
		$("#content2").hide();
		$("#content1").show();
		
	});
	
	// 비밀번호 수정
	$(document).on("click","button#pwdEdit", function(e){
		
		$("button.btn2").removeClass('hover');
		$("#infoEdit").css({"font-weight": ""});
		$(e.target).addClass('hover');
		
		$("#content3").hide();
		$("#content1").hide();
		$("#content2").show();
		
	});
	
	// 회원탈퇴
	$(document).on("click","button#exit", function(e){
		
		$("button.btn2").removeClass('hover');
		$("#infoEdit").css({"font-weight": ""});
		$(e.target).addClass('hover');
		
		$("#content2").hide();
		$("#content1").hide();
		$("#content3").show();
		
	});
	
	var regExp_pwd = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/;
	$("div#pwdReg").hide();
	// 비밀번호 변경
	$("input[name='newPw']").keyup(function(e){
		if(!regExp_pwd.test($("input[name='newPw']").val().trim())){
			$("div#pwdReg").show();
		}
		else{
			$("div#pwdReg").hide();
		}
	});
	
	
	$("input[name='pwCheck']").keyup(function(e){
		if($("input[name='pwCheck']").val().trim() != $("input[name='newPw']").val().trim()){
			$("div#pwdCheck").show();
		}
		
		else{
			$("div#pwdCheck").hide();
		}
	});
	
	
	$(document).on("change", "input[name='attach']", function(e){
		const input_file = $(e.target).get(0);
		const fileReader = new FileReader();
        fileReader.readAsDataURL(input_file.files[0]);
        
        fileReader.onload = function(){
        	document.getElementById("memberImgView").src = fileReader.result;
        };
        
	});
	
	
	
	
}); // document.ready


function emailDuplicateCheck(){
	
	let email = $("input[name='email']").val().trim();
	
	if(email == ''){
		alert("이메일을 입력하세요.");
		return;
	}
	
	$.ajax({
		url: "<%=ctxPath%>/emailDuplicateCheck.do",
		data: {"email": email},
        type: "post",
        async : true,
        dataType : "json",                 
        success : function(json) {
            
            if(json.n == 0) {
                $("span#emailCheckResult").html(email + "은(는) 사용 가능한 이메일입니다.").css({"color":"blue", "font-size": "10pt"});
                emailDuplicate = true;
            }
            else {
                $("span#emailCheckResult").html(email + "은(는) 이미 사용 중이므로 다른 이메일을 입력하세요.").css({"color":"red", "font-size": "10pt"});
                $("input[name='email']").val("");
                emailDuplicate = false;
            }
        },
        
        error: function(request, status, error) {
            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
       }
	});
}



function infoEdit(){
	
	const email = $("input[name='email']").val().trim();
	const postcode = $("input[name='postcode']").val().trim();
	const address = $("input[name='address']").val().trim();
	const detailaddress = $("input[name='detailaddress']").val().trim();
	const extraaddress = $("input[name='extraaddress']").val().trim();
	const speed = $("select[name='speed']").val().trim();
	const quick = $("select[name='quick']").val().trim();
	const power = $("select[name='power']").val().trim();
	const earth = $("select[name='earth']").val().trim();
	const stretch = $("select[name='stretch']").val().trim();
	
	if(email == ''){
		alert('이메일을 입력하세요.');
		return;
	}
	if(emailDuplicate == false){
		alert('이메일이 중복되어 사용하실 수 없습니다.');
		return;
	}
	if(postcode == '' || address == '' || detailaddress == '' || extraaddress == ''){
		alert('주소를 입력하세요.');
		return;
	}
	
	// form 전송
	const frm = document.infoEditFrm;
	frm.method = "post";
	frm.action = "<%= ctxPath%>/member/infoEdit.do";
    frm.submit();
	
}

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


function pwdChange(){
	
	const password = $("input[name='password']").val().trim();
	const newPw = $("input[name='newPw']").val().trim();
	
	if(password == newPw){
		alert('동일한 비밀번호로 변경할 수 없습니다.');
		return;
	}
	
	$.ajax({
		url: "<%=ctxPath%>/member/changePw.do",
		data: {"password": password, "newPw": newPw},
		type: "post",
		dataType: "json",
		success: function(json){
			if(json.n == 1){
				alert('비밀번호가 변경되었습니다. 새로 로그인해주세요.');
				location.href="<%=ctxPath%>/index.do";
			}
			else {
				alert('비밀번호가 일치하지 않습니다.');
				$("input[name='password']").val('').focus();
				$("input[name='newPw']").val('');
				$("input[name='pwCheck']").val('');
			}
		},
		error: function(request, status, error) {
            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
        }
	});
	
}


function memberQuit(){
	
	const pwd = $("input[name='password2']").val().trim();
	
	if(pwd == ''){
		alert('비밀번호를 입력하세요.');
		return;
	}
	
	$.ajax({
		url: "<%=ctxPath%>/member/checkPw.do",
		data: {"pwd": pwd},
		type: "post",
		dataType: "json",
		success: function(json){
			
			if(json.n == 1){
				Swal.fire({
					  title: "정말 탈퇴하시겠습니까?",
					  text: "AmaDo 회원 혜택을 잃게 됩니다.",
					  icon: "warning",
					  showCancelButton: true,
					  confirmButtonColor: "#3085d6",
					  cancelButtonColor: "#d33",
					  confirmButtonText: "네, 탈퇴합니다.",
					  cancelButtonText: "취소"
					}).then((result) => {
					  if (result.isConfirmed) {
						  
						  $.ajax({
							  
							  url: "<%=ctxPath%>/member/memberQuit.do",
							  data: {"userid": '${sessionScope.loginuser.userid}'},
							  dataType: "json",
							  type: "post",
							  success: function(json2){
								  
								  if(json2.n ==1){
									  Swal.fire({ title: "탈퇴 완료!", text: "그동안 이용해주셔서 감사합니다.", icon: "success"}).then(okay => {
										  if (okay) {
											    window.location.href = "<%=ctxPath%>/index.do";
											  }
									  });
									  
									  
									  
								  }
								  
								  else {
									  alert('내부 오류로 인해 탈퇴처리가 실패하였습니다. 다시 시도해주세요.');
								  }
								  
							  },
							  error: function(request, status, error) {
						            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
						        }
							  
						  });
					    
					  }
					});
			}
			
			else{
				alert('비밀번호가 일치하지 않습니다.');
				$("input[name='password2']").val('');
				return;
			}
			
		},
		error: function(request, status, error) {
            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
        }
	});
	
}

</script>




<div id="container">
    <div style="border:solid 0px red;">
        <%-- 마이페이지 서브메뉴 --%>
        <div id="menu" style="border:solid 0px black; display: flex; margin-top: 3%; ">
            <div style="border:solid 0px blue; width: 50%; display: flex; margin: 0 auto;" >
                  <button id="myinfo" class='mbtn' style="border-bottom: solid 3px #05203c;" onclick="location.href='<%=ctxPath%>/member/myPage.do'"><div><img src="<%= ctxPath%>/resources/images/zee/person2.png"></div>회원정보</button>
                  <button id="myclub" class='mbtn' style="border-bottom: solid 3px #05203c;" onclick="location.href='<%=ctxPath%>/member/myPage_club.do'"><div><img src="<%= ctxPath%>/resources/images/zee/team.png"></div>동호회 관리</button>
                  <button id="mygym" class='mbtn' style="border-bottom: solid 3px #05203c;" onclick="location.href='<%=ctxPath%>/member/myPage_gymview.do'"><div><img style="height:65px;"src="<%= ctxPath%>/resources/images/zee/court.png"></div>체육관 관리</button>
                  <button id="etc" class='mbtn' style="border-bottom: solid 3px #05203c;" onclick="location.href='<%=ctxPath%>/member/myPage_etc.do'"><div><img src="<%= ctxPath%>/resources/images/zee/etc.png"></div>기타</button>
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
	            <div id="content1" style="width: 50%;  margin: 3% auto;" >
	                <div class="item1">&nbsp;회원 정보 수정</div>
	                <hr class="hr1">
	                <div id="memberInfo">
	                <form name="infoEditFrm" enctype="multipart/form-data">
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
	                		<div class="input"><input type="text" name="email" value="${sessionScope.loginuser.email}"/><button type="button" class="btn btn-light btnInfoChange" onclick="emailDuplicateCheck()">이메일 중복확인</button></div>
	                	</div>
	                		<span style="margin-left: 18%;" id="emailCheckResult"></span>
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
	                		<div class="input"><input type="file" name="attach" style="border: none;" accept='image/*'/></div>
	                	</div>
                		<div style="border: solid 1px #d4d4d4; width: 11%; height: 100px; border-radius: 100%; margin-left: 18%; overflow: hidden; align-content: center;">
                			<c:if test="${not empty sessionScope.loginuser.memberimg}">
                				<img id="memberImgView" style="width: 100%;" src="<%=ctxPath%>/resources/images/uploadImg/${sessionScope.loginuser.memberimg}" />
                			</c:if>
                			<c:if test="${empty sessionScope.loginuser.memberimg}">
                				<img id="memberImgView" style="width: 100%;" src="<%=ctxPath%>/resources/images/no_img.jpg" />
                			</c:if>
                		</div>
	                	<div style="width: 100%; text-align: center; margin: 5% 0;">
	                		<button type="button" class="btn btn-primary" onclick="infoEdit()">수정하기</button>
	                		<button type="button" class="btn btn-secondary" onclick="javascript:history.back()">취소</button>
	                	</div>
                	</form>
	                </div>
	                
	            </div>
	            
	            
	            
	            <div id="content2" style="width: 50%;  margin: 3% auto;" >
	                <div class="item1">&nbsp;비밀번호 변경</div>
	                <hr class="hr1">
	                <div id="memberInfo" align="center">
	                	<table style="width: 80%;">
	                		<tbody>
	                			<tr style="height: 100px;">
	                				<td width="50">현재 비밀번호</td>
	                				<td width="50"><input type="password" name="password" /></td>
	                			</tr>
	                			<tr style="height: 100px;">
	                				<td>새 비밀번호</td>
	                				<td><input type="password" name="newPw" /><div id="pwdReg">비밀번호는 영문자, 숫자, 특수기호가 혼합된 8~15글자로 입력하세요.</div></td>
	                			</tr>
	                			<tr>
	                				<td>비밀번호 확인</td>
	                				<td><input type="password" name="pwCheck" /><div id="pwdCheck">비밀번호가 일치하지 않습니다.</div></td>
	                			</tr>
	                		</tbody>
	                	</table>
	                	
	                	<div style="width: 100%; text-align: center; margin: 5% 0;">
	                		<button type="button" class="btn btn-primary" onclick="pwdChange()">변경하기</button>
	                		<button type="button" class="btn btn-secondary" onclick="javascript:history.back()">취소</button>
	                	</div>
	                	
	                </div>
	                
	            </div>
	            
	            
	            
	            <div id="content3" style="width: 50%;  margin: 3% auto;" >
	                <div class="item1">&nbsp;회원 탈퇴</div>
	                <hr class="hr1">
	                <div id="memberInfo">
	                	<table style="width: 80%;">
	                		<tbody>
	                			<tr style="height: 100px;">
	                				<td width="50">비밀번호</td>
	                				<td width="50"><input type="password" name="password2" /></td>
	                			</tr>
	                		</tbody>
	                	</table>
	                	
	                	<div style="width: 100%; text-align: center; margin: 5% 0;">
	                		<button type="button" class="btn btn-primary" onclick="memberQuit()">탈퇴하기</button>
	                		<button type="button" class="btn btn-secondary" onclick="javascript:history.back()">취소</button>
	                	</div>
	                	
	                </div>
	                
	            </div>
	            
	        </div>
    	</div> 
    	
    </div>
</div>
