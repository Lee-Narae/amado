<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% String ctxPath = request.getContextPath(); %>

<style type="text/css">
#downloadBtn {
display: inline-block;
background-color: #96e496;
border-radius: 5px;
width: 70px;
height: 30px;
align-content: center;
text-align: center;
font-weight: bold;
}

#downloadBtn:hover {
cursor: pointer;
opacity: 0.8;
}

#uploadBtn {
display: inline-block;
width: 12%;
height: 40px;
align-content: center;
background-color: #0066ff;
color: white;
font-weight: bold;
font-size: 15pt;
text-align: center;
border-radius: 10px;
}

#uploadBtn:hover {
cursor: pointer;
opacity: 0.8;
box-shadow: 0px 0px 5px black;
}

#searchType {
height: 35px;
width: 10%;
border-radius: 10px;
text-align: center;
}

#sizePerPage {
height: 35px;
width: 5%;
border-radius: 10px;
text-align: center;
}

#searchWord {
height: 35px;
border-radius: 10px;
border: solid 1px gray;
padding-left: 1%;
}

table#memberTbl th {
text-align: center;
font-size: 14pt;
}

table#memberTbl tr.memberInfo:hover {
background-color: #e6ffe6;
cursor: pointer;
}

form[name="member_search_frm"] {
border: solid 0px red;
}


</style>

<script type="text/javascript">
$(document).ready(function(){

	$("div#memberM").addClass("hover");
	
	$("input:text[name='searchWord']").bind("keyup", function(e){
        if(e.keyCode == 13){
        	goSearch();
        }
    });
	
	if("${requestScope.searchWord}" != "" && "${requestScope.searchType}" != ""){
		$("input:text[name='searchWord']").val("${requestScope.searchWord}");
		$("select[name='searchType']").val("${requestScope.searchType}");
	}
	
	$("select[name='sizePerPage']").val("${requestScope.sizePerPage}");
	
	$("select[name='sizePerPage']").bind('change', function(){
		const frm = document.member_search_frm;
		frm.submit();
	});
	
	// 특정 회원 클릭 시 상세 정보 보이기
	$("tbody > tr.memberInfo").click(function(e){ // 선택자는 tr이지만 클릭한 것은 td이다. 그러므로 e.target은 td태그를 가리킨다.
		// alert($(e.target).parent().text()," 클릭");
		const userid = $(e.target).parent().find(".userid").text();
		// 또는 const userid = $(e.target).parent().children(".userid").text();
		
		const frm = document.memberOneDetail_frm;
		frm.userid.value = userid;
		frm.action = "<%=ctxPath%>/admin/manage/memberDetail";
		// 만약 상단에서 .getContextPath를 하지 않았다면 따로 쓸 필요 없이 위와 같이 해주어도 동일하다.
		frm.method = "post";
		frm.submit();
	});
	
});

function goSearch() {
	if($("input:text[name='searchWord']").val() == ""){
		alert("검색어를 입력하세요.");
		return;
	}
	
	if($("select[name='searchType']").val() == ""){ // select태그의 option 중 value 값을 넣어야 한다.
		alert("검색 대상을 선택하세요.");
		return;
	}
	
	const frm = document.member_search_frm;
	frm.submit();
	
}

function fileDownload(){
	location.href = "<%=ctxPath%>/admin/memberRegisterFrmDownload";
}

function goInsert(){

	if($("input#excelsheet").val() == ''){
		alert("업로드할 파일을 선택하세요.");
		return;
	}

	else {
		let formData = new FormData($("form[name='memberInsertFrm']").get(0));   // 폼태그에 작성된 모든 데이터 보내기  
        // jQuery선택자.get(0) 은 jQuery 선택자인 jQuery Object 를 DOM(Document Object Model) element 로 바꿔주는 것이다. 
        // DOM element 로 바꿔주어야 순수한 javascript 문법과 명령어를 사용할 수 있게 된다.
        
        // 또는
        //   let formData = new FormData(document.getElementById("excel_upload_frm")); // 폼태그에 작성된 모든 데이터 보내기  
        
		$.ajax({
            url: "<%=ctxPath%>/admin/memberInsert",
            type: "post",
            data: formData,
            processData: false,  // 파일 전송시 설정 
            contentType: false,  // 파일 전송시 설정 
            dataType: "json",
            success: function(json){
               // console.log("~~~ 확인용 : " + JSON.stringify(json));
                // ~~~ 확인용 : {"result":1}
                if(json.result == 1) {
                   alert("파일 업로드 성공");
                }
                else {
                   alert("파일 업로드 실패");
                }
            },
            error: function(request, status, error){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
        });
        
        
	}
	
}

</script>

<div style="height: auto;" align="center">

<div id="wrap" style="width: 85%; min-height: 810px; padding-bottom: 3%;">

<img src="<%=ctxPath%>/resources/images/narae/회원정보목록.png" width="20%" class="mt-5"/>

<div id="top" align="left" class="mt-5 p-3" style="border-radius: 20px; background-color: #dde6ee; width: 80%; height: 210px;">
	<div>※ 클릭하여 회원 상세 정보 조회 및 관리가 가능합니다.</div>
	<div class="mt-2" style="border-top-left-radius: 10px; border-top-right-radius: 10px; background-color: #abd3f2; width: 10%; font-weight: bold; text-align: center; align-content:center; height: 30px;">회원 등록</div>
	<div id="warning" style="padding: 1%; background-color: #eaf3fb; width: 95%; height: 120px; border-radius: 10px; border-top-left-radius: 0px; font-size: 10.5pt;">
		<div>- <span id="downloadBtn" onclick="fileDownload()">다운로드</span>를 클릭하여 Excel 파일을 다운 받은 후, 회원 정보를 입력하여 업로드해주세요.</div>
		<div class="mt-2 ml-2" style="padding: 1%; background-color: white; border-radius: 10px;">
			<form name="memberInsertFrm" method="post" enctype="multipart/form-data">
				<input type="file" name="excelsheet"/><span id="uploadBtn" onclick="goInsert()">upload 📤</span>
			</form>
		</div>
	</div>
</div>

<div id="memberTable" class="mt-5" style="width: 80%;">

	<div class="my-2">
		<form name="member_search_frm">
		     <select name="searchType" id="searchType">
		        <option value="">검색대상</option>
		        <option value="name">회원명</option>
		        <option value="userid">아이디</option>
		        <option value="email">이메일</option>
		     </select>
		     &nbsp;
		     <input type="text" name="searchWord" id="searchWord" />
		     <input type="text" style="display: none;" /> 
		    
		    <span onclick="goSearch()" style="cursor: pointer;">🔎</span>
		    
		    <select name="sizePerPage" style="margin-left: 50%;" id="sizePerPage">
		       <option value="10">10</option>
		       <option value="5">5</option>
		       <option value="3">3</option>      
		    </select>
		    <span style="font-size: 12pt; font-weight: bold;">명씩 보기</span>
		 </form>
	</div>	
	<table class="table table-bordered" id="memberTbl" style="text-align: center;">
      <thead>
          <tr style="background-color: #ccf3ff;">
             <th width="10%">번호</th>
             <th width="20%">아이디</th>
             <th width="15%">회원명</th>
             <th width="35%">이메일</th>
             <th width="10%">성별</th>
             <th width="10%">등급</th>
          </tr>
      </thead>
      
      <tbody>
          <c:if test="${not empty requestScope.memberList}">
          	<c:forEach var="list" items="${requestScope.memberList}" varStatus="status">
          		<tr class="memberInfo">
          			<fmt:parseNumber var="currentShowPageNo" value="${requestScope.currentShowPageNo}" />
          			<fmt:parseNumber var="sizePerPage" value="${requestScope.sizePerPage}" />
          				<td>${requestScope.totalMemberCount - (currentShowPageNo-1)*sizePerPage - status.index}</td>
	          		<td class="userid">${list.userid}</td>
	          		<td>${list.name}</td>
	          		<td>${list.email}</td>
	          		<td>
	          			<c:if test="${list.gender == '1'}">남</c:if>
	          			<c:if test="${list.gender == '2'}">여</c:if>
	          		</td>
	          		<td>${list.memberrank}</td>
          		</tr>
          	</c:forEach>
          
          </c:if>
          
          <c:if test="${empty requestScope.memberList}">
          	<td colspan="5">데이터가 존재하지 않습니다.</td>
          </c:if>
      </tbody>
    </table>

		<div id="pageBar" style="margin-left: 37%;">
	       <nav>
	          <ul class="pagination">${requestScope.pageBar}</ul>
	       </nav>
	    </div>
</div>




</div>




</div>