<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String ctxPath = request.getContextPath();
%>
 <!-- Daum 주소 API 스크립트 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <style>
    h1 {
      text-align: center;
      margin-bottom: 30px;
    }
    #gym-registration-form {
      max-width: 700px; /* 폼 전체의 최대 너비를 조정합니다 */
      margin: 0 auto; /* 가운데 정렬을 위해 margin을 auto로 설정합니다 */
      background-color: #fff;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    .form-group {
      margin-bottom: 20px;
    }

    label {
      font-weight: bold;
      display: block;
      margin-bottom: 5px;
    }

    input[type="text"],
    input[type="number"],
    select,
    textarea {
      width: 100%;
      padding: 10px;
      font-size: 16px;
      border: 1px solid #ccc;
      border-radius: 5px;
      box-sizing: border-box;
    }

    button {
      padding: 10px 20px;
      background-color: #4CAF50;
      color: white;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      transition: background-color 0.3s;
    }

    button:hover {
      background-color: #45a049;
    }

    input[type="file"] {
      font-size: 16px;
    }

    textarea {
      height: 150px;
    }

    .form-group .note {
      font-size: 14px;
      color: #666;
      margin-top: 5px;
    }
  </style>
 
 
  <script type="text/javascript">	
   
  
  	// Daum 주소 API를 이용한 주소 찾기 함수
    function searchAddress() {
            // 주소 검색 로직 구현 (예: 카카오 주소 검색 API 사용)
            new daum.Postcode({
                oncomplete: function(data) {
                    // 검색된 주소를 'address' 입력 필드에 설정
                    document.getElementById('address').value = data.address;
                    // 우편번호를 'postcode' 입력 필드에 설정
                    document.getElementById('postcode').value = data.zonecode;
                    // 상세주소 입력 필드에 포커스를 설정
                    document.getElementById('detailAddress').focus();
                }
            }).open();
        }
    
    function goBack() {
        window.history.back(); // 이전 페이지로 이동하는 함수
    }
    
    // 제품 이미지 파일 선택 시 미리보기 기능
  $(document).ready(function() {
    $(document).on("change", "input#attachment", function(e) {
        const input_file = $(e.target).get(0);
        const fileReader = new FileReader();
        fileReader.readAsDataURL(input_file.files[0]);
        fileReader.onload = function() {
            document.getElementById("previewImg").src = fileReader.result;
        };
  
        
    
    });
   
    
    $("button#submit").click(function(){
	 	 
		  //폼(form)을 전송(submit)
    	 const frm = document.addFrm;
 	    frm.method = "post";
 	    frm.action = "<%= ctxPath%>/gym/registerGymend.do";
 	    frm.submit();
	 	  
	 });
  
}); //end of   $(document).ready(function() ----------------------
 
  </script>

<h1>체육관 등록</h1>
  
<form name="addFrm" id="gym-registration-form" enctype="multipart/form-data">
    <div class="form-group">
      <label for="gym-name">체육관명</label>
      <input type="text" id="gymname" name="gymname" required>
    </div>
    
    <div class="form-group">
      <label for="manager-id">담당자 아이디</label>
      <input type="text" name="fk_userid" value="${sessionScope.loginuser.userid}" required disabled>
    </div>
     <div class="form-group">
        <label for="address">주소</label>
        <input type="text" id="address" name="address" required>
        <br>
        <button type="button" onclick="searchAddress()">주소 찾기</button>
    </div>
    <div class="form-group">
        <label for="postcode">우편번호</label>
        <input type="text" id="postcode" name="postcode" required>
    </div>
    <div class="form-group">
        <label for="detailaddress">상세주소</label>
        <input type="text" id="detailaddress" name="detailaddress" required>
    </div>
    
    <div class="form-group">
      <label>실내/실외</label>
      <select name="insidestatus">
        <option selected>선택하세요</option>
        <option value="0">실내</option>
        <option value="1">실외</option>
      </select>
    </div>
    
    <div class="form-group">
      <label for="cost">비용</label>
      <input type="number" id="cost" name="cost" required>
    </div>
    
    <div class="form-group">
      <label for="cost">인원수</label>
      <input type="number" id="membercount" name="membercount" required>
    </div>
    
	 <div class="form-group">
	  <label for="attachment">첨부 파일</label>
	  <input type="file" id="imgfilename" name="attach" multiple>
	</div>
	
	<!-- 이미지 미리보기 -->
    <div class="form-group">
        <label for="previewImg">이미지 미리보기</label>
        <img id="previewImg" width="300">
    </div>
	
	    
    <div class="form-group">
      <label for="notes">공간 정보</label>
      <textarea id="info" name="info"></textarea>
    </div>
 
    <div class="form-group">
      <label for="notes">주의 사항</label>
      <textarea id="caution" name="caution"></textarea>
    </div>
    
    
    <button id="submit" type="submit">등록</button>
    <button type="button" onclick="goBack()" class="btn btn-danger">취소</button>
</form>
  
