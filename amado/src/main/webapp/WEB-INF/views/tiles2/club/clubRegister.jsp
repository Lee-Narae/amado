<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
   String ctxPath = request.getContextPath();
%>    

    
<style type="text/css">
    
#profile{
	display: flex;
}
#pimg{
	border: solid 1px gray;
	width: 170px;
	height: 190px;
	text-align: center;
	
}
#infoo{
	border: solid 0px gray;
	margin-left: 5%;
}
select{
	width: 10%;
    height: 35px;
}
#simple-list-example{
	 width: 60%; 
	 text-align: left; 
	 border: solid 1px gray; 
	 border-radius:8%;
	 padding:13%;
	 margin-left: 10%;
}
   
</style>
 
<script type="text/javascript">

$(document).ready(function(){
	
	let total_fileSize = 0; // 첨부한 파일의 총량을 누적하는 용도
	
	 // ==>> 제품이미지 파일선택을 선택하면 화면에 이미지를 미리 보여주기 시작 <<== //
	 $(document).on("change", "input.img_file", function(e){
		
		 const input_file =  $(e.target).get(0);
		 // jQuery선택자.get(0) 은 jQuery 선택자인 jQuery Object 를 DOM(Document Object Model) element 로 바꿔주는 것이다. 
		 // DOM element 로 바꿔주어야 순수한 javascript 문법과 명령어를 사용할 수 있게 된다. 
		 
	  // console.log(input_file);
	  // <input type="file" name="pimage1" class="infoData img_file" accept="image/*"> 
		
	  // console.log(input_file.files);
	  /* 	 
		 FileList {0: File, length: 1}
	     0: File {name: 'berkelekle심플라운드01.jpg', lastModified: 1605506138000, lastModifiedDate: Mon Nov 16 2020 14:55:38 GMT+0900 (GMT+09:00), webkitRelativePath: '', size: 71317, …}
	     length: 1
	     [[Prototype]]: FileListitem: ƒ item()length: (...)constructor: ƒ FileList()Symbol(Symbol.iterator): ƒ values()Symbol(Symbol.toStringTag): "FileList"get length: ƒ length()[[Prototype]]: Object
	  */
	     
	  // console.log(input_file.files[0]);
	  /* File {name: 'berkelekle심플라운드01.jpg', lastModified: 1605506138000, lastModifiedDate: Mon Nov 16 2020 14:55:38 GMT+0900 (GMT+09:00), webkitRelativePath: '', size: 71317, …}
		 >>설명<<
		 name : 단순 파일의 이름 string타입으로 반환 (경로는 포함하지 않는다.)
		 lastModified : 마지막 수정 날짜 number타입으로 반환 (없을 경우, 현재 시간)
		 lastModifiedDate: 마지막 수정 날짜 Date객체타입으로 반환
		 size : 64비트 정수의 바이트 단위 파일의 크기 number타입으로 반환
		 type : 문자열인 파일의 MIME 타입 string타입으로 반환 
		        MIME 타입의 형태는 type/subtype 의 구조를 가지며, 다음과 같은 형태로 쓰인다. 
				 text/plain
				 text/html
				 image/jpeg
				 image/png
				 audio/mpeg
				 video/mp4
				...
	   */
	   
	  //  console.log(input_file.files[0].name);
		 // berkelekle심플라운드01.jpg
		 
		// 자바스크립트에서 file 객체의 실제 데이터(내용물)에 접근하기 위해 FileReader 객체를 생성하여 사용한다.
		  const fileReader = new FileReader();
		 
		  fileReader.readAsDataURL(input_file.files[0]); 
		  // FileReader.readAsDataURL() --> 파일을 읽고, result속성에 파일을 나타내는 URL을 저장 시켜준다.
		 
		  fileReader.onload = function(){ // FileReader.onload --> 파일 읽기 완료 성공시에만 작동하도록 하는 것임.
		    // console.log(fileReader.result);
			  /*
		        data:image/jpeg;base64,/9j/4AAQSkZJRgABAQEAeAB4AAD/2wBDAAIBAQIBAQICAgICAgICAwUDAwMDAwYEBAMFBwYHBwcGBwcICQsJCAgKCAcHCg0KCgsMDAwMBwkODw0MDgsMDAz/2wBDAQICAg 
		        이러한 형태로 출력되며, img.src 의 값으로 넣어서 사용한다.
		      */
		      
		      document.getElementById("previewImg").src = fileReader.result;
		  };
		  
		  
	 });//end of  $(document).on("change", "input.img_file", function(e){------------
	 // ==>> 제품이미지 파일선택을 선택하면 화면에 이미지를 미리 보여주기 끝 <<== //

	 
	 /////////////////////////////////////////////////////////////////
	
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
        	
	        	if( !(f.type == 'image/jpeg' || f.type == 'image/png') ) {
	        		alert("jpg 또는 png 파일만 가능합니다.");
	        		$(this).css("background-color", "#fff");
	        		return;
	        	}
	        	
	        	else {
	        		file_arr.push(f);
		        	const fileName = f.name; // 파일명	
	        	
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

	
	
   
    // 등록하기 버튼
    $("button#btnRegister").click(function(){
  	 
    	
      let is_infoData_OK = true;
    	
      if(is_infoData_OK) {
		   
  		/* 
             FormData 객체는 ajax 로 폼 전송을 가능하게 해주는 자바스크립트 객체이다.
             즉, FormData란 HTML5 의 <form> 태그를 대신 할 수 있는 자바스크립트 객체로서,
             자바스크립트 단에서 ajax 를 사용하여 폼 데이터를 다루는 객체라고 보면 된다. 
             FormData 객체가 필요하는 경우는 ajax로 파일을 업로드할 때 필요하다.
          */ 
  
          /*
            === FormData 의 사용방법 2가지 ===
	          <form id="myform">
	             <input type="text" id="title"   name="title" />
	             <input type="file" id="imgFile" name="imgFile" />
	          </form>
             
            첫번째 방법, 폼에 작성된 전체 데이터 보내기   
            var formData = new FormData($("form#myform").get(0));  // 폼에 작성된 모든것       
            또는
            var formData = new FormData($("form#myform")[0]);  // 폼에 작성된 모든것
            // jQuery선택자.get(0) 은 jQuery 선택자인 jQuery Object 를 DOM(Document Object Model) element 로 바꿔주는 것이다. 
	          // DOM element 로 바꿔주어야 순수한 javascript 문법과 명령어를 사용할 수 있게 된다. 
     
	          또는
            var formData = new FormData(document.getElementById('myform'));  // 폼에 작성된 모든것
      
            두번째 방법, 폼에 작성된 것 중 필요한 것만 선택하여 데이터 보내기 
            var formData = new FormData();
            // formData.append("key", value값);  // "key" 가 name 값이 되어진다.
            formData.append("title", $("input#title").val());
            formData.append("imgFile", $("input#imgFile")[0].files[0]);
          */  
      
          var formData = new FormData($("form[name='prodInputFrm']").get(0));  // $("form[name='prodInputFrm']").get(0) 폼 에 작성된 모든 데이터 보내기
          
      
              
             
              	
              
          }// end of if(file_arr.length > 0)----------
           // end of 추가이미지파일을 추가했을 경우 -------------
   // 글제목 유효성 검사
	  const clubName = $("input:text[name='clubName']").val().trim();
	  const cost = $("input:text[name='cost']").val().trim();
	  const headImg = $("input:file[name='headImg']").val().trim();
	  const sportType = $("select[name='sportType']").val();
	  const city = $("select[name='city']").val();
	  const local = $("select[name='local']").val();
	  const gym = $("select[name='gym']").val();
	  const time = $("select[name='time']").val();
	  const memberCnt = $("input:range[name='memberCnt']").val();
	  
	  if(clubName == "" || cost=="" ||
		 headImg == "" ){
		  
		  alert("필수사항을 입력하세요!!");
		  return; // 종료
	  }
	  if(sportType == "종목" || city == "시" || 
		 local == "구" || gym == "구장" || 
		 time=="주요 활동 시간대"){
		  
		  alert("필수사항을 선택하세요!!");
		  return; // 종료
	  }
	  if(memberCnt=="1"){
		  alert("동호회 정원은 1명 이상이어야 합니다.");
		  return;
	  }
	  
	  // 동호회명이 존재하는 경우 
	  
	  // 글내용 유효성 검사()
  
	     
      
        $.ajax({
        <%-- url : "<%= ctxPath%>/shop/admin/productRegister.up", --%>
             url : "<%= ctxPath%>/club/clubRegister.do",
             type : "post",
             data : formData,
             processData:false,  // 파일 전송시 설정 
             contentType:false,  // 파일 전송시 설정
             dataType:"json",
             success:function(json){
         	   	console.log("~~~ 확인용 : " + JSON.stringify(json));
                 // ~~~ 확인용 : {"result":1}
                 if(json.result == 1) {
         	       location.href="<%= ctxPath%>/club/viewclub.do"; 
                 }
                 
             },
             error: function(request, status, error){
			    
		     }
      	});

     
    });//end of  $("button#btnRegister").click(function(){---------------
      
  	  
      

		
	
});// end of $(document).ready(function(){})---------------------------


</script>


<form name="registerClubFrm" enctype="multipart/form-data">

	<div class="container" style="border:solid 0px black; margin-top: 12%;">
	
		<div class="row">
		  
		  <div class="col-8">
		    <div data-bs-spy="scroll" data-bs-target="#simple-list-example" data-bs-offset="0" data-bs-smooth-scroll="true" class="scrollspy-example" tabindex="0">
		      <h3 id="simple-list-item-1" style="font-weight: bolder;">기본정보</h3>
		      <hr>
		      
			  <div id="profile">
			  <%-- ==== 이미지파일 미리보여주기 ==== --%>
				<div id="previewImg">
					<div>사진</div> <!-- 밑에서 첨부파일 추가바면 자동으로 보이게끔 -->
				</div>
				
				<!-- 종목  -->
				<div id="infoo">
					<select name="sportType" style="width:80%;" class="form-select-lg mb-3" aria-label="Large select example">
						<option selected>종목</option>
						<option value="soccer">축구</option>
						<option value="baseball">야구</option>
						<option value="volleyball">배구</option>
						<option value="basketball">농구</option>
						<option value="tenis">테니스</option>
						<option value="bowling">볼링</option>
						<option value="jockgu">족구</option>
						<option value="badmiton">배드민턴</option>
					</select>
					
					<div style="font-size: 25px; font-weight: bold; ">이지윤</div> <!-- 자동 -->
					<div style="color: lightgray;">🕻 연락처</div><sapn>010-2222-3333</sapn> <!-- 자동 -->
					<div style="color: lightgray;">✉️ 이메일</div><sapn>cutyjh@naver.com</sapn> <!-- 자동 -->
				</div>
			  </div>
			  
		      <br><br><br><br>
		      
		      <!-- 동호회명 -->
				<h3 id="simple-list-item-2" style="font-weight: bolder;">동호회명<span style="color: red;">*</span></h3>
				<hr>
				<input name="clubName" id="form-control-lg" type="text" placeholder="동호회 이름을 입력하세요. " aria-label="">
			
				<br><br><br><br>
		
		      
		      <!-- 지역 -->
			<h3 id="simple-list-item-3" style="font-weight: bolder;">지역<span style="color: red;">*</span></h3>
			<hr>
			<span class="location" style="font-weight: bolder;">활동 지역</span>
			<select name="city" class="form-select form-select-lg mb-3" aria-label="Large select example">
			  <option selected>시</option>
			  <option value="1">One</option>
			  <option value="2">Two</option>
			  <option value="3">Three</option>
			</select>
			
			<select name="local" class="form-select form-select-lg mb-3" aria-label="Large select example">
			  <option selected>구</option>
			  <option value="1">One</option>
			  <option value="2">Two</option>
			  <option value="3">Three</option>
			</select>
			
			<span style="font-weight: bolder;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;활동 구장</span>
			<select name="gym" class="form-select form-select-lg mb-3" aria-label="Large select example">
			  <option selected>구장</option>
			  <option value="1">나래집</option>
			  <option value="2">준혁집마당</option>
			  <option value="3">한솔집안방 </option>
			  <option value="4">승진집다락방</option>
			</select>
			
			<br><br><br><br>
		
			<h3 id="simple-list-item-4" style="font-weight: bolder;">운영 시간<span style="color: red;">*</span></h3>
			<hr>
			<select name="time" style="width:30%;" class="form-select form-select-lg mb-3" aria-label="Large select example">
			  <option selected>주요 활동 시간대</option>
			  <option value="1">08:00~</option>
			  <option value="2">08:00~</option>
			  <option value="3">08:00~</option>
			</select>
			
			<br><br><br><br>
			
			<h3 id="simple-list-item-5" style="font-weight: bolder;">정원<span style="color: red;">*</span></h3>
			<hr>
			<label for="customRange3" class="form-label">최대 정원은 30명 까지입니다.</label>
			<br>
			    1
		        <input name="memberCnt" style="width:80%;" value="1" type="range" class="form-range slider" min="0" max="30" step="1" id="customRange3">
		        30
		        <span class="value" id="rangeValue"></span>
			
			<br><br><br><br>
			
			<h3 id="simple-list-item-6" style="font-weight: bolder;">회비<span style="color: red;">*</span></h3>
			<hr>
			<div style="display: flex;">
				<input name="cost" class="form-control form-control-lg" type="text" placeholder="" aria-label="" style="width: 30%;"><div style="font-weight: bold; padding-top: 20px; margin-left: 10px;">원</div>
			</div>
			
			<br><br><br><br>
			
			<h3 id="simple-list-item-7" style="font-weight: bolder;">동호회 대표 이미지<span style="color: red;">*</span></h3>
			<hr>
			<input class="img_file" name="headImg" type="file" name="attach" />
			
			<br><br><br><br>
		      
		      
		    </div>
		  </div>
		  
		  
		  <div class="col-4" >
		    <div id="simple-list-example" class="d-flex flex-column gap-2 simple-list-example-scrollspy">
		      <div>필수 입력사항</div>
		      <br>
		      <a class="p-1 rounded" href="#simple-list-item-1"><em>✔️</em>기본정보</a>
		      <a class="p-1 rounded" href="#simple-list-item-2"><em>✔️</em>동호회명</a>
		      <a class="p-1 rounded" href="#simple-list-item-3"><em>✔️</em>지역</a>
		      <a class="p-1 rounded" href="#simple-list-item-4"><em>✔️</em>운영시간</a>
		      <a class="p-1 rounded" href="#simple-list-item-5"><em>✔️</em>정원</a>
		      <a class="p-1 rounded" href="#simple-list-item-6"><em>✔️</em>회비</a>
		      <a class="p-1 rounded" href="#simple-list-item-7"><em>✔️</em>대표 이미지</a>
		    </div>
		  </div>
		  
		</div>
	
		<div style="margin: 20px;">
			<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnRegister">글쓰기</button>
	        <button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back()">취소</button>  
		</div>
	</div>
</form>