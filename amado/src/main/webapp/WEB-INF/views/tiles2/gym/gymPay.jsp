<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
   String ctxPath = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>체육관 예약</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .container {
            max-width: 800px;
            margin-top: 20px;
            width: 30%;
        }
        .section {
            margin-bottom: 20px;
        }
        .btn-custom {
            flex: 1 1 23%; /* 버튼들이 4개의 열을 가진 그리드로 배치됨 */
            height: 50px;
            margin: 5px; /* 버튼 사이의 간격 */
        }
        .btn-container {
            display: flex;
            flex-wrap: wrap; /* 버튼들을 여러 줄로 감싸서 표시 */
            justify-content: space-between; /* 버튼 사이의 간격을 균등하게 배치 */
        }
        .btn-custom.selected {
            background-color: #007bff;
            color: white;
        }
        .price {
            font-size: 24px;
            font-weight: bold;
        }
        .btn-reserve {
            width: 100%; /* 예약 버튼을 전체 폭으로 설정 */
            height: 50px;
        }
    </style>
    <script>
        let totalPrice = 0;

        function updatePrice(amount) {
            totalPrice += amount;
            document.getElementById("totalPrice").innerText = '₩' + totalPrice.toLocaleString();
        }

        function toggleSelection(button) {
            const isSelected = button.classList.contains('selected');
            const buttonValue = 10000;

            // Toggle button selection
            if (isSelected) {
                button.classList.remove('selected');
                updatePrice(-buttonValue);
            } else {
                button.classList.add('selected');
                updatePrice(buttonValue);
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <!-- 체육관 사진 -->
        <div class="section">
            <img src="gym.jpg" class="img-fluid" alt="체육관 사진">
        </div>

        <!-- 날짜 선택 -->
        <div class="section">
            <label for="date">날짜 선택:</label>
            <input type="date" id="date" class="form-control">
        </div>

        <!-- 시간 선택 버튼들 -->
        <div class="section">
            <label for="time">시간 선택:</label>
            <div class="btn-container">
                <% 
                    for (int i = 0; i < 24; i++) {
                        String time = String.format("%02d:00", i);
                        out.print("<button class='btn btn-outline-primary btn-custom' onclick=\"toggleSelection(this)\">" + time + "</button>");
                    }
                %>
            </div>
            
        </div>

        <!-- 총 가격 -->
        <div class="section">
            <span class="price" id="totalPrice">₩0</span>
        </div>

        <!-- 예약하기 버튼 -->
        <div class="section">
            <button class="btn btn-primary btn-reserve">예약하기</button>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.0.7/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
