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
	     
    	 if(frm.attach.value != '' && '${requestScope.editCBoard.orgfilename}' != ''){
    		 if(confirm('기존 첨부파일을 삭제하지 않고 새로운 첨부파일을 등록하더라도 새로운 첨부파일만 업로드됩니다.')){
    			 frm.method = "post";
    	    	 frm.action = "<%= ctxPath%>/club/editClubBoard.do";
    	    	 frm.submit();
    		 }
    	 }
	     
    	 frm.method = "post";
    	 frm.action = "<%= ctxPath%>/club/editClubBoard.do";
	     frm.submit();
	     
     });
     
     
     function display_none(){
    	 alert("눌려라 좀");
    	$("div#prevAttach").html("");
    	$("input[name='deleteAttach']").val(1);
     }


	
});// end of $(document).ready(function(){})---------------------------

</script>


<form name="addFrm" enctype="multipart/form-data">
	<div id="simple-list-item-0" class="container" style="border:solid 0px black; margin-top: 12%;  margin-bottom: 5%;">
	
		<div class="row" style="margin-left: 10%;">
		  
		  <div class="col-8">
		      <h3 id="simple-list-item-1" style="font-weight: bolder;">동호회게시판 글쓰기</h3>
		      <hr>
		  </div>

		</div>
		
	
	<div style="display: flex;">
  		<div style="margin: auto; padding-top: 3%; padding-left: 3%;">
     
        <table style="width: 1024px" class="table table-bordered">
         <tr>
            <th style="width: 15%; background-color: #DDDDDD;">아이디</th>
            <td>
                <input type="text" name="fk_userid" value="${sessionScope.loginuser.userid}" readonly />
                <%-- <input type="text" name="name" value="${sessionScope.loginuser.name}" readonly /> --%> 
            </td>
         </tr>
         
         <tr>
            <th style="width: 15%; background-color: #DDDDDD;">제목</th>
            <td>
                <input type="text" name="title" size="100" maxlength="200" value="${requestScope.editCBoard.title}"/> 
            </td>
         </tr>
         
         <tr>
            <th style="width: 15%; background-color: #DDDDDD;">내용</th> 
            <td>
                <textarea style="width: 100%; height: 612px;" name="content" id="content">${requestScope.editCBoard.content}</textarea>
            </td>
         </tr>
         
         <%-- === #170. 파일첨부 타입 추가하기 === --%>
		 <tr>
			<th style="width: 15%; background-color: #DDDDDD;">파일첨부</th>  
			<td>
			    <input type="file" name="attach" />
			</td>
			<c:if test="${not empty requestScope.editCBoard.orgfilename}">
				<div id="prevAttach" style="border: solid 1px gray; width: 64.5%; height: 50px; margin-left: 10%; border-radius: 10px; background-color: white; text-align: left; padding: 1%;">
				<span style="cursor: pointer;" onclick="display_none()">❌</span>&nbsp;&nbsp;<span>${requestScope.editCBoard.orgfilename}</span>
				</div>
			</c:if>
		 </tr>
         
         
        
        </table>
        
        <div style="margin: 20px;">
            <button type="button" class="btn btn-secondary btn-sm mr-3" id="btnEdit">수정하기</button>
            <button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back()">취소</button>  
        </div>
        <%-- form 태그 안에
        <button class="btn btn-secondary btn-sm mr-3" id="btnWrite">글쓰기</button>
        	이런식으로 타입을 안적으면 기본적으로 type="submit" 이기 때문에
        	유효성 검사를 하지 않고 GET 방식으로 넘어가버린다. 
         --%>
        
    <c:if test="${not empty requestScope.editCBoard}">
		<input type="hidden" name="clubboardseq" value="${requestScope.editCBoard.clubboardseq}"/>
		<input type="hidden" name="deleteAttach" value="0" />
	</c:if>
     
  </div>
</div>
		
</div>
	
	
</form>