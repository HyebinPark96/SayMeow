<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<jsp:useBean id="mBean" class="saymeow.MemberBean" />
<jsp:useBean id="mMgr" class="saymeow.MemberMgr" />                                      
<%
	//<input type="button" value="ȸ����������" onclick="location.href='memberUpdate.jsp';"><<ȸ���������� ��ư
%>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
</head> 
<!-- �ܺ� CSS -->						
<link rel="stylesheet" href="css/style.css">						
<!-- ��Ʈ��Ʈ�� CSS -->						
<link						
href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"						
rel="stylesheet"						
integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"						
crossorigin="anonymous">						
<%@include file="top.jsp"%>	
<body> 

<form method="post" action="loginProc.jsp">
<table width="75%" align="center" >
<tr >  
	<td height="190">
		<table width="50%" border="1" align="center">
		<tr> 
			<td colspan="2" align="center">�α���</td>
		</tr>
		<tr  align="center"> 
			<td width="47%">ID</td>
			<td width="53%"><input name="id" value="aaa"></td>
		</tr>
		<tr> 
			<td align="center">Password</td>
			<td align="center"><input name="pwd" value="1234"></td>
		</tr>
		<tr> 
			<td colspan="2" align="center"><input type="submit" value="login">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
		<input type="button" value="ȸ������" onclick="location.href='member.jsp';">
		<input type="button" value="���̵�/��й�ȣã��" onclick="location.href='findid.jsp'">
			</td>
		</tr>
</table>
</form>
	<!-- ��Ʈ��Ʈ�� JS -->					
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"					
integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"					
crossorigin="anonymous">					
</script>					
<%@ include file="bottom.jsp" %>					
</body> 
</html>