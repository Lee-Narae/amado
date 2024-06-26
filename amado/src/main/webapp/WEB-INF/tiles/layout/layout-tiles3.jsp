<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%-- === #25. tiles 를 사용하는 레이아웃2 페이지 만들기 === --%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<%
   String ctxPath = request.getContextPath();
%>      
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AmaDo</title>
  <!-- Required meta tags -->
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  
  <%-- Bootstrap CSS --%>
  <link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/bootstrap-4.6.2-dist/css/bootstrap.min.css" >
 
  <%-- Font Awesome 6 Icons --%>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

  <%-- Optional JavaScript --%>
  <script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.7.1.min.js"></script>
  <script type="text/javascript" src="<%= ctxPath%>/resources/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script>
  <script type="text/javascript" src="<%= ctxPath%>/resources/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script> 

  <%-- 스피너 및 datepicker 를 사용하기 위해 jQueryUI CSS 및 JS --%>
  <link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
  <script type="text/javascript" src="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>

  <%-- === ajax로 파일을 업로드 할때 가장 널리 사용하는 방법 : ajaxForm === --%> 
  <script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery.form.min.js"></script> 

<style type="text/css">
@font-face {
    font-family: 'MYArirang_gothic';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2206-02@1.0/MYArirang_gothic.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}

*{font-family: 'MYArirang_gothic';}

#side {
width: 14%;
position: fixed;
height: auto;
}
#main {
margin-left: 14%;
width: 86%;
min-height: auto;
}

#header{
height: 100px;
}

#content{
min-height: auto;
background-color: #F0F6FF;
}
</style>

</head>
<body>
	<div id="container" style="display: flex; height: auto;">
		<div id="side">
			<tiles:insertAttribute name="sidebar" />
		</div>
		<div id="main">
			<div id="header">
				<tiles:insertAttribute name="header" />
			</div>
			<div id="content">
				<tiles:insertAttribute name="content" />
			</div>
		</div>
	</div>
</body>
</html>