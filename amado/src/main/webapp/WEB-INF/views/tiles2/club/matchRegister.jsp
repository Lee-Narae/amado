<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>

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

</style>

<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/i18n/jquery-ui-i18n.min.js"></script>
<script type="text/javascript">
$(function(){
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
	
	let sportseq = $("select[name='sport']").val();
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
		data: {"sportseq": sportseq, "cityname": cityname, "localname": localname, "matchdate": matchdate},
		dataType: "json",
		success: function(json){
    		console.log(JSON.stringify(json));
    		
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
					   	 <td style="width: 30%;">\${item.clubname}</td>
					   	 <td style="width: 30%;">\${item.area}</td>
					   	 <td style="width: 10%;">\${item.membercount}</td>`;

					if(item.status == '0'){
						v_html += `<td style="width: 20%;"><button class='btn btn-primary'>매치 신청하기</button></td>`;
					}
					
					else {
						v_html += `<td style="width: 20%;"><button class='btn btn-secondary'>마감</button></td>`;
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

</script>

<div id="container" align="center">
	<div id="topImg" align="right">
		<img src="<%=ctxPath %>/resources/images/narae/main_visual_img_new01.png" style="width: 50%;"/>
	</div>
	<div style="font-size: 40pt; font-weight: bolder; position: relative; top: -400px; left: -320px;">매치 등록하기</div>
	<form name="matchFrm">
		<div id="matching" style="padding-left: 3%; padding-top: 1%;">
			<div id="sportdiv">
				<div align="left" style="margin: 10% 0 3% 15%; font-weight: bold;">종목</div>
				<div>
					<select name="sport" id="sport">
						<c:forEach var="sport" items="${requestScope.sportList}">
							<option value="${sport.sportseq}">${sport.sportname}</option>						
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
			<div><button type="button" class="btn btn-success btn-lg" style="margin-top: 25%;">등록하기</button></div>
		</div>
	</form>
	
	<div id="bottom" style="width: 80%; min-height: 700px; margin-top: -10%; margin-bottom: 5%;"></div>

</div>