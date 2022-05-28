<%@ page contentType="text/html;charset=EUC-KR"%>
<% request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="mMgr" class="saymeow.MemberMgr" />
<jsp:useBean id="mBean" class="saymeow.MemberBean" /> 
<jsp:setProperty name="mBean" property="*" />
<%boolean flag = mMgr.insertMember(mBean);%>
<html>
<head>
<title>회원가입 확인</title>
<link href="styleTW.css" rel="stylesheet" type="text/css">
<html>
<body>
<br/><br/>
<div align="center">
<%
if(flag){%>
	<script>
	alert("회원가입이 완료 되었습니다.");
	location.href="index.jsp";
</script>
	<%}else{%>
	 	<script>
	alert("다시 입력하여 주십시오.");
	history.back();
</script>
	<%}%>
</div>
</body>
</html>
