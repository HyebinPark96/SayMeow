<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>                                      
<%
	
%>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
</head> 
<body> 
	<%@ include file="top.jsp" %>
<form method="post" action="loginProc.jsp">
<table width="75%" align="center" >
<tr >  
	<td height="190">
		<table width="50%" border="1" align="center">
		<tr> 
			<td colspan="2" align="center">로그인</td>
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
		<input type="button" value="회원가입" onclick="location.href='member.jsp';">
			</td>
		</tr>
</table>
</form>
	<%@ include file="bottom.jsp" %> 
</body> 
</html>