<%@ page contentType="text/html;charset=EUC-KR"%>
<% request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="mMgr" class="saymeow.MemberMgr" />
<jsp:useBean id="mBean" class="saymeow.MemberBean" /> 
<jsp:setProperty name="mBean" property="*" />
<%boolean flag = mMgr.insertMember(mBean);%>
<html>
<head>
<title>ȸ������ Ȯ��</title>
<link href="styleTW.css" rel="stylesheet" type="text/css">
<html>
<body>
<br/><br/>
<div align="center">
<%
if(flag){%>
	<script>
	alert("ȸ�������� �Ϸ� �Ǿ����ϴ�.");
	location.href="index.jsp";
</script>
	<%}else{%>
	 	<script>
	alert("�ٽ� �Է��Ͽ� �ֽʽÿ�.");
	history.back();
</script>
	<%}%>
</div>
</body>
</html>
