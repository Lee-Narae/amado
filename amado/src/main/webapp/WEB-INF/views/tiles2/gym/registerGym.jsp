<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String ctxPath = request.getContextPath();
%>
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" /> 
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
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


	#plusImg {
	width: 50%;
	border: solid 1px gray;
	background-color: white;
	border-radius: 10px;
	height: 120px;
	padding: 1%;
}
	
  </style>
  <!-- Daum 주소 API 스크립트 -->
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/i18n/jquery-ui-i18n.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=662f0c20f3779577049f168f34f1f1bc"></script>
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

let total_fileSize = 0;
let lat = 0; // 위도
let lng = 0; // 경도


$(document).ready(function() {
	
	$("input#cost").next().hide();
	$("input#membercount").next().hide();
	
	// 비용 / 인원수 유효성 검사
	// 1. 비용
	$("input#cost").change(function(e){
		if($(e.target).val() < 0){
			$(e.target).next().show();
		}
		else {
			$(e.target).next().hide();
		}
	});
	
	$("input#cost").keyup(function(e){
		if($(e.target).val() < 0){
			$(e.target).next().show();
		}
		else {
			$(e.target).next().hide();
		}
	});
	
	$("input#membercount").change(function(e){
		if($(e.target).val() < 0){
			$(e.target).next().show();
		}
		else {
			$(e.target).next().hide();
		}
	});
	$("input#membercount").keyup(function(e){
		if($(e.target).val() < 0){
			$(e.target).next().show();
		}
		else {
			$(e.target).next().hide();
		}
	});	
	

   /* //파일미리보기
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
 */

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
    
    
    
	
	// file 태그에 첨부된 file 크기 누적용
	$(document).on("change", "input[name='attach']", function(e){
	       const input_file = $(e.target).get(0);
	       total_fileSize += input_file.files[0].size;
	       console.log(total_fileSize);
	});
	
	// 추가이미지 드래그앤드롭
	let file_arr = [];
	$("div#plusImg").on("dragenter", function(e){
		e.preventDefault();
       e.stopPropagation();
	}).on("dragover", function(e){ 
        e.preventDefault();
        e.stopPropagation();
        $(this).css("background-color", "#e0f1d0");
    }).on("dragleave", function(e){
        e.preventDefault();
        e.stopPropagation();
        $(this).css("background-color", "#fff");
    }).on("drop", function(e){
          e.preventDefault();
          var files = e.originalEvent.dataTransfer.files;
         
          if(files != null && files != undefined){
       	   let html = "";
              const f = files[0]; // 어차피 files.length 의 값이 1 이므로 위의 for문을 사용하지 않고 files[0] 을 사용하여 1개만 가져오면 된다. 
              let fileSize = f.size/1024/1024;

              if( !(f.type == 'image/jpeg' || f.type == 'image/png') ) {
               alert("jpg 또는 png파일만 가능합니다.");
               $(this).css("background-color", "#fff");
               return;
           }
              
           else if(fileSize >= 10) {
               alert("10MB 이상인 파일은 업로드할 수 없습니다.");
               $(this).css("background-color", "#fff");
               return;
           }
              
           else {
              
        	   file_arr.push(f);
               const fileName = f.name; // 파일명   
              
               fileSize = fileSize < 1 ? fileSize.toFixed(3) : fileSize.toFixed(1);
                   
                  html += "<div class='fileList'>" +
                       "<span class='delete'>&times;</span>" +
                       "<span class='fileName'>"+fileName+"</span>" +
                       "<span class='fileSize'>"+fileSize+"MB</span>" +
                       "<span class='clear'></span>" +
                       "</div>";
               $(this).append(html);
           }
              
           }
          
         $(this).css("background-color", "#fff");
          
    });
	              
	$(document).on("click", "span.delete", function(e){
		
		let idx = $("span.delete").index($(e.target));
		file_arr.splice(idx, 1);
		
		// console.log(file_arr);
		$(e.target).parent().remove();
	});
	
	
	$(document).on("keyup", "input[name='detailaddress']", function(){
		// 위경도 값 넣기
        var geocoder = new kakao.maps.services.Geocoder();
        // 주소-좌표 변환 객체를 생성한다
        geocoder.addressSearch($("input[name='address']").val(), function(result, status) {

        	lat = result[0].y;
        	lng = result[0].x;
     	    
        	$("input[name='lat']").val(lat);
        	$("input[name='lng']").val(lng);
        	 
     	});
	});
	
	
	// 등록하기
	$("button[id='submit']").click(function(){
		
		if($("input[name='gymname']").val().trim() == ''){
			swal('체육관 명을 입력하세요.');
			return;
		}
		if($("input[name='postcode']").val().trim() == ''){
			swal('우편번호를 입력하세요.');
			return;
		}
		if($("input[name='address']").val().trim() == ''){
			swal('주소를 입력하세요.');
			return;
		}
		if($("input[name='detailaddress']").val().trim() == ''){
			swal('상세주소를 입력하세요.');
			return;
		}
		if($("textarea[name='info']").val().trim() == ''){
			swal('공간정보를 입력하세요.');
			return;
		}
		if($("input[name='cost']").val().trim() == '' || isNaN($("input[name='cost']").val().trim())){
			swal('올바른 비용을 입력하세요.');
			("input[name='cost']").val('');
			return;
		}
		if($("textarea[name='caution']").val().trim() == ''){
			swal('주의사항을 입력하세요.');
			return;
		}
		if($("input[name='membercount']").val().trim() == '' || $("input[name='membercount']").val().trim()<0 ||
		   $("input[name='membercount']").val().trim() > 500 || isNaN($("input[name='membercount']").val().trim())){
			swal('올바른 수용인원을 입력하세요.');
			$("input[name='membercount']").val('0');
			return;
		}
		
		if($("input[name='attach']").val().trim() == ''){
			swal('대표이미지 파일을 첨부하세요.');
			return;
		}
		
		if(file_arr.length == 0){
			swal('추가이미지 파일을 첨부하세요.');
			return;
		}
		
		if(file_arr.length < 1 || file_arr.length > 5){
			swal('추가이미지는 최소 1개, 최대 5개까지 첨부 가능합니다.');
			return;
		}
        
		var formData = new FormData($("form[name='addFrm']")[0]);
         
        if(file_arr.length > 0){ // 추가 이미지 파일이 있을 경우
         	// 첨부한 파일의 총합의 크기가 10MB 이상 이라면 전송을 하지 못하게 막는다.
         
         	let sum_file_size = 0;
         	
         	for(let i=0; i<file_arr.length; i++){
         		sum_file_size += file_arr[i].size;
         	};
         	
            // 첨부한 파일의 총량을 누적하는 용도 
            total_fileSize += sum_file_size;
         	
			if( sum_file_size >= 10*1024*1024 ) { // 첨부한 파일의 총합의 크기가 10MB 이상 이라면 
				alert("첨부한 추가이미지 파일의 총합의 크기가 10MB 이상이므로 등록이 불가합니다.");
				return; // 종료
	        }
			else{
				file_arr.forEach(function(item, index){
					 formData.append("file_arr", item);
				});
			}
			
        } // end of if(file_arr.length > 0)
         
        // 첨부한 파일의 총량이 20MB 초과시 //   
        if( total_fileSize > 20*1024*1024 ) {
        	console.log
             alert("첨부한 파일의 총합의 크기가 20MB를 넘어 등록이 불가합니다.");
             return; // 종료
        }

        
        /*
	    	processData 관련하여, 일반적으로 서버에 전달되는 데이터는 query string(쿼리 스트링)이라는 형태로 전달된다. 
	    	ex) http://localhost:9090/board/list.action?searchType=subject&searchWord=안녕
	    	? 다음에 나오는 'searchType=subject&searchWord=안녕'이라는 것이 query string(쿼리 스트링)이다. 
	    	
	    	data 파라미터로 전달된 데이터를 jQuery에서는 내부적으로 query string으로 만든다. 
	    	하지만 파일 전송의 경우 내부적으로 query string으로 만드는 작업을 하지 않아야 한다.
	    	이와 같이 내부적으로 query string으로 만드는 작업을 하지 않도록 설정하는 것이 processData: false이다.
	    */
	
	    /*
	    	contentType 은 default 값이 "application/x-www-form-urlencoded; charset=UTF-8" 인데, 
	    	"multipart/form-data" 로 전송이 되도록 하기 위해서는 false로 해야 한다. 
	    	만약에 false 대신에 "multipart/form-data"를 넣어보면 제대로 작동하지 않는다.
	    */

        $.ajax({
            url: "<%= ctxPath%>/gym/registerGymend.do",
            type: "post",
            data: formData,
            processData: false,  // 파일 전송시 설정 
            contentType: false,  // 파일 전송시 설정
            dataType: "json",
            success: function(json){
            	if(json.n == 1){
            		alert('관리자가 승인해야 정상등록 됩니다!');
            		location.href = "<%=ctxPath%>/gym/rental_gym.do";
            	}
            },
            error: function(request, status, error){
               alert("첨부된 파일의 크기의 총합이 20MB를 초과하여 등록이 불가합니다.");
          }
            
        });

			
	}); // $("input:button[id='btnRegister']").click
	
  
 
	
	
	
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
      <input type="number" id="cost" name="cost" >
      <div style="color: red;">비용은 0이상의 숫자만 가능합니다.</div>
    </div>
    
    <div class="form-group">
      <label for="cost">인원수</label>
      <input type="number" id="membercount" name="membercount" >
      <div style="color: red;">인원수는 0이상의 숫자만 가능합니다.</div>
    </div>
    
    <div class="form-group">
     <label for="attachment">대표이미지</label>
     <input type="file" id="imgfilename" name="attach" multiple>
   </div>
   <div class="tr" style="display: flex;">
		<div class="td title">추가이미지</div>
		<div id="plusImg" align="left" style="font-size: 10pt;">🖼️ 추가이미지 파일을 하나씩 드래그하세요.</div>
	</div>
       
   <%-- ==== 추가이미지파일을 마우스 드래그앤드롭(DragAndDrop)으로 추가하기 ==== --%>
   <!--  <tr>
          <td width="25%" class="prodInputName" style="padding-bottom: 10px;">추가이미지파일(선택)</td>
          <td>
             <span style="font-size: 10pt;">파일을 1개씩 마우스로 끌어 오세요</span>
          <div id="fileDrop" class="fileDrop border border-secondary"></div>
          </td>
    </tr>
    
     -->
   <%--
    <div class="form-group">
     <label for="attachment">여러 파일</label>
     <input type="file" id="several_photos" name="attach" multiple>
   </div>
    --%> 

   
       
    <div class="form-group">
      <label for="notes">공간 정보</label>
      <textarea id="info" name="info"></textarea>
    </div>
 
    <div class="form-group">
      <label for="notes">주의 사항</label>
      <textarea id="caution" name="caution"></textarea>
    </div>
    
    <input type="hidden" name="lat"/>
	<input type="hidden" name="lng"/>
    
    <button id="submit" type="button">등록</button>
    <button type="button" onclick="goBack()" class="btn btn-danger">취소</button>
    
</form>
  
