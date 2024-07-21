<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>동호회 관리</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
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
        }
    </style>
    <script>
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
    </script>
</head>
<body>
    <div class="container">
        <div class="my-2">
            <form name="member_search_frm" class="search-form">
                <select name="searchType" id="searchType">
                    <option value="">검색대상</option>
                    <option value="name">회원명</option>
                    <option value="userid">아이디</option>
                    <option value="email">이메일</option>
                </select>
                <input type="text" name="searchWord" id="searchWord" />
                <input type="text" style="display: none;" /> 
                <span onclick="goSearch()" style="cursor: pointer;">🔎</span>
                <select name="sizePerPage" style="margin-left: 50%;" id="sizePerPage">
                    <option value="10">10</option>
                    <option value="5">5</option>
                    <option value="3">3</option>      
                </select>
                <span>명씩 보기</span>
            </form>
        </div>
      
        <table>
            <thead>
                <tr>
                    <th>동호회 번호</th>
                    <th>동호회명</th>
                    <th>회장 아이디</th>
                    <th>활동 구장</th>
                    <th>동호회 상태</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>001</td>
                    <td>축구 동호회</td>
                    <td>user01</td>
                    <td>서울 경기장</td>
                    <td>활동 중</td>
                </tr>
                <tr>
                    <td>002</td>
                    <td>농구 동호회</td>
                    <td>user02</td>
                    <td>부산 경기장</td>
                    <td>활동 중지</td>
                </tr>
              
            </tbody>
        </table>
        
        
        
        	<div id="pageBar" style="margin-left: 37%;">
	       <nav>
	          <ul class="pagination">${requestScope.pageBar}</ul>
	       </nav>
	    </div>
    </div>
</body>
</html>
