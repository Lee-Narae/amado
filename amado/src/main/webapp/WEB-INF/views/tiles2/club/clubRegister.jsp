<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
	
	
	 let b_requiredInfo = false;
		
		$(document).on("click", "button#btnRegister", function(e) {
			
		    const category = $("select#category").val();
		    const city = $("select#city").val();
		    
		    if (category === "종목") {
		        alert("종목을 선택해주세요!");
		        b_requiredInfo = true;
		    }
		   	if (city ==="선택해주세요") {
		        alert("지역을 선택해주세요!");
		        b_requiredInfo = true;
		        
		    }
		    const mcnt = $("input[name='membercount']").val();
		    if( Number(mcnt) < 1 || Number(mcnt) > 30 ){
		    	alert("정원은 최소 1 부터, 최대 30 까지입니다.");
		    	b_requiredInfo = true;
		    	
		    }
		    
		    if($("input.img_file").val() == ""){
		    	alert("사진을 추가해주세요");
		    	b_requiredInfo = true;
		    }
		    
		    
		    $("input").each(function() {
		    	if ($(this).val().trim() === "") {
		            alert("데이터를 입력해주세요!");
		            b_requiredInfo = true; // 값이 하나라도 비어 있으면 true로 변경
		            break; // 순회 중단
		        }
		    });
		    
		    if( b_requiredInfo ){
		    	return;
		    }
		    
		});
	 
	
	
	
	// ==>> 제품이미지 파일선택을 선택하면 화면에 이미지를 미리 보여주기 시작 <<== //
	 $(document).on("change", "input.img_file", function(e){
		
		 const scrollSpy = new bootstrap.ScrollSpy(document.body, {
			  target: '#navbar-example'
			})
		 
		 $("div#pview").hide();
		 
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
		  
		  ///////////////////////////////////////////////////
		  // 첨부한 파일의 총량을 누적하는 용도 
		  ///////////////////////////////////////////////////
	 });
	 // ==>> 제품이미지 파일선택을 선택하면 화면에 이미지를 미리 보여주기 끝 <<== //
	 
	 
	 
	
	$("select[name='city']").change(function(e){ // 도시 선택하면
	
		let cityname = $(e.target).val();
		
		// 세부 지역 불러오기
		$.ajax({
			url: "<%=ctxPath%>/club/getLocal.do",
			data: {"cityname": cityname},
			dataType: "json",
			success: function(json){
				// console.log(JSON.stringify(json));
				
				let v_html = `<option value='선택하세요'>선택하세요</option>`;
				
				$.each(json, function(index, item){
					v_html += `<option value='\${item.local}'>\${item.local}</option>`;
				});
				
				$("select[name='local']").html(v_html);
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		 });
	});
	
	
	// ---------------------------------------------- //

	 $("button#btnRegister").click(function(){
		 
		 
		
	 	 
		  //폼(form)을 전송(submit)
	 	  const frm = document.registerClubFrm;
	 	  frm.method = "post";
	 	  frm.action = "<%= ctxPath%>/club/clubRegisterEnd.do";
	 	  frm.submit();
	 	  
	 });
	
});// end of $(document).ready(function(){})---------------------------

function goTop() {
    $(window).scrollTop(0);
}

</script>


<form name="registerClubFrm" enctype="multipart/form-data">
	<div id="simple-list-item-0" class="container" style="border:solid 0px black; margin-top: 12%;">
	
		<div class="row">
		  
		  <div class="col-8">
		    <div data-bs-spy="scroll" data-bs-target="#simple-list-example" data-bs-offset="0" data-bs-smooth-scroll="true" class="scrollspy-example" tabindex="0">
		      <h3 id="simple-list-item-1" style="font-weight: bolder;">기본정보</h3>
		      <hr>
		      
			  <div id="profile">
			  <%-- ==== 이미지파일 미리보여주기 ==== --%>
				<div  id="pview" style="border:solid 1px gray; z-index:2; position: absolute; width: 30%; height: 180px;" >
					<div style="margin-top: 35%; margin-left: 31%; ">대표 이미지</div>
				</div>
				<div id="preview" style="border:solid 0px red; z-index: 1; position: relative;" >
					<img id="previewImg" width="300" /> <!-- 밑에서 첨부파일 추가바면 자동으로 보이게끔 -->
				</div>
					
					
				<!-- 종목  -->
				<div id="infoo">
					<select name="fk_sportseq" style="width:80%;" id="category" class="form-select-lg mb-3" aria-label="Large select example">
						<option value="종목">종목</option>
						<option value="1">축구</option>
						<option value="2">야구</option>
						<option value="3">배구</option>
						<option value="4">농구</option>
						<option value="5">테니스</option>
						<option value="6">볼링</option>
						<option value="7">족구</option>
						<option value="8">배드민턴</option>
					</select>
					
					<div id="name" style="font-size: 25px; font-weight: bold; ">${sessionScope.loginuser.name}</div> <!-- 자동 -->
					<div style="color: lightgray;">🕻 연락처</div><span>${sessionScope.loginuser.mobile}</span> <!-- 자동 -->
					<div style="color: lightgray;">✉️ 이메일</div><span>${sessionScope.loginuser.email}</span> <!-- 자동 -->
				</div>
			  </div>
			  
		      <br><br><br><br>
		      
		      <!-- 동호회명 -->
				<h3 id="simple-list-item-2" style="font-weight: bolder;">동호회명<span style="color: red;">*</span></h3>
				<hr>
				<input name="clubname" id="form-control-lg" type="text" placeholder="동호회 이름을 입력하세요. " aria-label="">
			
				<br><br><br><br>
		
		      
		      <!-- 지역 -->
			<h3 id="simple-list-item-3" style="font-weight: bolder;">지역<span style="color: red;">*</span></h3>
			<hr>
			
			<span class="location" style="font-weight: bolder;">활동 지역</span>
			<select name="city" id="city"  class="form-select form-select-lg mb-3" aria-label="Large select example">
			  <option value="0">선택하세요</option>
			  <c:forEach var="city" items="${requestScope.cityList}">
				  <option value="${city.cityname}">${city.cityname}</option>
			  </c:forEach>
			</select>
			
			<select name="local"  id="local" class="form-select form-select-lg mb-3" aria-label="Large select example"></select>
			
			<span style="font-weight: bolder;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;활동 구장</span>
			<input name="clubgym" id="form-control-lg" type="text" placeholder="oo체육관" aria-label="">
			
			
			<br><br><br><br>
		
			<h3 id="simple-list-item-4" style="font-weight: bolder;">운영 시간<span style="color: red;">*</span></h3>
			<hr>
			<span style="font-weight: bolder;">주요 활동 시간대</span>
			<input name="clubtime" id="form-control-lg" type="text" placeholder="00:00 ~ 00:00" aria-label="">
			
			<br><br><br><br>
			
			<h3 id="simple-list-item-5" style="font-weight: bolder;">정원<span style="color: red;">*</span></h3>
			<hr>
			
			<label for="customRange3" class="form-label">최대 정원은 30명 까지입니다.</label>
			<br>
			<div style="display: flex;">
				<input name="membercount" class="form-control form-control-lg" type="text" placeholder="" aria-label="" style="width: 20%;"><div style="font-weight: bold; padding-top: 20px; margin-left: 10px;">명</div>
			</div>
			<!--  
			    1
		        <input name="membercount" style="width:80%;" value="1" type="range" class="form-range slider" min="0" max="30" step="1" id="customRange3">
		        ${requestScope.membercnt}
		        <span class="value" id="rangeValue"></span>
			-->
			 
			<br><br><br><br>
			
			<h3 id="simple-list-item-6" style="font-weight: bolder;">회비<span style="color: red;">*</span></h3>
			<hr>
			<div style="display: flex;">
				<input name="clubpay" class="form-control form-control-lg" type="text" placeholder="" aria-label="" style="width: 30%;"><div style="font-weight: bold; padding-top: 20px; margin-left: 10px;">원</div>
			</div>
			
			<br><br><br><br>
			
			<h3 id="simple-list-item-7" style="font-weight: bolder;">동호회 대표 이미지<span style="color: red;">*</span></h3>
			<hr>
			<input class="img_file" id="clubimg" type="file" name="attach" />
			
			<br><br><br><br>
		      
		      
		    </div>
		  </div>
		  
		  
		  <div class="col-4">
		    <div id="simple-list-example" class="d-flex flex-column gap-2 simple-list-example-scrollspy">
		      <div style="margin-bottom: 1rem;">필수 입력사항</div>
		      <br>
		      <a class="p-1 rounded" href="#simple-list-item-0"><em>✔️</em>기본정보</a>
		      <a class="p-1 rounded" href="#simple-list-item-1"><em>✔️</em>동호회명</a>
		      <a class="p-1 rounded" href="#simple-list-item-2"><em>✔️</em>지역</a>
		      <a class="p-1 rounded" href="#simple-list-item-3"><em>✔️</em>운영시간</a>
		      <a class="p-1 rounded" href="#simple-list-item-4"><em>✔️</em>정원</a>
		      <a class="p-1 rounded" href="#simple-list-item-5"><em>✔️</em>회비</a>
		      <a class="p-1 rounded" href="#simple-list-item-6"><em>✔️</em>대표 이미지</a>
		    </div>
		  </div>   
		  
		</div>
	
		<input type="hidden" name="fk_userid" value="${sessionScope.loginuser.userid}" />
		<input type="hidden" name="clubtel" value="${sessionScope.loginuser.mobile}" />
	
		<div style="margin: 20px;">
			<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnRegister">등록하기</button>
	        <button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back()">취소</button>  
		</div>
	</div>

</form>