<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
   String ctxPath = request.getContextPath();
%>

<style type="text/css">

</style>    

<script type="text/javascript">

  $(document).ready(function(){
     
	  <%-- === #167-2. 스마트 에디터 구현 시작 === --%>
      //전역변수
      var obj = [];
      
      //스마트에디터 프레임생성
      nhn.husky.EZCreator.createInIFrame({
          oAppRef: obj,
          elPlaceHolder: "content", // id가 content인 textarea에 에디터를 넣어준다.
          sSkinURI: "<%= ctxPath%>/resources/smarteditor/SmartEditor2Skin.html",
          htParams : {
              // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
              bUseToolbar : true,            
              // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
              bUseVerticalResizer : true,    
              // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
              bUseModeChanger : true,
          }
      });
     <%-- === 스마트 에디터 구현 끝 === --%>
     
     // 글쓰기 버튼
     $("button#btnWrite").click(function(){
    	 
    	 alert( $("textarea[name='content']").val().trim());
    	 
    	 <%-- === 스마트 에디터 구현 시작 === --%>
         // id가 content인 textarea에 에디터에서 대입
           obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
        <%-- === 스마트 에디터 구현 끝 === --%>
    	 
    	 // 글제목 유효성 검사
    	 const title = $("input:text[name='title']").val().trim();
    	 if(title == "") {
    		 alert("글제목을 입력하세요!!");
    		 $("input:text[name='title']").val("");
    		 return; // 종료
    	 }
    	 
    	 if(title.length >= 50) {
    		 alert("글제목은 50글자를 넘길 수 없습니다.");
    		 return; // 종료
    	 }
    	 
    	 // 글내용 유효성 검사(스마트에디터를 사용할 경우)
    	 // 위와 같은 방식으로 처리를 하면 공백을 넣을 때 html 에서는 &nbsp; 이렇게 들어가서 공백처리가 안된다.
    	 // 고로 아래와 같은 방식으로 처리를 해야한다.
    	 let content_val = $("textarea[name='content']").val().trim();
//    	 alert(content_val); // content 에 공백만 여러 개를 입력하여 쓸 경우
    	 // <p>&nbsp; &nbsp;&nbsp;</p> 이라고 나온다.
    	 
    	 content_val = content_val.replace(/&nbsp;/gi, ""); // 공백(&nbsp;)을 "" 으로 변환 (한번만 되서 정규표현식을 사용하여 전부 변환시켜준다.)
    /*    
                 대상문자열.replace(/찾을 문자열/gi, "변경할 문자열");
       ==> 여기서 꼭 알아야 될 점은 나누기(/)표시안에 넣는 찾을 문자열의 따옴표는 없어야 한다는 점입니다. 
                 그리고 뒤의 gi는 다음을 의미합니다.
    
       g : 전체 모든 문자열을 변경 global
       i : 영문 대소문자를 무시, 모두 일치하는 패턴 검색 ignore
    */ 
//    	 alert(content_val); // content 에 공백만 여러 개를 입력하여 쓸 경우
    	 // <p>    </p>
    	 
    	 content_val = content_val.substring(content_val.indexOf("<p>")+3);
    	 content_val = content_val.substring(0, content_val.indexOf("</p>"));
//    	 alert(content_val); // content 에 공백만 여러 개를 입력하여 쓸 경우
    	 // 
    	 if(content_val.length == 0){
    		 alert("글내용을 입력하세요!");
    		 return;
    	 }
    	 
    	 if(content_val.length >= 1000){
    		 alert("글내용은 1000글자를 넘길 수 없습니다.");
    		 return;
    	 }
    	 
    	// 글암호 유효성 검사
    	 const password = $("input:password[name='password']").val().trim();
    	 if(password == "") {
    		 alert("글암호를 입력하세요!!");
    		 $("input:text[name='password']").val("");
    		 return; // 종료
    	 }
    	 
    	 if(password.length >= 1000) {
    		 alert("글암호는 20글자를 넘길 수 없습니다.");
    		 $("input:text[name='password']").val("");
    		 return; // 종료
    	 }
    	 
    	 // 폼(form) 을 전송(submit)
    	 const frm = document.addFrm;
    	 frm.method = "post";
    	 frm.action = "<%= ctxPath%>/community/addEnd.do";
    	 frm.submit();
    	 
     }); // end of $("button#btnWrite").click(function()-----
     
  });// end of $(document).ready(function(){})-----------

  
	function navigate() {
	    var selectBox = document.getElementById("searchType_a");
	    var selectedValue = selectBox.value;

	    // URL을 설정할 때 여기서 사용할 변수나 경로를 정의합니다.
	    var ctxPath = "<%=ctxPath %>"; // ctxPath 변수가 정의되어 있다고 가정

	    switch (selectedValue) {
	        case "0":
	            // 전체 선택 시 처리할 URL
	            location.href = "?sportseq=/community/list.do";
	            break;
	        case "1":
	            // 축구 선택 시 처리할 URL
	            location.href = "?sportseq=1";
	            break;
	        case "2":
	            // 야구 선택 시 처리할 URL
	            location.href = "?sportseq=2";
	            break;
	        case "3":
	            // 배구 선택 시 처리할 URL
	            location.href = "?sportseq=3";
	            break;
	        case "4":
	            // 농구 선택 시 처리할 URL
	            location.href = "?sportseq=4";
	            break;
	        case "5":
	            // 테니스 선택 시 처리할 URL
	            location.href = "?sportseq=5";
	            break;
	        case "6":
	            // 볼링 선택 시 처리할 URL
	            location.href = "?sportseq=6";
	            break;
	        case "7":
	            // 족구 선택 시 처리할 URL
	            location.href = "?sportseq=7";
	            break;
	        case "8":
	            // 배드민턴 선택 시 처리할 URL
	            location.href = "?sportseq=8";
	            break;
	        default:
	            // 기본적으로는 전체로 처리
	            location.href = ctxPath + "/community/list.do";
	            break;
	    }

	    // 선택한 값을 localStorage에 저장하여 페이지 새로고침 후에도 유지
	    localStorage.setItem("selectedSport", selectedValue);
	}
  
</script>


<div style="display: flex;">
  <div style="margin: auto; padding-top: 3%; padding-left: 3%;">
     
     	<c:if test="${requestScope.params == '/community/list.do'}"> <!-- 나중에 post 방식으로 보낼 때는 clubseq 값도 같이 보내서 requestScope.clubseq 값에 따라 보여주게 변경. -->
		<h2 style="margin-bottom: 30px;">전체 글쓰기</h2>
		</c:if>		
		<c:if test="${requestScope.params == '1'}">
			<h2 style="margin-bottom: 30px;">축구 글쓰기</h2>
		</c:if>		
		<c:if test="${requestScope.params == '2'}">
			<h2 style="margin-bottom: 30px;">야구 글쓰기</h2>
		</c:if>		
		<c:if test="${requestScope.params == '3'}">
			<h2 style="margin-bottom: 30px;">배구 글쓰기</h2>
		</c:if>		
		<c:if test="${requestScope.params == '4'}">
			<h2 style="margin-bottom: 30px;">농구 글쓰기</h2>
		</c:if>		
		<c:if test="${requestScope.params == '5'}">
			<h2 style="margin-bottom: 30px;">테니스 글쓰기</h2>
		</c:if>		
		<c:if test="${requestScope.params == '6'}">
			<h2 style="margin-bottom: 30px;">볼링 글쓰기</h2>
		</c:if>		
		<c:if test="${requestScope.params == '7'}">
			<h2 style="margin-bottom: 30px;">족구 글쓰기</h2>
		</c:if>		
		<c:if test="${requestScope.params == '8'}">
			<h2 style="margin-bottom: 30px;">배드민턴 글쓰기</h2>
		</c:if>
     
       <form name="addFrm" enctype="multipart/form-data"> 
        <table style="width: 1024px;" class="board">
         <tr style="margin-bottom: 10px;">
            <th style="width: 15%; background-color: #DDDDDD;">아이디</th>
            <td>
                <input type="text" name="fk_userid" value="${sessionScope.loginuser.userid}" readonly />
            </td>
         </tr>
         
         <tr>
            <th style="width: 15%; background-color: #DDDDDD;">제목</th>
            <td>
                 <input type="text" name="title" size="100" maxlength="200" /> 
            </td>
         </tr>
         <tr>
         	<th style="width: 15%; background-color: #DDDDDD;">게시판</th>
         <td>
		     <select id="searchType_a" name="searchType_a" style="width: 30%;" onchange="navigate()">
		         <option value="0">전체</option>
		         <option value="1">축구</option>
		         <option value="2">야구</option>
		         <option value="3">배구</option>
		         <option value="4">농구</option>
		         <option value="6">테니스</option>
		         <option value="7">볼링</option>
		         <option value="5">족구</option>
		         <option value="8">배드민턴</option>
		     </select>
	     </td>
         <tr>
         <tr>
            <th style="width: 15%; background-color: #DDDDDD;">내용</th> 
            <td>
                <textarea style="width: 100%; height: 612px;" name="content" id="content"></textarea>
            </td>
         </tr>
         
		 <tr>
			 <th style="width: 15%; background-color: #DDDDDD;">파일첨부</th>  
			 <td>
			     <input type="file" name="attach" />
			 </td>
		 </tr>
         
         <tr>
            <th style="width: 15%; background-color: #DDDDDD;">글암호</th> 
            <td>
                <input type="password" name="password" maxlength="20" />
            </td>
         </tr>   
        </table>
        
        <div style="margin: 20px;">
            <button type="button" class="btn btn-secondary btn-sm mr-3" id="btnWrite">글쓰기</button>
            <button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back()">취소</button>  
        </div>
        <%-- form 태그 안에
        <button class="btn btn-secondary btn-sm mr-3" id="btnWrite">글쓰기</button>
        	이런식으로 타입을 안적으면 기본적으로 type="submit" 이기 때문에
        	유효성 검사를 하지 않고 GET 방식으로 넘어가버린다. 
         --%>
         <input type="hidden" name="sportseq" value="${requestScope.params}" />
     </form>
     
  </div>
</div>
