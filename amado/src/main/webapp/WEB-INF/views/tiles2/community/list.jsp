<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
   String ctxPath = request.getContextPath();
%>


<style type="text/css">


	span.subject {
	    display: inline-block;
	    max-width: 450px; /* 최대 너비를 적절히 설정 */
	    overflow: hidden;
	    text-overflow: ellipsis;
	    white-space: nowrap;
	}	


/* 	.subject:hover {
		background: red;
	} */
    
    th {background-color: #ddd}
    
    .subjectStyle {font-weight: bold;
                   color: navy;
                   cursor: pointer; }
                   
    a {text-decoration: none !important;} /* 페이지바의 a 태그에 밑줄 없애기 */
    
    
</style>

<script type="text/javascript">

$(document).ready(function() {
		
	$("span.subject").hover(function(e){
		$(e.target).addClass("subjectStyle");
	}, function(e) {
		$(e.target).removeClass("subjectStyle");
	});
	
	$("input:text[name='searchWord']").bind("keyup", function(e){
		if(e.keyCode == 13){
			goSearch();
		}
	});
	
	// 검색시 검색조건 및 검색어 값 유지시키기
	if(${not empty requestScope.paraMap}) {
		$("select[name='searchType']").val("${requestScope.paraMap.searchType}");
		$("input[name='searchWord']").val("${requestScope.paraMap.searchWord}");
		$("select#searchType_a").val("${requestScope.params}");
	}
	
	
	<%-- === 검색어 입력시 자동글 완성하기  === --%>
	$("div#displayList").hide();
	
	$("input[name='searchWord']").keyup(function(){
		
		const wordLength = $(this).val().trim().length;
		// 검색어에서 공백을 제거한 길이를 알아온다.
		
		if(wordLength == 0){
			$("div#displayList").hide();
			// 검색어가 공백이거나 검색어 입력후 백스페이스키를 눌러서 검색어를 모두 지우면 검색된 내용이 안 나오도록 해야 한다. 
		}
		
		else {
			
			if( $("select[name='searchType']").val() == "title" ||
				$("select[name='searchType']").val() == "fk_userid" ) {
				
				$.ajax({
					url:"<%= ctxPath%>/wordSearchShow.do",
					type:"get",
					data:{"searchType":$("select[name='searchType']").val()
						 ,"searchWord":$("input[name='searchWord']").val()}, 
					dataType:"json",
					success:function(json){
					 //	console.log(JSON.stringify(json));
						/*
						  [{"word":"JSP/Servlet 에 대해서 질문있어요~~"},{"word":"처음으로 Jsp에 대해서 배워요"},{"word":"저는 jAVA에 대해서 궁금해요~~"},{"word":"친구가 java 공부를 하래요"},{"word":"Java 배우기가 어렵나요?"},{"word":"다음달 부터 JAVA 를 배우려구요"},{"word":"javascript 가 뭔가요?"},{"word":"웹을 하려면 jaVaScript 를 해야하나요?"}]
						     또는 
						  [] 
						*/
						
						<%-- === #120. 검색어 입력시 자동글 완성하기 7 === --%>
						if(json.length > 0){
							// 검색된 데이터가 있는 경우임.
							
							let v_html = ``;
							
							$.each(json, function(index, item){
								const word = item.word;
								// word ==> 저는 jAVA에 대해서 궁금해요~~
								// word ==> Java 배우기가 어렵나요?
								// word ==> 웹을 하려면 jaVaScript 를 해야하나요?
										
							//	word.toLowerCase() 은 word 를 모두 소문자로 변경하는 것이다.
								// word ==> 저는 java에 대해서 궁금해요~~
								// word ==> java 배우기가 어렵나요?
								// word ==> 웹을 하려면 javascript 를 해야하나요?
										
							    const idx = word.toLowerCase().indexOf($("input[name='searchWord']").val().toLowerCase());
								// 만약에 검색어가 JavA 이라면 
								/*
								      저는 java에 대해서 궁금해요~~         은 idx 가 3  이다.
								   java 배우기가 어렵나요?            은 idx 가 0  이다.
								      웹을 하려면 javascript 를 해야하나요?  은 idx 가 7  이다.
								*/
								
								const len = $("input[name='searchWord']").val().length; 
								// 검색어(JavA)의 길이 len 은 4가 된다.
							
							/*	
								console.log("~~~~~ 시작 ~~~~~~");
								console.log(word.substring(0, idx));       // 검색어(JavA) 앞까지의 글자         ==> 저는 
								console.log(word.substring(idx, idx+len)); // 검색어(JavA) 글자                     ==> jAVA
								console.log(word.substring(idx+len));      // 검색어(JavA) 뒤부터 끝까지 글자  ==> 에 대해서 궁금해요~~ 
								console.log("~~~~~ 끝 ~~~~~~");
							*/
							
							    const result = word.substring(0, idx) + "<span style='color:purple;'>"+word.substring(idx, idx+len)+"</span>"+ word.substring(idx+len); 
							    
							    v_html += `<span style='cursor:pointer;' class='result'>\${result}</span><br>`;
							    
							});// end of $.each()----------------------
							
							const input_width = $("input[name='searchWord']").css("width"); // 검색어 input 태그 width 값 알아오기
							
							$("div#displayList").css({"width":input_width}); // 검색결과 div 의 width 크기를 검색어 입력 input 태그의 width 와 일치시키기 
							
							$("div#displayList").html(v_html);
							$("div#displayList").show();
						}
					},
					error: function(request, status, error){
					   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
				});
			}
		}
	});// end of $("input[name='searchWord']").keyup(function(){})--------
	
	
	
}); // end of $(document).ready(function() -------
			
		
	function goAdd() {
		if("${requestScope.params}" == "/community/list.do") {
			location.href = "<%=ctxPath%>/community/add.do?sportseq="+"1";
		}
		else {
			location.href = "<%=ctxPath%>/community/add.do?sportseq="+"${requestScope.params}";	
		}
	
		
	} // end of goAdd
	
	function goSearch(){
//		alert("눌렀다");

		const frm = document.searchFrm;
		frm.submit();
	} // end of goSearch
	
	
	
	function goView(boardseq) {
		
/* 		alert("~~ 확인용 boardseq : " + boardseq); */
		
		const goBackURL = "${requestScope.goBackURL}";

 
//	그러므로 & 를 글자 그대로 인식하는 post 방식으로 보내야 한다.
//	아래에 #132. 에 표기된 from 태그를 먼저 만든다.

		const frm = document.goViewFrm;
 		frm.boardseq.value = boardseq;
		frm.goBackURL.value = goBackURL; 
		
		if(${not empty requestScope.paraMap}) { // 검색조건이 있을 경우
			frm.searchType.value = "${requestScope.paraMap.searchType}";
			frm.searchWord.value = "${requestScope.paraMap.searchWord}";
		}
		frm.action = "<%= ctxPath %>/board/boardview.do";
		frm.method = "post";
		frm.submit();

	} // end of function goView(seq) -------------------- 		
	
	function navigate() {
	    var selectBox = document.getElementById("searchType_a");
	    var selectedValue = selectBox.value;

	    // URL을 설정할 때 여기서 사용할 변수나 경로를 정의합니다.
	    var ctxPath = "<%=ctxPath %>"; // ctxPath 변수가 정의되어 있다고 가정

	    switch (selectedValue) {
	        case "0":
	            // 전체 선택 시 처리할 URL
	            location.href = ctxPath + "/community/list.do?sportseq=" + selectedValue;
	            break;
	        case "1":
	            // 축구 선택 시 처리할 URL
	            location.href = ctxPath + "/community/list.do?sportseq=" + selectedValue;
	            break;
	        case "2":
	            // 야구 선택 시 처리할 URL
	            location.href = ctxPath + "/community/list.do?sportseq=" + selectedValue;
	            break;
	        case "3":
	            // 배구 선택 시 처리할 URL
	            location.href = ctxPath + "/community/list.do?sportseq=" + selectedValue;
	            break;
	        case "4":
	            // 농구 선택 시 처리할 URL
	            location.href = ctxPath + "/community/list.do?sportseq=" + selectedValue;
	            break;
	        case "5":
	            // 테니스 선택 시 처리할 URL
	            location.href = ctxPath + "/community/list.do?sportseq=" + selectedValue;
	            break;
	        case "6":
	            // 볼링 선택 시 처리할 URL
	            location.href = ctxPath + "/community/list.do?sportseq=" + selectedValue;
	            break;
	        case "7":
	            // 족구 선택 시 처리할 URL
	            location.href = ctxPath + "/community/list.do?sportseq=" + selectedValue;
	            break;
	        case "8":
	            // 배드민턴 선택 시 처리할 URL
	            location.href = ctxPath + "/community/list.do?sportseq=" + selectedValue;
	            break;
	        default:
	            // 기본적으로는 전체로 처리
	            location.href = ctxPath + "/community/list.do?sportseq=/community/list.do";
	            break;
	    }

	    // 선택한 값을 localStorage에 저장하여 페이지 새로고침 후에도 유지
	    localStorage.setItem("selectedSport", selectedValue);
	}
	
</script>




<div style="display: flex;">
	<div style="width: 80%; margin: auto; padding-left: 3%;">
	<c:if test="${requestScope.params == '/community/list.do'}">
		<h2 style="text-align:center; margin-bottom: 30px;">전체 게시판</h2>
	</c:if>
	<c:if test="${requestScope.params == '1'}">
		<h2 style="text-align:center; margin-bottom: 30px;">축구 게시판</h2>
	</c:if>		
	<c:if test="${requestScope.params == '2'}">
		<h2 style="text-align:center; margin-bottom: 30px;">야구 게시판</h2>
	</c:if>		
	<c:if test="${requestScope.params == '3'}">
		<h2 style="text-align:center; margin-bottom: 30px;">배구 게시판</h2>
	</c:if>		
	<c:if test="${requestScope.params == '4'}">
		<h2 style="text-align:center; margin-bottom: 30px;">농구 게시판</h2>
	</c:if>		
	<c:if test="${requestScope.params == '6'}">
		<h2 style="text-align:center; margin-bottom: 30px;">테니스 게시판</h2>
	</c:if>		
	<c:if test="${requestScope.params == '7'}">
		<h2 style="text-align:center; margin-bottom: 30px;">볼링 게시판</h2>
	</c:if>		
	<c:if test="${requestScope.params == '5'}">
		<h2 style="text-align:center; margin-bottom: 30px;">족구 게시판</h2>
	</c:if>		
	<c:if test="${requestScope.params == '8'}">
		<h2 style="text-align:center; margin-bottom: 30px;">배드민턴 게시판</h2>
	</c:if>	
		
		<form name="searchFrm" class="float-right" style="text-align:right; margin-top: 20px;">
		    <select id="searchType_a" name="searchType_a" style="height: 26px;" onchange="navigate()">
		        <option value="/community/list.do">전체</option>
		        <option value="1">축구</option>
		        <option value="2">야구</option>
		        <option value="3">배구</option>
		        <option value="4">농구</option>
		        <option value="6">테니스</option>
		        <option value="7">볼링</option>
		        <option value="5">족구</option>
		        <option value="8">배드민턴</option>
		    </select>
	    	<select name="searchType" style="height: 26px;">
	    		<option value="title">글제목</option>
		        <option value="content">글내용</option>
		        <option value="title_content">글제목+글내용</option>
		        <option value="fk_userid">작성자아이디</option>
	      	</select>
	    	<input type="text" name="searchWord" size="40" autocomplete="off" /> 
	        <input type="text" style="display: none;"/> <%-- form 태그내에 input 태그가 오로지 1개 뿐일경우에는 엔터를 했을 경우 검색이 되어지므로 이것을 방지하고자 만든것이다. --%> 
	        <button type="button" class="btn btn-secondary btn-sm" onclick="goSearch()">검색</button>
	        <input type="hidden" name="sportseq" value="${requestScope.params}" />
		</form>	
		
		<%-- === 검색어 입력시 자동글 완성하기  === --%>
		<div id="displayList" style="border:solid 1px gray; border-top:0px; height:100px; margin-left:68%; margin-top:-30px; overflow:auto;">
		</div>	

		<br><br>

		<div class="mt-4" style="margin-top: 80px;">
		
		<table class="table table-bordered">
			<thead>
				<tr>
					<th style="width: 70px; text-align: center;">글번호</th>
					<th style="width: 300px; text-align: center;">제목</th>
					<th style="width: 70px; text-align: center;">작성자아이디</th>
					<th style="width: 150px; text-align: center;">카테고리</th>
					<th style="width: 150px; text-align: center;">작성일자</th>
					<th style="width: 60px; text-align: center;">조회수</th>
				</tr>
			</thead>

			<tbody>
			
				
				<c:if test="${not empty requestScope.boardPagingList}">
					<c:forEach var="boardvo" items="${requestScope.boardPagingList}">
						<c:if test="${boardvo.fk_sportseq == 1}">
							<c:if test="${empty boardvo.filename}">
							<tr>
								<td align="center">${boardvo.boardseq}</td>
								<td>
									<c:if test="${boardvo.commentcount > 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}<span class="badge badge-light">[${boardvo.commentcount}]</span></span>
									</c:if>
									<c:if test="${boardvo.commentcount == 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}</span>
									</c:if>
								</td>
								<td align="center">${boardvo.fk_userid}</td>
								<td align="center">축구</td>
								<td align="center">${boardvo.registerdate}</td>
								<td align="center">${boardvo.viewcount}</td>
							</tr>
							</c:if>
						</c:if>		
						<c:if test="${boardvo.fk_sportseq == 1}">
							<c:if test="${not empty boardvo.filename}">
							<tr>
								<td align="center">${boardvo.boardseq}</td>
								<td>
									<c:if test="${boardvo.commentcount > 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}<span class="badge badge-light">[${boardvo.commentcount}]</span></span>&nbsp;<img src="<%= ctxPath%>/resources/images/disk.gif" />
									</c:if>
									<c:if test="${boardvo.commentcount == 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}</span>&nbsp;<img src="<%= ctxPath%>/resources/images/disk.gif" />
									</c:if>
								</td>
								<td align="center">${boardvo.fk_userid}</td>
								<td align="center">축구</td>
								<td align="center">${boardvo.registerdate}</td>
								<td align="center">${boardvo.viewcount}</td>
							</tr>
							</c:if>
						</c:if>		
									
						<c:if test="${boardvo.fk_sportseq == 2}">
							<c:if test="${empty boardvo.filename}">
							<tr>
								<td align="center">${boardvo.boardseq}</td>
								<td>
									<c:if test="${boardvo.commentcount > 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}<span class="badge badge-light">[${boardvo.commentcount}]</span></span>
									</c:if>
									<c:if test="${boardvo.commentcount == 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}</span>
									</c:if>
								</td>
								<td align="center">${boardvo.fk_userid}</td>
								<td align="center">야구</td>
								<td align="center">${boardvo.registerdate}</td>
								<td align="center">${boardvo.viewcount}</td>
							</tr>
							</c:if>
							<c:if test="${not empty boardvo.filename}">
							<tr>
								<td align="center">${boardvo.boardseq}</td>
								<td>
									<c:if test="${boardvo.commentcount > 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}<span class="badge badge-light">[${boardvo.commentcount}]</span></span>&nbsp;<img src="<%= ctxPath%>/resources/images/disk.gif" />
									</c:if>
									<c:if test="${boardvo.commentcount == 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}</span>&nbsp;<img src="<%= ctxPath%>/resources/images/disk.gif" />
									</c:if>
								</td>
								<td align="center">${boardvo.fk_userid}</td>
								<td align="center">야구</td>
								<td align="center">${boardvo.registerdate}</td>
								<td align="center">${boardvo.viewcount}</td>
							</tr>
							</c:if>
						</c:if>
						
						<c:if test="${boardvo.fk_sportseq == 3}">
							<c:if test="${empty boardvo.filename}">
							<tr>
								<td align="center">${boardvo.boardseq}</td>
								<td>
									<c:if test="${boardvo.commentcount > 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}<span class="badge badge-light">[${boardvo.commentcount}]</span></span>
									</c:if>
									<c:if test="${boardvo.commentcount == 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}</span>
									</c:if>
								</td>
								<td align="center">${boardvo.fk_userid}</td>
								<td align="center">배구</td>
								<td align="center">${boardvo.registerdate}</td>
								<td align="center">${boardvo.viewcount}</td>
							</tr>
							</c:if>
							<c:if test="${not empty boardvo.filename}">
							<tr>
								<td align="center">${boardvo.boardseq}</td>
								<td>
									<c:if test="${boardvo.commentcount > 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}<span class="badge badge-light">[${boardvo.commentcount}]</span></span>&nbsp;<img src="<%= ctxPath%>/resources/images/disk.gif" />
									</c:if>
									<c:if test="${boardvo.commentcount == 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}</span>&nbsp;<img src="<%= ctxPath%>/resources/images/disk.gif" />
									</c:if>
								</td>
								<td align="center">${boardvo.fk_userid}</td>
								<td align="center">배구</td>
								<td align="center">${boardvo.registerdate}</td>
								<td align="center">${boardvo.viewcount}</td>
							</tr>
							</c:if>
						</c:if>
						
						<c:if test="${boardvo.fk_sportseq == 4}">
							<c:if test="${empty boardvo.filename}">
							<tr>
								<td align="center">${boardvo.boardseq}</td>
								<td>
									<c:if test="${boardvo.commentcount > 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}<span class="badge badge-light">[${boardvo.commentcount}]</span></span>
									</c:if>
									<c:if test="${boardvo.commentcount == 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}</span>
									</c:if>
								</td>
								<td align="center">${boardvo.fk_userid}</td>
								<td align="center">농구</td>
								<td align="center">${boardvo.registerdate}</td>
								<td align="center">${boardvo.viewcount}</td>
							</tr>
							</c:if>
							<c:if test="${not empty boardvo.filename}">
							<tr>
								<td align="center">${boardvo.boardseq}</td>
								<td>
									<c:if test="${boardvo.commentcount > 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}<span class="badge badge-light">[${boardvo.commentcount}]</span></span>&nbsp;<img src="<%= ctxPath%>/resources/images/disk.gif" />
									</c:if>
									<c:if test="${boardvo.commentcount == 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}</span>&nbsp;<img src="<%= ctxPath%>/resources/images/disk.gif" />
									</c:if>
								</td>
								<td align="center">${boardvo.fk_userid}</td>
								<td align="center">농구</td>
								<td align="center">${boardvo.registerdate}</td>
								<td align="center">${boardvo.viewcount}</td>
							</tr>
							</c:if>
						</c:if>
						
						<c:if test="${boardvo.fk_sportseq == 6}">
							<c:if test="${empty boardvo.filename}">
							<tr>
								<td align="center">${boardvo.boardseq}</td>
								<td>
									<c:if test="${boardvo.commentcount > 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}<span class="badge badge-light">[${boardvo.commentcount}]</span></span>
									</c:if>
									<c:if test="${boardvo.commentcount == 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}</span>
									</c:if>
								</td>
								<td align="center">${boardvo.fk_userid}</td>
								<td align="center">테니스</td>
								<td align="center">${boardvo.registerdate}</td>
								<td align="center">${boardvo.viewcount}</td>
							</tr>
							</c:if>
							<c:if test="${not empty boardvo.filename}">
							<tr>
								<td align="center">${boardvo.boardseq}</td>
								<td>
									<c:if test="${boardvo.commentcount > 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}<span class="badge badge-light">[${boardvo.commentcount}]</span></span>&nbsp;<img src="<%= ctxPath%>/resources/images/disk.gif" />
									</c:if>
									<c:if test="${boardvo.commentcount == 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}</span>&nbsp;<img src="<%= ctxPath%>/resources/images/disk.gif" />
									</c:if>
								</td>
								<td align="center">${boardvo.fk_userid}</td>
								<td align="center">테니스</td>
								<td align="center">${boardvo.registerdate}</td>
								<td align="center">${boardvo.viewcount}</td>
							</tr>
							</c:if>
						</c:if>
						
						<c:if test="${boardvo.fk_sportseq == 7}">
							<c:if test="${empty boardvo.filename}">
							<tr>
								<td align="center">${boardvo.boardseq}</td>
								<td>
									<c:if test="${boardvo.commentcount > 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}<span class="badge badge-light">[${boardvo.commentcount}]</span></span>
									</c:if>
									<c:if test="${boardvo.commentcount == 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}</span>
									</c:if>
								</td>
								<td align="center">${boardvo.fk_userid}</td>
								<td align="center">볼링</td>
								<td align="center">${boardvo.registerdate}</td>
								<td align="center">${boardvo.viewcount}</td>
							</tr>
							</c:if>
							<c:if test="${not empty boardvo.filename}">
							<tr>
								<td align="center">${boardvo.boardseq}</td>
								<td>
									<c:if test="${boardvo.commentcount > 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}<span class="badge badge-light">[${boardvo.commentcount}]</span></span>&nbsp;<img src="<%= ctxPath%>/resources/images/disk.gif" />
									</c:if>
									<c:if test="${boardvo.commentcount == 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}</span>&nbsp;<img src="<%= ctxPath%>/resources/images/disk.gif" />
									</c:if>
								</td>
								<td align="center">${boardvo.fk_userid}</td>
								<td align="center">볼링</td>
								<td align="center">${boardvo.registerdate}</td>
								<td align="center">${boardvo.viewcount}</td>
							</tr>
							</c:if>
						</c:if>
						
						<c:if test="${boardvo.fk_sportseq == 5}">
							<c:if test="${empty boardvo.filename}">
							<tr>
								<td align="center">${boardvo.boardseq}</td>
								<td>
									<c:if test="${boardvo.commentcount > 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}<span class="badge badge-light">[${boardvo.commentcount}]</span></span>
									</c:if>
									<c:if test="${boardvo.commentcount == 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}</span>
									</c:if>
								</td>
								<td align="center">${boardvo.fk_userid}</td>
								<td align="center">족구</td>
								<td align="center">${boardvo.registerdate}</td>
								<td align="center">${boardvo.viewcount}</td>
							</tr>
							</c:if>
							<c:if test="${not empty boardvo.filename}">
							<tr>
								<td align="center">${boardvo.boardseq}</td>
								<td>
									<c:if test="${boardvo.commentcount > 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}<span class="badge badge-light">[${boardvo.commentcount}]</span></span>&nbsp;<img src="<%= ctxPath%>/resources/images/disk.gif" />
									</c:if>
									<c:if test="${boardvo.commentcount == 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}</span>&nbsp;<img src="<%= ctxPath%>/resources/images/disk.gif" />
									</c:if>
								</td>
								<td align="center">${boardvo.fk_userid}</td>
								<td align="center">족구</td>
								<td align="center">${boardvo.registerdate}</td>
								<td align="center">${boardvo.viewcount}</td>
							</tr>
							</c:if>
						</c:if>
						
						<c:if test="${boardvo.fk_sportseq == 8}">
							<c:if test="${empty boardvo.filename}">
							<tr>
								<td align="center">${boardvo.boardseq}</td>
								<td>
									<c:if test="${boardvo.commentcount > 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}<span class="badge badge-light">[${boardvo.commentcount}]</span></span>
									</c:if>
									<c:if test="${boardvo.commentcount == 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}</span>
									</c:if>
								</td>
								<td align="center">${boardvo.fk_userid}</td>
								<td align="center">배드민턴</td>
								<td align="center">${boardvo.registerdate}</td>
								<td align="center">${boardvo.viewcount}</td>
							</tr>
							</c:if>
							<c:if test="${not empty boardvo.filename}">
							<tr>
								<td align="center">${boardvo.boardseq}</td>
								<td>
									<c:if test="${boardvo.commentcount > 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}<span class="badge badge-light">[${boardvo.commentcount}]</span></span>&nbsp;<img src="<%= ctxPath%>/resources/images/disk.gif" />
									</c:if>
									<c:if test="${boardvo.commentcount == 0}">
										<span class="subject" onclick="goView('${boardvo.boardseq}')">${boardvo.title}</span>&nbsp;<img src="<%= ctxPath%>/resources/images/disk.gif" />
									</c:if>
								</td>
								<td align="center">${boardvo.fk_userid}</td>
								<td align="center">배드민턴</td>
								<td align="center">${boardvo.registerdate}</td>
								<td align="center">${boardvo.viewcount}</td>
							</tr>
							</c:if>
						</c:if>
						
					</c:forEach>
				</c:if>

				<c:if test="${empty requestScope.boardPagingList}">
					<tr>
						<td colspan="6">데이터가 없습니다.</td>
					</tr>
				</c:if>

			</tbody>
		</table>
		
		</div>
		
		<div style="display: flex;"  class="float-right">
			<button type="button" class="btn btn-secondary btn-sm" style="margin: auto 0 auto auto;" onclick="goAdd()">글쓰기</button>
		</div>
		
		<nav aria-label="Page navigation example">
			<ul class="pagination justify-content-center">${requestScope.pageBar}</ul>
	    </nav>  			
	</div>
	
</div>

<%-- #132. 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후
     //    사용자가 "검색된결과목록보기" 버튼을 클릭했을때 돌아갈 페이지를 알려주기 위해
     //    현재 페이지 주소를 뷰단으로 넘겨준다. 
--%>
<form name="goViewFrm">
	<input type="hidden" name="boardseq" /> 
	<input type="hidden" name="goBackURL" /> 
	<input type="hidden" name="searchType" /> 
	<input type="hidden" name="searchWord" /> 
</form>



