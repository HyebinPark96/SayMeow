<!-- �α��� ���д� ���� ������ �ȸ��� �� �� ���Ƽ� �� �������� ��� ���ϱ��! -->
<%@page import="saymeow.UtilMgr"%>
<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
	int mode = UtilMgr.parseInt(request, "mode");
	String msg = "";
	if (mode==2) {
		msg = "���̵� �� ��й�ȣ�� �ٽ� Ȯ���Ͻñ� �ٶ��ϴ�.";
	}
%>

<html>
<head>
<title>�α��� ����</title>
<!-- ��Ʈ��Ʈ�� CSS -->						
<link						
href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"						
rel="stylesheet"						
integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"						
crossorigin="anonymous">						
<%@include file="top2.jsp"%>
</head>
<body>
	<div align="center">
		<input type="button" value="�ٽþ���" onClick="history.back()">
	</div>
<!-- ��Ʈ��Ʈ�� JS -->					
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"					
integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"					
crossorigin="anonymous">					
</script>					
<%@ include file="bottom.jsp" %>
</body>
</html>