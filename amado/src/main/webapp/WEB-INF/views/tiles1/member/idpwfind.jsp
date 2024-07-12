<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>

<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" /> 
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
<style type="text/css">

@import url(https://fonts.googleapis.com/css?family=Lato:300);

.find {
border-bottom: solid 3px #8c8c8c;
width: 45%;
height: 60px;
align-content: center;
font-size: 17pt;
font-weight: bold;
color: #8c8c8c;
}

.find:hover{
color: #0076e4;
border-bottom: solid 3px #0076e4;
box-shadow: #8c8c8c 0px 10px 10px -10px;
cursor: pointer;
}

.findclick {
color: #0076e4;
border-bottom: solid 3px #0076e4;
box-shadow: #8c8c8c 0px 10px 10px -10px;
}

.first_td {
display: inline-block;
background-color: #8bdd27;
color: white;
width: 20%;
height: 40px;
border-radius: 30px;
align-content: center;
text-align: center;
margin-right: 3%;
font-weight: bold;
}

.first_td2 {
display: inline-block;
background-color: #0066ff;
color: white;
width: 20%;
height: 40px;
border-radius: 30px;
align-content: center;
text-align: center;
margin-right: 3%;
font-weight: bold;
}

input[name='name'],
input[name='name2']{
height: 40px;
border-radius: 30px;
width: 130px;
border: solid 1px gray;
padding-left: 5%;
}

input[name='userid']{
height: 40px;
border-radius: 30px;
width: 160px;
border: solid 1px gray;
padding-left: 5%;
}

input[name='email'],
input[name='email2']{
height: 40px;
border-radius: 30px;
width: 300px;
border: solid 1px gray;
padding-left: 5%;
margin-right: 3%;
}

input[name='idCertCode'],
input[name='pwCertCode'],
input[name='newpw']{
height: 40px;
border-radius: 30px;
width: 300px;
border: solid 1px gray;
padding-left: 5%;
margin-right: 3%;
}

#emailReg, #emailRegpw, #pwdReg {
font-size: 10pt;
color: red;
margin-left: 25%;
margin-top: 1%;
}

body > div.sweet-alert.showSweetAlert.visible > h2 {
font-size: 13pt;
}

/* 로더 */
.loader4{
  position: relative;
  width: 150px;
  height: 40px;
  align-content: center;
  top: 45%;
  top: -webkit-calc(50% - 10px);
  top: calc(50% - 10px);
  left: 25%;
  left: -webkit-calc(50% - 75px);
  left: calc(50% - 75px);

  background-color: rgba(255,255,255,0.2);
}

.loader4:before{
  align-content: center;
  content: "";
  position: absolute;
  background-color: #6699ff;
  top: 0px;
  left: 0px;
  height: 40px;
  width: 0px;
  z-index: 0;
  opacity: 1;
  -webkit-transform-origin:  100% 0%;
      transform-origin:  100% 0% ;
  -webkit-animation: loader4 10s ease-in-out infinite;
      animation: loader4 10s ease-in-out infinite;
}

.loader4:after{
  align-content: center;
  text-align: center;
  content: "LOADING ...";
  color: #6699ff;
  font-size: 20px;
  position: absolute;
  width: 100%;
  height: 40px;
  line-height: 20px;
  left: 0;
  top: 0;
}

@-webkit-keyframes loader4{
    0%{width: 0px;}
    70%{width: 100%; opacity: 1;}
    90%{opacity: 0; width: 100%;}
    100%{opacity: 0;width: 0px;}
}

@keyframes loader4{
    0%{width: 0px;}
    70%{width: 100%; opacity: 1;}
    90%{opacity: 0; width: 100%;}
    100%{opacity: 0;width: 0px;}
}

</style>

<script type="text/javascript">

let idFindCert = '';
let pwFindCert = '';
let useridForPw = '';

$(document).ready(function(){
	
	$("div.box").hide();
	$("div#findcontent_id").hide();
	$("div#findcontent_pw").hide();
	
	const way = '${requestScope.way}';
	
	if(way == 'id'){
		$("div.find").removeClass("findclick");
		$("#idfind").addClass("findclick");
		$("div#findcontent_id").show();
	}

	else {
		$("div.find").removeClass("findclick");
		$("#pwfind").addClass("findclick");
		$("div#findcontent_pw").show();
	}
	
	// id 찾기
	$("div#idfind").click(function(){
		location.href="IdPwfind.do?find=id";		
	});
	
	// pw 찾기
	$("div#pwfind").click(function(){
		location.href="IdPwfind.do?find=pw";
	});

	// email 정규표현식
	var reg = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	
	$("div#emailReg").hide();
	
	$("input[name='email']").keyup(function(){
		if(!reg.test($("input[name='email']").val().trim())){
			$("div#emailReg").show();
		}
		else{
			$("div#emailReg").hide();
		}
	});
	
	// email 정규표현식
	
	$("div#emailRegpw").hide();
	
	$("input[name='email2']").keyup(function(){
		if(!reg.test($("input[name='email2']").val().trim())){
			$("div#emailRegpw").show();
		}
		else{
			$("div#emailRegpw").hide();
		}
	});
	
	
	
	// id 찾기 인증코드 확인
	$(document).on("click", "button#codeCheck", function(){
		if($("input[name='idCertCode']").val().trim() == idFindCert){
			let viewId = `<div class="mt-5">회원님의 아이디는 "<span style="color: blue; font-size: 15pt; font-weight: bold;">leenr</span>" 입니다.</div>
				<button type="button" class="btn btn-primary btn-lg mt-2" onclick="location.href='<%=ctxPath%>/member/login.do'">로그인하러 가기</button>`;
			
			$("div#userIdDiv").html(viewId);
		}
		
		else{
			swal('인증코드가 일치하지 않습니다.');
		}
	});
	
	// pw 찾기 인증코드 확인
	$(document).on("click", "button#codeCheck2", function(){
		if($("input[name='pwCertCode']").val().trim() == pwFindCert){
			let viewPw = `<div class="mt-3">
				<span class="first_td2">새 비밀번호</span>
				<input type="password" name="newpw" maxlength="20"/>
				<button type="button" class="btn btn-danger btn-sm" id="newPwUpdate" onclick="newPwUpdate()">변경하기</button>
			</div>
<div id="pwdReg">비밀번호는 영문자, 숫자, 특수기호가 혼합된 8~15글자로 입력하세요.</div>`;
			
			$("div#PwDiv").html(viewPw);
		}
		else {
			swal('인증코드가 일치하지 않습니다.');
		}
		
	});
	
	// new pw 정규표현식
	var regExp_pwd = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/;
	
	$("div#pwdReg").hide();
	
	$(document).on("keyup", "input[name='newpw']", function(){
		
		if(!regExp_pwd.test($("input[name='newpw']").val().trim())){
			$("div#pwdReg").show();
		}
		else{
			$("div#pwdReg").hide();
		}
	});
	
});


function newPwUpdate(){
	
	const newpw = $("input[name='newpw']").val().trim();
	
	// 유효성 검사
	if(newpw == ''){
		swal('비밀번호를 입력하세요.');
		$("input[name='newpw']").focus();
		return;
	}
	
	// 정규표현식 검사
	const regExp_pwd = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
	if(!regExp_pwd.test(newpw)){
		swal('올바르지 않은 비밀번호 형식입니다.');
		$("input[name='newpw']").val('').focus();
		return;
	}
	
	
	// ajax
	$.ajax({
		url: "<%=ctxPath%>/member/findPwUpdatePw.do",
		type: "post",
		data: {"password": newpw, "userid": useridForPw},
		dataType: "json",
		success: function(json){
			
			if(json.n == 1){
				alert('새로운 비밀번호로 변경되었습니다. 다시 로그인하세요.');
				location.href = "login.do";
			}
			
			else if(json.n == 2){
				alert('비밀번호 변경이 실패하였습니다. 다시 진행해주세요.');
				location.href = "IdPwfind.do?find=pw";
			}
			
			else{
				alert('기존 비밀번호와 동일한 비밀번호로는 변경할 수 없습니다.');
				$("input[name='newpw']").val('').focus();
			}
			
		},
		error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}
	});
	
	
}

function idFindSendEmail(){
	// 유효성 검사
	const name = $("input[name='name']").val().trim();
	const email = $("input[name='email']").val().trim();
	
	if(name == ''){
		swal('이름을 입력하세요.');
		return;
	}
	
	if(email == ''){
		swal('이메일을 입력하세요.');
		return;
	}

	var reg = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

	if(!reg.test($("input[name='email']").val().trim())){
		$("div#emailReg").show();
		return;
	}
	
	// ajax
	
	let userid = '';
	
	$.ajax({
		url: "<%=ctxPath%>/member/findId.do",
		data: {"name":name, "email":email},
		dataType: "json",
		type: "post",
		success: function(json){

			if(json.exist == 'no'){
				swal(`입력하신 내용에 해당하는
						회원 정보가 없습니다.`);
				$("input[name='name']").val("");
				$("input[name='email']").val("");
				return;
			}
			
			else { // 실제 회원정보가 있을 경우 이메일 인증 진행
				
				userid = json.userid;
				// console.log(userid);
				
				$("div.box").show();
			
				$.ajax({
					url: "<%=ctxPath%>/member/idFind_sendEmail.do",
					data: {"name":name, "email":email},
					dataType: "json",
					type: "post",
					success: function(json){
						$("div.box").hide();
						
						if(json.success == 'yes'){
							$("button#sendEmail").hide();
							// console.log(JSON.stringify(json));
							// {"success":"yes","certification_code":"igoeq7711504"}
							
							idFindCert = json.certification_code;
							let html = `<div class="mt-5">
								<div align="center" class="mb-2">이메일로 인증코드가 발송되었습니다. 인증코드를 입력하세요.</div>
								<span class="first_td">인증코드</span>
								<input type="text" name="idCertCode" maxlength="20" />
								<button type="button" class="btn btn-info btn-sm" id="codeCheck">확인</button>
							</div>`;
							
							$("div#afterIdFindEmail").html(html);
						}
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
				});
				
			}
			
		},
		error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}
	});
}


function pwFindSendEmail(){
	
	// 유효성 검사
	const name2 = $("input[name='name2']").val().trim();
	const email2 = $("input[name='email2']").val().trim();
	const userid2 = $("input[name='userid']").val().trim();
	
	if(name2 == ''){
		swal('이름을 입력하세요.');
		return;
	}

	if(userid2 == ''){
		swal('아이디를 입력하세요.');
		return;
	}
	
	if(email2 == ''){
		swal('이메일을 입력하세요.');
		return;
	}
	
	var reg = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

	if(!reg.test($("input[name='email2']").val().trim())){
		$("div#emailRegpw").show();
		return;
	}
	
	// ajax
	$.ajax({
		url: "<%=ctxPath%>/member/findpw.do",
		data: {"name":name2, "userid": userid2, "email":email2},
		dataType: "json",
		type: "post",
		success: function(json){

			useridForPw = json.userid;
			
			if(json.exist == 'no'){
				swal(`입력하신 내용에 해당하는
						회원 정보가 없습니다.`);
				$("input[name='name2']").val("");
				$("input[name='userid']").val("");
				$("input[name='email2']").val("");
				return;
			}
			
			else { // 실제 회원정보가 있을 경우 이메일 인증 진행
				
				$("div.box").show();
			
				$.ajax({
					url: "<%=ctxPath%>/member/pwFind_sendEmail.do",
					data: {"email": email2},
					dataType: "json",
					type: "post",
					success: function(json){
						$("div.box").hide();
						
						if(json.success == 'yes'){
							$("button#pwsendEmail").hide();
							// console.log(JSON.stringify(json));
							// {"success":"yes","certification_code":"igoeq7711504"}
							
							pwFindCert = json.certification_code2;
							let html = `<div class="mt-3">
								<div align="center" class="mb-2">이메일로 인증코드가 발송되었습니다. 인증코드를 입력하세요.</div>
								<span class="first_td">인증코드</span>
								<input type="text" name="pwCertCode" maxlength="20" />
								<button type="button" class="btn btn-info btn-sm" id="codeCheck2">확인</button>
							</div>`;
							
							$("div#afterPwFindEmail").html(html);
						}
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
				});
				
			}
			
		},
		error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}
	});
	
	
}
</script>


<div id="wrap" style="width: 100%; height: 700px; background-color: #f8fcff; align-content: center; " align="center">

<div id="idpwfind" style="border-radius: 30px; background-color: white; width: 40%; height: 550px; box-shadow: 0px 4px 35px #00000014; padding-top: 1.5%;">

<div id="toptitle" style="width: 80%; display: flex; justify-content: space-between;">
<div id="idfind" class="find">아이디 찾기</div>
<div id="pwfind" class="find">비밀번호 찾기</div>
</div>

<div id="findcontent_id" style="width: 80%; height: 400px; margin-top: 3%; padding: 5% 0 0 5%;" align="left">

<div>
	<span class="first_td">이름</span>
	<input type="text" name="name" maxlength="10" />
</div>
<div class="mt-3">
	<span class="first_td">이메일</span>
	<input type="text" name="email" maxlength="50"/>
	<button type="button" class="btn btn-info btn-sm" id="sendEmail" onclick="idFindSendEmail()">인증하기</button>
</div>
<div id="emailReg">올바르지 않은 이메일 형식입니다.</div>

<div id="afterIdFindEmail">

</div>
<div id="userIdDiv" align="center">
	
</div>

</div>


<div id="findcontent_pw" style="width: 80%; height: 400px; margin-top: 3%; padding: 5% 0 0 5%;" align="left">

<div>
	<span class="first_td">이름</span>
	<input type="text" name="name2" maxlength="10" />
</div>
<div class="mt-3">
	<span class="first_td">아이디</span>
	<input type="text" name="userid" maxlength="20" />
</div>
<div class="mt-3">
	<span class="first_td">이메일</span>
	<input type="text" name="email2" maxlength="50"/>
	<button type="button" class="btn btn-info btn-sm" id="pwsendEmail" onclick="pwFindSendEmail()">인증하기</button>
</div>
<div id="emailRegpw">올바르지 않은 이메일 형식입니다.</div>

<div id="afterPwFindEmail">

</div>
<div id="PwDiv">

</div>
</div>







</div>


</div>

    <div class="box" style="position: fixed; top: 50%; left: 46%;">
      <div class="loader4"></div>
    </div>

