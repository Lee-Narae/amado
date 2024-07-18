<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>


<style type="text/css">
.title {
width: 10%;
margin-left: 10%;
margin-right: 1%;
background-color: #0076d1;
color: white;
height: 40px;
align-content: center;
font-weight: bold;
border-radius: 20px;
}

.tr {
margin-bottom: 1%;
}

input {
height: 40px;
border-radius: 10px;
border: solid 1px gray;
padding-left: 1%;
}

textarea {
border-radius: 10px;
padding-left: 1%;
}

div#forAddress > input {
margin-bottom: 0.5%;
}

select {
width: 20%;
height: 40px;
align-content: center;
text-align: center;
border-radius: 10px;
}

option {

}
</style>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
});

function addressMatching() {
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
            }
            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('postcode').value = data.zonecode;
            document.getElementById("address").value = addr;
        }
    }).open();
}
</script>

<div style="width: 100%; min-height: 810px;" align="center">

<div id="gymContent" style="width: 80%; border: solid 1px red;">
<img width="260" class="mt-5" src="<%=ctxPath%>/resources/images/narae/gymReg.png"/>

<div id="gymReg" style="border: solid 1px blue; width: 100%; margin-top: 3%;">
	<div class="tr" style="display: flex;">
		<div class="td title">체육관 명</div>
		<div class="td input"><input type="text" name="gymname" style="padding-left: 1%;"/></div>
	</div>
	<div class="tr" style="display: flex;">
		<div class="td title">주소</div>
		<div class="td input"><button type="button" class="btn btn-info" onclick="addressMatching()">검색</button></div>
	</div>
	<div id="forAddress" style="margin-bottom: 1%; padding-left: 21%;" align="left">
		<input type="text" name="postcode" id="postcode" readonly placeholder="우편번호"/><br>
		<input type="text"  name="address" id="address" readonly placeholder="주소"/>
		<input type="text"  name="detailaddress" placeholder="상세주소"/>
	</div>
	<div class="tr" style="display: flex;">
		<div class="td title">공간 정보</div>
		<div class="td input"><textarea cols="100" rows="3" name="info"></textarea></div>
	</div>
	<div class="tr" style="display: flex;">
		<div class="td title">주의사항</div>
		<div class="td input"><textarea cols="100" rows="2" name="caution"></textarea></div>
	</div>
	<div class="tr" style="display: flex;">
		<div class="td title">인원</div>
		<div class="td input"><input type="text" name="membercount"/></div>
	</div>
	<div class="tr" style="display: flex;">
		<div class="td title">타입</div>
		<div class="td input" style="width: 50%;" align="left">
			<select name="insidestatus">
				<option value="0">실내</option>
				<option value="1">실외</option>
			</select>
		</div>
	</div>
	<div class="tr" style="display: flex;">
		<div class="td title">대표이미지</div>
		<div class="td input"><input type="file" name="orgfilename" style="border: none; margin-top: 1%;"/></div>
	</div>
</div>

</div>

</div>