<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% String ctxPath = request.getContextPath(); %>

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 80%;
            margin: 50px auto;
            background: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            margin-bottom: 20px;
            color: #2980b9; /* 연한 파란색 */
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 0 auto;
        }

        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
        }

        th {
            background-color: #f2f2f2;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .my-2 {
            margin-bottom: 20px;
        }

        .search-form select,
        .search-form input {
            margin-right: 10px;
        }

        .search-form span {
            font-size: 12pt;
            font-weight: bold;
            cursor: pointer; /* 🔎 아이콘에 커서 손가락 모양 */
        }

        /* 특정 회원 클릭 시 손가락 모양으로 변경 */
        tbody tr.clubInfo td {
            cursor: pointer;
        }

        tbody tr.clubInfo:hover td {
            background-color: #ddd; /* 마우스 오버 시 배경색 변경 */
        }
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        $(document).ready(function(){
        	
        	$("div#clubM").addClass("hover");
        	
        	if("${requestScope.searchWord}" != "" && "${requestScope.searchType}" != ""){
        		$("input:text[name='searchWord']").val("${requestScope.searchWord}");
        		$("select[name='searchType']").val("${requestScope.searchType}");
        	}
        	
        	$("select[name='sizePerPage']").val("${requestScope.sizePerPage}");
        	
        	
        	
            // 특정 회원 클릭 시 상세 정보 보이기
            $(document).on("click", "tr.clubInfo td", function(e) {
               
            	let clubseq = $(e.target).parent().find("input[name='clubseq2']").val();
            	
            	const frm = document.goViewFrm;
            	frm.action = "<%=ctxPath%>/admin/manage/clubdetail";
                frm.clubseq.value = clubseq;
                frm.method = "post";
                frm.submit();
                
            });

        	$("select[name='sizePerPage']").bind('change', function(){
        		const frm = document.member_search_frm;
        		frm.submit();
        	});
            
            
            
            
        });
        
     // 검색 버튼 클릭 시 검증 후 폼 제출
        function goSearch() {
            if ($("input:text[name='searchWord']").val() == "") {
                alert("검색어를 입력하세요.");
                return;
            }
            
            if ($("select[name='searchType']").val() == "") {
                alert("검색 대상을 선택하세요.");
                return;
            }
            
            const frm = document.member_search_frm;
            frm.submit();
        }
        
    </script>
</head>


    <div class="container">
        <h1>동호회 관리</h1>

        <div class="my-2">
            <form name="member_search_frm" class="search-form">
                <select name="searchType" id="searchType">
                    <option value="">검색대상</option>
                    <option value="clubname">동호회이름</option>
                    <option value="fk_userid">아이디</option>
                    <option value="clubgym">체육관</option>
                </select>
                <input type="text" name="searchWord" id="searchWord" />
                <span onclick="goSearch()">🔎</span>
                <select name="sizePerPage" style="margin-left: 50%;" id="sizePerPage">
                    <option value="10">10</option>
                    <option value="5">5</option>
                    <option value="3">3</option>      
                </select>
                <span>개씩 보기</span>
            </form>
        </div>
      
        <table>
            <thead>
                <tr>
                    <th>동호회 번호</th>
                    <th>동호회명</th>
                    <th>회장 아이디</th>
                    <th>체육관</th>
                    <th>비용</th>
                    <th>운영시간</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${not empty requestScope.clubList}">
                    <c:forEach var="list" items="${requestScope.clubList}" varStatus="status">
                        <tr class="clubInfo">
                            <td>${requestScope.totalMemberCount - (requestScope.currentShowPageNo-1)*requestScope.sizePerPage - status.index}</td>
                            <td class="clubname">${list.clubname}</td>
                            <td>${list.fk_userid}</td>
                            <td>${list.clubgym}</td>
                             <td><fmt:formatNumber value="${list.clubpay}" pattern="#,###"/>원</td>
                            <td>${list.clubtime}<input type="hidden" name="clubseq2" value="${list.clubseq}"/></td>
                        </tr>
                    </c:forEach>
                </c:if>
                
                <c:if test="${empty requestScope.clubList}">
                    <tr><td colspan="6">데이터가 존재하지 않습니다.</td></tr>
                </c:if>
            </tbody>
        </table>

        <div id="pageBar" style="margin-left: 37%;">
            <nav>
                <ul class="pagination">${requestScope.pageBar}</ul>
            </nav>
        </div>
    </div>

<form name="goViewFrm">
	<input type="hidden" name="clubseq" /> 
	<input type="hidden" name="goBackURL" value="${requestScope.currentURL}"/> 
</form>
    