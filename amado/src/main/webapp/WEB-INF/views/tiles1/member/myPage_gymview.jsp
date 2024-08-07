<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<% String ctxPath = request.getContextPath(); %> 

<style type="text/css">
   .mbtn {
        font-weight: bold;
        height: 100px;
        margin-inline-end: .25rem;
        background-color: white;
        border: none;
        color: gray;
        width: 40%;
        cursor: pointer;
        transition: box-shadow 0.3s ease;
    }

    .mbtn:hover {
        color: #05203c;
    }

    .hr1 {
        border-style: none;
        height: 2px;
        background-color: lightgray;
    }

    .item1 {
        border-left: solid 3px #05203c;
    }

    #hr2-container {
        position: relative;
        height: 40px;
        background-color: #98b6d5;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    #hrbtns {
        border: solid 0px red;
        margin-right: 1.5%;
        display: flex;
        gap: 70px;
        position: absolute;
        z-index: 1;
    }

    .btn2 {
        font-size: 14px;
        cursor: pointer;
        border: none;
        background-color: inherit;
    }

    .hover {
        color: #05203c;
        font-weight: bold;
    }

    .title {
        width: 15%;
        background-color: #4db8ff;
        color: white;
        font-weight: bold;
        align-content: center;
        text-align: center;
        height: 40px;
        border-radius: 15px;
        margin-right: 3%;
    }

    .tr {
        align-content: center;
        margin-bottom: 1%;
    }

    .select {
        width: 20%;
    }

    select {
        width: 30%;
        height: 40px;
        text-align: center;
        border-radius: 10px;
    }

    .btnInfoChange {
        font-size: 8pt;
        margin-left: 3%;
    }

    .input {
        width: 70%;
    }

    #memberInfo input {
        height: 40px;
        border-radius: 10px;
        align-content: center;
        padding-left: 1%;
        border: solid 1px gray;
    }

    body {
        font-family: Arial, sans-serif;
        
        color: #333;
        margin: 0;
        padding: 0;
    }

    .container {
        max-width: 800px;
        margin: 50px auto;
       
        padding: 20px;
       
 
    }

    .container h1 {
        text-align: center;
        color: #007BFF;
        margin-bottom: 20px;
    }

    .form-group {
        display: flex;
        align-items: center;
        margin-bottom: 15px;
    }

    .form-group label {
        width: 120px;
        font-weight: bold;
    }

    .form-group input[type="text"],
    .form-group input[type="file"],
    .form-group select,
    .form-group textarea {
        flex: 1;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 16px;
    }

    .form-group textarea {
        resize: vertical;
    }

  
/* .clickable 클래스를 가진 td 요소에 손가락 모양 커서 적용 */
.clickable {
    cursor: pointer;
}
 	
</style>


<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script type="text/javascript">

$(document).ready(function(){
    // 첫화면 기본세팅
    $("button#mygym").addClass('hover');
    $("#payList").css({"font-weight": "bold"});
    
});

function gym_delete(gymseq,fk_userid){
    $.ajax({
        url:"<%= ctxPath %>/member/gym_delete.do",
        data:{"gymseq":gymseq,
              "fk_userid":fk_userid
        },
        type: "post",
        dataType:"json",
        success:function(json){
            console.log(JSON.stringify(json));
            if(json.n > 0){
                alert('삭제가 완료됐습니다!');
                window.location.reload();
            }
        },
        error: function(request, status, error){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
        }
    });
}



</script>

<div id="container">
    <div style="border:solid 0px red;">
        <%-- 마이페이지 서브메뉴 --%>
        <div id="menu" style="border:solid 0px black; display: flex; margin-top: 3%;">
            <div style="border:solid 0px blue; width: 50%; display: flex; margin: 0 auto;">
                  <button id="myinfo" class='mbtn' style="border-bottom: solid 3px #05203c;" onclick="location.href='<%=ctxPath%>/member/myPage.do'"><div><img src="<%= ctxPath%>/resources/images/zee/person2.png"></div>회원정보</button>
                  <button id="myclub" class='mbtn' style="border-bottom: solid 3px #05203c;" onclick="location.href='<%=ctxPath%>/member/myPage_club.do'"><div><img src="<%= ctxPath%>/resources/images/zee/team.png"></div>동호회 관리</button>
                  <button id="mygym" class='mbtn' style="border-bottom: solid 3px #05203c;" onclick="location.href='<%=ctxPath%>/member/myPage_gymview.do'"><div><img style="height:65px;"src="<%= ctxPath%>/resources/images/zee/court.png"></div>체육관 관리</button>
                  <button id="etc" class='mbtn' style="border-bottom: solid 3px #05203c;" onclick="location.href='<%=ctxPath%>/member/myPage_etc.do'"><div><img src="<%= ctxPath%>/resources/images/zee/etc.png"></div>기타</button>
            </div>
        </div>
         
        <br>
        
        <div>
           <div id="hr2-container">
                <div id="hrbtns">
                    <button id="gymManage" class='btn2'>내 체육관 관리</button>
                </div>
            </div>
           
            <div>
                <div id="content2" style="width: 50%; margin: 3% auto;">
                    <div class="item1">&nbsp;내 체육관 관리</div>
                    <hr class="hr1">
                    <div id="memberInfo">
                    </div>
                </div>

                <div class="container">
                    <table class="table table-striped table-bordered" id="gymTable">
                        <thead class="thead-dark">
                            <tr>
                                <th>체육관 이름</th>
                                <th>체육관 주소</th>
                                <th>삭제하기</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${not empty requestScope.GymList}">
                                <!-- GymList가 비어있지 않을 때 데이터 출력 -->
                                <c:forEach var="gym" items="${requestScope.GymList}">
                                    <tr>  
                                        <td class="clickable"  onclick="location.href='<%= ctxPath %>/member/myPage_gym.do?gymseq=${gym.gymseq}'">${gym.gymname}</td>
                                        <td class="clickable"  onclick="location.href='<%= ctxPath %>/member/myPage_gym.do?gymseq=${gym.gymseq}'">${gym.address}</td>
                                        <td><button class="btn btn-danger btn-sm" onclick="gym_delete('${gym.gymseq}', '${gym.fk_userid}')">삭제하기</button></td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                            <c:if test="${empty requestScope.GymList}">
                                <!-- GymList가 비어있을 때 메시지 출력 -->
                                <tr>
                                    <td colspan="3">등록한 체육관이 없습니다!</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>



                <form>
                    <input type='hidden' name='fk_userid' value='${sessionScope.loginuser.userid}' />
                </form>
            </div>
        </div> 
    </div>
</div>
