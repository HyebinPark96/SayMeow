<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
	String mod = request.getParameter("mode");
	String msg = "";
	if (mod.equals("0")) {
		msg = "아이디 및 비밀번호를 다시 확인하시기 바랍니다.";
	} else if (mod.equals("1")) {
		msg = "비밀번호를 다시 확인하시기 바랍니다.";
	
	}
%>

<html>
<head>
<title>로그인 에러</title>
</head>
<%@ include file="top.jsp" %>
<body>


	<div align="center">
		<b>로그인에 실패하셨습니다.<br /><br />
		
		</b>
	
		<input type="button" value="다시쓰기" onClick="history.back()">
	</div>
<%@ include file="bottom.jsp" %> 
</body>
</html>