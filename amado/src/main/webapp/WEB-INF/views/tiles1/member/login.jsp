<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
%>

<style type="text/css">

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
  width: 555px;
  height: 741px;
  top: 79px;
  left: 682px;
}

.login .group {
  position: absolute;
  width: 555px;
  height: 741px;
  top: 0;
  left: 0;
}

.login .overlap-wrapper {
  height: 741px;
}

.login .overlap-group {
  position: relative;
  width: 559px;
  height: 741px;
}

.login .rectangle {
  position: absolute;
  width: 539px;
  height: 741px;
  top: 0;
  left: 0;
  background-color: #ffffff;
  border-radius: 40px;
  box-shadow: 0px 4px 35px #00000014;
}

.login .div-wrapper {
  position: absolute;
  width: 203px;
  height: 30px;
  top: 55px;
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

.login .group-2 {
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

.login .username-or-email-wrapper {
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

.login .group-3 {
  position: absolute;
  width: 457px;
  height: 127px;
  top: 332px;
  left: 44px;
}

.login .group-4 {
  position: absolute;
  width: 451px;
  height: 92px;
  top: 0;
  left: 0;
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

.login .text-wrapper-4 {
  top: 107px;
  left: 284px;
  font-weight: 400;
  color: #1e234b;
  font-size: 13px;
  position: absolute;
  letter-spacing: 0;
  line-height: normal;
}

.login .text-wrapper-5 {
  top: 107px;
  left: 373px;
  font-weight: 400;
  color: #1f234b;
  font-size: 13px;
  position: absolute;
  letter-spacing: 0;
  line-height: normal;
}

.login .text-wrapper-6 {
  top: 107px;
  left: 357px;
  font-weight: 400;
  color: #1f234b;
  font-size: 13px;
  position: absolute;
  letter-spacing: 0;
  line-height: normal;
}

.login .group-5 {
  position: absolute;
  width: 515px;
  height: 194px;
  top: 491px;
  left: 44px;
}

.login .overlap-2 {
  position: absolute;
  width: 451px;
  height: 54px;
  top: 0;
  left: 0;
  background-color: #0076e4;
  border-radius: 10px;
  box-shadow: 0px 4px 19px #4157934c;
}

.login .text-wrapper-7 {
  width: 56px;
  top: 15px;
  left: 198px;
  font-weight: 700;
  color: #ffffff;
  font-size: 16px;
  text-align: center;
  position: absolute;
  letter-spacing: 0;
  line-height: normal;
}

.login .overlap-3 {
  position: absolute;
  width: 451px;
  height: 54px;
  top: 140px;
  left: 0;
  background-color: #cdcdcd;
  border-radius: 10px;
  box-shadow: 0px 4px 19px #aeaeae4c;
}

.login .text-wrapper-8 {
  width: 67px;
  top: 15px;
  left: 200px;
  font-weight: 700;
  color: #666666;
  font-size: 16px;
  text-align: center;
  position: relative;
  left: 192px;
  letter-spacing: 0;
  line-height: normal;
}

.login .text-wrapper-9 {
  top: 84px;
  left: 41px;
  font-weight: 700;
  color: #000000;
  font-size: 55px;
  position: absolute;
  letter-spacing: 0;
  line-height: normal;
}

.login .text-wrapper-10 {
  position: absolute;
  top: 577px;
  left: 256px;
  font-weight: 400;
  color: #ababab;
  font-size: 16px;
  letter-spacing: 0;
  line-height: normal;
}

.overlap-2:hover {
cursor: pointer;
background-color: #4da9ff;
}

.find:hover {
cursor: pointer;
text-decoration:underline; 
}


.overlap-3:hover {
cursor: pointer;
background-color: #bfbfbf;
}

</style>

<script type="text/javascript">
$(document).ready(function(){
	
	$("input:text[name='userid']").focus();
	
	$("input:password[name='password']").keyup(function(e){
		if(e.keyCode == 13){
			goLogin();
		}
	});
	
	
	// 아이디 찾기
	$("div.find").click(function(){
		
		const way = $(event.target).attr('id');
		location.href = `IdPwfind.do?find=\${way}`;
		
	});
	
	
});


// 로그인 메소드
function goLogin(){
	
	const id = $("input:text[name='userid']").val().trim();
	if(id == ''){
		alert("아이디를 입력하세요.");
		$("input:text[name='userid']").focus();
		return;
	}
	
	const pwd = $("input:password[name='password']").val().trim();
	if(pwd == ''){
		alert("비밀번호를 입력하세요.");
		$("input:password[name='password']").focus();
		return;
	}
	
	const frm = document.loginFrm;
	frm.action = "<%= ctxPath%>/member/loginEnd.do";
	frm.method= "post";
	frm.submit();
	
	
}
</script>

<div class="login">
  <div class="div">
    <img class="logo" src="<%=ctxPath %>/resources/images/logo.png" />
    <div class="overlap">
      <div class="group">
        <div class="overlap-wrapper">
          <div class="overlap-group">
            <form name="loginFrm">
            <div class="rectangle"></div>
            <div class="div-wrapper"><div class="text-wrapper">Welcome to AmaDo</div></div>
            <div class="group-2">
              <div class="text-wrapper-2">ID</div>
              <input class="username-or-email-wrapper" name="userid" type="text" maxlength="20" placeholder="아이디를 입력하세요"/>
            </div>
            <div class="group-3">
              <div class="group-4">
                <div class="text-wrapper-2">Password</div>
                <input class="password-wrapper" name="password" type="password" maxlength="20" placeholder="비밀번호를 입력하세요"/>
              </div>
              <div class="text-wrapper-4 find" id="id">아이디 찾기</div>
              <div class="text-wrapper-5 find" id="pw">비밀번호 찾기</div>
              <div class="text-wrapper-6">&nbsp;/</div>
            </div>
            <div class="group-5">
              <div class="overlap-2" onclick="goLogin()"><div class="text-wrapper-7">로그인</div></div>
              <div class="overlap-3" onclick="location.href='<%=ctxPath%>/member/memberRegister.do'"><div class="text-wrapper-8">회원가입</div></div>
            </div>
            </form>
          </div>
        </div>
      </div>
      <div class="text-wrapper-9">로그인</div>
      <div class="text-wrapper-10">OR</div>
    </div>
  </div>
</div>

<form name="wayFrm">
<input type="hidden" name="way" />
<input type="text" style="display: none;" />
</form>
