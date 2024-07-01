<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String ctxPath = request.getContextPath();
%>
 <!-- Daum 주소 API 스크립트 -->
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <style>
    h1 {
      text-align: center;
      margin-bottom: 30px;
    }

    #gym-registration-form {
      max-width: 500px;
      margin: 0 auto;
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
      new daum.Postcode({
        oncomplete: function(data) {
          document.getElementById('address').value = data.address; // 선택한 주소를 입력란에 자동 입력
        }
      }).open();
    }
  </script>

<h1>체육관 등록</h1>
  
  <form id="gym-registration-form" enctype="multipart/form-data">
    <div class="form-group">
      <label for="gym-name">체육관명</label>
      <input type="text" id="gym-name" name="gym-name" required>
    </div>
    
    <div class="form-group">
      <label for="manager-id">담당자 아이디</label>
      <input type="text" id="manager-id" name="manager-id" required>
    </div>
    
    <div class="form-group">
      <label for="address">주소</label>
      <input type="text" id="address" name="address" required>
      <button type="button" onclick="searchAddress()">주소 찾기</button>
    </div>
    
    <div class="form-group">
      <label for="operational-status">운영 여부</label>
      <select id="operational-status" name="operational-status" required>
        <option value="">선택하세요</option>
        <option value="운영중">운영중</option>
        <option value="운영중지">운영중지</option>
      </select>
    </div>
    
    <div class="form-group">
      <label for="cost">비용</label>
      <input type="number" id="cost" name="cost" required>
    </div>
    
    <div class="form-group">
      <label for="attachment">첨부 파일</label>
      <input type="file" id="attachment" name="attachment">
    </div>
    
    <div class="form-group">
      <label for="notes">공간 정보</label>
      <textarea id="notes" name="notes"></textarea>
    </div>
 
    <div class="form-group">
      <label for="notes">주의 사항</label>
      <textarea id="notes" name="notes"></textarea>
    </div>
    
       
    
    <button type="submit">등록</button>
  </form>
  
