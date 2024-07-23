<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String ctxPath = request.getContextPath();
%>

<style type="text/css">
textarea::placeholder {
	font-size: 1.2em;
	font-style: italic;
	text-align: left;
	padding-top: 10px;
}

input[type="file"] {
	display: none;
}

.custom-file-upload {
	border: 1px solid #ccc;
	display: inline-block;
	padding: 6px 12px;
	cursor: pointer;
	background-color: gray;
}

.privacy-info {
	display: none;
	margin-top: 20px;
}

div.fileDrop {
	display: inline-block;
	width: 100%;
	height: 100px;
	overflow: auto;
	background-color: #fff;
	padding-left: 10px;
}

div.fileDrop>div.fileList>span.delete {
	display: inline-block;
	width: 20px;
	border: solid 1px gray;
	text-align: center;
}

div.fileDrop>div.fileList>span.delete:hover {
	background-color: #000;
	color: #fff;
	cursor: pointer;
}

div.fileDrop>div.fileList>span.fileName {
	padding-left: 10px;
}

div.fileDrop>div.fileList>span.fileSize {
	padding-right: 20px;
	float: right;
}
</style>


<script type="text/javascript">

	$(document).ready(function() {
		
        document.getElementById('view-policy').addEventListener('click', function() {
            var privacyInfo = document.getElementById('privacy-info');
            if (privacyInfo.style.display === 'none' || privacyInfo.style.display === '') {
                privacyInfo.style.display = 'block';
            } else {
                privacyInfo.style.display = 'none';
            }
        });
        
        
/*         $("input:file[name='attach']").click(function(e) {
//            alert($("input:file[name='attach']").val());

        	var files = e.originalEvent.dataTransfer.files;  
        	
        	alert(files);


        });	 */
        
        
  	  <%-- === jQuery 를 사용하여 드래그앤드롭(DragAndDrop)을 통한 파일 업로드 시작 === --%>
		let file_arr = []; // 첨부된어진 파일 정보를 담아 둘 배열
		
		let fSum = 0.000; // 첨푸되어진 파일의 사이즈 합을 담아둘 곳

		fSum = parseFloat(fSum);
		$("span#fSum").html(fSum);
		
        // == 파일 Drag & Drop 만들기 == //
	    $("div#fileDrop").on("dragenter", function(e){ /* "dragenter" 이벤트는 드롭대상인 박스 안에 Drag 한 파일이 최초로 들어왔을 때 */ 
	        e.preventDefault();
	        <%-- 
	                  브라우저에 어떤 파일을 drop 하면 브라우저 기본 동작이 실행된다. 
	                  이미지를 drop 하면 바로 이미지가 보여지게되고, 만약에 pdf 파일을 drop 하게될 경우도 각 브라우저의 pdf viewer 로 브라우저 내에서 pdf 문서를 열어 보여준다. 
	                  이것을 방지하기 위해 preventDefault() 를 호출한다. 
	                  즉, e.preventDefault(); 는 해당 이벤트 이외에 별도로 브라우저에서 발생하는 행동을 막기 위해 사용하는 것이다.
	        --%>
	        
	        e.stopPropagation();
	        <%--
	            propagation 의 사전적의미는 전파, 확산이다.
	            stopPropagation 은 부모태그로의 이벤트 전파를 stop 중지하라는 의미이다.
	                     즉, 이벤트 버블링을 막기위해서 사용하는 것이다. 
	                     사용예제 사이트 https://devjhs.tistory.com/142 을 보면 이해가 될 것이다. 
	        --%>
	    }).on("dragover", function(e){ /* "dragover" 이벤트는 드롭대상인 박스 안에 Drag 한 파일이 머물러 있는 중일 때. 필수이벤트이다. dragover 이벤트를 적용하지 않으면 drop 이벤트가 작동하지 않음 */ 
	        e.preventDefault();
	        e.stopPropagation();
	        $(this).css("background-color", "#ffd8d8");
	    }).on("dragleave", function(e){ /* "dragleave" 이벤트는 Drag 한 파일이 드롭대상인 박스 밖으로 벗어났을 때  */
	        e.preventDefault();
	        e.stopPropagation();
	        $(this).css("background-color", "#fff");
	    }).on("drop", function(e){      /* "drop" 이벤트는 드롭대상인 박스 안에서 Drag 한것을 Drop(Drag 한 파일(객체)을 놓는것) 했을 때. 필수이벤트이다. */
	        e.preventDefault();
	
	        var files = e.originalEvent.dataTransfer.files;  
	        <%--  
	            jQuery 에서 이벤트를 처리할 때는 W3C 표준에 맞게 정규화한 새로운 객체를 생성하여 전달한다.
	                     이 전달된 객체는 jQuery.Event 객체 이다. 이렇게 정규화된 이벤트 객체 덕분에, 
	                     웹브라우저별로 차이가 있는 이벤트에 대해 동일한 방법으로 사용할 수 있습니다. (크로스 브라우징 지원)
	                     순수한 dom 이벤트 객체는 실제 웹브라우저에서 발생한 이벤트 객체로, 네이티브 객체 또는 브라우저 내장 객체 라고 부른다.
            --%>
	        /*  Drag & Drop 동작에서 파일 정보는 DataTransfer 라는 객체를 통해 얻어올 수 있다. 
                jQuery를 이용하는 경우에는 event가 순수한 DOM 이벤트(각기 다른 웹브라우저에서 해당 웹브라우저의 객체에서 발생되는 이벤트)가 아니기 때문에,
	            event.originalEvent를 사용해서 순수한 원래의 DOM 이벤트 객체를 가져온다.
                Drop 된 파일은 드롭이벤트가 발생한 객체(여기서는 $("div#fileDrop")임)의 dataTransfer 객체에 담겨오고, 
                             담겨진 dataTransfer 객체에서 files 로 접근하면 드롭된 파일의 정보를 가져오는데 그 타입은 FileList 가 되어진다. 
                             그러므로 for문을 사용하든지 또는 [0]을 사용하여 파일의 정보를 알아온다. 
			*/
		//  console.log(typeof files); // object
        //  console.log(files);
            /*
				FileList {0: File, length: 1}
				0: File {name: 'berkelekle단가라포인트03.jpg', lastModified: 1605506138000, lastModifiedDate: Mon Nov 16 2020 14:55:38 GMT+0900 (한국 표준시), webkitRelativePath: '', size: 57641, …}
				         length:1
				[[Prototype]]: FileList
            */
	        if(files != null && files != undefined){
	         <%-- console.log("files.length 는 => " + files.length);  
	             // files.length 는 => 1 이 나온다. 
	         --%>   
	        	
	         <%--
	        	for(let i=0; i<files.length; i++){
	                const f = files[i];
	                const fileName = f.name;  // 파일명
	                const fileSize = f.size;  // 파일크기
	                console.log("파일명 : " + fileName);
	                console.log("파일크기 : " + fileSize);
	            } // end of for------------------------
	          --%>
	            
	            let html = "";
	            const f = files[0]; // 어차피 files.length 의 값이 1 이므로 위의 for문을 사용하지 않고 files[0] 을 사용하여 1개만 가져오면 된다. 
	        	let fileSize = f.size/1024/1024;  /* 파일의 크기는 MB로 나타내기 위하여 /1024/1024 하였음 */
	        	
	        	if(fileSize >= 20) {
	        		alert("20MB 이상인 파일은 업로드할 수 없습니다.!!");
	        		$(this).css("background-color", "#fff");
	        		return;
	        	}
	        	
	        	else {
	        		file_arr.push(f); //  드롭대상인 박스 안에 첨부파일을 드롭하면 파일들을 담아둘 배열인 file_arr 에 파일들을 저장시키도록 한다. 
		        	const fileName = f.name; // 파일명	
	        	
	        	    fileSize = fileSize < 1 ? fileSize.toFixed(3) : fileSize.toFixed(1);
	        	    // fileSize 가 1MB 보다 작으면 소수부는 반올림하여 소수점 3자리까지 나타내며, 
	                // fileSize 가 1MB 이상이면 소수부는 반올림하여 소수점 1자리까지 나타낸다. 만약에 소수부가 없으면 소수점은 0 으로 표시한다.
	                /* 
	                     numObj.toFixed([digits]) 의 toFixed() 메서드는 숫자를 고정 소수점 표기법(fixed-point notation)으로 표시하여 나타난 수를 문자열로 반환해준다. 
	                                     파라미터인 digits 는 소수점 뒤에 나타날 자릿수 로써, 0 이상 20 이하의 값을 사용할 수 있으며, 구현체에 따라 더 넓은 범위의 값을 지원할 수도 있다. 
	                     digits 값을 지정하지 않으면 0 을 사용한다.
	                     
	                     var numObj = 12345.6789;

						 numObj.toFixed();       // 결과값 '12346'   : 반올림하며, 소수 부분을 남기지 않는다.
						 numObj.toFixed(1);      // 결과값 '12345.7' : 반올림한다.
						 numObj.toFixed(6);      // 결과값 '12345.678900': 빈 공간을 0 으로 채운다.
	                */
	        	    html += 
	                    "<div class='fileList'>" +
	                        "<span class='delete'>&times;</span>" +  // &times; 는 x 로 보여주는 것이다.  
	                        "<span class='fileName'>"+fileName+"</span>" +
	                        "<span class='fileSize'>"+fileSize+" MB</span>" +
	                        "<span class='clear'></span>" +  // <span class='clear'></span> 의 용도는 CSS 에서 float:right; 를 clear: both; 하기 위한 용도이다. 
	                    "</div>";
		            $(this).append(html);
		            
		            
		            fSum = parseFloat(fSum);
		            fSum += Number(fileSize);
		            
		            fSum = fSum < 1 ? fSum.toFixed(3) : fSum.toFixed(1);
		            
		            $("span#fSum").html(fSum);
		            
	        	}
	        }// end of if(files != null && files != undefined)--------------------------
	        
	        $(this).css("background-color", "#fff");
	    });
		
		
	    // == Drop 되어진 파일목록 제거하기 == // 
	    $(document).on("click", "span.delete", function(e){
	    	let idx = $("span.delete").index($(e.target));
	    //	alert("인덱스 : " + idx );
	    
	    
   	    	let fileValue = file_arr[idx];
   	        let delfileSize = fileValue.size / 1024 / 1024; // 파일 크기를 MB 단위로 변환
   	   	    delfileSize = delfileSize < 1 ? delfileSize.toFixed(3) : delfileSize.toFixed(1);
//   	    alert("파일 크기: " + delfileSize + " MB");

            fSum = parseFloat(fSum);
            fSum -= Number(delfileSize);
            
            fSum = fSum < 1 ? fSum.toFixed(3) : fSum.toFixed(1);
            
            $("span#fSum").html(fSum);
	    
	    
	    
	    	file_arr.splice(idx,1); // 드롭대상인 박스 안에 첨부파일을 드롭하면 파일들을 담아둘 배열인 file_arr 에서 파일을 제거시키도록 한다. 
//	    	console.log(file_arr);
	    	
	    	

	    	
	    	
	    	
	    <%-- 
	               배열명.splice() : 배열의 특정 위치에 배열 요소를 추가하거나 삭제하는데 사용한다. 
		                                     삭제할 경우 리턴값은 삭제한 배열 요소이다. 삭제한 요소가 없으면 빈 배열( [] )을 반환한다.
		
		        배열명.splice(start, 0, element);  // 배열의 특정 위치에 배열 요소를 추가하는 경우 
			             start   - 수정할 배열 요소의 인덱스
                         0       - 요소를 추가할 경우
                         element - 배열에 추가될 요소
             
                      배열명.splice(start, deleteCount); // 배열의 특정 위치의 배열 요소를 삭제하는 경우    
                         start   - 수정할 배열 요소의 인덱스
                         deleteCount - 삭제할 요소 개수
		--%>
	    
            $(e.target).parent().remove(); // <div class='fileList'> 태그를 삭제하도록 한다. 	    
	    });

<%-- === jQuery 를 사용하여 드래그앤드롭(DragAndDrop)을 통한 파일 업로드 끝 === --%>
        
        
        
        <%-- 문의접수 버튼 눌렀을 경우 --%>
        $("button#inquiryWrite").click(function(){
        	
        	
        	if($("select#searchtype_a").val() == 0 || $("select#searchtype_b").val() == 0) {
        		alert("문의유형을 선택해주세요.");
        		return;
        	}
        	
        	
	       	 let content_val = "<p>"; 
	       	 content_val += $("textarea[name='content']").val().trim();
	       	 content_val += "</p>";
	       	
//	    	 alert(content_val.length); // content 에 공백만 여러 개를 입력하여 쓸 경우
	    	 // <p>&nbsp; &nbsp;&nbsp;</p> 이라고 나온다.
	    	 
	    	 content_val = content_val.replace(/&nbsp;/gi, ""); // 공백(&nbsp;)을 "" 으로 변환 (한번만 되서 정규표현식을 사용하여 전부 변환시켜준다.)
	        	
	    	 content_val = content_val.substring(content_val.indexOf("<p>")+3);
	    	 content_val = content_val.substring(0, content_val.indexOf("</p>"));
//	    	 alert(content_val); // content 에 공백만 여러 개를 입력하여 쓸 경우
	    	 // 
	    	 
	    	 if(content_val.length == 0){
	    		 alert("글내용을 입력하세요!");
	    		 return;
	    	 }
	    	 
	    	 if(content_val.length >= 1000){
	    		 alert("글내용은 1000글자를 넘길 수 없습니다.");
	    		 return;
	    	 }
	    	 
	    	 
	 		const regExp_email = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i);
			// 이메일 정규표현식 객체 생성 

			const email = $("textarea[name='email']").val();
			const bool = regExp_email.test(email);

			if (!bool) {
				alert("올바른 이메일 주소를 작성해주세요.");
				return;
			}
			
			const regExp_phone = new RegExp(/^[0][1][0][1-9][0-9]{7}$/);
			// 연락처 국번( 가운데 숫자 4자리인데 첫번째 숫자는 1-9 이고 나머지는 0-9) 정규표현식 객체 생성 

			const phone = $("textarea[name='phone']").val();
			const bool2 = regExp_phone.test(phone);
			if (!bool2) {
				alert("올바른 휴대폰 번호를 작성해주세요.");
				return;
			}
			
		    const checkbox_checked_length = $("input:checkbox[id='agree']:checked").length;

		    if(checkbox_checked_length == 0) {
		         alert("이용약관에 동의하셔야 합니다.");
		         return; // goRegister() 함수를 종료한다.
		    }
	    	 
		    
		    var formData = new FormData($("form[name='inquiryFrm']").get(0));
		    
	          if(file_arr.length > 0) { // 파일첨부가 있을 경우 
	              
	        	  // 첨부한 파일의 총합의 크기가 10MB 이상 이라면 메일 전송을 하지 못하게 막는다.
	        	  let sum_file_size = 0;
		          for(let i=0; i<file_arr.length; i++) {
		              sum_file_size += file_arr[i].size;
		          }// end of for---------------
		            
		          if( sum_file_size >= 20*1024*1024 ) { // 첨부한 파일의 총합의 크기가 10MB 이상 이라면 
		              alert("첨부한 파일의 총합의 크기가 20MB 이상이라서 파일을 업로드할 수 없습니다.!!");
		        	  return; // 종료
		          }
		          else { // formData 속에 첨부파일 넣어주기
		        	  
		        	  file_arr.forEach(function(item){
		                  formData.append("file_arr", item);  // 첨부파일 추가하기.  "file_arr" 이 키값이고  item 이 밸류값인데 file_arr 배열속에 저장되어진 배열요소인 파일첨부되어진 파일이 되어진다.    
		                                                      // 같은 key를 가진 값을 여러 개 넣을 수 있다.(덮어씌워지지 않고 추가가 된다.)
		              });
		          }
	          }		    
		    
	          $.ajax({
	              url : "<%=ctxPath%>/community/inquiryEnd.do",
	              type : "post",
	              data : formData,
	              processData:false,  // 파일 전송시 설정 
	              contentType:false,  // 파일 전송시 설정 
	              dataType:"json",
	              success:function(json){
	            	  // console.log("~~~ 확인용 : " + JSON.stringify(json));
	                  // ~~~ 확인용 : {"result":1}
	                  if(json.result == 1 || json.inquiryseq != 0) {
	                	 alert("1대1 문의가 등록되었습니다.");
	                	 GoInquiryList();
	                  }
	                  else {
	                	  alert("1대1 문의 등록에 실패했습니다.");
	                  }
	              },
	              error: function(request, status, error){
	  				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	  		      }
	          });
		    
<%-- 	    	const frm = document.inquiryFrm;
			frm.searchType_a.value = $("select#searchType_a").val();
			frm.searchType_b.value = $("select#searchType_b").val();
	    	frm.method = "post";
	    	frm.action = "<%=ctxPath%>/community/inquiryEnd.do";
	    	frm.submit(); --%>
    	 
        }); // 문의접수 버튼 눌렀을 경우
        
        
		
	}); // end of $(document).ready
	
	
	function GoInquiryList() {
		const frm = document.idFrm;
//    	frm.method = "GET";
    	frm.action = "<%=ctxPath%>/community/inquiryList.do";
    	frm.submit();		
	}
	
	
	
    function updateSearchTypeB() {
        var searchTypeA = document.getElementById("searchtype_a").value;
        var searchTypeB = document.getElementById("searchtype_b");
        var previousValue = searchTypeB.value;
        searchTypeB.innerHTML = "";

        var options = {
            "0": [{"text": "선택해주세요", "value": "0"}],
            "1": [{"text": "대관문의", "value": "1"}, {"text": "환불문의", "value": "2"}, {"text": "기타문의", "value": "3"}],
            "2": [{"text": "시설문의", "value": "1"}, {"text": "예약문의", "value": "2"}, {"text": "기타문의", "value": "3"}],
            "3": [{"text": "참가문의", "value": "1"}, {"text": "환불문의", "value": "2"}, {"text": "기타문의", "value": "3"}],
            "4": [{"text": "일반문의", "value": "1"}, {"text": "환불문의", "value": "2"}, {"text": "기타문의", "value": "3"}]
        };

        options[searchTypeA].forEach(function(optionObject) {
            var option = document.createElement("option");
            option.text = optionObject.text;
            option.value = optionObject.value;
            if (option.value === previousValue) {
                option.selected = true;
            }
            searchTypeB.add(option);
        });

        // Enable or disable searchTypeB based on searchTypeA value
        if (searchTypeA === "0") {
            searchTypeB.disabled = true;
        } else {
            searchTypeB.disabled = false;
        }
    }

</script>



<div style="display: flex;" class="mt-4">

	<div style="width: 80%; margin: auto; padding-left: 3%;">

		<div class="mb-3" style="cursor: pointer; text-decoration: underline;" id="GoInquiryList" onclick="GoInquiryList()">문의목록보기</div>		


		<h2 style="margin-bottom: 30px;">1:1 문의하기</h2>
		<hr style="border-width: 1px 0 0 0; border-color: #000;" class="mb-3">




		<form name="inquiryFrm" enctype="multipart/form-data">
			<div class="row mt-5" style="height: 50px;">
				<strong class="col-md-2 mt-3" style="text-align: center;">문의유형</strong>
				<select class="col-md-3" id="searchtype_a" name="searchtype_a" onchange="updateSearchTypeB()">
					<option value="0">선택해주세요</option>
					<option value="1">동호회</option>
					<option value="2">체육관</option>
					<option value="3">플리마켓</option>
					<option value="4">기타</option>
				</select> 
				<select class="col-md-3 ml-4" id="searchtype_b" name="searchtype_b" disabled>
					<option value="0">선택해주세요</option>
				</select>
				<div class="col-md-4"></div>
			</div>

			<div class="row mt-5" style="height: 260px; border: solid 0px blue;">
				<strong class="col-md-2 mt-2 mb-4" style="text-align: center;">문의내용</strong>
				<textarea name="content" class="col-md6" rows="10" cols="78"
					placeholder="※상담사에게 폭언, 욕설 등을 하지 말아주세요. &#10;답변을 받지 못하거나 사전안내 없이 삭제될 수 있습니다."></textarea>
			</div>

			<br>

			<div class="row ml-10 mt-1 mb-1">
				<div class="col-md-1 mr-5"></div>
				<div
					style="margin-left: 53px; flex: 0 0 auto; width: 767px; padding-right: 15px; padding-left: 15px;">
					<span style="font-size: 10pt;">파일을 마우스로 끌어 오세요</span>
					<div id="fileDrop" class="fileDrop border border-secondary"></div>
				</div>
			</div>

			<div class="d-flex align-items-center"
				style="font-size: small; margin-left: 220px;">
				20MB까지 등록가능하며 첨부파일은 답변완료가 되면 즉시 삭제됩니다.
				<div style="margin-left: 260px;"></div>
				<div class="col-md-1" style="font-weight: bolder;">
					<span id="fSum"></span>/20MB
				</div>
			</div>


			<div class="row mt-4" style="height: 40px; border: solid 0px blue;">
				<strong class="col-md-2 mt-2 mb-4" style="text-align: center;">이메일
					주소</strong>
				<textarea name="email" class="col-md6" rows="1" cols="65"
					placeholder="exam@naver.com" style="font-size: 14pt;">${requestScope.loginuser.email}</textarea>
			</div>

			<div class="row mt-5 mb-5"
				style="height: 40px; border: solid 0px red;">
				<strong class="col-md-2 mt-2 mb-4" style="text-align: center;">휴대폰
					번호</strong>
				<textarea name="phone" class="col-md6" rows="1" cols="65"
					placeholder="01012345678" style="font-size: 14pt;">${requestScope.loginuser.mobile}</textarea>
				<input type="hidden" name="fk_userid" value="${requestScope.fk_userid}">
			</div>

			<div class="row mt-5 mb-5"
				style="height: 20px; border: solid 0px red;">
				<div class="col-md-3"></div>
				<input type="checkbox" id="agree" class="col-md-1"><span
					class="mt-1">(필수) 개인정보 수집,이용동의&nbsp;&nbsp;<span
					id="view-policy"
					style="cursor: pointer; text-decoration: underline;">전문보기</span></span>
			</div>


			<div class="privacy-info" id="privacy-info">
				<hr style="border-width: 1px 0 0 0; border-color: #000;"
					class="mb-3">
				<p>
					<strong>개인정보 수집·이용에 대한 안내</strong>
				</p>
				<p>
					<strong>필수 수집·이용 항목</strong>
				</p>
				<p>문의접수와 처리, 회신을 위한 최소한의 개인정보입니다. 동의가 필요합니다.</p>
				<p>
					<strong>수집항목</strong>
				</p>
				<ul>
					<li>이메일 주소</li>
					<li>휴대폰 번호</li>
					<li>문의 및 상담 내용</li>
				</ul>
				<p>
					<strong>목적</strong>
				</p>
				<p>고객문의 및 상담요청에 대한 회신, 상담을 위한 서비스 이용기록 조회</p>
				<p>
					<strong>보유기간</strong>
				</p>
				<p>3년간 보관 후 지체없이 파기</p>
				<p>
					더 자세한 내용에 대해서는 <a href="#" target="_blank">AMADO 개인정보처리방침</a>을
					참고하시기 바랍니다.
				</p>
			</div>



			<div class="row mt-5 mb-5"
				style="height: 80px; border: solid 0px red;">
				<div class="col-md-3"></div>
				<button type="button" class="col-md-4"
					style="background-color: yellow;" id="inquiryWrite">
					<span
						style="font-weight: bolder; font-size: 18pt; font-style: inherit;">문의접수</span>
				</button>
			</div>

		</form>


<form name="idFrm">
	<input type="hidden" name="userid" value="${requestScope.fk_userid}">
</form>


	</div>
</div>












