<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
   String ctxPath = request.getContextPath();
%>

<!doctype html>
<html lang="ko">
  <head>
  <meta charset="utf-8">
    <title>CSS</title>
    <style>
      body { padding: 0px; margin: 0px; }
      .jb-box { width: 100%; height: 1000px; overflow: hidden;margin: 0px auto; position: relative; }
      video { width: 100%; }
      .jb-text { position: absolute; top: 50%; width: 100%; }
      .jb-text p { margin-top: -24px; text-align: center; font-size: 48px; color: #ffffff; }
    </style>
  </head>
  <body>
    <div class="jb-box">
      <video muted autoplay loop>
        <source src="<%=ctxPath%>/resources/videos/go.mp4" type="video/mp4">
        <strong>Your browser does not support the video tag.</strong>
      </video>
      <div class="jb-text">
        <p></p>
      </div>
    </div>
  </body>
</html>