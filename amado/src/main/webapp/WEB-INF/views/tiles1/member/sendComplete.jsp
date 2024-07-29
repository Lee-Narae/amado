<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>

<div style="width: 100%; height: 700px; align-content: center" align="center">

	<div style="width: 40%; height: 300px;">
		<div style="display: flex; width: 100%; height: 180px;">
			<div style="width: 40%;">
				<img style="width: 100%;" src="<%=ctxPath%>/resources/images/narae/3d-techny-email-marketing-and-newsletter-with-new-message-1.gif" />
			</div>
			<div style="width: 60%;">
				<img style="width: 70%;" src="<%=ctxPath%>/resources/images/narae/파랑.png" />
			</div>
		</div>
		<div style="padding: 3% 0 3% 40%;" align="left">
			<div style="font-size: 15pt; font-weight: bold; color: #3366ff; margin-bottom: 1.5%;">이메일을 발송하였습니다.</div>
			<div style="font-size: 10.5pt;">발송량에 따라 이메일이 도착하는 시점에 차이가 있을 수 있습니다.<br>
				 바로 도착하지 않더라도 조금만 기다려 주세요.</div>
		</div>
	</div>

	<div><button type="button" class="btn btn-primary" onclick="location.href='<%=ctxPath%>/index.do'">홈으로</button></div>

</div>