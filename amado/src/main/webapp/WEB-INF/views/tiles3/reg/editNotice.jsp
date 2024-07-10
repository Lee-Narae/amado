<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
.title {
width: 10%;
margin-left: 5%;
margin-right: 1%;
background-color: #0076d1;
color: white;
height: 40px;
align-content: center;
font-weight: bold;
border-radius: 20px;
}

.tr{
height: 50px;
padding-top: 0.4%;
}

input[name='title']{
height: 40px;
border-radius: 10px;
border: solid 1px gray;
padding-left: 1%;
}

</style>

<script type="text/javascript">
$(document).ready(function(){
	
	  <%-- === #166. 스마트 에디터 구현 시작 === --%>
      //전역변수
      var obj = [];
      
      //스마트에디터 프레임생성
      nhn.husky.EZCreator.createInIFrame({
          oAppRef: obj,
          elPlaceHolder: "CONTENT", // id가 content인 textarea에 에디터를 넣어준다.
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
	
     
     
     // 글쓰기버튼 클릭 시
     $("button#btnEdit").click(function(){

    	 // 글제목 유효성 검사
    	 if($("input:text[name='title']").val().trim() == ""){
    		 alert("글 제목을 입력하세요.");
    		 return;
    	 }
    	 
    	 <%-- === 스마트 에디터 구현 시작 === --%>
         // id가 content인 textarea에 에디터에서 대입
         obj.getById["CONTENT"].exec("UPDATE_CONTENTS_FIELD", []);
         <%-- === 스마트 에디터 구현 끝 === --%>
    	 
         // 글내용 유효성 검사(스마트에디터를 사용할 경우)
         let content_val = $("textarea[name='content']").val().trim();

         // 공백만 입력했을 경우
         // alert(content_val); ==> <p>&nbsp; &nbsp;</p>
         
         // 공백 (&nbsp;)를 " "으로 바꾼다.
         content_val = content_val.replace(/&nbsp;/gi, "");
         /*    
	                 대상문자열.replace(/찾을 문자열/gi, "변경할 문자열");
	       ==> 여기서 꼭 알아야 될 점은 나누기(/)표시안에 넣는 찾을 문자열의 따옴표는 없어야 한다는 점입니다. 
	                 그리고 뒤의 gi는 다음을 의미합니다.
	    
	       g : 전체 모든 문자열을 변경 global
	       i : 영문 대소문자를 무시, 모두 일치하는 패턴 검색 ignore
	     */ 
         
	     content_val = content_val.substring(content_val.indexOf("<p>")+3);
	     content_val = content_val.substring(0, content_val.indexOf("</p>"));
	     
	     if(content_val.trim().length == 0){
	    	 alert("글 내용을 입력하세요.");
	    	 return;
	     }

	     // form 전송
    	 const frm = document.addFrm;
	     
    	 if(frm.attach.value != '' && $("div#prevAttach").html() != ''){
    		 if(confirm('기존 첨부파일을 삭제하지 않고 새로운 첨부파일을 등록하더라도 새로운 첨부파일만 업로드됩니다.')){
    			 frm.method = "post";
    	    	 frm.action = "<%= ctxPath%>/community/editNotice.do";
    	    	 frm.submit();
    		 }
    	 }
	     
    	 frm.method = "post";
    	 frm.action = "<%= ctxPath%>/community/editNotice.do";
	     frm.submit();
	     
     });
     

     
});

function display_none(){
	$("div#prevAttach").html("");
	$("input[name='deleteAttach']").val(1);
}

</script>

<div id="wrap" style="min-height: 810px; padding-bottom: 5%;" align="center">
<img width="260" class="mt-5" src="<%=ctxPath%>/resources/images/narae/공지사항 등록.png"/>

<form name="addFrm" enctype="multipart/form-data">
	<div id="noticeContent" style="width: 90%; padding-top: 3%;">
		<div class="tr" style="align-content: center; margin-left: 8%; display: flex; margin-bottom: 0.5%;">
			<div class="title">제목</div>
			<div style="width: 70%;"><input type="text" name="title" size="100" maxlength="50" value="${requestScope.editNotice.title}"/></div>
		</div>
		<div class="tr" style="align-content: center; margin-left: 8%; display: flex;">
			<div class="title">첨부파일</div>
			<div style="width: 70%;" align="left"><input type="file" name="attach" style="margin-top: 0.5%;" /></div>
		</div>
			<c:if test="${not empty requestScope.editNotice}">
				<div id="prevAttach" style="border: solid 1px gray; width: 64.5%; height: 50px; margin-left: 10%; border-radius: 10px; background-color: white; text-align: left; padding: 1%;">
				<span style="cursor: pointer;" onclick="display_none()">❌</span>&nbsp;&nbsp;<span>${requestScope.editNotice.orgfilename}</span>
				</div>
			</c:if>
	
	
		<div style="width: 75%; background-color: white; margin-top: 1%;">
			<textarea style="width: 100%; height: 612px;" name="content" id="CONTENT">${requestScope.editNotice.content}</textarea>
		</div>
	</div>
	
	<c:if test="${not empty requestScope.editNotice}">
		<input type="hidden" name="noticeseq" value="${requestScope.editNotice.noticeseq}"/>
		<input type="hidden" name="deleteAttach" value="0" />
	</c:if>
</form>

		<div style="margin: 50px;">
		    <button type="button" class="btn btn-primary mr-3" id="btnEdit">수정하기</button>
		    <button type="button" class="btn btn-secondary" onclick="javascript:history.back()">취소</button>  
		</div>
</div>