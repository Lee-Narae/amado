<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<% String ctxPath = request.getContextPath(); %> 

<style type="text/css">
.mbtn {
	font-weight: bold;
	height: 100px;
	margin-inline-end: .25rem;
	background-color: white;
	border: none;
	color: gray;
	width: 40%;
	cursor: pointer;
	transition: box-shadow 0.3s ease; /* 호버 시 부드러운 전환 효과 */
}

.mbtn:hover {
	color: #05203c;
}

.hr1 {
	border-style: none;
	height: 2px;
	background-color: lightgray;
}

.item1 {
	border-left: solid 3px #05203c;
}

#hr2-container {
	position: relative;
	height: 40px;
	background-color: #98b6d5;
	display: flex;
	justify-content: center;
	align-items: center;
}

#hrbtns {
	border: solid 0px red;
	margin-right: 1.5%;
	display: flex;
	gap: 70px; /* Adjust the gap between buttons */
	position: absolute;
	z-index: 1;
}

.btn2 {
	font-size: 14px;
	cursor: pointer;
	border: none;
	background-color: inherit;
}

.hover {
	color: #05203c;
	font-weight: bold;
}

.title {
	width: 15%;
	background-color: #4db8ff;
	color: white;
	font-weight: bold;
	align-content: center;
	text-align: center;
	height: 40px;
	border-radius: 15px;
	margin-right: 3%;
}

.tr {
	align-content: center;
	margin-bottom: 1%;
}

.select {
	width: 20%;
}

select {
	width: 30%;
	height: 40px;
	text-align: center;
	border-radius: 10px;
}

.btnInfoChange {
	font-size: 8pt;
	margin-left: 3%;
}

.input {
	width: 70%;
}

#memberInfo input {
	height: 30px;
	border-radius: 10px;
	align-content: center;
	padding-left: 1%;
	border: solid 1px gray;
}

.sportCard {
	width: 100%;
	height: 350px;
	border-radius: 20px;
	box-shadow: 0 1px 3px rgba(0, 0, 0, 0.12), 0 1px 2px rgba(0, 0, 0, 0.24);
	transition: all 0.3s cubic-bezier(.25, .8, .25, 1);
	position: relative;
	z-index: 1;
}

.sportCard:hover {
	box-shadow: 0 14px 28px rgba(0, 0, 0, 0.25), 0 10px 10px
		rgba(0, 0, 0, 0.22);
}

#top, #bottom {
	width: 80%;
	justify-content: space-between;
}

.card {
	width: 23%;
	height: 350px;
	cursor: pointer;
	border: none;
}

.back {
	border-radius: 20px;
	background-color: #fefeec;
	text-align: center;
	width: 100%;
	height: 350px;
	position: absolute;
	z-index: 0;
	top: 0px;
	align-content: center;
}

.shadow {
	box-shadow: 0 14px 28px rgba(0, 0, 0, 0.25), 0 10px 10px
		rgba(0, 0, 0, 0.22);
}

.sportname {
	font-size: 20pt;
	font-weight: bold;
}

.back div {
	margin-bottom: 1%;
}

.clubimg {
	width: 55%;
	border: solid thin #6699ff;
	border-radius: 100%;
	height: 200px;
	overflow: hidden;
	text-align: center;
}

#profile>div>div {
	margin-bottom: 2%;
}

#prev, #next {
	cursor: pointer;
}

#swal2-title {
	font-size: 15pt;
}

.spTitle {
	background-color: #6699ff;
	display: inline-block;
	height: 30px;
	width: 25%;
	align-content: center;
	border-radius: 15px;
	color: white;
	text-align: center;
	font-weight: bold;
	margin-left: 10%;
	margin-right: 5%;
}

#tableDiv>div {
	margin-bottom: 2.5%;
}

.clubMemberTbl td {
	height: 50px;
	border-bottom: solid 1px #c9c9c9;
}

.clubMemberTbl thead, .clubMemberTbl tfoot {
	background-color: #99ccff;
	color: white;
}

.clubMemberTbl tfoot td {
	height: 30px;
}

.clubMemberTbl tfoot td:nth-child(1) {
	border-bottom-left-radius: 10px;
}

.clubMemberTbl tfoot td:last-child {
	border-bottom-right-radius: 10px;
	border-bottom: none;
}

.clubMemberTbl thead>tr>td:nth-child(1) {
	border-top-left-radius: 10px;
}

.clubMemberTbl thead>tr>td:last-child {
	border-top-right-radius: 10px;
}
</style>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script type="text/javascript">

let cancelHTML = '';

$(document).ready(function(){
	
	// 첫화면 기본세팅
	$("button#myclub").addClass('hover');
	$("#clubShow").css({"font-weight": "bold"});
	$("#content2").hide();
	
	// 가입 동호회 조회
	$("#clubShow").click(function(){
		
		$("#clubManage").css({"font-weight": ""});
		$("#clubShow").css({"font-weight": "bold"});
		$("#content1").show();
		$("#content2").hide();
		
	});
	
	
	
	// 내 동호회 조회
	$("#clubManage").click(function(){
		
		$("#clubShow").css({"font-weight": ""});
		$("#clubManage").css({"font-weight": "bold"});
		$("#content2").show();
		$("#content1").hide();
		
	});
	
	
	
	// 클릭이벤트
	$(".sportCard").click(function(e){
		$(e.target).fadeOut();
	});
	
	$(".back").click(function(e){
		$(e.target).prev().fadeIn();
		$(e.target).prev().children().fadeIn();
	});
	
	$(".sportCard > img").click(function(e){
		$(e.target).parent().fadeOut();
	});
	
	$(".sportname").click(function(e){
		$(e.target).parent().fadeOut();
	});
	
	$(".back > div").click(function(e){
		$(e.target).parent().prev().fadeIn();
		$(e.target).parent().prev().children().fadeIn();
	});	
	
	$(".back > div > img").click(function(e){
		$(e.target).parent().parent().prev().fadeIn();
		$(e.target).parent().parent().prev().children().fadeIn();
	});	
	
	
	let current_index = 0;      // 현재 인덱스 번호
    let positionValue = 0;      // div#images 위치값
    const image_width = 450;
    
	if(current_index == 0) {  // 첫 이미지인 경우
        $("#prev").css({"opacity": "0.4", "cursor": "context-menu"});
    }
	
    // 이전버튼 클릭
    $("div#prev").click(function(){
    	$("#next").css({"opacity": "", "cursor": "pointer"});
		
    	if(current_index > 0){  // 첫 이미지가 아닌 경우
            positionValue += image_width;
            // $("div#profile").style.transform = `translateX(\${positionValue}px)`;
            $("div#profile").css({"transform": `translateX(\${positionValue}px)`});
            current_index--;
        }

        else if(current_index == 0) {  // 첫 이미지인 경우
            $("#prev").css({"opacity": "0.4", "cursor": "context-menu"});
        }
    });
    
 // 다음버튼 클릭
    $("div#next").click(function(){
        $("#prev").css({"opacity": "", "cursor": "pointer"});
        
    	if(current_index < ${requestScope.clubList.size()-1}){  // 첫 이미지가 아닌 경우
            positionValue -= image_width;
            $("div#profile").css({"transform": `translateX(\${positionValue}px)`});
            current_index++;
        }

    	else if(current_index == ${requestScope.clubList.size()-1}){
    		$("#next").css({"opacity": "0.4", "cursor": "context-menu"});
    	}
    });
    
    
});


function quitClub(clubseq, userid){

	$.ajax({
		
		url: "<%=ctxPath%>/member/checkClubMaster.do",
		data: {"clubseq": clubseq, "userid": userid},
		type: "post",
		dataType: "json",
		success: function(json){
			
			if(json.result == 1){
				Swal.fire(`동호회장이므로 탈퇴가 불가합니다.
					  [내 동호회 관리]에서 동호회를 삭제하세요.`);
				return;
			}
			
			else {
				
				Swal.fire({
					  title: "정말 탈퇴하시겠습니까?",
					  icon: "warning",
					  showCancelButton: true,
					  confirmButtonColor: "#3085d6",
					  cancelButtonColor: "#d33",
					  confirmButtonText: "네, 탈퇴합니다.",
					  cancelButtonText: "취소"		  
					}).then((result) => {
					  if (result.isConfirmed) {
						  
						  $.ajax({
							  url: "<%=ctxPath%>/member/quitClub.do",
							  data: {"clubseq": clubseq, "userid": userid},
							  type: "post",
							  dataType: "json",
							  success: function(json2){
								  
								  if(json2.n == 1){
									  Swal.fire({
									      title: "탈퇴 완료!",
									      icon: "success"
									    }).then(okay => {
											  if (okay) {
												  location.reload(true);
												  }
										  });
								  }
								  
							  },
							  error: function(request, status, error){
									alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
							  }
						  });
					  
					  }
					  
					});
				
			}
			
		},
		error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}
		
	});
	
}


function editClub(clubseq){

	let num = $("button.editBtn").index(event.target);
	
	cancelHTML = $(event.target).parent().parent().parent().find("#tableDiv").html();
	
	if($(event.target).html() == '수정'){ // 수정
		$(event.target).html('완료');
		$(event.target).parent().append('<button type="button" class="btn btn-light cancel" onclick="editCancel()">취소</button>');
		
		const cityLocal = $(event.target).parent().parent().parent().find(".area").html();
		const orgCity = cityLocal.substring(0, cityLocal.indexOf('&nbsp;'));
		const orgLocal = cityLocal.substring(cityLocal.indexOf('&nbsp;')+6, cityLocal.length);

		const orgClubgym = $(event.target).parent().parent().parent().find(".clubgym").text();
		const orgClubtel = $(event.target).parent().parent().parent().find(".clubtel").text();
		
		const clubpaycomma = $(event.target).parent().parent().parent().find(".clubpay").text().substring(0, $(event.target).parent().parent().parent().find(".clubpay").text().length-1);
		const commaIdx = clubpaycomma.indexOf(',');

		const orgClubpay = clubpaycomma.substring(0, commaIdx)+clubpaycomma.substring(commaIdx+1, clubpaycomma.length);
		
		const orgMbcnt = $(event.target).parent().parent().parent().find(".mbcnt").text().substring(0, $(event.target).parent().parent().parent().find(".mbcnt").text().length-1);
		
		$(event.target).parent().parent().parent().find(".area").html(`<input type="text" name="city" value="\${orgCity}" style="width: 25%;"/>&nbsp;<input type="text" name="local" value="\${orgLocal}" style="width: 25%;"/>`);
		$(event.target).parent().parent().parent().find(".clubgym").html(`<input type="text" name="clubgym" value="\${orgClubgym}" style="width: 50%;"/>`);
		$(event.target).parent().parent().parent().find(".clubtel").html(`<input type="text" name="clubtel" value="\${orgClubtel}" style="width: 50%;"/>`);
		$(event.target).parent().parent().parent().find(".clubpay").html(`<input type="text" name="clubpay" value="\${orgClubpay}" style="width: 20%;"/>원`);
		$(event.target).parent().parent().parent().find(".mbcnt").html(`<input type="text" name="membercount" value="\${orgMbcnt}" style="width: 10%;"/>명`);
	}
	
	else { // 수정완료
		
		const newcity = $("input[name='city']").val().trim();
		const newlocal = $("input[name='local']").val().trim();
		const newclubgym = $("input[name='clubgym']").val().trim();
		const newclubtel = $("input[name='clubtel']").val().trim();
		const newclubpay = $("input[name='clubpay']").val().trim();
		const newmembercount = $("input[name='membercount']").val().trim();
		
		if(newcity == "" || newlocal == "" || newclubgym == "" || newclubtel == "" || newclubpay == "" || newmembercount == ""){
			alert('값을 입력하세요.');
			return;
		}
		
		if(isNaN(newclubpay) || isNaN(newmembercount)){
			alert('잘못된 값입니다.');
			return;
		}
		
		else {
			
			$.ajax({
				url: "<%=ctxPath%>/member/clubEdit.do",
				data: {"clubseq": clubseq, "city": newcity, "local": newlocal, "clubgym": newclubgym, "clubtel": newclubtel, "clubpay": newclubpay, "membercount": newmembercount},
				type: "post",
				dataType: "json",
				success: function(json){
					if(json.n == 1){
						
						$(".area").eq(num).html(`\${newcity}&nbsp;\${newlocal}`);
						$(".clubgym").eq(num).html(newclubgym);
						$(".clubtel").eq(num).html(newclubtel);
						$(".clubpay").eq(num).html(Number(newclubpay).toLocaleString('en')+'원');
						$(".mbcnt").eq(num).html(newmembercount+'명');

						$(".ifEdit").eq(num).html(`<button type="button" class="btn btn-warning editBtn" onclick="editClub('\${clubseq}')">수정</button>&nbsp;&nbsp;`);
						
					}
					
					else {
						alert('내부 오류로 인해 수정이 실패하였습니다. 다시 시도해주세요.');
						location.reload(true);
					}
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});
			
		}
	}
	
	
}

function editCancel(){
	$(event.target).parent().parent().parent().find("#tableDiv").html(cancelHTML);
	$("div.ifEdit").html(`<button type="button" class="btn btn-warning editBtn" onclick="editClub('\${club.clubseq}')">수정</button>&nbsp;&nbsp;`);
}


function deleteClub(clubseq){
	Swal.fire({
		  title: "정말 삭제하시겠습니까?",
		  html: "삭제 후 복구할 수 없습니다.<br>가입된 회원은 모두 <span style='color: red; font-weight: bold;'>탈퇴 처리</span>됩니다.",
		  icon: "warning",
		  showCancelButton: true,
		  confirmButtonColor: "#3085d6",
		  cancelButtonColor: "#d33",
		  confirmButtonText: "삭제하기",
		  cancelButtonText: "취소"
		}).then((result) => {
		  if (result.isConfirmed) {

			  $.ajax({
				  url: "<%=ctxPath%>/member/deleteClub.do",
				  data: {"clubseq": clubseq},
				  dataType: "json",
				  type: "post",
				  success: function(json){
					  console.log(JSON.stringify(json));
					  if(json.n == 1){
						  Swal.fire({
						      title: "삭제 완료!",
						      text: "동호회가 삭제되었습니다.",
						      icon: "success"
						    }).then(okay => {
								  if (okay) {
									  location.reload(true);
									  }
							  });
					  }
					  
					  else {
						  alert('내부 오류로 삭제가 실패하였습니다. 다시 진행해 주세요.');
					  }
				  },
				  error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				  }
			  });
			  
		  }
		});
}



function openModal(clubseq){
	
	$.ajax({
		url: "<%=ctxPath%>/member/getClubmember.do",
		data: {"clubseq": clubseq},
		dataType: "json",
		success: function(json){
			
			let pageBar = json[json.length-1].pageBar;
			
			let modal_html = `<div class="modal-header" align="center">
						        <h5 class="modal-title" style="font-weight: bold; width: 100%; display: inline-block;">동호회 회원 관리</h5>
						        <button type="button" class="close" data-dismiss="modal">&times;</button>
						      </div>
							  <div class="modal-body" style="height: auto;">
								<div style="width: 100%; min-height: auto;">
									<div class="tableDiv my-5" align="center">
										<table class="clubMemberTbl" style="width: 80%;">
											<thead>
												<tr>
													<td style="width: 5%;" align="center">번호</td>
													<td style="width: 15%;" align="center">아이디</td>
													<td style="width: 10%;" align="center">이름</td>
													<td style="width: 20%;" align="center">연락처</td>
													<td style="width: 10%;" align="center">성별</td>
													<td style="width: 30%;" align="center">관리</td>
												</tr>
											</thead>
											
											<tbody>`;
											
			$.each(json, function(index, item){
				
				if(index != json.length-1){
				modal_html += `<tr>
							   		<td style="width: 5%;" align="center">\${item.rn}</td>
							   		<td style="width: 15%;" align="center">\${item.userid}</td>
							   		<td style="width: 10%;" align="center">\${item.name}</td>
							   		<td style="width: 20%;" align="center">\${item.mobile.substring(0, 3)}-\${item.mobile.substring(3, 7)}-\${item.mobile.substring(7, 11)}</td>
							   		<td style="width: 10%;" align="center">\${item.gender}</td>
							   		<td style="width: 30%;" align="center"><button type="button" class="btn btn-danger btn-sm" onclick="quitClubMember('\${item.userid}', \${item.clubseq})">강퇴</button>&nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-info btn-sm" onclick="sendMail('\${item.email}')">메일 전송</button></td>
							   </tr>`;
				}
			}); 
												
							modal_html += `</tbody>
										   <tfoot>
										   		<tr>
										   			<td colspan="6"></td>
										   		</tr>
										   </tfoot>
										</table>
									</div>
								</div>
								
								<div style="margin-left: 33%;"><ul style="list-style-type: none; display: flex;">\${pageBar}</ul></div>
								
						      </div>
						      <div class="modal-footer">
							     <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
							  </div>`;
			
			$("div.modal-content").html(modal_html);
			
			
		},
		error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	  }
	});
	
	
}


function movePage(currentShowPageNo, clubseq){
	
	$.ajax({
		url: "<%=ctxPath%>/member/getClubmember.do",
		data: {"currentShowPageNo": currentShowPageNo, "clubseq": clubseq},
		dataType: "json",
		success: function(json){
			
			let pageBar = json[json.length-1].pageBar;
			
			let modal_html = `<div class="modal-header" align="center">
						        <h5 class="modal-title" style="font-weight: bold; width: 100%; display: inline-block;">동호회 회원 관리</h5>
						        <button type="button" class="close" data-dismiss="modal">&times;</button>
						      </div>
							  <div class="modal-body" style="height: auto;">
								<div style="width: 100%; min-height: auto;">
									<div class="tableDiv my-5" align="center">
										<table class="clubMemberTbl" style="width: 80%;">
											<thead>
												<tr>
													<td style="width: 5%;" align="center">번호</td>
													<td style="width: 15%;" align="center">아이디</td>
													<td style="width: 10%;" align="center">이름</td>
													<td style="width: 20%;" align="center">연락처</td>
													<td style="width: 10%;" align="center">성별</td>
													<td style="width: 30%;" align="center">관리</td>
												</tr>
											</thead>
											
											<tbody>`;
											
			$.each(json, function(index, item){
				
				if(index != json.length-1){
				modal_html += `<tr>
							   		<td style="width: 5%;" align="center">\${item.rn}</td>
							   		<td style="width: 15%;" align="center">\${item.userid}</td>
							   		<td style="width: 10%;" align="center">\${item.name}</td>
							   		<td style="width: 20%;" align="center">\${item.mobile.substring(0, 3)}-\${item.mobile.substring(3, 7)}-\${item.mobile.substring(7, 11)}</td>
							   		<td style="width: 10%;" align="center">\${item.gender}</td>
							   		<td style="width: 30%;" align="center"><button type="button" class="btn btn-danger btn-sm" onclick="quitClubMember('\${item.userid}', \${item.clubseq})">강퇴</button>&nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-info btn-sm" onclick="sendMail('\${item.email}')">메일 전송</button></td>
							   </tr>`;
				}
			}); 
												
							modal_html += `</tbody>
										   <tfoot>
										   		<tr>
										   			<td colspan="6"></td>
										   		</tr>
										   </tfoot>
										</table>
									</div>
								</div>
								
								<div style="margin-left: 33%;"><ul style="list-style-type: none; display: flex;">\${pageBar}</ul></div>
								
						      </div>
						      <div class="modal-footer">
							     <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
							  </div>`;
			
			$("div.modal-content").html(modal_html);
			
			
		},
		error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	  }
	});
	
}


function quitClubMember(userid, clubseq){
	
	if(userid == '${sessionScope.loginuser.userid}'){
		alert('자기 자신은 탈퇴시킬 수 없습니다.');
		return;
	}
	
	Swal.fire({
		  title: "해당 회원을 강제 탈퇴시키시겠습니까?",
		  icon: "warning",
		  showCancelButton: true,
		  confirmButtonColor: "#3085d6",
		  cancelButtonColor: "#d33",
		  confirmButtonText: "네",
		  cancelButtonText: "아니오"		  
		}).then((result) => {
		  if (result.isConfirmed) {
			  
			  $.ajax({
				  url: "<%=ctxPath%>/member/quitClubMember.do",
				  data: {"clubseq": clubseq, "userid": userid},
				  type: "post",
				  dataType: "json",
				  success: function(json){
					  
					  if(json.n == 1){
						  Swal.fire({
						      title: "탈퇴 완료!",
						      icon: "success"
						    }).then(okay => {
								  if (okay) {
									  openModal(clubseq);
									  }
							  });
					  }
					  
					  else {
						  alert('내부 오류로 인하여 탈퇴가 실패하였습니다. 다시 시도해주세요.');
					  }
					  
				  },
				  error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				  }
			  });
		  
		  }
		  
		});
	
}


function sendMail(email){

	const f = document.emailFrm;
	f.receive.value = email;
	f.send.value = '${sessionScope.loginuser.userid}';
	f.method = "post";
	f.action = "<%=ctxPath%>/member/clubEmail.do";
	f.submit();
	
}

</script>




<div id="container">
    <div style="border:solid 0px red;">
        <%-- 마이페이지 서브메뉴 --%>
        <div id="menu" style="border:solid 0px black; display: flex; margin-top: 3%; ">
            <div style="border:solid 0px blue; width: 50%; display: flex; margin: 0 auto;" >
                  <button id="myinfo" class='mbtn' style="border-bottom: solid 3px #05203c;" onclick="location.href='<%=ctxPath%>/member/myPage.do'"><div><img src="<%= ctxPath%>/resources/images/zee/person2.png"></div>회원정보</button>
                  <button id="myclub" class='mbtn' style="border-bottom: solid 3px #05203c;" onclick="location.href='<%=ctxPath%>/member/myPage_club.do'"><div><img src="<%= ctxPath%>/resources/images/zee/team.png"></div>동호회 관리</button>
                  <button id="mygym" class='mbtn' style="border-bottom: solid 3px #05203c;" onclick="location.href='<%=ctxPath%>/member/myPage_gym.do'"><div><img style="height:65px;"src="<%= ctxPath%>/resources/images/zee/court.png"></div>체육관 관리</button>
                  <button id="etc" class='mbtn' style="border-bottom: solid 3px #05203c;" onclick="location.href='<%=ctxPath%>/member/myPage_etc.do'"><div><img src="<%= ctxPath%>/resources/images/zee/etc.png"></div>기타</button>
            </div>
        </div>
         
        <br>
        
        <div>
	       <div id="hr2-container">
	            <div id="hrbtns">
	                <button id="clubShow" class='btn2'>가입 동호회 조회</button>
	                <button id="clubManage" class='btn2'>내 동호회 관리</button>
	            </div>
	        </div>

	       
	        <div>
	           	<div id="content1" style="width: 80%; margin: 3% auto;" >
	                <div class="item1" style="margin-left: 10%;">&nbsp;가입 동호회 조회</div>
	                <hr class="hr1" style="width: 80%;">
	                <div id="memberInfo" align="center">
	                	<div id="top" style="display: flex; margin-bottom: 3%;">
	                		<div class="card">
	                			<div class="sportCard" style="background-color: #ffb3b3;">
	                				<img width="190" height="190" style="margin-top: 15%;" src="https://img.icons8.com/emoji/190/soccer-ball-emoji.png" alt="soccer-ball-emoji"/>
	                				<div class="sportname">축구</div>
	                			</div>
	                			<div class="back" align="center" style="padding: 10% 0;">
	                				<c:if test="${not empty requestScope.soccer}">
		                				<div id="clubname" style="font-size: 15pt; font-weight: bold; margin-bottom: 5%;">${requestScope.soccer.clubname }</div>
										<div style="width: 100%;" align="center"><img style="width: 50%;" src="<%=ctxPath%>/resources/images/zee/${requestScope.soccer.clubimg}"/></div>
										<div style="font-size: 10pt;">${requestScope.soccer.city}&nbsp;${requestScope.soccer.local}</div>
										<div style="font-size: 13pt;">${requestScope.soccer.clubgym}</div>
										<div style="font-size: 11pt;">${requestScope.soccer.clubtel}</div>
										<button type="button" class="btn btn-info" onclick="quitClub('${requestScope.soccer.clubseq}', '${sessionScope.loginuser.userid}')">탈퇴하기</button>
									</c:if>
									<c:if test="${empty requestScope.soccer}">가입된 동호회가 없습니다!</c:if>
	                			</div>
	                		</div>
	                		<div class="card">
	                			<div class="sportCard" style="background-color: #ffccb3;">
	                				<img width="190" height="190" style="margin-top: 15%;" src="https://img.icons8.com/emoji/190/baseball-emoji.png" alt="baseball-emoji"/>
	                				<div class="sportname">야구</div>
	                			</div>
	                			<div class="back">
									<c:if test="${not empty requestScope.baseball}">
		                				<div style="font-size: 15pt; font-weight: bold; margin-bottom: 5%;">${requestScope.baseball.clubname }</div>
										<div style="width: 100%;" align="center"><img style="width: 50%;" src="<%=ctxPath%>/resources/images/zee/${requestScope.baseball.clubimg}"/></div>
										<div style="font-size: 10pt;">${requestScope.baseball.city}&nbsp;${requestScope.baseball.local}</div>
										<div style="font-size: 13pt;">${requestScope.baseball.clubgym}</div>
										<div style="font-size: 11pt;">${requestScope.baseball.clubtel}</div>
										<button type="button" class="btn btn-info" onclick="quitClub('${requestScope.baseball.clubseq}', '${sessionScope.loginuser.userid}')">탈퇴하기</button>
									</c:if>
									<c:if test="${empty requestScope.baseball}">가입된 동호회가 없습니다!</c:if>
								</div>
	                		</div>
	                		<div class="card">
	                			<div class="sportCard" style="background-color: #ffe6b3;">
	                				<img width="190" height="190" style="margin-top: 15%;" src="https://img.icons8.com/emoji/190/volleyball-emoji.png" alt="volleyball-emoji"/>
									<div class="sportname">배구</div>
	                			</div>
	                			<div class="back">
	                				<c:if test="${not empty requestScope.volley}">
		                				<div style="font-size: 15pt; font-weight: bold; margin-bottom: 5%;">${requestScope.volley.clubname }</div>
										<div style="width: 100%;" align="center"><img style="width: 50%;" src="<%=ctxPath%>/resources/images/zee/${requestScope.volley.clubimg}"/></div>
										<div style="font-size: 10pt;">${requestScope.volley.city}&nbsp;${requestScope.volley.local}</div>
										<div style="font-size: 13pt;">${requestScope.volley.clubgym}</div>
										<div style="font-size: 11pt;">${requestScope.volley.clubtel}</div>
										<button type="button" class="btn btn-info" onclick="quitClub('${requestScope.volley.clubseq}', '${sessionScope.loginuser.userid}')">탈퇴하기</button>
									</c:if>
									<c:if test="${empty requestScope.volley}">가입된 동호회가 없습니다!</c:if>
	                			</div>
	                		</div>
	                		<div class="card">
	                			<div class="sportCard" style="background-color: #e0f2bf;">
	                				<img width="190" height="190" style="margin-top: 15%;" src="https://img.icons8.com/emoji/190/basketball-emoji.png" alt="basketball-emoji"/>
									<div class="sportname">농구</div>
	                			</div>
	                			<div class="back">
	                				<c:if test="${not empty requestScope.basket}">
		                				<div style="font-size: 15pt; font-weight: bold; margin-bottom: 5%;">${requestScope.basket.clubname }</div>
										<div style="width: 100%;" align="center"><img style="width: 50%;" src="<%=ctxPath%>/resources/images/zee/${requestScope.basket.clubimg}"/></div>
										<div style="font-size: 10pt;">${requestScope.basket.city}&nbsp;${requestScope.basket.local}</div>
										<div style="font-size: 13pt;">${requestScope.basket.clubgym}</div>
										<div style="font-size: 11pt;">${requestScope.basket.clubtel}</div>
										<button type="button" class="btn btn-info" onclick="quitClub('${requestScope.basket.clubseq}', '${sessionScope.loginuser.userid}')">탈퇴하기</button>
									</c:if>
									<c:if test="${empty requestScope.basket}">가입된 동호회가 없습니다!</c:if>
	                			</div>
	                		</div>
	                	</div>
	                	<div id="bottom" style="display: flex;">
							<div class="card">
								<div class="sportCard" style="background-color: #d6eeaa;">
									<img width="190" height="190" style="margin-top: 15%;" src="https://img.icons8.com/emoji/190/tennis-emoji.png" alt="tennis-emoji"/>
									<div class="sportname">테니스</div>
								</div>
								<div class="back">
									<c:if test="${not empty requestScope.tennis}">
		                				<div style="font-size: 15pt; font-weight: bold; margin-bottom: 5%;">${requestScope.tennis.clubname }</div>
										<div style="width: 100%;" align="center"><img style="width: 50%;" src="<%=ctxPath%>/resources/images/zee/${requestScope.tennis.clubimg}"/></div>
										<div style="font-size: 10pt;">${requestScope.tennis.city}&nbsp;${requestScope.tennis.local}</div>
										<div style="font-size: 13pt;">${requestScope.tennis.clubgym}</div>
										<div style="font-size: 11pt;">${requestScope.tennis.clubtel}</div>
										<button type="button" class="btn btn-info" onclick="quitClub('${requestScope.tennis.clubseq}', '${sessionScope.loginuser.userid}')">탈퇴하기</button>
									</c:if>
									<c:if test="${empty requestScope.tennis}">가입된 동호회가 없습니다!</c:if>
								</div>
							</div>
							<div class="card">
								<div class="sportCard" style="background-color: #cce6ff;">
									<img width="160" height="160" style="margin: 21% 0 5% 0;" src="https://img.icons8.com/external-smashingstocks-flat-smashing-stocks/180/external-Bowling-casino-smashingstocks-flat-smashing-stocks-3.png" alt="external-Bowling-casino-smashingstocks-flat-smashing-stocks-3"/>
									<div class="sportname">볼링</div>
								</div>
								<div class="back">
									<c:if test="${not empty requestScope.bowling}">
		                				<div style="font-size: 15pt; font-weight: bold; margin-bottom: 5%;">${requestScope.bowling.clubname }</div>
										<div style="width: 100%;" align="center"><img style="width: 50%;" src="<%=ctxPath%>/resources/images/zee/${requestScope.bowling.clubimg}"/></div>
										<div style="font-size: 10pt;">${requestScope.bowling.city}&nbsp;${requestScope.bowling.local}</div>
										<div style="font-size: 13pt;">${requestScope.bowling.clubgym}</div>
										<div style="font-size: 11pt;">${requestScope.bowling.clubtel}</div>
										<button type="button" class="btn btn-info" onclick="quitClub('${requestScope.bowling.clubseq}', '${sessionScope.loginuser.userid}')">탈퇴하기</button>
									</c:if>
									<c:if test="${empty requestScope.bowling}">가입된 동호회가 없습니다!</c:if>
								</div>
							</div>
							<div class="card">
								<div class="sportCard" style="background-color: #b3ccff;">
									<img width="160" height="160" style="margin: 21% 0 5% 0;" src="https://img.icons8.com/3d-fluency/160/beach-ball.png" alt="beach-ball"/>
									<div class="sportname">족구</div>
								</div>
								<div class="back">
									<c:if test="${not empty requestScope.jokgu}">
		                				<div style="font-size: 15pt; font-weight: bold; margin-bottom: 5%;">${requestScope.jokgu.clubname }</div>
										<div style="width: 100%;" align="center"><img style="width: 50%;" src="<%=ctxPath%>/resources/images/zee/${requestScope.jokgu.clubimg}"/></div>
										<div style="font-size: 10pt;">${requestScope.jokgu.city}&nbsp;${requestScope.jokgu.local}</div>
										<div style="font-size: 13pt;">${requestScope.jokgu.clubgym}</div>
										<div style="font-size: 11pt;">${requestScope.jokgu.clubtel}</div>
										<button type="button" class="btn btn-info" onclick="quitClub('${requestScope.jokgu.clubseq}', '${sessionScope.loginuser.userid}')">탈퇴하기</button>
									</c:if>
									<c:if test="${empty requestScope.jokgu}">가입된 동호회가 없습니다!</c:if>
								</div>
							</div>
							<div class="card">
								<div class="sportCard" style="background-color: #dbc6eb;">
									<img width="160" height="160" style="margin: 21% 0 5% 0;" src="https://img.icons8.com/3d-fluency/190/shuttercock.png" alt="shuttercock"/>
									<div class="sportname">배드민턴</div>
								</div>
								<div class="back">
									<c:if test="${not empty requestScope.minton}">
		                				<div style="font-size: 15pt; font-weight: bold; margin-bottom: 5%;">${requestScope.minton.clubname }</div>
										<div style="width: 100%;" align="center"><img style="width: 50%;" src="<%=ctxPath%>/resources/images/zee/${requestScope.minton.clubimg}"/></div>
										<div style="font-size: 10pt;">${requestScope.minton.city}&nbsp;${requestScope.minton.local}</div>
										<div style="font-size: 13pt;">${requestScope.minton.clubgym}</div>
										<div style="font-size: 11pt;">${requestScope.minton.clubtel}</div>
										<button type="button" class="btn btn-info" onclick="quitClub('${requestScope.minton.clubseq}', '${sessionScope.loginuser.userid}')">탈퇴하기</button>
									</c:if>
									<c:if test="${empty requestScope.minton}">가입된 동호회가 없습니다!</c:if>
								</div>
							</div>
	                	</div>
	                </div>
	                
	            </div>
	            
	            <div id="content2" style="width: 50%;  margin: 3% auto;" >
	                <div class="item1">&nbsp;내 동호회 관리</div>
	                <hr class="hr1">
	                <div id="memberInfo">
	                	<div style="display: flex; margin-top: 3%;">
	                	
	                	<c:if test="${sessionScope.loginuser.memberrank == 1}">
	                	
							<div id="prev" style="width: 10%; margin-left: 10%; align-content: center;" align="center"><img style="width: 60%;" src="<%=ctxPath%>/resources/images/narae/icons8-left-64.png"/></div>
							<!-- 여기 안에 div 만들고 모든 자기 동호회를 넣어야 함 -->
							<div id="slide" style="width: 450px; height: 600px; margin: 0 auto; overflow: hidden; box-shadow: 0 14px 28px rgba(0,0,0,0.25), 0 10px 10px rgba(0,0,0,0.22); border-radius: 20px;">
								<div id="profile" style="display: flex; height: 600px; transition: transform 1s; width: ${requestScope.clubList.size() * 450}px; flex-wrap: wrap;">
									
									<c:forEach items="${requestScope.clubList}" var="club">
										<div align="center" style="border-radius: 20px;	width: 450px; height: 600px; padding: 30px; margin: 0;">
											<div class="clubimg mb-3"><img style="width: 100%;" src="<%=ctxPath%>/resources/images/zee/${club.clubimg}"/></div>
											<div style="font-size: 10pt; font-weight: bold;">${club.sportname}</div>
											<div style="font-size: 20pt; font-weight: bold;">${club.clubname}</div>
											<div id="tableDiv" align="left">
												<div>
													<span class="spTitle">지역</span>
													<span class="area">${club.city}&nbsp;${club.local}</span>
												</div>
												<div>
													<span class="spTitle">활동구장</span>
													<span class="clubgym">${club.clubgym}</span>
												</div>
												<div>
													<span class="spTitle">연락처</span>
													<span class="clubtel">${club.clubtel}</span>
												</div>
												<div>
													<span class="spTitle">회비</span>
													<span class="clubpay"><fmt:formatNumber value="${club.clubpay}" pattern="#,###"/>원</span>
												</div>
												<div>
													<span class="spTitle">인원</span>
													<span class="mbcnt">${club.membercount}명</span>
												</div>
											</div>
											<div class="mt-3" style="display: flex; justify-content: space-between;">
												<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#mngMemberModal" onclick="openModal('${club.clubseq}')">회원 관리</button>&nbsp;&nbsp;
												<div class="ifEdit">
													<button type="button" class="btn btn-warning editBtn" onclick="editClub('${club.clubseq}')">수정</button>&nbsp;&nbsp;
												</div>
												<button type="button" class="btn btn-danger" onclick="deleteClub('${club.clubseq}')">동호회 삭제</button>
											</div>
										</div>
									</c:forEach>
								</div>
							</div>
							<div id="next" style="width: 10%; margin-right: 10%; align-content: center;" align="center"><img style="width: 60%;" src="<%=ctxPath%>/resources/images/narae/icons8-right-64.png"/></div>
						
						</c:if>
						<c:if test="${sessionScope.loginuser.memberrank != 1}">
							<div align="center" style="margin: 0 auto;">
							<img width="94" height="94" src="https://img.icons8.com/3d-fluency/94/box-important.png" alt="box-important"/><br><br>
							${sessionScope.loginuser.name }님이 만든 동호회가 없습니다.
							</div>
						</c:if>
						
						</div>
	                </div>
	                
	            </div>
		            
	        </div>
    	</div> 
    	
    </div>
</div>

<form name="emailFrm">
	<input type="hidden" name="receive" />
	<input type="hidden" name="send" />
</form>


<!-- 회원 관리 모달 -->
<div class="modal modalclass" id="mngMemberModal" style="margin: auto 0; height: auto;">
  <div class="modal-dialog modal-xl modal-dialog-scrollable" style="height: auto;">
    <div class="modal-content modal1">

    </div>
  </div>
</div>
