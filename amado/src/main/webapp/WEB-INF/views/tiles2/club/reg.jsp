<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>

<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" /> 
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
<style type="text/css">
table#match {border-collapse: collapse; }
                    
table#match td {padding-left: 10px;
                 height: 50px; }
                       
.prodInputName {background-color: #ccf2ff;  
 				text-align: center;
                font-weight: bold;}                                                 

.error {color: red; font-weight: bold; font-size: 9pt;}

div.fileDrop{display: inline-block; 
             width: 100%; 
             height: 100px;
             overflow: auto;
             background-color: #fff;
             padding-left: 10px;}
              
div.fileDrop > div.fileList > span.delete{display:inline-block; width: 20px; border: solid 1px gray; text-align: center;} 
div.fileDrop > div.fileList > span.delete:hover{background-color: #000; color: #fff; cursor: pointer;}
div.fileDrop > div.fileList > span.fileName{padding-left: 10px;}
div.fileDrop > div.fileList > span.fileSize{padding-right: 20px; float:right;} 
span.clear{clear: both;} 
    


tr > td {
    border: solid 1px #cce6ff;
	background-color: white;
}

div#tableWrap {
  width: 50%;
  border: solid 1px #cce6ff;
  border-radius: 12px;
   overflow: hidden;
	  
}

table#match {
margin: 0%;
border-style: hidden;
}

.product{
height: 60px;
align-content: center;
}

#datepicker {
width: 30%;
height: 35px;
border-radius: 10px;
text-align: center;
padding: 3%;
border: solid 1px gray;
background-color: #f2f2f2;
cursor: pointer;
}

select {
width: 20%;
height: 35px;
border-radius: 10px;
text-align: center;
}

#area {
height: 35px;
border-radius: 10px;
border: solid 1px gray;
padding-left: 1%;
}
d

</style>

<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/i18n/jquery-ui-i18n.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	$("span.error").hide();
	
	$(".spinner_membercnt").spinner({
        spin: function(event, ui) {
           if(ui.value > 100) {
              $(this).spinner("value", 100);
              return false;
           }
           else if(ui.value < 0) {
              $(this).spinner("value", 0);
              return false;
           }
        }
    });
	
	$(".spinner_hour").spinner({
        spin: function(event, ui) {
           if(ui.value > 23) {
              $(this).spinner("value", 23);
              return false;
           }
           else if(ui.value < 0) {
              $(this).spinner("value", 0);
              return false;
           }
        }
    });
	
	$(".spinner_minute").spinner({
        spin: function(event, ui) {
           if(ui.value > 59) {
              $(this).spinner("value", 59);
              return false;
           }
           else if(ui.value < 0) {
              $(this).spinner("value", 0);
              return false;
           }
        }
     });
	
	$.datepicker.setDefaults($.datepicker.regional['ko']);
    $( "#datepicker" ).datepicker({dateFormat: 'yy-mm-dd', minDate: 0});
          
    $("select[name='city']").val('${requestScope.city}');
    $("select[name='local']").val('${requestScope.local}');
    
	// 세부 지역 불러오기
	$("select[name='city']").change(function(e){
		getLocal();
	});
    
	
	// 유효성 검사
	$("input:text[name='membercount']").blur(function(e){
		if($(e.target).val() == 0 || $(e.target).val() == ""){
			$("span.error1").show();
		}
		else if($(e.target).val() > 100){
			alert("인원은 최대 100명까지 입력 가능합니다.");
			$(e.target).val(0);
		}
		else {
			$("span.error1").hide();
		}
	});
	
	$("input:text[name='membercount']").blur(function(e){
		if($(e.target).val() == ''){
			$("span.error2").show();
		}
		else {
			$("span.error2").hide();
		}		
	});
	
	$("input:text[name='area']").blur(function(e){
		if($(e.target).val() == ''){
			$("span.error3").show();
		}
		else {
			$("span.error3").hide();
		}		
	});	
	
	$("input:text[name='hour']").blur(function(e){
		if($(e.target).val() == ''){
			$("span.error2").show();
		}
		else if($(e.target).val() > 23){
			alert("최대 23시까지 입력 가능합니다.");
			$(e.target).val(0);
		}
		else if($("input:text[name='minute']").val() != '' && $(e.target).val() != ''){
			$("span.error2").hide();
		}		
	});	
	
	$("input:text[name='minute']").blur(function(e){
		if($(e.target).val() == ''){
			$("span.error2").show();
		}
		else if($(e.target).val() > 59){
			alert("최대 59분까지 입력 가능합니다.");
			$(e.target).val(0);
		}
		else if($("input:text[name='hour']").val() != '' && $(e.target).val() != ''){
			$("span.error2").hide();
		}		
	});	
	
});

function getLocal(){
	
	let cityname = $("select[name='city']").val();
	
	// 세부 지역 불러오기
	$.ajax({
		url: "<%=ctxPath%>/club/getLocal.do",
		data: {"cityname": cityname},
		async: "false",
		dataType: "json",
		success: function(json){
			// console.log(JSON.stringify(json));
			
			let v_html = `<option value='0'>선택하세요</option>`;
			
			$.each(json, function(index, item){
				v_html += `<option value='\${item.local}'>\${item.local}</option>`;
			});
			
			$("select[name='local']").html(v_html);
			
		},
		error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}
	});
	
}


function goReg(){
	
	const clubname = $("td#clubname").text();
	const sportname = $("td#sportname").text();
	let membercount = $("input:text[name='membercount']").val();
	let matchdate = $("input:text[name='matchdate']").val();
	let city = $("select[name='city']").val();
	let local = $("select[name='local']").val();
	let area = $("input:text[name='area']").val();
	let hour = $("input:text[name='hour']").val();
	let minute = $("input:text[name='minute']").val();
	
	/* 확인 완료
		console.log("clubname: "+clubname);
		console.log("sportname: "+sportname);
		console.log("membercount: "+membercount);
		console.log("matchdate: "+matchdate);
		console.log("city: "+city);
		console.log("local: "+local);
		console.log("area: "+area);
	*/ 
	
	if(membercount == 0 || membercount == '' || matchdate == '' || city == 0 || local == 0 || area == '' || hour == '' || minute == ''){
		alert("필수 항목을 입력하세요.");
		return;
	}
	
	$.ajax({
		url: "<%=ctxPath%>/club/matchRegisterEnd.do",
		data: {"clubname": clubname, "sportname": sportname, "membercount": membercount,
			   "matchdate": matchdate, "city": city, "local": local, "area": area, "hour": hour, "minute": minute},
		dataType: "json",
		type: "post",
		success: function(json){
			if(json.n == 1){
				alert("등록 완료!");
			}
			else{
				alert("등록 실패");
			}
			
			location.href = "<%=ctxPath%>/club/matchRegister.do";
			
		},
		error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}
		
	});
	
}

</script>
    
<div id="container" align="center" style="margin-bottom: 20px; margin-top: 3%;">

   <div style="margin-top: 20px; padding-top: 10px; padding-bottom: 10px; font-size: 30pt; font-weight: bold;">매치 등록하기</div>
   <br>


   <form name="registerFrm"> 
      <div id="tableWrap">   
      <table id="match" style="background-color: #ccf2ff; width: 100%;">
      <tbody>
         <tr class="product">
            <td width="25%" class="prodInputName">동호회</td>
            <td width="75%" align="left" id="clubname">${requestScope.clubname}</td>
         </tr>
         <tr class="product">
            <td width="25%" class="prodInputName">종목</td>
            <td width="75%" align="left" id="sportname">${requestScope.sportname}</td>
         </tr>
         <tr class="product">
            <td width="25%" class="prodInputName">인원</td>
            <td width="75%" align="left">
               <input type="text" name="membercount" class="spinner spinner_membercnt" value="0" style="width: 50px;"/><span>&nbsp;명</span>
               <span class="error error1">필수입력</span>
            </td>
         </tr>
         <tr class="product">
            <td width="25%" class="prodInputName">시합일자</td>
            <td width="75%" align="left">
               <input type="text" name="matchdate" id="datepicker" placeholder="선택하세요" value="${requestScope.date}">
               &nbsp;&nbsp;
               <input type="text" name="hour" class="spinner spinner_hour" value="0" style="width: 20px;" />&nbsp;시&nbsp;&nbsp;
               <input type="text" name="minute" class="spinner spinner_minute" value="0" style="width: 20px;" />&nbsp;분
               &nbsp;&nbsp;
               <span class="error error2">필수입력</span>
            </td>
         </tr>
         <tr class="product">
            <td width="25%" class="prodInputName">지역</td>
            <td width="75%" align="left">
               <select name="city" id="city">
					<option value="0">선택하세요</option>
					<c:forEach var="city" items="${requestScope.cityList}">
						<option value="${city.cityname}">${city.cityname}</option>
					</c:forEach>
	      	   </select>&nbsp;&nbsp;
               <select name="local">
				  <option value="0">선택하세요</option>
					  <c:forEach var="local" items="${requestScope.localList}">
					  	  <option value="${local}">${local}</option>
					  </c:forEach>
			   </select>
            </td>
         </tr>
         <tr class="product">
			<td width="25%" class="prodInputName">장소</td>
			<td>
			    <input type="text" name="area" id="area" maxlength="30" placeholder="○○체육관 등"/>
			    <span class="error error3">필수입력</span>
			</td>
         </tr>
      </tbody>
      </table>
      </div>
   </form>
   
   <div class="mt-5">
	   <button type="button" class="btn btn-primary" onclick="goReg()">등록하기</button>&nbsp;&nbsp;
	   <button type="button" class="btn btn-light" onclick="location.href='<%=ctxPath%>/club/matchRegister.do'">취소</button>
   </div>
</div>