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
    }
    .image-container {
        position: relative;
        width: 68%;
    }
    .image-container img {
        width: 100%;
        display: block;
    }
    .image-container .text {
        position: absolute;
        color: black;
        font-size: 28px;
        font-weight: bold;
    }
    .image-container .img {
        position: absolute;
        width: 100%;
        height: 100%;
    }
    .text-a {
        top: 33%;
        left: 47%;
    }
    .text-b {
        top: 43%;
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

    /* New CSS for podium */
    .podium {
        display: flex;
        justify-content: space-around;
        align-items: flex-end;
        margin: 20px 0;
    }
    .podium-item {
        text-align: center;
        position: relative;
    }
    .podium-rank {
        position: absolute;
        width: 100%;
        top: -50px;
        font-size: 20px;
        font-weight: bold;
    }
    .podium-img {
        width: 150px;
        height: 150px;
        border-radius: 50%;
    }
    .podium-1st {
        height: 200px;
    }
    .podium-2nd,
    .podium-3rd {
        height: 150px;
    }
</style>



<div style="width: 1024px; margin: auto; margin-top: 5%;">
    <c:if test="${requestScope.params == '/club/findClub.do' || requestScope.params == '1'}">
       <div style="text-align: center; margin: 5% 0 4% 0; font-size: 30pt; font-weight: bolder;">축구 동호회 찾기</div>
    </c:if>
    <c:if test="${requestScope.params == '2'}">
       <div style="text-align: center; margin: 5% 0 4% 0; font-size: 30pt; font-weight: bolder;">야구 동호회 찾기</div>
    </c:if>
    <c:if test="${requestScope.params == '3'}">
       <div style="text-align: center; margin: 5% 0 4% 0; font-size: 30pt; font-weight: bolder;">배구 동호회 찾기</div>
    </c:if>
    <c:if test="${requestScope.params == '4'}">
       <div style="text-align: center; margin: 5% 0 4% 0; font-size: 30pt; font-weight: bolder;">농구 동호회 찾기</div>
    </c:if>
    <c:if test="${requestScope.params == '5'}">
       <div style="text-align: center; margin: 5% 0 4% 0; font-size: 30pt; font-weight: bolder;">테니스 동호회 찾기</div>
    </c:if>
    <c:if test="${requestScope.params == '6'}">
       <div style="text-align: center; margin: 5% 0 4% 0; font-size: 30pt; font-weight: bolder;">볼링 동호회 찾기</div>
    </c:if>
    <c:if test="${requestScope.params == '7'}">
       <div style="text-align: center; margin: 5% 0 4% 0; font-size: 30pt; font-weight: bolder;">족구 동호회 찾기</div>
    </c:if>
    <c:if test="${requestScope.params == '8'}">
       <div style="text-align: center; margin: 5% 0 4% 0; font-size: 30pt; font-weight: bolder;">배드민턴 동호회 찾기</div>
    </c:if>

    <div class="podium">
        <div class="podium-item podium-2nd">
            <div class="podium-rank">2등</div>
            <img src="<%=ctxPath %>/resources/images/다운로드.jpg" class="podium-img" alt="Podium" />
        </div>
        <div class="podium-item podium-1st">
            <div class="podium-rank">1등</div>
            <img src="<%=ctxPath %>/resources/images/다운로드1.jpg" class="podium-img" alt="Podium" />
        </div>
        <div class="podium-item podium-3rd">
            <div class="podium-rank">3등</div>
            <img src="<%=ctxPath %>/resources/images/다운로드2.jpg" class="podium-img" alt="Podium" />
        </div>
    </div>

    <form name="searchFrm" style="margin-bottom: 40px; margin-top: 20px;">
        <div style="display: flex;" class="float-left">
            <select name="searchType-a" style="height: 26px;">
                <option value="Ranking">랭킹순</option>
                <option value="name">이름순</option>
                <option value="Member">멤버수순</option>
            </select>
            <select name="searchType-b" style="height: 26px; margin-left: 2%;">
                <option value="none" selected="selected">== 지역선택 ==</option>
                <option value="seoul">서울특별시</option>
                <option value="busan">부산광역시</option>
                <option value="daegu">대구광역시</option>
                <option value="incheon">인천광역시</option>
                <option value="gwangju">광주광역시</option>
                <option value="daejeon">대전광역시</option>
                <option value="ulsan">울산광역시</option>
                <option value="sejong">세종특별자치시</option>
                <option value="gyeonggi">경기도</option>
                <option value="gangwon">강원특별자치시</option>
                <option value="chung-cheong_bukdo">충청북도</option>
                <option value="chung-cheong_namdo">충청남도</option>
                <option value="jeonbuk">전북특별자치시</option>
                <option value="jeonnam">전라남도</option>
                <option value="gyeongbuk">경상북도</option>
                <option value="gyeongnam">경상남도</option>
                <option value="jeju">제주특별자치도</option>
            </select> 
            <select name="searchType-c" style="height: 26px; margin-left: 2%; margin-right: 5px;">
                <option value="none" selected="selected">== 카테고리선택 ==</option>
                <option value="soccer">축구</option>
                <option value="baseball">야구</option>
                <option value="volleyball">배구</option>
                <option value="basketball">농구</option>
                <option value="tennis">테니스</option>
                <option value="Bowling">볼링</option>
                <option value="foot_volleyball">족구</option>
                <option value="Badminton">배드민턴</option>
            </select> 
        </div>
        <div class="float-right" style="display: flex; margin-bottom: 20px;">
            <input type="text" name="searchWord" size="30" placeholder="동호회명을 검색하세요" class="search-input" autocomplete="off" />
            <input type="text" style="display: none;" />
            <%-- form 태그내에 input 태그가 오로지 1개 뿐일 경우에는 엔터를 했을 경우 검색이 되어지므로 이것을 방지하고자 만든것이다. --%>
            <button style="margin-left: 5px;" type="button" class="btn btn-secondary btn-sm" onclick="goSearch()">검색</button>
        </div>
    </form>

    <table class="table table-bordered" style="margin-bottom: 10%;">
        <thead>
            <tr>
                <th style="width: 70px; text-align: center;">랭킹</th>
                <th style="width: 70px; text-align: center;">대표이미지</th>
                <th style="width: 300px; text-align: center;">동호회명</th>
                <th style="width: 300px; text-align: center;">소개글</th>
                <th style="width: 100px; text-align: center;">카테고리</th>
                <th style="width: 100px; text-align: center;">지역</th>
                <th style="width: 100px; text-align: center;">멤버수</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td align="center" onclick="goView()">1</td>
                <td><img src="<%=ctxPath %>/resources/images/다운로드1.jpg" class="rounded" alt="round" width="80" /></td>
                <td align="center">동호회명</td>
                <td align="center">소개글</td>
                <td align="center">카테고리</td>
                <td align="center">지역</td>
                <td align="center">멤버수</td>
            </tr>
            <tr>
                <td align="center" onclick="goView()">2</td>
                <td><img src="<%=ctxPath %>/resources/images/다운로드.jpg" class="rounded" alt="round" width="80" /></td>
                <td align="center">동호회명2</td>
                <td align="center">소개글2</td>
                <td align="center">카테고리2</td>
                <td align="center">지역2</td>
                <td align="center">멤버수2</td>
            </tr>
            <tr>
                <td align="center" onclick="goView()">3</td>
                <td><img src="<%=ctxPath %>/resources/images/다운로드2.jpg" class="rounded" alt="round" width="80" /></td>
                <td align="center">동호회명3</td>
                <td align="center">소개글3</td>
                <td align="center">카테고리3</td>
                <td align="center">지역3</td>
                <td align="center">멤버수3</td>
            </tr>
        </tbody>
    </table>
</div>

