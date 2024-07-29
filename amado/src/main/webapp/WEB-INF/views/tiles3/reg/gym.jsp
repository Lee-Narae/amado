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
height: 30px;
}

#plusImg {
width: 50%;
border: solid 1px gray;
background-color: white;
border-radius: 10px;
height: 120px;
padding: 1%;
}

.delete {
color: red;
font-weight: bold;
font-size: 15pt;
margin-right: 1%;
}

.fileName {
font-size: 12pt;
display: inline-block;
min-width: 50%;
}
</style>

<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" /> 
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/i18n/jquery-ui-i18n.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1d1ded080a235938c8e4701b8f4565e5&libraries=services"></script>
<script type="text/javascript">

let total_fileSize = 0;
let lat = 0; // 위도
let lng = 0; // 경도

$(document).ready(function(){
	
	$("div#gymR").addClass("hover");
	
	$("#membercount").spinner({
        spin: function(event, ui) {
           if(ui.value > 500) {
              $(this).spinner("value", 500);
              return false;
           }
           else if(ui.value < 0) {
              $(this).spinner("value", 0);
              return false;
           }
        }
    });
	
	$("#membercount").width(50);
	
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
	$("button[id='gymRegBtn']").click(function(){
		
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
        
		var formData = new FormData($("form[name='gymRegFrm']")[0]);
         
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
            url: "<%=ctxPath%>/admin/reg/gymReg",
            type: "post",
            data: formData,
            processData: false,  // 파일 전송시 설정 
            contentType: false,  // 파일 전송시 설정
            dataType: "json",
            success: function(json){
            	if(json.n == 1){
            		alert('등록 완료!');
            		location.href = "<%=ctxPath%>/gym/rental_gym.do";
            	}
            },
            error: function(request, status, error){
               alert("첨부된 파일의 크기의 총합이 20MB를 초과하여 등록이 불가합니다.");
          }
            
        });

			
	}); // $("input:button[id='btnRegister']").click
	
	
}); // document.ready

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

<div style="width: 100%; min-height: 810px; padding-bottom: 5%;" align="center">

<div id="gymContent" style="width: 80%;">
<img width="260" class="mt-5" src="<%=ctxPath%>/resources/images/narae/gymReg.png"/>

<div id="gymReg" style="width: 100%; margin-top: 3%;">
	<form name="gymRegFrm" enctype="multipart/form-data">
		<div class="tr" style="display: flex;">
			<div class="td title">체육관 명</div>
			<div class="td input"><input type="text" name="gymname" style="padding-left: 1%;"/></div>
		</div>
		<div class="tr" style="display: flex;">
			<div class="td title">주소</div>
			<div class="td input"><button type="button" class="btn btn-info" onclick="addressMatching()">검색</button></div>
		</div>
		<div id="forAddress" style="margin-bottom: 1%; padding-left: 21%;" align="left">
			<input type="text" name="postcode" id="postcode" readonly placeholder="우편번호" style="width: 10%;"/><br>
			<input type="text"  name="address" id="address" readonly placeholder="주소"/>
			<input type="text"  name="detailaddress" placeholder="상세주소" style="width: 50%;"/>
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
			<div class="td title">비용</div>
			<div class="td input" style="width:50%; font-weight: bold;" align="left"><input type="text" name="cost" />&nbsp;원 / 1시간</div>
		</div>
		<div class="tr" style="display: flex;">
			<div class="td title">인원</div>
			<div class="td input" style="font-weight: bold;"><input type="text" name="membercount" id="membercount" style="height: 30px;"/>&nbsp;명</div>
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
			<div class="td input"><input type="file" name="attach" style="border: none; margin-top: 1%;"/></div>
		</div>
		<div class="tr" style="display: flex;">
			<div class="td title">추가이미지</div>
			<div id="plusImg" align="left" style="font-size: 10pt;">🖼️ 추가이미지 파일을 하나씩 드래그하세요.</div>
		</div>
		<input type="hidden" name="lat"/>
		<input type="hidden" name="lng"/>
	</form>	
</div>

</div>

	<div style="margin-top: 5%;">
		<button type="button" class="btn btn-primary" id="gymRegBtn">등록하기</button>
		<button type="button" class="btn btn-light">취소</button>
	</div>
	
</div>