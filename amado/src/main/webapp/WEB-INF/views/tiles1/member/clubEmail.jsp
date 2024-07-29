<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" /> 
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
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
padding-left: 5%;
}

input{
height: 40px;
border-radius: 10px;
border: solid 1px gray;
padding-left: 1%;
}

#plusImg {
width: 64%;
border: solid 1px gray;
background-color: white;
margin-left: 3%;
margin-bottom: 3%;
border-radius: 10px;
height: 120px;
padding: 1%;
}

.delete {
color: red;
font-weight: bold;
font-size: 15pt;
margin-right: 1%;
cursor: pointer;
}

/* 로더 */
.loader4{
  position: relative;
  width: 150px;
  height: 40px;
  align-content: center;
  top: 45%;
  top: -webkit-calc(50% - 10px);
  top: calc(50% - 10px);
  left: 25%;
  left: -webkit-calc(50% - 75px);
  left: calc(50% - 75px);

  background-color: rgba(255,255,255,0.2);
}

.loader4:before{
  align-content: center;
  content: "";
  position: absolute;
  background-color: #6699ff;
  top: 0px;
  left: 0px;
  height: 40px;
  width: 0px;
  z-index: 0;
  opacity: 1;
  -webkit-transform-origin:  100% 0%;
      transform-origin:  100% 0% ;
  -webkit-animation: loader4 10s ease-in-out infinite;
      animation: loader4 10s ease-in-out infinite;
}

.loader4:after{
  align-content: center;
  text-align: center;
  content: "LOADING ...";
  color: #6699ff;
  font-size: 20px;
  position: absolute;
  width: 100%;
  height: 40px;
  line-height: 20px;
  left: 0;
  top: 0;
}

@-webkit-keyframes loader4{
    0%{width: 0px;}
    70%{width: 100%; opacity: 1;}
    90%{opacity: 0; width: 100%;}
    100%{opacity: 0;width: 0px;}
}

@keyframes loader4{
    0%{width: 0px;}
    70%{width: 100%; opacity: 1;}
    90%{opacity: 0; width: 100%;}
    100%{opacity: 0;width: 0px;}
}
/* 로더 끝 */
</style>

<script type="text/javascript">
$(document).ready(function(){
	
	$("div.box").hide();
	
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
	
 	// 추가이미지 드래그앤드롭
 	let file_arr = [];
 	$("div#plusImg").on("dragenter", function(e){
 		e.preventDefault();
        e.stopPropagation();
 	}).on("dragover", function(e){ 
         e.preventDefault();
         e.stopPropagation();
         $(this).css("background-color", "#e0f1d0");
     }).on("dragleave", function(e){
         e.preventDefault();
         e.stopPropagation();
         $(this).css("background-color", "#fff");
     }).on("drop", function(e){
           e.preventDefault();
           var files = e.originalEvent.dataTransfer.files;
          
           if(files != null && files != undefined){
        	   let html = "";
               const f = files[0]; // 어차피 files.length 의 값이 1 이므로 위의 for문을 사용하지 않고 files[0] 을 사용하여 1개만 가져오면 된다. 
               let fileSize = f.size/1024/1024;

               if(fileSize >= 10) {
	               alert("10MB 이상인 파일은 업로드할 수 없습니다.");
	               $(this).css("background-color", "#fff");
	               return;
	           }
	               
	           else {
	               
	         	   file_arr.push(f);
	               const fileName = f.name; // 파일명   
	               
	               fileSize = fileSize < 1 ? fileSize.toFixed(3) : fileSize.toFixed(1);
	                    
	               html += "<div class='fileList'>" +
	                       "<span class='delete'>&times;</span>" +
	                       "<span class='fileName'>"+fileName+"</span>" +
	                       "<span class='fileSize'>"+fileSize+"MB</span>" +
	                       "<span class='clear'></span>" +
	                       "</div>";
	               $(this).append(html);
	           }
               
            }
           
          	$(this).css("background-color", "#fff");
           
     });
 	              
 	$(document).on("click", "span.delete", function(e){
 		
 		let idx = $("span.delete").index($(e.target));
 		file_arr.splice(idx, 1);
 		
 		$(e.target).parent().remove();
 	});
    
 	
 	$("button.emailSendBtn").click(function(){
 		
 		if($("input[name='title']").val().trim() == ''){
 			swal('제목을 입력하세요.');
 			return;
 		}
 		
 		obj.getById["CONTENT"].exec("UPDATE_CONTENTS_FIELD", []);
 		var contentval = $("textarea#CONTENT").val();
 		contentval = contentval.replace(/&nbsp;/gi, "");
 		contentval = contentval.substring(contentval.indexOf("<p>")+3);
 		contentval = contentval.substring(0, contentval.indexOf("</p>"));
 		
 		if(contentval.trim().length == 0) {
 			swal('내용을 입력하세요.');
 			return;
 		}
 		
 		if(file_arr.length > 5){
 			swal('첨부 파일은 최대 5개까지 첨부 가능합니다.');
 			return;
 		}
 	    
 		var formData = new FormData($("form[name='emailFrm']")[0]);
 	     
 	    if(file_arr.length > 0){ // 추가 이미지 파일이 있을 경우
 	     	// 첨부한 파일의 총합의 크기가 10MB 이상 이라면 전송을 하지 못하게 막는다.
 	     
 	     	let sum_file_size = 0;
 	     	
 	     	for(let i=0; i<file_arr.length; i++){
 	     		sum_file_size += file_arr[i].size;
 	     	};
 	     	
 			if( sum_file_size >= 10*1024*1024 ) { // 첨부한 파일의 총합의 크기가 10MB 이상 이라면 
 				alert("첨부 파일의 총합 크기가 10MB 이상이므로 등록이 불가합니다.");
 				return; // 종료
 	        }
 			else{
 				file_arr.forEach(function(item, index){
 					 formData.append("file_arr", item);
 				});
 			}
 			
 	    } // end of if(file_arr.length > 0)
 	     
 		$("div.box").show();
 	    	

 	    
 	    /*
 	    	processData 관련하여, 일반적으로 서버에 전달되는 데이터는 query string(쿼리 스트링)이라는 형태로 전달된다. 
 	    	ex) http://localhost:9090/board/list.action?searchType=subject&searchWord=안녕
 	    	? 다음에 나오는 'searchType=subject&searchWord=안녕'이라는 것이 query string(쿼리 스트링)이다. 
 	    	
 	    	data 파라미터로 전달된 데이터를 jQuery에서는 내부적으로 query string으로 만든다. 
 	    	하지만 파일 전송의 경우 내부적으로 query string으로 만드는 작업을 하지 않아야 한다.
 	    	이와 같이 내부적으로 query string으로 만드는 작업을 하지 않도록 설정하는 것이 processData: false이다.
 	    */

 	    /*
 	    	contentType 은 default 값이 "application/x-www-form-urlencoded; charset=UTF-8" 인데, 
 	    	"multipart/form-data" 로 전송이 되도록 하기 위해서는 false로 해야 한다. 
 	    	만약에 false 대신에 "multipart/form-data"를 넣어보면 제대로 작동하지 않는다.
 	    */

 	    $.ajax({
 	        url: "<%=ctxPath%>/member/sendClubEmail.do",
 	        type: "post",
 	        data: formData,
 	        processData: false,  // 파일 전송시 설정 
 	        contentType: false,  // 파일 전송시 설정
 	        dataType: "json",
 	        success: function(json){
 	        	if(json.result == 1){
 	        		location.href = "<%=ctxPath%>/member/sendComplete.do";
 	        	}
 	        	
 	        	else {
 	        		alert('내부 오류로 인해 메일 전송이 실패하였습니다.');
 	        		location.href = "<%=ctxPath%>/index.do";
 	        	}
 	        },
 	        error: function(request, status, error){
 	           alert("첨부된 파일의 크기의 총합이 20MB를 초과하여 등록이 불가합니다.");
 	      }
 	        
 	    });
 		
 	});
 	
 	
 	
 	
 	
});



</script>

<div id="wrap" style="width: 100%; min-height: 810px; padding: 5% 0;" align="center">
<img width="260" class="mt-5" src="<%=ctxPath%>/resources/images/narae/메일작성하기.png"/>

<form name="emailFrm" enctype="multipart/form-data">
	<div id="noticeContent" style="width: 90%; padding-top: 3%;">
		
		<div class="tr" style="align-content: center; margin-left: 8%; display: flex; margin-bottom: 0.5%;">
			<div class="title">받는 사람</div>
			<div style="width: 70%; margin-left: 3%;" align="left"><input type="text" style="border: none;" name="email" value="${requestScope.email}" readonly /></div>
		</div>
		<div class="tr" style="align-content: center; margin-left: 8%; display: flex; margin-bottom: 0.5%;">
			<div class="title">제목</div>
			<div style="width: 70%;"><input type="text" name="title" size="100" maxlength="50"/></div>
		</div>
		<div class="tr" style="align-content: center; margin-left: 8%; display: flex;">
			<div class="title">첨부 파일</div>
			<div id="plusImg" align="left" style="font-size: 10pt;">🖼️ 파일을 하나씩 드래그하세요.</div>
		</div>
	
		<div style="width: 75%; background-color: white; margin-top: 6%;">
			<textarea style="width: 100%; height: 612px;" name="content" id="CONTENT"></textarea>
		</div>
	</div>
	<input type="hidden" name="send" value="${requestScope.userid}"/>
</form>

		<div style="margin: 50px;">
			<button type="button" class="btn btn-primary mr-3 emailSendBtn" >메일 전송하기</button>
		    <button type="button" class="btn btn-secondary" onclick="javascript:history.back()">취소</button>  
		</div>
</div>

<div class="box" style="position: fixed; top: 50%; left: 46%;">
  <div class="loader4"></div>
</div>
