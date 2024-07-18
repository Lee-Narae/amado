<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
   String ctxPath = request.getContextPath();
%>

<style type="text/css">

textarea::placeholder {
    font-size: 1.2em;
    font-style: italic;
    text-align: left;
    padding-top: 10px;
}

input[type="file"] {
  display: none;
}

.custom-file-upload {
  border: 1px solid #ccc;
  display: inline-block;
  padding: 6px 12px;
  cursor: pointer;
  background-color: gray;
}

.privacy-info {
    display: none;
    margin-top: 20px;
}

</style>


<script type="text/javascript">

	$(document).ready(function() {
		
        document.getElementById('view-policy').addEventListener('click', function() {
            var privacyInfo = document.getElementById('privacy-info');
            if (privacyInfo.style.display === 'none' || privacyInfo.style.display === '') {
                privacyInfo.style.display = 'block';
            } else {
                privacyInfo.style.display = 'none';
            }
        });
        
        
        
        <%-- 문의접수 버튼 눌렀을 경우 --%>
        $("button#inquiryWrite").click(function(){
        	
        	
        	
        	if($("select#searchType_a").val() == 0 || $("select#searchType_b").val() == 0) {
        		alert("문의유형을 선택해주세요.");
        		return;
        	}
        	
        	
	       	 let content_val = "<p>"; 
	       	 content_val += $("textarea[name='content']").val().trim();
	       	 content_val += "</p>";
	       	
//	    	 alert(content_val.length); // content 에 공백만 여러 개를 입력하여 쓸 경우
	    	 // <p>&nbsp; &nbsp;&nbsp;</p> 이라고 나온다.
	    	 
	    	 content_val = content_val.replace(/&nbsp;/gi, ""); // 공백(&nbsp;)을 "" 으로 변환 (한번만 되서 정규표현식을 사용하여 전부 변환시켜준다.)
	        	
	    	 content_val = content_val.substring(content_val.indexOf("<p>")+3);
	    	 content_val = content_val.substring(0, content_val.indexOf("</p>"));
//	    	 alert(content_val); // content 에 공백만 여러 개를 입력하여 쓸 경우
	    	 // 
	    	 
	    	 if(content_val.length == 0){
	    		 alert("글내용을 입력하세요!");
	    		 return;
	    	 }
	    	 
	    	 if(content_val.length >= 1000){
	    		 alert("글내용은 1000글자를 넘길 수 없습니다.");
	    		 return;
	    	 }
	    	 
	    	 
	 		const regExp_email = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i);
			// 이메일 정규표현식 객체 생성 

			const email = $("textarea[name='email']").val();
			const bool = regExp_email.test(email);

			if (!bool) {
				alert("올바른 이메일 주소를 작성해주세요.");
				return;
			}
			
			const regExp_phone = new RegExp(/^[0][1][0][1-9][0-9]{7}$/);
			// 연락처 국번( 가운데 숫자 4자리인데 첫번째 숫자는 1-9 이고 나머지는 0-9) 정규표현식 객체 생성 

			const phone = $("textarea[name='phone']").val();
			const bool2 = regExp_phone.test(phone);
			if (!bool2) {
				alert("올바른 휴대폰 번호를 작성해주세요.");
				return;
			}
	    	 
			
		    const checkbox_checked_length = $("input:checkbox[id='agree']:checked").length;

		    if(checkbox_checked_length == 0) {
		         alert("이용약관에 동의하셔야 합니다.");
		         return; // goRegister() 함수를 종료한다.
		    }
	    	 
	    	const frm = document.inquiryFrm;
			frm.searchType_a.value = $("select#searchType_a").val();
			frm.searchType_b.value = $("select#searchType_b").val();
	    	frm.method = "post";
	    	frm.action = "<%= ctxPath%>/community/inquiryEnd.do";
	    	frm.submit();
    	 
        }); // 문의접수 버튼 눌렀을 경우
        
        
		
	}); // end of $(document).ready
	
	
	
	
	

</script>



<div style="display: flex;" class="mt-4">
	<div style="width: 80%; margin: auto; padding-left: 3%;">

		<h2 style="margin-bottom: 30px;">1:1 문의하기</h2>
		<hr style="border-width:1px 0 0 0; border-color:#000;" class="mb-3">
		
		
		<form name="inquiryFrm" enctype="multipart/form-data">
		
			
			<div class="row mt-5" style="height: 50px;">
				<strong class="col-md-2 mt-3" style="text-align: center;">문의유형</strong>
				<select class="col-md-3" id="searchType_a" name="searchType_a">
					<option value="0">선택해주세요</option>
					<option value="1">동호회</option>
					<option value="2">체육관</option>
					<option value="3">플리마켓</option>
					<option value="3">기타</option>
				</select>
				<select class="col-md-3 ml-4" id="searchType_b" name="searchType_b">
					<option value="0">선택해주세요</option>
					<option value="1">대관문의</option>
					<option value="2">환불문의</option>
					<option value="3">기타문의</option>
				</select>
				<div class="col-md-4"></div>
			</div>
		
			<div class="row mt-5" style="height: 260px; border: solid 0px blue;">
				<strong class="col-md-2 mt-2 mb-4" style="text-align: center;">문의내용</strong>
				<textarea name="content" class="col-md6" rows="10" cols="78" placeholder="※상담사에게 폭언, 욕설 등을 하지 말아주세요. &#10;답변을 받지 못하거나 사전안내 없이 삭제될 수 있습니다."></textarea>
			</div>
		
			<br>
			
			<div class="row mt-2 d-flex align-items-center" style="height: 60px; border: solid 0px blue;">
			    <strong class="col-md-2 text-center"></strong>
			    <label class="custom-file-upload col-md-3 text-center d-flex align-items-center justify-content-center" style="height: 100%;">
			        <input type="file" name="attach" />
			        <span style="color: white;">+ 파일첨부하기(0/10)</span>
			    </label>
			    <div class="col-md-3 ml-2 mt-1 d-flex align-items-center" style="font-size: small;">
			        20MB까지 등록가능하며 첨부파일은 답변완료가 되면 <br> 즉시 삭제됩니다.
			    </div>
			</div>
			
			<div class="row mt-2" style="height: 50px; border: solid 0px blue;">
				<div class="col-md-7"></div>
				<div class="ml-4"></div>
				<div class="ml-4"></div>
				<div class="col-md-2" style="font-weight: bolder;">0/20MB</div>
			</div>

			<div class="row mt-2" style="height: 40px; border: solid 0px blue;">
				<strong class="col-md-2 mt-2 mb-4" style="text-align: center;">이메일 주소</strong>
				<textarea name="email" class="col-md6" rows="1" cols="78" placeholder="exam@naver.com"></textarea>
			</div>
			
			<div class="row mt-5 mb-5" style="height: 40px; border: solid 0px red;">
				<strong class="col-md-2 mt-2 mb-4" style="text-align: center;">휴대폰 번호</strong>
				<textarea name="phone" class="col-md6" rows="1" cols="78" placeholder="01012345678"></textarea>>
			</div>			

			<div class="row mt-5 mb-5" style="height: 20px; border: solid 0px red;">
				<div class="col-md-3"></div>
				<input type="checkbox" id="agree" class="col-md-1"><span class="mt-1">(필수) 개인정보 수집,이용동의&nbsp;&nbsp;<span id="view-policy" style="cursor: pointer; text-decoration: underline;">전문보기</span></span>
			</div>


	        <div class="privacy-info" id="privacy-info">
	      	  	<hr style="border-width:1px 0 0 0; border-color:#000;" class="mb-3">
	            <p><strong>개인정보 수집·이용에 대한 안내</strong></p>
	            <p><strong>필수 수집·이용 항목</strong></p>
	            <p>문의접수와 처리, 회신을 위한 최소한의 개인정보입니다. 동의가 필요합니다.</p>
	            <p><strong>수집항목</strong></p>
	            <ul>
	                <li>이메일 주소</li>
	                <li>휴대폰 번호</li>
	                <li>문의 및 상담 내용</li>
	            </ul>
	            <p><strong>목적</strong></p>
	            <p>고객문의 및 상담요청에 대한 회신, 상담을 위한 서비스 이용기록 조회</p>
	            <p><strong>보유기간</strong></p>
	            <p>3년간 보관 후 지체없이 파기</p>
	            <p>더 자세한 내용에 대해서는 <a href="#" target="_blank">AMADO 개인정보처리방침</a>을 참고하시기 바랍니다.</p>
	        </div>



			<div class="row mt-5 mb-5" style="height: 80px; border: solid 0px red;">
				<div class="col-md-3"></div>
				<button type="button" class="col-md-4" style="background-color: yellow;" id="inquiryWrite">
					<span style="font-weight: bolder; font-size: 18pt; font-style: inherit;">문의접수</span>
				</button>
			</div>
			
		</form>
		
		

	</div>
</div>












