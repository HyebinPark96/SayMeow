<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
	String mode = request.getParameter("mode");
	String msg = "";
	if (mode.equals("0")) {
		msg = "���̵� �� ��й�ȣ�� �ٽ� Ȯ���Ͻñ� �ٶ��ϴ�.";
	} else if (mode.equals("1")) {
		msg = "��й�ȣ�� �ٽ� Ȯ���Ͻñ� �ٶ��ϴ�.";
	
	}
%>

<html>
<head>
<title>�α��� ����</title>
</head>
<body>

<%@ include file="top.jsp" %>
	<div align="center">
		<b>�α��ο� �����ϼ̽��ϴ�.<br /><br />
		
		</b>
	
		<input type="button" value="�ٽþ���" onClick="history.back()">
	</div>
<%@ include file="bottom.jsp" %> 
</body>
</html>