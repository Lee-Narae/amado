<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
   String ctxPath = request.getContextPath();
%>      
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AmaDo</title>
  <!-- Required meta tags -->
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  
  <%-- Bootstrap CSS --%>
  <link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/bootstrap-4.6.2-dist/css/bootstrap.min.css" >
 
  <%-- Font Awesome 6 Icons --%>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

  <%-- Optional JavaScript --%>
  <script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.7.1.min.js"></script>
  <script type="text/javascript" src="<%= ctxPath%>/resources/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script>
  <script type="text/javascript" src="<%= ctxPath%>/resources/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script> 

  <%-- 스피너 및 datepicker 를 사용하기 위해 jQueryUI CSS 및 JS --%>
  <link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
  <script type="text/javascript" src="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>

  <%-- === ajax로 파일을 업로드 할때 가장 널리 사용하는 방법 : ajaxForm === --%> 
  <script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery.form.min.js"></script> 


<style type="text/css">
@font-face {
    font-family: 'MYArirang_gothic';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2206-02@1.0/MYArirang_gothic.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}

*{font-family: 'MYArirang_gothic';}

.login {
  background-color: #f8fcff;
  display: flex;
  flex-direction: row;
  justify-content: center;
  width: 100%;
}

.login .div {
  background-color: #f8fcff;
  width: 1920px;
  height: 900px;
  position: relative;
}

.login .logo {
  position: absolute;
  width: 172px;
  height: 86px;
  top: 805px;
  left: 1727px;
  object-fit: cover;
}

.login .overlap {
  position: absolute;
  width: 539px;
  height: 609px;
  top: 145px;
  left: 682px;
}

.login .group {
  position: absolute;
  width: 539px;
  height: 609px;
  top: 0;
  left: 0;
}

.login .group-2 {
  position: relative;
  height: 609px;
  background-color: #ffffff;
  border-radius: 40px;
  box-shadow: 0px 4px 35px #00000014;
}

.login .div-wrapper {
  position: absolute;
  width: 290px;
  height: 30px;
  top: 80px;
  left: 45px;
}

.login .text-wrapper {
  position: absolute;
  top: 0;
  left: 0;
  font-weight: 400;
  color: #000000;
  font-size: 20px;
  letter-spacing: 0;
  line-height: normal;
}

.login .group-3 {
  position: absolute;
  width: 451px;
  height: 92px;
  top: 202px;
  left: 44px;
}

.login .text-wrapper-2 {
  position: absolute;
  top: -3px;
  left: 0;
  font-weight: 400;
  color: #000000;
  font-size: 16px;
  letter-spacing: 0;
  line-height: normal;
}

.login .overlap-group {
  position: absolute;
  width: 451px;
  height: 57px;
  top: 35px;
  left: 0;
  background-color: #ffffff;
  border-radius: 9px;
  border: 1px solid;
  border-color: #4285f4;
}

.login .text-wrapper-3 {
  position: absolute;
  width: 302px;
  top: 17px;
  left: 24px;
  font-weight: 300;
  color: #7f7f7f;
  font-size: 14px;
  letter-spacing: 0;
  line-height: normal;
}

.login .group-wrapper {
  position: absolute;
  width: 451px;
  height: 92px;
  top: 332px;
  left: 44px;
}

.login .group-4 {
  position: relative;
  height: 92px;
}

.login .password-wrapper {
  position: absolute;
  width: 451px;
  height: 57px;
  top: 35px;
  left: 0;
  background-color: #ffffff;
  border-radius: 9px;
  border: 1px solid;
  border-color: #adadad;
}

.login .overlap-wrapper {
  position: absolute;
  width: 453px;
  height: 54px;
  top: 491px;
  left: 44px;
}

.login .overlap-2 {
  position: relative;
  width: 451px;
  height: 54px;
  background-color: #0076e4;
  border-radius: 10px;
  box-shadow: 0px 4px 19px #4157934c;
}

.login .text-wrapper-4 {
  width: 56px;
  top: 14px;
  left: 198px;
  color: #ffffff;
  font-size: 16px;
  text-align: center;
  position: absolute;
  font-weight: 700;
  letter-spacing: 0;
  line-height: normal;
}

.login .text-wrapper-5 {
  top: 124px;
  left: 41px;
  color: #000000;
  font-size: 40px;
  position: absolute;
  font-weight: 700;
  letter-spacing: 0;
  line-height: normal;
}

.overlap-2:hover {
cursor: pointer;
background-color: #4da9ff;
}
</style>
</head>

<script type="text/javascript">
$(document).ready(function(){
	
	$("input:text[name='userid']").focus();
	
	$("input:password[name='password']").keyup(function(e){
		if(e.keyCode == 13){
			goAdminLogin();
		}
	});
	
});

function goAdminLogin(){
	
	// 유효성 검사
	const userid = $("input:text[name='userid']").val().trim();
	const password = $("input:password[name='password']").val().trim();
	
	if(userid == ''){
		alert("아이디를 입력하세요.");
		$("input:text[name='userid']").focus();
		return;
	}
	
	if(password == ''){
		alert("비밀번호를 입력하세요.");
		$("input:password[name='password']").focus();
		return;
	}
	
	// 폼태그 전송
	const frm = document.adminLoginFrm;
	frm.action = "<%=ctxPath%>/admin/adminLogin";
	frm.method = "post";
	frm.submit();
	
}
</script>

<body>
<div class="login">
  <div class="div">
    <img class="logo" src="<%=ctxPath %>/resources/images/logo.png" />
    <div class="overlap">
      <div class="group">
        <div class="group-2">
          <div class="div-wrapper"><p class="text-wrapper">Welcome to AmaDo - admin</p></div>
          <form name="adminLoginFrm">
          <div class="group-3">
            <div class="text-wrapper-2">ID</div>
            <input class="password-wrapper" name="userid" type="text" maxlength="20" placeholder="아이디를 입력하세요"/>
          </div>
          <div class="group-wrapper">
            <div class="group-4">
              <div class="text-wrapper-2">Password</div>
              <input class="password-wrapper" name="password" type="password" maxlength="20" placeholder="비밀번호를 입력하세요"/>
            </div>
          </div>
          </form>
          <div class="overlap-wrapper">
            <div class="overlap-2" onclick="goAdminLogin()"><div class="text-wrapper-4">로그인</div></div>
          </div>
        </div>
      </div>
      <div class="text-wrapper-5">관리자 전용 로그인</div>
    </div>
  </div>
</div>
</body>
</html>