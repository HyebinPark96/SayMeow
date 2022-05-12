<!-- mailSend.jsp에서 받아온 id와 email를 DB조회 -->
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mail" class="saymeow.MailSend"/>
<%
	String id = request.getParameter("id");
	String email = request.getParameter("email");
	boolean result = mail.sendEmail(id, email);
	String msg = "전송실패";
	if(result) 
		msg = "전송성공";
%>
<script>
	alert("<%=msg%>");
	location.href="mailSend.jsp";
</script>