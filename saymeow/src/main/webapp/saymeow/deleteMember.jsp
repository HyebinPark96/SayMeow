<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>  
<jsp:useBean id="mMgr" class="saymeow.MemberMgr" />
<jsp:useBean id="mBean" class="saymeow.MemberBean" /> 
<jsp:setProperty name="mBean" property="*" />
<%
	String id = (String)session.getAttribute("idKey");	
%>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="EUC-KR">
<title>ȸ��Ż��</title>
</head> 
<body> 
	<div align="center"><br><br>
	<h4>ȸ��Ż��</h4>
	<form method="psot" action="deleteMemberProc.jsp">
	��й�ȣ <input type="password"name="pwd">
	<input type="hidden" name="id" value="<%=id%>">
	<input type="submit" value="ȸ��Ż��">
	</form><br>
	*ȸ��Ż�� ���ؼ� ��й�ȣ�� �Է��ϼ���.
	</div>
</body> 
</html>