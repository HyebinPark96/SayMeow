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
<title>회원탈퇴</title>
</head> 
<body> 
	<div align="center"><br><br>
	<h4>회원탈퇴</h4>
	<form method="psot" action="deleteMemberProc.jsp">
	비밀번호 <input type="password"name="pwd">
	<input type="hidden" name="id" value="<%=id%>">
	<input type="submit" value="회원탈퇴">
	</form><br>
	*회원탈퇴를 위해서 비밀번호를 입력하세요.
	</div>
</body> 
</html>