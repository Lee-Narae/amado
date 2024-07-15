<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String ctxPath = request.getContextPath();
%>
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
   
      div.fileDrop{ display: inline-block; 
                 width: 100%; 
                 height: 100px;
                 overflow: auto;
                 background-color: #fff;
                 padding-left: 10px;}
                 
    div.fileDrop > div.fileList > span.delete{display:inline-block; width: 20px; border: solid 1px gray; text-align: center;} 
    div.fileDrop > div.fileList > span.delete:hover{background-color: #000; color: #fff; cursor: pointer;}
    div.fileDrop > div.fileList > span.fileName{padding-left: 10px;}
    div.fileDrop > div.fileList > span.fileSize{padding-right: 20px; float:right;} 

  </style>
  <!-- Daum 주소 API 스크립트 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">   

// Daum 주소 API를 이용한 주소 찾기 함수
function searchAddress() {
    new daum.Postcode({
        oncomplete: function(data) {
            document.getElementById('address').value = data.address;
            document.getElementById('postcode').value = data.zonecode;
            document.getElementById('detailaddress').focus();
        }
    }).open();
}//end of function searchAddress




$(document).ready(function() {

   //파일미리보기
   $(document).on("change", "input#imgfilename", function(e) {
       const inputFiles = e.target.files;
       const previewImagesContainer = document.getElementById("previewImages");
       previewImagesContainer.innerHTML = ""; 

       for (let i = 0; i < inputFiles.length; i++) {
           const fileReader = new FileReader();
           const imgElement = document.createElement("img");
           imgElement.style.width = "100px";

           fileReader.onload = function(event) {
               imgElement.src = event.target.result;
           };

           fileReader.readAsDataURL(inputFiles[i]);

           previewImagesContainer.appendChild(imgElement);
       }
   });
    // 폼 제출 시 알림 및 폼 전송
    $("button#submit").click(function() {
        alert("관리자가 승인해야 정상등록 됩니다");
        const frm = document.addFrm;
        frm.method = "post";
        frm.action = "<%= ctxPath%>/gym/registerGymend.do";
        frm.submit();
    });

    // 비용(input[type="number"]) 입력 필드에 대한 숫자만 입력 유효성 검사
    var costInput = document.getElementById("cost");
    costInput.addEventListener("input", function(event) {
        var value = event.target.value;
        if (isNaN(value)) {
            event.target.value = "";
            alert("숫자만 입력할 수 있습니다.");
        }
    });

    // 인원수(input[type="number"]) 입력 필드에 대한 숫자만 입력 유효성 검사
    var memberCountInput = document.getElementById("membercount");
    memberCountInput.addEventListener("input", function(event) {
        var value = event.target.value;
        if (isNaN(value)) {
            event.target.value = "";
            alert("숫자만 입력할 수 있습니다.");
        }
    });
    
    
    
    <%-- === jQuery 를 사용하여 드래그앤드롭(DragAndDrop)을 통한 파일 업로드 시작 === --%>
      let file_arr = []; // 첨부되어진 파일 정보를 담아둘 배열 
      
      // == 파일 Drag & Drop 만들기 == //
      $("div#fileDrop").on("dragenter", function(e){ /* "dragenter" 이벤트는 드롭대상인 박스 안에 Drag 한 파일이 최초로 들어왔을 때 */ 
          e.preventDefault();
           <%-- 
                브라우저에 어떤 파일을 drop 하면 브라우저 기본 동작이 실행된다. 
                이미지를 drop 하면 바로 이미지가 보여지게되고, 만약에 pdf 파일을 drop 하게될 경우도 각 브라우저의 pdf viewer 로 브라우저 내에서 pdf 문서를 열어 보여준다. 
                이것을 방지하기 위해 preventDefault() 를 호출한다. 
                즉, e.preventDefault(); 는 해당 이벤트 이외에 별도로 브라우저에서 발생하는 행동을 막기 위해 사용하는 것이다.
           --%>
           
           e.stopPropagation();
           <%--
               propagation 의 사전적의미는 전파, 확산이다.
               stopPropagation 은 부모태그로의 이벤트 전파를 stop 중지하라는 의미이다.
               즉, 이벤트 버블링을 막기위해서 사용하는 것이다. 
               사용예제 사이트 https://devjhs.tistory.com/142 을 보면 이해가 될 것이다. 
           --%>
      }).on("dragover", function(e){ /* "dragover" 이벤트는 드롭대상인 박스 안에 Drag 한 파일이 머물러 있는 중일 때. 필수이벤트이다. dragover 이벤트를 적용하지 않으면 drop 이벤트가 작동하지 않음 */ 
           e.preventDefault();
           e.stopPropagation();
           $(this).css("background-color", "#ffd8d8");
      }).on("dragleave", function(e){ /* "dragleave" 이벤트는 Drag 한 파일이 드롭대상인 박스 밖으로 벗어났을 때  */
           e.preventDefault();
           e.stopPropagation();
           $(this).css("background-color", "#fff");
      }).on("drop", function(e){      /* "drop" 이벤트는 드롭대상인 박스 안에서 Drag 한것을 Drop(Drag 한 파일(객체)을 놓는것) 했을 때. 필수이벤트이다. */
           e.preventDefault();
          
           var files = e.originalEvent.dataTransfer.files;  
           <%--  
               jQuery 에서 이벤트를 처리할 때는 W3C 표준에 맞게 정규화한 새로운 객체를 생성하여 전달한다.
               이 전달된 객체는 jQuery.Event 객체 이다. 이렇게 정규화된 이벤트 객체 덕분에, 
               웹브라우저별로 차이가 있는 이벤트에 대해 동일한 방법으로 사용할 수 있습니다. (크로스 브라우징 지원)
               순수한 dom 이벤트 객체는 실제 웹브라우저에서 발생한 이벤트 객체로, 네이티브 객체 또는 브라우저 내장 객체 라고 부른다.
           --%>
           /*  Drag & Drop 동작에서 파일 정보는 DataTransfer 라는 객체를 통해 얻어올 수 있다. 
               jQuery를 이용하는 경우에는 event가 순수한 DOM 이벤트(각기 다른 웹브라우저에서 해당 웹브라우저의 객체에서 발생되는 이벤트)가 아니기 때문에,
               event.originalEvent를 사용해서 순수한 원래의 DOM 이벤트 객체를 가져온다.
               Drop 된 파일은 드롭이벤트가 발생한 객체(여기서는 $("div#fileDrop")임)의 dataTransfer 객체에 담겨오고, 
               담겨진 dataTransfer 객체에서 files 로 접근하면 드롭된 파일의 정보를 가져오는데 그 타입은 FileList 가 되어진다. 
               그러므로 for문을 사용하든지 또는 [0]을 사용하여 파일의 정보를 알아온다. 
         */
      //  console.log(typeof files); // object
       //  console.log(files);
           <%--
            FileList {0: File, length: 1}
            0: File {name: 'berkelekle단가라포인트03.jpg', lastModified: 1605506138000, lastModifiedDate: Mon Nov 16 2020 14:55:38 GMT+0900 (한국 표준시), webkitRelativePath: '', size: 57641, …}
               length: 1
            [[Prototype]]: FileList
            
            
            
            FileList {0: File, 1: File, 2: File, 3: File, length: 4}
            0: File {name: 'berkelekle덩크04.jpg', lastModified: 1605506138000, lastModifiedDate: Mon Nov 16 2020 14:55:38 GMT+0900 (GMT+09:00), webkitRelativePath: '', size: 41931, …}
            1: File {name: 'berkelekle디스트리뷰트06.jpg', lastModified: 1605506138000, lastModifiedDate: Mon Nov 16 2020 14:55:38 GMT+0900 (GMT+09:00), webkitRelativePath: '', size: 48901, …}
            2: File {name: 'berkelekle심플V넥02.jpg', lastModified: 1605506138000, lastModifiedDate: Mon Nov 16 2020 14:55:38 GMT+0900 (GMT+09:00), webkitRelativePath: '', size: 58889, …}
            3: File {name: 'berkelekle단가라포인트03.jpg', lastModified: 1605506138000, lastModifiedDate: Mon Nov 16 2020 14:55:38 GMT+0900 (GMT+09:00), webkitRelativePath: '', size: 57641, …}
               length: 4
            [[Prototype]]: FileList
           --%>
            
         if(files != null && files != undefined) {
            <%-- console.log("files.length 는 => " + files.length);  
                   // files.length 는 => 1 이 나온다.
                   // files.length 는 => 4 가 나온다. 
              --%>    
                 
              <%--
                 for(let i=0; i<files.length; i++){
                      const f = files[i];
                      const fileName = f.name;  // 파일명
                      const fileSize = f.size;  // 파일크기
                      console.log("파일명 : " + fileName);
                      console.log("파일크기 : " + fileSize);
                  } // end of for------------------------
              --%>
               
              let html = "";
              const f = files[0]; // 어차피 files.length 의 값이 1 이므로 위의 for문을 사용하지 않고 files[0] 을 사용하여 1개만 가져오면 된다. 
             let fileSize = f.size/1024/1024;  /* 파일의 크기는 MB로 나타내기 위하여 /1024/1024 하였음 */
          
              if( !(f.type == 'image/jpeg' || f.type == 'image/png') ) {
                 alert("jpg 또는 png 파일만 가능합니다.");
                 $(this).css("background-color", "#fff");
                 return;
              }
          
              else if(fileSize >= 10) {
                 alert("10MB 이상인 파일은 업로드할 수 없습니다.!!");
                 $(this).css("background-color", "#fff");
                 return;
              }
          
              else {
                 file_arr.push(f);
                 const fileName = f.name; // 파일명   
              
                  fileSize = fileSize < 1 ? fileSize.toFixed(3) : fileSize.toFixed(1);
                  // fileSize 가 1MB 보다 작으면 소수부는 반올림하여 소수점 3자리까지 나타내며, 
                   // fileSize 가 1MB 이상이면 소수부는 반올림하여 소수점 1자리까지 나타낸다. 만약에 소수부가 없으면 소수점은 0 으로 표시한다.
                   /* 
                        numObj.toFixed([digits]) 의 toFixed() 메서드는 숫자를 고정 소수점 표기법(fixed-point notation)으로 표시하여 나타난 수를 문자열로 반환해준다. 
                                        파라미터인 digits 는 소수점 뒤에 나타날 자릿수 로써, 0 이상 20 이하의 값을 사용할 수 있으며, 구현체에 따라 더 넓은 범위의 값을 지원할 수도 있다. 
                        digits 값을 지정하지 않으면 0 을 사용한다.
                        
                        var numObj = 12345.6789;
   
                   numObj.toFixed();       // 결과값 '12346'   : 반올림하며, 소수 부분을 남기지 않는다.
                   numObj.toFixed(1);      // 결과값 '12345.7' : 반올림한다.
                   numObj.toFixed(6);      // 결과값 '12345.678900': 빈 공간을 0 으로 채운다.
                   */
                  html += 
                       "<div class='fileList'>" +
                           "<span class='delete'>&times;</span>" +
                           "<span class='fileName'>"+fileName+"</span>" +
                           "<span class='fileSize'>"+fileSize+" MB</span>" +
                           "<span class='clear'></span>" +
                       "</div>";
                  $(this).append(html);
                  
               // ===>> 이미지파일 미리보기 시작 <<=== // 
                  // 자바스크립트에서 file 객체의 실제 데이터(내용물)에 접근하기 위해 FileReader 객체를 생성하여 사용한다.
              // console.log(f);
                  const fileReader = new FileReader();
                 fileReader.readAsDataURL(f); // FileReader.readAsDataURL() --> 파일을 읽고, result속성에 파일을 나타내는 URL을 저장 시켜준다. 
                
                 fileReader.onload = function() { // FileReader.onload --> 파일 읽기 완료 성공시에만 작동하도록 하는 것임. 
                 // console.log(fileReader.result); 
                   /*
                     data:image/jpeg;base64,/9j/4AAQSkZJRgABAQEAeAB4AAD/2wBDAAIBAQIBAQICAgICAgICAwUDAwMDAwYEBAMFBwYHBwcGBwcICQsJCAgKCAcHCg0KCgsMDAwMBwkODw0MDgsMDAz/2wBDAQICAg 
                     이러한 형태로 출력되며, img.src 의 값으로 넣어서 사용한다.
                    */
                    document.getElementById("previewImg").src = fileReader.result;
                };
                // ===>> 이미지파일 미리보기 끝 <<=== //
              }
               
         }// end of if(files != null && files != undefined)---------   
           
         $(this).css("background-color","#fff");
      });
   
      
      // == Drop 되어진 파일목록 제거하기 == //
      $(document).on("click", "span.delete", function(e){
         
         let idx = $("span.delete").index($(e.target));
      // alert("인덱스 : " + idx);
         
         file_arr.splice(idx, 1);
      // console.log(file_arr);
        <%-- 
              배열명.splice() : 배열의 특정 위치에 배열 요소를 추가하거나 삭제하는데 사용한다. 
                              삭제할 경우 리턴값은 삭제한 배열 요소이다. 삭제한 요소가 없으면 빈 배열( [] )을 반환한다.
      
             배열명.splice(start, 0, element);  // 배열의 특정 위치에 배열 요소를 추가하는 경우 
                         start   - 수정할 배열 요소의 인덱스
                           0       - 요소를 추가할 경우
                           element - 배열에 추가될 요소
            
              배열명.splice(start, deleteCount); // 배열의 특정 위치의 배열 요소를 삭제하는 경우    
                           start   - 수정할 배열 요소의 인덱스
                           deleteCount - 삭제할 요소 개수
      --%>
         $(e.target).parent().remove();
      });
      
  <%-- === jQuery 를 사용하여 드래그앤드롭(DragAndDrop)을 통한 파일 업로드 끝 === --%>
});


</script>



<h1>체육관 등록</h1>
  
<form name="addFrm" id="gym-registration-form" enctype="multipart/form-data">
    <div class="form-group">
      <label for="gym-name">체육관명</label>
      <input type="text" id="gymname" name="gymname" required>
    </div>
    
    <div class="form-group">
      <label for="manager-id">담당자 아이디</label>
      <input type="text" name="fk_userid" value="${sessionScope.loginuser.userid}" required readonly>
    </div>
     <div class="form-group">
        <label for="address">주소</label>
        <input type="text" id="address" name="address" required>
         <br><br>
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
   
       
   <%-- ==== 추가이미지파일을 마우스 드래그앤드롭(DragAndDrop)으로 추가하기 ==== --%>
    <tr>
          <td width="25%" class="prodInputName" style="padding-bottom: 10px;">추가이미지파일(선택)</td>
          <td>
             <span style="font-size: 10pt;">파일을 1개씩 마우스로 끌어 오세요</span>
          <div id="fileDrop" class="fileDrop border border-secondary"></div>
          </td>
    </tr>
    
    
   <%--
    <div class="form-group">
     <label for="attachment">여러 파일</label>
     <input type="file" id="several_photos" name="attach" multiple>
   </div>
    --%> 
   
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
  
