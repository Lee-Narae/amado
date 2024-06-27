<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
   String ctxPath = request.getContextPath();
%>

<style type="text/css">
    .container {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh; /* Viewport height to center the image vertically */
    }
    .image-container {
        position: relative;
        width: 80%; /* Adjust the width as needed */
    }
    .image-container img {
        width: 100%;
        display: block;
    }
    .image-container .text {
        position: absolute;
        color: black; /* Text color */
        font-size: 24px; /* Adjust the font size as needed */
        font-weight: bold;
    }
    .text-a {
        top: 33.5%;
        left: 47.6%;
    }
    .text-b {
        top: 45%;
        left: 27%;
    }
    .text-c {
        top: 45%;
        left: 68%;
    }
    .search-input {
        text-align: left;
    }
    .search-input::placeholder {
        text-align: center;
    }
</style>

<div style="width: 87%; margin: auto; margin-top: 5%; padding-left: 3%;">
   <div style="text-align: center; margin: 5% 0 4% 0; font-size: 30pt; font-weight: bolder;">동호회 찾기</div>

<div class="container" style="margin-bottom: 40px;">
    <div class="image-container">
        <img src="<%=ctxPath %>/resources/images/podium.png" alt="Podium" />
        <div class="text text-a">1등</div>
        <div class="text text-b">2등</div>
        <div class="text text-c">3등</div>
    </div>
</div>

            
            <form name="searchFrm" style="margin-bottom: 40px; margin-top: 20px;">
	            <div class="float-left">
	                <select name="searchType" style="height: 26px;">
	                    <option value="Ranking">랭킹순</option>
	                    <option value="name">이름순</option>
	                    <option value="Member">회원순</option>
	                </select>
	                <select name="searchType" style="height: 26px;">
	                    <option value="gyeonggi-do">경기도</option>
	                    <option value="gangwon-do">강원도</option>
	                    <option value="Chungcheong">충청도</option>
	                    <option value="gyeongsang">경상도</option>
	                    <option value="jeolla">전라도</option>
	                </select> 
	            </div>
	            <div class="float-right" style="margin-bottom: 20px;">
	                <input type="text" name="searchWord" size="30" placeholder="동호회명을 검색하세요" class="search-input" autocomplete="off" />
	                <input type="text" style="display: none;" />
	                <%-- form 태그내에 input 태그가 오로지 1개 뿐일 경우에는 엔터를 했을 경우 검색이 되어지므로 이것을 방지하고자 만든것이다. --%>
	                <button type="button" class="btn btn-secondary btn-sm" onclick="goSearch()">검색</button>
	            </div>
	            
            </form>

            <table class="table table-bordered" style="margin-bottom: 10%;">
                <thead>
                    <tr>
                        <th style="width: 70px; text-align: center;">글번호</th>
                        <th style="width: 300px; text-align: center;">제목</th>
                        <th style="width: 70px; text-align: center;">작성자</th>
                        <th style="width: 150px; text-align: center;">작성일자</th>
                        <th style="width: 60px; text-align: center;">조회수</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td align="center" onclick="goView()">글번호</td>
                        <td><span class="subject" onclick="goView()">제목</span></td>
                        <td align="center">작성자</td>
                        <td align="center">날짜</td>
                        <td align="center">조회수</td>
                    </tr>
                </tbody>
            </table>
        </div>
