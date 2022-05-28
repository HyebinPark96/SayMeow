<!-- 로그인 실패는 굳이 페이지 안만들어도 될 것 같아서 이 페이지는 사용 안하기로! -->
<%@page import="saymeow.UtilMgr"%>
<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
	int mode = UtilMgr.parseInt(request, "mode");
	String msg = "";
	if (mode==2) {
		msg = "아이디 및 비밀번호를 다시 확인하시기 바랍니다.";
	}
%>

<html>
<head>
<title>로그인 에러</title>
<!-- 부트스트랩 CSS -->						
<link						
href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"						
rel="stylesheet"						
integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"						
crossorigin="anonymous">						
<%@include file="top2.jsp"%>
</head>
<body>
	<div align="center">
		<input type="button" value="다시쓰기" onClick="history.back()">
	</div>
<!-- 부트스트랩 JS -->					
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"					
integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"					
crossorigin="anonymous">					
</script>					
<%@ include file="bottom.jsp" %>
</body>
</html>