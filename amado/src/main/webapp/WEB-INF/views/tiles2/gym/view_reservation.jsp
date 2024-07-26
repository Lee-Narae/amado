<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
   String ctxPath = request.getContextPath();
%>    

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>예약 관리 테이블</title>
    <!-- 부트스트랩 CSS 링크 -->
    <link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/bootstrap-4.6.2-dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f0f4f8; /* 연한 배경색 */
            font-family: 'Arial', sans-serif;
        }
        .container {
            margin-top: 30px;
        }
        .table-container {
            background: #ffffff; /* 테이블 배경을 흰색으로 유지 */
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        .table thead th {
            background-color: #81d4fa; /* 하늘색 헤더 */
            color: #01579b; /* 어두운 하늘색 글자 */
            font-weight: bold;
            text-align: center;
            border-bottom: 2px solid #01579b; /* 헤더 밑에 테두리 */
        }
        .table tbody tr {
            transition: background-color 0.3s;
        }
        .table tbody tr:hover {
            background-color: #b3e5fc; /* 호버 시 배경 색상 */
        }
        .table tbody tr:nth-child(odd) {
            background-color: #ffffff; /* 홀수 행 배경 색상 */
        }
        .table tbody td {
            padding: 12px;
            border-top: 1px solid #e1f5fe; /* 행 사이에 테두리 추가 */
            color: #0277bd; /* 어두운 하늘색 글자 */
            background-color: #ffffff; /* 각 셀 배경 색상을 하얀색으로 유지 */
        }
        .table td {
            cursor: pointer;
        }
        .btn-cancel {
            background-color: #ff3d00; /* 빨간색 버튼 배경 */
            color: #ffffff; /* 버튼 글자 색상 */
            border: none;
            border-radius: 5px;
            padding: 8px 12px;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .btn-cancel:hover {
            background-color: #c62828; /* 호버 시 어두운 빨간색 */
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="table-container">
            <h1 class="text-center my-4">예약 관리 테이블</h1>
            <table class="table">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>예약장소</th>
                        <th>예약날짜</th>
                        <th>예약시간</th>
                        <th>예약금액</th>
                        <th>액션</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="reservation" items="${reservations}" varStatus="status">
                        <tr>
                            <td><c:out value="${status.index + 1}"/></td>
                            <td class="clickable" data-content="<c:out value='${reservation.place}'/>"><c:out value="${reservation.place}"/></td>
                            <td class="clickable" data-content="<c:out value='${reservation.date}'/>"><c:out value="${reservation.date}"/></td>
                            <td class="clickable" data-content="<c:out value='${reservation.time}'/>"><c:out value="${reservation.time}"/></td>
                            <td class="clickable" data-content="<c:out value='${reservation.amount}'/>"><c:out value="${reservation.amount}"/></td>
                            <td><button class="btn-cancel">예약취소</button></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- 모달 HTML -->
    <div class="modal fade" id="infoModal" tabindex="-1" role="dialog" aria-labelledby="infoModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="infoModalLabel">세부 정보</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p id="modalContent"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 부트스트랩 JS 및 Popper.js 링크 (필요한 경우) -->
    <script src="<%= ctxPath%>/resources/bootstrap-4.6.2-dist/js/bootstrap.min.js"></script>
    <script src="<%= ctxPath%>/resources/popper.js/2.11.6/umd/popper.min.js"></script>

    <!-- 사용자 정의 JS -->
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var cells = document.querySelectorAll('.clickable');
            cells.forEach(function(cell) {
                cell.addEventListener('click', function() {
                    var content = cell.getAttribute('data-content');
                    document.getElementById('modalContent').innerText = content;
                    $('#infoModal').modal('show');
                });
            });
        });
    </script>
</body>