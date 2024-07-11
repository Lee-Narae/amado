<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>
<% Object member = session.getAttribute("loginuser"); %>

<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" /> 
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
<style type="text/css">

#topImg {
background-color: #f9f7f1;
width: 80%;
height: 550px;
}

#matching > div {
width: 20%;
margin-right: 2%;
}

#sport {
width: 80%;
height: 50px;
border-radius: 10px;
text-align: center;
padding: 3%;
}

#city, #local {
width: 80%;
height: 50px;
border-radius: 10px;
text-align: center;
padding: 3%;
}

#local {
margin-top: 28.5%;
}

#datepicker {
width: 100%;
height: 50px;
border-radius: 10px;
text-align: center;
padding: 3%;
border: solid 1px gray;
}

#matching {
width: 60%;
display: flex;
height: 150px;
background-color: white;
position: relative;
top: -350px;
border-radius: 30px;
box-shadow: 0px 0px 10px #dedede;
}

.tbl-content{
  background-color: white;
  overflow-x:auto;
  margin-top: 0px;
  border: 1px solid rgba(255,255,255,0.3);
}

.matchingTable th{
  padding: 20px 15px !important;
  text-align: center;
  font-weight: bold;
  font-size: 18px;
  color: white;
  text-transform: uppercase;
  background-color: #004d99;
  opacity: 0.4;
}

.matchingTable th:nth-child(1){
  border-top-left-radius: 10px;
}

.matchingTable th:last-child{
border-top-right-radius: 10px;
}

.matchingTable td{
  padding: 15px;
  text-align: center;
  vertical-align:middle;
  font-size: 18px;
  border-top: solid 1px gray;
  border-bottom: solid 1px gray;
  height: 80px;
  
}

.bottom_detail{
margin-bottom: 5%;
}

.sweet-alert h2{
font-size: 15pt;
}

/* table#modalTable * {
 border: solid 1px gray;
} */

table#modalTable td {
height: 45px;
align-content: center;
}

table#modalTable > tr {
margin-bottom: 3%;
}

#modalTable > tbody > tr:nth-child(1) > td:nth-child(1),
#modalTable > tbody > tr:nth-child(2) > td:nth-child(1) {
background-color: #80bfff;
color: white;
font-weight: bold;
}

#modalTable > tbody > tr:nth-child(1) > td:nth-child(2),
#modalTable > tbody > tr:nth-child(2) > td:nth-child(2) {
padding: 2% 0;
padding-left: 5%;
background-color: #e6f2ff;
}


</style>

<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/i18n/jquery-ui-i18n.min.js"></script>
<script type="text/javascript">
$(function(){
	
	$(".app_memberCount").spinner({
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
	
	$.datepicker.setDefaults($.datepicker.regional['ko']);
    $( "#datepicker" ).datepicker({dateFormat: 'yy-mm-dd', minDate: 0});
    
    $("select[name='local']").html("<option>선택하세요</option>");
    
	$("select[name='city']").change(function(e){
		
		$("input:text[name='date']").val("");
		searchMatch();
		
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
	

	// 1. 종목 태그가 바뀌면
	$("select[name='sport']").change(function(e){
		
		$("select[name='city']").val("0");
		$("select[name='local']").val("선택하세요");
		$("input:text[name='date']").val("");
		searchMatch();
	});


	// 3. 로컬 태그가 바뀌면
	$("select[name='local']").change(function(e){
		$("input:text[name='date']").val("");
		searchMatch();
	});
	
	// 4. 날짜 태그가 바뀌면
	$("input:text[name='date']").change(function(){
		searchMatch();	
	});

});
  

function searchMatch(){
	
	let sportname = $("select[name='sport']").val();
	let cityname = "";
	let localname = "";
	let matchdate = $("input:text[name='date']").val();
	
	if($("select[name='city']").val() != '0'){
		cityname = $("select[name='city']").val();
	}
	
	if($("select[name='local']") != '선택하세요'){
		localname = $("select[name='local']").val();	
	}

	
	$.ajax({
		url: "<%=ctxPath%>/searchMatch.do",
		data: {"sportname": sportname, "cityname": cityname, "localname": localname, "matchdate": matchdate},
		dataType: "json",
		success: function(json){
    		// console.log(JSON.stringify(json));
    		
    		if(json.length > 0){
    			
    			// 날짜별 그룹짓기
    			
				let date_arr = [];
    			let v_html2 = ``;
    			
    			$.each(json, function(index, item){
    				
    				date_arr.push(item.matchdate);
    				
    			});
    			
    			// console.log(date_arr);
    			const set = new Set(date_arr);
    			
    			const distinct_date_arr = [...set].sort();
    			
    			// console.log(distinct_date_arr);
    			
    			$.each(distinct_date_arr, function(index, item){
    				
    				v_html2 += `<div class='bottom_detail'>
    								<div style="text-align: left; font-weight: bold; font-size: 20pt; margin: 0 0 1% 12%;">\${item}</div>
    								<div class="tbl-header">
    								  <table class="matchingTable" cellpadding="0" cellspacing="0" border="0" style="width: 80%;">
    								    <thead>
    								      <tr>
    								        <th style="width: 10%;">매치 시간</th>
    										<th style="width: 30%;">상대팀</th>
    										<th style="width: 30%;">장소</th>
    										<th style="width: 10%;">인원</th>
    										<th style="width: 20%;">매칭 여부</th>
    								      </tr>
    								    </thead>
    								  </table>
    								</div>
    								<div class="tbl-content">
    								<table class="matchingTable" cellpadding="0" cellspacing="0" border="0" style="width: 80%;">
    								    <tbody id="\${item}">
    								    </tbody>
    								</table>
    								</div>`;
    				v_html2 += `</div>`;
    			});

    			$("div#bottom").html(v_html2);
    			
    			
    			
    			
   				$.each(json, function(index, item){
    			
   		    		let v_html = ``;
   		    		
   					v_html += `<tr>
					   	 <td style="width: 10%;">\${item.matchtime}</td>
					   	 <td style="width: 30%;" id="td_clubname">\${item.clubname}</td>
					   	 <td style="width: 30%; height: 30px;"><div style="font-size: 10pt;">\${item.city} > \${item.local}</div>\${item.area}</td>
					   	 <td style="width: 10%;">\${item.membercount}</td>`;

					if(item.status == '0' && item.applystatus != "1"){
						v_html += `<td style="width: 20%;"><button class='btn btn-primary' data-toggle="modal" data-target="#matchApplyModal" onclick="modalInfo(\${item.matchingregseq}, '\${item.clubname}')"${sessionScope.loginuser == null?'disabled':''}>${sessionScope.loginuser == null?'로그인하세요':'매치 신청하기'}</button></td>`;
					}
					
					else if(item.status == "0" && item.applystatus == "1"){
						v_html += `<td style="width: 20%;"><button class='btn btn-light' disabled>수락 대기 중</button></td>`;
					}
					
					else {
						v_html += `<td style="width: 20%;"><button class='btn btn-secondary' disabled>마감</button></td>`;
					}
					
					v_html += `</tr>`;
					
					$(`tbody#\${item.matchdate}`).append(v_html);
    			});
    			
    		}
    		
    		else{
    			
    			$("div#bottom_detail").html("");
    			
    			let v_html = `<div class='bottom_detail'>
			    				<div class="tbl-header">
			    				  <table class="matchingTable" cellpadding="0" cellspacing="0" border="0" style="width: 80%;">
			    				    <thead>
			    				      <tr>
			    				        <th style="width: 10%;">매치 시간</th>
			    						<th style="width: 30%;">상대팀</th>
			    						<th style="width: 30%;">장소</th>
			    						<th style="width: 10%;">인원</th>
			    						<th style="width: 20%;">매칭 여부</th>
			    				      </tr>
			    				    </thead>
			    				  </table>
			    				</div>
			    				<div class="tbl-content">
			    				<table class="matchingTable" cellpadding="0" cellspacing="0" border="0" style="width: 80%;">
			    				    <tbody>
			    				    <tr><td colspan='5'>해당 조건에 만족하는 매치가 없습니다.</td></tr>
			    				    </tbody>
			    				</table>
			    			  </div>`;
    				
    			$("div#bottom").html(v_html);
    			
    		}
    		
    		
    			
    	},
        error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}
	});
	
}

// 모달에 값 넣어주는 용도
function modalInfo(matchingregseq, clubname){
	// console.log(matchingregseq);
	// console.log(clubname);

	$("span#teamA").text(clubname);
	
	// 시합등록번호로 종목 알아오기
	$.ajax({
		url: "<%=ctxPath%>/club/getSportseq.do",
		data: {"matchingregseq": matchingregseq},
		dataType: "json",
		success: function(json){
			
			console.log(JSON.stringify(json));
			
			if(json.clubname == clubname){
				swal("본인이 속한 동호회의 매치는 신청할 수 없습니다.");
				$("#matchApplyModal").modal("hide");
				return;
			}
			
			if(json.clubname == null){
				swal("해당 종목은 동호회에 가입하지 않았으므로 매치 신청이 불가합니다.");
				$("#matchApplyModal").modal("hide");
				return;
			}
			
			$("input#appclubseq").val(json.clubseq);
			$("input#matchingregseq").val(matchingregseq);
			$("span#teamB").text(json.clubname);
			
		},
		error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}
	});

}


function goMatchApply(){
	
	if($("input[name='membercount']").val() > 0){
		const f = document.applyFrm;
		f.action = "<%=ctxPath%>/club/goApply.do",
		f.method = "post";
		f.submit();
	}
	
	else {
		alert('인원이 올바르지 않습니다.');
		return;
	}
}


function goRegister(){
	
	if('<%=member%>' == 'null'){
		swal('로그인이 필요합니다.');
		return;
	}
	
	let sportname = $("select[name='sport']").val();
	let cityname = $("select[name='city']").val();
	let localname = $("select[name='local']").val();
	let matchdate = $("input:text[name='date']").val();
	
	if(cityname == "0"){
		swal('지역을 선택하세요.');
		return;
	}
	
	if(localname == '선택하세요'){
		swal('지역을 선택하세요.');
		return;
	}
	
	if(matchdate == ''){
		swal('날짜를 선택하세요.');
		return;
	}
	
	var mdate = new Date(matchdate);

	var mdateYear = mdate.getFullYear();
	var mdateMonth = mdate.getMonth();
	var mdateDate = mdate.getDate();
	
	var today = new Date();

	var todayYear = today.getFullYear();
	var todayMonth = today.getMonth();
	var todayDate = today.getDate();	
	
	
	if(Number(mdateYear) < Number(todayYear)){
		swal('현재보다 이전의 날짜는 선택할 수 없습니다.');
		return;
	}
	if(Number(mdateYear) == Number(todayYear) && Number(mdateMonth) < Number(todayMonth)){
		swal('현재보다 이전의 날짜는 선택할 수 없습니다.');
		return;
	}
	if(Number(mdateYear) == Number(todayYear) && Number(mdateMonth) == Number(todayMonth) && Number(mdateDate) < Number(todayDate)){
		swal('현재보다 이전의 날짜는 선택할 수 없습니다.');
		return;
	}
	
	let clubseq = "";
	let clubname = "";

	// 로그인 유저의 가입 동호회 번호 알아오기
	$.ajax({
		url: "<%=ctxPath%>/getClubseq.do",
		data: {"sportname": sportname},
		type: "post",
		async: "false",
		dataType: "json",
		success: function(json){
			
			console.log(json);
			if(json.clubseq != null){
				clubseq = json.clubseq;
				clubname = json.clubname;
				$("input:hidden[name='clubseq']").val(clubseq);
				$("input:hidden[name='clubname']").val(clubname);
				
				
				// 정상 처리되었다면
				const frm = document.matchFrm;
				frm.action = "<%=ctxPath%>/club/matchRegister/reg.do";
				frm.method = "post";
				frm.submit();
				
			}
			
			else {
				swal(`현재 가입하신 \${sportname} 동호회가 없어 
				매치 등록을 할 수 없습니다.`);
			}
			
			
		},
		error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}
	});
	

}

</script>

<div id="container" align="center">
	<div id="topImg" align="right">
		<img src="<%=ctxPath %>/resources/images/narae/main_visual_img_new01.png" style="width: 50%;"/>
	</div>
	<div style="font-size: 40pt; font-weight: bolder; position: relative; top: -400px; left: -320px;">매치 등록하기</div>
	<form name="matchFrm">
		<input type="hidden" name="clubseq" />
		<input type="hidden" name="clubname" />
		<div id="matching" style="padding-left: 3%; padding-top: 1%;">
			<div id="sportdiv">
				<div align="left" style="margin: 10% 0 3% 15%; font-weight: bold;">종목</div>
				<div>
					<select name="sport" id="sport">
						<c:forEach var="sport" items="${requestScope.sportList}">
							<option value="${sport.sportname}">${sport.sportname}</option>						
						</c:forEach>
			      	</select>
				</div>
			</div>
			<div id="areadiv" style="width: 35%; display: flex;">
				<div style="width: 50%;">
					<div align="left" style="margin: 11% 0 4% 15%; font-weight: bold;">지역</div>
					<div>
						<select name="city" id="city">
							<option value="0">선택하세요</option>
							<c:forEach var="city" items="${requestScope.cityList}">
								<option value="${city.cityname}">${city.cityname}</option>
							</c:forEach>
				      	</select>
					</div>
				</div>
				<div style="width: 50%;">
					<div>
						<select name="local" id="local"></select>
					</div>
				</div>
			</div>
			<div id="timediv">
				<div align="left" style="margin: 10% 0 3% 7%; font-weight: bold;">날짜</div>
				<input type="text" name="date" id="datepicker" placeholder="선택하세요">
			</div>
			<div><button type="button" class="btn btn-success btn-lg" style="margin-top: 25%;" onclick="goRegister()">등록하기</button></div>
		</div>
	</form>
	
	<div id="bottom" style="width: 80%; min-height: 700px; margin-top: -10%; margin-bottom: 5%;"></div>


<!-- Modal -->
<!-- Modal 구성 요소는 현재 페이지 상단에 표시되는 대화 상자/팝업 창입니다. -->
<div class="modal modalclass" id="matchApplyModal" style="margin-top: 5%;">
  <div class="modal-dialog">
    <div class="modal-content">
      
      <!-- Modal header -->
      <div class="modal-header">
        <h5 class="modal-title" style="font-weight: bold;">매치 신청하기</h5>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      
      <!-- Modal body -->
      <div class="modal-body" style="height: 250px;">
        
        <div style="font-size: 20pt; font-weight: bold; margin-top: 5%;">
        	<span style="color: blue;" id="teamA">팀 A</span> vs <span style="color: red;" id="teamB">팀 B</span>
        </div>
        <form name="applyFrm" >
	        <table id="modalTable" style="width: 95%; margin-top: 5%;">
	        	<tr>
	        		<td align="center">인원</td>
	        		<td><input type="text" name="membercount" class="spinner app_memberCount" value="0" style="height: 30px; width: 40px;"/></td>
	        	</tr>
	        	<tr>
	        		<td align="center">요청 메세지</td>
	        		<td><input type="text" id="message" name="message" maxlength="50" style="width: 90%; height: 50px; border-radius: 15px; border: solid 1px gray;" /></td>
	        	</tr>
	        </table>
        	<input type="hidden" id="appclubseq" name="appclubseq" />
        	<input type="hidden" id="matchingregseq" name="matchingregseq" />
        </form>
      </div>
      
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary" onclick="goMatchApply()">신청하기</button>
      </div>
    </div>
  </div>
</div>


</div>