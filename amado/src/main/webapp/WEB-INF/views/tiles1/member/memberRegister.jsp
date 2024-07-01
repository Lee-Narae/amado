<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
%>

<style type="text/css">

div#divRegisterFrm {
	text-align: center;
}

table#tblMemberRegister {
 /*	border: solid 1px red; */ 
	width: 93%;
	margin: 1% auto;
}

table#tblMemberRegister th {
    border: solid 1px gray; 
}

table#tblMemberRegister th {
	height: 60px;
	background-color: silver;
	font-size: 14pt;
}

table#tblMemberRegister td {
	line-height: 200%;
	padding: 1.2% 0;
}

span.star {
	color: red;
	font-weight: bold;
	font-size: 13pt;
}


table#tblMemberRegister > tbody > tr > td:first-child {
	width: 20%;
	font-weight: bold;
	text-align: left;
}

table#tblMemberRegister > tbody > tr > td:nth-child(2) {
	width: 80%;
	text-align: left;
}

img#idcheck, img#zipcodeSearch {
	cursor: pointer;
}

span#emailcheck,
span#phonecheck {
	border: solid 1px gray;
	border-radius: 5px;
	font-size: 8pt;
	display: inline-block;
	width: 80px;
	height: 30px;
	text-align: center;
	margin-left: 10px;
	cursor: pointer;
}

/*  변경한 곳 */
    .input-form { 
      max-width: 680px;

      margin-top: 80px;
      padding: 32px;

      -webkit-border-radius: 10px;
      -moz-border-radius: 10px;
      border-radius: 10px;
      -webkit-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
      -moz-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
      box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15)
    }


</style>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> 

<script type="text/javascript">



let b_idcheck = false;
let b_idcheck_click = false;
// "아이디중복확인" 을 클릭했는지 클릭을 안했는지 여부를 알아오기 위한 용도

let b_emailcheck = false;
let b_emailcheck_click = false;
// "이메일중복확인" 을 클릭했는지 클릭을 안했는지 여부를 알아오기 위한 용도

let hp2 = false;
let hp3 = false;
let b_phonecheck = false;
let b_phonecheck_click = false;
// "휴대폰확인" 을 클릭했는지 클릭을 안했늕 여부를 알아오기 위한 용도

let b_zipcodeSearch_click = false;
// "우편번호찾기" 를 클릭했는지 클릭을 안했는지 여부를 알아오기 위한 용도

$(document).ready(function () {
    $("button#rightPopover").hide();
    $("span.error").hide();
     

    // $("input#name").bind("blur", function(e) { alert("name에 있던 포커스를 잃어버렸습니다."); });
    // $("input#name").blur(function(e) { alert("name에 있던 포커스를 잃어버렸습니다."); });


    $("input#name").blur((e) => {
        const name = $(e.target).val().trim();
        if (name == "") {
            // 입력하지 않거나 공백만 입력했을 경우
            $(e.target).parent().find("span.error").show();
        } else {
            // 공백이 아닌 글자를 입력했을 경우
            $("table#tblMemberRegister :input").prop("disabled", false);
            $(e.target).parent().find("span.error").hide();
        }
    }); // 아이디가 name 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.




    $("input#userid").blur((e) => {
        const regExp_userid = new RegExp(/^[a-z]+[a-z0-9]{4,19}$/g);
        const bool = regExp_userid.test($(e.target).val());
        if (!bool) {
            // 아이디가 정규표현식에 위배된 경우
            $(e.target).parent().find("span.error").show();
            b_idcheck = false;
        } else {
            // 아이디가 정규표현식에 위배된 경우
            $("table#tblMemberRegister :input").prop("disabled", false);
            $(e.target).parent().find("span.error").hide();
            b_idcheck = true;
        }
    }); // 아이디가 userid 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.


    $("input#pwd").blur((e) => {

        const regExp_pwd = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
        // 숫자/문자/특수문자 포함 형태의 8~15자리 이내의 암호 정규표현식 객체 생성
        const bool = regExp_pwd.test($(e.target).val());
        if (!bool) {
            // 암호가 정규표현식에 위배된 경우
            $(e.target).parent().find("span.error").show();
        } else {
            // 암호가 정규표현식에 맞는 경우
            $("table#tblMemberRegister :input").prop("disabled", false);
            $(e.target).parent().find("span.error").hide();
        }
    }); // 아이디가 pwd 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.


    $("input#pwdcheck").blur((e) => {

        if ($("input#pwd").val() != $(e.target).val()) {
            // 암호와 암호 확인 값이 일치하지 않는 경우
            $(e.target).parent().find("span.error").show();
        } else {
            // 암호와 암호 확인 값이 같은 경우
            $("table#tblMemberRegister :input").prop("disabled", false);
            $(e.target).parent().find("span.error").hide();
        }
    }); // 아이디가 pwdcheck 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.



    $("input#email").blur((e) => {
        const regExp_email = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i);
        // 이메일 정규표현식 객체 생성 
        const bool = regExp_email.test($(e.target).val());
        if (!bool) {
            // 이메일이 정규표현식에 위배된 경우
            $(e.target).parent().find("span.error").show();
            b_emailcheck = false;
        } else {
            // 이메일이 정규표현식에 맞는 경우
            $("table#tblMemberRegister :input").prop("disabled", false);
            $(e.target).parent().find("span.error").hide();
            b_emailcheck = true;
        }
    }); // 아이디가 email 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.



    $("input#hp2").blur((e) => {
        const regExp_hp2 = new RegExp(/^[1-9][0-9]{3}$/);
        // 연락처 국번( 숫자 4자리인데 첫번째 숫자는 1-9 이고 나머지는 0-9) 정규표현식 객체 생성 
        const bool = regExp_hp2.test($(e.target).val());
        if (!bool) {
            // 연락처 국번이 정규표현식에 위배된 경우 
            $(e.target).parent().find("span.error").show();
            hp2 = false;
        } else {
            // 연락처 국번이 정규표현식에 맞는 경우 
            $("table#tblMemberRegister :input").prop("disabled", false);
            $(e.target).parent().find("span.error").hide();
            hp2 = true;
        }
    }); // 아이디가 hp2 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.


    $("input#hp3").blur((e) => {
        const regExp_hp3 = new RegExp(/^\d{4}$/);
        // 숫자 4자리만 들어오도록 검사해주는 정규표현식 객체 생성 
        const bool = regExp_hp3.test($(e.target).val());
        if (!bool) {
            // 마지막 전화번호 4자리가 정규표현식에 위배된 경우 
            $(e.target).parent().find("span.error").show();
            hp3 = false;
        } else {
            // 마지막 전화번호 4자리가 정규표현식에 맞는 경우 
            $("table#tblMemberRegister :input").prop("disabled", false);
            $(e.target).parent().find("span.error").hide();
            hp3 = true;
        }
    }); // 아이디가 hp3 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.


    $("input#postcode").blur((e) => {
        const regExp_postcode = new RegExp(/^\d{5}$/);
        // 숫자 5자리만 들어오도록 검사해주는 정규표현식 객체 생성 
        const bool = regExp_postcode.test($(e.target).val());
        if (!bool) {
            // 우편번호가 정규표현식에 위배된 경우 
            $(e.target).parent().find("span.error").show();
        } else {
            // 우편번호가 정규표현식에 맞는 경우 
            $("table#tblMemberRegister :input").prop("disabled", false);
            $(e.target).parent().find("span.error").hide();
        }
    }); // 아이디가 postcode 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.


    ////////////////////////////////////////////////////////////

    // 우편번호를 읽기전용(readonly) 로 만들기
    $("input#postcode").attr("readonly", true);

    // 주소를 읽기전용(readonly) 로 만들기
    $("input#address").attr("readonly", true);

    // 참고항목을 읽기전용(readonly) 로 만들기
    // $("input#extraAddress").attr("readonly", true);



    // === "우편번호찾기"를 클릭했을 때 이벤트 처리하기 === //
    $("img#zipcodeSearch").click(function () {

        b_zipcodeSearch_click = true;
        // "우편번호찾기" 를 클릭했는지 안 했는지 여부를 알아오기 위한 용도

        new daum.Postcode({
            oncomplete: function (data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                let addr = ''; // 주소 변수
                let extraAddr = ''; // 참고항목 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if (data.userSelectedType === 'R') {
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if (data.buildingName !== '' && data.apartment === 'Y') {
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if (extraAddr !== '') {
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    // document.getElementById("extraAddress").value = extraAddr;

                } else {
                    // document.getElementById("extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();
            }
        }).open();

        // 우편번호를 읽기전용(readonly) 로 만들기
        $("input#postcode").attr("readonly", true);

        // 주소를 읽기전용(readonly) 로 만들기
        $("input#address").attr("readonly", true);

        // 참고항목을 읽기전용(readonly) 로 만들기
        // $("input#extraAddress").attr("readonly", true);

        // 주소를 비활성화 로 만들기
        //  $("input#address").attr("disabled", true);

        // 참고항목을 비활성화 로 만들기
        //  $("input#extraAddress").attr("disabled", true);

        // 주소를 쓰기가능 으로 만들기
        // $("input#address").removeAttr("readonly");

        // 참고항목을 쓰기가능 으로 만들기
        // $("input#extraAddress").removeAttr("readonly");

        // 주소를 활성화 시키기
        // $("input#address").removeAttr("disabled");

        // 참고항목을 활성화 시키기
        // $("input#extraAddress").removeAttr("disabled");

    }); // end of $("img#zipcodeSearch").click()------------




    $('input#datepicker').keyup((e) => {

        $(e.target).val("").next().show();

    }); // end of $('input#datepicker').keyup() ------------


    // === jQuery UI 의 datepicker === //
    $('input#datepicker').datepicker({
        dateFormat: 'yy-mm-dd'  // Input Display Format 변경
        , showOtherMonths: true   // 빈 공간에 현재월의 앞뒤월의 날짜를 표시
        , showMonthAfterYear: true // 년도 먼저 나오고, 뒤에 월 표시
        , changeYear: true        // 콤보박스에서 년 선택 가능
        , changeMonth: true       // 콤보박스에서 월 선택 가능                
    //  , showOn: "both"          // button:버튼을 표시하고,버튼을 눌러야만 달력 표시됨. both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시됨.  
    //  , buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif"  // 버튼 이미지 경로
    //  , buttonImageOnly: true   // 기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
    //  , buttonText: "선택"       // 버튼에 마우스 갖다 댔을 때 표시되는 텍스트
        , yearSuffix: "년"         // 달력의 년도 부분 뒤에 붙는 텍스트
        , monthNamesShort: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12']  // 달력의 월 부분 텍스트
        , monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']  // 달력의 월 부분 Tooltip 텍스트
        , dayNamesMin: ['일', '월', '화', '수', '목', '금', '토']  // 달력의 요일 부분 텍스트
        , dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일']  // 달력의 요일 부분 Tooltip 텍스트
    //  , minDate: "-1M"  // 최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
    //  , maxDate: "+1M"  // 최대 선택일자(+1D:하루후, +1M:한달후, +1Y:일년후)
    });

    // 초기값을 오늘 날짜로 설정
    // $('input#datepicker').datepicker('setDate', 'today');  // (-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)


    // === 전체 datepicker 옵션 일괄 설정하기 ===  
    //     한번의 설정으로 $("input#fromDate"), $('input#toDate')의 옵션을 모두 설정할 수 있다.
    $(function () {
        //모든 datepicker에 대한 공통 옵션 설정
        $.datepicker.setDefaults({
            dateFormat: 'yy-mm-dd' //Input Display Format 변경
            , showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
            , showMonthAfterYear: true //년도 먼저 나오고, 뒤에 월 표시
            , changeYear: true //콤보박스에서 년 선택 가능
            , changeMonth: true //콤보박스에서 월 선택 가능                
            // ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시됨. both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시됨.  
            // ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
            // ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
            // ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
            , yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
            , monthNamesShort: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'] //달력의 월 부분 텍스트
            , monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'] //달력의 월 부분 Tooltip 텍스트
            , dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'] //달력의 요일 부분 텍스트
            , dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'] //달력의 요일 부분 Tooltip 텍스트
            // ,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
            // ,maxDate: "+1M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                    
        });

        // input을 datepicker로 선언
        $("input#fromDate").datepicker();
        $("input#toDate").datepicker();

        // From의 초기값을 오늘 날짜로 설정
        $('input#fromDate').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)

        // To의 초기값을 3일후로 설정
        $('input#toDate').datepicker('setDate', '+3D'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
    });

    ///////////////////////////////////////////////////////////////////////

    // 생년월일에 마우스로 달력에 있는 날짜를 선택한 경우 이벤트 처리한 것
    $('input#datepicker').bind("change", (e) => {
        if($(e.target).val() != "") {
            $(e.target).next().hide(); // 오류 메시지 감추기
        }
    });



    ///////////////////////////////////////////////////////////////////////
    // "아이디중복확인" 을 클릭했을 때 이벤트 처리하기 시작 //
    $("img#idcheck").click(function() {

        b_idcheck_click = true;
        // "아이디중복확인" 을 클릭했는지 클릭을 안했는지 여부를 알아오기 위한 용도
        // 입력하고자 하는 아이디가 데이터베이스 테이블에 존재하는지, 존재하지 않는지 알아와야 한다.
        /*
            Ajax (Asynchronous JavaScript and XML)란?                         
            ==> 이름만 보면 알 수 있듯이 '비동기 방식의 자바스크립트와 XML' 로서
                Asynchronous JavaScript + XML 인 것이다.
                한마디로 말하면, Ajax 란? Client 와 Server 간에 XML 데이터를 JavaScript 를 사용하여 비동기 통신으로 주고 받는 기술이다.
                하지만 요즘에는 데이터 전송을 위한 데이터 포맷방법으로 XML 을 사용하기 보다는 JSON(Javascript Standard Object Notation) 을 더 많이 사용한다. 
                참고로 HTML은 데이터 표현을 위한 포맷방법이다.
                그리고, 비동기식이란 어떤 하나의 웹페이지에서 여러가지 서로 다른 다양한 일처리가 개별적으로 발생한다는 뜻으로서, 
                어떤 하나의 웹페이지에서 서버와 통신하는 그 일처리가 발생하는 동안 일처리가 마무리 되기전에 또 다른 작업을 할 수 있다는 의미이다.
        */
        
        
        if($("input#userid").val().trim() == "" && b_idcheck == false) {
        	$("span#idcheckResult").html("");
        	$("span#idcheckResult").html("아이디를 입력하세요.").css({"color":"red"});
        	b_idcheck_click = false;
			return false;        	
        }
            
        if(b_idcheck == false) {
        	$("span#idcheckResult").html("");
        	b_idcheck_click = false;
        	return false;
        }

        $.ajax({
            url: "<%=ctxPath%>/idDuplicateCheck.do",
            data: {"userid":$("input#userid").val()}, // data 속성은 http://localhost:9090/MyMVC/member/idDuplicateCheck.up 로 전송해야 할 데이터를 말한다.
            type: "post",   // type을 생략하면 type : "get" 이다.
           
            async : true,   // async:true 가 비동기 방식을 말한다. async 을 생략하면 기본값이 비동기 방식인 async:true 이다.
                            // async:false 가 동기 방식이다. 지도를 할 때는 반드시 동기방식인 async:false 을 사용해야만 지도가 올바르게 나온다.

            dataType : "json", // Javascript Standard Object Notation.  dataType은 /MyMVC/member/idDuplicateCheck.up 로 부터 실행된 결과물을 받아오는 데이터타입을 말한다. 
            // 만약에 dataType:"xml" 으로 해주면 /MyMVC/member/idDuplicateCheck.up 로 부터 받아오는 결과물은 xml 형식이어야 한다. 
            // 만약에 dataType:"json" 으로 해주면 /MyMVC/member/idDuplicateCheck.up 로 부터 받아오는 결과물은 json 형식이어야 한다.                           

            success : function(json) {
             // console.log("json => ", json);
                // json => {"isExist":true}
                // json => {"isExist":false}
                // json 는 idDuplicateCheck.up 을 통해 가져온 결과물인 "{"isExist":true}" 또는 "{"isExist":false}" 로 되어지는 string 타입의 결과물이다.

                // console.log("~~~~ json 의 데이터타입 : ", typeof json);
                // ~~~~ json 의 데이터타입 :  object

                if(json.n == 0) {
                    // 입력한 userid가 존재하지 않는 경우
                    $("span#idcheckResult").html($("input#userid").val()  + " 은(는) 사용 가능한 아이디입니다.").css({"color":"blue"});
                }
                else {
                	// 입력한 userid가 이미 사용중이라면
                    $("span#idcheckResult").html($("input#userid").val()  + " 은(는) 이미 사용중이므로 다른 아이디를 입력하세요.").css({"color":"red"});
                    $("input#userid").val("");
                }
            },
            
            error: function(request, status, error) {
                alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
            }

        });

    });
    // "아이디중복확인" 을 클릭했을 때 이벤트 처리하기 끝 //



    // "이메일중복확인" 을 클릭했을 때 이벤트 처리하기 시작 //
    $("span#emailcheck").click(function() {

        b_emailcheck_click = true;
        // "이메일중복확인" 을 클릭했는지 클릭을 안했는지 여부를 알아오기 위한 용도
        // 입력하고자 하는 이메일이 데이터베이스 테이블에 존재하는지, 존재하지 않는지 알아와야 한다.

        if($("input#email").val().trim() == "" && b_emailcheck == false) {
        	$("span#emailCheckResult").html("");
        	$("span#emailcheckResult").html("이메일을 입력하세요.").css({"color":"red"});
        	b_emailcheck_click = false;
			return false;        	
        }
            
        if(b_emailcheck == false) {
        	$("span#emailCheckResult").html("");
        	b_emailcheck_click = false;
        	return false;
        }
        
        $.ajax({
            url: "<%=ctxPath%>/emailDuplicateCheck.do",
            data: {"email":$("input#email").val()}, // data 속성은 http://localhost:9090/MyMVC/member/emailDuplicateCheck.up 로 전송해야할 데이터를 말한다.
            type: "post",   // type을 생략하면 type : "get" 이다.
           
            async : true,   // async:true 가 비동기 방식을 말한다. async 을 생략하면 기본값이 비동기 방식인 async:true 이다.
                            // async:false 가 동기 방식이다. 지도를 할때는 반드시 동기방식인 async:false 을 사용해야만 지도가 올바르게 나온다.

            dataType : "json",                 

            success : function(json) {
                
                if(json.isExist) {
                    // 입력한 email이 이미 사용중이라면
                    $("span#emailCheckResult").html($("input#email").val()  + " 은(는) 이미 사용중이므로 다른 이메일을 입력하세요.").css({"color":"red"});
                    $("input#email").val("");
                    
                }
                else {
                    // 입력한 email이 존재하지 않는 경우
                    $("span#emailCheckResult").html($("input#email").val()  + " 은(는) 사용 가능한 이메일입니다.").css({"color":"blue"});
                }
            },
            
            error: function(request, status, error) {
                alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
           }
        });
         
    });
    // "이메일중복확인" 을 클릭했을 때 이벤트 처리하기 끝 //

    
    // "휴대폰확인" 을 클릭했을 때 이벤트 처리하기 시작 //
    $("span#phonecheck").click(function() {

    	b_phonecheck_click = true;
        // "이메일중복확인" 을 클릭했는지 클릭을 안했는지 여부를 알아오기 위한 용도
        // 입력하고자 하는 이메일이 데이터베이스 테이블에 존재하는지, 존재하지 않는지 알아와야 한다.

        if(hp2 == true && hp3 == true) {
        	b_phonecheck = true;
        }
        
        /* 
        alert("hp2 = " + hp2);
        alert("hp3 = " + hp3);
    	alert("b_phonecheck = " + b_phonecheck);
        */
        
        if(b_phonecheck == false) {
			alert("휴대폰 번호를 다시 한 번 확인해주세요!"); 	        	
        	$("span#phonecheckResult").html("");
        	b_phonecheck_click = false;
			return false;        	
        }

        
        $.ajax({
            url: "<%=ctxPath%>/phonecheck.do",
            data: {"hp2":$("input#hp2").val(),
            	   "hp3":$("input#hp3").val()}, // data 속성은 http://localhost:9090/MyMVC/member/emailDuplicateCheck.up 로 전송해야할 데이터를 말한다.
            type: "post",   // type을 생략하면 type : "get" 이다.
           
            async : true,   // async:true 가 비동기 방식을 말한다. async 을 생략하면 기본값이 비동기 방식인 async:true 이다.
                            // async:false 가 동기 방식이다. 지도를 할때는 반드시 동기방식인 async:false 을 사용해야만 지도가 올바르게 나온다.

            dataType : "json",                 

            success : function(json) {
                
                if(json.isExist) {
                    // 입력한 email이 이미 사용중이라면
                    $("span#phonecheckResult").html("010 - " + $("input#hp2").val() + " - " + $("input#hp3").val()  + " 은(는) 이미 사용중이므로 다른 연락처를 입력하세요.").css({"color":"red"});
                    $("input#email").val("");
                    
                }
                else {
                    // 입력한 email이 존재하지 않는 경우
                    $("span#emailCheckResult").html($("input#email").val()  + " 은(는) 사용 가능한 이메일입니다.").css({"color":"blue"});
                }
            },
            
            error: function(request, status, error) {
                alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
           }
        });
         
    });
    // "이메일중복확인" 을 클릭했을 때 이벤트 처리하기 끝 //

    // 아이디 값이 변경되면 가입하기 버튼을 클릭 시 "아이디중복확인" 을 클릭했는지 클릭안했는지를 알아보기위한 용도 초기화 시키기
    $("input#userid").bind("change", function() {
        b_idcheck_click = false;
    });


    // 이메일 값이 변경되면 가입하기 버튼을 클릭 시 "이메일중복확인" 을 클릭했는지 클릭안했는지를 알아보기위한 용도 초기화 시키기
    $("input#email").bind("change", function() {
        b_emailcheck_click = false;
    });

    // 휴대폰 번호가 변경되면 가입하기 버튼을 클릭 시 "휴대폰확인" 을 클릭했는지 클릭안했는지를 알아보기위한 용도 초기화 시키기
    $("input#hp2").bind("change", function() {
        b_phonecheck_click = false;
    });
    $("input#hp3").bind("change", function() {
        b_phonecheck_click = false;
    });


}); // end of $(rurument).ready(function() {}) -------------------



// Function Declaration
// "가입하기" 버튼 클릭 시 호출되는 함수
function goRegister() {

    // *** 필수입력사항에 모두 입력이 되었는지 검사하기 시작 *** //
    let b_requiredInfo = true;

    const requiredInfo_list = document.querySelectorAll("input.requiredInfo");
    for(let i=0; i<requiredInfo_list.length; i++) {
        const val = requiredInfo_list[i].value.trim();
        if(val == "") {
            alert("* 표시된 필수입력사항은 모두 입력하셔야 합니다.");
            b_requiredInfo = false;
            break;
        }
    } // end of for(let i=0; i<requiredInfo_list.length; i++) ----------------


    if(!b_requiredInfo) {
        return; // goRegister() 함수를 종료한다.
    }
    // *** 필수입력사항에 모두 입력이 되었는지 검사하기 끝 *** //


    // *** "아이디중복확인" 을 클릭했는지 검사하기 시작 *** //
    if(!b_idcheck_click) {
        // "아이디중복확인" 을 클릭하지 않았을 경우
        alert("아이디 중복확인을 클릭하셔야 합니다.");
        return; // goRegister() 함수를 종료한다.
    }
    // *** "아이디중복확인" 을 클릭했는지 검사하기 끝 *** //


    // *** "이메일중복확인" 을 클릭했는지 검사하기 시작 *** //
    if(!b_emailcheck_click) {
        // "이메일중복확인" 을 클릭하지 않았을 경우
        alert("이메일 중복확인을 클릭하셔야 합니다.");
        return; // goRegister() 함수를 종료한다.
    }
    // *** "이메일중복확인" 을 클릭했는지 검사하기 끝 *** //

    
    // *** "우편번호찾기" 를 클릭했는지 검사하기 시작 *** //
    if (!b_zipcodeSearch_click) {
        // "우편번호찾기" 를 클릭하지 않았을 경우
        alert("우편번호찾기를 클릭하여 우편번호를 입력하셔야 합니다.");
        return; // goRegister() 함수를 종료한다.
    }
    // *** "우편번호찾기" 를 클릭했는지 검사하기 끝 *** //


    // *** 우편번호 및 주소에 값을 입력했는지 검사하기 시작 *** //
    const postcode = $("input#postcode").val().trim();
    const address = $("input#address").val().trim();
    const detailAddress = $("input#detailAddress").val().trim();
    const extraaddress = $("input#extraaddress").val().trim();
    // const extraAddress = $("input#extraAddress").val().trim();

    // if (postcode == "" || address == "" || detailAddress == "" || extraAddress == "") {
    if (postcode == "" || address == "" || detailAddress == "" || extraaddress == "") {
        alert("우편번호 및 주소를 입력하셔야 합니다.");
        return; // goRegister() 함수를 종료한다.
    }
    // *** 우편번호 및 주소에 값을 입력했는지 검사하기 끝 *** //


    // *** 성별을 선택했는지 검사하기 시작 *** //
    const radio_checked_length = $("input:radio[name='gender']:checked").length;

    if (radio_checked_length == 0) {
        alert("성별을 선택하셔야 합니다.");
        return; // goRegister() 함수를 종료한다.
    }
    // *** 성별을 선택했는지 검사하기 끝 *** //


    // *** 생년월일 값을 입력했는지 검사하기 시작 *** //
    const birthday = $('input#datepicker').val().trim();

    if(birthday == "") {
        alert("생년월일을 입력하셔야 합니다.");
        return; // goRegister() 함수를 종료한다.
    }
    // *** 생년월일 값을 입력했는지 검사하기 끝 *** //


    const frm = document.registerFrm;
    frm.action = "memberRegister.do";
    frm.method = "post";
    frm.submit();

} // end of function goRegister() ------------------



function goReset() {

    $("span.error").hide();
    $("span#idcheckResult").empty();
    $("span#emailCheckResult").empty();

} // function goReset() ---------------------

	
</script>




<div class="row" style="display: flex; margin-bottom: 2%; margin-top: 2%;">
<%-- 변경한 곳 아래 --%>
   <div class="input-form col-md-12 mx-auto" style="margin: auto; padding-left: 3%;">
<%-- 변경한 곳 위 --%>   
      <form name="registerFrm">
          <table id="tblMemberRegister">
             <thead>
                <tr align="center">
                   <th colspan="2">::: 회원가입 <span style="font-size: 10pt; font-style: italic;">(<span class="star">*</span>표시는 필수입력사항)</span> :::</th>
                </tr>
             </thead>
             
             <tbody>
                <tr>
                    <td colspan="2" style="line-height: 50%;">&nbsp;</td>
                </tr>
                
                <tr>
                    <td>성명&nbsp;<span class="star">*</span></td>
                    <td>
                       <input type="text" name="name" id="name" maxlength="30" class="requiredInfo" />
                       <span class="error">성명은 필수입력 사항입니다.</span>
                    </td>
                </tr>
                
                <tr>
                    <td>아이디&nbsp;<span class="star">*</span></td>
                    <td>
                       <input type="text" name="userid" id="userid" maxlength="40" class="requiredInfo" />&nbsp;&nbsp;  
                       <%-- 아이디중복체크 --%>
                       <img src="<%= ctxPath%>/resources/images/id_check.png" id="idcheck" class="rounded" alt="round" width="25" />
                       <span id="idcheckResult"></span>
                       <span class="error">아이디는 영문자,숫자가 혼합된 5~20 글자로 입력하세요.</span>
                    </td>
                </tr>
                
                <tr>
                    <td>비밀번호&nbsp;<span class="star">*</span></td>
                    <td>
                       <input type="password" name="pwd" id="pwd" maxlength="15" class="requiredInfo" />
                       <span class="error">암호는 영문자,숫자,특수기호가 혼합된 8~15 글자로 입력하세요.</span>
                    </td>
                </tr>
                
                <tr>
                    <td>비밀번호확인&nbsp;<span class="star">*</span></td>
                    <td>
                       <input type="password" id="pwdcheck" maxlength="15" class="requiredInfo" />
                       <span class="error">암호가 일치하지 않습니다.</span>
                    </td>
                </tr>
                
                <tr>
                    <td>이메일&nbsp;<span class="star">*</span></td>
                    <td>
                       <input type="text" name="email" id="email" maxlength="60" class="requiredInfo" />
                       <%-- 이메일중복체크 --%>
                       <span id="emailcheck">이메일중복확인</span>
                       <span id="emailCheckResult"></span>
                       <span class="error">이메일 형식에 맞지 않습니다.</span>
                    </td>
                </tr>
                
                <tr>
                    <td>연락처&nbsp;</td>
                    <td>
                       <input type="text" name="hp1" id="hp1" size="6" maxlength="3" value="010" readonly />&nbsp;-&nbsp; 
                       <input type="text" name="hp2" id="hp2" size="6" maxlength="4" />&nbsp;-&nbsp;
                       <input type="text" name="hp3" id="hp3" size="6" maxlength="4" />    
                       <span id="phonecheck">휴대폰확인</span>
                       <span class="error">휴대폰 형식이 아닙니다.</span>
                    </td>
                </tr>
                <tr>
                    <td>인증번호확인&nbsp;</td>
                    <td>
						<input type="text" name="phoneCheckResultVal" id="phoneCheckResultVal" size="10" maxlength="10" />
						<span id="phoneCheck">인증번호확인</span>
						<span id="phoneCheckResult"></span>
						<span class="error">올바른 인증번호가 아닙니다.</span>
                    </td>
                </tr>
                
                <tr>
                    <td>우편번호</td>
                    <td>
                       <input type="text" name="postcode" id="postcode" size="6" maxlength="5" />&nbsp;&nbsp;
                       <%-- 우편번호 찾기 --%>
                       <img src="<%= ctxPath%>/resources/images/address.png" id="zipcodeSearch" class="rounded" alt="round" width="25" />
                       <span class="error">우편번호 형식에 맞지 않습니다.</span>
                    </td>
                </tr>
                
                <tr>
                    <td>주소</td>
                    <td>
                       <input type="text" name="address" id="address" size="40" maxlength="200" placeholder="주소" /><br>
                       <input type="text" name="detailaddress" id="detailAddress" size="40" maxlength="200" placeholder="상세주소" />&nbsp;<input type="text" name="extraaddress" id="extraAddress" size="40" maxlength="200" placeholder="참고항목" />            
                       <span class="error">주소를 입력하세요.</span>
                    </td>
                </tr>
                
                <tr>
                    <td>성별</td>
                    <td>
                       <input type="radio" name="gender" value="1" id="male" /><label for="male" style="margin-left: 1.5%;">남자</label>
                       <input type="radio" name="gender" value="2" id="female" style="margin-left: 10%;" /><label for="female" style="margin-left: 1.5%;">여자</label>
                    </td>
                </tr>
                
                <tr>
                    <td>생년월일</td>
                    <td>
                       <input type="text" name="birthday" id="datepicker" maxlength="10" />
                       <span class="error">생년월일은 마우스로만 클릭하세요.</span>
                    </td>
                </tr>
                
                
                <tr>
                    <td colspan="2">
                       <label for="agree">이용약관에 동의합니다</label>&nbsp;&nbsp;<input type="checkbox" id="agree" />
                    </td>
                </tr>
                
                <tr>
                    <td colspan="2">
                       <iframe src="<%= ctxPath%>/iframe_agree/agree.html" width="100%" height="150px" style="border: solid 1px navy;"></iframe>
                    </td>
                </tr>

                <tr>
                    <td colspan="2" class="text-center">
                       <input type="button" class="btn btn-success btn-lg mr-5" value="가입하기" onclick="goRegister()" />
                       <input type="reset"  class="btn btn-danger btn-lg" value="취소하기" onclick="goReset()" />
                    </td>
                </tr>
                 
             </tbody>
          </table>

      </form>
   </div>
</div>