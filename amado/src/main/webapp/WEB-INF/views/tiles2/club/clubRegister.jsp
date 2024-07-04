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
	
	searchMatch();
	
	// ---------------------------------------------- //
	
	// 로컬 태그가 바뀌면
	$("select[name='local']").change(function(e){
		$("input:text[name='date']").val("");
		searchMatch();
	});
	
	
	 $("button#btnRegister").click(function(){
	 	 
		  // 폼(form)을 전송(submit)
	 	  const frm = document.registerClubFrm;
	 	  frm.method = "post";
	 	  frm.action = "<%= ctxPath%>/club/clubRegisterEnd.do";
	 	  frm.submit();
	 });
	
});// end of $(document).ready(function(){})---------------------------


function searchMatch(){
	
	let cityname = "";
	let localname = "";
	
	if($("select[name='city']").val() != '0'){
		cityname = $("select[name='city']").val();
	}
	
	if($("select[name='local']") != '선택하세요'){
		localname = $("select[name='local']").val();	
	}

	
	$.ajax({
		url: "<%=ctxPath%>/club/getLocation.do",
		data: {"cityname": cityname, "localname": localname},
		dataType: "json",
		success: function(json){
    		// console.log(JSON.stringify(json));
    		
    		if(json.length > 0){
    			
   				$.each(json, function(index, item){
    			
   		    		let v_html = ``;
   		    		
   					v_html += `<tr>
					   	 <td style="width: 30%; height: 30px;"><div style="font-size: 10pt;">\${item.city} > \${item.local}</div>\${item.area}</td>
					v_html += </tr>`;
					
					$("span#location").html(v_html);
    			});
    			
    		}
    	},
        error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}
	});
	
}


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
					<select name="sportseq" style="width:80%;" class="form-select-lg mb-3" aria-label="Large select example">
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
			<input name="gym" id="form-control-lg" type="text" placeholder="oo체육관" aria-label="">
			
			
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
			<!-- 
			<label for="customRange3" class="form-label">최대 정원은 30명 까지입니다.</label>
			<br>
			    1
		        <input name="memberCnt" style="width:80%;" value="1" type="range" class="form-range slider" min="0" max="30" step="1" id="customRange3">
		        30
		        <span class="value" id="rangeValue"></span>
			 -->
			 
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
			<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnRegister">등록하기</button>
	        <button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back()">취소</button>  
		</div>
	</div>

</form>