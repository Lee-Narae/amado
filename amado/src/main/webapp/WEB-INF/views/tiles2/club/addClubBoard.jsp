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
      
    	
       <%-- === 스마트 에디터 구현 시작 === --%>
        // id가 content인 textarea에 에디터에서 대입
          obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
       <%-- === 스마트 에디터 구현 끝 === --%>
       
       // 글제목 유효성 검사
       const subject = $("input:text[name='title']").val().trim();
       if(subject == ""){
          alert("글제목을 입력하세요!!");
          $("input:text[name='subject']").val("");
          return; // 종료
       }
       
       // 글내용 유효성 검사(스마트 에디터를 사용할 경우)
       let content_val = $("textarea[name='content']").val().trim();
       //alert(content_val); // content에 공백만 여러개를 입력하여 쓰기할 경우 알아보는 것
       
       content_val = content_val.replace(/&nbsp;/gi, ""); // 공백(&nbsp;)을 "" 으로 변환
       /*    
              대상문자열.replace(/찾을 문자열/gi, "변경할 문자열");
            ==> 여기서 꼭 알아야 될 점은 나누기(/)표시안에 넣는 찾을 문자열의 따옴표는 없어야 한다는 점입니다. 
                      그리고 뒤의 gi는 다음을 의미합니다.
         
            g : 전체 모든 문자열을 변경 global
            i : 영문 대소문자를 무시, 모두 일치하는 패턴 검색 ignore
       */ 
       //alert(content_val);
            
           content_val = content_val.substring(content_val.indexOf("<P>")+3);
           content_val.substring(0, content_val.indexOf("</p>"));
           
           if(content_val.trim().length == 0){
              alert("글내용을 입력하세요!!");
              return; // 종료
           }
           
           
          
        // 폼(form)을 전송(submit)
        const frm = document.addFrm;
        frm.method = "post";
        frm.action = "<%= ctxPath%>/club/addEndClubBoard.do";
        frm.submit();
    });
    
    
    
    
	// ==>> 제품이미지 파일선택을 선택하면 화면에 이미지를 미리 보여주기 시작 <<== //
	 $(document).on("change", "input.img_file", function(e){
		
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
                    <input type="text" name="title" size="100" maxlength="200" /> 
            </td>
         </tr>
         
         <tr>
            <th style="width: 15%; background-color: #DDDDDD;">내용</th> 
            <td>
                <textarea style="width: 100%; height: 612px;" name="content" id="content"></textarea>
            </td>
         </tr>
         
         <%-- === #170. 파일첨부 타입 추가하기 === --%>
		 <tr>
			<th style="width: 15%; background-color: #DDDDDD;">파일첨부</th>  
			<td>
			    <input type="file" name="attach" />
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
        
    <input type="hidden" name="clubseq" value="${requestScope.clubseq }" />
    <input type="hidden" name="clubname" value="${requestScope.clubname }" />
    <input type="hidden" name="sportname" value="${requestScope.sportname }" />
     
  </div>
</div>
		
</div>
	
	
</form>